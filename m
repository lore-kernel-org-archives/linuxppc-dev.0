Message-ID: <3D458D46.D3511AAE@broadcom.com>
Date: Mon, 29 Jul 2002 11:45:26 -0700
From: "James Dougherty" <jfd@broadcom.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org, jfd@broadcom.com
Subject: Problems with mount system call -- cannot mount procfs!
Content-Type: text/plain;
 charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I've recently ported Linux 2.4.2 and Linux 2.4.19-rc3 to our custom
MPC8245 processor board. The system boots up fine, and mounts a
known good root filesystem, however, it fails to mount procfs.

Here is a trace of the "mount" command on 2.4.2 after the system boots:


root@switch-2:/# mount -t proc proc /proc
Oops: Exception in kernel mode, sig: 4
NIP: C004021C XER: 00000000 LR: C0003FFC SP: C3765E80 REGS: c3765dd0 TRAP: 0700
MSR: 00089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c3764000[37] 'mount' Last syscall: 21
last math c3764000 last altivec 00000000
GPR00: 00000054 C3765E80 C3764000 100203D8 100203E8 100203F8 C0ED0000 00000000
GPR08: 100203F9 10020484 C0040214 48422488 48422488 100265D0 00000000 100CC250
GPR16: 7FFFFC6C 7FFFFC68 10020000 00000000 00009032 03765E80 00000000 C0004268
GPR24: C0003FA0 100203B8 7FFFFE8F 00000000 100203D8 7FFFFC68 00000000 7FFFFC78
Call backtrace:
C0003FFC FFFFFFFF 10002654 100031D8 10003EB8 10004CC4 0FEDA188
00000000
Illegal instruction
root@switch-2:/#



root@switch-2:/# strace mount -t proc proc /proc
Oops: Exception in kernel mode, sig: 4
NIP: C004021C XER: 00000000 LR: C00040B0 SP: C36BDE80 REGS: c36bddd0 TRAP: 0700
MSR: 00089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c36bc000[39] 'mount' Last syscall: 21
last math c36bc000 last altivec 00000000
GPR00: 00000054 C36BDE80 C36BC000 100203D8 100203E8 100203F8 C0ED0000 00000000
GPR08: 100203F9 10020484 C0040214 C36BDE70 01000000 10039790 00000000 100B1690
GPR16: 7FFFFC5C 7FFFFC58 10020000 00000000 00009032 036BDE80 00000000 C0004268
GPR24: C0003FA0 100203B8 7FFFFE8A 00000000 100203D8 7FFFFC58 00000000 7FFFFC68
Call backtrace:
C0004064 FFFFFFFF 10002654 100031D8 10003EB8 10004CC4 0FEDA188
00000000
execve("/bin/mount", ["mount", "-t", "proc", "proc", "/proc"], [/* 18 vars */]) = 0
brk(0)                                  = 0x1002014c
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = -1 ENOENT (No such file or directory)
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\2\243"..., 1024) = 1024
fstat64(0x3, 0x7ffff090)                = 0
mmap(0xfeb0000, 1307264, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0xfeb0000
mprotect(0xffc1000, 189056, PROT_NONE)  = 0
mmap(0xffd0000, 106496, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0x110000) = 0xffd0000
mmap(0xffea000, 21120, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xffea000
close(3)                                = 0
getpid()                                = 39
brk(0)                                  = 0x1002014c
brk(0x10020174)                         = 0x10020174
brk(0x10021000)                         = 0x10021000
open("/dev/null", O_RDWR)               = 3
close(3)                                = 0
getuid()                                = 0
geteuid()                               = 0
lstat("/etc/mtab", {st_mode=S_IFLNK|0777, st_size=12, ...}) = 0
stat("/sbin/mount.proc", 0x7ffffa28)    = -1 ENOENT (No such file or directory)
rt_sigprocmask(SIG_BLOCK, ~[TRAP SEGV], NULL, 8) = 0
mount("proc", "/proc", "proc", 0xc0ed0000, 0 <unfinished ...>
+++ killed by SIGILL +++
root@switch-2:/#



c0040214 <sys_mount>:
c0040214:	94 21 ff d0 	stwu	r1,-48(r1)
c0040218:	7c 08 02 a6 	mflr	r0
c004021c:	bf 61 00 1c 	stmw	r27,28(r1)    <-----------
c0040220:	90 01 00 34 	stw	r0,52(r1)
c0040224:	7c 7d 1b 78 	mr	r29,r3
c0040228:	7c 9e 23 78 	mr	r30,r4
c004022c:	7c db 33 78 	mr	r27,r6
c0040230:	7c fc 3b 78 	mr	r28,r7
c0040234:	7c a3 2b 78 	mr	r3,r5
c0040238:	38 81 00 08 	addi	r4,r1,8
c004023c:	4b ff fb 75 	bl	c003fdb0 <copy_mount_options>
c0040240:	7c 7f 1b 79 	mr.	r31,r3


c0003ffc <ret_from_syscall_1>:
c0003ffc:	90 61 00 bc 	stw	r3,188(r1)
c0004000:	39 40 fd fd 	li	r10,-515
c0004004:	7c 03 50 40 	cmplw	r3,r10
c0004008:	41 80 00 20 	blt	c0004028 <ret_from_syscall_1+0x2c>
c000400c:	7c 63 00 d0 	neg	r3,r3
c0004010:	2c 03 02 02 	cmpwi	r3,514
c0004014:	40 82 00 08 	bne	c000401c <ret_from_syscall_1+0x20>
c0004018:	38 60 00 04 	li	r3,4



Anybody have an idea on what is going wrong here or how
I should proceed to debug?

Many thanks in advance.
					-James


--
James F. Dougherty, III
Broadcom Corporation
jfd@broadcom.com
(408) 501-8273

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
