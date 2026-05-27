Return-Path: <linuxppc-dev+bounces-21552-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDFDCD5BDE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 07:01:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQLBv0kh5z2xYh;
	Wed, 27 May 2026 17:01:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779865303;
	cv=none; b=CHimxcuQCNozll2EU+FxJvtDof4UKUUSEBbiv8ac6ccP21NL3u19eNcdIn7avWohRBI2JtnRBHshgwBISvbM9o+sdEeJtbytH8om5+TMX4nrA1OvumcsN3aJGRwyoo6qbxlb3NyMJrrXMY5H8k7xy6n2LGA6AhVOol/oZmaGJuCWcjIQHrUfN8LW9crUeKYf/snBSsWq2BC8H+53n0MV7Ldb1hvgngrbzrEpsv8sEB97NFpo5QFUExkPoEM4Ih3ioE7xxA59Y+fbV/XatXhvcLO2rSi+K4qeO5daLIsTzGl7K67RsC8gNX2UEuWs1RiqPrMO8GwH2cClAZ/WZmpvBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779865303; c=relaxed/relaxed;
	bh=6Vv4F4NgVCg0xU3q59Ved0WryPBOSiU/Q5RfSryUhTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vc1tDN4ITG8N+OlmTPPSZFu6xBLbBh4ICLg2fCxcbuI8dH+ULkn7arIZHVe7cydlD5O2GH/3JiHUMJFjNjqd6tBfAWS0a9fE144DNuuItGso+B5GJMAM9xxLyKhkJ7v5+ivpxs1sXVl/fPuByRNd7Y/5yqoITZD513e91rpggG4MngP9jjTfK/RZyTsXBxcHoLSW8hEpl53QD/ACAObX0px3eXZJYRrtT+YpWI1QOUVGtj8YVAp5DtOZgTqQeJqLXrGA2kEVNp7VZTOQuMPaK+V2cD/G/IKvLBjBlkMERWl9QmQRpIpZ27cYJH2FuK+Q6vMvCRxSYtEgyYHIL/RqzA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qkxhv3Nr; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qkxhv3Nr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQLBs3Rsjz2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 17:01:40 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QL4lPM735964;
	Wed, 27 May 2026 07:01:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6Vv4F4
	NgVCg0xU3q59Ved0WryPBOSiU/Q5RfSryUhTA=; b=qkxhv3NrYq2fr+EFnFsfPI
	lhyKT6JKrPY26NNjGr3EMCgFOqDyjcn/4tjrx7u9UL+0d2nYfDVPkcBizFMonXUH
	M595MXJ0yMziASEILOrrRXf4i9F7zHGiGwS7Z2n1BbM1RDlivcOOX+AVmp9FMqVd
	dz2Php+8TgOEENB0y/QpiTmH1mRLWavMyZvVpSX8LODIS3R4AqsJ6HUMmdVu75H8
	qza4NSu4L1e08RJH5J5QZ9vHTvn20Uj6VDdf1pykMq373af1BnczpMc5g4DM+dSk
	hd18y/elAY1TKl3lI1M0ejlAIlYpZp0XahASlnhJfLG3os51WiSNxAa1ANmVEumQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nc6u7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 07:01:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64R6sBw8030912;
	Wed, 27 May 2026 07:01:22 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrb1tw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 07:01:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64R71ISQ51380540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 07:01:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C47522004F;
	Wed, 27 May 2026 07:01:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B26822004B;
	Wed, 27 May 2026 07:01:15 +0000 (GMT)
Received: from [9.39.21.117] (unknown [9.39.21.117])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 May 2026 07:01:15 +0000 (GMT)
Message-ID: <d45877d5-86f1-4581-b3e0-59ceb722de3a@linux.ibm.com>
Date: Wed, 27 May 2026 12:31:14 +0530
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
To: Chen Yu <yu.c.chen@intel.com>, kprateek.nayak@amd.com
Cc: srikar@linux.ibm.com, venkat88@linux.ibm.com, maddy@linux.ibm.com,
        riteshh@linux.ibm.com, chleroy@kernel.org, tim.c.chen@linux.intel.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sched@vger.kernel.org
References: <51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com>
 <ahUogeqIq5km7JSr@linux.ibm.com>
 <058664ab-0982-4c13-9d4b-caa2f7616b0f@amd.com>
 <20260526140856.139657-1-yu.c.chen@intel.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260526140856.139657-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=VvYTxe2n c=1 sm=1 tr=0 ts=6a1696c3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=zd2uoN0lAAAA:8
 a=VnNF1IyMAAAA:8 a=r2PQHF22u2BctQDFN84A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: dJ1L3dXvenJ5sNmJz1NlVmDDvZ2EVc3R
X-Proofpoint-GUID: dJ1L3dXvenJ5sNmJz1NlVmDDvZ2EVc3R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDA2MiBTYWx0ZWRfX4iIqgSF9XaBQ
 jGRusQpajTRBmS8UO4eRZe1uJsiiETRdR8dZyyz5fL0o75GRpbI+vMgvrxtBXVt1latq//BpgCk
 0K4KdSb/ojIG7p+cEa/jP0YP45yCQiuNdfg+VgITJeKDJoucEOTCYQPKCtxuGW/v2mgUqk76jIk
 wYMCmq4cCXPxNAMe7xQ9xaCm2tD3NspgoR3Y7oC5/QelcXwJeFzM5oGjpHYuLzga9Wuygqf1IoV
 cvsuXp5ZJgHyxAU8DNntvRKtA6Rcu9/48mn12/wjggCwTV8O/39rnOzRMpzGpYGQFdJupK9m6jr
 9YaGICNm/dQhRdE8fVmtSH4I2y9v9DJNG0nqUrpJ8J2G8UgDa/xNW/B+n3mIXPgS2dYwLZbUf4P
 o8teysfkOjcf0iekguI2VuK+7+/Z9gLb1TXE6/OuoZD1zU3txnN9rnD/y6Fi49eLgKrFLGsyQTo
 EeFJi2ivZSHXamNdr3g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 clxscore=1011 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270062

Hi Chen, Prateek.

I got back to work today, sorry for delay.
I am trying to go through the mails.
Apologies in case i have missed any bits.

On 5/26/26 7:38 PM, Chen Yu wrote:
> Hi Prateek,
> 
> On Tue, 26 May 2026 11:23:59 +0530, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>> Hello Srikar,
>>
>> On 5/26/2026 10:28 AM, Srikar Dronamraju wrote:
>>> L2 Cache reported here is for SMT8 Core aka CACHE domain.
>>
>> Apart for the scheduler, nothing in tree currently cares about
>> cpu_coregroup_mask() except for drivers/base/arch_topology.c but
>> Power doesn't select GENERIC_ARCH_TOPOLOGY.
>>
>> Why can't Power have an internal mask for MC domain (tl_mc_mask) and
>> the scheduler can use cpu_coregroup_mask() for the actual LLc? (The L2
>> mask in this case.)

This seems wrong. there is no notion that coregroup_mask
(MC domain) has to point at LLC domain.

For example, on Shared LPAR, there is no MC domain and LLC is at SMT core level.
In that case coregroup_mask has point at SMT mask is wrong.

If we need a mask to point to the LLC mask which arch has to return, then we would
need a new api say cpu_llc_mask ? that can point accordingly.

I don't like mixing MC domain and LLC into one bit.

>>
>> Power anyways adds its own topology via set_sched_topology() so the
>> default_topology from kernel/sched/topology.c remains unused.
>>
>> ...
>>
>>> Shouldnt cache-aware scheduling be worried about cpuset partitions too.
>>> If a cpuset has subset of LLC cores, then we should Scheduler assume it can
>>> control complete LLC?
>>
>> Well, the scheduling takes care of partitions and the cache aware
>> scheduling bits take care of looking at the full system perspective
>> for stats aggregation and pointing to a particular LLc.
>>
>> We don't compare llc_id across cpusets so we keeping one unique llc_id
>> per H/W LLC instance is feasible and it enables us to keep llc_id space
>> limited for optimizing cache-aware scheduling.
>>
>> Now if we have threads of same process across partitions, we'll
>> still aggregate the utilization numbers across the full LLC but
>> the load balancers at individual partitions will make a call on
>> the aggregation.
>>
>> -- 
>> Thanks and Regards,
>> Prateek
>>
>>
> 
> I suppose what you suggested looks like below:
> 
> powerpc/smp: make cpu_coregroup_mask() return the LLC
> 
> On pSeries shared LPARs(or coregroup_enabled is false on
> Power9 and earlier) the hemisphere map is not allocated, so
> build_sched_domains() dereferences a NULL cpumask and crashes.
> 
> The generic scheduler expects cpu_coregroup_mask() to span the LLC.
> On powerpc the LLC is the L2. Return cpu_l2_cache_mask() instead of
> the hemisphere map. Use a coregroup_map() helper for the in-file
> hemisphere users, and a powerpc_tl_mc_mask() wrapper for the MC
> sched-domain level.
> 
> Fixes: b5ea300a17e3 ("sched/cache: Make LLC id continuous")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Suggested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>   arch/powerpc/kernel/smp.c | 35 +++++++++++++++++++++++------------
>   1 file changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -1040,11 +1040,22 @@ static const struct cpumask *tl_smallcore_smt_mask(struct sched_domain_topology_
>   }
>   #endif
>   
> +static inline struct cpumask *coregroup_map(int cpu)
> +{
> +	return per_cpu(cpu_coregroup_map, cpu);
> +}
> +
>   struct cpumask *cpu_coregroup_mask(int cpu)
>   {
> -	return per_cpu(cpu_coregroup_map, cpu);
> +	return cpu_l2_cache_mask(cpu);
> +}

This looks wrong to me too. In different hardware topologies
there maybe distinction between coregroup and l2 mask.

Let me go through the code and see if there is better way.

> +
> +static const struct cpumask *
> +powerpc_tl_mc_mask(struct sched_domain_topology_level *tl, int cpu)
> +{
> +	return coregroup_map(cpu);
>   }
>   
>   static bool has_coregroup_support(void)
>   {
>   	if (is_shared_processor())
> @@ -1155,7 +1166,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>   	cpumask_set_cpu(boot_cpuid, cpu_core_mask(boot_cpuid));
>   
>   	if (has_coregroup_support())
> -		cpumask_set_cpu(boot_cpuid, cpu_coregroup_mask(boot_cpuid));
> +		cpumask_set_cpu(boot_cpuid, coregroup_map(boot_cpuid));
>   
>   	init_big_cores();
>   	if (has_big_cores) {
> @@ -1520,8 +1531,8 @@ static void remove_cpu_from_masks(int cpu)
>   		set_cpus_unrelated(cpu, i, cpu_core_mask);
>   
>   	if (has_coregroup_support()) {
> -		for_each_cpu(i, cpu_coregroup_mask(cpu))
> -			set_cpus_unrelated(cpu, i, cpu_coregroup_mask);
> +		for_each_cpu(i, coregroup_map(cpu))
> +			set_cpus_unrelated(cpu, i, coregroup_map);
>   	}
>   }
>   #endif
> @@ -1553,7 +1564,7 @@ static void update_coregroup_mask(int cpu, cpumask_var_t *mask)
>   	if (!*mask) {
>   		/* Assume only siblings are part of this CPU's coregroup */
>   		for_each_cpu(i, submask_fn(cpu))
> -			set_cpus_related(cpu, i, cpu_coregroup_mask);
> +			set_cpus_related(cpu, i, coregroup_map);
>   
>   		return;
>   	}
> @@ -1561,18 +1572,18 @@ static void update_coregroup_mask(int cpu, cpumask_var_t *mask)
>   	cpumask_and(*mask, cpu_online_mask, cpu_node_mask(cpu));
>   
>   	/* Update coregroup mask with all the CPUs that are part of submask */
> -	or_cpumasks_related(cpu, cpu, submask_fn, cpu_coregroup_mask);
> +	or_cpumasks_related(cpu, cpu, submask_fn, coregroup_map);
>   
>   	/* Skip all CPUs already part of coregroup mask */
> -	cpumask_andnot(*mask, *mask, cpu_coregroup_mask(cpu));
> +	cpumask_andnot(*mask, *mask, coregroup_map(cpu));
>   
>   	for_each_cpu(i, *mask) {
>   		/* Skip all CPUs not part of this coregroup */
>   		if (coregroup_id == cpu_to_coregroup_id(i)) {
> -			or_cpumasks_related(cpu, i, submask_fn, cpu_coregroup_mask);
> +			or_cpumasks_related(cpu, i, submask_fn, coregroup_map);
>   			cpumask_andnot(*mask, *mask, submask_fn(i));
>   		} else {
> -			cpumask_andnot(*mask, *mask, cpu_coregroup_mask(i));
> +			cpumask_andnot(*mask, *mask, coregroup_map(i));
>   		}
>   	}
>   }
> @@ -1733,7 +1744,7 @@ static void __init build_sched_topology(void)
>   
>   	if (has_coregroup_support()) {
>   		powerpc_topology[i++] =
> -			SDTL_INIT(tl_mc_mask, powerpc_shared_proc_flags, MC);

I would prefer not do this rename. having tl_mc_mask helps to find the usage across
the codebase.

> +			SDTL_INIT(powerpc_tl_mc_mask, powerpc_shared_proc_flags, MC);
>   	}
>   
>   	powerpc_topology[i++] = SDTL_INIT(tl_pkg_mask, powerpc_shared_proc_flags, PKG);


