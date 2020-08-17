Return-Path: <SRS0=WC9B=B3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC985C433E1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 06:00:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8859820758
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 06:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8859820758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BVNgR1Cd9zDqQH
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 16:00:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BVNPB4LR0zDqQ4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2020 15:47:58 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4BVNP25fMQz9tytm;
 Mon, 17 Aug 2020 07:47:50 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id doilp8E-UR36; Mon, 17 Aug 2020 07:47:50 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4BVNP24bwNz9tytl;
 Mon, 17 Aug 2020 07:47:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7EF168B772;
 Mon, 17 Aug 2020 07:47:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id xbfnOYmSa4Je; Mon, 17 Aug 2020 07:47:55 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.230.104])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 61CE78B75B;
 Mon, 17 Aug 2020 07:47:55 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 5497365CDD; Mon, 17 Aug 2020 05:47:55 +0000 (UTC)
Message-Id: <0eb61cf0dc66d781d47deb2228498cd61d03a754.1597643221.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 1/4] powerpc/process: Remove useless #ifdef CONFIG_VSX
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 17 Aug 2020 05:47:55 +0000 (UTC)
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

cpu_has_feature(CPU_FTR_VSX) returns false when CONFIG_VSX is
not set.

There is no need to enclose the test in an #ifdef CONFIG_VSX.
Remove it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/process.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index a17d0746d55f..b64d71188715 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -124,10 +124,8 @@ unsigned long notrace msr_check_and_set(unsigned long bits)
 
 	newmsr = oldmsr | bits;
 
-#ifdef CONFIG_VSX
 	if (cpu_has_feature(CPU_FTR_VSX) && (bits & MSR_FP))
 		newmsr |= MSR_VSX;
-#endif
 
 	if (oldmsr != newmsr)
 		mtmsr_isync(newmsr);
@@ -144,10 +142,8 @@ void notrace __msr_check_and_clear(unsigned long bits)
 
 	newmsr = oldmsr & ~bits;
 
-#ifdef CONFIG_VSX
 	if (cpu_has_feature(CPU_FTR_VSX) && (bits & MSR_FP))
 		newmsr &= ~MSR_VSX;
-#endif
 
 	if (oldmsr != newmsr)
 		mtmsr_isync(newmsr);
@@ -162,10 +158,8 @@ static void __giveup_fpu(struct task_struct *tsk)
 	save_fpu(tsk);
 	msr = tsk->thread.regs->msr;
 	msr &= ~(MSR_FP|MSR_FE0|MSR_FE1);
-#ifdef CONFIG_VSX
 	if (cpu_has_feature(CPU_FTR_VSX))
 		msr &= ~MSR_VSX;
-#endif
 	tsk->thread.regs->msr = msr;
 }
 
@@ -245,10 +239,8 @@ static void __giveup_altivec(struct task_struct *tsk)
 	save_altivec(tsk);
 	msr = tsk->thread.regs->msr;
 	msr &= ~MSR_VEC;
-#ifdef CONFIG_VSX
 	if (cpu_has_feature(CPU_FTR_VSX))
 		msr &= ~MSR_VSX;
-#endif
 	tsk->thread.regs->msr = msr;
 }
 
@@ -421,10 +413,8 @@ static int __init init_msr_all_available(void)
 	if (cpu_has_feature(CPU_FTR_ALTIVEC))
 		msr_all_available |= MSR_VEC;
 #endif
-#ifdef CONFIG_VSX
 	if (cpu_has_feature(CPU_FTR_VSX))
 		msr_all_available |= MSR_VSX;
-#endif
 #ifdef CONFIG_SPE
 	if (cpu_has_feature(CPU_FTR_SPE))
 		msr_all_available |= MSR_SPE;
@@ -509,19 +499,18 @@ static bool should_restore_altivec(void) { return false; }
 static void do_restore_altivec(void) { }
 #endif /* CONFIG_ALTIVEC */
 
-#ifdef CONFIG_VSX
 static bool should_restore_vsx(void)
 {
 	if (cpu_has_feature(CPU_FTR_VSX))
 		return true;
 	return false;
 }
+#ifdef CONFIG_VSX
 static void do_restore_vsx(void)
 {
 	current->thread.used_vsr = 1;
 }
 #else
-static bool should_restore_vsx(void) { return false; }
 static void do_restore_vsx(void) { }
 #endif /* CONFIG_VSX */
 
-- 
2.25.0

