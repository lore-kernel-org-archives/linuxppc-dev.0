Message-Id: <m13COYr-001SyaC@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: Problems with strace (3.99.1 or 4.2) under Linux 2.4.0-test4
To: linuxppc-embedded@lists.linuxppc.org, strace@lists.wiggy.net
Date: Wed, 12 Jul 2000 11:36:33 -0400 (EDT)
Cc: all@cideas.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


	I am trying to trace system calls under Linux 2.4.0-test4,
	but it isn't working.  I was able to do this with a
	previous environment:

	- TQM 860T module
	- Linux 2.2.13
	- strace 3.99.1

	Does anybody have any hints on how to fix this?


	Current Environment
	-------------------

	Hardware:

	- EST SBC8260
	- MPC8260 Rev A.1 CPU/CPM/BUS: 166/133/33 Mhz

	Environment:

	- Linux: 2.4.0-test4
	- MontaVista CDK: 8xx toolchain
	- Using the /opt/hardhat/devkit/ppc/8xx/target for the
	  NFS mounted root filesystem

	Failing Example (MPC8260, Linux 2.4.0-test4):
	---------------------------------------------

bash-2.03# /sbin/strace -V
strace -- version 3.99.1
bash-2.03# strace cat /dev/null
execve("/bin/cat", ["cat", "/dev/null"], [/* 15 vars */]) = 0

bash-2.03# strace -V
strace -- version 4.2
bash-2.03# strace cat /dev/null
execve("/bin/cat", ["cat", "/dev/null"], [/* 15 vars */]) = 0

	Working Example (x86, Linux 2.2.14):
	------------------------------------

dell 235} strace -V
strace -- version 4.2
dell 236} motd

Red Hat Linux release 6.2 (Zoot)
Kernel 2.2.14-5.0 on an i686

dell 237} strace cat /dev/null
execve("/bin/cat", ["cat", "/dev/null"], [/* 36 vars */]) = 0
brk(0)                                  = 0x804b160
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40014000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=26148, ...}) = 0
old_mmap(NULL, 26148, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40015000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
fstat(3, {st_mode=S_IFREG|0755, st_size=4101324, ...}) = 0
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\210\212"..., 4096) = 4096
old_mmap(NULL, 1001564, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4001c000
mprotect(0x40109000, 30812, PROT_NONE)  = 0
old_mmap(0x40109000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xec000) = 0x40109000
old_mmap(0x4010d000, 14428, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4010d000
close(3)                                = 0
mprotect(0x4001c000, 970752, PROT_READ|PROT_WRITE) = 0
mprotect(0x4001c000, 970752, PROT_READ|PROT_EXEC) = 0
munmap(0x40015000, 26148)               = 0
personality(PER_LINUX)                  = 0
getpid()                                = 32478
brk(0)                                  = 0x804b160
brk(0x804b198)                          = 0x804b198
brk(0x804c000)                          = 0x804c000
fstat64(0x1, 0xbffff8f8)                = -1 ENOSYS (Function not implemented)
fstat(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 5), ...}) = 0
open("/dev/null", O_RDONLY|O_LARGEFILE) = 3
fstat(3, {st_mode=S_IFCHR|0666, st_rdev=makedev(1, 3), ...}) = 0
read(3, "", 512)                        = 0
close(3)                                = 0
close(1)                                = 0
_exit(0)                                = ?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
