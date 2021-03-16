Return-Path: <SRS0=5tyt=IO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52888C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Mar 2021 07:58:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6612464F4D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Mar 2021 07:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6612464F4D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F05JD05dHz3by8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Mar 2021 18:58:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F05H64VQhz309v
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Mar 2021 18:57:19 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4F05Gz0Khxz9v027;
 Tue, 16 Mar 2021 08:57:15 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 5ZxMvtfGLWGv; Tue, 16 Mar 2021 08:57:14 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4F05Gy5fnrz9v023;
 Tue, 16 Mar 2021 08:57:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 745548B78A;
 Tue, 16 Mar 2021 08:57:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id ZbvnO1ugLN_d; Tue, 16 Mar 2021 08:57:15 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 0A4518B789;
 Tue, 16 Mar 2021 08:57:15 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id D9B0D675C0; Tue, 16 Mar 2021 07:57:14 +0000 (UTC)
Message-Id: <117f0200e11961af6c0fdf85c98373e5dcf96a47.1615881400.git.christophe.leroy@csgroup.eu>
In-Reply-To: <955248c6423cb068c5965923121ba31d4dd2fdde.1615881400.git.christophe.leroy@csgroup.eu>
References: <955248c6423cb068c5965923121ba31d4dd2fdde.1615881400.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 2/4] powerpc: Rename 'tsk' parameter into 'task'
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 16 Mar 2021 07:57:14 +0000 (UTC)
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

To better match generic code, rename 'tsk' to 'task' in
some stacktrace functions in preparation of following
patch which converts powerpc to generic ARCH_STACKWALK.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/stacktrace.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
index a2a050551109..5b93650bc16c 100644
--- a/arch/powerpc/kernel/stacktrace.c
+++ b/arch/powerpc/kernel/stacktrace.c
@@ -27,13 +27,13 @@
  * Save stack-backtrace addresses into a stack_trace buffer.
  */
 static void save_context_stack(struct stack_trace *trace, unsigned long sp,
-			struct task_struct *tsk, int savesched)
+			struct task_struct *task, int savesched)
 {
 	for (;;) {
 		unsigned long *stack = (unsigned long *) sp;
 		unsigned long newsp, ip;
 
-		if (!validate_sp(sp, tsk, STACK_FRAME_OVERHEAD))
+		if (!validate_sp(sp, task, STACK_FRAME_OVERHEAD))
 			return;
 
 		newsp = stack[0];
@@ -94,18 +94,18 @@ EXPORT_SYMBOL_GPL(save_stack_trace_regs);
  *
  * If the task is not 'current', the caller *must* ensure the task is inactive.
  */
-static int __save_stack_trace_tsk_reliable(struct task_struct *tsk,
+static int __save_stack_trace_tsk_reliable(struct task_struct *task,
 					   struct stack_trace *trace)
 {
 	unsigned long sp;
 	unsigned long newsp;
-	unsigned long stack_page = (unsigned long)task_stack_page(tsk);
+	unsigned long stack_page = (unsigned long)task_stack_page(task);
 	unsigned long stack_end;
 	int graph_idx = 0;
 	bool firstframe;
 
 	stack_end = stack_page + THREAD_SIZE;
-	if (!is_idle_task(tsk)) {
+	if (!is_idle_task(task)) {
 		/*
 		 * For user tasks, this is the SP value loaded on
 		 * kernel entry, see "PACAKSAVE(r13)" in _switch() and
@@ -129,10 +129,10 @@ static int __save_stack_trace_tsk_reliable(struct task_struct *tsk,
 		stack_end -= STACK_FRAME_OVERHEAD;
 	}
 
-	if (tsk == current)
+	if (task == current)
 		sp = current_stack_frame();
 	else
-		sp = tsk->thread.ksp;
+		sp = task->thread.ksp;
 
 	if (sp < stack_page + sizeof(struct thread_struct) ||
 	    sp > stack_end - STACK_FRAME_MIN_SIZE) {
@@ -181,7 +181,7 @@ static int __save_stack_trace_tsk_reliable(struct task_struct *tsk,
 		 * FIXME: IMHO these tests do not belong in
 		 * arch-dependent code, they are generic.
 		 */
-		ip = ftrace_graph_ret_addr(tsk, &graph_idx, ip, stack);
+		ip = ftrace_graph_ret_addr(task, &graph_idx, ip, stack);
 #ifdef CONFIG_KPROBES
 		/*
 		 * Mark stacktraces with kretprobed functions on them
-- 
2.25.0

