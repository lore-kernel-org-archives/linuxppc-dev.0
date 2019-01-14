Return-Path: <SRS0=iwfG=PW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0845C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 04:11:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 534A420660
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 04:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 534A420660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43dKln0rzgzDqRX
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 15:11:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=joe.lawrence@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43dKk01DR0zDq8V
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2019 15:09:43 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 10C3CDC8E0;
 Mon, 14 Jan 2019 04:09:41 +0000 (UTC)
Received: from redhat.com (ovpn-120-146.rdu2.redhat.com [10.10.120.146])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6628160BEC;
 Mon, 14 Jan 2019 04:09:39 +0000 (UTC)
Date: Sun, 13 Jan 2019 23:09:37 -0500
From: Joe Lawrence <joe.lawrence@redhat.com>
To: Nicolai Stange <nstange@suse.de>
Subject: Re: ppc64le reliable stack unwinder and scheduled tasks
Message-ID: <20190114040937.GA6739@redhat.com>
References: <7f468285-b149-37e2-e782-c9e538b997a9@redhat.com>
 <87bm4ocbbt.fsf@suse.de> <20190111010808.GA17858@redhat.com>
 <87fttzbpid.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fttzbpid.fsf@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Mon, 14 Jan 2019 04:09:41 +0000 (UTC)
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
Cc: Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org,
 Torsten Duwe <duwe@lst.de>, live-patching@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Jan 11, 2019 at 08:51:54AM +0100, Nicolai Stange wrote:
> Joe Lawrence <joe.lawrence@redhat.com> writes:
> 
> > On Fri, Jan 11, 2019 at 01:00:38AM +0100, Nicolai Stange wrote:

[ ... snip ... ]

> >> For testing, could you try whether clearing the word at STACK_FRAME_MARKER
> >> from _switch() helps?
> >> 
> >> I.e. something like (completely untested):
> >
> > I'll kick off some builds tonight and try to get tests lined up
> > tomorrow.  Unfortunately these take a bit of time to run setup, schedule
> > and complete, so perhaps by next week.
> 
> Ok, that's probably still a good test for confirmation, but the solution
> you proposed below is much better.

Good news, 40 tests (RHEL-7 backport) with clearing out the
STACK_FRAME_MARKER were all successful.  Previously I would see stalled
livepatch transitions due to the unreliable report in ~10% of test
cases.

> >> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> >> index 435927f549c4..b747d0647ec4 100644
> >> --- a/arch/powerpc/kernel/entry_64.S
> >> +++ b/arch/powerpc/kernel/entry_64.S
> >> @@ -596,6 +596,10 @@ _GLOBAL(_switch)
> >>  	SAVE_8GPRS(14, r1)
> >>  	SAVE_10GPRS(22, r1)
> >>  	std	r0,_NIP(r1)	/* Return to switch caller */
> >> +
> >> +	li	r23,0
> >> +	std	r23,96(r1)	/* 96 == STACK_FRAME_MARKER * sizeof(long) */
> >> +
> >>  	mfcr	r23
> >>  	std	r23,_CCR(r1)
> >>  	std	r1,KSP(r3)	/* Set old stack pointer */
> >> 
> >> 
> >
> > This may be sufficient to avoid the condition, but if the contents of
> > frame 0 are truely uninitialized (not to be trusted), should the
> > unwinder be even looking at that frame (for STACK_FRAMES_REGS_MARKER),
> > aside from the LR and other stack size geometry sanity checks?
> 
> That's a very good point: we'll only ever be examining scheduled out tasks
> and current (which at that time is running klp_try_complete_transition()).
> 
> current won't be in an interrupt/exception when it's walking its own
> stack. And scheduled out tasks can't have an exception/interrupt frame
> as their frame 0, correct?
> 
> Thus, AFAICS, whenever klp_try_complete_transition() finds a
> STACK_FRAMES_REGS_MARKER in frame 0, it is known to be garbage, as you
> said.

I gave this about 20 tests and they were also all successful, what do
you think?  (The log could probably use some trimming and cleanup.)  I
think either solution would fix the issue.

-->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8--

From edd3fb9e8a16d5a7ccc98759e9397f386f0e82ca Mon Sep 17 00:00:00 2001
From: Joe Lawrence <joe.lawrence@redhat.com>
Date: Fri, 11 Jan 2019 10:25:26 -0500
Subject: [PATCH] powerpc/livepatch: relax reliable stack tracer exception
 check

The ppc64le reliable stack tracer iterates over a given task's stack,
verifying a set of conditions to determine whether the trace is
'reliable'.  These checks include the presence of any exception frames.

We should be careful when inspecting the bottom-most stack frame (the
first to be unwound), particularly for scheduled-out tasks.  As Nicolai
Stange explains, "If I'm reading the code in _switch() correctly, the
first frame is completely uninitialized except for the pointer back to
the caller's stack frame."  If a previous do_IRQ() invocation, for
example, has left a residual exception-marker on the first frame, the
stack tracer would incorrectly report this task's trace as unreliable.

save_stack_trace_tsk_reliable() already skips the first frame when
verifying the saved Link Register.  It should do the same when looking
for the STACK_FRAME_REGS_MARKER.  The task it is unwinding will be
either 'current', in which case the tracer will have never been called
from an exception path, or the task will be inactive and its first
frame's contents will be uninitialized (aside from backchain pointer).

Fixes: df78d3f61480 ("powerpc/livepatch: Implement reliable stack tracing for the consistency model")
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 arch/powerpc/kernel/stacktrace.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
index e2c50b55138f..0793e75c45a6 100644
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
@@ -143,7 +149,7 @@ save_stack_trace_tsk_reliable(struct task_struct *tsk,
 			return 1;
 
 		/* Mark stacktraces with exception frames as unreliable. */
-		if (sp <= stack_end - STACK_INT_FRAME_SIZE &&
+		if (!firstframe && sp <= stack_end - STACK_INT_FRAME_SIZE &&
 		    stack[STACK_FRAME_MARKER] == STACK_FRAME_REGS_MARKER) {
 			return 1;
 		}
-- 
2.20.1


