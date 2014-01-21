clc;

%% Rotating 90° around X

clear all; disp('Rotating 90° around X');
disp('----------------------------------------');

A = affine_rotation_x(degtorad(90));
Rin = A(1:3, 1:3);
q = quaternionFromRotation(Rin);
R = quaternionToRotation(q)

expect = Rin;
maximumError = max(max(expect - R))

X = R*[1; 0; 0]; Y = R*[0; 1; 0]; Z = R*[0; 0; 1];
fprintf('X:    %10.2f  %10.2f  %10.2f\n',   X(1), X(2), X(3));
fprintf('Y:    %10.2f  %10.2f  %10.2f\n',   Y(1), Y(2), Y(3));
fprintf('Z:    %10.2f  %10.2f  %10.2f\n\n', Z(1), Z(2), Z(3));

%% Rotating 45° around X twice

clear all; disp('Rotating 45° around X twice');
disp('----------------------------------------');

A = affine_rotation_x(degtorad(45));
Rin = A(1:3, 1:3);
q = quaternionFromRotation(Rin);
q = quaternionMul(q, q);
R = quaternionToRotation(q)

expect = Rin * Rin;
maximumError = max(max(expect - R))

X = R*[1; 0; 0]; Y = R*[0; 1; 0]; Z = R*[0; 0; 1];
fprintf('X:    %10.2f  %10.2f  %10.2f\n',   X(1), X(2), X(3));
fprintf('Y:    %10.2f  %10.2f  %10.2f\n',   Y(1), Y(2), Y(3));
fprintf('Z:    %10.2f  %10.2f  %10.2f\n\n', Z(1), Z(2), Z(3));


%% Rotating 45° around X, then 45° around Y

clear all; disp('Rotating 90° around X, then 90° around Y');
disp('----------------------------------------');
Ax = affine_rotation_x(degtorad(90));
Ay = affine_rotation_y(degtorad(90));

qx = quaternionFromRotation(Ax);
qy = quaternionFromRotation(Ay);
q = quaternionMul(qy, qx);
R = quaternionToRotation(q)

expect = Ay*Ax;
maximumError = max(max(expect(1:3, 1:3) - R))

X = R*[1; 0; 0]; Y = R*[0; 1; 0]; Z = R*[0; 0; 1];
fprintf('X:    %10.2f  %10.2f  %10.2f\n',   X(1), X(2), X(3));
fprintf('Y:    %10.2f  %10.2f  %10.2f\n',   Y(1), Y(2), Y(3));
fprintf('Z:    %10.2f  %10.2f  %10.2f\n\n', Z(1), Z(2), Z(3));

Xq = quaternionRotateVector(q, [1; 0; 0]);
Yq = quaternionRotateVector(q, [0; 1; 0]);
Zq = quaternionRotateVector(q, [0; 0; 1]);
fprintf('Xq:   %10.2f  %10.2f  %10.2f\n',   Xq(1), Xq(2), Xq(3));
fprintf('Yq:   %10.2f  %10.2f  %10.2f\n',   Yq(1), Yq(2), Yq(3));
fprintf('Zq:   %10.2f  %10.2f  %10.2f\n\n', Zq(1), Zq(2), Zq(3));


%% Angular velocity: Rotating with 90°/sec

clear all; disp('Angular velocity: Rotating with 90°/sec');
disp('----------------------------------------');

T = 0.1;

omega  = degtorad([90 0 0]);
qomega = quaternionFromAngularVelocity(omega, T);

q = [1 0 0 0];

N = 1/T;
for i = 1:N
    q = quaternionMul(qomega, q);
end

Xq = quaternionRotateVector(q, [1; 0; 0]);
Yq = quaternionRotateVector(q, [0; 1; 0]);
Zq = quaternionRotateVector(q, [0; 0; 1]);
fprintf('Xq:   %10.2f  %10.2f  %10.2f\n',   Xq(1), Xq(2), Xq(3));
fprintf('Yq:   %10.2f  %10.2f  %10.2f\n',   Yq(1), Yq(2), Yq(3));
fprintf('Zq:   %10.2f  %10.2f  %10.2f\n\n', Zq(1), Zq(2), Zq(3));
