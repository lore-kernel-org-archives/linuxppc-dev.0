Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A52C71122
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 08:58:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 675EF2098A
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 08:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 675EF2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42XJWn31lNzF3KF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 19:58:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XJTm5zV2zF3Df
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 19:56:28 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42XJTc04HRz9ttFk;
 Sat, 13 Oct 2018 10:56:20 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id EpsjHLgGVGwk; Sat, 13 Oct 2018 10:56:19 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42XJTb6MW3z9ttFY;
 Sat, 13 Oct 2018 10:56:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 349C38B782;
 Sat, 13 Oct 2018 10:56:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id wula8U0IY4ln; Sat, 13 Oct 2018 10:56:25 +0200 (CEST)
Received: from PO15451 (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id BF9C28B74B;
 Sat, 13 Oct 2018 10:56:24 +0200 (CEST)
Subject: Re: [PATCH v2 3/3] powerpc: machine check interrupt is a non-maskable
 interrupt
To: Nicholas Piggin <npiggin@gmail.com>
References: <20170719065912.19183-1-npiggin@gmail.com>
 <20170719065912.19183-4-npiggin@gmail.com>
 <30487984-752a-960d-6aae-6571c55c7ba5@c-s.fr>
 <20181009143241.026f3e7f@roar.ozlabs.ibm.com>
 <ccf61fc2-1f2e-7b67-c481-fa4c00a65aae@c-s.fr>
 <20181009153058.2564e7a1@roar.ozlabs.ibm.com>
 <0539727f-8420-3176-30b5-f4a6a1ccd4a4@c-s.fr>
 <20181009211650.042d428c@roar.ozlabs.ibm.com>
 <9f0cbf48-d278-08bf-cb32-8b9608768025@c-s.fr>
 <bb79aa53-8924-b334-93d6-fc907c8880e1@c-s.fr>
 <20181013184815.6a80d196@roar.ozlabs.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <7f8486d4-fe7e-59f0-371d-af2d9ab83bca@c-s.fr>
Date: Sat, 13 Oct 2018 10:56:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181013184815.6a80d196@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
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
Cc: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 13/10/2018 à 10:48, Nicholas Piggin a écrit :
> On Sat, 13 Oct 2018 08:29:48 +0000
> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> 
>> On 10/11/2018 02:31 PM, Christophe LEROY wrote:
>>>
>>>
>>> Le 09/10/2018 à 13:16, Nicholas Piggin a écrit :
>>>> On Tue, 9 Oct 2018 09:36:18 +0000
>>>> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>>>>   
>>>>> On 10/09/2018 05:30 AM, Nicholas Piggin wrote:
>>>>>> On Tue, 9 Oct 2018 06:46:30 +0200
>>>>>> Christophe LEROY <christophe.leroy@c-s.fr> wrote:
>>>>>>> Le 09/10/2018 à 06:32, Nicholas Piggin a écrit :
>>>>>>>> On Mon, 8 Oct 2018 17:39:11 +0200
>>>>>>>> Christophe LEROY <christophe.leroy@c-s.fr> wrote:
>>>>>>>>> Hi Nick,
>>>>>>>>>
>>>>>>>>> Le 19/07/2017 à 08:59, Nicholas Piggin a écrit :
>>>>>>>>>> Use nmi_enter similarly to system reset interrupts. This uses NMI
>>>>>>>>>> printk NMI buffers and turns off various debugging facilities that
>>>>>>>>>> helps avoid tripping on ourselves or other CPUs.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>>>>>>>>> ---
>>>>>>>>>>       arch/powerpc/kernel/traps.c | 9 ++++++---
>>>>>>>>>>       1 file changed, 6 insertions(+), 3 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/arch/powerpc/kernel/traps.c
>>>>>>>>>> b/arch/powerpc/kernel/traps.c
>>>>>>>>>> index 2849c4f50324..6d31f9d7c333 100644
>>>>>>>>>> --- a/arch/powerpc/kernel/traps.c
>>>>>>>>>> +++ b/arch/powerpc/kernel/traps.c
>>>>>>>>>> @@ -789,8 +789,10 @@ int machine_check_generic(struct pt_regs
>>>>>>>>>> *regs)
>>>>>>>>>>       void machine_check_exception(struct pt_regs *regs)
>>>>>>>>>>       {
>>>>>>>>>> -    enum ctx_state prev_state = exception_enter();
>>>>>>>>>>           int recover = 0;
>>>>>>>>>> +    bool nested = in_nmi();
>>>>>>>>>> +    if (!nested)
>>>>>>>>>> +        nmi_enter();
>>>>>>>>>
>>>>>>>>> This alters preempt_count, then when die() is called
>>>>>>>>> in_interrupt() returns true allthough the trap didn't happen in
>>>>>>>>> interrupt, so oops_end() panics for "fatal exception in interrupt"
>>>>>>>>> instead of gently sending SIGBUS the faulting app.
>>>>>>>>
>>>>>>>> Thanks for tracking that down.
>>>>>>>>> Any idea on how to fix this ?
>>>>>>>>
>>>>>>>> I would say we have to deliver the sigbus by hand.
>>>>>>>>
>>>>>>>>         if ((user_mode(regs)))
>>>>>>>>             _exception(SIGBUS, regs, BUS_MCEERR_AR, regs->nip);
>>>>>>>>         else
>>>>>>>>             die("Machine check", regs, SIGBUS);
>>>>>>>
>>>>>>> And what about all the other things done by 'die()' ?
>>>>>>>
>>>>>>> And what if it is a kernel thread ?
>>>>>>>
>>>>>>> In one of my boards, I have a kernel thread regularly checking the HW,
>>>>>>> and if it gets a machine check I expect it to gently stop and the die
>>>>>>> notification to be delivered to all registered notifiers.
>>>>>>>
>>>>>>> Until before this patch, it was working well.
>>>>>>
>>>>>> I guess the alternative is we could check regs->trap for machine
>>>>>> check in the die test. Complication is having to account for MCE
>>>>>> in an interrupt handler.
>>>>>>
>>>>>>           if (in_interrupt()) {
>>>>>>                    if (!IS_MCHECK_EXC(regs) || (irq_count() -
>>>>>> (NMI_OFFSET + HARDIRQ_OFFSET)))
>>>>>>                        panic("Fatal exception in interrupt");
>>>>>>           }
>>>>>>
>>>>>> Something like that might work for you? We needs a ppc64 macro for the
>>>>>> MCE, and can probably add something like in_nmi_from_interrupt() for
>>>>>> the second part of the test.
>>>>>
>>>>> Don't know, I'm away from home on business trip so I won't be able to
>>>>> test anything before next week. However it looks more or less like a
>>>>> hack, doesn't it ?
>>>>
>>>> I thought it seemed okay (with the right functions added). Actually it
>>>> could be a bit nicer to do this, then it works generally :
>>>>
>>>>            if (in_interrupt()) {
>>>>                     if (!in_nmi() || in_nmi_from_interrupt())
>>>>                         panic("Fatal exception in interrupt");
>>>>            }
>>>>   
>>>>>
>>>>> What about the following ?
>>>>
>>>> Hmm, in some ways maybe it's nicer. One complication is I would like the
>>>> same thing to be available for platform specific machine check
>>>> handlers, so then you need to pass is_in_interrupt to them. Which you
>>>> can do without any problem... But is it cleaner than the above?
>>>
>>> For me it looks cleaner than twiddle the preempt_count depending on
>>> whether we were or not already in nmi() .
>>>
>>> Let's draft something and see what it looks like.
>>
>> Ok, finaly I went to your solution, see below, as it avoids having to
>> modify all subarch and platform specific machine check handlers.
>>
>> Unfortunately it doesn't solves the issue, it only delays it:
>>
>> oops_end() calls do_exit(), which has the following test:
>>
>> 	if (unlikely(in_interrupt()))
>> 		panic("Aiee, killing interrupt handler!");
>>
>>
>> So at the time being I still have no idea how to fix that, have you ?
> 
> Huh, I'm not sure. x86's MCE handling looks like it does this:
> 
>                  /*
>                   * We might have interrupted pretty much anything.  In
>                   * fact, if we're a machine check, we can even interrupt
>                   * NMI processing.  We don't want in_nmi() to return true,
>                   * but we need to notify RCU.
>                   */
>                  rcu_nmi_enter();
> 
> But I don't see why they don't want the full NMI treatment there. I
> thought the whole point was to do everything so you would get e.g.,
> the NMI-safe printk and so on.
> 
> The reason the in_interrupt checks work below is because the synchronous
> trap handlers e.g., for BUG do not enter interrupt context so the
> question is about they context they interrupted. Maybe the right way to
> go is nmi_exit just before deciding to oops.

Yes I arrived at the same conclusion. I tested it just now and it works 
for me. Thanks.

Christophe

> 
> Perhaps we could ask lkml.
> 
> Thanks,
> Nick
> 
