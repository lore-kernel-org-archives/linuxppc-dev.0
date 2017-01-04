Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttlwt55Q2zDqHY
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 20:33:18 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v049TMnH139205
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jan 2017 04:33:16 -0500
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27r5kchs32-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Jan 2017 04:33:15 -0500
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 4 Jan 2017 15:03:12 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id A66AC3940067
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 15:03:09 +0530 (IST)
Received: from d28av07.in.ibm.com (d28av07.in.ibm.com [9.184.220.146])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v049X8to38862898
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jan 2017 15:03:08 +0530
Received: from d28av07.in.ibm.com (localhost [127.0.0.1])
 by d28av07.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v049X5uj003272
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jan 2017 15:03:08 +0530
Subject: Re: [PATCH v4 12/12] powerpc: Rename soft_enabled to
 soft_disabled_mask
To: Nicholas Piggin <npiggin@gmail.com>
References: <1482134828-18811-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1482134828-18811-13-git-send-email-maddy@linux.vnet.ibm.com>
 <20161220125841.6d74265b@roar.ozlabs.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Wed, 4 Jan 2017 15:03:03 +0530
MIME-Version: 1.0
In-Reply-To: <20161220125841.6d74265b@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <9660f66d-0e9c-846e-0d8d-77770f7427db@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 20 December 2016 08:28 AM, Nicholas Piggin wrote:
> On Mon, 19 Dec 2016 13:37:08 +0530
> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:
>
>> Rename the paca->soft_enabled to paca->soft_disabled_mask as
>> it is no more used as a flag for interrupt state.
>>
> This makes it much more readable, thanks. I have a question which
> isn't part of this patch but I just notice it now:
>
>
>> @@ -193,8 +193,8 @@ static inline bool arch_irqs_disabled(void)
>>   #define hard_irq_disable()	do {			\
>>   	u8 _was_enabled;				\
>>   	__hard_irq_disable();				\
>> -	_was_enabled = local_paca->soft_enabled;	\
>> -	local_paca->soft_enabled = IRQ_DISABLE_MASK_LINUX;\
>> +	_was_enabled = local_paca->soft_disabled_mask;	\
>> +	local_paca->soft_disabled_mask = IRQ_DISABLE_MASK_LINUX;\
>>   	local_paca->irq_happened |= PACA_IRQ_HARD_DIS;	\
>>   	if (_was_enabled == IRQ_DISABLE_MASK_NONE)	\
>>   		trace_hardirqs_off();			\
> trace_hardirqs_off() is the Linux interrupt disable, i.e., the MASK_LINUX
> bit. So I think the test should be:
>
> if (!(_was_enabled & IRQ_DISABLE_MASK_LINUX))
spot on. nice catch. Infact we should move this as part to
patch 5.

>
> After your rename it should be called _was_masked instead  I guess.

  Too obvious, my bad. Will change it.

> Also I suppose the new soft disable mask should include all interrupt
> bits, shouldn't it? It would be confusing to get the situation where
Yes That is correct. Condition should include pmu bits also.
Will fix it.

Maddy
> hard_irq_disable() strips the PMU bit off the mask. If you agree, then
> it would be good to add IRQ_DISABLE_MASK_ALL define where the bits are
> defined.
>
> Thanks,
> Nick
>
