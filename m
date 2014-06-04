Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E17311A06FA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jun 2014 20:36:28 +1000 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 4 Jun 2014 16:06:22 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 403111258054
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jun 2014 16:05:36 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s54Ab2ID54067240
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jun 2014 16:07:02 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s54AaHWZ031873
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jun 2014 16:06:17 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] PPC: BOOK3S: Disable/Enable TM looking at the ibm,
 pa-features device tree entry
In-Reply-To: <871twcbvyn.fsf@linux.vnet.ibm.com>
References: <1398845480-9945-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20060.1398920500@ale.ozlabs.ibm.com> <87r44dbkg4.fsf@linux.vnet.ibm.com>
 <871twcbvyn.fsf@linux.vnet.ibm.com>
Date: Wed, 04 Jun 2014 16:06:16 +0530
Message-ID: <87y4xd6jxb.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
>
>> Michael Neuling <mikey@neuling.org> writes:
>>
>>> Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> wrote:
>>>
>>>> Runtime disable transactional memory feature looking at pa-features
>>>> device tree entry. This provides a mechanism to disable TM on P8
>>>> systems.
>>>
>>> What are we actually achieving with this?
>>
>> PAPR compliance  :) ? Also I wanted to disable guest kernel from doing
>> TM related save restore. Guest kernel already look at the cpu feature
>> before doing that. Hence needed a mechanism to disable the feature. 
>>
>> Things like
>>
>> static inline void __switch_to_tm(struct task_struct *prev)
>> {
>> 	if (cpu_has_feature(CPU_FTR_TM)) {
>> 		tm_enable();
>> 		tm_reclaim_task(prev);
>> 	}
>> }
>>
>>
>>>
>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>>>> ---
>>>>  arch/powerpc/kernel/prom.c | 5 +++++
>>>>  1 file changed, 5 insertions(+)
>>>> 
>>>> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
>>>> index 668aa4791fd7..537bd7e7db0b 100644
>>>> --- a/arch/powerpc/kernel/prom.c
>>>> +++ b/arch/powerpc/kernel/prom.c
>>>> @@ -161,6 +161,11 @@ static struct ibm_pa_feature {
>>>>  	{CPU_FTR_NODSISRALIGN, 0, 0,	1, 1, 1},
>>>>  	{0, MMU_FTR_CI_LARGE_PAGE, 0,	1, 2, 0},
>>>>  	{CPU_FTR_REAL_LE, PPC_FEATURE_TRUE_LE, 5, 0, 0},
>>>> +	/*
>>>> +	 * We should use CPU_FTR_TM_COMP so that if we disable TM, it won't get
>>>> +	 * enabled via device tree
>>>> +	 */
>>>> +	{CPU_FTR_TM_COMP, 0, 0,		22, 0, 0},
>>>
>>> What does this do to guests?  Will it turn TM unavailable into an
>>> illegal instruction?
>>>
>>
>> Good suggestion. I guess it should be facility unavailable interrupt ?
>> I should also make the sure __init_HFSCR only set HFSCR_TM only if the
>> cpu feature is enabled ?
>
> I looked at this and I guess we don't need to update HFSCR considering
> that the guest kernel (privileged) access to TM always happen within
> if (cpu_has_feature(CPU_FTR_TM)) conditional block. Also we want to
> disable this per guest and there is no easy way to suggest hypervisor
> that disable TM in HFSCR.
>
> BTW we already do this for guest problme state. We do in guest kernel
>
> 	if (cpu_has_feature(CPU_FTR_TM))
> 		regs->msr |= MSR_TM;
>
> IIUC that should result in facility unavailable interrupt when problem
> state try to access TM ?
>
> I will try to run some test with the patch and update here.

This will actually result in illegal instruction.

-aneesh
