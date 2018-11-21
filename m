Return-Path: <SRS0=wfsy=OA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D9FC43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 18:34:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94E91206BB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 18:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E91206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 430WSj57DkzF368
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 05:34:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.160.195; helo=mail-qt1-f195.google.com;
 envelope-from=breno.debian@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
 [209.85.160.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 430WQQ5jhtzF1yF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Nov 2018 05:32:30 +1100 (AEDT)
Received: by mail-qt1-f195.google.com with SMTP id r14so4897467qtp.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2018 10:32:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fACaq/NlDAWY1jKTFv4yBuUuN44FB7grmLgS0QFE2ME=;
 b=blHICqY6elyK6pJWFKs1ZNFOyPkud3op/rKvehN6aDt78Qw7iiYuQZzeyZ4qzWN2Bk
 iIz6jG0/ZLN3zMmrv6gwrJFdXvkXFH2EJcLo9mLYEEnIfFnHcLBafnkY2gWCLO5o+/RF
 3jUZgtIQGHByYqd0sLlZmNmIz6yt1vRVewv9GMj9A8yG10blTmEzZ4IDdWf079UinrZg
 OFfRIEkcyJLUbGwVAWCSea/Gkco6Jgg+Ld2AhTdOJAeW7HtyK/odfmbyqIT+ZndUM71L
 IeR2WVgeuri9uKxnwnbjmjDcF6t1MHkYEFlWOLJ/X+s5ctkuem8CVolMsHawGdloM43P
 0Rnw==
X-Gm-Message-State: AGRZ1gIxVDneaO1sAivU046IwOWdYbgvquoLkNPBdJxb1prWzqhnwCra
 pl2LR33x3mZtqSntGHh2Io4=
X-Google-Smtp-Source: AJdET5fmBwhVSOGdpfUyW4vhZP3Qhy0zB7ofhZayDZcVlFKCQ7airvDVLP7Juu/vrMZPjru1/d1cgw==
X-Received: by 2002:ac8:5314:: with SMTP id t20mr6869197qtn.328.1542825148864; 
 Wed, 21 Nov 2018 10:32:28 -0800 (PST)
Received: from [9.18.239.97] ([32.104.18.243])
 by smtp.gmail.com with ESMTPSA id 20sm27835042qtp.54.2018.11.21.10.32.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 21 Nov 2018 10:32:28 -0800 (PST)
Subject: Re: [PATCH] powerpc/tm: Set MSR[TS] just prior to recheckpoint
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <1542631494-10344-1-git-send-email-leitao@debian.org>
 <8736rw2g18.fsf@concordia.ellerman.id.au>
From: Breno Leitao <leitao@debian.org>
Message-ID: <bbd2ef02-e1f3-6b86-0d13-3c78ee2cc78d@debian.org>
Date: Wed, 21 Nov 2018 16:32:31 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <8736rw2g18.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: mikey@neuling.org, "v3.9+" <stable@vger.kernel.org>,
 gromero@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

hi Michael,

On 11/20/18 8:34 AM, Michael Ellerman wrote:
> Hi Breno,
> 
> Thanks for chasing this one down.
> 
> Breno Leitao <leitao@debian.org> writes:
> 
>> On a signal handler return, the user could set a context with MSR[TS] bits
>> set, and these bits would be copied to task regs->msr.
>>
>> At restore_tm_sigcontexts(), after current task regs->msr[TS] bits are set,
>> several __get_user() are called and then a recheckpoint is executed.
>>
>> This is a problem since a page fault (in kernel space) could happen when
>> calling __get_user(). If it happens, the process MSR[TS] bits were
>> already set, but recheckpoint was not executed, and SPRs are still invalid.
>>
>> The page fault can cause the current process to be de-scheduled, with
>> MSR[TS] active and without tm_recheckpoint() being called.  More
>> importantly, without TEXAR[FS] bit set also.
>>
>> Since TEXASR might not have the FS bit set, and when the process is
>> scheduled back, it will try to reclaim, which will be aborted because of
>> the CPU is not in the suspended state, and, then, recheckpoint. This
>> recheckpoint will restore thread->texasr into TEXASR SPR, which might be
>> zero, hitting a BUG_ON().
>>
>> 	[ 2181.457997] kernel BUG at arch/powerpc/kernel/tm.S:446!
> 
> As Mikey said, would be good to have at least the stack trace & NIP
> here, if not the full oops.

Ack!

>> This patch simply delays the MSR[TS] set, so, if there is any page fault in
>> the __get_user() section, it does not have regs->msr[TS] set, since the TM
>> structures are still invalid, thus avoiding doing TM operations for
>> in-kernel exceptions and possible process reschedule.
>>
>> With this patch, the MSR[TS] will only be set just before recheckpointing
>> and setting TEXASR[FS] = 1, thus avoiding an interrupt with TM registers in
>> invalid state.
> 
> To make this safe when PREEMPT is enabled we need to preempt_disable() /
> enable() around the setting of regs->msr and the recheckpoint.
> 
> That could also serve as nice documentation.
> 
> I guess the other question is whether it should be the job of
> tm_recheckpoint() to set regs->msr, given that it already hard disables
> interrupts.
> 
> eg. we'd set the TM flags in a local msr variable and pass the to
> tm_recheckpoint(), it would then assign that to regs->msr in the IRQ
> disabled section. Though there's many callers of tm_recheckpoint() that
> don't need that behaviour, so it would probably need to be factored out.

Right, that might be doable, but I am wondering if it isn't better to create
a new function that does it as below:

void tm_set_msr_and_recheckpoint(struct pt_regs *regs, u64 msr)
{
       preempt_disable();
       regs->msr = msr;
       tm_recheckpoint();
       preempt_enable();
}

I understand that preempt_disable() does a better work disabling preemption
compared to disabling IRQ. Also, it does not change the API just for this
very specific signal case.

>> It is not possible to move tm_recheckpoint to happen earlier, because it is
>> required to get the checkpointed registers from userspace, with
>> __get_user(), thus, the only way to avoid this undesired behavior is
>> delaying the MSR[TS] set, as done in this patch.
> 
> I think the root cause here is that we're copying into the live regs of
> current. That has obviously worked in the past, because the register
> state wasn't used until we returned back to userspace. But that's no
> longer true with TM. And even so it's quite subtle. I also suspect some
> of our FP/VEC handling may not work correctly if we're scheduled part
> way through restoring the regs.

I got your point and I think we have a risk of corrupting the regs if MSR[TS]
is set and we do page_fault->recheckpoint/recheclaim in the middle of
__get_user() chunks.

> What might work better is if we copy all the regs into temporary space
> and then with interrupts disabled we copy them into the task. That way
> we should never be scheduled with a half-populated set of regs.

Yes, that seems to be the best strategy, and I might be interested in working
on it.

> That's obviously a much bigger patch though and something we'll have to
> do later.
> 
>> Fixes: 87b4e5393af7 ("powerpc/tm: Fix return of active 64bit signals")
>> Cc: stable@vger.kernel.org (v3.9+)
>> Signed-off-by: Breno Leitao <leitao@debian.org>
>> ---
>>  arch/powerpc/kernel/signal_64.c | 29 +++++++++++++++--------------
>>  1 file changed, 15 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
>> index 83d51bf586c7..15b153bdd826 100644
>> --- a/arch/powerpc/kernel/signal_64.c
>> +++ b/arch/powerpc/kernel/signal_64.c
>> @@ -467,20 +467,6 @@ static long restore_tm_sigcontexts(struct task_struct *tsk,
>>  	if (MSR_TM_RESV(msr))
>>  		return -EINVAL;
>>  
>> -	/* pull in MSR TS bits from user context */
>> -	regs->msr = (regs->msr & ~MSR_TS_MASK) | (msr & MSR_TS_MASK);
>> -
>> -	/*
>> -	 * Ensure that TM is enabled in regs->msr before we leave the signal
>> -	 * handler. It could be the case that (a) user disabled the TM bit
>> -	 * through the manipulation of the MSR bits in uc_mcontext or (b) the
>> -	 * TM bit was disabled because a sufficient number of context switches
>> -	 * happened whilst in the signal handler and load_tm overflowed,
>> -	 * disabling the TM bit. In either case we can end up with an illegal
>> -	 * TM state leading to a TM Bad Thing when we return to userspace.
>> -	 */
>> -	regs->msr |= MSR_TM;
>> -
>>  	/* pull in MSR LE from user context */
>>  	regs->msr = (regs->msr & ~MSR_LE) | (msr & MSR_LE);
>>  
>> @@ -572,6 +558,21 @@ static long restore_tm_sigcontexts(struct task_struct *tsk,
>>  	tm_enable();
>>  	/* Make sure the transaction is marked as failed */
>>  	tsk->thread.tm_texasr |= TEXASR_FS;
>> +
> 
> 	preempt_disable();
> 
>> +	/* pull in MSR TS bits from user context */
>> +	regs->msr = (regs->msr & ~MSR_TS_MASK) | (msr & MSR_TS_MASK);
>> +
>> +	/*
>> +	 * Ensure that TM is enabled in regs->msr before we leave the signal
>> +	 * handler. It could be the case that (a) user disabled the TM bit
>> +	 * through the manipulation of the MSR bits in uc_mcontext or (b) the
>> +	 * TM bit was disabled because a sufficient number of context switches
>> +	 * happened whilst in the signal handler and load_tm overflowed,
>> +	 * disabling the TM bit. In either case we can end up with an illegal
>> +	 * TM state leading to a TM Bad Thing when we return to userspace.
>> +	 */
>> +	regs->msr |= MSR_TM;
>> +
>>  	/* This loads the checkpointed FP/VEC state, if used */
>>  	tm_recheckpoint(&tsk->thread);
>>
> 	preempt_enable();
> 
> Although looking at the code that follows, it probably won't cope with
> being preempted either. So the preempt_enable() should probably go at
> the end of the function.

Why? I confess I do not understand the preempt mechanism a lot. Does a
preemption save/restore FP and vector states when it is preempted?

What is the code/IRQ that is executed when there is a preemption? I am
wondering if a preempt happens because the  Decrementer (0x900) IRQ  happens
and a syscall is being executed, thus, saving the whole context and then
restoring it. If my guess is correct, the IRQ might not save the FP/VEC
states, thus, your concern about ahving load_fp_state() after a preemption.

Let me paste the "patched" code here to help with the discussion:

        regs->msr |= MSR_TM;

        /* This loads the checkpointed FP/VEC state, if used */
        tm_recheckpoint(&tsk->thread);

        msr_check_and_set(msr & (MSR_FP | MSR_VEC));
        if (msr & MSR_FP) {
                load_fp_state(&tsk->thread.fp_state);
                regs->msr |= (MSR_FP | tsk->thread.fpexc_mode);
        }
        if (msr & MSR_VEC) {
                load_vr_state(&tsk->thread.vr_state);
                regs->msr |= MSR_VEC;
        }

Thanks
Breno
