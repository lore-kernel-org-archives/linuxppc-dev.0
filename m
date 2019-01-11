Return-Path: <SRS0=2HDf=PT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2477EC43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 01:09:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E2BE206B7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 01:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E2BE206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bPsj1yRKzDqxG
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 12:09:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=joe.lawrence@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bPqy4sBBzDqwJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 12:08:13 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6DE5C9F75D;
 Fri, 11 Jan 2019 01:08:11 +0000 (UTC)
Received: from redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C4C760A35;
 Fri, 11 Jan 2019 01:08:10 +0000 (UTC)
Date: Thu, 10 Jan 2019 20:08:08 -0500
From: Joe Lawrence <joe.lawrence@redhat.com>
To: Nicolai Stange <nstange@suse.de>
Subject: Re: ppc64le reliable stack unwinder and scheduled tasks
Message-ID: <20190111010808.GA17858@redhat.com>
References: <7f468285-b149-37e2-e782-c9e538b997a9@redhat.com>
 <87bm4ocbbt.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bm4ocbbt.fsf@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 11 Jan 2019 01:08:11 +0000 (UTC)
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

On Fri, Jan 11, 2019 at 01:00:38AM +0100, Nicolai Stange wrote:
> Hi Joe,
> 
> Joe Lawrence <joe.lawrence@redhat.com> writes:
> 
> > tl;dr: On ppc64le, what is top-most stack frame for scheduled tasks
> >        about?
> 
> If I'm reading the code in _switch() correctly, the first frame is
> completely uninitialized except for the pointer back to the caller's
> stack frame.
> 
> For completeness: _switch() saves the return address, i.e. the link
> register into its parent's stack frame, as is mandated by the ABI and
> consistent with your findings below: it's always the second stack frame
> where the return address into __switch_to() is kept.
>

Hi Nicolai,

Good, that makes a lot of sense.  I couldn't find any reference
explaining the contents of frame 0, only unwinding code here and there
(as in crash-utility) that stepped over it.
 
> <snip>
> 
> >
> >
> > Example 1 (RHEL-7)
> > ==================
> >
> > crash> struct task_struct.thread c00000022fd015c0 | grep ksp
> >     ksp = 0xc0000000288af9c0
> >
> > crash> rd 0xc0000000288af9c0 -e 0xc0000000288b0000
> >
> >  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> >
> > sp[0]:
> >
> > c0000000288af9c0:  c0000000288afb90 0000000000dd0000   ...(............
> > c0000000288af9d0:  c000000000002a94 c000000001c60a00   .*..............
> >
> >         crash> sym c000000000002a94
> >         c000000000002a94 (T) hardware_interrupt_common+0x114
> 
> So that c000000000002a94 certainly wasn't stored by _switch(). I think
> what might have happened is that the switching frame aliased with some
> prior interrupt frame as setup by hardware_interrupt_common().
> 
> The interrupt and switching frames seem to share a common layout as far
> as the lower STACK_FRAME_OVERHEAD + sizeof(struct pt_regs) bytes are
> concerned.
> 
> That address into hardware_interrupt_common() could have been written by
> the do_IRQ() called from there.
> 

That was my initial theory, but then when I saw an ordinary scheduled
task with a similarly strange frame 0, I thought that _switch() might
have been doing something clever (or not).  But according your earlier
explanation, it would line up that these values may be inherited from
do_IRQ() or the like.

> 
> > c0000000288af9e0:  c000000001c60a80 0000000000000000   ................
> > c0000000288af9f0:  c0000000288afbc0 0000000000dd0000   ...(............
> > c0000000288afa00:  c0000000014322e0 c000000001c60a00   ."C.............
> > c0000000288afa10:  c0000002303ae380 c0000002303ae380   ..:0......:0....
> > c0000000288afa20:  7265677368657265 0000000000002200   erehsger."......
> >
> >         Uh-oh...
> >
> >         /* Mark stacktraces with exception frames as unreliable. */
> >         stack[STACK_FRAME_MARKER] == STACK_FRAME_REGS_MARKER
> 
> 
> Aliasing of the switching stack frame with some prior interrupt stack
> frame would explain why that STACK_FRAME_REGS_MARKER is still found on
> the stack, i.e. it's a leftover.
> 
> For testing, could you try whether clearing the word at STACK_FRAME_MARKER
> from _switch() helps?
> 
> I.e. something like (completely untested):

I'll kick off some builds tonight and try to get tests lined up
tomorrow.  Unfortunately these take a bit of time to run setup, schedule
and complete, so perhaps by next week.

> 
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index 435927f549c4..b747d0647ec4 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -596,6 +596,10 @@ _GLOBAL(_switch)
>  	SAVE_8GPRS(14, r1)
>  	SAVE_10GPRS(22, r1)
>  	std	r0,_NIP(r1)	/* Return to switch caller */
> +
> +	li	r23,0
> +	std	r23,96(r1)	/* 96 == STACK_FRAME_MARKER * sizeof(long) */
> +
>  	mfcr	r23
>  	std	r23,_CCR(r1)
>  	std	r1,KSP(r3)	/* Set old stack pointer */
> 
> 

This may be sufficient to avoid the condition, but if the contents of
frame 0 are truely uninitialized (not to be trusted), should the
unwinder be even looking at that frame (for STACK_FRAMES_REGS_MARKER),
aside from the LR and other stack size geometry sanity checks?

> <snap>
> 
> >
> > save_stack_trace_tsk_reliable
> > =============================
> >
> > arch/powerpc/kernel/stacktrace.c :: save_stack_trace_tsk_reliable() does
> > take into account the first stackframe, but only to verify that the link
> > register is indeed pointing at kernel code address.
> 
> It's actually the other way around:
> 
> 	if (!firstframe && !__kernel_text_address(ip))
> 		return 1;
> 
> 
> So the address gets sanitized only if it's _not_ coming from the first
> frame.

Yup, that's right, I had it backwards.

Thanks!

-- Joe
