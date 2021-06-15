Return-Path: <SRS0=IFQS=LJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0CBC48BDF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 08:34:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 602B9613D0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 08:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 602B9613D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G41nX3jx0z3bnT
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 18:34:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G41mv2xN6z30CS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jun 2021 18:33:35 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4G41mg4zvLzB8mB;
 Tue, 15 Jun 2021 10:33:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wfQQf5NaQRu9; Tue, 15 Jun 2021 10:33:23 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4G41mg41v4zB8hP;
 Tue, 15 Jun 2021 10:33:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 10E918B7B8;
 Tue, 15 Jun 2021 10:33:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id GaSWeabT_J_J; Tue, 15 Jun 2021 10:33:23 +0200 (CEST)
Received: from po9473vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 6E3C98B7AE;
 Tue, 15 Jun 2021 10:33:22 +0200 (CEST)
Received: by po9473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 4CF9766264; Tue, 15 Jun 2021 08:33:22 +0000 (UTC)
Message-Id: <e7cc75be0b753364b264ebe27a8ecf7de56546b7.1623745949.git.christophe.leroy@csgroup.eu>
In-Reply-To: <8071cd2e2f2bdc0711e6ac435dff4a09ff21fee2.1623745949.git.christophe.leroy@csgroup.eu>
References: <8071cd2e2f2bdc0711e6ac435dff4a09ff21fee2.1623745949.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 2/5] powerpc/interrupt: Refactor
 interrupt_exit_user_prepare()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 npiggin@gmail.com
Date: Tue, 15 Jun 2021 08:33:22 +0000 (UTC)
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

interrupt_exit_user_prepare() is a superset of
interrupt_exit_user_prepare_main().

Refactor to avoid code duplication.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/interrupt.c | 57 ++-------------------------------
 1 file changed, 3 insertions(+), 54 deletions(-)

diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index ba2d602d2da6..b9558372adc0 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -400,9 +400,7 @@ notrace unsigned long syscall_exit_restart(unsigned long r3, struct pt_regs *reg
 
 notrace unsigned long interrupt_exit_user_prepare(struct pt_regs *regs)
 {
-	unsigned long ti_flags;
-	unsigned long flags;
-	unsigned long ret = 0;
+	unsigned long ret;
 
 	if (!IS_ENABLED(CONFIG_BOOKE) && !IS_ENABLED(CONFIG_40x))
 		BUG_ON(!(regs->msr & MSR_RI));
@@ -416,63 +414,14 @@ notrace unsigned long interrupt_exit_user_prepare(struct pt_regs *regs)
 	 */
 	kuap_assert_locked();
 
-	local_irq_save(flags);
-
-again:
-	ti_flags = READ_ONCE(current_thread_info()->flags);
-	while (unlikely(ti_flags & (_TIF_USER_WORK_MASK & ~_TIF_RESTORE_TM))) {
-		local_irq_enable(); /* returning to user: may enable */
-		if (ti_flags & _TIF_NEED_RESCHED) {
-			schedule();
-		} else {
-			if (ti_flags & _TIF_SIGPENDING)
-				ret |= _TIF_RESTOREALL;
-			do_notify_resume(regs, ti_flags);
-		}
-		local_irq_disable();
-		ti_flags = READ_ONCE(current_thread_info()->flags);
-	}
-
-	if (IS_ENABLED(CONFIG_PPC_BOOK3S_64) && IS_ENABLED(CONFIG_PPC_FPU)) {
-		if (IS_ENABLED(CONFIG_PPC_TRANSACTIONAL_MEM) &&
-				unlikely((ti_flags & _TIF_RESTORE_TM))) {
-			restore_tm_state(regs);
-		} else {
-			unsigned long mathflags = MSR_FP;
-
-			if (cpu_has_feature(CPU_FTR_VSX))
-				mathflags |= MSR_VEC | MSR_VSX;
-			else if (cpu_has_feature(CPU_FTR_ALTIVEC))
-				mathflags |= MSR_VEC;
-
-			/* See above restore_math comment */
-			if ((regs->msr & mathflags) != mathflags)
-				restore_math(regs);
-		}
-	}
-
-	if (!prep_irq_for_user_exit()) {
-		local_irq_enable();
-		local_irq_disable();
-		goto again;
-	}
-
-	booke_load_dbcr0();
-
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-	local_paca->tm_scratch = regs->msr;
-#endif
+	local_irq_disable();
 
-	account_cpu_user_exit();
+	ret = interrupt_exit_user_prepare_main(regs, 0);
 
 #ifdef CONFIG_PPC64
 	regs->exit_result = ret;
 #endif
 
-	/* Restore user access locks last */
-	kuap_user_restore(regs);
-	kuep_unlock();
-
 	return ret;
 }
 
-- 
2.25.0

