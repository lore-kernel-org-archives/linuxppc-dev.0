Return-Path: <linuxppc-dev+bounces-21604-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84276CD4F54
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 18:07:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQczZ6xlcz2ySJ;
	Thu, 28 May 2026 04:07:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779905274;
	cv=none; b=c0xml6A997IfpduUsPG06bA7iYJfY70mTKgSoXs/eNZP3f3834VOCO1cOxRfMqWSqLwtZs58mQbRqKtfZXjLyu1lapiRMFVmU0jW6OfuiUE+M8tO5xll3kgre2M7wfPW54qzcIIAt+kH3iY0bnMwPGV8KaHw17Ao81aMniXJcWJNHjBDvaRLpE9ktP+XjK1wFOHJU/PIQBy8x8bPAEZWzTviqvBEVC3qmQDb9Bk97GnCwmESiMrWVCkSIAwXH77cFY6wGrWsDn5sBhPJUnBwkyUcud4628k4LkCW/fUGAe6dVMdEtJc4NFYqgaErCTg3KZJq0FWkXkyPEh0FJnl65A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779905274; c=relaxed/relaxed;
	bh=0MOXoSm/nGySOe5YkZQIyuBpPebHGJpOJFn3JXoRPDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TasSTEomDJeKf4c+YDi436ouT981MHPaeoEWNtWVmnGPC3jqb7XMI3AJIg4W76pPMec0TVUik8RCUCjprzmtbyN6bjofWsQb4NoJi/dmuZ7NlLx12JyGNW/YlLinG1mWhteiGZ/b8Asi3bkHyGcAms3T8WInkrwRcQfSP1KJ6YsL3HENeD+yzLxKugJjWFIz9NHMLvGBVbKw3N0A0JcF4RDVxyiuUjBe5eD5B34jbTpdv42Fhz65VR1gWR4FqV6IiD6unnZILhi1iKvwisTF2WhizpmmJZQSNqtyeyFudE5mf6DGv2A7XtYMDoKD09S6Bw2AlFvq9uqBtdSV19I2tQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TzsuE3oF; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TzsuE3oF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQczY5P8jz2ySC
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2026 04:07:52 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RDDgZq735816;
	Wed, 27 May 2026 18:07:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0MOXoS
	m/nGySOe5YkZQIyuBpPebHGJpOJFn3JXoRPDE=; b=TzsuE3oFOJOutyz310zqy+
	DzDl4z16llvHotxFMReSCNLEtPWD2yaMHU+NMnFWvhsu/6A4IT8vW04+34o9Kxjg
	atltfZAVHA2OHdEJjqFnACsk/PSV/d0BUizWAd5uiH3NCwWCybhjryWW5pdbzkaU
	YnnCUTkxBGIp9UvKSUFtHK+3yvHt09VGsq6vwrmKF1ZNdeYIbokQpZoUw+0La8ER
	TKGDB8+UvMfstdfj7e/9YUcTTlfa/81oZTmm38Ken7OvuRerXCXqxxkHpyeh0uKn
	f5IzKdKCBW9RtdrcApIu/NGc1lkzwC4D2cdGO9cK8nh39mjJJ7OJidbdlN7WP8Kw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nc9fp9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 18:07:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64RHs69a023938;
	Wed, 27 May 2026 18:07:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrb4b03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 18:07:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64RI7YD523593434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 18:07:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71A8620043;
	Wed, 27 May 2026 18:07:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9AFB20040;
	Wed, 27 May 2026 18:07:31 +0000 (GMT)
Received: from [9.39.21.117] (unknown [9.39.21.117])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 May 2026 18:07:31 +0000 (GMT)
Message-ID: <42a19577-fe56-44b4-b0ed-37cde6d03ff5@linux.ibm.com>
Date: Wed, 27 May 2026 23:37:30 +0530
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
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <912676bc-230e-410f-a5fe-153b0f304aee@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=VvYTxe2n c=1 sm=1 tr=0 ts=6a1732eb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=zd2uoN0lAAAA:8 a=QyXUC8HyAAAA:8 a=8uysP2Pe3OK28tamSnoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: G8fU30n7A9ishNSDb65urDp_ZQfE6Loj
X-Proofpoint-GUID: G8fU30n7A9ishNSDb65urDp_ZQfE6Loj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE4MiBTYWx0ZWRfX21jYUvSMUaJ/
 SJ/Ipxwzd9PcumlFChPAgvqWR+qX82m8bB2PY264VP4cgTvtfegT5jwR/Kkr9fErVGWAt8NBD7u
 r2tSisjvovCVgHA1nnSHwKasHdWGqsvpxmxcfboaxQ9oxeYQ/BakibVFNIEP/f9wfREcs2aGmFl
 p1JNm8aQhftUkUn2/zRxSdUBTL7ibAgKTp2ce9dyUjyedpPC7PPTO6w85/9iVpbKZLJ82cCQMft
 lGdZ5WrkgFveegJa9oMi2tPTgxvAVZ4F/IShTKTEh62Et0FnH6km1Z8EUs+She4zJ/Xqa+UzYH6
 8a+MEfkSni84dyrSPC+l/ARzo9Z4n8VOvsgGOUv32VppRcnNFSTKdqlxDeOdZWBGD3W5cV7YIeY
 WbPTNMZv93AXxPaoqvekoyzOGmWq0xTkj4P1QLBL3gRfIj0f5VB1o0cB1nHfhkwtBP8uXtq/LM+
 Zt78qyzRGoGQma0uamw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270182

Hi Chen, Prateek.

On 5/27/26 9:35 PM, Chen, Yu C wrote:
> Hi Shrikanth,
> 
> On 5/27/2026 3:01 PM, Shrikanth Hegde wrote:
>> Hi Chen, Prateek.
>>
>> I got back to work today, sorry for delay.
>> I am trying to go through the mails.
>> Apologies in case i have missed any bits.
>>
> 
> Thanks for taking a look at this!
> 
>> On 5/26/26 7:38 PM, Chen Yu wrote:
>>> Hi Prateek,
>>>
>>> On Tue, 26 May 2026 11:23:59 +0530, K Prateek Nayak 
>>> <kprateek.nayak@amd.com> wrote:
>>>> Hello Srikar,
>>>>
>>>> On 5/26/2026 10:28 AM, Srikar Dronamraju wrote:
>>>>> L2 Cache reported here is for SMT8 Core aka CACHE domain.
>>>>
>>>> Apart for the scheduler, nothing in tree currently cares about
>>>> cpu_coregroup_mask() except for drivers/base/arch_topology.c but
>>>> Power doesn't select GENERIC_ARCH_TOPOLOGY.
>>>>
>>>> Why can't Power have an internal mask for MC domain (tl_mc_mask) and
>>>> the scheduler can use cpu_coregroup_mask() for the actual LLc? (The L2
>>>> mask in this case.)
>>
>> This seems wrong. there is no notion that coregroup_mask
>> (MC domain) has to point at LLC domain.
>>
>> For example, on Shared LPAR, there is no MC domain and LLC is at SMT 
>> core level.
>> In that case coregroup_mask has point at SMT mask is wrong.
>>
> 
> On Shared LPAR, highest_flag_domain(SD_SHARE_LLC) selected the
> SMT domain(L2 shared)prior to commit b5ea300a17e3.
> Prateek suggested changing cpu_coregroup_mask() to use
> cpu_l2_cache_mask(), which makes the LLC mask cover the same range.
> sd_llc, size and grouping remain unchanged. Only sd_llc_id becomes
> contiguous, which aligns with the intent of this commit.
> 
> But yes, the naming is confusing. cpu_coregroup_mask suggests a
> "group of cores", but after the change, it only covers threads
> within a single SMT core.
> 

Yes. Though it might achieve the same effect, keeping it explicit may
help in maintaining it better.

On PowerPC, there are these subtleties of Shared LPAR where MC domain
per se doesn't exit etc, and on power9 and earlier has different 
topologies. Maybe one could figure it all out and simplifies them into
a few masks. But yes, it is slightly different as of today.

>> If we need a mask to point to the LLC mask which arch has to return, 
>> then we would
>> need a new api say cpu_llc_mask ? that can point accordingly.
>>
> 
> Do you mean something like this?
> https://lore.kernel.org/lkml/8d14c844-b4a8-4af6- 
> acab-2cfdd42225be@intel.com/

Yes. This is something i prefer, but not to make it point to l2 mask 
always. See below diff which now make it boot on Shared Processor LPAR
where i see panic without it.

Need to add proper comments where appropriate.

diff --git a/arch/powerpc/include/asm/topology.h 
b/arch/powerpc/include/asm/topology.h
index 66ed5fe1b718..bd1db3b1dbb0 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -131,6 +131,9 @@ static inline int cpu_to_coregroup_id(int cpu)
  #ifdef CONFIG_SMP
  #include <asm/cputable.h>

+const struct cpumask *arch_llc_mask(int cpu);
+#define arch_llc_mask  arch_llc_mask
+
  struct cpumask *cpu_coregroup_mask(int cpu);
  const struct cpumask *cpu_die_mask(int cpu);
  int cpu_die_id(int cpu);
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 3467f86fd78f..26c15c786c55 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1101,6 +1101,13 @@ const struct cpumask *cpu_die_mask(int cpu)
  }
  EXPORT_SYMBOL_GPL(cpu_die_mask);

+const struct cpumask *arch_llc_mask(int cpu)
+{
+       if (has_coregroup_support())
+               return cpu_coregroup_mask(cpu);
+       return cpu_smallcore_mask(cpu);
+}
+
  int cpu_die_id(int cpu)
  {
         if (has_coregroup_support())
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index df2ceb54c970..3b5155121276 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2063,7 +2063,11 @@ const struct cpumask *tl_mc_mask(struct 
sched_domain_topology_level *tl, int cpu
         return cpu_coregroup_mask(cpu);
  }

+#ifndef arch_llc_mask
  #define llc_mask(cpu) cpu_coregroup_mask(cpu)
+#else
+#define llc_mask(cpu) arch_llc_mask(cpu)
+#endif

  #else
  #define llc_mask(cpu) cpumask_of(cpu)

(One more subtlety; crash would be seen only with NR_CPUS=8192 as 
CPUMASK_OFFSTACK=y, but that's a different concern altogether.)


> 
>> I don't like mixing MC domain and LLC into one bit.
>>
> 
> [ ... ]
> 
>>>   struct cpumask *cpu_coregroup_mask(int cpu)
>>>   {
>>> -    return per_cpu(cpu_coregroup_map, cpu);
>>> +    return cpu_l2_cache_mask(cpu);
>>> +}
>>
>> This looks wrong to me too. In different hardware topologies
>> there maybe distinction between coregroup and l2 mask.
>>
>> Let me go through the code and see if there is better way.
>>
> 
> Sure, please go ahead - I'm on board with the direction
> you settle on.
> 
> thanks,
> Chenyu
> 


