Date: Sat, 20 Jan 2001 22:19:08 +0100
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: mprotect broken on ppc
Message-ID: <20010120221908.A20689@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

there seems to be a bug in mprotect which was introduced in
test9->test10.

The result is an invalid pointer from the getpwuid(3) function, this
function is used in rpm to check owner and group permissions.

Just an example:

bad, su(1) is called with "-" to read the profile and make a login
shell:
...
lemon:~/lsof # chroot /abuild/buildsystem.lemon.broken_build/ su -c "rpm
-ba /usr/src/packages/SOURCES/lsof.spec" - < /dev/null
getUname(): pw = 0 , uid = 0
parsePrep
Bad owner/group: /usr/src/packages/SOURCES/lsof_4.52.tar.bz2
...
this works on all other archs.

same as above, rpm is a symlink to rpm.sh which reads the /etc/profile
in the chroot:
....
lemon:~/lsof # chroot /abuild/buildsystem.lemon.broken_build/ su -c
"/bin/rpm.sh -ba /usr/src/packages/SOURCES/lsof.spec" - < /dev/null
getUname(): pw = 0 , uid = 0
parsePrep
Bad owner/group: /usr/src/packages/SOURCES/lsof_4.52.tar.bz2
...


if I call the rpm binary directly it works as expected:
....
lemon:~/lsof # chroot /abuild/buildsystem.lemon.broken_build/ su -c
"/bin/rpm.bin -ba /usr/src/packages/SOURCES/lsof.spec" - < /dev/null
getUname(): pw = 1925cb8 , uid = 0
Executing(%prep): /bin/sh -e /var/tmp/rpm-tmp.83927
+ umask 022
+ cd /usr/src/packages/BUILD
+ cd /usr/src/packages/BUILD
+ rm -rf lsof_4.52
...

pw in rpm/build/names:getUname() returns something.


Here is the strace output from the failed build:
....
3902  open("/etc/ld.so.cache", O_RDONLY) = 5
3902  fstat(5, {st_mode=S_IFREG|0644, st_size=10630, ...}) = 0
3902  mmap(NULL, 10630, PROT_READ, MAP_PRIVATE, 5, 0) = 0x30002000
3902  close(5)                          = 0
3902  open("/lib/libnss_compat.so.2", O_RDONLY) = 5
3902  read(5, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\0\034"..., 1024) = 1024
3902  fstat(5, {st_mode=S_IFREG|0755, st_size=57990, ...}) = 0
3902  brk(0x1938370)                    = 0x1938370
3902  mmap(0x6ffd4450, 113580, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE, 5, 0) = 0x6ffd5000
3902  mprotect(0x6ffdffb0, 68604, PROT_NONE) = -1 EINVAL (Invalid argument)
                                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
3902  mmap(0x6ffe5000, 47264, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 5, 0) = 0x6ffe5000
3902  mmap(0x6fff08a0, 780, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = -1 EINVAL (Inval
3902  close(5)                          = 0
3902  munmap(0x30002000, 10630)         = 0
3902  write(2, "Bad owner/group: /usr/src/packag"..., 60) = 60
3902  write(2, "\n", 1)                 = 1
3902  open("/usr/lib/rpm/rpmrc", O_RDONLY) = 5
.....


The same mprotect works with test9.
It doesnt matter what .config I use or if highmem is on. It happens on
all machines with 2.4.0-test10 and newer kernels.

The diff between these two kernels show many changes in the memory
system, so I guess something went wrong for ppc.

The files, strace output and such can be found at
http://penguinppc.org/~olaf/broken_build/


Any ideas how to fix that? Or what might be wrong here?



Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
