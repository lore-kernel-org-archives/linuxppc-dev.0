Return-Path: <SRS0=iwfG=PW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E53C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 07:23:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51C9F20659
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 07:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C9F20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43dQ1L1Qn6zDqSB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 18:23:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=suse.de
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=nstange@suse.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.de
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43dPzX4n0LzDqPw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2019 18:21:44 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 3CDBAAE1D;
 Mon, 14 Jan 2019 07:21:41 +0000 (UTC)
From: Nicolai Stange <nstange@suse.de>
To: Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: ppc64le reliable stack unwinder and scheduled tasks
References: <7f468285-b149-37e2-e782-c9e538b997a9@redhat.com>
 <87bm4ocbbt.fsf@suse.de> <20190111010808.GA17858@redhat.com>
 <87fttzbpid.fsf@suse.de> <20190114040937.GA6739@redhat.com>
Date: Mon, 14 Jan 2019 08:21:40 +0100
In-Reply-To: <20190114040937.GA6739@redhat.com> (Joe Lawrence's message of
 "Sun, 13 Jan 2019 23:09:37 -0500")
Message-ID: <877ef7bt6j.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Nicolai Stange <nstange@suse.de>, linux-kernel@vger.kernel.org,
 Torsten Duwe <duwe@lst.de>, Jiri Kosina <jkosina@suse.cz>,
 live-patching@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Joe Lawrence <joe.lawrence@redhat.com> writes:

> On Fri, Jan 11, 2019 at 08:51:54AM +0100, Nicolai Stange wrote:
>> Joe Lawrence <joe.lawrence@redhat.com> writes:
>>=20
>> > On Fri, Jan 11, 2019 at 01:00:38AM +0100, Nicolai Stange wrote:
>
> [ ... snip ... ]
>
>> >> For testing, could you try whether clearing the word at STACK_FRAME_M=
ARKER
>> >> from _switch() helps?
>> >>=20
>> >> I.e. something like (completely untested):
>> >
>> > I'll kick off some builds tonight and try to get tests lined up
>> > tomorrow.  Unfortunately these take a bit of time to run setup, schedu=
le
>> > and complete, so perhaps by next week.
>>=20
>> Ok, that's probably still a good test for confirmation, but the solution
>> you proposed below is much better.
>
> Good news, 40 tests (RHEL-7 backport) with clearing out the
> STACK_FRAME_MARKER were all successful.  Previously I would see stalled
> livepatch transitions due to the unreliable report in ~10% of test
> cases.
>
>> >> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/ent=
ry_64.S
>> >> index 435927f549c4..b747d0647ec4 100644
>> >> --- a/arch/powerpc/kernel/entry_64.S
>> >> +++ b/arch/powerpc/kernel/entry_64.S
>> >> @@ -596,6 +596,10 @@ _GLOBAL(_switch)
>> >>  	SAVE_8GPRS(14, r1)
>> >>  	SAVE_10GPRS(22, r1)
>> >>  	std	r0,_NIP(r1)	/* Return to switch caller */
>> >> +
>> >> +	li	r23,0
>> >> +	std	r23,96(r1)	/* 96 =3D=3D STACK_FRAME_MARKER * sizeof(long) */
>> >> +
>> >>  	mfcr	r23
>> >>  	std	r23,_CCR(r1)
>> >>  	std	r1,KSP(r3)	/* Set old stack pointer */
>> >>=20
>> >>=20
>> >
>> > This may be sufficient to avoid the condition, but if the contents of
>> > frame 0 are truely uninitialized (not to be trusted), should the
>> > unwinder be even looking at that frame (for STACK_FRAMES_REGS_MARKER),
>> > aside from the LR and other stack size geometry sanity checks?
>>=20
>> That's a very good point: we'll only ever be examining scheduled out tas=
ks
>> and current (which at that time is running klp_try_complete_transition()=
).
>>=20
>> current won't be in an interrupt/exception when it's walking its own
>> stack. And scheduled out tasks can't have an exception/interrupt frame
>> as their frame 0, correct?
>>=20
>> Thus, AFAICS, whenever klp_try_complete_transition() finds a
>> STACK_FRAMES_REGS_MARKER in frame 0, it is known to be garbage, as you
>> said.
>
> I gave this about 20 tests and they were also all successful, what do
> you think?  (The log could probably use some trimming and cleanup.)  I
> think either solution would fix the issue.
>
> -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8--
>
> From edd3fb9e8a16d5a7ccc98759e9397f386f0e82ca Mon Sep 17 00:00:00 2001
> From: Joe Lawrence <joe.lawrence@redhat.com>
> Date: Fri, 11 Jan 2019 10:25:26 -0500
> Subject: [PATCH] powerpc/livepatch: relax reliable stack tracer exception
>  check
>
> The ppc64le reliable stack tracer iterates over a given task's stack,
> verifying a set of conditions to determine whether the trace is
> 'reliable'.  These checks include the presence of any exception frames.
>
> We should be careful when inspecting the bottom-most stack frame (the
> first to be unwound), particularly for scheduled-out tasks.  As Nicolai
> Stange explains, "If I'm reading the code in _switch() correctly, the
> first frame is completely uninitialized except for the pointer back to
> the caller's stack frame."  If a previous do_IRQ() invocation, for
> example, has left a residual exception-marker on the first frame, the
> stack tracer would incorrectly report this task's trace as unreliable.
>

FWIW, it's not been do_IRQ() who wrote the exception marker, but it's
caller hardware_interrupt_common(), more specifically the
EXCEPTION_PROLOG_COMMON_3 part therof.


> save_stack_trace_tsk_reliable() already skips the first frame when
> verifying the saved Link Register.  It should do the same when looking
> for the STACK_FRAME_REGS_MARKER.  The task it is unwinding will be
> either 'current', in which case the tracer will have never been called
> from an exception path, or the task will be inactive and its first
> frame's contents will be uninitialized (aside from backchain pointer).

I thought about this a little more and can't see anything that would
prevent higher, i.e. non-_switch() frames to also alias with prior
exception frames. That STACK_FRAME_REGS_MARKER is written to a stack
frame's "parameter area" and most functions probably don't initialize
this either. So, AFAICS, higher stack frames could potentially be
affected by the very same problem.

I think the best solution would be to clear the STACK_FRAME_REGS_MARKER
upon exception return. I have a patch ready for that and will post it
after it has passed some basic testing -- hopefully later this day.

That being said, I still think that your patch should also get applied
in some form -- looking at unitialized memory is just not a good thing
to do.


>
> Fixes: df78d3f61480 ("powerpc/livepatch: Implement reliable stack tracing=
 for the consistency model")
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> ---
>  arch/powerpc/kernel/stacktrace.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stack=
trace.c
> index e2c50b55138f..0793e75c45a6 100644
> --- a/arch/powerpc/kernel/stacktrace.c
> +++ b/arch/powerpc/kernel/stacktrace.c
> @@ -84,6 +84,12 @@ save_stack_trace_regs(struct pt_regs *regs, struct sta=
ck_trace *trace)
>  EXPORT_SYMBOL_GPL(save_stack_trace_regs);
>=20=20
>  #ifdef CONFIG_HAVE_RELIABLE_STACKTRACE
> +/*
> + * This function returns an error if it detects any unreliable features =
of the
> + * stack.  Otherwise it guarantees that the stack trace is reliable.
> + *
> + * If the task is not 'current', the caller *must* ensure the task is in=
active.
> + */
>  int
>  save_stack_trace_tsk_reliable(struct task_struct *tsk,
>  				struct stack_trace *trace)
> @@ -143,7 +149,7 @@ save_stack_trace_tsk_reliable(struct task_struct *tsk,
>  			return 1;
>=20=20
>  		/* Mark stacktraces with exception frames as unreliable. */
> -		if (sp <=3D stack_end - STACK_INT_FRAME_SIZE &&
> +		if (!firstframe && sp <=3D stack_end - STACK_INT_FRAME_SIZE &&
>  		    stack[STACK_FRAME_MARKER] =3D=3D STACK_FRAME_REGS_MARKER) {
>  			return 1;
>  		}

I would perhaps not limit this to the STACK_FRAME_REGS_MARKER, but also
not emit the ip obtained from the first frame into the resulting trace.

I.e., how about moving all the sp/newsp handling to the beginning of the
loop and doing an 'if (firstframe) continue;' right after that?

Thanks,

Nicolai


--=20
SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton,
HRB 21284 (AG N=C3=BCrnberg)
