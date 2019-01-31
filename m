Return-Path: <SRS0=ULCe=QH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD78C282C7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 10:11:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F3BD20B1F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 10:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="GKdWvunu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F3BD20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qwxz42ZzzDqSv
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 21:11:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="GKdWvunu"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qwtS3mhVzDqQ3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 21:08:48 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43qwtN1rwCz9tyxC;
 Thu, 31 Jan 2019 11:08:44 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=GKdWvunu; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id F1nUlcsWzmyM; Thu, 31 Jan 2019 11:08:44 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43qwtN0npFz9tyx9;
 Thu, 31 Jan 2019 11:08:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1548929324; bh=JyArn9ovGYYICE5HdUVE4XQ2hlQLfgffs4ttLpyQrP4=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=GKdWvunu8Inbiyi6nHvll7xcEt3YpczszfDe2WmIb37eMjakI56XhAukLl7BGkA3x
 ViDyRkULydz746kWSf7j4D2BDAzW4B8/vIjN9lYd4dduopoiLstW/IJocf1jYri9aa
 2q43WbG4WlnzfK4amvSYtLLNpTKW3vEXfYyG0iLw=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 3EF2E8B814;
 Thu, 31 Jan 2019 11:08:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 2QKi2J4PYWlb; Thu, 31 Jan 2019 11:08:45 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id DE9978B78D;
 Thu, 31 Jan 2019 11:08:44 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 85AA872E14; Thu, 31 Jan 2019 10:08:44 +0000 (UTC)
Message-Id: <fb9f47f910f95781734f92f93a54de0ef2dcd5e9.1548852243.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1548852242.git.christophe.leroy@c-s.fr>
References: <cover.1548852242.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v15 01/13] powerpc/irq: use memblock functions returning
 virtual address
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
Date: Thu, 31 Jan 2019 10:08:44 +0000 (UTC)
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

Since only the virtual address of allocated blocks is used,
lets use functions returning directly virtual address.

Those functions have the advantage of also zeroing the block.

Suggested-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/irq.c      |  5 -----
 arch/powerpc/kernel/setup_32.c | 26 ++++++++++++++++----------
 arch/powerpc/kernel/setup_64.c | 19 +++++++------------
 3 files changed, 23 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index bb299613a462..4a5dd8800946 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -725,18 +725,15 @@ void exc_lvl_ctx_init(void)
 #endif
 #endif
 
-		memset((void *)critirq_ctx[cpu_nr], 0, THREAD_SIZE);
 		tp = critirq_ctx[cpu_nr];
 		tp->cpu = cpu_nr;
 		tp->preempt_count = 0;
 
 #ifdef CONFIG_BOOKE
-		memset((void *)dbgirq_ctx[cpu_nr], 0, THREAD_SIZE);
 		tp = dbgirq_ctx[cpu_nr];
 		tp->cpu = cpu_nr;
 		tp->preempt_count = 0;
 
-		memset((void *)mcheckirq_ctx[cpu_nr], 0, THREAD_SIZE);
 		tp = mcheckirq_ctx[cpu_nr];
 		tp->cpu = cpu_nr;
 		tp->preempt_count = HARDIRQ_OFFSET;
@@ -754,12 +751,10 @@ void irq_ctx_init(void)
 	int i;
 
 	for_each_possible_cpu(i) {
-		memset((void *)softirq_ctx[i], 0, THREAD_SIZE);
 		tp = softirq_ctx[i];
 		tp->cpu = i;
 		klp_init_thread_info(tp);
 
-		memset((void *)hardirq_ctx[i], 0, THREAD_SIZE);
 		tp = hardirq_ctx[i];
 		tp->cpu = i;
 		klp_init_thread_info(tp);
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 947f904688b0..1f0b7629c1a6 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -196,6 +196,17 @@ static int __init ppc_init(void)
 }
 arch_initcall(ppc_init);
 
+static void *__init alloc_stack(void)
+{
+	void *ptr = memblock_alloc(THREAD_SIZE, THREAD_SIZE);
+
+	if (!ptr)
+		panic("cannot allocate %d bytes for stack at %pS\n",
+		      THREAD_SIZE, (void *)_RET_IP_);
+
+	return ptr;
+}
+
 void __init irqstack_early_init(void)
 {
 	unsigned int i;
@@ -203,10 +214,8 @@ void __init irqstack_early_init(void)
 	/* interrupt stacks must be in lowmem, we get that for free on ppc32
 	 * as the memblock is limited to lowmem by default */
 	for_each_possible_cpu(i) {
-		softirq_ctx[i] = (struct thread_info *)
-			__va(memblock_phys_alloc(THREAD_SIZE, THREAD_SIZE));
-		hardirq_ctx[i] = (struct thread_info *)
-			__va(memblock_phys_alloc(THREAD_SIZE, THREAD_SIZE));
+		softirq_ctx[i] = alloc_stack();
+		hardirq_ctx[i] = alloc_stack();
 	}
 }
 
@@ -224,13 +233,10 @@ void __init exc_lvl_early_init(void)
 		hw_cpu = 0;
 #endif
 
-		critirq_ctx[hw_cpu] = (struct thread_info *)
-			__va(memblock_phys_alloc(THREAD_SIZE, THREAD_SIZE));
+		critirq_ctx[hw_cpu] = alloc_stack();
 #ifdef CONFIG_BOOKE
-		dbgirq_ctx[hw_cpu] = (struct thread_info *)
-			__va(memblock_phys_alloc(THREAD_SIZE, THREAD_SIZE));
-		mcheckirq_ctx[hw_cpu] = (struct thread_info *)
-			__va(memblock_phys_alloc(THREAD_SIZE, THREAD_SIZE));
+		dbgirq_ctx[hw_cpu] = alloc_stack();
+		mcheckirq_ctx[hw_cpu] = alloc_stack();
 #endif
 	}
 }
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 236c1151a3a7..080dd515d587 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -634,19 +634,17 @@ __init u64 ppc64_bolted_size(void)
 
 static void *__init alloc_stack(unsigned long limit, int cpu)
 {
-	unsigned long pa;
+	void *ptr;
 
 	BUILD_BUG_ON(STACK_INT_FRAME_SIZE % 16);
 
-	pa = memblock_alloc_base_nid(THREAD_SIZE, THREAD_SIZE, limit,
-					early_cpu_to_node(cpu), MEMBLOCK_NONE);
-	if (!pa) {
-		pa = memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit);
-		if (!pa)
-			panic("cannot allocate stacks");
-	}
+	ptr = memblock_alloc_try_nid(THREAD_SIZE, THREAD_SIZE,
+				     MEMBLOCK_LOW_LIMIT, limit,
+				     early_cpu_to_node(cpu));
+	if (!ptr)
+		panic("cannot allocate stacks");
 
-	return __va(pa);
+	return ptr;
 }
 
 void __init irqstack_early_init(void)
@@ -739,20 +737,17 @@ void __init emergency_stack_init(void)
 		struct thread_info *ti;
 
 		ti = alloc_stack(limit, i);
-		memset(ti, 0, THREAD_SIZE);
 		emerg_stack_init_thread_info(ti, i);
 		paca_ptrs[i]->emergency_sp = (void *)ti + THREAD_SIZE;
 
 #ifdef CONFIG_PPC_BOOK3S_64
 		/* emergency stack for NMI exception handling. */
 		ti = alloc_stack(limit, i);
-		memset(ti, 0, THREAD_SIZE);
 		emerg_stack_init_thread_info(ti, i);
 		paca_ptrs[i]->nmi_emergency_sp = (void *)ti + THREAD_SIZE;
 
 		/* emergency stack for machine check exception handling. */
 		ti = alloc_stack(limit, i);
-		memset(ti, 0, THREAD_SIZE);
 		emerg_stack_init_thread_info(ti, i);
 		paca_ptrs[i]->mc_emergency_sp = (void *)ti + THREAD_SIZE;
 #endif
-- 
2.13.3

