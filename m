Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F90AC00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 07:51:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E74B2064D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 07:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E74B2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RMQh4lgFzF3gS
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 17:51:40 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RM0P68YdzDrPm
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 17:32:21 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42RM0H007lz9ttFc;
 Fri,  5 Oct 2018 09:32:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id oTtDuNdU_3r6; Fri,  5 Oct 2018 09:32:14 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42RM0G6dZwz9ttFV;
 Fri,  5 Oct 2018 09:32:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id DE8FE8BB75;
 Fri,  5 Oct 2018 09:32:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 4eMkH3Zfdgb7; Fri,  5 Oct 2018 09:32:18 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C3F978BB6E;
 Fri,  5 Oct 2018 09:32:18 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 943416F198; Fri,  5 Oct 2018 07:32:18 +0000 (UTC)
Message-Id: <358723b36b126a381d827c82d04ee226321416b2.1538687076.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1538687073.git.christophe.leroy@c-s.fr>
References: <cover.1538687073.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 9/9] powerpc: clean stack pointers naming
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Fri,  5 Oct 2018 07:32:18 +0000 (UTC)
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

Some stack pointers used to also be thread_info pointers
and were called tp. Now that they are only stack pointers,
rename them sp.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/irq.c      | 17 +++++++----------
 arch/powerpc/kernel/setup_64.c | 20 ++++++++++----------
 2 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 62cfccf4af89..754f0efc507b 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -659,21 +659,21 @@ void __do_irq(struct pt_regs *regs)
 void do_IRQ(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
-	void *curtp, *irqtp, *sirqtp;
+	void *cursp, *irqsp, *sirqsp;
 
 	/* Switch to the irq stack to handle this */
-	curtp = (void *)(current_stack_pointer() & ~(THREAD_SIZE - 1));
-	irqtp = hardirq_ctx[raw_smp_processor_id()];
-	sirqtp = softirq_ctx[raw_smp_processor_id()];
+	cursp = (void *)(current_stack_pointer() & ~(THREAD_SIZE - 1));
+	irqsp = hardirq_ctx[raw_smp_processor_id()];
+	sirqsp = softirq_ctx[raw_smp_processor_id()];
 
 	/* Already there ? */
-	if (unlikely(curtp == irqtp || curtp == sirqtp)) {
+	if (unlikely(cursp == irqsp || cursp == sirqsp)) {
 		__do_irq(regs);
 		set_irq_regs(old_regs);
 		return;
 	}
 	/* Switch stack and call */
-	call_do_irq(regs, irqtp);
+	call_do_irq(regs, irqsp);
 
 	set_irq_regs(old_regs);
 }
@@ -732,10 +732,7 @@ void irq_ctx_init(void)
 
 void do_softirq_own_stack(void)
 {
-	void *irqtp;
-
-	irqtp = softirq_ctx[smp_processor_id()];
-	call_do_softirq(irqtp);
+	call_do_softirq(softirq_ctx[smp_processor_id()]);
 }
 
 irq_hw_number_t virq_to_hw(unsigned int virq)
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 6792e9c90689..4912ec0320b8 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -717,22 +717,22 @@ void __init emergency_stack_init(void)
 	limit = min(ppc64_bolted_size(), ppc64_rma_size);
 
 	for_each_possible_cpu(i) {
-		void *ti;
+		void *sp;
 
-		ti = alloc_stack(limit, i);
-		memset(ti, 0, THREAD_SIZE);
-		paca_ptrs[i]->emergency_sp = ti + THREAD_SIZE;
+		sp = alloc_stack(limit, i);
+		memset(sp, 0, THREAD_SIZE);
+		paca_ptrs[i]->emergency_sp = sp + THREAD_SIZE;
 
 #ifdef CONFIG_PPC_BOOK3S_64
 		/* emergency stack for NMI exception handling. */
-		ti = alloc_stack(limit, i);
-		memset(ti, 0, THREAD_SIZE);
-		paca_ptrs[i]->nmi_emergency_sp = ti + THREAD_SIZE;
+		sp = alloc_stack(limit, i);
+		memset(sp, 0, THREAD_SIZE);
+		paca_ptrs[i]->nmi_emergency_sp = sp + THREAD_SIZE;
 
 		/* emergency stack for machine check exception handling. */
-		ti = alloc_stack(limit, i);
-		memset(ti, 0, THREAD_SIZE);
-		paca_ptrs[i]->mc_emergency_sp = ti + THREAD_SIZE;
+		sp = alloc_stack(limit, i);
+		memset(sp, 0, THREAD_SIZE);
+		paca_ptrs[i]->mc_emergency_sp = sp + THREAD_SIZE;
 #endif
 	}
 }
-- 
2.13.3

