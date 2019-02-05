Return-Path: <SRS0=EZew=QM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B50C282CB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 11:46:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 215692080D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 11:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 215692080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43v2pS1CPbzDq8X
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 22:46:08 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43v2Vv6kwHzDqHn
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 22:32:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43v2Vv4wP8z9sNR; Tue,  5 Feb 2019 22:32:39 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43v2Vv2YS5z9sNg; Tue,  5 Feb 2019 22:32:38 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v16 05/21] powerpc: prep stack walkers for THREAD_INFO_IN_TASK
Date: Tue,  5 Feb 2019 22:32:03 +1100
Message-Id: <20190205113219.17903-6-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205113219.17903-1-mpe@ellerman.id.au>
References: <20190205113219.17903-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Christophe Leroy <christophe.leroy@c-s.fr>

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
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
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
index cf31ce6c1f53..f958f3bcba04 100644
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
 
@@ -90,9 +95,8 @@ EXPORT_SYMBOL_GPL(save_stack_trace_regs);
  *
  * If the task is not 'current', the caller *must* ensure the task is inactive.
  */
-int
-save_stack_trace_tsk_reliable(struct task_struct *tsk,
-				struct stack_trace *trace)
+static int __save_stack_trace_tsk_reliable(struct task_struct *tsk,
+					   struct stack_trace *trace)
 {
 	unsigned long sp;
 	unsigned long newsp;
@@ -197,6 +201,25 @@ save_stack_trace_tsk_reliable(struct task_struct *tsk,
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
2.20.1

