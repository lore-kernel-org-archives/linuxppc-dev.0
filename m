Return-Path: <srs0=vy+b=4h=axtens.net=dja@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wGp7T6csHzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 May 2017 01:22:13 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wGp7T5mMWz8t6N
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 May 2017 01:22:13 +1000 (AEST)
Received: from mail-pg0-x232.google.com (mail-pg0-x232.google.com
 [IPv6:2607:f8b0:400e:c05::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wGp7S4ln4z9s0g
 for <linuxppc-dev@ozlabs.org>; Tue,  2 May 2017 01:22:12 +1000 (AEST)
Received: by mail-pg0-x232.google.com with SMTP id v1so46305261pgv.1
 for <linuxppc-dev@ozlabs.org>; Mon, 01 May 2017 08:22:12 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH v2] powerpc/book3s: mce: Move add_taint() later in virtual
 mode.
In-Reply-To: <87r30mtnc2.fsf@concordia.ellerman.id.au>
References: <149253349689.12722.1516352063236500616.stgit@jupiter.in.ibm.com>
 <874lxjbak1.fsf@possimpible.ozlabs.ibm.com>
 <87r30mtnc2.fsf@concordia.ellerman.id.au>
Date: Tue, 02 May 2017 01:22:06 +1000
Message-ID: <87y3ug1u1t.fsf@possimpible.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> Daniel Axtens <dja@axtens.net> writes:
>>> diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
>>> index a1475e6..b23b323 100644
>>> --- a/arch/powerpc/kernel/mce.c
>>> +++ b/arch/powerpc/kernel/mce.c
>>> @@ -221,6 +221,8 @@ static void machine_check_process_queued_event(struct irq_work *work)
>>>  {
>>>  	int index;
>>>  
>>> +	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
>>> +
>> This bit makes sense...
>>
>>> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
>>> index ff365f9..af97e81 100644
>>> --- a/arch/powerpc/kernel/traps.c
>>> +++ b/arch/powerpc/kernel/traps.c
>>> @@ -741,6 +739,8 @@ void machine_check_exception(struct pt_regs *regs)
>>>  
>>>  	__this_cpu_inc(irq_stat.mce_exceptions);
>>>  
>>> +	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
>>> +
>>
>> But this bit I'm not sure about.
>>
>> Isn't machine_check_exception called from asm in
>> kernel/exceptions-64s.S? As in, it's called really early/in real mode?
>
> It is called from there, in asm, but not from real mode AFAICS.
>
> There's a call from machine_check_common(), we're already in virtual
> mode there.
>
> The other call is from unrecover_mce(), and both places that call that
> do so via rfid, using PACAKMSR, which should turn on virtual mode.
>
>
> But none of that really matters. The fundamental issue here is we can't
> recursively call OPAL, that's what matters.

Ah right, yes. Every time I think I understand MCEs, it is made plain to
me that I do not. I have been trying to compose a coherent reply for
over an hour and every time I think I have got somewhere I find a
massive issue in my understanding. But here goes!

> So if we were in OPAL and take an MCE, then we must not call OPAL again
> from the MCE handler.

If I'm correctly understanding the code, this includes the non-early
handlers (ppc_md.machine_check_exception) as well as the early handlers
(ppc_md.machine_check_early). Is that right?

So the only place we're safe to do prints is in the 'bottom half' on the
other side of the work queue?

> This fixes one case where we know that can happen, but AFAICS we are not
> protected in general from it.
>
> For example if we take an MCE in OPAL, decide it's not recoverable and
> go to unrecover_mce(), that will call machine_check_exception() which
> can then call OPAL via printk.

(Assuming I understand the code, we probably won't get that far because
we'll attempt an opal reboot and a panic in opal_machine_check - but
carrying on...)

I think I see what you mean: even without any tainting, panic() will
printk(), which will take us back to OPAL.

I *think* we can fix this with a tweak to opal_machine_check. It pulls
the event off the work-queue and prints it, but I now think it
shouldn't; it just try to recover. If it can't recover it should proceed
to do the opal_cec_reboot2. That might fail on a BMC system or an early
firmware level, leaving the machine hosed, but it was about to panic
anyway.

We can then leave popping the event and printing it to the bottom
half/work queue.

... assuming I have understood it correctly. Thoughts?

> Or maybe there's a check in there somewhere that makes it OK, but it's
> not clear to me.

More immediately, what I'm confused by (amongst many other things!) -
and maybe Mahesh you can enlighten me - is this: what situation is
caught by this add_taint() in machine_check_exception? If we're about to
die, tainting the kernel is probably not the most useful thing to do. As
I understand it, if we're not about to die, we'll print out the taint in
the 'bottom half'/work queue side. Is this right?

Perhaps we can slightly shrink the window for disaster and fix the hard
bits later :P

Regards,
Daniel
