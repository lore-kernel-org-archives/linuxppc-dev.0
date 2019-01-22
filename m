Return-Path: <SRS0=/GF9=P6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8157FC282C3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 16:03:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0593A217D8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 16:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0593A217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43kY9N6M8fzDqPS
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 03:03:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=joe.lawrence@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43kY365kS6zDqMN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2019 02:57:38 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0E23829158;
 Tue, 22 Jan 2019 15:57:37 +0000 (UTC)
Received: from jlaw-desktop.bos.redhat.com (dhcp-17-208.bos.redhat.com
 [10.18.17.208])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A151B1019633;
 Tue, 22 Jan 2019 15:57:34 +0000 (UTC)
From: Joe Lawrence <joe.lawrence@redhat.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 live-patching@vger.kernel.org
Subject: [PATCH 2/4] powerpc/livepatch: relax reliable stack tracer checks for
 first-frame
Date: Tue, 22 Jan 2019 10:57:22 -0500
Message-Id: <20190122155724.27557-3-joe.lawrence@redhat.com>
In-Reply-To: <20190122155724.27557-1-joe.lawrence@redhat.com>
References: <20190122155724.27557-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Tue, 22 Jan 2019 15:57:37 +0000 (UTC)
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
Cc: Nicolai Stange <nstange@suse.de>, Jiri Kosina <jkosina@suse.cz>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Torsten Duwe <duwe@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The bottom-most stack frame (the first to be unwound) may be largely
uninitialized, for the "Power Architecture 64-Bit ELF V2 ABI" only
requires its backchain pointer to be set.

The reliable stack tracer should be careful when verifying this frame:
skip checks on STACK_FRAME_LR_SAVE and STACK_FRAME_MARKER offsets that
may contain uninitialized residual data.

Fixes: df78d3f61480 ("powerpc/livepatch: Implement reliable stack tracing for the consistency model")
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 arch/powerpc/kernel/stacktrace.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
index e2c50b55138f..06688f4d557b 100644
--- a/arch/powerpc/kernel/stacktrace.c
+++ b/arch/powerpc/kernel/stacktrace.c
@@ -84,6 +84,12 @@ save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
 EXPORT_SYMBOL_GPL(save_stack_trace_regs);
 
 #ifdef CONFIG_HAVE_RELIABLE_STACKTRACE
+/*
+ * This function returns an error if it detects any unreliable features of the
+ * stack.  Otherwise it guarantees that the stack trace is reliable.
+ *
+ * If the task is not 'current', the caller *must* ensure the task is inactive.
+ */
 int
 save_stack_trace_tsk_reliable(struct task_struct *tsk,
 				struct stack_trace *trace)
@@ -142,12 +148,6 @@ save_stack_trace_tsk_reliable(struct task_struct *tsk,
 		if (sp & 0xF)
 			return 1;
 
-		/* Mark stacktraces with exception frames as unreliable. */
-		if (sp <= stack_end - STACK_INT_FRAME_SIZE &&
-		    stack[STACK_FRAME_MARKER] == STACK_FRAME_REGS_MARKER) {
-			return 1;
-		}
-
 		newsp = stack[0];
 		/* Stack grows downwards; unwinder may only go up. */
 		if (newsp <= sp)
@@ -158,11 +158,26 @@ save_stack_trace_tsk_reliable(struct task_struct *tsk,
 			return 1; /* invalid backlink, too far up. */
 		}
 
+		/*
+		 * We can only trust the bottom frame's backlink, the
+		 * rest of the frame may be uninitialized, continue to
+		 * the next.
+		 */
+		if (firstframe) {
+			firstframe = 0;
+			goto next;
+		}
+
+		/* Mark stacktraces with exception frames as unreliable. */
+		if (sp <= stack_end - STACK_INT_FRAME_SIZE &&
+		    stack[STACK_FRAME_MARKER] == STACK_FRAME_REGS_MARKER) {
+			return 1;
+		}
+
 		/* Examine the saved LR: it must point into kernel code. */
 		ip = stack[STACK_FRAME_LR_SAVE];
-		if (!firstframe && !__kernel_text_address(ip))
+		if (!__kernel_text_address(ip))
 			return 1;
-		firstframe = 0;
 
 		/*
 		 * FIXME: IMHO these tests do not belong in
@@ -183,6 +198,7 @@ save_stack_trace_tsk_reliable(struct task_struct *tsk,
 		else
 			trace->skip--;
 
+next:
 		if (newsp == stack_end)
 			break;
 
-- 
2.20.1

