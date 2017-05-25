Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wYK2010yPzDqgP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 16:22:47 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4P6JBcW052945
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 02:22:45 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2anrshthym-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 02:22:45 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 25 May 2017 02:22:43 -0400
Subject: Re: [PATCH] powerpc: Fix booting P9 hash with CONFIG_PPC_RADIX_MMU=N
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling
 <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 anton@samba.org, Greg Johnson <gwj@google.com>
References: <20170524070326.13531-1-mikey@neuling.org>
 <87bmqir5tl.fsf@skywalker.in.ibm.com> <1495671229.18002.1.camel@neuling.org>
 <87d1axa2ce.fsf@concordia.ellerman.id.au>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 25 May 2017 11:52:32 +0530
MIME-Version: 1.0
In-Reply-To: <87d1axa2ce.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <f94c6ec5-fbb5-1530-0742-f5801efe0ac5@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thursday 25 May 2017 11:46 AM, Michael Ellerman wrote:
> Michael Neuling <mikey@neuling.org> writes:
> 
>> On Wed, 2017-05-24 at 14:26 +0530, Aneesh Kumar K.V wrote:
>>> Michael Neuling <mikey@neuling.org> writes:
>>>
>>>> Currently if you disable CONFIG_PPC_RADIX_MMU you'll crash on boot on
>>>> a P9. This is because we still set MMU_FTR_TYPE_RADIX via
>>>> ibm,pa-features and MMU_FTR_TYPE_RADIX is what's used for code patching
>>>> in much of the asm code (ie. slb_miss_realmode)
>>>>
>>>> This patch fixes the problem by stopping MMU_FTR_TYPE_RADIX from being
>>>> set from ibm.pa-features.
>>>>
>>>> We may eventually end up removing the CONFIG_PPC_RADIX_MMU option
>>>> completely but until then this fixes the issue.
>>>>
>>>> Signed-off-by: Michael Neuling <mikey@neuling.org>
>>>> ---
>>>>   arch/powerpc/kernel/prom.c | 2 ++
>>>>   1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
>>>> index 40c4887c27..f830562974 100644
>>>> --- a/arch/powerpc/kernel/prom.c
>>>> +++ b/arch/powerpc/kernel/prom.c
>>>> @@ -161,7 +161,9 @@ static struct ibm_pa_feature {
>>>>   	{ .pabyte = 0,  .pabit = 3, .cpu_features  = CPU_FTR_CTRL },
>>>>   	{ .pabyte = 0,  .pabit = 6, .cpu_features  = CPU_FTR_NOEXECUTE },
>>>>   	{ .pabyte = 1,  .pabit = 2, .mmu_features  = MMU_FTR_CI_LARGE_PAGE
>>>> },
>>>> +#ifdef CONFIG_PPC_RADIX_MMU
>>>>   	{ .pabyte = 40, .pabit = 0, .mmu_features  = MMU_FTR_TYPE_RADIX },
>>>> +#endif
>>>>   	{ .pabyte = 1,  .pabit = 1, .invert = 1, .cpu_features =
>>>> CPU_FTR_NODSISRALIGN },
>>>>   	{ .pabyte = 5,  .pabit = 0, .cpu_features  = CPU_FTR_REAL_LE,
>>>>   				    .cpu_user_ftrs = PPC_FEATURE_TRUE_LE },
>>>> -- 
>>>> 2.11.0
>>>
>>> Instead can we do that feature removal in mmu_early_init_devtree. ie,
>>> something like
>>
>> It looks like mmu_early_init_devtree() gets called after parsing ibm,pa_features
>> so that should work.
> 
> But why is doing it later preferable?
> 
> Mikey's patch means it will never be set at any point during boot, which
> seems obviously better to me.

My suggestion was w.r.t consolidating different ways of clearing 
RADIX_MMU feature flag into one place. Also I was not sure we want to 
conditionally parse the pa-feature device tree. Instead we parse it 
without any #ifdef in there and clear things which are not supported by 
the kernel either via command line or via Kconfig.

-aneesh
