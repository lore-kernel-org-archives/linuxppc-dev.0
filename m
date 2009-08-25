Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 066EEB7C07
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 26 Aug 2009 00:50:55 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5A767DDDA2
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Aug 2009 00:50:54 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n7PEom84013509
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Aug 2009 09:50:49 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/booke: Move MMUCSR definition into mmu-book3e.h
Date: Tue, 25 Aug 2009 09:50:48 -0500
Message-Id: <1251211848-7675-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The MMUCSR is now defined as part of the Book-3E architecture so we
can move it into mmu-book3e.h and add some of the additional bits
defined by the architecture specs.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/include/asm/mmu-book3e.h |   12 ++++++++++++
 arch/powerpc/include/asm/reg_booke.h  |    6 ------
 arch/powerpc/mm/tlb_nohash_low.S      |    2 --
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-book3e.h b/arch/powerpc/include/asm/mmu-book3e.h
index d745804..7469581 100644
--- a/arch/powerpc/include/asm/mmu-book3e.h
+++ b/arch/powerpc/include/asm/mmu-book3e.h
@@ -114,6 +114,18 @@
 
 #define MAS7_RPN		0xFFFFFFFF
 
+/* Bit definitions for MMUCSR0 */
+#define MMUCSR0_TLB1FI	0x00000002	/* TLB1 Flash invalidate */
+#define MMUCSR0_TLB0FI	0x00000004	/* TLB0 Flash invalidate */
+#define MMUCSR0_TLB2FI	0x00000040	/* TLB2 Flash invalidate */
+#define MMUCSR0_TLB3FI	0x00000020	/* TLB3 Flash invalidate */
+#define MMUCSR0_TLBFI	(MMUCSR0_TLB0FI | MMUCSR0_TLB1FI | \
+			 MMUCSR0_TLB2FI | MMUCSR0_TLB3FI)
+#define MMUCSR0_TLB0PS	0x00000780	/* TLB0 Page Size */
+#define MMUCSR0_TLB1PS	0x00007800	/* TLB1 Page Size */
+#define MMUCSR0_TLB2PS	0x00078000	/* TLB2 Page Size */
+#define MMUCSR0_TLB3PS	0x00780000	/* TLB3 Page Size */
+
 /* TLBnCFG encoding */
 #define TLBnCFG_N_ENTRY		0x00000fff	/* number of entries */
 #define TLBnCFG_HES		0x00002000	/* HW select supported */
diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index 2c9c706..9bb81d9 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -430,12 +430,6 @@
 #define L2CSR0_L2LOA	0x00000080	/* L2 Cache Lock Overflow Allocate */
 #define L2CSR0_L2LO	0x00000020	/* L2 Cache Lock Overflow */
 
-/* Bit definitions for MMUCSR0 */
-#define MMUCSR0_TLB1FI	0x00000002	/* TLB1 Flash invalidate */
-#define MMUCSR0_TLB0FI	0x00000004	/* TLB0 Flash invalidate */
-#define MMUCSR0_TLB2FI	0x00000040	/* TLB2 Flash invalidate */
-#define MMUCSR0_TLB3FI	0x00000020	/* TLB3 Flash invalidate */
-
 /* Bit definitions for SGR. */
 #define SGR_NORMAL	0		/* Speculative fetching allowed. */
 #define SGR_GUARDED	1		/* Speculative fetching disallowed. */
diff --git a/arch/powerpc/mm/tlb_nohash_low.S b/arch/powerpc/mm/tlb_nohash_low.S
index 7bcd9fb..bbdc5b5 100644
--- a/arch/powerpc/mm/tlb_nohash_low.S
+++ b/arch/powerpc/mm/tlb_nohash_low.S
@@ -124,8 +124,6 @@ _GLOBAL(_tlbil_pid)
  * to have the larger code path before the _SECTION_ELSE
  */
 
-#define MMUCSR0_TLBFI	(MMUCSR0_TLB0FI | MMUCSR0_TLB1FI | \
-			 MMUCSR0_TLB2FI | MMUCSR0_TLB3FI)
 /*
  * Flush MMU TLB on the local processor
  */
-- 
1.6.0.6
