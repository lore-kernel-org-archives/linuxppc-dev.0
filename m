Return-Path: <SRS0=4kvs=MX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7373C32788
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 14:25:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41A1D204FD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 14:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A1D204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42WCtD5jWdzF3L4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 01:25:24 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42WCr63GrczF1F0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 01:23:34 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42WCqs3dzzz9ttn0;
 Thu, 11 Oct 2018 16:23:21 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id sJaHp8wQ6q0Q; Thu, 11 Oct 2018 16:23:21 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42WCqs33TSz9ttBX;
 Thu, 11 Oct 2018 16:23:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9E0008B881;
 Thu, 11 Oct 2018 16:23:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id oqLQZIft6Xuf; Thu, 11 Oct 2018 16:23:23 +0200 (CEST)
Received: from PO15451 (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 487858B86C;
 Thu, 11 Oct 2018 16:23:23 +0200 (CEST)
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
 <e4c9e983-db3e-ab50-c30b-9d538e202147@c-s.fr>
 <20181009221446.33b926e3@roar.ozlabs.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <8281d664-6c4b-3476-ac2d-9fc9ba2c7e03@c-s.fr>
Date: Thu, 11 Oct 2018 16:23:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181009221446.33b926e3@roar.ozlabs.ibm.com>
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



Le 09/10/2018 à 14:14, Nicholas Piggin a écrit :
> On Tue, 9 Oct 2018 14:01:37 +0200
> Christophe LEROY <christophe.leroy@c-s.fr> wrote:
> 
>> Le 09/10/2018 à 13:16, Nicholas Piggin a écrit :
>>> On Tue, 9 Oct 2018 09:36:18 +0000
>>> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>>>    
>>>> On 10/09/2018 05:30 AM, Nicholas Piggin wrote:
>>>>> On Tue, 9 Oct 2018 06:46:30 +0200
>>>>> Christophe LEROY <christophe.leroy@c-s.fr> wrote:
>>>>>       
>>>>>> Le 09/10/2018 à 06:32, Nicholas Piggin a écrit :
>>>>>>> On Mon, 8 Oct 2018 17:39:11 +0200
>>>>>>> Christophe LEROY <christophe.leroy@c-s.fr> wrote:
>>>>>>>          
>>>>>>>> Hi Nick,
>>>>>>>>
>>>>>>>> Le 19/07/2017 à 08:59, Nicholas Piggin a écrit :
>>>>>>>>> Use nmi_enter similarly to system reset interrupts. This uses NMI
>>>>>>>>> printk NMI buffers and turns off various debugging facilities that
>>>>>>>>> helps avoid tripping on ourselves or other CPUs.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>>>>>>>> ---
>>>>>>>>>       arch/powerpc/kernel/traps.c | 9 ++++++---
>>>>>>>>>       1 file changed, 6 insertions(+), 3 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
>>>>>>>>> index 2849c4f50324..6d31f9d7c333 100644
>>>>>>>>> --- a/arch/powerpc/kernel/traps.c
>>>>>>>>> +++ b/arch/powerpc/kernel/traps.c
>>>>>>>>> @@ -789,8 +789,10 @@ int machine_check_generic(struct pt_regs *regs)
>>>>>>>>>       
>>>>>>>>>       void machine_check_exception(struct pt_regs *regs)
>>>>>>>>>       {
>>>>>>>>> -	enum ctx_state prev_state = exception_enter();
>>>>>>>>>       	int recover = 0;
>>>>>>>>> +	bool nested = in_nmi();
>>>>>>>>> +	if (!nested)
>>>>>>>>> +		nmi_enter();
>>>>>>>>
>>>>>>>> This alters preempt_count, then when die() is called
>>>>>>>> in_interrupt() returns true allthough the trap didn't happen in
>>>>>>>> interrupt, so oops_end() panics for "fatal exception in interrupt"
>>>>>>>> instead of gently sending SIGBUS the faulting app.
>>>>>>>
>>>>>>> Thanks for tracking that down.
>>>>>>>          
>>>>>>>> Any idea on how to fix this ?
>>>>>>>
>>>>>>> I would say we have to deliver the sigbus by hand.
>>>>>>>
>>>>>>>         if ((user_mode(regs)))
>>>>>>>             _exception(SIGBUS, regs, BUS_MCEERR_AR, regs->nip);
>>>>>>>         else
>>>>>>>             die("Machine check", regs, SIGBUS);
>>>>>>>          
>>>>>>
>>>>>> And what about all the other things done by 'die()' ?
>>>>>>
>>>>>> And what if it is a kernel thread ?
>>>>>>
>>>>>> In one of my boards, I have a kernel thread regularly checking the HW,
>>>>>> and if it gets a machine check I expect it to gently stop and the die
>>>>>> notification to be delivered to all registered notifiers.
>>>>>>
>>>>>> Until before this patch, it was working well.
>>>>>
>>>>> I guess the alternative is we could check regs->trap for machine
>>>>> check in the die test. Complication is having to account for MCE
>>>>> in an interrupt handler.
>>>>>
>>>>>           if (in_interrupt()) {
>>>>>                    if (!IS_MCHECK_EXC(regs) || (irq_count() - (NMI_OFFSET + HARDIRQ_OFFSET)))
>>>>>                        panic("Fatal exception in interrupt");
>>>>>           }
>>>>>
>>>>> Something like that might work for you? We needs a ppc64 macro for the
>>>>> MCE, and can probably add something like in_nmi_from_interrupt() for
>>>>> the second part of the test.
>>>>
>>>> Don't know, I'm away from home on business trip so I won't be able to
>>>> test anything before next week. However it looks more or less like a
>>>> hack, doesn't it ?
>>>
>>> I thought it seemed okay (with the right functions added). Actually it
>>> could be a bit nicer to do this, then it works generally :
>>>
>>>            if (in_interrupt()) {
>>>                     if (!in_nmi() || in_nmi_from_interrupt())
>>>                         panic("Fatal exception in interrupt");
>>>            }
>>
>>
>> Yes looks nice, but:
>> 1/ what is in_nmi_from_interrupt() ? Is it (in_nmi() && (in_irq() ||
>> in_softirq()) ?
> 
>    return (irq_count() - (NMI_OFFSET + HARDIRQ_OFFSET))) != 0;
> 
> (basically just in_interrupt() with the nmi_enter undone)
> 
>> 2/ what about in_nmi_from_nmi(), how do we detect that ?
> 
> Oh good point, I'm not sure. I guess we could irq_enter() in the
> nested case, I think that would make in_nmi_from_interrupt()
> return true.

Yes we could, but I find it ugly.

Don't you think it looks less strange to just check in_interrupt() 
before calling nmi_enter()  ?

Christophe
