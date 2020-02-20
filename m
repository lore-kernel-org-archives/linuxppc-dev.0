Return-Path: <SRS0=DuU+=4I=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D644C11D04
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Feb 2020 11:54:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14F5D20722
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Feb 2020 11:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Ob7cSth8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F5D20722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48NY0D26DCzDqTq
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Feb 2020 22:54:04 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48NXxZ6DvVzDqDS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Feb 2020 22:51:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=Ob7cSth8; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 48NXxZ2PXvz9sR4; Thu, 20 Feb 2020 22:51:46 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 48NXxZ1GKHz9sRN; Thu, 20 Feb 2020 22:51:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1582199506;
 bh=oDTyRWdmbY0HToM3fgkqZbZL6ZGz9v5UJjkSqsUQeM4=;
 h=From:To:Cc:Subject:Date:From;
 b=Ob7cSth8Bbv1lKlPjvi0EhFomR2hiHshOBt9+SQVGos1TdoMxAeiP2ipzD6XzRSxV
 83e20KO9KxBVE/8zLWXvecd4cgQXfMZVa9ThQNeC71pVbe25Dg/88cdhLklknDDL5b
 kkMKHQaT5qk/j44udEfOkq0vtfPbVHfVfK8APLDRVpo92z8/EXw/6rRTb4FejvpmL1
 osR/v/+Z5UovsAl53yymgzavv1YygjkhjWacJPQEG201qGQvBcVowvs/aYl/i/ec/8
 1AaFuu4Wa2sGAbIM4v1NK31Nv1+BOJlbS6uExfJ/NyWj5N0+QB3scs1+q2+9MC+iKF
 QI+oV438qntcQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 1/5] powerpc: Rename current_stack_pointer() to
 current_stack_frame()
Date: Thu, 20 Feb 2020 22:51:37 +1100
Message-Id: <20200220115141.2707-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.21.1
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

current_stack_pointer(), which was called __get_SP(), used to just
return the value in r1.

But that caused problems in some cases, so it was turned into a
function in commit bfe9a2cfe91a ("powerpc: Reimplement __get_SP() as a
function not a define").

Because it's a function in a separate compilation unit to all its
callers, it has the effect of causing a stack frame to be created, and
then returns the address of that frame. This is good in some cases
like those described in the above commit, but in other cases it's
overkill, we just need to know what stack page we're on.

On some other arches current_stack_pointer is just a register global
giving the stack pointer, and we'd like to do that too. So rename our
current_stack_pointer() to current_stack_frame() to make that
possible.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/perf_event.h | 2 +-
 arch/powerpc/include/asm/reg.h        | 2 +-
 arch/powerpc/kernel/irq.c             | 4 ++--
 arch/powerpc/kernel/misc.S            | 4 ++--
 arch/powerpc/kernel/process.c         | 2 +-
 arch/powerpc/kernel/stacktrace.c      | 6 +++---
 6 files changed, 10 insertions(+), 10 deletions(-)

v3: New.

diff --git a/arch/powerpc/include/asm/perf_event.h b/arch/powerpc/include/asm/perf_event.h
index 7426d7a90e1e..eed3954082fa 100644
--- a/arch/powerpc/include/asm/perf_event.h
+++ b/arch/powerpc/include/asm/perf_event.h
@@ -32,7 +32,7 @@
 	do {							\
 		(regs)->result = 0;				\
 		(regs)->nip = __ip;				\
-		(regs)->gpr[1] = current_stack_pointer();	\
+		(regs)->gpr[1] = current_stack_frame();		\
 		asm volatile("mfmsr %0" : "=r" ((regs)->msr));	\
 	} while (0)
 
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 1aa46dff0957..1b1ffdba6097 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1448,7 +1448,7 @@ static inline void mtsrin(u32 val, u32 idx)
 
 #define proc_trap()	asm volatile("trap")
 
-extern unsigned long current_stack_pointer(void);
+extern unsigned long current_stack_frame(void);
 
 extern unsigned long scom970_read(unsigned int address);
 extern void scom970_write(unsigned int address, unsigned long value);
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 5c9b11878555..02118c18434d 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -602,7 +602,7 @@ static inline void check_stack_overflow(void)
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
 	long sp;
 
-	sp = current_stack_pointer() & (THREAD_SIZE-1);
+	sp = current_stack_frame() & (THREAD_SIZE-1);
 
 	/* check for stack overflow: is there less than 2KB free? */
 	if (unlikely(sp < 2048)) {
@@ -647,7 +647,7 @@ void do_IRQ(struct pt_regs *regs)
 	void *cursp, *irqsp, *sirqsp;
 
 	/* Switch to the irq stack to handle this */
-	cursp = (void *)(current_stack_pointer() & ~(THREAD_SIZE - 1));
+	cursp = (void *)(current_stack_frame() & ~(THREAD_SIZE - 1));
 	irqsp = hardirq_ctx[raw_smp_processor_id()];
 	sirqsp = softirq_ctx[raw_smp_processor_id()];
 
diff --git a/arch/powerpc/kernel/misc.S b/arch/powerpc/kernel/misc.S
index 974f65f79a8e..65f9f731c229 100644
--- a/arch/powerpc/kernel/misc.S
+++ b/arch/powerpc/kernel/misc.S
@@ -110,7 +110,7 @@ _GLOBAL(longjmp)
 	li	r3, 1
 	blr
 
-_GLOBAL(current_stack_pointer)
+_GLOBAL(current_stack_frame)
 	PPC_LL	r3,0(r1)
 	blr
-EXPORT_SYMBOL(current_stack_pointer)
+EXPORT_SYMBOL(current_stack_frame)
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index e730b8e522b0..110db94cdf3c 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -2051,7 +2051,7 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
 	sp = (unsigned long) stack;
 	if (sp == 0) {
 		if (tsk == current)
-			sp = current_stack_pointer();
+			sp = current_stack_frame();
 		else
 			sp = tsk->thread.ksp;
 	}
diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
index e2a46cfed5fd..c477b8585a29 100644
--- a/arch/powerpc/kernel/stacktrace.c
+++ b/arch/powerpc/kernel/stacktrace.c
@@ -57,7 +57,7 @@ void save_stack_trace(struct stack_trace *trace)
 {
 	unsigned long sp;
 
-	sp = current_stack_pointer();
+	sp = current_stack_frame();
 
 	save_context_stack(trace, sp, current, 1);
 }
@@ -71,7 +71,7 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 		return;
 
 	if (tsk == current)
-		sp = current_stack_pointer();
+		sp = current_stack_frame();
 	else
 		sp = tsk->thread.ksp;
 
@@ -131,7 +131,7 @@ static int __save_stack_trace_tsk_reliable(struct task_struct *tsk,
 	}
 
 	if (tsk == current)
-		sp = current_stack_pointer();
+		sp = current_stack_frame();
 	else
 		sp = tsk->thread.ksp;
 
-- 
2.21.1

