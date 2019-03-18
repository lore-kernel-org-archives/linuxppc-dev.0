Return-Path: <SRS0=3pJc=RV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48F0C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 10:57:49 +0000 (UTC)
Received: from lists.ozlabs.org (unknown [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66E8B20854
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 10:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E8B20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44NCnl11qczDqJT
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 21:57:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=sudeep.holla@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 44NCcZ3Hm9zDqKX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2019 21:49:49 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 816E4174E;
 Mon, 18 Mar 2019 03:49:48 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8D41B3F614;
 Mon, 18 Mar 2019 03:49:45 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 4/6] powerpc: use common ptrace_syscall_enter hook to
 handle _TIF_SYSCALL_EMU
Date: Mon, 18 Mar 2019 10:49:23 +0000
Message-Id: <20190318104925.16600-5-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190318104925.16600-1-sudeep.holla@arm.com>
References: <20190318104925.16600-1-sudeep.holla@arm.com>
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
Cc: Haibo Xu <haibo.xu@arm.com>, Steve Capper <Steve.Capper@arm.com>,
 jdike@addtoit.com, Sudeep Holla <sudeep.holla@arm.com>,
 Will Deacon <will.deacon@arm.com>, Oleg Nesterov <oleg@redhat.com>,
 Bin Lu <bin.lu@arm.com>, Richard Weinberger <richard@nod.at>,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Andy Lutomirski <luto@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Now that we have a new hook ptrace_syscall_enter that can be called from
syscall entry code and it handles PTRACE_SYSEMU in generic code, we
can do some cleanup using the same in do_syscall_trace_enter.

Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/powerpc/kernel/ptrace.c | 48 ++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 2e2183b800a8..05579a5dcb12 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -3278,35 +3278,29 @@ long do_syscall_trace_enter(struct pt_regs *regs)
 
 	user_exit();
 
-	flags = READ_ONCE(current_thread_info()->flags) &
-		(_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE);
-
-	if (flags) {
-		int rc = tracehook_report_syscall_entry(regs);
+	if (unlikely(ptrace_syscall_enter(regs))) {
+		/*
+		 * A nonzero return code from tracehook_report_syscall_entry()
+		 * tells us to prevent the syscall execution, but we are not
+		 * going to execute it anyway.
+		 *
+		 * Returning -1 will skip the syscall execution. We want to
+		 * avoid clobbering any registers, so we don't goto the skip
+		 * label below.
+		 */
+		return -1;
+	}
 
-		if (unlikely(flags & _TIF_SYSCALL_EMU)) {
-			/*
-			 * A nonzero return code from
-			 * tracehook_report_syscall_entry() tells us to prevent
-			 * the syscall execution, but we are not going to
-			 * execute it anyway.
-			 *
-			 * Returning -1 will skip the syscall execution. We want
-			 * to avoid clobbering any registers, so we don't goto
-			 * the skip label below.
-			 */
-			return -1;
-		}
+	flags = READ_ONCE(current_thread_info()->flags) & _TIF_SYSCALL_TRACE;
 
-		if (rc) {
-			/*
-			 * The tracer decided to abort the syscall. Note that
-			 * the tracer may also just change regs->gpr[0] to an
-			 * invalid syscall number, that is handled below on the
-			 * exit path.
-			 */
-			goto skip;
-		}
+	if (flags && tracehook_report_syscall_entry(regs)) {
+		/*
+		 * The tracer decided to abort the syscall. Note that
+		 * the tracer may also just change regs->gpr[0] to an
+		 * invalid syscall number, that is handled below on the
+		 * exit path.
+		 */
+		goto skip;
 	}
 
 	/* Run seccomp after ptrace; allow it to set gpr[3]. */
-- 
2.17.1

