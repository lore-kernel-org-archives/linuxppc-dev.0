Return-Path: <shaggy@linux.vnet.ibm.com>
Date: Mon, 8 Feb 2010 14:53:26 -0700
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
Message-Id: <20100208215112.17930.7048.sendpatchset@norville.austin.ibm.com>
In-Reply-To: <20100208215049.17930.8586.sendpatchset@norville.austin.ibm.com>
References: <20100208215049.17930.8586.sendpatchset@norville.austin.ibm.com>
Subject: [PATCH 03/04] powerpc/booke: Add definitions for advanced debug
	registers
Cc: Sergio Durigan Junior <sergiodj@br.ibm.com>, David Gibson <dwg@au1.ibm.com>,
	Torez Smith <torez@us.ibm.com>, Thiago Jung Bauermann <bauerman@br.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc/booke: Add definitions for advanced debug registers

From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>

Based on patches originally written by Torez Smith.

This patch adds additional definitions for BookE Debug Registers
to the reg_booke.h header file.

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Acked-by: David Gibson <dwg@au1.ibm.com>
Cc: Torez Smith  <lnxtorez@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: Sergio Durigan Junior <sergiodj@br.ibm.com>
Cc: Thiago Jung Bauermann <bauerman@br.ibm.com>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
---

 arch/powerpc/include/asm/processor.h |   36 ++++++++++++-
 arch/powerpc/include/asm/reg_booke.h |   96 ++++++++++++++++++++++++++++++++++
 2 files changed, 129 insertions(+), 3 deletions(-)


diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 9eed29e..221ba62 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -161,9 +161,41 @@ struct thread_struct {
 #ifdef CONFIG_PPC32
 	void		*pgdir;		/* root of page-table tree */
 #endif
-#if defined(CONFIG_4xx) || defined (CONFIG_BOOKE)
-	unsigned long	dbcr0;		/* debug control register values */
+#ifdef CONFIG_PPC_ADV_DEBUG_REGS
+	/*
+	 * The following help to manage the use of Debug Control Registers
+	 * om the BookE platforms.
+	 */
+	unsigned long	dbcr0;
 	unsigned long	dbcr1;
+#ifdef CONFIG_BOOKE
+	unsigned long	dbcr2;
+#endif
+	/*
+	 * The stored value of the DBSR register will be the value at the
+	 * last debug interrupt. This register can only be read from the
+	 * user (will never be written to) and has value while helping to
+	 * describe the reason for the last debug trap.  Torez
+	 */
+	unsigned long	dbsr;
+	/*
+	 * The following will contain addresses used by debug applications
+	 * to help trace and trap on particular address locations.
+	 * The bits in the Debug Control Registers above help define which
+	 * of the following registers will contain valid data and/or addresses.
+	 */
+	unsigned long	iac1;
+	unsigned long	iac2;
+#if CONFIG_PPC_ADV_DEBUG_IACS > 2
+	unsigned long	iac3;
+	unsigned long	iac4;
+#endif
+	unsigned long	dac1;
+	unsigned long	dac2;
+#if CONFIG_PPC_ADV_DEBUG_DVCS > 0
+	unsigned long	dvc1;
+	unsigned long	dvc2;
+#endif
 #endif
 	/* FP and VSX 0-31 register set */
 	double		fpr[32][TS_FPRWIDTH];
diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index 3bf7835..8808d30 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -248,6 +248,8 @@
 #define DBSR_RET	0x00008000	/* Return Debug Event */
 #define DBSR_CIRPT	0x00000040	/* Critical Interrupt Taken Event */
 #define DBSR_CRET	0x00000020	/* Critical Return Debug Event */
+#define DBSR_IAC12ATS	0x00000002	/* Instr Address Compare 1/2 Toggle */
+#define DBSR_IAC34ATS	0x00000001	/* Instr Address Compare 3/4 Toggle */
 #endif
 #ifdef CONFIG_40x
 #define DBSR_IC		0x80000000	/* Instruction Completion */
@@ -313,6 +315,38 @@
 #define DBCR0_IA12T	0x00008000	/* Instr Addr 1-2 range Toggle */
 #define DBCR0_IA34T	0x00004000	/* Instr Addr 3-4 range Toggle */
 #define DBCR0_FT	0x00000001	/* Freeze Timers on debug event */
+
+#define dbcr_iac_range(task)	((task)->thread.dbcr0)
+#define DBCR_IAC12I	DBCR0_IA12			/* Range Inclusive */
+#define DBCR_IAC12X	(DBCR0_IA12 | DBCR0_IA12X)	/* Range Exclusive */
+#define DBCR_IAC12MODE	(DBCR0_IA12 | DBCR0_IA12X)	/* IAC 1-2 Mode Bits */
+#define DBCR_IAC34I	DBCR0_IA34			/* Range Inclusive */
+#define DBCR_IAC34X	(DBCR0_IA34 | DBCR0_IA34X)	/* Range Exclusive */
+#define DBCR_IAC34MODE	(DBCR0_IA34 | DBCR0_IA34X)	/* IAC 3-4 Mode Bits */
+
+/* Bit definitions related to the DBCR1. */
+#define DBCR1_DAC1R	0x80000000	/* DAC1 Read Debug Event */
+#define DBCR1_DAC2R	0x40000000	/* DAC2 Read Debug Event */
+#define DBCR1_DAC1W	0x20000000	/* DAC1 Write Debug Event */
+#define DBCR1_DAC2W	0x10000000	/* DAC2 Write Debug Event */
+
+#define dbcr_dac(task)	((task)->thread.dbcr1)
+#define DBCR_DAC1R	DBCR1_DAC1R
+#define DBCR_DAC1W	DBCR1_DAC1W
+#define DBCR_DAC2R	DBCR1_DAC2R
+#define DBCR_DAC2W	DBCR1_DAC2W
+
+/*
+ * Are there any active Debug Events represented in the
+ * Debug Control Registers?
+ */
+#define DBCR0_ACTIVE_EVENTS	(DBCR0_ICMP | DBCR0_IAC1 | DBCR0_IAC2 | \
+				 DBCR0_IAC3 | DBCR0_IAC4)
+#define DBCR1_ACTIVE_EVENTS	(DBCR1_DAC1R | DBCR1_DAC2R | \
+				 DBCR1_DAC1W | DBCR1_DAC2W)
+#define DBCR_ACTIVE_EVENTS(dbcr0, dbcr1)  (((dbcr0) & DBCR0_ACTIVE_EVENTS) || \
+					   ((dbcr1) & DBCR1_ACTIVE_EVENTS))
+
 #elif defined(CONFIG_BOOKE)
 #define DBCR0_EDM	0x80000000	/* External Debug Mode */
 #define DBCR0_IDM	0x40000000	/* Internal Debug Mode */
@@ -342,19 +376,79 @@
 #define DBCR0_CRET	0x00000020	/* Critical Return Debug Event */
 #define DBCR0_FT	0x00000001	/* Freeze Timers on debug event */
 
+#define dbcr_dac(task)	((task)->thread.dbcr0)
+#define DBCR_DAC1R	DBCR0_DAC1R
+#define DBCR_DAC1W	DBCR0_DAC1W
+#define DBCR_DAC2R	DBCR0_DAC2R
+#define DBCR_DAC2W	DBCR0_DAC2W
+
 /* Bit definitions related to the DBCR1. */
+#define DBCR1_IAC1US	0xC0000000	/* Instr Addr Cmp 1 Sup/User   */
+#define DBCR1_IAC1ER	0x30000000	/* Instr Addr Cmp 1 Eff/Real */
+#define DBCR1_IAC1ER_01	0x10000000	/* reserved */
+#define DBCR1_IAC1ER_10	0x20000000	/* Instr Addr Cmp 1 Eff/Real MSR[IS]=0 */
+#define DBCR1_IAC1ER_11	0x30000000	/* Instr Addr Cmp 1 Eff/Real MSR[IS]=1 */
+#define DBCR1_IAC2US	0x0C000000	/* Instr Addr Cmp 2 Sup/User   */
+#define DBCR1_IAC2ER	0x03000000	/* Instr Addr Cmp 2 Eff/Real */
+#define DBCR1_IAC2ER_01	0x01000000	/* reserved */
+#define DBCR1_IAC2ER_10	0x02000000	/* Instr Addr Cmp 2 Eff/Real MSR[IS]=0 */
+#define DBCR1_IAC2ER_11	0x03000000	/* Instr Addr Cmp 2 Eff/Real MSR[IS]=1 */
 #define DBCR1_IAC12M	0x00800000	/* Instr Addr 1-2 range enable */
 #define DBCR1_IAC12MX	0x00C00000	/* Instr Addr 1-2 range eXclusive */
 #define DBCR1_IAC12AT	0x00010000	/* Instr Addr 1-2 range Toggle */
+#define DBCR1_IAC3US	0x0000C000	/* Instr Addr Cmp 3 Sup/User   */
+#define DBCR1_IAC3ER	0x00003000	/* Instr Addr Cmp 3 Eff/Real */
+#define DBCR1_IAC3ER_01	0x00001000	/* reserved */
+#define DBCR1_IAC3ER_10	0x00002000	/* Instr Addr Cmp 3 Eff/Real MSR[IS]=0 */
+#define DBCR1_IAC3ER_11	0x00003000	/* Instr Addr Cmp 3 Eff/Real MSR[IS]=1 */
+#define DBCR1_IAC4US	0x00000C00	/* Instr Addr Cmp 4 Sup/User   */
+#define DBCR1_IAC4ER	0x00000300	/* Instr Addr Cmp 4 Eff/Real */
+#define DBCR1_IAC4ER_01	0x00000100	/* Instr Addr Cmp 4 Eff/Real MSR[IS]=0 */
+#define DBCR1_IAC4ER_10	0x00000200	/* Instr Addr Cmp 4 Eff/Real MSR[IS]=0 */
+#define DBCR1_IAC4ER_11	0x00000300	/* Instr Addr Cmp 4 Eff/Real MSR[IS]=1 */
 #define DBCR1_IAC34M	0x00000080	/* Instr Addr 3-4 range enable */
 #define DBCR1_IAC34MX	0x000000C0	/* Instr Addr 3-4 range eXclusive */
 #define DBCR1_IAC34AT	0x00000001	/* Instr Addr 3-4 range Toggle */
 
+#define dbcr_iac_range(task)	((task)->thread.dbcr1)
+#define DBCR_IAC12I	DBCR1_IAC12M	/* Range Inclusive */
+#define DBCR_IAC12X	DBCR1_IAC12MX	/* Range Exclusive */
+#define DBCR_IAC12MODE	DBCR1_IAC12MX	/* IAC 1-2 Mode Bits */
+#define DBCR_IAC34I	DBCR1_IAC34M	/* Range Inclusive */
+#define DBCR_IAC34X	DBCR1_IAC34MX	/* Range Exclusive */
+#define DBCR_IAC34MODE	DBCR1_IAC34MX	/* IAC 3-4 Mode Bits */
+
 /* Bit definitions related to the DBCR2. */
+#define DBCR2_DAC1US	0xC0000000	/* Data Addr Cmp 1 Sup/User   */
+#define DBCR2_DAC1ER	0x30000000	/* Data Addr Cmp 1 Eff/Real */
+#define DBCR2_DAC2US	0x00000000	/* Data Addr Cmp 2 Sup/User   */
+#define DBCR2_DAC2ER	0x00000000	/* Data Addr Cmp 2 Eff/Real */
 #define DBCR2_DAC12M	0x00800000	/* DAC 1-2 range enable */
+#define DBCR2_DAC12MM	0x00400000	/* DAC 1-2 Mask mode*/
 #define DBCR2_DAC12MX	0x00C00000	/* DAC 1-2 range eXclusive */
+#define DBCR2_DAC12MODE	0x00C00000	/* DAC 1-2 Mode Bits */
 #define DBCR2_DAC12A	0x00200000	/* DAC 1-2 Asynchronous */
-#endif
+#define DBCR2_DVC1M	0x000C0000	/* Data Value Comp 1 Mode */
+#define DBCR2_DVC1M_SHIFT	18	/* # of bits to shift DBCR2_DVC1M */
+#define DBCR2_DVC2M	0x00030000	/* Data Value Comp 2 Mode */
+#define DBCR2_DVC2M_SHIFT	16	/* # of bits to shift DBCR2_DVC2M */
+#define DBCR2_DVC1BE	0x00000F00	/* Data Value Comp 1 Byte */
+#define DBCR2_DVC1BE_SHIFT	8	/* # of bits to shift DBCR2_DVC1BE */
+#define DBCR2_DVC2BE	0x0000000F	/* Data Value Comp 2 Byte */
+#define DBCR2_DVC2BE_SHIFT	0	/* # of bits to shift DBCR2_DVC2BE */
+
+/*
+ * Are there any active Debug Events represented in the
+ * Debug Control Registers?
+ */
+#define DBCR0_ACTIVE_EVENTS  (DBCR0_ICMP | DBCR0_IAC1 | DBCR0_IAC2 | \
+			      DBCR0_IAC3 | DBCR0_IAC4 | DBCR0_DAC1R | \
+			      DBCR0_DAC1W  | DBCR0_DAC2R | DBCR0_DAC2W)
+#define DBCR1_ACTIVE_EVENTS	0
+
+#define DBCR_ACTIVE_EVENTS(dbcr0, dbcr1)  (((dbcr0) & DBCR0_ACTIVE_EVENTS) || \
+					   ((dbcr1) & DBCR1_ACTIVE_EVENTS))
+#endif /* #elif defined(CONFIG_BOOKE) */
 
 /* Bit definitions related to the TCR. */
 #define TCR_WP(x)	(((x)&0x3)<<30)	/* WDT Period */

-- 
Dave Kleikamp
IBM Linux Technology Center
