Return-Path: <SRS0=gbiG=P5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032EFC433EF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Nov 2021 20:27:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AE9C61178
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Nov 2021 20:27:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8AE9C61178
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HqGbq1qC0z3cmv
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Nov 2021 07:27:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=arm.com
 (client-ip=217.140.110.172; helo=foss.arm.com;
 envelope-from=valentin.schneider@arm.com; receiver=<UNKNOWN>)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by lists.ozlabs.org (Postfix) with ESMTP id 4HqGZ33kLhz2yPg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Nov 2021 07:25:31 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05175143B;
 Wed, 10 Nov 2021 12:25:30 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com
 [10.1.196.57])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BEBB43F5A1;
 Wed, 10 Nov 2021 12:25:27 -0800 (PST)
From: Valentin Schneider <valentin.schneider@arm.com>
To: linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
 linuxppc-dev@lists.ozlabs.org, linux-kbuild@vger.kernel.org
Subject: [PATCH v2 3/5] powerpc: Use preemption model accessors
Date: Wed, 10 Nov 2021 20:24:46 +0000
Message-Id: <20211110202448.4054153-4-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211110202448.4054153-1-valentin.schneider@arm.com>
References: <20211110202448.4054153-1-valentin.schneider@arm.com>
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
Cc: Marco Elver <elver@google.com>, Michal Marek <michal.lkml@markovi.net>,
 Peter Zijlstra <peterz@infradead.org>,
 Frederic Weisbecker <frederic@kernel.org>, Mike Galbraith <efault@gmx.de>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Steven Rostedt <rostedt@goodmis.org>, Paul Mackerras <paulus@samba.org>,
 Masahiro Yamada <masahiroy@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Dmitry Vyukov <dvyukov@google.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Per PREEMPT_DYNAMIC, checking CONFIG_PREEMPT doesn't tell you the actual
preemption model of the live kernel. Use the newly-introduced accessors
instead.

sched_init() -> preempt_dynamic_init() happens way before IRQs are set up,
so this should be fine.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 arch/powerpc/kernel/interrupt.c | 2 +-
 arch/powerpc/kernel/traps.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index de10a2697258..c56c10b59be3 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -552,7 +552,7 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs)
 		/* Returning to a kernel context with local irqs enabled. */
 		WARN_ON_ONCE(!(regs->msr & MSR_EE));
 again:
-		if (IS_ENABLED(CONFIG_PREEMPT)) {
+		if (is_preempt_full()) {
 			/* Return to preemptible kernel context */
 			if (unlikely(current_thread_info()->flags & _TIF_NEED_RESCHED)) {
 				if (preempt_count() == 0)
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index aac8c0412ff9..1cb31bbdc925 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -265,7 +265,7 @@ static int __die(const char *str, struct pt_regs *regs, long err)
 	printk("%s PAGE_SIZE=%luK%s%s%s%s%s%s %s\n",
 	       IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN) ? "LE" : "BE",
 	       PAGE_SIZE / 1024, get_mmu_str(),
-	       IS_ENABLED(CONFIG_PREEMPT) ? " PREEMPT" : "",
+	       is_preempt_full() ? " PREEMPT" : "",
 	       IS_ENABLED(CONFIG_SMP) ? " SMP" : "",
 	       IS_ENABLED(CONFIG_SMP) ? (" NR_CPUS=" __stringify(NR_CPUS)) : "",
 	       debug_pagealloc_enabled() ? " DEBUG_PAGEALLOC" : "",
-- 
2.25.1

