Return-Path: <SRS0=ULCe=QH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3849C282C7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 10:20:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78C2B218AF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 10:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="SIRd5y6K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78C2B218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qx8C5RCQzDqbq
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 21:20:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="SIRd5y6K"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qwtc3CS8zDqTT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 21:08:56 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43qwtX1y3Rz9tyxD;
 Thu, 31 Jan 2019 11:08:52 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=SIRd5y6K; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id dg1E1baNvEeN; Thu, 31 Jan 2019 11:08:52 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43qwtX0wJkz9tyxB;
 Thu, 31 Jan 2019 11:08:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1548929332; bh=yMq6si7jSH6bQUbdVukf4mkG8sOf1bePhLPx15JBPBI=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=SIRd5y6KTz59S6MR0NxmvTvQnbh0EppDwx+cUqIvuKIgn3iwerFhyJ9ng4B1INBAj
 TXaVhccbqh3kuEnbcUAQ5mW+HdTJBMRlkvL+sGlYkNnOTPZwNaYlZK/1uAor3xnAKo
 Nq3LMd9nwv0fFdoaOzpyJVZFU1CxMX9GP1/1cpQc=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 437C28B814;
 Thu, 31 Jan 2019 11:08:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id zql9HpmPwQCG; Thu, 31 Jan 2019 11:08:53 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 05CB58B78D;
 Thu, 31 Jan 2019 11:08:53 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 9AFEA72E14; Thu, 31 Jan 2019 10:08:52 +0000 (UTC)
Message-Id: <38755f11005b121f1483736f565f6fd24c827e14.1548852243.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1548852242.git.christophe.leroy@c-s.fr>
References: <cover.1548852242.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v15 05/13] powerpc: prep stack walkers for THREAD_INFO_IN_TASK
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
Date: Thu, 31 Jan 2019 10:08:52 +0000 (UTC)
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

[text copied from commit 9bbd4c56b0b6
("arm64: prep stack walkers for THREAD_INFO_IN_TASK")]

When CONFIG_THREAD_INFO_IN_TASK is selected, task stacks may be freed
before a task is destroyed. To account for this, the stacks are
refcounted, and when manipulating the stack of another task, it is
necessary to get/put the stack to ensure it isn't freed and/or re-used
while we do so.

This patch reworks the powerpc stack walking code to account for this.
When CONFIG_THREAD_INFO_IN_TASK is not selected these perform no
refcounting, and this should only be a structural change that does not
affect behaviour.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/process.c    | 23 +++++++++++++++++++++--
 arch/powerpc/kernel/stacktrace.c | 29 ++++++++++++++++++++++++++---
 2 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index ce393df243aa..4ffbb677c9f5 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -2027,7 +2027,7 @@ int validate_sp(unsigned long sp, struct task_struct *p,
 
 EXPORT_SYMBOL(validate_sp);
 
-unsigned long get_wchan(struct task_struct *p)
+static unsigned long __get_wchan(struct task_struct *p)
 {
 	unsigned long ip, sp;
 	int count = 0;
@@ -2053,6 +2053,20 @@ unsigned long get_wchan(struct task_struct *p)
 	return 0;
 }
 
+unsigned long get_wchan(struct task_struct *p)
+{
+	unsigned long ret;
+
+	if (!try_get_task_stack(p))
+		return 0;
+
+	ret = __get_wchan(p);
+
+	put_task_stack(p);
+
+	return ret;
+}
+
 static int kstack_depth_to_print = CONFIG_PRINT_STACK_DEPTH;
 
 void show_stack(struct task_struct *tsk, unsigned long *stack)
@@ -2067,6 +2081,9 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
 	int curr_frame = 0;
 #endif
 
+	if (!try_get_task_stack(tsk))
+		return;
+
 	sp = (unsigned long) stack;
 	if (tsk == NULL)
 		tsk = current;
@@ -2081,7 +2098,7 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
 	printk("Call Trace:\n");
 	do {
 		if (!validate_sp(sp, tsk, STACK_FRAME_OVERHEAD))
-			return;
+			break;
 
 		stack = (unsigned long *) sp;
 		newsp = stack[0];
@@ -2121,6 +2138,8 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
 
 		sp = newsp;
 	} while (count++ < kstack_depth_to_print);
+
+	put_task_stack(tsk);
 }
 
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
index e2c50b55138f..f80e1129c0f2 100644
--- a/arch/powerpc/kernel/stacktrace.c
+++ b/arch/powerpc/kernel/stacktrace.c
@@ -67,12 +67,17 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 {
 	unsigned long sp;
 
+	if (!try_get_task_stack(tsk))
+		return;
+
 	if (tsk == current)
 		sp = current_stack_pointer();
 	else
 		sp = tsk->thread.ksp;
 
 	save_context_stack(trace, sp, tsk, 0);
+
+	put_task_stack(tsk);
 }
 EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
 
@@ -84,9 +89,8 @@ save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
 EXPORT_SYMBOL_GPL(save_stack_trace_regs);
 
 #ifdef CONFIG_HAVE_RELIABLE_STACKTRACE
-int
-save_stack_trace_tsk_reliable(struct task_struct *tsk,
-				struct stack_trace *trace)
+static int __save_stack_trace_tsk_reliable(struct task_struct *tsk,
+					   struct stack_trace *trace)
 {
 	unsigned long sp;
 	unsigned long stack_page = (unsigned long)task_stack_page(tsk);
@@ -193,6 +197,25 @@ save_stack_trace_tsk_reliable(struct task_struct *tsk,
 	}
 	return 0;
 }
+
+int save_stack_trace_tsk_reliable(struct task_struct *tsk,
+				  struct stack_trace *trace)
+{
+	int ret;
+
+	/*
+	 * If the task doesn't have a stack (e.g., a zombie), the stack is
+	 * "reliably" empty.
+	 */
+	if (!try_get_task_stack(tsk))
+		return 0;
+
+	ret = __save_stack_trace_tsk_reliable(tsk, trace);
+
+	put_task_stack(tsk);
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(save_stack_trace_tsk_reliable);
 #endif /* CONFIG_HAVE_RELIABLE_STACKTRACE */
 
-- 
2.13.3

