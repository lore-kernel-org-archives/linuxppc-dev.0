Date: Tue, 16 Sep 2003 13:54:40 -0500 (CDT)
Message-Id: <200309161854.h8GIseaF011976@sullivan.realtime.net>
To: Tom Rini <trini@kernel.crashing.org>,
	Scott Anderson <scott_anderson@mvista.com>
From: Milton Miller <miltonm@bga.com>
Subject: boot udelay asm fix
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Tom, Scott

A feature of the assembler is to not check our instruction selection.
Looks like this one gets the rounding wrong without the fix.  Patch
against marcello 2.4 head, but is needed on all trees.

milton

===== arch/ppc/boot/common/util.S 1.5 vs edited =====
--- 1.5/arch/ppc/boot/common/util.S	Mon Sep 15 10:45:58 2003
+++ edited/arch/ppc/boot/common/util.S	Tue Sep 16 13:29:43 2003
@@ -198,7 +198,7 @@
 	 *  timebase_period_ns defaults to 60 (16.6MHz) */
 	lis	r5,timebase_period_ns@ha
 	lwz	r5,timebase_period_ns@l(r5)
-	addi	r4,r4,r5
+	add	r4,r4,r5
 	addi	r4,r4,-1
 	divw	r4,r4,r5	/* BUS ticks */
 1:	mftbu	r5

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
