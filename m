Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 93404DE472
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 01:20:40 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m5JFKZjx008607
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2008 10:20:36 -0500
Date: Thu, 19 Jun 2008 10:20:35 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/e500mc: flush L2 on NAP for e500mc
Message-ID: <Pine.LNX.4.64.0806191020110.26128@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If we have an L2CSR register (e500mc) we need to flush the L2 before going
to nap.  We use the HW flush mechanism provided in that register.

The code reuses the CPU_FTR_604_PERF_MON bit as it is no longer used by
any code in the kernel.  Additionally we didn't reuse the exist L2CR
feature bit as this is intended for the 7xxx L2CR register and L2CSR
is part of the new Freescale "Book-E" registers.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/idle_e500.S |    9 +++++++++
 include/asm-powerpc/cputable.h  |    8 ++++----
 include/asm-powerpc/reg_booke.h |   17 +++++++++++++++++
 3 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/idle_e500.S b/arch/powerpc/kernel/idle_e500.S
index 267adec..0630403 100644
--- a/arch/powerpc/kernel/idle_e500.S
+++ b/arch/powerpc/kernel/idle_e500.S
@@ -47,6 +47,15 @@ BEGIN_FTR_SECTION
 	mtlr	r0
 	lis	r3,HID0_NAP@h
 END_FTR_SECTION_IFSET(CPU_FTR_CAN_NAP)
+BEGIN_FTR_SECTION
+	msync
+	li	r7,L2CSR0_L2FL@l
+	mtspr	SPRN_L2CSR0,r7
+2:
+	mfspr	r7,SPRN_L2CSR0
+	andi.	r4,r7,L2CSR0_L2FL@l
+	bne	2b
+END_FTR_SECTION_IFSET(CPU_FTR_L2CSR|CPU_FTR_CAN_NAP)
 1:
 	/* Go to NAP or DOZE now */
 	mfspr	r4,SPRN_HID0
diff --git a/include/asm-powerpc/cputable.h b/include/asm-powerpc/cputable.h
index 18feb63..9106113 100644
--- a/include/asm-powerpc/cputable.h
+++ b/include/asm-powerpc/cputable.h
@@ -132,7 +132,7 @@ extern void do_feature_fixups(unsigned long value, void *fixup_start,
 #define CPU_FTR_TAU			ASM_CONST(0x0000000000000010)
 #define CPU_FTR_CAN_DOZE		ASM_CONST(0x0000000000000020)
 #define CPU_FTR_USE_TB			ASM_CONST(0x0000000000000040)
-#define CPU_FTR_604_PERF_MON		ASM_CONST(0x0000000000000080)
+#define CPU_FTR_L2CSR			ASM_CONST(0x0000000000000080)
 #define CPU_FTR_601			ASM_CONST(0x0000000000000100)
 #define CPU_FTR_HPTE_TABLE		ASM_CONST(0x0000000000000200)
 #define CPU_FTR_CAN_NAP			ASM_CONST(0x0000000000000400)
@@ -245,8 +245,7 @@ extern void do_feature_fixups(unsigned long value, void *fixup_start,
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_PPC_LE)
 #define CPU_FTRS_604	(CPU_FTR_COMMON | \
-	    CPU_FTR_USE_TB | CPU_FTR_604_PERF_MON | CPU_FTR_HPTE_TABLE | \
-	    CPU_FTR_PPC_LE)
+	    CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE | CPU_FTR_PPC_LE)
 #define CPU_FTRS_740_NOTAU	(CPU_FTR_COMMON | \
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_PPC_LE)
@@ -353,7 +352,8 @@ extern void do_feature_fixups(unsigned long value, void *fixup_start,
 	    CPU_FTR_SPE_COMP | CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_BIG_PHYS | \
 	    CPU_FTR_NODSISRALIGN)
 #define CPU_FTRS_E500MC	(CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | \
-	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_BIG_PHYS | CPU_FTR_NODSISRALIGN)
+	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_BIG_PHYS | CPU_FTR_NODSISRALIGN | \
+	    CPU_FTR_L2CSR)
 #define CPU_FTRS_GENERIC_32	(CPU_FTR_COMMON | CPU_FTR_NODSISRALIGN)

 /* 64-bit CPUs */
diff --git a/include/asm-powerpc/reg_booke.h b/include/asm-powerpc/reg_booke.h
index bf638e7..f74a23e 100644
--- a/include/asm-powerpc/reg_booke.h
+++ b/include/asm-powerpc/reg_booke.h
@@ -80,6 +80,7 @@
 #define SPRN_DSRR1	0x23F	/* Debug Save and Restore Register 1 */
 #define SPRN_SPRG8	0x25C	/* Special Purpose Register General 8 */
 #define SPRN_SPRG9	0x25D	/* Special Purpose Register General 9 */
+#define SPRN_L1CSR2	0x25E	/* L1 Cache Control and Status Register 2 */
 #define SPRN_MAS0	0x270	/* MMU Assist Register 0 */
 #define SPRN_MAS1	0x271	/* MMU Assist Register 1 */
 #define SPRN_MAS2	0x272	/* MMU Assist Register 2 */
@@ -110,6 +111,8 @@
 #define SPRN_L1CSR1	0x3F3	/* L1 Cache Control and Status Register 1 */
 #define SPRN_PIT	0x3DB	/* Programmable Interval Timer */
 #define SPRN_BUCSR	0x3F5	/* Branch Unit Control and Status */
+#define SPRN_L2CSR0	0x3F9	/* L2 Data Cache Control and Status Register 0 */
+#define SPRN_L2CSR1	0x3FA	/* L2 Data Cache Control and Status Register 1 */
 #define SPRN_DCCR	0x3FA	/* Data Cache Cacheability Register */
 #define SPRN_ICCR	0x3FB	/* Instruction Cache Cacheability Register */
 #define SPRN_SVR	0x3FF	/* System Version Register */
@@ -393,6 +396,20 @@
 #define L1CSR1_ICFI	0x00000002	/* Instr Cache Flash Invalidate */
 #define L1CSR1_ICE	0x00000001	/* Instr Cache Enable */

+/* Bit definitions for L2CSR0. */
+#define L2CSR0_L2E	0x80000000	/* L2 Cache Enable */
+#define L2CSR0_L2PE	0x40000000	/* L2 Cache Parity/ECC Enable */
+#define L2CSR0_L2WP	0x1c000000	/* L2 I/D Way Partioning */
+#define L2CSR0_L2CM	0x03000000	/* L2 Cache Coherency Mode */
+#define L2CSR0_L2FI	0x00200000	/* L2 Cache Flash Invalidate */
+#define L2CSR0_L2IO	0x00100000	/* L2 Cache Instruction Only */
+#define L2CSR0_L2DO	0x00010000	/* L2 Cache Data Only */
+#define L2CSR0_L2REP	0x00003000	/* L2 Line Replacement Algo */
+#define L2CSR0_L2FL	0x00000800	/* L2 Cache Flush */
+#define L2CSR0_L2LFC	0x00000400	/* L2 Cache Lock Flash Clear */
+#define L2CSR0_L2LOA	0x00000080	/* L2 Cache Lock Overflow Allocate */
+#define L2CSR0_L2LO	0x00000020	/* L2 Cache Lock Overflow */
+
 /* Bit definitions for SGR. */
 #define SGR_NORMAL	0		/* Speculative fetching allowed. */
 #define SGR_GUARDED	1		/* Speculative fetching disallowed. */
-- 
1.5.5.1
