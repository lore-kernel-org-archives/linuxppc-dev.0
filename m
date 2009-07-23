Return-Path: <benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1E22CB7B6A
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jul 2009 15:59:59 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 23 Jul 2009 15:59:47 +1000
Subject: [PATCH 13/20] powerpc: Add SPR definitions for new 64-bit BookE
Message-Id: <20090723055959.0D67DDDD1B@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds various SPRs defined on 64-bit BookE, along with changes
to the definition of the base MSR values to add the values needed
for 64-bit Book3E.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/include/asm/reg.h       |   10 +++-------
 arch/powerpc/include/asm/reg_booke.h |   35 ++++++++++++++++++++++++++++++++---
 2 files changed, 35 insertions(+), 10 deletions(-)

--- linux-work.orig/arch/powerpc/include/asm/reg.h	2009-07-22 16:37:24.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/reg.h	2009-07-22 16:40:20.000000000 +1000
@@ -98,19 +98,15 @@
 #define MSR_RI		__MASK(MSR_RI_LG)	/* Recoverable Exception */
 #define MSR_LE		__MASK(MSR_LE_LG)	/* Little Endian */
 
-#ifdef CONFIG_PPC64
+#if defined(CONFIG_PPC_BOOK3S_64)
+/* Server variant */
 #define MSR_		MSR_ME | MSR_RI | MSR_IR | MSR_DR | MSR_ISF |MSR_HV
 #define MSR_KERNEL      MSR_ | MSR_SF
-
 #define MSR_USER32	MSR_ | MSR_PR | MSR_EE
 #define MSR_USER64	MSR_USER32 | MSR_SF
-
-#else /* 32-bit */
+#elif defined(CONFIG_PPC_BOOK3S_32)
 /* Default MSR for kernel mode. */
-#ifndef MSR_KERNEL	/* reg_booke.h also defines this */
 #define MSR_KERNEL	(MSR_ME|MSR_RI|MSR_IR|MSR_DR)
-#endif
-
 #define MSR_USER	(MSR_KERNEL|MSR_PR|MSR_EE)
 #endif
 
Index: linux-work/arch/powerpc/include/asm/reg_booke.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/reg_booke.h	2009-07-22 16:37:24.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/reg_booke.h	2009-07-22 16:40:20.000000000 +1000
@@ -18,18 +18,26 @@
 #define MSR_IS		MSR_IR	/* Instruction Space */
 #define MSR_DS		MSR_DR	/* Data Space */
 #define MSR_PMM		(1<<2)	/* Performance monitor mark bit */
+#define MSR_CM		(1<<31) /* Computation Mode (0=32-bit, 1=64-bit) */
 
-/* Default MSR for kernel mode. */
-#if defined (CONFIG_40x)
+#if defined(CONFIG_PPC_BOOK3E_64)
+#define MSR_		MSR_ME | MSR_CE
+#define MSR_KERNEL      MSR_ | MSR_CM
+#define MSR_USER32	MSR_ | MSR_PR | MSR_EE
+#define MSR_USER64	MSR_USER32 | MSR_CM
+#elif defined (CONFIG_40x)
 #define MSR_KERNEL	(MSR_ME|MSR_RI|MSR_IR|MSR_DR|MSR_CE)
-#elif defined(CONFIG_BOOKE)
+#define MSR_USER	(MSR_KERNEL|MSR_PR|MSR_EE)
+#else
 #define MSR_KERNEL	(MSR_ME|MSR_RI|MSR_CE)
+#define MSR_USER	(MSR_KERNEL|MSR_PR|MSR_EE)
 #endif
 
 /* Special Purpose Registers (SPRNs)*/
 #define SPRN_DECAR	0x036	/* Decrementer Auto Reload Register */
 #define SPRN_IVPR	0x03F	/* Interrupt Vector Prefix Register */
 #define SPRN_USPRG0	0x100	/* User Special Purpose Register General 0 */
+#define SPRN_SPRG3R	0x103	/* Special Purpose Register General 3 Read */
 #define SPRN_SPRG4R	0x104	/* Special Purpose Register General 4 Read */
 #define SPRN_SPRG5R	0x105	/* Special Purpose Register General 5 Read */
 #define SPRN_SPRG6R	0x106	/* Special Purpose Register General 6 Read */
@@ -38,11 +46,18 @@
 #define SPRN_SPRG5W	0x115	/* Special Purpose Register General 5 Write */
 #define SPRN_SPRG6W	0x116	/* Special Purpose Register General 6 Write */
 #define SPRN_SPRG7W	0x117	/* Special Purpose Register General 7 Write */
+#define SPRN_EPCR	0x133	/* Embedded Processor Control Register */
 #define SPRN_DBCR2	0x136	/* Debug Control Register 2 */
 #define SPRN_IAC3	0x13A	/* Instruction Address Compare 3 */
 #define SPRN_IAC4	0x13B	/* Instruction Address Compare 4 */
 #define SPRN_DVC1	0x13E	/* Data Value Compare Register 1 */
 #define SPRN_DVC2	0x13F	/* Data Value Compare Register 2 */
+#define SPRN_MAS8	0x155	/* MMU Assist Register 8 */
+#define SPRN_TLB0PS	0x158	/* TLB 0 Page Size Register */
+#define SPRN_MAS5_MAS6	0x15c	/* MMU Assist Register 5 || 6 */
+#define SPRN_MAS8_MAS1	0x15d	/* MMU Assist Register 8 || 1 */
+#define SPRN_MAS7_MAS3	0x174	/* MMU Assist Register 7 || 3 */
+#define SPRN_MAS0_MAS1	0x175	/* MMU Assist Register 0 || 1 */
 #define SPRN_IVOR0	0x190	/* Interrupt Vector Offset Register 0 */
 #define SPRN_IVOR1	0x191	/* Interrupt Vector Offset Register 1 */
 #define SPRN_IVOR2	0x192	/* Interrupt Vector Offset Register 2 */
@@ -425,6 +440,19 @@
 #define SGR_NORMAL	0		/* Speculative fetching allowed. */
 #define SGR_GUARDED	1		/* Speculative fetching disallowed. */
 
+/* Bit definitions for EPCR */
+#define SPRN_EPCR_EXTGS		0x80000000
+#define SPRN_EPCR_DTLBGS	0x40000000
+#define SPRN_EPCR_ITLBGS	0x20000000
+#define SPRN_EPCR_DSIGS		0x10000000
+#define SPRN_EPCR_ISIGS		0x08000000
+#define SPRN_EPCR_DUVD		0x04000000
+#define SPRN_EPCR_ICM		0x02000000
+#define SPRN_EPCR_GICM		0x01000000
+#define SPRN_EPCR_DGTMI		0x00800000
+#define SPRN_EPCR_DMIUH		0x00400000
+
+
 /*
  * The IBM-403 is an even more odd special case, as it is much
  * older than the IBM-405 series.  We put these down here incase someone
@@ -480,3 +508,4 @@
 #endif /* 403GCX */
 #endif /* __ASM_POWERPC_REG_BOOKE_H__ */
 #endif /* __KERNEL__ */
+
