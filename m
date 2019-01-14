Return-Path: <SRS0=iwfG=PW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039CBC43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 16:48:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14684206B7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 16:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14684206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43dfYd0hVGzDqWW
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 03:48:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=joe.lawrence@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43dfWr3P2HzDqWT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 03:47:04 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5C4FB8553D;
 Mon, 14 Jan 2019 16:47:02 +0000 (UTC)
Received: from redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 40A7619C7C;
 Mon, 14 Jan 2019 16:47:01 +0000 (UTC)
Date: Mon, 14 Jan 2019 11:46:59 -0500
From: Joe Lawrence <joe.lawrence@redhat.com>
To: Nicolai Stange <nstange@suse.de>
Subject: Re: ppc64le reliable stack unwinder and scheduled tasks
Message-ID: <20190114164659.GA18643@redhat.com>
References: <7f468285-b149-37e2-e782-c9e538b997a9@redhat.com>
 <87bm4ocbbt.fsf@suse.de> <20190111010808.GA17858@redhat.com>
 <87fttzbpid.fsf@suse.de> <20190114040937.GA6739@redhat.com>
 <877ef7bt6j.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877ef7bt6j.fsf@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Mon, 14 Jan 2019 16:47:02 +0000 (UTC)
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

On Mon, Jan 14, 2019 at 08:21:40AM +0100, Nicolai Stange wrote:
> Joe Lawrence <joe.lawrence@redhat.com> writes:
> 
> > We should be careful when inspecting the bottom-most stack frame (the
> > first to be unwound), particularly for scheduled-out tasks.  As Nicolai
> > Stange explains, "If I'm reading the code in _switch() correctly, the
> > first frame is completely uninitialized except for the pointer back to
> > the caller's stack frame."  If a previous do_IRQ() invocation, for
> > example, has left a residual exception-marker on the first frame, the
> > stack tracer would incorrectly report this task's trace as unreliable.
> >
> 
> FWIW, it's not been do_IRQ() who wrote the exception marker, but it's
> caller hardware_interrupt_common(), more specifically the
> EXCEPTION_PROLOG_COMMON_3 part therof.
> 

Hi Nicolai,

Yeah, I was sloppy with the description there. :)

> I thought about this a little more and can't see anything that would
> prevent higher, i.e. non-_switch() frames to also alias with prior
> exception frames. That STACK_FRAME_REGS_MARKER is written to a stack
> frame's "parameter area" and most functions probably don't initialize
> this either. So, AFAICS, higher stack frames could potentially be
> affected by the very same problem.

Hmm, I suppose a callee could leave that stack-word untouched and then
make subsquent calls, which would be confusing for the unwinder.

> I think the best solution would be to clear the STACK_FRAME_REGS_MARKER
> upon exception return. I have a patch ready for that and will post it
> after it has passed some basic testing -- hopefully later this day.
> 

I agree that this seems like the simplest way to clean up the exception
stack frame state. 

> That being said, I still think that your patch should also get applied
> in some form -- looking at unitialized memory is just not a good thing
> to do.
> 
> [ ... snip ...]

> I would perhaps not limit this to the STACK_FRAME_REGS_MARKER, but also
> not emit the ip obtained from the first frame into the resulting trace.
> 
> I.e., how about moving all the sp/newsp handling to the beginning of the
> loop and doing an 'if (firstframe) continue;' right after that?

Good point, there is a bunch of ip and trace entries bookkeeping that
shouldn't apply in this case.

I gave the following some very light testing (5.0.0-rc2 + Petr's atomic
patches as to include and run the selftests) ... if you want to take a
bigger hammer to refactor some of the sp/newsp code (perhaps it could be
incorporated into the for() loop itself), feel free to go for it.  You
could add something like this as a 2nd patch to the previously mentioned
STACK_FRAME_REGS_MARKER cleanup fix.

Thanks,

-- Joe

-->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8--

From b87f9e81cf59a6e7e2309400e1b417562414cd5c Mon Sep 17 00:00:00 2001
From: Joe Lawrence <joe.lawrence@redhat.com>
Date: Sun, 13 Jan 2019 21:02:01 -0500
Subject: [PATCH] powerpc/livepatch: relax reliable stack tracer checks for
 first-frame

The bottom-most stack frame (the first to be unwound) may be largely
uninitialized, for the "Power Architecture 64-Bit ELF V2 ABI" only
requires its backchain pointer to be set.

The reliable stack tracer should be careful when verifying this frame:
skip checks on STACK_FRAME_LR_SAVE and STACK_FRAME_MARKER offsets that
may contain uninitialized residual data.

Fixes: df78d3f61480 ("powerpc/livepatch: Implement reliable stack tracing for the consistency model")
Suggested-by: Nicolai Stange <nstange@suse.de>
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 arch/powerpc/kernel/stacktrace.c | 33 +++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
index e2c50b55138f..46096687a5a8 100644
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
@@ -158,11 +158,21 @@ save_stack_trace_tsk_reliable(struct task_struct *tsk,
 			return 1; /* invalid backlink, too far up. */
 		}
 
+		/* We can only trust the bottom frame's backlink, the rest
+		 * of the frame may be uninitialized, continue to the next. */
+		if (firstframe--)
+			goto next;
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
@@ -183,12 +193,13 @@ save_stack_trace_tsk_reliable(struct task_struct *tsk,
 		else
 			trace->skip--;
 
-		if (newsp == stack_end)
-			break;
-
 		if (trace->nr_entries >= trace->max_entries)
 			return -E2BIG;
 
+next:
+		if (newsp == stack_end)
+			break;
+
 		sp = newsp;
 	}
 	return 0;
-- 
2.20.1


