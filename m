Return-Path: <shaggy@linux.vnet.ibm.com>
Date: Thu, 10 Dec 2009 13:57:21 -0200
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
Message-Id: <20091210155721.6697.40863.sendpatchset@norville.austin.ibm.com>
In-Reply-To: <20091210155709.6697.4635.sendpatchset@norville.austin.ibm.com>
References: <20091210155709.6697.4635.sendpatchset@norville.austin.ibm.com>
Subject: [RFC:PATCH 02/03] powerpc: Add definitions for Debug Registers on
	BookE Platforms
Cc: Sergio Durigan Junior <sergiodj@br.ibm.com>, Torez Smith <torez@us.ibm.com>,
	David Gibson <dwg@au1.ibm.com>, Thiago Jung Bauermann <bauerman@br.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc: Add definitions for Debug Registers on BookE Platforms

From: Torez Smith <lnxtorez@linux.vnet.ibm.com>

This patch adds additional definitions for BookE Debug Registers
to the reg_booke.h header file.

Signed-off-by: Torez Smith  <lnxtorez@linux.vnet.ibm.com>
Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Thiago Jung Bauermann <bauerman@br.ibm.com>
Cc: Sergio Durigan Junior <sergiodj@br.ibm.com>
Cc: David Gibson <dwg@au1.ibm.com>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
---

 arch/powerpc/include/asm/processor.h |   30 +++++-
 arch/powerpc/include/asm/reg_booke.h |  176 +++++++++++++++++++++++++++++-----
 2 files changed, 178 insertions(+), 28 deletions(-)


diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 9eed29e..1393307 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -161,9 +161,35 @@ struct thread_struct {
 #ifdef CONFIG_PPC32
 	void		*pgdir;		/* root of page-table tree */
 #endif
-#if defined(CONFIG_4xx) || defined (CONFIG_BOOKE)
-	unsigned long	dbcr0;		/* debug control register values */
+#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+	/*
+	 * The following help to manage the use of Debug Control Registers
+	 * om the BookE platforms.
+	 */
+	unsigned long	dbcr0;
 	unsigned long	dbcr1;
+	unsigned long	dbcr2;
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
+	unsigned long	iac3;
+	unsigned long	iac4;
+	unsigned long	dac1;
+	unsigned long	dac2;
+	unsigned long	dvc1;
+	unsigned long	dvc2;
 #endif
 	/* FP and VSX 0-31 register set */
 	double		fpr[32][TS_FPRWIDTH];
diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index 3bf7835..7f8c71f 100644
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
@@ -294,25 +296,68 @@
 #define DBCR0_IC	0x08000000	/* Instruction Completion */
 #define DBCR0_ICMP	DBCR0_IC
 #define DBCR0_BT	0x04000000	/* Branch Taken */
-#define DBCR0_BRT	DBCR0_BT
 #define DBCR0_EDE	0x02000000	/* Exception Debug Event */
 #define DBCR0_IRPT	DBCR0_EDE
 #define DBCR0_TDE	0x01000000	/* TRAP Debug Event */
-#define DBCR0_IA1	0x00800000	/* Instr Addr compare 1 enable */
-#define DBCR0_IAC1	DBCR0_IA1
-#define DBCR0_IA2	0x00400000	/* Instr Addr compare 2 enable */
-#define DBCR0_IAC2	DBCR0_IA2
-#define DBCR0_IA12	0x00200000	/* Instr Addr 1-2 range enable */
-#define DBCR0_IA12X	0x00100000	/* Instr Addr 1-2 range eXclusive */
-#define DBCR0_IA3	0x00080000	/* Instr Addr compare 3 enable */
-#define DBCR0_IAC3	DBCR0_IA3
-#define DBCR0_IA4	0x00040000	/* Instr Addr compare 4 enable */
-#define DBCR0_IAC4	DBCR0_IA4
-#define DBCR0_IA34	0x00020000	/* Instr Addr 3-4 range Enable */
-#define DBCR0_IA34X	0x00010000	/* Instr Addr 3-4 range eXclusive */
-#define DBCR0_IA12T	0x00008000	/* Instr Addr 1-2 range Toggle */
-#define DBCR0_IA34T	0x00004000	/* Instr Addr 3-4 range Toggle */
+#define DBCR0_IAC1	0x00800000	/* Instr Addr compare 1 enable */
+#define DBCR0_IAC2	0x00400000	/* Instr Addr compare 2 enable */
+#define DBCR0_IAC12M	0x00300000	/* Instr Addr 1-2 range enable */
+#define DBCR0_IAC12M_R	0x00100000	/* Instr Addr 1-2 Reserved state */
+#define DBCR0_IAC12M_I	0x00200000	/* Instr Addr 1-2 range Inclusive */
+#define DBCR0_IAC12M_X	0x00300000	/* Instr Addr 1-2 range eXclusive */
+#define DBCR0_IAC3	0x00080000	/* Instr Addr compare 3 enable */
+#define DBCR0_IAC4	0x00040000	/* Instr Addr compare 4 enable */
+#define DBCR0_IAC34	0x00020000	/* Instr Addr 3-4 range Enable */
+#define DBCR0_IAC34X	0x00010000	/* Instr Addr 3-4 range eXclusive */
+#define DBCR0_IAC12T	0x00008000	/* Instr Addr 1-2 range Toggle */
+#define DBCR0_IAC34T	0x00004000	/* Instr Addr 3-4 range Toggle */
 #define DBCR0_FT	0x00000001	/* Freeze Timers on debug event */
+
+#define DBCR0_USER_DEBUG	(DBCR0_IDM | DBCR0_ICMP | DBCR0_IAC1 | \
+				 DBCR0_IAC2 | DBCR0_IAC3 | DBCR0_IAC4)
+#define DBCR0_BASE_REG_VALUE	0
+
+#define dbcr_iac_range(task)	((task)->thread.dbcr0)
+#define DBCR_IAC12M	DBCR0_IAC12M
+#define DBCR_IAC12M_I	DBCR0_IAC12M_I
+#define DBCR_IAC12M_X	DBCR0_IAC12M_X
+#define DBCR_IAC34M	DBCR0_IAC34M
+#define DBCR_IAC34M_I	DBCR0_IAC34M_I
+#define DBCR_IAC34M_X	DBCR0_IAC34M_X
+
+/* Bit definitions related to the DBCR1. */
+#define DBCR1_D1R	0x80000000	/* DAC1 Read Debug Event */
+#define DBCR1_DAC1R	DBCR1_D1R
+#define DBCR1_D2R	0x40000000	/* DAC2 Read Debug Event */
+#define DBCR1_DAC2R	DBCR1_D2R
+#define DBCR1_D1W	0x20000000	/* DAC1 Write Debug Event */
+#define DBCR1_DAC1W	DBCR1_D1W
+#define DBCR1_D2W	0x10000000	/* DAC2 Write Debug Event */
+#define DBCR1_DAC2W	DBCR1_D2W
+
+#define DBCR1_USER_DEBUG	(DBCR1_DAC1R | DBCR1_DAC2R | DBCR1_DAC1W | \
+				 DBCR1_DAC2W)
+#define DBCR1_BASE_REG_VALUE	0
+
+#define dbcr_dac(task)	((task)->thread.dbcr1)
+#define DBCR_DAC1R	DBCR1_DAC1R
+#define DBCR_DAC1W	DBCR1_DAC1W
+#define DBCR_DAC2R	DBCR1_DAC2R
+#define DBCR_DAC2W	DBCR1_DAC2W
+
+#define DBCR2_USER_DEBUG	0
+#define DBCR2_BASE_REG_VALUE	0
+
+/*
+ * Are there any active Debug Events represented in the
+ * Debug Control Registers?
+ */
+#define DBCR0_ACTIVE_EVENTS	(DBCR0_ICMP | DBCR0_IAC1 | DBCR0_IAC2 | \
+				 DBCR0_IAC3 | DBCR0_IAC4)
+#define DBCR1_ACTIVE_EVENTS	(DBCR1_D1R | DBCR1_D2R | DBCR1_D1W | DBCR1_D2W)
+#define DBCR_ACTIVE_EVENTS(dbcr0, dbcr1)  (((dbcr0) & DBCR0_ACTIVE_EVENTS) || \
+					   ((dbcr1) & DBCR1_ACTIVE_EVENTS))
+
 #elif defined(CONFIG_BOOKE)
 #define DBCR0_EDM	0x80000000	/* External Debug Mode */
 #define DBCR0_IDM	0x40000000	/* Internal Debug Mode */
@@ -324,8 +369,7 @@
 #define DBCR0_RST_NONE	0x00000000	/* No Reset */
 #define DBCR0_ICMP	0x08000000	/* Instruction Completion */
 #define DBCR0_IC	DBCR0_ICMP
-#define DBCR0_BRT	0x04000000	/* Branch Taken */
-#define DBCR0_BT	DBCR0_BRT
+#define DBCR0_BT	0x04000000	/* Branch Taken */
 #define DBCR0_IRPT	0x02000000	/* Exception Debug Event */
 #define DBCR0_TDE	0x01000000	/* TRAP Debug Event */
 #define DBCR0_TIE	DBCR0_TDE
@@ -342,19 +386,99 @@
 #define DBCR0_CRET	0x00000020	/* Critical Return Debug Event */
 #define DBCR0_FT	0x00000001	/* Freeze Timers on debug event */
 
+#define DBCR0_USER_DEBUG	(DBCR0_IDM | DBCR0_ICMP | DBCR0_IAC1 | \
+				 DBCR0_IAC2 | DBCR0_IAC3 | DBCR0_IAC4 | \
+				 DBCR0_DAC1R | DBCR0_DAC1W  | DBCR0_DAC2R | \
+				 DBCR0_DAC2W)
+#define DBCR0_BASE_REG_VALUE	0
+
+#define dbcr_dac(task)	((task)->thread.dbcr0)
+#define DBCR_DAC1R	DBCR0_DAC1R
+#define DBCR_DAC1W	DBCR0_DAC1W
+#define DBCR_DAC2R	DBCR0_DAC2R
+#define DBCR_DAC2W	DBCR0_DAC2W
+
 /* Bit definitions related to the DBCR1. */
-#define DBCR1_IAC12M	0x00800000	/* Instr Addr 1-2 range enable */
-#define DBCR1_IAC12MX	0x00C00000	/* Instr Addr 1-2 range eXclusive */
-#define DBCR1_IAC12AT	0x00010000	/* Instr Addr 1-2 range Toggle */
-#define DBCR1_IAC34M	0x00000080	/* Instr Addr 3-4 range enable */
-#define DBCR1_IAC34MX	0x000000C0	/* Instr Addr 3-4 range eXclusive */
-#define DBCR1_IAC34AT	0x00000001	/* Instr Addr 3-4 range Toggle */
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
+#define DBCR1_IAC12M	0x00C00000	/* Instr Addr 1-2 range enable */
+#define DBCR1_IAC12M_R	0x00400000	/* Instr Addr 1-2 reserved state */
+#define DBCR1_IAC12M_I	0x00800000	/* Instr Addr 1-2 range inclusive */
+#define DBCR1_IAC12M_X	0x00C00000	/* Instr Addr 1-2 range eXclusive */
+#define DBCR1_IAC12A_T	0x00010000	/* Instr Addr 1-2 range Toggle */
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
+#define DBCR1_IAC34M	0x000000C0	/* Instr Addr 3-4 range enable */
+#define DBCR1_IAC34M_R	0x00000040	/* Instr Addr 3-4 reserved state */
+#define DBCR1_IAC34M_I	0x00000080	/* Instr Addr 3-4 range inclusive */
+#define DBCR1_IAC34M_X	0x000000C0	/* Instr Addr 3-4 range eXclusive */
+#define DBCR1_IAC34A_T	0x00000001	/* Instr Addr 3-4 range Toggle */
+
+#define DBCR1_USER_DEBUG	(DBCR1_IAC12M | DBCR1_IAC34M)
+#define DBCR1_BASE_REG_VALUE	(DBCR1_IAC1US | DBCR1_IAC1ER_10 | \
+				 DBCR1_IAC2US | DBCR1_IAC2ER_10 | \
+				 DBCR1_IAC3US | DBCR1_IAC3ER_10 | \
+				 DBCR1_IAC4US | DBCR1_IAC4ER_10)
+
+#define dbcr_iac_range(task)	((task)->thread.dbcr1)
+#define DBCR_IAC12M	DBCR1_IAC12M
+#define DBCR_IAC12M_I	DBCR1_IAC12M_I
+#define DBCR_IAC12M_X	DBCR1_IAC12M_X
+#define DBCR_IAC34M	DBCR1_IAC34M
+#define DBCR_IAC34M_I	DBCR1_IAC34M_I
+#define DBCR_IAC34M_X	DBCR1_IAC34M_X
 
 /* Bit definitions related to the DBCR2. */
-#define DBCR2_DAC12M	0x00800000	/* DAC 1-2 range enable */
-#define DBCR2_DAC12MX	0x00C00000	/* DAC 1-2 range eXclusive */
+#define DBCR2_DAC1US	0xC0000000	/* Data Addr Cmp 1 Sup/User   */
+#define DBCR2_DAC1ER	0x30000000	/* Data Addr Cmp 1 Eff/Real */
+#define DBCR2_DAC2US	0x00000000	/* Data Addr Cmp 2 Sup/User   */
+#define DBCR2_DAC2ER	0x00000000	/* Data Addr Cmp 2 Eff/Real */
+#define DBCR2_DAC12MODE	0x00C00000	/* DAC 1-2 Mode Bits */
+#define DBCR2_DAC12MASK	0x00400000	/* DAC 1-2 Mask mode*/
+#define DBCR2_DAC12R	0x00800000	/* DAC 1-2 range enable */
+#define DBCR2_DAC12RX	0x00C00000	/* DAC 1-2 range eXclusive */
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
+#define DBCR2_USER_DEBUG	(DBCR2_DAC12MODE | DBCR2_DVC1M | DBCR2_DVC2M | \
+				 DBCR2_DVC1BE | DBCR2_DVC2BE)
+#define DBCR2_BASE_REG_VALUE	(DBCR2_DAC1US | DBCR2_DAC2US)
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
