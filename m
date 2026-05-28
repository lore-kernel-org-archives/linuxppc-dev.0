Return-Path: <linuxppc-dev+bounces-21615-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F5CCD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2026 04:58:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQvQF2w9yz2xpt;
	Thu, 28 May 2026 14:58:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779944309;
	cv=none; b=nSmGfS8Yg5OXL9HtMhI1pDQWJg+3HNZd5TCTB4OInXry8f+qYxTu0lZ31rBHyNNdao58fX4TONzinBicfNURPNd41aE7SjgSyID65zROuYXeLbpgfwvItyuPOILjwb5YPXrsBALznbnCKRdulhjg/0y8Lzuvn3U/RrjmcZkupqWLzlq2J8dJ66/1Ps1+Gbh/WLyxNgNvJknCnP1D8GEe/4ImU4enJVYj5Zo9Jopf0Nn0ExFBkDqMM4vAHOGsyuyclvMLD7AUwo0psffzurfc4+KoTj8nfonId53goMFnZuRaOK38cx/z9SWRXxmwu/8DtZO9YrgpfEDo6yJNeeJX8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779944309; c=relaxed/relaxed;
	bh=UMvhgid91xuqK9xy6qN9wIiqZdU2a4rsyIeHAZDU4kU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=o0+rxy6a+65hVlUBOuf8ND6S/0bYZkb2OPwvsex/PR1f6VaWN5iSi3j0v15L+vNkbmmVvDN4GLGsi6HWeQyNGykFOJFnwvFOerdD7yCjjOr94uloRBjd/g1N3AYsd6QEnywCxgHDnB+/rfv+xOxg50cs/dxrinrikP2/siCFScEQe9ptfJeB1YhiXZk9Q3aZ+JlTxOark2HLTuSmF6mH0P412bRsl0HykiSm2lTX2KtGg3TaxTC//V/pfHEF2o1w93YZhCFH8FJpI0cpsVC7y5qFj/RsGnS7TkX3dsuCf/oiTKVA7TVv0wf1aiGcOlinxNeGHi0kLrsL2FjmazckLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MrloZ5Br; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MrloZ5Br;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQvQD0WLTz2xSN
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2026 14:58:27 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RL7F7s2480393;
	Thu, 28 May 2026 04:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UMvhgi
	d91xuqK9xy6qN9wIiqZdU2a4rsyIeHAZDU4kU=; b=MrloZ5Br0Yt8M6xiQRvOe8
	VzB9Mh5157WoK/OLv1Rz7vR0sNeyyUKf1zcXLKS8v/tvy9jHC57eOr+gei3gt+KG
	2f3fSz/3MHDlt+TsXtzJeOiAqNaKgVFLmwGX2OYJiSxzFmrHgE7d1RR3vfIKc/g3
	+sJXnOF5utPrHAYO3Rf1uVVEh4W8MDzdMSDKpvuZ1Jw7hUZDQmFKm524u0OS6v9r
	7t6HvzpeKp126mEwPD+mCDAOI4upl2RCuKUL+70QAxt4gUxRUHEKaXK3hrv9zouJ
	f1I6hKhcgTDGifHtfU8NkdUD3p4FGT6EYsLjopNW/g41rM8FMYnIw/zFPNP0lc2A
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee8869b4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 04:58:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64S4s5oE019596;
	Thu, 28 May 2026 04:58:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrbpesd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 04:58:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64S4w7JB18153728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 May 2026 04:58:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC1C820040;
	Thu, 28 May 2026 04:58:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE41120043;
	Thu, 28 May 2026 04:58:04 +0000 (GMT)
Received: from [9.124.220.134] (unknown [9.124.220.134])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 May 2026 04:58:04 +0000 (GMT)
Message-ID: <508a604b-2d30-47f4-a63c-36778a1d47c7@linux.ibm.com>
Date: Thu, 28 May 2026 10:28:03 +0530
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] sched/cache: "Make LLC id continuous" causes NULL cpumask
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: "Chen, Yu C" <yu.c.chen@intel.com>, kprateek.nayak@amd.com
Cc: srikar@linux.ibm.com, venkat88@linux.ibm.com, maddy@linux.ibm.com,
        riteshh@linux.ibm.com, chleroy@kernel.org, tim.c.chen@linux.intel.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sched@vger.kernel.org
References: <51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com>
 <ahUogeqIq5km7JSr@linux.ibm.com>
 <058664ab-0982-4c13-9d4b-caa2f7616b0f@amd.com>
 <20260526140856.139657-1-yu.c.chen@intel.com>
 <d45877d5-86f1-4581-b3e0-59ceb722de3a@linux.ibm.com>
 <912676bc-230e-410f-a5fe-153b0f304aee@intel.com>
 <42a19577-fe56-44b4-b0ed-37cde6d03ff5@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <42a19577-fe56-44b4-b0ed-37cde6d03ff5@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gvT5DIhnckMsE6NKzZlK3vZc42B24i6k
X-Authority-Analysis: v=2.4 cv=Z8Dc2nRA c=1 sm=1 tr=0 ts=6a17cb65 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=zd2uoN0lAAAA:8 a=QyXUC8HyAAAA:8 a=Wy3zBFh7Jqj81cXh6vwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA0MiBTYWx0ZWRfXyEjA00jk4wNq
 qh8lvFoCeEKWKOJhah9DHJo7Dx1xS0iIaPEOGAUUGsZoxdo3ZnojfionD4LSCFYmAbT/OmVkcpD
 HtfPYwpkks0dd3jUYnFX1e6TDhjY4ZkxHS45dF6iUddyOi7rxWSPjKATL3TSaRJFAKgieMJDG2w
 L7YCOzMvwh9G84KhV5tdbVR3hL2O+RiCaGO/uLJPZ7AOhLLg+bTNcuNkxVkYC2y/nS8yqUzAbUB
 enIrrKY9YDNSLFpo7l2FLTvSAOslzJlj9iG8aX/30lpBZVuePKmvQxIb5M1eX5BjhmkCskf/k6D
 QqWBc34rujUWdE4iQ/iKRKbBmekAe6QAduqB6wQkbGAkDTwWK1habrzQ/wGDQBcoAP6ldzrE5VJ
 t1AwPXC9XDTb86qxbDx/IhumO7aavFIdIIC+yC87JavsS6o42O/muAybpN6Pm9HPGv8FJPXPOr/
 ohGLk64ovP5noPocL6g==
X-Proofpoint-ORIG-GUID: gvT5DIhnckMsE6NKzZlK3vZc42B24i6k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_01,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280042



On 5/27/26 11:37 PM, Shrikanth Hegde wrote:
> Hi Chen, Prateek.
> 
> On 5/27/26 9:35 PM, Chen, Yu C wrote:
>> Hi Shrikanth,
>>
>> On 5/27/2026 3:01 PM, Shrikanth Hegde wrote:
>>> Hi Chen, Prateek.
>>>
>>> I got back to work today, sorry for delay.
>>> I am trying to go through the mails.
>>> Apologies in case i have missed any bits.
>>>
>>
>> Thanks for taking a look at this!
>>
>>> On 5/26/26 7:38 PM, Chen Yu wrote:
>>>> Hi Prateek,
>>>>
>>>> On Tue, 26 May 2026 11:23:59 +0530, K Prateek Nayak 
>>>> <kprateek.nayak@amd.com> wrote:
>>>>> Hello Srikar,
>>>>>
>>>>> On 5/26/2026 10:28 AM, Srikar Dronamraju wrote:
>>>>>> L2 Cache reported here is for SMT8 Core aka CACHE domain.
>>>>>
>>>>> Apart for the scheduler, nothing in tree currently cares about
>>>>> cpu_coregroup_mask() except for drivers/base/arch_topology.c but
>>>>> Power doesn't select GENERIC_ARCH_TOPOLOGY.
>>>>>
>>>>> Why can't Power have an internal mask for MC domain (tl_mc_mask) and
>>>>> the scheduler can use cpu_coregroup_mask() for the actual LLc? (The L2
>>>>> mask in this case.)
>>>
>>> This seems wrong. there is no notion that coregroup_mask
>>> (MC domain) has to point at LLC domain.
>>>
>>> For example, on Shared LPAR, there is no MC domain and LLC is at SMT 
>>> core level.
>>> In that case coregroup_mask has point at SMT mask is wrong.
>>>
>>
>> On Shared LPAR, highest_flag_domain(SD_SHARE_LLC) selected the
>> SMT domain(L2 shared)prior to commit b5ea300a17e3.
>> Prateek suggested changing cpu_coregroup_mask() to use
>> cpu_l2_cache_mask(), which makes the LLC mask cover the same range.
>> sd_llc, size and grouping remain unchanged. Only sd_llc_id becomes
>> contiguous, which aligns with the intent of this commit.
>>
>> But yes, the naming is confusing. cpu_coregroup_mask suggests a
>> "group of cores", but after the change, it only covers threads
>> within a single SMT core.
>>
> 
> Yes. Though it might achieve the same effect, keeping it explicit may
> help in maintaining it better.
> 
> On PowerPC, there are these subtleties of Shared LPAR where MC domain
> per se doesn't exit etc, and on power9 and earlier has different 
> topologies. Maybe one could figure it all out and simplifies them into
> a few masks. But yes, it is slightly different as of today.
> 
>>> If we need a mask to point to the LLC mask which arch has to return, 
>>> then we would
>>> need a new api say cpu_llc_mask ? that can point accordingly.
>>>
>>
>> Do you mean something like this?
>> https://lore.kernel.org/lkml/8d14c844-b4a8-4af6- 
>> acab-2cfdd42225be@intel.com/
> 
> Yes. This is something i prefer, but not to make it point to l2 mask 
> always. See below diff which now make it boot on Shared Processor LPAR
> where i see panic without it.
> 
> Need to add proper comments where appropriate.
> 
> diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/ 
> asm/topology.h
> index 66ed5fe1b718..bd1db3b1dbb0 100644
> --- a/arch/powerpc/include/asm/topology.h
> +++ b/arch/powerpc/include/asm/topology.h
> @@ -131,6 +131,9 @@ static inline int cpu_to_coregroup_id(int cpu)
>   #ifdef CONFIG_SMP
>   #include <asm/cputable.h>
> 
> +const struct cpumask *arch_llc_mask(int cpu);
> +#define arch_llc_mask  arch_llc_mask
> +
>   struct cpumask *cpu_coregroup_mask(int cpu);
>   const struct cpumask *cpu_die_mask(int cpu);
>   int cpu_die_id(int cpu);
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 3467f86fd78f..26c15c786c55 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -1101,6 +1101,13 @@ const struct cpumask *cpu_die_mask(int cpu)
>   }
>   EXPORT_SYMBOL_GPL(cpu_die_mask);
> 
> +const struct cpumask *arch_llc_mask(int cpu)
> +{
> +       if (has_coregroup_support())
> +               return cpu_coregroup_mask(cpu);
> +       return cpu_smallcore_mask(cpu);


This function body needs change, since LLC is not at MC.
and I didn't account for power9.

Rest of the structure is what i would prefer the direction to go.
This will help future architectures too to account for their specific
needs.

What do you think?

> +}
> +
>   int cpu_die_id(int cpu)
>   {
>          if (has_coregroup_support())
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index df2ceb54c970..3b5155121276 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2063,7 +2063,11 @@ const struct cpumask *tl_mc_mask(struct 
> sched_domain_topology_level *tl, int cpu
>          return cpu_coregroup_mask(cpu);
>   }
> 
> +#ifndef arch_llc_mask
>   #define llc_mask(cpu) cpu_coregroup_mask(cpu)
> +#else
> +#define llc_mask(cpu) arch_llc_mask(cpu)
> +#endif
> 
>   #else
>   #define llc_mask(cpu) cpumask_of(cpu)
> 
> (One more subtlety; crash would be seen only with NR_CPUS=8192 as 
> CPUMASK_OFFSTACK=y, but that's a different concern altogether.)
> 
> 
>>
>>> I don't like mixing MC domain and LLC into one bit.
>>>
>>
>> [ ... ]
>>
>>>>   struct cpumask *cpu_coregroup_mask(int cpu)
>>>>   {
>>>> -    return per_cpu(cpu_coregroup_map, cpu);
>>>> +    return cpu_l2_cache_mask(cpu);
>>>> +}
>>>
>>> This looks wrong to me too. In different hardware topologies
>>> there maybe distinction between coregroup and l2 mask.
>>>
>>> Let me go through the code and see if there is better way.
>>>
>>
>> Sure, please go ahead - I'm on board with the direction
>> you settle on.
>>
>> thanks,
>> Chenyu
>>
> 


