Return-Path: <SRS0=/GF9=P6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7574EC282C5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 16:04:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF32521726
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 16:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF32521726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43kYBz2ySFzDqRX
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 03:04:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=joe.lawrence@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43kY3929NRzDqMX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2019 02:57:41 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F16BB88E48;
 Tue, 22 Jan 2019 15:57:38 +0000 (UTC)
Received: from jlaw-desktop.bos.redhat.com (dhcp-17-208.bos.redhat.com
 [10.18.17.208])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E402F1048107;
 Tue, 22 Jan 2019 15:57:37 +0000 (UTC)
From: Joe Lawrence <joe.lawrence@redhat.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 live-patching@vger.kernel.org
Subject: [PATCH 3/4] powerpc/livepatch: small cleanups in
 save_stack_trace_tsk_reliable()
Date: Tue, 22 Jan 2019 10:57:23 -0500
Message-Id: <20190122155724.27557-4-joe.lawrence@redhat.com>
In-Reply-To: <20190122155724.27557-1-joe.lawrence@redhat.com>
References: <20190122155724.27557-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Tue, 22 Jan 2019 15:57:39 +0000 (UTC)
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

Mostly cosmetic changes:

- Group common stack pointer code at the top
- Simplify the first frame logic
- Code stackframe iteration into for...loop construct
- Check for trace->nr_entries overflow before adding any into the array

Suggested-by: Nicolai Stange <nstange@suse.de>
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 arch/powerpc/kernel/stacktrace.c | 40 +++++++++++---------------------
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
index 06688f4d557b..28c3c25755d7 100644
--- a/arch/powerpc/kernel/stacktrace.c
+++ b/arch/powerpc/kernel/stacktrace.c
@@ -95,20 +95,11 @@ save_stack_trace_tsk_reliable(struct task_struct *tsk,
 				struct stack_trace *trace)
 {
 	unsigned long sp;
+	unsigned long newsp;
 	unsigned long stack_page = (unsigned long)task_stack_page(tsk);
 	unsigned long stack_end;
 	int graph_idx = 0;
-
-	/*
-	 * The last frame (unwinding first) may not yet have saved
-	 * its LR onto the stack.
-	 */
-	int firstframe = 1;
-
-	if (tsk == current)
-		sp = current_stack_pointer();
-	else
-		sp = tsk->thread.ksp;
+	bool firstframe;
 
 	stack_end = stack_page + THREAD_SIZE;
 	if (!is_idle_task(tsk)) {
@@ -135,14 +126,20 @@ save_stack_trace_tsk_reliable(struct task_struct *tsk,
 		stack_end -= STACK_FRAME_OVERHEAD;
 	}
 
+	if (tsk == current)
+		sp = current_stack_pointer();
+	else
+		sp = tsk->thread.ksp;
+
 	if (sp < stack_page + sizeof(struct thread_struct) ||
 	    sp > stack_end - STACK_FRAME_MIN_SIZE) {
 		return 1;
 	}
 
-	for (;;) {
+	for (firstframe = true; sp != stack_end;
+	     firstframe = false, sp = newsp) {
 		unsigned long *stack = (unsigned long *) sp;
-		unsigned long newsp, ip;
+		unsigned long ip;
 
 		/* sanity check: ABI requires SP to be aligned 16 bytes. */
 		if (sp & 0xF)
@@ -163,10 +160,8 @@ save_stack_trace_tsk_reliable(struct task_struct *tsk,
 		 * rest of the frame may be uninitialized, continue to
 		 * the next.
 		 */
-		if (firstframe) {
-			firstframe = 0;
-			goto next;
-		}
+		if (firstframe)
+			continue;
 
 		/* Mark stacktraces with exception frames as unreliable. */
 		if (sp <= stack_end - STACK_INT_FRAME_SIZE &&
@@ -193,19 +188,12 @@ save_stack_trace_tsk_reliable(struct task_struct *tsk,
 			return 1;
 #endif
 
+		if (trace->nr_entries >= trace->max_entries)
+			return -E2BIG;
 		if (!trace->skip)
 			trace->entries[trace->nr_entries++] = ip;
 		else
 			trace->skip--;
-
-next:
-		if (newsp == stack_end)
-			break;
-
-		if (trace->nr_entries >= trace->max_entries)
-			return -E2BIG;
-
-		sp = newsp;
 	}
 	return 0;
 }
-- 
2.20.1

