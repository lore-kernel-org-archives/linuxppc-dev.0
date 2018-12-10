Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6484DC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 07:39:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A72F52084E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 07:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A72F52084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Cw204TcJzDqgD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 18:39:20 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43CvZd6mGszDqyh
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 18:19:05 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43CvZZ4GXKz9v6LS;
 Mon, 10 Dec 2018 08:19:02 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id OjLUA-Lz-D94; Mon, 10 Dec 2018 08:19:02 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43CvZZ3jQ9z9v6Kp;
 Mon, 10 Dec 2018 08:19:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E4FFA8B79A;
 Mon, 10 Dec 2018 08:19:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id b2grhkRJnspd; Mon, 10 Dec 2018 08:19:02 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D01528B74C;
 Mon, 10 Dec 2018 08:19:02 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id AE49D716E9; Mon, 10 Dec 2018 07:19:02 +0000 (UTC)
Message-Id: <f5c2b46851fc9c19c3829a63adc415eedeeda935.1544426182.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1544426182.git.christophe.leroy@c-s.fr>
References: <cover.1544426182.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v11 9/9] powerpc: clean stack pointers naming
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 10 Dec 2018 07:19:02 +0000 (UTC)
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
index 0b227d0891ec..49765ccbc8c0 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -718,22 +718,22 @@ void __init emergency_stack_init(void)
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

