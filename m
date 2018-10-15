Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DE1C28CF8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 07:22:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3FCD2086A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 07:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3FCD2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YVJX5wYJzF3Dc
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 18:22:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YVGT2zHdzF38p
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 18:20:49 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42YVGF4X1zz9ttC9;
 Mon, 15 Oct 2018 09:20:37 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id uUBbCTsWsVga; Mon, 15 Oct 2018 09:20:37 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42YVGF3s5hz9ttC7;
 Mon, 15 Oct 2018 09:20:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 5A85A8B788;
 Mon, 15 Oct 2018 09:20:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id PAdd9vrN0XhQ; Mon, 15 Oct 2018 09:20:46 +0200 (CEST)
Received: from pc13168vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1B2258B786;
 Mon, 15 Oct 2018 09:20:45 +0200 (CEST)
Received: by pc13168vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id AF1DE6F46D; Mon, 15 Oct 2018 07:20:45 +0000 (UTC)
Message-Id: <c96ba8d949aa62604af12cfa030e2357f9a93597.1539587888.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/traps: fix machine check handlers to use pr_cont()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 15 Oct 2018 07:20:45 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When printing the machine check cause, the cause appears on the
following line due to bad use of printk without \n:

[   33.663993] Machine check in kernel mode.
[   33.664011] Caused by (from SRR1=9032):
[   33.664036] Data access error at address c90c8000

This patch fixes it by using pr_cont() for the second part:

[  133.258131] Machine check in kernel mode.
[  133.258146] Caused by (from SRR1=9032): Data access error at address c90c8000

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/traps.c                | 78 +++++++++++++++---------------
 arch/powerpc/platforms/8xx/machine_check.c |  4 +-
 2 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 4f880c2a6e4c..39fde4b40b6e 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -535,10 +535,10 @@ int machine_check_e500mc(struct pt_regs *regs)
 	printk("Caused by (from MCSR=%lx): ", reason);
 
 	if (reason & MCSR_MCP)
-		printk("Machine Check Signal\n");
+		pr_cont("Machine Check Signal\n");
 
 	if (reason & MCSR_ICPERR) {
-		printk("Instruction Cache Parity Error\n");
+		pr_cont("Instruction Cache Parity Error\n");
 
 		/*
 		 * This is recoverable by invalidating the i-cache.
@@ -556,7 +556,7 @@ int machine_check_e500mc(struct pt_regs *regs)
 	}
 
 	if (reason & MCSR_DCPERR_MC) {
-		printk("Data Cache Parity Error\n");
+		pr_cont("Data Cache Parity Error\n");
 
 		/*
 		 * In write shadow mode we auto-recover from the error, but it
@@ -575,38 +575,38 @@ int machine_check_e500mc(struct pt_regs *regs)
 	}
 
 	if (reason & MCSR_L2MMU_MHIT) {
-		printk("Hit on multiple TLB entries\n");
+		pr_cont("Hit on multiple TLB entries\n");
 		recoverable = 0;
 	}
 
 	if (reason & MCSR_NMI)
-		printk("Non-maskable interrupt\n");
+		pr_cont("Non-maskable interrupt\n");
 
 	if (reason & MCSR_IF) {
-		printk("Instruction Fetch Error Report\n");
+		pr_cont("Instruction Fetch Error Report\n");
 		recoverable = 0;
 	}
 
 	if (reason & MCSR_LD) {
-		printk("Load Error Report\n");
+		pr_cont("Load Error Report\n");
 		recoverable = 0;
 	}
 
 	if (reason & MCSR_ST) {
-		printk("Store Error Report\n");
+		pr_cont("Store Error Report\n");
 		recoverable = 0;
 	}
 
 	if (reason & MCSR_LDG) {
-		printk("Guarded Load Error Report\n");
+		pr_cont("Guarded Load Error Report\n");
 		recoverable = 0;
 	}
 
 	if (reason & MCSR_TLBSYNC)
-		printk("Simultaneous tlbsync operations\n");
+		pr_cont("Simultaneous tlbsync operations\n");
 
 	if (reason & MCSR_BSL2_ERR) {
-		printk("Level 2 Cache Error\n");
+		pr_cont("Level 2 Cache Error\n");
 		recoverable = 0;
 	}
 
@@ -616,7 +616,7 @@ int machine_check_e500mc(struct pt_regs *regs)
 		addr = mfspr(SPRN_MCAR);
 		addr |= (u64)mfspr(SPRN_MCARU) << 32;
 
-		printk("Machine Check %s Address: %#llx\n",
+		pr_cont("Machine Check %s Address: %#llx\n",
 		       reason & MCSR_MEA ? "Effective" : "Physical", addr);
 	}
 
@@ -640,29 +640,29 @@ int machine_check_e500(struct pt_regs *regs)
 	printk("Caused by (from MCSR=%lx): ", reason);
 
 	if (reason & MCSR_MCP)
-		printk("Machine Check Signal\n");
+		pr_cont("Machine Check Signal\n");
 	if (reason & MCSR_ICPERR)
-		printk("Instruction Cache Parity Error\n");
+		pr_cont("Instruction Cache Parity Error\n");
 	if (reason & MCSR_DCP_PERR)
-		printk("Data Cache Push Parity Error\n");
+		pr_cont("Data Cache Push Parity Error\n");
 	if (reason & MCSR_DCPERR)
-		printk("Data Cache Parity Error\n");
+		pr_cont("Data Cache Parity Error\n");
 	if (reason & MCSR_BUS_IAERR)
-		printk("Bus - Instruction Address Error\n");
+		pr_cont("Bus - Instruction Address Error\n");
 	if (reason & MCSR_BUS_RAERR)
-		printk("Bus - Read Address Error\n");
+		pr_cont("Bus - Read Address Error\n");
 	if (reason & MCSR_BUS_WAERR)
-		printk("Bus - Write Address Error\n");
+		pr_cont("Bus - Write Address Error\n");
 	if (reason & MCSR_BUS_IBERR)
-		printk("Bus - Instruction Data Error\n");
+		pr_cont("Bus - Instruction Data Error\n");
 	if (reason & MCSR_BUS_RBERR)
-		printk("Bus - Read Data Bus Error\n");
+		pr_cont("Bus - Read Data Bus Error\n");
 	if (reason & MCSR_BUS_WBERR)
-		printk("Bus - Write Data Bus Error\n");
+		pr_cont("Bus - Write Data Bus Error\n");
 	if (reason & MCSR_BUS_IPERR)
-		printk("Bus - Instruction Parity Error\n");
+		pr_cont("Bus - Instruction Parity Error\n");
 	if (reason & MCSR_BUS_RPERR)
-		printk("Bus - Read Parity Error\n");
+		pr_cont("Bus - Read Parity Error\n");
 
 	return 0;
 }
@@ -680,19 +680,19 @@ int machine_check_e200(struct pt_regs *regs)
 	printk("Caused by (from MCSR=%lx): ", reason);
 
 	if (reason & MCSR_MCP)
-		printk("Machine Check Signal\n");
+		pr_cont("Machine Check Signal\n");
 	if (reason & MCSR_CP_PERR)
-		printk("Cache Push Parity Error\n");
+		pr_cont("Cache Push Parity Error\n");
 	if (reason & MCSR_CPERR)
-		printk("Cache Parity Error\n");
+		pr_cont("Cache Parity Error\n");
 	if (reason & MCSR_EXCP_ERR)
-		printk("ISI, ITLB, or Bus Error on first instruction fetch for an exception handler\n");
+		pr_cont("ISI, ITLB, or Bus Error on first instruction fetch for an exception handler\n");
 	if (reason & MCSR_BUS_IRERR)
-		printk("Bus - Read Bus Error on instruction fetch\n");
+		pr_cont("Bus - Read Bus Error on instruction fetch\n");
 	if (reason & MCSR_BUS_DRERR)
-		printk("Bus - Read Bus Error on data load\n");
+		pr_cont("Bus - Read Bus Error on data load\n");
 	if (reason & MCSR_BUS_WRERR)
-		printk("Bus - Write Bus Error on buffered store or cache line push\n");
+		pr_cont("Bus - Write Bus Error on buffered store or cache line push\n");
 
 	return 0;
 }
@@ -705,30 +705,30 @@ int machine_check_generic(struct pt_regs *regs)
 	printk("Caused by (from SRR1=%lx): ", reason);
 	switch (reason & 0x601F0000) {
 	case 0x80000:
-		printk("Machine check signal\n");
+		pr_cont("Machine check signal\n");
 		break;
 	case 0:		/* for 601 */
 	case 0x40000:
 	case 0x140000:	/* 7450 MSS error and TEA */
-		printk("Transfer error ack signal\n");
+		pr_cont("Transfer error ack signal\n");
 		break;
 	case 0x20000:
-		printk("Data parity error signal\n");
+		pr_cont("Data parity error signal\n");
 		break;
 	case 0x10000:
-		printk("Address parity error signal\n");
+		pr_cont("Address parity error signal\n");
 		break;
 	case 0x20000000:
-		printk("L1 Data Cache error\n");
+		pr_cont("L1 Data Cache error\n");
 		break;
 	case 0x40000000:
-		printk("L1 Instruction Cache error\n");
+		pr_cont("L1 Instruction Cache error\n");
 		break;
 	case 0x00100000:
-		printk("L2 data cache parity error\n");
+		pr_cont("L2 data cache parity error\n");
 		break;
 	default:
-		printk("Unknown values in msr\n");
+		pr_cont("Unknown values in msr\n");
 	}
 	return 0;
 }
diff --git a/arch/powerpc/platforms/8xx/machine_check.c b/arch/powerpc/platforms/8xx/machine_check.c
index 402016705a39..9944fc303df0 100644
--- a/arch/powerpc/platforms/8xx/machine_check.c
+++ b/arch/powerpc/platforms/8xx/machine_check.c
@@ -18,9 +18,9 @@ int machine_check_8xx(struct pt_regs *regs)
 	pr_err("Machine check in kernel mode.\n");
 	pr_err("Caused by (from SRR1=%lx): ", reason);
 	if (reason & 0x40000000)
-		pr_err("Fetch error at address %lx\n", regs->nip);
+		pr_cont("Fetch error at address %lx\n", regs->nip);
 	else
-		pr_err("Data access error at address %lx\n", regs->dar);
+		pr_cont("Data access error at address %lx\n", regs->dar);
 
 #ifdef CONFIG_PCI
 	/* the qspan pci read routines can cause machine checks -- Cort
-- 
2.13.3

