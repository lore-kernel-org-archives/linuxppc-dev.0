Date: Thu, 10 Jul 2003 02:49:04 -0500 (CDT)
Message-Id: <200307100749.h6A7n4Ya072918@sullivan.realtime.net>
To: linuxppc-dev@lists.linuxppc.org
From: Milton Miller <miltonm@bga.com>
Subject: [PATCH] allow use of biarch binutils to build
Cc: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I built a ppc64 / ppc biarch binutils.  The output arch is chosen
to be powerpc:common64 by default before the diff.  Alan Modra acked
the choice of powerpc:common.


===== arch/ppc/vmlinux.lds.S 1.22 vs edited =====
--- 1.22/arch/ppc/vmlinux.lds.S	Sat Jun 14 01:41:51 2003
+++ edited/arch/ppc/vmlinux.lds.S	Wed Jul  9 23:19:53 2003
@@ -1,6 +1,6 @@
 #include <asm-generic/vmlinux.lds.h>

-OUTPUT_ARCH(powerpc)
+OUTPUT_ARCH(powerpc:common)
 jiffies = jiffies_64 + 4;
 SECTIONS
 {
===== arch/ppc/boot/ld.script 1.6 vs edited =====
--- 1.6/arch/ppc/boot/ld.script	Thu May 29 06:06:53 2003
+++ edited/arch/ppc/boot/ld.script	Wed Jul  9 23:17:20 2003
@@ -1,4 +1,4 @@
-OUTPUT_ARCH(powerpc)
+OUTPUT_ARCH(powerpc:common)
 SECTIONS
 {
   /* Read-only sections, merged into text segment: */

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
