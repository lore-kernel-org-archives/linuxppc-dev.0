Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wSNGt1tB0zDqQ8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 15:31:49 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4H5SYQY053535
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 01:31:43 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2agbrk32xk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 01:31:43 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 17 May 2017 15:31:40 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4H5VUVX39977172
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 15:31:38 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4H5V52j007372
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 15:31:05 +1000
Received: from [9.124.31.42] (sriharisrinidhi.in.ibm.com [9.124.31.42])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 v4H5V4x0005223
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 15:31:04 +1000
Subject: Re: [PATCH 2/3] powerpc/mm: Rename find_linux_pte_or_hugepte
To: linuxppc-dev@lists.ozlabs.org
References: <1494926782-25700-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1494926782-25700-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1494933772.21847.48.camel@kernel.crashing.org>
 <87wp9g17tt.fsf@skywalker.in.ibm.com>
 <1494997069.3092.5.camel@kernel.crashing.org>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Wed, 17 May 2017 11:00:40 +0530
MIME-Version: 1.0
In-Reply-To: <1494997069.3092.5.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <d87fa489-38f3-5b13-7267-92e7c4fee09e@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 17 May 2017 10:27 AM, Benjamin Herrenschmidt wrote:
> On Wed, 2017-05-17 at 08:57 +0530, Aneesh Kumar K.V wrote:
>> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
>>
>>> On Tue, 2017-05-16 at 14:56 +0530, Aneesh Kumar K.V wrote:
>>>> +static inline pte_t *find_linux_pte(pgd_t *pgdir, unsigned long ea,
>>>> +                                   bool *is_thp, unsigned *hshift)
>>>> +{
>>>> +       VM_WARN((!arch_irqs_disabled() && !__hard_irqs_disabled()) ,
>>>> +               "%s called with irq enabled\n", __func__);
>>>> +       return __find_linux_pte(pgdir, ea, is_thp, hshift);
>>>> +}
>>>> +
>>> When is arch_irqs_disabled() not sufficient ?
>> We can do lockless page table walk in interrupt handlers where we find
>> MSR_EE = 0.
> Such as ?
>
>> I was not sure we mark softenabled 0 there. What I wanted to
>> indicate in the patch is that we are safe with either softenable = 0 or MSR_EE = 0
> Reading the MSR is expensive...
>
> Can you find a case where we are hard disabled and not soft disable in
> C code ? I can't think of one off-hand ... I know we have some asm that
> can do that very temporarily but I wouldn't think we have anything at
> runtime.
>
> Talking of which, we have this in irq.c:
>
>
> #ifdef CONFIG_TRACE_IRQFLAGS
> 	else {
> 		/*
> 		 * We should already be hard disabled here. We had bugs
> 		 * where that wasn't the case so let's dbl check it and
> 		 * warn if we are wrong. Only do that when IRQ tracing
> 		 * is enabled as mfmsr() can be costly.
> 		 */
> 		if (WARN_ON(mfmsr() & MSR_EE))
> 			__hard_irq_disable();
> 	}
> #endif
>
> I think we should move that to a new CONFIG_PPC_DEBUG_LAZY_IRQ because
> distros are likely to have CONFIG_TRACE_IRQFLAGS these days no ?

Yes, CONFIG_TRACE_IRQFLAGS are enabled. So in my local_t patchset,
I have added a patch to do the same with a flag "CONFIG_IRQ_DEBUG_SUPPORT"

mpe reported boot hang with the current version of the
local_t patchset in Booke system, and have a fix for the
same and it is being tested. Will post a newer version
once the patch verified.

Maddy
>
> Also we could add additional checks, such as MSR_EE matching paca-
>> irq_happened or the above you mentioned, ie, WARN if we find case
> where IRQs are hard disabled but soft enabled.
>
> If we find these, I think we should fix them.
>
> Cheers,
> Ben.
>
