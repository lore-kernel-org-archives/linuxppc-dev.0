Return-Path: <linuxppc-dev+bounces-29451-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAEE8CC6B1A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2026 03:16:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4GZv08Dkz2yYK;
	Wed, 14 Oct 2026 14:16:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791947814;
	cv=none; b=Ns7PmZZRQq/1R4e0pmkY2Gx4uGyXfPuswCia/qTT5uklqXie20FTkrAei0Vx1i9kjwXSro1Bi/LYI1vP60UQ5tREJk33JQqzHz5Rga3xLIKYFAQ2Eh7Q04vIcCmhtcR3LCvVMtFePChXhNefD0gWziEGHrtn219UO16pUJluLWirUOGGDqDEmgStshDbcapm0ZK6n5ir9Ha9IMUvAqfTmnAo4ieaVeCbKdQ1NKH9VUCF1jZoO+dmSrupOeCyPTmyzQc7k/UYiFIrYC78Lxzhz5UexDSstykMSnPSUGoRP676h34nFWmEQAOOtpGdaQsIbsvF2VNhsSg8zxzbIvgSug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791947814; c=relaxed/relaxed;
	bh=vfjXevxmmjpEfgjWMFTXwdTqXsK/H4tcoFH11uvIfLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=csu0Uz8T/HUV+cCK//0eyvfYiSluZDOrr8sO7usQ3foTKkeTEm5WTXZN59eN5wJEsaA/mZFi8o0K5lE/S2/erf85t17NCXW3LlK5qTy5KBXElpnhwd2qO9bQj5QizQVpXZcTlLshdNujfw6UsBG2cBBflXLX9RPeBjopdaI/gKIZU3dRa2UwDr6ttiCUtc92TeEkmsC8gogg1tlmocJecqbur/eGuWZoaqceNRxJ3FL72vqnjceR3iuB9IGmIHs3IkqxXKfSEGJfK1cEcimoy2qqkWL5xq/e3cF8mkUuh2elH4TC3wPpvz8rRSUfHkmhKbYQQ3iP5nUc4L9K/JfnNw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NbEdq29a; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NbEdq29a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4GZs1vjPz2yWy
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 14:16:52 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DM0oDY1775031;
	Wed, 14 Oct 2026 03:16:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vfjXev
	xmmjpEfgjWMFTXwdTqXsK/H4tcoFH11uvIfLA=; b=NbEdq29aHj18kt8RqSm4qt
	g8IaKSPczksIyPIM3sdVRW0UpzhyJp+La0K9phvfvutUxfzOwV6LsVbxcn76YyLl
	7UWDW5bHfyNk2cVWg5ubg248K3v3XCbTZO5hXx9sjLwcEeqqOz6UC14eQ87bzDrV
	O40bLSkIOS9ymR1a6WOz7S6RVTIfC8Vj31zpw9GMvnggXIYngkWtdlcvGFX+4haA
	hCO544wHGmXsUTOBgTS3czGy+6GxOtY/j5oJFdOzB84Jk7ohdHIvSYKk4sQEoL8R
	TUn3H44qp9tJrUNL/BecnSppJFUvVrFjqJBvzUzRFBdEK1Vo/YhbgEiJlbPtchIg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwj1qdk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 03:16:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69E1sECD2709272;
	Wed, 14 Oct 2026 03:16:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h816h5f77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 03:16:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69E3GFkI43188556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Oct 2026 03:16:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD99E2004E;
	Wed, 14 Oct 2026 03:16:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACCB52004B;
	Wed, 14 Oct 2026 03:16:12 +0000 (GMT)
Received: from [9.124.213.187] (unknown [9.124.213.187])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Oct 2026 03:16:12 +0000 (GMT)
Message-ID: <5f107344-7ddf-402e-809c-7229ff6fb6d5@linux.ibm.com>
Date: Wed, 14 Oct 2026 08:46:11 +0530
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
Subject: Re: [PATCH 0/4] powerpc/topology: Introduce llc_override debugfs
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        ritesh.list@gmail.com, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        vineethr@linux.ibm.com, vincent.guittot@linaro.org,
        srikar@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        peterz@infradead.org
References: <20261012102037.2477378-1-sshegde@linux.ibm.com>
 <0cbd60fcf328ffcb317739f60d327da3af6145f1.camel@linux.intel.com>
 <dfd8312d-a59c-4480-b054-d94d2e66110e@linux.ibm.com>
 <4d0f2f4631f2f836bb1aec140c2c8e3e11d7ba20.camel@linux.intel.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <4d0f2f4631f2f836bb1aec140c2c8e3e11d7ba20.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAxMiBTYWx0ZWRfX6i56fBXqo8DT
 jGPA/utDhheJL89A5rOScXi3plxsfDP1opIPD8n2RHxhB48JuSOaYRVSHMZ1Hfas5tZoqQ85Mm1
 jmSjrXmb2eV1EFftGmEogVGYCDwkU2X/Z00ccFOVSRTNhwmaxEQbfJt7dFio04ND1maO5dFvODX
 WIw2bkNEQYBqEDiz8YspY9KEXVGldaxXlfbxaZMB9+BfJyIRb1AeFU0h9BkmBR5IeChZj8PaM5d
 hz52lm6ula03kHuzTHQarZW7biyGp0jwRYIfACiyXFHyWc9ktUzRTQuVvfZQpOFVBpaWjHZPfA6
 6tFX8WLJVG4b1GacNL40dsHZf7TnbSdmRQ31lyBwT+cTWNJDob6h8OzhOm5aj9/YucCxfT15zb+
 uFPj1g8y/qZgFKvsy9/bzT5TXVuZp9/Qb0xW7QEv9dxyMDBSTymXRlTz79gH4AvAd4XZQ5Wz9n9
 6CrbHIBQTRxguX2ye/Q==
X-Proofpoint-GUID: E5reA7hJtXl3dRwHFJCbCN9ZNuvHwB7e
X-Proofpoint-ORIG-GUID: T8XHE_d19YmQUy8zpn2yaoosPKieZ6Y1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAxMiBTYWx0ZWRfX4ZBCkDXv0Z+O
 4TNCvWkysTAVQ6sEFFrGZb+V0/rUsOSrjkg3Fn2QRw/q2BfmdB8zzPrsqvy9OFjWmMeuUdAKrpJ
 2tqtJcpFQ+2KeHlx6f1Jwau4k90jypY=
X-Authority-Analysis: v=2.4 cv=btHZl0ai c=1 sm=1 tr=0 ts=6acef405 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=LSd69HplV2GyPLOmy40A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140012



On 10/14/26 2:14 AM, Tim Chen wrote:
> On Tue, 2026-10-13 at 15:28 +0530, Shrikanth Hegde wrote:
>>
> 
> [snip]
> 
>>
>> One way to fix it is with a change like below.
>> But more thoughts after the patch.
>>
>> ---
>>    arch/powerpc/include/asm/topology.h |  7 +------
>>    arch/powerpc/kernel/smp.c           | 23 +++++++++++++++++++++++
>>    include/linux/sched.h               |  2 +-
>>    kernel/sched/topology.c             |  7 +++++++
>>    4 files changed, 32 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
>> index 44ec416fa489..f4555632e692 100644
>> --- a/arch/powerpc/include/asm/topology.h
>> +++ b/arch/powerpc/include/asm/topology.h
>> @@ -135,12 +135,7 @@ struct cpumask *cpu_coregroup_mask(int cpu);
>>    const struct cpumask *cpu_die_mask(int cpu);
>>    int cpu_die_id(int cpu);
>>    
>> -/*
>> - * Points to where the LLC is. On power9 this will point at CACHE
>> - * domain, On others it will point to SMT domain. In all cases
>> - * cpu_l2_cache_mask points to where LLC is
>> - */
>> -#define arch_llc_mask(cpu)     cpu_l2_cache_mask(cpu)
>> +const struct cpumask *arch_llc_mask(int cpu);
> 
> You will need to add
> #define arch_llc_mask arch_llc_mask

Yes.

> here.
> 
> Otherwise kernel/sched/topology.c looks for a macro:
> 
>    # ifndef arch_llc_mask
>    #define arch_llc_mask(cpu) cpu_coregroup_mask(cpu)
>    # endif
> 
> With the #define gone, the generic code falls back to
> cpu_coregroup_mask().
> 
>>    
>>    #ifdef CONFIG_PPC64
>>    #include <asm/smp.h>
>> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
>> index 6a4ee7d3b8e5..139c54fc3e2d 100644
>> --- a/arch/powerpc/kernel/smp.c
>> +++ b/arch/powerpc/kernel/smp.c
>> @@ -1864,6 +1864,28 @@ void __noreturn arch_cpu_idle_dead(void)
>>    
>>    #endif
>>    
>> +/*
>> + * Points to where the LLC is. On power9 this will point at CACHE
>> + * domain, On others it will point to SMT domain. In all cases
>> + * cpu_l2_cache_mask points to where LLC is.
>> + *
>> + * If there is llc_override debug knob, return appropriate mask
>> + */
>> +const struct cpumask *arch_llc_mask(int cpu)
>> +{
>> +	switch (READ_ONCE(llc_override)) {
>> +	case LLC_OVERRIDE_SMT:
>> +		return cpu_smt_mask(cpu);
>> +	case LLC_OVERRIDE_MC:
>> +		return cpu_coregroup_mask(cpu);
>> +	case LLC_OVERRIDE_PKG:
>> +		return cpu_die_mask(cpu);
>> +	case LLC_OVERRIDE_DISABLED:
>> +	default:
>> +		return cpu_l2_cache_mask(cpu);
>> +	}
>> +}
>> +
> 
> The mask here has to match the span of the highest SD_SHARE_LLC
> domain, and there seems to be some mismatches.
>                                                                                 
> - PKG: On power pc, seems like cpu_die_mask() returns
>    cpu_coregroup_map when coregroups are
>    supported,
> 
> 	if (has_coregroup_support())
> 		return per_cpu(cpu_coregroup_map, cpu);
> 	else
> 		return cpu_node_mask(cpu);
> 
>    so this is the MC span while sd_llc sits at PKG. It
>    should be cpu_node_mask(), the same as tl_pkg_mask().
> 

facepalm :/

> - SMT: patch 3 adds SD_SHARE_LLC only to MC/PKG, so for "smt" the
>    flags are as before. I think it is possible for P9 to have
>    shared_caches between two cores:
> 
>    /*
>     * P9 has a slightly odd architecture where pairs of cores share an L2 cache.
>     * This topology makes it *much* cheaper to migrate tasks between adjacent cores
>     * since the migrated task remains cache hot. We want to take advantage of this
>     * at the scheduler level so an extra topology level is required.
>     */
> 
>    the CACHE level also has SD_SHARE_LLC, and highest_flag_domain() picks it, so sd_llc spans
>    cpu_l2_cache_map. shared_caches is only set when that map is wider
>    than the core's threads, e.g. a P9 core pair sharing an L2:
> 
>      CPU:               0 1 2 3 | 4 5 6 7
>      cpu_smt_mask():    core A  | core B
>      sd_llc (CACHE):    0-7
> 
>    The ids follow cpu_smt_mask(), so 0-3 and 4-7 get different ids
>    while sd_llc and sd_llc_size cover all eight, and
>    cpus_share_cache(0, 4) is false, which is incorrect.
> 

Yes. I doubt anyone wants to try this experiment on Power9.
But yes, functionally updating the flags is needed.

@srikar,
That is also the reason for having the disabled. By default on P9,
llc will be at CACHE domain. But, one may want to experiment with =smt
which i doubt anyone will ever do.


>>    int arch_update_cpu_topology(void)
>>    {
>>    	if (READ_ONCE(llc_override_changed)) {
>> @@ -1923,6 +1945,7 @@ static ssize_t llc_override_set(struct file *file, const char __user *ubuf,
>>    		pr_info("sched LLC override set to %s. Rebuilding sched domains\n",
>>    			llc_override_str[override]);
>>    
>> +		sched_reset_llc_id();
> 
> The reset here seems racy without taking cpus_read_lock, and taking
> sched_domains_mutex for each CPU and you could have a cpu hot plug event
> or cpu set rebuild in between.
> 
> That's why I would go with the boot parameter. The llc ids are assigned once,
> with the right mask, so there is nothing to reset or rebuild, no
> change to kernel/sched/, and everything stays in arch/powerpc. Since
> this is an experiment knob, needing a reboot to change it is a small
> cost, and every run starts from a clean state.
> 
> Tim


Yes. That is what i prefer at this moment too. It will be cleaner.
Only thing is, need to get the masks right in different domains.

> 
>>    		rebuild_sched_domains();
>>    	}
>>    
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index 7b91cae4a59c..4d7e2ee841a9 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -2505,5 +2505,5 @@ extern void migrate_enable(void);
>>    #endif /* MODULE */
>>    
>>    DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
>> -
>> +void sched_reset_llc_id(void);
>>    #endif
>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>> index dd2b1d70ec9d..63c9bca4c5eb 100644
>> --- a/kernel/sched/topology.c
>> +++ b/kernel/sched/topology.c
>> @@ -3087,6 +3087,13 @@ void sched_domains_free_llc_id(int cpu)
>>    	sched_domains_mutex_unlock();
>>    }
>>    
>> +void sched_reset_llc_id(void)
>> +{
>> +	int cpu;
>> +
>> +	for_each_online_cpu(cpu)
>> +		sched_domains_free_llc_id(cpu);
>> +}
>>    /*
>>     * Build sched domains for a given set of CPUs and attach the sched domains
>>     * to the individual CPUs


