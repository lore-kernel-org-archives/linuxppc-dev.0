Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 764BBDDED6
	for <linuxppc-dev@ozlabs.org>; Mon,  5 May 2008 17:02:19 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] 4xx: Fix problem with new TLB storage attibute
	fields on 440x6 core
Date: Mon,  5 May 2008 08:53:19 +0200
Message-Id: <1209970399-4464-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The new 440x6 core used on AMCC 460EX/GT introduces new storage attibure
fields to the TLB2 word. Those are:

Bit  11   12   13   14   15
     WL1  IL1I IL1D IL2I IL2D

With these bits the cache (L1 and L2) can be configured in a more flexible
way, instruction- and data-cache independently now. The "old" I and W bits
are still available and setting these old bits will automically set these
new bits too (for backward compatibilty).

The current code does not clear these fields resulting in disabling the cache
by chance. This patch now makes sure that these new bits are cleared when
the TLB2 word is written.

Signed-off-by: Stefan Roese <sr@denx.de>
---
 arch/powerpc/kernel/head_44x.S      |    9 ++++++++-
 include/asm-powerpc/pgtable-ppc32.h |    7 +++++++
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index ad071a1..5485000 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -653,7 +653,14 @@ finish_tlb_load:
 	rlwimi	r10, r11, 0, 26, 26		/* UX = HWEXEC & USER */
 
 	rlwimi	r12, r10, 0, 26, 31		/* Insert static perms */
-	rlwinm	r12, r12, 0, 20, 15		/* Clear U0-U3 */
+
+	/*
+	 * Clear U0-U3 and WL1 IL1I IL1D IL2I IL2D bits which are added
+	 * on newer 440 cores like the 440x6 used on AMCC 460EX/460GT (see
+	 * include/asm-powerpc/pgtable-ppc32.h for details).
+	 */
+	rlwinm	r12, r12, 0, 20, 10
+
 	tlbwe	r12, r13, PPC44x_TLB_ATTRIB	/* Write ATTRIB */
 
 	/* Done...restore registers and get out of here.
diff --git a/include/asm-powerpc/pgtable-ppc32.h b/include/asm-powerpc/pgtable-ppc32.h
index 2c79f55..a30e081 100644
--- a/include/asm-powerpc/pgtable-ppc32.h
+++ b/include/asm-powerpc/pgtable-ppc32.h
@@ -212,6 +212,13 @@ extern int icache_44x_need_flush;
  *   0  1  2  3  4  ... 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
  *   -  -  -  -  -    - U0 U1 U2 U3 W  I  M  G  E   - UX UW UR SX SW SR
  *
+ * Newer 440 cores (440x6 as used on AMCC 460EX/460GT) have additional
+ * TLB2 storage attibute fields. Those are:
+ *
+ *   TLB2:
+ *   0...10    11   12   13   14   15   16...31
+ *   no change WL1  IL1I IL1D IL2I IL2D no change
+ *
  * There are some constrains and options, to decide mapping software bits
  * into TLB entry.
  *
-- 
1.5.5.1
