To: linuxppc-dev@lists.linuxppc.org
Cc: glibc-linux@ricardo.ecn.wfu.edu
Subject: PPC reg.h / glibc&kernel conflicts
From: Jesper Skov <jskov@cygnus.co.uk>
Date: 14 Jan 2000 11:43:37 +0100
In-Reply-To: Brendan J Simon's message of "Fri, 07 Jan 2000 12:44:41 +1100"
Message-ID: <otg0w13pd2.fsf_-_@thinktwice.zoftcorp.dk>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



I have added (like Dan Malek, I found out later) PPC support to
gdbserver. 

Given that the code has a configure check for reg.h which seems to
provide PT_ definitions for both m68k and i386, I thought I would be a
good boy and add that for PPC as well.

Unfortunately there are some conflicts between where the kernel
includes and glibc includes expect the PT_ definitions to appear. On
powerpc asm/ptrace.h is included from several other asm-ppc header
files which prevents making PT_ definitions in glibc (because glibc
cannot safely use asm headers without unexpectedly getting PT_
definitions as well).

I don't have time to sort this out properly (at the moment). Would be
nice if someone who had time would sort this out - or at the very
least air some opinions on the subject so I know whether to try and
find time for fixing this in the future.

Below included the glibc-2.1.2 changes required - note that this is
not a patch submittal but an RFC - the patch breaks glibc if used with
current (stable) kernels.

Hm... Come to think of it, this could already be fixed in development
versions of kernel/glibc.... If so, ignore this posting.

Cheers,
Jesper

diff -urN --exclude-from=/home/jskov/lib/diff-excludes -P /tmp/glibc-2.1.2/sysdeps/unix/sysv/linux/powerpc/Dist ./Dist
--- /tmp/glibc-2.1.2/sysdeps/unix/sysv/linux/powerpc/Dist	Mon Dec 14 10:11:23 1998
+++ ./Dist	Fri Jan 14 11:18:17 2000
@@ -3,4 +3,5 @@
 kernel_termios.h
 init-first.h
 sys/procfs.h
+sys/reg.h
 sys/user.h
diff -urN --exclude-from=/home/jskov/lib/diff-excludes -P /tmp/glibc-2.1.2/sysdeps/unix/sysv/linux/powerpc/sys/reg.h ./sys/reg.h
--- /tmp/glibc-2.1.2/sysdeps/unix/sysv/linux/powerpc/sys/reg.h	Thu Jan  1 01:00:00 1970
+++ ./sys/reg.h	Fri Jan 14 11:22:56 2000
@@ -0,0 +1,178 @@
+/* Copyright (C) 1998 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Library General Public License as
+   published by the Free Software Foundation; either version 2 of the
+   License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Library General Public License for more details.
+
+   You should have received a copy of the GNU Library General Public
+   License along with the GNU C Library; see the file COPYING.LIB.  If not,
+   write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
+   Boston, MA 02111-1307, USA.  */
+
+#ifndef _SYS_REG_H
+#define _SYS_REG_H	1
+
+/* Index into an array of 4 byte integers returned from ptrace for
+   location of the users' stored general purpose registers. */
+
+enum
+{
+  PT_R0 = 0,
+#define PT_R0 PT_R0
+  PT_R1 = 1,
+#define PT_R1 PT_R1
+  PT_R2 = 2,
+#define PT_R2 PT_R2
+  PT_R3 = 3,
+#define PT_R3 PT_R3
+  PT_R4 = 4,
+#define PT_R4 PT_R4
+  PT_R5 = 5,
+#define PT_R5 PT_R5
+  PT_R6 = 6,
+#define PT_R6 PT_R6
+  PT_R7 = 7,
+#define PT_R7 PT_R7
+  PT_R8 = 8,
+#define PT_R8 PT_R8
+  PT_R9 = 9,
+#define PT_R9 PT_R9
+  PT_R10 = 10,
+#define PT_R10 PT_R10
+  PT_R11 = 11,
+#define PT_R11 PT_R11
+  PT_R12 = 12,
+#define PT_R12 PT_R12
+  PT_R13 = 13,
+#define PT_R13 PT_R13
+  PT_R14 = 14,
+#define PT_R14 PT_R14
+  PT_R15 = 15,
+#define PT_R15 PT_R15
+  PT_R16 = 16,
+#define PT_R16 PT_R16
+  PT_R17 = 17,
+#define PT_R17 PT_R17
+  PT_R18 = 18,
+#define PT_R18 PT_R18
+  PT_R19 = 19,
+#define PT_R19 PT_R19
+  PT_R20 = 20,
+#define PT_R20 PT_R20
+  PT_R21 = 21,
+#define PT_R21 PT_R21
+  PT_R22 = 22,
+#define PT_R22 PT_R22
+  PT_R23 = 23,
+#define PT_R23 PT_R23
+  PT_R24 = 24,
+#define PT_R24 PT_R24
+  PT_R25 = 25,
+#define PT_R25 PT_R25
+  PT_R26 = 26,
+#define PT_R26 PT_R26
+  PT_R27 = 27,
+#define PT_R27 PT_R27
+  PT_R28 = 28,
+#define PT_R28 PT_R28
+  PT_R29 = 29,
+#define PT_R29 PT_R29
+  PT_R30 = 30,
+#define PT_R30 PT_R30
+  PT_R31 = 31,
+#define PT_R31 PT_R31
+
+  PT_NIP = 32,
+#define PT_NIP PT_NIP
+  PT_MSR = 33,
+#define PT_MSR PT_MSR
+  PT_ORIG_R3 = 34,
+#define PT_ORIG_R3 PT_ORIG_R3
+  PT_CTR = 35,
+#define PT_CTR PT_CTR
+  PT_LNK = 36,
+#define PT_LNK PT_LNK
+  PT_XER = 37,
+#define PT_XER PT_XER
+  PT_CCR = 38,
+#define PT_CCR PT_CCR
+  PT_MQ = 39,
+#define PT_MQ PT_MQ
+
+  PT_FPR0 = 48,
+#define PT_FPR0 PT_FPR0
+  PT_FPR1 = 50,
+#define PT_FPR1 PT_FPR1
+  PT_FPR2 = 52,
+#define PT_FPR2 PT_FPR2
+  PT_FPR3 = 54,
+#define PT_FPR3 PT_FPR3
+  PT_FPR4 = 56,
+#define PT_FPR4 PT_FPR4
+  PT_FPR5 = 58,
+#define PT_FPR5 PT_FPR5
+  PT_FPR6 = 60,
+#define PT_FPR6 PT_FPR6
+  PT_FPR7 = 62,
+#define PT_FPR7 PT_FPR7
+  PT_FPR8 = 64,
+#define PT_FPR8 PT_FPR8
+  PT_FPR9 = 66,
+#define PT_FPR9 PT_FPR9
+  PT_FPR10 = 68,
+#define PT_FPR10 PT_FPR10
+  PT_FPR11 = 70,
+#define PT_FPR11 PT_FPR11
+  PT_FPR12 = 72,
+#define PT_FPR12 PT_FPR12
+  PT_FPR13 = 74,
+#define PT_FPR13 PT_FPR13
+  PT_FPR14 = 76,
+#define PT_FPR14 PT_FPR14
+  PT_FPR15 = 78,
+#define PT_FPR15 PT_FPR15
+  PT_FPR16 = 80,
+#define PT_FPR16 PT_FPR16
+  PT_FPR17 = 82,
+#define PT_FPR17 PT_FPR17
+  PT_FPR18 = 84,
+#define PT_FPR18 PT_FPR18
+  PT_FPR19 = 86,
+#define PT_FPR19 PT_FPR19
+  PT_FPR20 = 88,
+#define PT_FPR20 PT_FPR20
+  PT_FPR21 = 90,
+#define PT_FPR21 PT_FPR21
+  PT_FPR22 = 92,
+#define PT_FPR22 PT_FPR22
+  PT_FPR23 = 94,
+#define PT_FPR23 PT_FPR23
+  PT_FPR24 = 96,
+#define PT_FPR24 PT_FPR24
+  PT_FPR25 = 98,
+#define PT_FPR25 PT_FPR25
+  PT_FPR26 = 100,
+#define PT_FPR26 PT_FPR26
+  PT_FPR27 = 102,
+#define PT_FPR27 PT_FPR27
+  PT_FPR28 = 104,
+#define PT_FPR28 PT_FPR28
+  PT_FPR29 = 106,
+#define PT_FPR29 PT_FPR29
+  PT_FPR30 = 108,
+#define PT_FPR30 PT_FPR30
+  PT_FPR31 = 110,
+#define PT_FPR31 PT_FPR31
+
+  PT_FPSCR = 113
+#define PT_FPSCR PT_FPSCR
+};
+
+#endif	/* _SYS_REG_H */
diff -urN --exclude-from=/home/jskov/lib/diff-excludes -P /tmp/glibc-2.1.2/sysdeps/unix/sysv/linux/powerpc/sys/user.h ./sys/user.h
--- /tmp/glibc-2.1.2/sysdeps/unix/sysv/linux/powerpc/sys/user.h	Fri Jan 14 11:31:20 2000
+++ ./sys/user.h	Fri Jan 14 11:30:56 2000
@@ -21,8 +21,6 @@
 #define _SYS_USER_H	1
 #include <features.h>
 
-#include <asm/ptrace.h>
-
 struct user {
 	struct pt_regs	regs;			/* entire machine state */
 	size_t		u_tsize;		/* text size (pages) */

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
