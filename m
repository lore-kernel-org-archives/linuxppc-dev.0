Date: Thu, 10 Jul 2003 02:49:17 -0500 (CDT)
Message-Id: <200307100749.h6A7nHkv072923@sullivan.realtime.net>
To: linuxppc-dev@lists.linuxppc.org
From: Milton Miller <miltonm@bga.com>
Subject: [PATCH] fix CONFIG_CMDLINE for MULTIPLATFORM
Cc: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The strlcpy conversions moved a set of cmdline up.   But being unconditional
it breaks the CONFIG_CMDLINE case.  Since the bufer should start out
zero anyways, delete this line.


===== arch/ppc/kernel/setup.c 1.40 vs edited =====
--- 1.40/arch/ppc/kernel/setup.c	Mon Jun 30 12:10:33 2003
+++ edited/arch/ppc/kernel/setup.c	Thu Jul 10 01:17:03 2003
@@ -405,7 +405,6 @@
 	 * are used for initrd_start and initrd_size,
 	 * otherwise they contain 0xdeadbeef.
 	 */
-	cmd_line[0] = 0;
 	if (r3 >= 0x4000 && r3 < 0x800000 && r4 == 0) {
 		strlcpy(cmd_line, (char *)r3 + KERNELBASE,
 			sizeof(cmd_line));

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
