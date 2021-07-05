Return-Path: <SRS0=1zWh=L5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A3DC07E99
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Jul 2021 12:01:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB96B60241
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Jul 2021 12:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB96B60241
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GJPRv2vZFz3bXx
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Jul 2021 22:01:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GJPRT67x3z303M
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Jul 2021 22:01:21 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4GJPRM0sMxzB7Q1;
 Mon,  5 Jul 2021 14:01:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S1KocAW6MyJi; Mon,  5 Jul 2021 14:01:19 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4GJPQq3k1hzB5YS;
 Mon,  5 Jul 2021 14:00:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7552C8B786;
 Mon,  5 Jul 2021 14:00:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id gAnyppKZ_Q8D; Mon,  5 Jul 2021 14:00:51 +0200 (CEST)
Received: from po9473vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.230.103])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 431C48B763;
 Mon,  5 Jul 2021 14:00:51 +0200 (CEST)
Received: by po9473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id C4FB6663AC; Mon,  5 Jul 2021 12:00:50 +0000 (UTC)
Message-Id: <e9d501da0c59f60ca767b1b3ea4603fce6d02b9e.1625486440.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/non-smp: Inconditionaly call smp_mb() on switch_mm
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Mon,  5 Jul 2021 12:00:50 +0000 (UTC)
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

Commit 3ccfebedd8cf ("powerpc, membarrier: Skip memory barrier in
switch_mm()") added some logic to skip the smp_mb() in
switch_mm_irqs_off() before the call to switch_mmu_context().

However, on non SMP smp_mb() is just a compiler barrier and doing
it inconditionaly is simpler than the logic used to check
whether the barrier is needed or not.

After the patch:

00000000 <switch_mm_irqs_off>:
...
   c:	7c 04 18 40 	cmplw   r4,r3
  10:	81 24 00 24 	lwz     r9,36(r4)
  14:	91 25 04 c8 	stw     r9,1224(r5)
  18:	4d 82 00 20 	beqlr
  1c:	48 00 00 00 	b       1c <switch_mm_irqs_off+0x1c>
			1c: R_PPC_REL24	switch_mmu_context

Before the patch:

00000000 <switch_mm_irqs_off>:
...
   c:	7c 04 18 40 	cmplw   r4,r3
  10:	81 24 00 24 	lwz     r9,36(r4)
  14:	91 25 04 c8 	stw     r9,1224(r5)
  18:	4d 82 00 20 	beqlr
  1c:	81 24 00 28 	lwz     r9,40(r4)
  20:	71 29 00 0a 	andi.   r9,r9,10
  24:	40 82 00 34 	bne     58 <switch_mm_irqs_off+0x58>
  28:	48 00 00 00 	b       28 <switch_mm_irqs_off+0x28>
			28: R_PPC_REL24	switch_mmu_context
...
  58:	2c 03 00 00 	cmpwi   r3,0
  5c:	41 82 ff cc 	beq     28 <switch_mm_irqs_off+0x28>
  60:	48 00 00 00 	b       60 <switch_mm_irqs_off+0x60>
			60: R_PPC_REL24	switch_mmu_context

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/membarrier.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/membarrier.h b/arch/powerpc/include/asm/membarrier.h
index 6e20bb5c74ea..de7f79157918 100644
--- a/arch/powerpc/include/asm/membarrier.h
+++ b/arch/powerpc/include/asm/membarrier.h
@@ -12,7 +12,8 @@ static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
 	 * when switching from userspace to kernel is not needed after
 	 * store to rq->curr.
 	 */
-	if (likely(!(atomic_read(&next->membarrier_state) &
+	if (IS_ENABLED(CONFIG_SMP) &&
+	    likely(!(atomic_read(&next->membarrier_state) &
 		     (MEMBARRIER_STATE_PRIVATE_EXPEDITED |
 		      MEMBARRIER_STATE_GLOBAL_EXPEDITED)) || !prev))
 		return;
-- 
2.25.0

