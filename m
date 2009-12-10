Return-Path: <jwboyer@linux.vnet.ibm.com>
Date: Thu, 10 Dec 2009 12:07:41 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Subject: Re: [RFC:PATCH 02/03] powerpc: Add definitions for Debug Registers
	on BookE Platforms
Message-ID: <20091210170741.GU2937@zod.rchland.ibm.com>
References: <20091210155709.6697.4635.sendpatchset@norville.austin.ibm.com>
	<20091210155721.6697.40863.sendpatchset@norville.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091210155721.6697.40863.sendpatchset@norville.austin.ibm.com>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>,
	Sergio Durigan Junior <sergiodj@br.ibm.com>,
	Torez Smith <torez@us.ibm.com>,
	Thiago Jung Bauermann <bauerman@br.ibm.com>, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 10, 2009 at 01:57:21PM -0200, Dave Kleikamp wrote:
>diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
>index 9eed29e..1393307 100644
>--- a/arch/powerpc/include/asm/processor.h
>+++ b/arch/powerpc/include/asm/processor.h
>@@ -161,9 +161,35 @@ struct thread_struct {
> #ifdef CONFIG_PPC32
> 	void		*pgdir;		/* root of page-table tree */
> #endif
>-#if defined(CONFIG_4xx) || defined (CONFIG_BOOKE)
>-	unsigned long	dbcr0;		/* debug control register values */
>+#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
>+	/*
>+	 * The following help to manage the use of Debug Control Registers
>+	 * om the BookE platforms.
>+	 */
>+	unsigned long	dbcr0;
> 	unsigned long	dbcr1;
>+	unsigned long	dbcr2;

This is wrong for 405.  405 only has dbcr0 and dbcr1.  I don't see why you'd
change the #define values to be more explicit and then include things that
don't make sense.

>+	/*
>+	 * The stored value of the DBSR register will be the value at the
>+	 * last debug interrupt. This register can only be read from the
>+	 * user (will never be written to) and has value while helping to
>+	 * describe the reason for the last debug trap.  Torez
>+	 */
>+	unsigned long	dbsr;
>+	/*
>+	 * The following will contain addresses used by debug applications
>+	 * to help trace and trap on particular address locations.
>+	 * The bits in the Debug Control Registers above help define which
>+	 * of the following registers will contain valid data and/or addresses.
>+	 */
>+	unsigned long	iac1;
>+	unsigned long	iac2;
>+	unsigned long	iac3;
>+	unsigned long	iac4;
>+	unsigned long	dac1;
>+	unsigned long	dac2;
>+	unsigned long	dvc1;
>+	unsigned long	dvc2;
> #endif

Without digging much, I'm wondering if we could just use a pointer to a debug
register structure here instead of growing struct thread more.

> 	/* FP and VSX 0-31 register set */
> 	double		fpr[32][TS_FPRWIDTH];
>diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
>index 3bf7835..7f8c71f 100644
>--- a/arch/powerpc/include/asm/reg_booke.h
>+++ b/arch/powerpc/include/asm/reg_booke.h
>@@ -248,6 +248,8 @@
> #define DBSR_RET	0x00008000	/* Return Debug Event */
> #define DBSR_CIRPT	0x00000040	/* Critical Interrupt Taken Event */
> #define DBSR_CRET	0x00000020	/* Critical Return Debug Event */
>+#define DBSR_IAC12ATS	0x00000002	/* Instr Address Compare 1/2 Toggle */
>+#define DBSR_IAC34ATS	0x00000001	/* Instr Address Compare 3/4 Toggle */
> #endif
> #ifdef CONFIG_40x
> #define DBSR_IC		0x80000000	/* Instruction Completion */
>@@ -294,25 +296,68 @@
> #define DBCR0_IC	0x08000000	/* Instruction Completion */
> #define DBCR0_ICMP	DBCR0_IC
> #define DBCR0_BT	0x04000000	/* Branch Taken */
>-#define DBCR0_BRT	DBCR0_BT
> #define DBCR0_EDE	0x02000000	/* Exception Debug Event */
> #define DBCR0_IRPT	DBCR0_EDE
> #define DBCR0_TDE	0x01000000	/* TRAP Debug Event */
>-#define DBCR0_IA1	0x00800000	/* Instr Addr compare 1 enable */
>-#define DBCR0_IAC1	DBCR0_IA1
>-#define DBCR0_IA2	0x00400000	/* Instr Addr compare 2 enable */
>-#define DBCR0_IAC2	DBCR0_IA2
>-#define DBCR0_IA12	0x00200000	/* Instr Addr 1-2 range enable */
>-#define DBCR0_IA12X	0x00100000	/* Instr Addr 1-2 range eXclusive */
>-#define DBCR0_IA3	0x00080000	/* Instr Addr compare 3 enable */
>-#define DBCR0_IAC3	DBCR0_IA3
>-#define DBCR0_IA4	0x00040000	/* Instr Addr compare 4 enable */
>-#define DBCR0_IAC4	DBCR0_IA4
>-#define DBCR0_IA34	0x00020000	/* Instr Addr 3-4 range Enable */
>-#define DBCR0_IA34X	0x00010000	/* Instr Addr 3-4 range eXclusive */
>-#define DBCR0_IA12T	0x00008000	/* Instr Addr 1-2 range Toggle */
>-#define DBCR0_IA34T	0x00004000	/* Instr Addr 3-4 range Toggle */
>+#define DBCR0_IAC1	0x00800000	/* Instr Addr compare 1 enable */
>+#define DBCR0_IAC2	0x00400000	/* Instr Addr compare 2 enable */
>+#define DBCR0_IAC12M	0x00300000	/* Instr Addr 1-2 range enable */
>+#define DBCR0_IAC12M_R	0x00100000	/* Instr Addr 1-2 Reserved state */
>+#define DBCR0_IAC12M_I	0x00200000	/* Instr Addr 1-2 range Inclusive */
>+#define DBCR0_IAC12M_X	0x00300000	/* Instr Addr 1-2 range eXclusive */
>+#define DBCR0_IAC3	0x00080000	/* Instr Addr compare 3 enable */
>+#define DBCR0_IAC4	0x00040000	/* Instr Addr compare 4 enable */
>+#define DBCR0_IAC34	0x00020000	/* Instr Addr 3-4 range Enable */
>+#define DBCR0_IAC34X	0x00010000	/* Instr Addr 3-4 range eXclusive */
>+#define DBCR0_IAC12T	0x00008000	/* Instr Addr 1-2 range Toggle */
>+#define DBCR0_IAC34T	0x00004000	/* Instr Addr 3-4 range Toggle */

A lot of this seems to just be cleanup... would it be possible to factor out
the cleanup parts so that the additions are easier to review?

> #define DBCR0_FT	0x00000001	/* Freeze Timers on debug event */
>+
>+#define DBCR0_USER_DEBUG	(DBCR0_IDM | DBCR0_ICMP | DBCR0_IAC1 | \
>+				 DBCR0_IAC2 | DBCR0_IAC3 | DBCR0_IAC4)
>+#define DBCR0_BASE_REG_VALUE	0
>+
>+#define dbcr_iac_range(task)	((task)->thread.dbcr0)
>+#define DBCR_IAC12M	DBCR0_IAC12M
>+#define DBCR_IAC12M_I	DBCR0_IAC12M_I
>+#define DBCR_IAC12M_X	DBCR0_IAC12M_X
>+#define DBCR_IAC34M	DBCR0_IAC34M
>+#define DBCR_IAC34M_I	DBCR0_IAC34M_I
>+#define DBCR_IAC34M_X	DBCR0_IAC34M_X
>+
>+/* Bit definitions related to the DBCR1. */
>+#define DBCR1_D1R	0x80000000	/* DAC1 Read Debug Event */
>+#define DBCR1_DAC1R	DBCR1_D1R
>+#define DBCR1_D2R	0x40000000	/* DAC2 Read Debug Event */
>+#define DBCR1_DAC2R	DBCR1_D2R
>+#define DBCR1_D1W	0x20000000	/* DAC1 Write Debug Event */
>+#define DBCR1_DAC1W	DBCR1_D1W
>+#define DBCR1_D2W	0x10000000	/* DAC2 Write Debug Event */
>+#define DBCR1_DAC2W	DBCR1_D2W
>+
>+#define DBCR1_USER_DEBUG	(DBCR1_DAC1R | DBCR1_DAC2R | DBCR1_DAC1W | \
>+				 DBCR1_DAC2W)
>+#define DBCR1_BASE_REG_VALUE	0
>+
>+#define dbcr_dac(task)	((task)->thread.dbcr1)
>+#define DBCR_DAC1R	DBCR1_DAC1R
>+#define DBCR_DAC1W	DBCR1_DAC1W
>+#define DBCR_DAC2R	DBCR1_DAC2R
>+#define DBCR_DAC2W	DBCR1_DAC2W
>+
>+#define DBCR2_USER_DEBUG	0
>+#define DBCR2_BASE_REG_VALUE	0

Why are these defined for 405?

>+/*
>+ * Are there any active Debug Events represented in the
>+ * Debug Control Registers?
>+ */
>+#define DBCR0_ACTIVE_EVENTS	(DBCR0_ICMP | DBCR0_IAC1 | DBCR0_IAC2 | \
>+				 DBCR0_IAC3 | DBCR0_IAC4)
>+#define DBCR1_ACTIVE_EVENTS	(DBCR1_D1R | DBCR1_D2R | DBCR1_D1W | DBCR1_D2W)
>+#define DBCR_ACTIVE_EVENTS(dbcr0, dbcr1)  (((dbcr0) & DBCR0_ACTIVE_EVENTS) || \
>+					   ((dbcr1) & DBCR1_ACTIVE_EVENTS))
>+
> #elif defined(CONFIG_BOOKE)
> #define DBCR0_EDM	0x80000000	/* External Debug Mode */
> #define DBCR0_IDM	0x40000000	/* Internal Debug Mode */
>@@ -324,8 +369,7 @@
> #define DBCR0_RST_NONE	0x00000000	/* No Reset */
> #define DBCR0_ICMP	0x08000000	/* Instruction Completion */
> #define DBCR0_IC	DBCR0_ICMP
>-#define DBCR0_BRT	0x04000000	/* Branch Taken */
>-#define DBCR0_BT	DBCR0_BRT
>+#define DBCR0_BT	0x04000000	/* Branch Taken */

This seems like just cleanup of DBCR0_BRT?

> #define DBCR0_IRPT	0x02000000	/* Exception Debug Event */
> #define DBCR0_TDE	0x01000000	/* TRAP Debug Event */
> #define DBCR0_TIE	DBCR0_TDE
>@@ -342,19 +386,99 @@
> #define DBCR0_CRET	0x00000020	/* Critical Return Debug Event */
> #define DBCR0_FT	0x00000001	/* Freeze Timers on debug event */
>
>+#define DBCR0_USER_DEBUG	(DBCR0_IDM | DBCR0_ICMP | DBCR0_IAC1 | \
>+				 DBCR0_IAC2 | DBCR0_IAC3 | DBCR0_IAC4 | \
>+				 DBCR0_DAC1R | DBCR0_DAC1W  | DBCR0_DAC2R | \
>+				 DBCR0_DAC2W)
>+#define DBCR0_BASE_REG_VALUE	0
>+
>+#define dbcr_dac(task)	((task)->thread.dbcr0)
>+#define DBCR_DAC1R	DBCR0_DAC1R
>+#define DBCR_DAC1W	DBCR0_DAC1W
>+#define DBCR_DAC2R	DBCR0_DAC2R
>+#define DBCR_DAC2W	DBCR0_DAC2W
>+
> /* Bit definitions related to the DBCR1. */

I'll try to review these a bit later.  Changing #defines makes for hard patch
review :)

josh
