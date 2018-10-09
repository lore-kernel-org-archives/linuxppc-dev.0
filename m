Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA72C64EAD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 12:03:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 315F920C0A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 12:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 315F920C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Twqf2XSJzF3Cy
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 23:03:42 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TwnL1LvxzDrP3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 23:01:42 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42Twn21d0Mz9ttFY;
 Tue,  9 Oct 2018 14:01:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id yfWdA3zIZAuR; Tue,  9 Oct 2018 14:01:26 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42Twn214h1z9ttCB;
 Tue,  9 Oct 2018 14:01:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9C4DD8B803;
 Tue,  9 Oct 2018 14:01:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 5dieokrgOn6t; Tue,  9 Oct 2018 14:01:37 +0200 (CEST)
Received: from PO15451 (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 326DE8B7FA;
 Tue,  9 Oct 2018 14:01:37 +0200 (CEST)
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
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <e4c9e983-db3e-ab50-c30b-9d538e202147@c-s.fr>
Date: Tue, 9 Oct 2018 14:01:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181009211650.042d428c@roar.ozlabs.ibm.com>
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



Le 09/10/2018 à 13:16, Nicholas Piggin a écrit :
> On Tue, 9 Oct 2018 09:36:18 +0000
> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> 
>> On 10/09/2018 05:30 AM, Nicholas Piggin wrote:
>>> On Tue, 9 Oct 2018 06:46:30 +0200
>>> Christophe LEROY <christophe.leroy@c-s.fr> wrote:
>>>    
>>>> Le 09/10/2018 à 06:32, Nicholas Piggin a écrit :
>>>>> On Mon, 8 Oct 2018 17:39:11 +0200
>>>>> Christophe LEROY <christophe.leroy@c-s.fr> wrote:
>>>>>       
>>>>>> Hi Nick,
>>>>>>
>>>>>> Le 19/07/2017 à 08:59, Nicholas Piggin a écrit :
>>>>>>> Use nmi_enter similarly to system reset interrupts. This uses NMI
>>>>>>> printk NMI buffers and turns off various debugging facilities that
>>>>>>> helps avoid tripping on ourselves or other CPUs.
>>>>>>>
>>>>>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>>>>>> ---
>>>>>>>      arch/powerpc/kernel/traps.c | 9 ++++++---
>>>>>>>      1 file changed, 6 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
>>>>>>> index 2849c4f50324..6d31f9d7c333 100644
>>>>>>> --- a/arch/powerpc/kernel/traps.c
>>>>>>> +++ b/arch/powerpc/kernel/traps.c
>>>>>>> @@ -789,8 +789,10 @@ int machine_check_generic(struct pt_regs *regs)
>>>>>>>      
>>>>>>>      void machine_check_exception(struct pt_regs *regs)
>>>>>>>      {
>>>>>>> -	enum ctx_state prev_state = exception_enter();
>>>>>>>      	int recover = 0;
>>>>>>> +	bool nested = in_nmi();
>>>>>>> +	if (!nested)
>>>>>>> +		nmi_enter();
>>>>>>
>>>>>> This alters preempt_count, then when die() is called
>>>>>> in_interrupt() returns true allthough the trap didn't happen in
>>>>>> interrupt, so oops_end() panics for "fatal exception in interrupt"
>>>>>> instead of gently sending SIGBUS the faulting app.
>>>>>
>>>>> Thanks for tracking that down.
>>>>>       
>>>>>> Any idea on how to fix this ?
>>>>>
>>>>> I would say we have to deliver the sigbus by hand.
>>>>>
>>>>>        if ((user_mode(regs)))
>>>>>            _exception(SIGBUS, regs, BUS_MCEERR_AR, regs->nip);
>>>>>        else
>>>>>            die("Machine check", regs, SIGBUS);
>>>>>       
>>>>
>>>> And what about all the other things done by 'die()' ?
>>>>
>>>> And what if it is a kernel thread ?
>>>>
>>>> In one of my boards, I have a kernel thread regularly checking the HW,
>>>> and if it gets a machine check I expect it to gently stop and the die
>>>> notification to be delivered to all registered notifiers.
>>>>
>>>> Until before this patch, it was working well.
>>>
>>> I guess the alternative is we could check regs->trap for machine
>>> check in the die test. Complication is having to account for MCE
>>> in an interrupt handler.
>>>
>>>          if (in_interrupt()) {
>>>                   if (!IS_MCHECK_EXC(regs) || (irq_count() - (NMI_OFFSET + HARDIRQ_OFFSET)))
>>>                       panic("Fatal exception in interrupt");
>>>          }
>>>
>>> Something like that might work for you? We needs a ppc64 macro for the
>>> MCE, and can probably add something like in_nmi_from_interrupt() for
>>> the second part of the test.
>>
>> Don't know, I'm away from home on business trip so I won't be able to
>> test anything before next week. However it looks more or less like a
>> hack, doesn't it ?
> 
> I thought it seemed okay (with the right functions added). Actually it
> could be a bit nicer to do this, then it works generally :
> 
>           if (in_interrupt()) {
>                    if (!in_nmi() || in_nmi_from_interrupt())
>                        panic("Fatal exception in interrupt");
>           }


Yes looks nice, but:
1/ what is in_nmi_from_interrupt() ? Is it (in_nmi() && (in_irq() || 
in_softirq()) ?
2/ what about in_nmi_from_nmi(), how do we detect that ?

Christophe

> 
>>
>> What about the following ?
> 
> Hmm, in some ways maybe it's nicer. One complication is I would like the
> same thing to be available for platform specific machine check
> handlers, so then you need to pass is_in_interrupt to them. Which you
> can do without any problem... But is it cleaner than the above?
> 
> I guess one advantage of yours is that a BUG somewhere in the NMI path
> will panic the system. Or is that a disadvantage?
> 
> Thanks,
> Nick
> 
> 
>>
>> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
>> index fd58749b4d6b..1f09033a5103 100644
>> --- a/arch/powerpc/kernel/traps.c
>> +++ b/arch/powerpc/kernel/traps.c
>> @@ -208,7 +208,7 @@ static unsigned long oops_begin(struct pt_regs *regs)
>>    NOKPROBE_SYMBOL(oops_begin);
>>
>>    static void oops_end(unsigned long flags, struct pt_regs *regs,
>> -			       int signr)
>> +		     int signr, bool is_in_interrupt)
>>    {
>>    	bust_spinlocks(0);
>>    	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
>> @@ -247,7 +247,7 @@ static void oops_end(unsigned long flags, struct
>> pt_regs *regs,
>>    		mdelay(MSEC_PER_SEC);
>>    	}
>>
>> -	if (in_interrupt())
>> +	if (is_in_interrupt)
>>    		panic("Fatal exception in interrupt");
>>    	if (panic_on_oops)
>>    		panic("Fatal exception");
>> @@ -288,7 +288,7 @@ static int __die(const char *str, struct pt_regs
>> *regs, long err)
>>    }
>>    NOKPROBE_SYMBOL(__die);
>>
>> -void die(const char *str, struct pt_regs *regs, long err)
>> +static void nmi_die(const char *str, struct pt_regs *regs, long err,
>> bool is_in_interrupt)
>>    {
>>    	unsigned long flags;
>>
>> @@ -303,7 +303,13 @@ void die(const char *str, struct pt_regs *regs,
>> long err)
>>    	flags = oops_begin(regs);
>>    	if (__die(str, regs, err))
>>    		err = 0;
>> -	oops_end(flags, regs, err);
>> +	oops_end(flags, regs, err, is_in_interrupt);
>> +}
>> +NOKPROBE_SYMBOL(nmi_die);
>> +
>> +void die(const char *str, struct pt_regs *regs, long err)
>> +{
>> +	nmi_die(str, regs, err, in_interrupt());
>>    }
>>    NOKPROBE_SYMBOL(die);
>>
>> @@ -737,6 +743,7 @@ int machine_check_generic(struct pt_regs *regs)
>>    void machine_check_exception(struct pt_regs *regs)
>>    {
>>    	int recover = 0;
>> +	bool is_in_interrupt = in_interrupt();
>>    	bool nested = in_nmi();
>>    	if (!nested)
>>    		nmi_enter();
>> @@ -765,7 +772,7 @@ void machine_check_exception(struct pt_regs *regs)
>>    	if (check_io_access(regs))
>>    		goto bail;
>>
>> -	die("Machine check", regs, SIGBUS);
>> +	nmi_die("Machine check", regs, SIGBUS, is_in_interrupt);
>>
>>    	/* Must die if the interrupt is not recoverable */
>>    	if (!(regs->msr & MSR_RI))
>>
>>
>> Thanks
>> Christophe
