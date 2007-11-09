Return-Path: <bgill@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8CC0ADDDD5
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Nov 2007 09:17:58 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	lA9MHqGA009017
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Nov 2007 15:17:53 -0700 (MST)
From: Becky Bruce <becky.bruce@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Avoid unpaired stwcx. on some processors
Date: Fri,  9 Nov 2007 16:17:49 -0600
Message-Id: <11946466691682-git-send-email-becky.bruce@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The context switch code in the kernel issues a dummy stwcx. to clear the
reservation, as recommended by the architecture. However, some processors
can have issues if this stwcx to address A occurs while the reservation
is already held to a different address B.  To avoid this problem, the dummy
stwcx. needs to be paired with a dummy lwarx to the same address.

This patch adds the dummy lwarx, and creates a cpu feature bit to indicate
which cpus are affected. Tested on mpc8641_hpcn_defconfig in arch/powerpc;
build tested in arch/ppc.

Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
---
Resend with correct signed-off-by line!

 arch/powerpc/kernel/entry_32.S |    6 ++++++
 arch/ppc/kernel/entry.S        |    6 ++++++
 include/asm-powerpc/cputable.h |   22 ++++++++++++----------
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 21d889e..6461dca 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -244,6 +244,9 @@ syscall_exit_cont:
 	andis.	r10,r0,DBCR0_IC@h
 	bnel-	load_dbcr0
 #endif
+BEGIN_FTR_SECTION
+	lwarx	r7,0,r1
+END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
 	stwcx.	r0,0,r1			/* to clear the reservation */
 	lwz	r4,_LINK(r1)
 	lwz	r5,_CCR(r1)
@@ -694,6 +697,9 @@ restore:
 	mtctr	r11
 
 	PPC405_ERR77(0,r1)
+BEGIN_FTR_SECTION
+	lwarx	r11,0,r1
+END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
 	stwcx.	r0,0,r1			/* to clear the reservation */
 
 #if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
diff --git a/arch/ppc/kernel/entry.S b/arch/ppc/kernel/entry.S
index fba7ca1..aa57dee 100644
--- a/arch/ppc/kernel/entry.S
+++ b/arch/ppc/kernel/entry.S
@@ -244,6 +244,9 @@ syscall_exit_cont:
 	andis.	r10,r0,DBCR0_IC@h
 	bnel-	load_dbcr0
 #endif
+BEGIN_FTR_SECTION
+	lwarx	r7,0,r1
+END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
 	stwcx.	r0,0,r1			/* to clear the reservation */
 	lwz	r4,_LINK(r1)
 	lwz	r5,_CCR(r1)
@@ -690,6 +693,9 @@ restore:
 	mtctr	r11
 
 	PPC405_ERR77(0,r1)
+BEGIN_FTR_SECTION
+	lwarx	r11,0,r1
+END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
 	stwcx.	r0,0,r1			/* to clear the reservation */
 
 #if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
diff --git a/include/asm-powerpc/cputable.h b/include/asm-powerpc/cputable.h
index 9d74338..4525c78 100644
--- a/include/asm-powerpc/cputable.h
+++ b/include/asm-powerpc/cputable.h
@@ -138,6 +138,7 @@ extern void do_feature_fixups(unsigned long value, void *fixup_start,
 #define CPU_FTR_FPU_UNAVAILABLE		ASM_CONST(0x0000000000800000)
 #define CPU_FTR_UNIFIED_ID_CACHE	ASM_CONST(0x0000000001000000)
 #define CPU_FTR_SPE			ASM_CONST(0x0000000002000000)
+#define CPU_FTR_NEED_PAIRED_STWCX	ASM_CONST(0x0000000004000000)
 
 /*
  * Add the 64-bit processor unique features in the top half of the word;
@@ -261,25 +262,25 @@ extern void do_feature_fixups(unsigned long value, void *fixup_start,
 #define CPU_FTRS_7450_20	(CPU_FTR_COMMON | \
 	    CPU_FTR_USE_TB | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | \
 	    CPU_FTR_L3CR | CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | \
-	    CPU_FTR_NEED_COHERENT | CPU_FTR_PPC_LE)
+	    CPU_FTR_NEED_COHERENT | CPU_FTR_PPC_LE | CPU_FTR_NEED_PAIRED_STWCX)
 #define CPU_FTRS_7450_21	(CPU_FTR_COMMON | \
 	    CPU_FTR_USE_TB | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | \
 	    CPU_FTR_L3CR | CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | \
 	    CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_L3_DISABLE_NAP | \
-	    CPU_FTR_NEED_COHERENT | CPU_FTR_PPC_LE)
+	    CPU_FTR_NEED_COHERENT | CPU_FTR_PPC_LE | CPU_FTR_NEED_PAIRED_STWCX)
 #define CPU_FTRS_7450_23	(CPU_FTR_COMMON | \
-	    CPU_FTR_USE_TB | \
+	    CPU_FTR_USE_TB | CPU_FTR_NEED_PAIRED_STWCX | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | \
 	    CPU_FTR_L3CR | CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | \
 	    CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_NEED_COHERENT | CPU_FTR_PPC_LE)
 #define CPU_FTRS_7455_1	(CPU_FTR_COMMON | \
-	    CPU_FTR_USE_TB | \
+	    CPU_FTR_USE_TB | CPU_FTR_NEED_PAIRED_STWCX | \
 	    CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_HAS_HIGH_BATS | \
 	    CPU_FTR_NEED_COHERENT | CPU_FTR_PPC_LE)
 #define CPU_FTRS_7455_20	(CPU_FTR_COMMON | \
-	    CPU_FTR_USE_TB | \
+	    CPU_FTR_USE_TB | CPU_FTR_NEED_PAIRED_STWCX | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | \
 	    CPU_FTR_L3CR | CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | \
 	    CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_L3_DISABLE_NAP | \
@@ -289,31 +290,32 @@ extern void do_feature_fixups(unsigned long value, void *fixup_start,
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | \
 	    CPU_FTR_L3CR | CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | \
 	    CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS | \
-	    CPU_FTR_NEED_COHERENT | CPU_FTR_PPC_LE)
+	    CPU_FTR_NEED_COHERENT | CPU_FTR_PPC_LE | CPU_FTR_NEED_PAIRED_STWCX)
 #define CPU_FTRS_7447_10	(CPU_FTR_COMMON | \
 	    CPU_FTR_USE_TB | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | \
 	    CPU_FTR_L3CR | CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | \
 	    CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS | \
-	    CPU_FTR_NEED_COHERENT | CPU_FTR_NO_BTIC | CPU_FTR_PPC_LE)
+	    CPU_FTR_NEED_COHERENT | CPU_FTR_NO_BTIC | CPU_FTR_PPC_LE | \
+	    CPU_FTR_NEED_PAIRED_STWCX)
 #define CPU_FTRS_7447	(CPU_FTR_COMMON | \
 	    CPU_FTR_USE_TB | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | \
 	    CPU_FTR_L3CR | CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | \
 	    CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS | \
-	    CPU_FTR_NEED_COHERENT | CPU_FTR_PPC_LE)
+	    CPU_FTR_NEED_COHERENT | CPU_FTR_PPC_LE | CPU_FTR_NEED_PAIRED_STWCX)
 #define CPU_FTRS_7447A	(CPU_FTR_COMMON | \
 	    CPU_FTR_USE_TB | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | \
 	    CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS | \
-	    CPU_FTR_NEED_COHERENT | CPU_FTR_PPC_LE)
+	    CPU_FTR_NEED_COHERENT | CPU_FTR_PPC_LE | CPU_FTR_NEED_PAIRED_STWCX)
 #define CPU_FTRS_7448	(CPU_FTR_COMMON | \
 	    CPU_FTR_USE_TB | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | \
 	    CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS | \
-	    CPU_FTR_PPC_LE)
+	    CPU_FTR_PPC_LE | CPU_FTR_NEED_PAIRED_STWCX)
 #define CPU_FTRS_82XX	(CPU_FTR_COMMON | \
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB)
 #define CPU_FTRS_G2_LE	(CPU_FTR_COMMON | CPU_FTR_MAYBE_CAN_DOZE | \
-- 
1.5.3
