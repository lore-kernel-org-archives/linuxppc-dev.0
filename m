To: linuxppc-dev@lists.linuxppc.org
Subject: 2.4.0-paulus and subprocesses in emacs
From: Jiri Masik <masik@pc203b.fzu.cz>
Date: 11 Jan 2001 17:07:42 +0100
Message-ID: <4vy9wiqdgx.fsf@darbujan.fzu.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I've noticed a problem with the recent 2.4 test kernels for example
with 2.4.0 rsynced from penguinppc.org::linux-2.4-paulus on Tuesday.
Processes spawned from emacs fail with the following strace
...
--- SIGIO (I/O possible) ---
ioctl(5, FIONREAD, 0x7ffd5148)          = 0
gettimeofday({979224239, 539012}, {4294967236, 1}) = 0
gettimeofday({979224239, 539068}, {4294967236, 1}) = 0
gettimeofday({979224239, 539191}, {4294967236, 1}) = 0
write(5, "L\25\0\n\4\0\0\32\4\0\0W\0\23\2VDired (directory"..., 60) = 60
gettimeofday({979224239, 540562}, {4294967236, 1}) = 0
rt_sigprocmask(SIG_BLOCK, [IO], [], 8)  = 0
ioctl(5, FIONREAD, 0x7ffd4878)          = 0
rt_sigprocmask(SIG_SETMASK, [], [IO], 8) = 0
gettimeofday({979224239, 540886}, {4294967236, 1}) = 0
gettimeofday({979224239, 540937}, {4294967236, 1}) = 0
_newselect(0x6, 0x417618, 0, 0, 0x7fffdc38) = 1
--- SIGIO (I/O possible) ---
ioctl(5, FIONREAD, 0x7ffd46c8)          = 0
read(5, "\2$\2\216\376P\17E\0\0\0%\4\0\0\32\0\0\0\0\2\237\0\214"..., 32) = 32
ioctl(5, FIONREAD, 0x7ffd46c8)          = 0
ioctl(5, FIONREAD, 0x7ffd46c8)          = 0
write(5, "L\1\0\5\4\0\0\32\4\0\0W\0\320\2V ireL\1\0\5\4\0\0\32\4"..., 40) = 40
brk(0x622000)                           = 0x622000
write(5, "L!\0\r\4\0\0\32\4\0\0W\0\23\2VReading director"..., 72) = 72
stat("/data/masik", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
access("/data/masik", X_OK)             = 0
open("/dev/null", O_RDONLY)             = 4
stat("/local/usr/bin/ls", 0x7fff92f8)   = -1 ENOENT (No such file or directory)
stat("/usr/local/bin/ls", 0x7fff92f8)   = -1 ENOENT (No such file or directory)
stat("/usr/bin/ls", 0x7fff92f8)         = -1 ENOENT (No such file or directory)
stat("/bin/ls", {st_mode=S_IFREG|0755, st_size=52916, ...}) = 0
access("/bin/ls", X_OK)                 = 0
pipe([6, 7])                            = 0
fork()                                  = 412
close(7)                                = 0
close(4)                                = 0
read(6, 0x7fff94e0, 16384)              = ? ERESTARTSYS (To be restarted)
--- SIGCHLD (Child exited) ---
wait4(-1, [WIFSIGNALED(s) && WTERMSIG(s) == SIGTRAP],
WNOHANG|WUNTRACED, NULL) = 412

The complete log can be found at
http://darbujan.fzu.cz/~masik/emacs.strace

and it is the result of M-x dired ~/. Similarly I can't open projects
managed by version control system as emacs fails to run prcs on them
internally. Running M-x shell either kills emacs with Fatal error
(11).Segmentation fault or Process shell illegal instruction
There are no problems when I switch back to the 2.2.18p4-b1-s19-tm.
I have unstable debian distribution with libc6 2.2-10

Has anybody experienced similar problems or has an idea what's wrong?
cheers
        Jiri

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
