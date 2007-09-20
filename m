Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 13738DDF11
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 05:09:05 +1000 (EST)
Date: Thu, 20 Sep 2007 14:11:20 -0500
From: Olof Johansson <olof@lixom.net>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: Separate out legacy MCE parsers
Message-ID: <20070920191120.GA17759@lixom.net>
References: <20070905024159.GB27139@lixom.net>
	<18149.45028.597999.740370@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18149.45028.597999.740370@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[POWERPC] Separate out legacy MCE parsers

Move out the old-style exception parsers to a separate function, and
don't call it on platforms that has a platform-specific handler.

It would make sense to move out the generic versions into their platforms
instead, but that can be done gradually down the road.

Signed-off-by: Olof Johansson <olof@lixom.net>

---

On Tue, Sep 11, 2007 at 06:58:12AM +1000, Paul Mackerras wrote:
> Olof Johansson writes:
> 
> > If a platform provide it's own machine check handler, assume that code
> > will handle the reason parsing and reporting the error. The current
> > default fall-though only makes sense on a few 32-bit platforms that
> > lack individual handlers.
> 
> Might be nice to put that code into a function of its own, called
> print_6xx_machine_check or something similar.

See below. Any platform that doesn't set it's own MCE handler will call
the generic one, which is at the moment just a fallback to the previous
versions.


-Olof

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index ccfc99d..c9d3f6d 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -324,14 +324,137 @@ static inline int check_io_access(struct pt_regs *regs)
 #define clear_single_step(regs)	((regs)->msr &= ~MSR_SE)
 #endif
 
+static int generic_machine_check_exception(struct pt_regs *regs)
+{
+	unsigned long reason = get_mc_reason(regs);
+
+#if defined(CONFIG_4xx) && !defined(CONFIG_440A)
+	if (reason & ESR_IMCP) {
+		printk("Instruction");
+		mtspr(SPRN_ESR, reason & ~ESR_IMCP);
+	} else
+		printk("Data");
+	printk(" machine check in kernel mode.\n");
+#elif defined(CONFIG_440A)
+	printk("Machine check in kernel mode.\n");
+	if (reason & ESR_IMCP){
+		printk("Instruction Synchronous Machine Check exception\n");
+		mtspr(SPRN_ESR, reason & ~ESR_IMCP);
+	}
+	else {
+		u32 mcsr = mfspr(SPRN_MCSR);
+		if (mcsr & MCSR_IB)
+			printk("Instruction Read PLB Error\n");
+		if (mcsr & MCSR_DRB)
+			printk("Data Read PLB Error\n");
+		if (mcsr & MCSR_DWB)
+			printk("Data Write PLB Error\n");
+		if (mcsr & MCSR_TLBP)
+			printk("TLB Parity Error\n");
+		if (mcsr & MCSR_ICP){
+			flush_instruction_cache();
+			printk("I-Cache Parity Error\n");
+		}
+		if (mcsr & MCSR_DCSP)
+			printk("D-Cache Search Parity Error\n");
+		if (mcsr & MCSR_DCFP)
+			printk("D-Cache Flush Parity Error\n");
+		if (mcsr & MCSR_IMPE)
+			printk("Machine Check exception is imprecise\n");
+
+		/* Clear MCSR */
+		mtspr(SPRN_MCSR, mcsr);
+	}
+#elif defined (CONFIG_E500)
+	printk("Machine check in kernel mode.\n");
+	printk("Caused by (from MCSR=%lx): ", reason);
+
+	if (reason & MCSR_MCP)
+		printk("Machine Check Signal\n");
+	if (reason & MCSR_ICPERR)
+		printk("Instruction Cache Parity Error\n");
+	if (reason & MCSR_DCP_PERR)
+		printk("Data Cache Push Parity Error\n");
+	if (reason & MCSR_DCPERR)
+		printk("Data Cache Parity Error\n");
+	if (reason & MCSR_BUS_IAERR)
+		printk("Bus - Instruction Address Error\n");
+	if (reason & MCSR_BUS_RAERR)
+		printk("Bus - Read Address Error\n");
+	if (reason & MCSR_BUS_WAERR)
+		printk("Bus - Write Address Error\n");
+	if (reason & MCSR_BUS_IBERR)
+		printk("Bus - Instruction Data Error\n");
+	if (reason & MCSR_BUS_RBERR)
+		printk("Bus - Read Data Bus Error\n");
+	if (reason & MCSR_BUS_WBERR)
+		printk("Bus - Read Data Bus Error\n");
+	if (reason & MCSR_BUS_IPERR)
+		printk("Bus - Instruction Parity Error\n");
+	if (reason & MCSR_BUS_RPERR)
+		printk("Bus - Read Parity Error\n");
+#elif defined (CONFIG_E200)
+	printk("Machine check in kernel mode.\n");
+	printk("Caused by (from MCSR=%lx): ", reason);
+
+	if (reason & MCSR_MCP)
+		printk("Machine Check Signal\n");
+	if (reason & MCSR_CP_PERR)
+		printk("Cache Push Parity Error\n");
+	if (reason & MCSR_CPERR)
+		printk("Cache Parity Error\n");
+	if (reason & MCSR_EXCP_ERR)
+		printk("ISI, ITLB, or Bus Error on first instruction fetch for an exception handler\n");
+	if (reason & MCSR_BUS_IRERR)
+		printk("Bus - Read Bus Error on instruction fetch\n");
+	if (reason & MCSR_BUS_DRERR)
+		printk("Bus - Read Bus Error on data load\n");
+	if (reason & MCSR_BUS_WRERR)
+		printk("Bus - Write Bus Error on buffered store or cache line push\n");
+#else /* !CONFIG_4xx && !CONFIG_E500 && !CONFIG_E200 */
+	printk("Machine check in kernel mode.\n");
+	printk("Caused by (from SRR1=%lx): ", reason);
+	switch (reason & 0x601F0000) {
+	case 0x80000:
+		printk("Machine check signal\n");
+		break;
+	case 0:		/* for 601 */
+	case 0x40000:
+	case 0x140000:	/* 7450 MSS error and TEA */
+		printk("Transfer error ack signal\n");
+		break;
+	case 0x20000:
+		printk("Data parity error signal\n");
+		break;
+	case 0x10000:
+		printk("Address parity error signal\n");
+		break;
+	case 0x20000000:
+		printk("L1 Data Cache error\n");
+		break;
+	case 0x40000000:
+		printk("L1 Instruction Cache error\n");
+		break;
+	case 0x00100000:
+		printk("L2 data cache parity error\n");
+		break;
+	default:
+		printk("Unknown values in msr\n");
+	}
+#endif /* CONFIG_4xx */
+
+	return 0;
+}
+
 void machine_check_exception(struct pt_regs *regs)
 {
 	int recover = 0;
-	unsigned long reason = get_mc_reason(regs);
 
 	/* See if any machine dependent calls */
 	if (ppc_md.machine_check_exception)
 		recover = ppc_md.machine_check_exception(regs);
+	else
+		recover = generic_machine_check_exception(regs);
 
 	if (recover)
 		return;
@@ -356,121 +479,6 @@ void machine_check_exception(struct pt_regs *regs)
 	if (check_io_access(regs))
 		return;
 
-#if defined(CONFIG_4xx) && !defined(CONFIG_440A)
-	if (reason & ESR_IMCP) {
-		printk("Instruction");
-		mtspr(SPRN_ESR, reason & ~ESR_IMCP);
-	} else
-		printk("Data");
-	printk(" machine check in kernel mode.\n");
-#elif defined(CONFIG_440A)
-	printk("Machine check in kernel mode.\n");
-	if (reason & ESR_IMCP){
-		printk("Instruction Synchronous Machine Check exception\n");
-		mtspr(SPRN_ESR, reason & ~ESR_IMCP);
-	}
-	else {
-		u32 mcsr = mfspr(SPRN_MCSR);
-		if (mcsr & MCSR_IB)
-			printk("Instruction Read PLB Error\n");
-		if (mcsr & MCSR_DRB)
-			printk("Data Read PLB Error\n");
-		if (mcsr & MCSR_DWB)
-			printk("Data Write PLB Error\n");
-		if (mcsr & MCSR_TLBP)
-			printk("TLB Parity Error\n");
-		if (mcsr & MCSR_ICP){
-			flush_instruction_cache();
-			printk("I-Cache Parity Error\n");
-		}
-		if (mcsr & MCSR_DCSP)
-			printk("D-Cache Search Parity Error\n");
-		if (mcsr & MCSR_DCFP)
-			printk("D-Cache Flush Parity Error\n");
-		if (mcsr & MCSR_IMPE)
-			printk("Machine Check exception is imprecise\n");
-
-		/* Clear MCSR */
-		mtspr(SPRN_MCSR, mcsr);
-	}
-#elif defined (CONFIG_E500)
-	printk("Machine check in kernel mode.\n");
-	printk("Caused by (from MCSR=%lx): ", reason);
-
-	if (reason & MCSR_MCP)
-		printk("Machine Check Signal\n");
-	if (reason & MCSR_ICPERR)
-		printk("Instruction Cache Parity Error\n");
-	if (reason & MCSR_DCP_PERR)
-		printk("Data Cache Push Parity Error\n");
-	if (reason & MCSR_DCPERR)
-		printk("Data Cache Parity Error\n");
-	if (reason & MCSR_BUS_IAERR)
-		printk("Bus - Instruction Address Error\n");
-	if (reason & MCSR_BUS_RAERR)
-		printk("Bus - Read Address Error\n");
-	if (reason & MCSR_BUS_WAERR)
-		printk("Bus - Write Address Error\n");
-	if (reason & MCSR_BUS_IBERR)
-		printk("Bus - Instruction Data Error\n");
-	if (reason & MCSR_BUS_RBERR)
-		printk("Bus - Read Data Bus Error\n");
-	if (reason & MCSR_BUS_WBERR)
-		printk("Bus - Read Data Bus Error\n");
-	if (reason & MCSR_BUS_IPERR)
-		printk("Bus - Instruction Parity Error\n");
-	if (reason & MCSR_BUS_RPERR)
-		printk("Bus - Read Parity Error\n");
-#elif defined (CONFIG_E200)
-	printk("Machine check in kernel mode.\n");
-	printk("Caused by (from MCSR=%lx): ", reason);
-
-	if (reason & MCSR_MCP)
-		printk("Machine Check Signal\n");
-	if (reason & MCSR_CP_PERR)
-		printk("Cache Push Parity Error\n");
-	if (reason & MCSR_CPERR)
-		printk("Cache Parity Error\n");
-	if (reason & MCSR_EXCP_ERR)
-		printk("ISI, ITLB, or Bus Error on first instruction fetch for an exception handler\n");
-	if (reason & MCSR_BUS_IRERR)
-		printk("Bus - Read Bus Error on instruction fetch\n");
-	if (reason & MCSR_BUS_DRERR)
-		printk("Bus - Read Bus Error on data load\n");
-	if (reason & MCSR_BUS_WRERR)
-		printk("Bus - Write Bus Error on buffered store or cache line push\n");
-#else /* !CONFIG_4xx && !CONFIG_E500 && !CONFIG_E200 */
-	printk("Machine check in kernel mode.\n");
-	printk("Caused by (from SRR1=%lx): ", reason);
-	switch (reason & 0x601F0000) {
-	case 0x80000:
-		printk("Machine check signal\n");
-		break;
-	case 0:		/* for 601 */
-	case 0x40000:
-	case 0x140000:	/* 7450 MSS error and TEA */
-		printk("Transfer error ack signal\n");
-		break;
-	case 0x20000:
-		printk("Data parity error signal\n");
-		break;
-	case 0x10000:
-		printk("Address parity error signal\n");
-		break;
-	case 0x20000000:
-		printk("L1 Data Cache error\n");
-		break;
-	case 0x40000000:
-		printk("L1 Instruction Cache error\n");
-		break;
-	case 0x00100000:
-		printk("L2 data cache parity error\n");
-		break;
-	default:
-		printk("Unknown values in msr\n");
-	}
-#endif /* CONFIG_4xx */
-
 	if (debugger_fault_handler(regs))
 		return;
 	die("Machine check", regs, SIGBUS);
