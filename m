Subject: gdb on IBM Walnut board panics the kernel
Date: Fri, 2 Feb 2001 16:41:27 -0500
Message-ID: <FF6CF34C346E724596A2FB5CAAB2C49707F8F2@voyager.ops.infiniswitch.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
From: "Curry, Diane" <dcurry@infiniswitch.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm running Monta Vista's Hard Hat Linux (11/26/200 2.4.0-test2) on an
IBM 405GP walnut rev D board. On an x86 PC running Red Hat Linux 7.0,
using MV's CDK, I built a small program using ppc_4xx-gcc with the -g
switch.
The executable is in /tmp of the root filesystem
(/opt/hardhat/devkit/ppc/4xx/target)
that is exported for the target linux to nfs mount. The program, when
run by itself, runs fine.  However, when running gdb on the program, the
kernel panics (explicitly setting
breakpoints produces the same result).
Has anyone observed similar behavior or recognize the possible cause?
Any suggestions would be greatly appreciated.

Diane Curry
Infiniswitch Corp.
dcurry@infiniswitch.com

Program output:
sh-2.03# ./foo
This is a silly test...
i=12
i=16
i=20
i=24
i=28
i=32
i=36
Testing gdb on the 405

sh-2.03# /bin/gdb ./foo
GNU gdb 5.0
Copyright 2000 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you
are
welcome to change it and/or distribute copies of it under certain
conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for
details.
This GDB was configured as "powerpc-hardhat-linux"...
(gdb) run
Starting program: /tmp/foo
[tcsetpgrp failed in terminal_inferior: InappropriaDebugException()
DBSR = 0x10100000  regs = 0xc1bfddd0  NIP = 0xc0003854
NIP: C0003854 XER: 00000000 LR: C0003478 REGS: c1bfddd0 TRAP: 2000
MSR: 00009230 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c1bfc000[22] 'foo' Last syscall: 6
last math 00000000 last altivec 00000000
GPR00: 00000001 C1BFDE80 C1BFC000 C1BFDE90 30002BC0 30000828 30000828
00000000
GPR08: 300275C8 00000000 00000003 30026FF8 30026DC8 100A11E4 100A1DD0
00000000
GPR16: 00000000 00000000 00000000 1004CA70 00009230 01BFDE80 00000000
C0003478
GPR24: C0003854 10000034 00000000 30026B54 00000000 30026B88 300262C0
7FFFFA28
Call backtrace:
C0003478 30004704 3000DEE0 30003204 30003144 30010C8C
Kernel panic: Exception in kernel pc c0003854 signal 5


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
