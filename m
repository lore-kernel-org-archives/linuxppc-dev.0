Return-Path: <linuxppc-dev+bounces-21496-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F0EFCD5BB4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 05:25:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPh5m5004z2y8t;
	Tue, 26 May 2026 15:25:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779773100;
	cv=none; b=C7zqrDWujJNRqqOhWzRHYMumjN0t3IxN32O+04OEYHrctrIfqbDyBbEZGfQoDh53iLd7VnGY0/iJbX1vNUbESEl3tSrCsdSFsFHRmyjpfyS+siXuYP9JznFKIlBL1iY/h79iF624amzVuZTceU9cgsQjQCjWF/2wRzZazwx9sVo90GYPhQd7wYa40X+yK8ahrFKJ6eY5C+MOjP9eW0izvjS1sNqBrUuT4lCNVCgagATUp4kS/bvxjj0cOZqQu6wFQjiypXwxCvpZuoRt5T9s/orhfXOuDTRlpsqGkR5/ZmmcyutV2SmBzU3Uc7UvHk11+DzbcnI+lo1BCRSSw1is9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779773100; c=relaxed/relaxed;
	bh=wnMq+xvdorH/ELELt8cScK8ygoQfl8bDmhGz1Ko3n2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hOZK4Hj3qsVVhW5Xvm1u1tzPcDDojtTY98RkbAlWF9IZamWo5OTyRZpV7yLJFJlJlR3pljBw1uoQOpCEzi8D47qYX1oykNNwGtgyPYGuAVeVEzDyazPKJUTdDCf4w100kUlAct7Ng7e6TbUf5WsJPzHd0bBWo0boCUaivVHYxMKcvXz63uAVBlvEd05I/ksHox5I92SVbh/P5uEP+9tuhFaBUp4orsTESL2kG/+pJ7BhwfTR4Sycmvy9ZRiQxbycN7Vg1YOrlCUmlLiDeaXM1qbpj86XkDmadBZGDa9vGuSCi2WKsR12l+B3c3gO7nkIcQLLLqXfUHGh9agyToqq8g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hvpmki0j; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hvpmki0j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPh5l6hwyz2xjQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 15:24:59 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64Q2w1oW1359512;
	Tue, 26 May 2026 05:24:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wnMq+x
	vdorH/ELELt8cScK8ygoQfl8bDmhGz1Ko3n2A=; b=hvpmki0jNYInI4Szp6iQS1
	Fsm7RSOgDo2PV7vMiUa54E1OFxLQ36UHX6MOjCl8BKyXY5E7Nl/0Ta+Ko4BnRCCz
	m8bfhm+4n2Jt+nhstvpBJMr0WgzzWqQ7U0HMhE5piC+ZjKrP6KaUc/bz29EBAa+Q
	ffUyGqCmWPvzSDFRJDtAdyg2vN/GmeVILHKw12Z9VedAIrOelt5FNXh1NljKvhDn
	o9wXmEXJstEboMDMRT0+W21t2DeRs736iKCYgGLCYohRJw5COeDOdho2LpKxchPq
	vycv2sGykCslzJXwW4H6rjMvaOoV8SFnYGzNH5mVCoe0IeIl01RJ8fklOI5uiHag
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4pd9ky0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 05:24:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64Q5O5Ft029728;
	Tue, 26 May 2026 05:24:32 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ebr2gys1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 05:24:32 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64Q5OVN821299826
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 May 2026 05:24:31 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 634B158057;
	Tue, 26 May 2026 05:24:31 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 737F758058;
	Tue, 26 May 2026 05:24:27 +0000 (GMT)
Received: from [9.123.10.165] (unknown [9.123.10.165])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 May 2026 05:24:27 +0000 (GMT)
Message-ID: <8675afde-5c7f-4717-be7a-a473bd1af381@linux.ibm.com>
Date: Tue, 26 May 2026 10:54:25 +0530
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
 dereference in build_sched_domains on POWER9
Content-Language: en-GB
To: "Chen, Yu C" <yu.c.chen@intel.com>,
        Srikar Dronamraju <srikar@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-sched@vger.kernel.org, tim.c.chen@linux.intel.com,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com>
 <bca40921-d351-4439-ae6a-9e5294f23e2e@intel.com>
 <ahUQE-AgvOAQV_mI@linux.ibm.com>
 <a0e3f4f4-03b6-4bb1-881f-06bf5abca1a3@intel.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <a0e3f4f4-03b6-4bb1-881f-06bf5abca1a3@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OdqoyBTY c=1 sm=1 tr=0 ts=6a152e91 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=N8J75DuAAAAA:8
 a=QyXUC8HyAAAA:8 a=2Ry_GTzzjSFMXXZ5pSMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=nD1YRifxtKbQKNhUHPb7:22
X-Proofpoint-GUID: LKWAgWP4o7Ya6di9-OjtvEPzX9m6sHGW
X-Proofpoint-ORIG-GUID: LKWAgWP4o7Ya6di9-OjtvEPzX9m6sHGW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA0MSBTYWx0ZWRfXxO2mESjKGRG0
 L13kAPXHj2qs+IBE4M9G65O3oJSbuSsYl7WAAPemvj3/rG1ig22lVwZo+AvtUJcW1jc6XE1NDly
 UWbUtezlCBqDPkzkCnaMjG2qGbtcEDX6tYloozI+mnrosi0D+zWBZcfMiJIGKyG9v3c3vlAbspw
 mbfP31F4q3/H2PUE/nTe0gaF+qLec9N6BMQQSHw4VOkEAWp0EBCM7qGl+2VxsgDPoi636lenq5s
 ieyzGGK6YhbCPc0/6fbgWV/GxjuQ4f60zBQzqY8Nfu6jU3oEH9RXTCs7v5TT1RYYCU95GC99rRW
 MeV35dKSkG/XIe8i/PlS1WuJ2q+tg7dgSm1z4uXzemnkHi89gKVVvtjQkadE6nhsh9lBg894sBt
 Z25PNhGsYBSV6xm/3druwNc8qO08YJ8KTF8KsQoZ6x4JJMNa2s7GBme0nHiFn1jtZOI3205x7ZR
 6D2CQYLkSL6PXDRHe2Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-26_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260041


On 26/05/26 9:38 am, Chen, Yu C wrote:
> Hi Venkat,
>
> On 5/26/2026 11:14 AM, Srikar Dronamraju wrote:
>> * Chen, Yu C <yu.c.chen@intel.com> [2026-05-25 23:35:45]:
>>
>>> Hi Venkat,
>>>
>>> On 5/25/2026 10:07 PM, Venkat Rao Bagalkote wrote:
>>>> Greetings!!!
>>>>
>>>> I am seeing an early boot kernel panic due to NULL pointer dereference
>>>> on a POWER9 (pSeries) system when testing linux-next (next-20260522).


This issue is seen on P11 as well.

[    0.006697] smp: Brought up 1 node, 16 CPUs
[    0.006702] Big cores detected but using small core scheduling
[    0.006752] BUG: Kernel NULL pointer dereference on read at 0x00000000
[    0.006755] Faulting instruction address: 0xc000000020adbb6c
[    0.006759] Oops: Kernel access of bad area, sig: 7 [#1]
[    0.006762] LE PAGE_SIZE=4K MMU=Radix  SMP NR_CPUS=8192 NUMA pSeries
[    0.006767] Modules linked in:
[    0.006772] CPU: 4 UID: 0 PID: 1 Comm: swapper/4 Not tainted 
7.1.0-rc5-next-20260525 #1 PREEMPT(lazy)
[    0.006777] Hardware name: IBM,9080-HEX Power11 (architected) 
0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
[    0.006781] NIP:  c000000020adbb6c LR: c0000000202e5a58 CTR: 
0000000000000000
[    0.006784] REGS: c0000000283d7890 TRAP: 0300   Not tainted 
(7.1.0-rc5-next-20260525)
[    0.006788] MSR:  8000000002009033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 
44002242  XER: 20040003
[    0.006796] CFAR: c0000000202e5a54 DAR: 0000000000000000 DSISR: 
00080000 IRQMASK: 0
[    0.006796] GPR00: 0000000000000000 c0000000283d7b50 c000000021abf100 
0000000000000010
[    0.006796] GPR04: 0000000000000010 0000000000000030 0000000000000000 
c000000028365500
[    0.006796] GPR08: 0000000000000000 c000000022213598 000000003b77d000 
0000000000000000
[    0.006796] GPR12: c00000002005d8f0 c000000000008000 c0000000283cb578 
c0000000283cb400
[    0.006796] GPR16: c0000000283c9000 c000000022218b20 c0000000222330e8 
00000000ffffffff
[    0.006796] GPR20: fffffffffffffff6 0000000000000000 c000000022da36e0 
0000000000000000
[    0.006796] GPR24: 0000000000000000 0000000000000000 c0000000283c9178 
c0000000227b5f00
[    0.006796] GPR28: c00000002831c1e8 c000000022db5980 0000000000000000 
0000000000000000
[    0.006835] NIP [c000000020adbb6c] _find_first_bit+0xc/0xc0
[    0.006842] LR [c0000000202e5a58] build_sched_domains+0x7d8/0xb40
[    0.006847] Call Trace:
[    0.006849] [c0000000283d7b50] [c0000000202e5408] 
build_sched_domains+0x188/0xb40 (unreliable)
[    0.006854] [c0000000283d7c90] [c000000022034380] 
sched_init_domains+0x118/0x168
[    0.006860] [c0000000283d7ce0] [c000000022032b14] 
sched_init_smp+0xa8/0x158
[    0.006865] [c0000000283d7d30] [c000000022005674] 
kernel_init_freeable+0x1ac/0x294
[    0.006870] [c0000000283d7dd0] [c000000020011718] kernel_init+0x2c/0x1c4
[    0.006874] [c0000000283d7e30] [c00000002000debc] 
ret_from_kernel_user_thread+0x14/0x1c
[    0.006878] ---- interrupt: 0 at 0x0
[    0.006881] Code: eb610038 7fc3f378 eb810040 eba10048 38210060 
ebc1fff0 ebe1fff8 7c0803a6 4e800020 7c681b78 7c832379 4d820020 
<e9280000> 38e3ffff 39400000 78e7d7e2
[    0.006895] ---[ end trace 0000000000000000 ]---
[    0.006898]


Regards,

Venkat.

>>>
>>> It seems that cpumask_first(llc_mask(i)) is accessing
>>> NULL cpu_coregroup_mask():
>>
>>> has_coregroup_support() is false, thus cpu_coregroup_map
>>> is never allocated in smp_prepare_cpus().
>>> This machine is a "shared system" VM. We should probably
>>> let the LLC id generation fall back to using L2 id if
>>> cpu_coregroup_mask is unavailable (which restores the
>>> behavior before this patch). I'm wondering if the following
>>> change would help(need IBM friends' help on this):
>>
>> Power9 and below systems, dont have coregroup.
>> Its not because of shared LPAR. But its true for dedicated LPARs too.
>> Only Power10 and above systems have hemisphere where we add MC/coregroup
>> support.
>>
>
> OK, thanks for the correction. Are you saying coregroup_enabled is false
> on Power9 and older hardware, and set to true on Power10? Power10 has a
> corresponding device-tree property, which is parsed to enable hemisphere
> support in find_possible_nodes(). This is why has_coregroup_support()
> returns true for Power10.
>
>>>
>>> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
>>> index 3467f86fd78f..cf6c2e4190ab 100644
>>> --- a/arch/powerpc/kernel/smp.c
>>> +++ b/arch/powerpc/kernel/smp.c
>>> @@ -1042,11 +1042,6 @@ static const struct cpumask
>>> *tl_smallcore_smt_mask(struct sched_domain_topology_
>>>   }
>>>   #endif
>>>
>>> -struct cpumask *cpu_coregroup_mask(int cpu)
>>> -{
>>> -       return per_cpu(cpu_coregroup_map, cpu);
>>> -}
>>> -
>>>   static bool has_coregroup_support(void)
>>>   {
>>>          /* Coregroup identification not available on shared systems */
>>> @@ -1056,6 +1051,14 @@ static bool has_coregroup_support(void)
>>>          return coregroup_enabled;
>>>   }
>>>
>>> +struct cpumask *cpu_coregroup_mask(int cpu)
>>> +{
>>> +       if (!has_coregroup_support())
>>> +               return cpu_l2_cache_mask(cpu);
>>> +
>>> +       return per_cpu(cpu_coregroup_map, cpu);
>>> +}
>>> +
>>
>> While this is a work-around for the problem in Power9
>> It will hurt Power10 and Power11 systems.
>> As has been alluded by Prateek, MC is not LLC on Power.
>
> Could you please elaborate on the cache topology?
> Specifically, could you clarify what the LLC is for Power9
> and Power10 respectively? Is it always the L2 cache?
>
> I have checked the IBM documentation available at:
> https://hc32.hotchips.org/assets/program/conference/day1/HotChips2020_Server_Processors_IBM_Starke_POWER10_v33.pdf 
>
> According to the document, a hemisphere corresponds to a 64MB
> L3 cache shared by 8 cores. Since the MC domain spans a single
> hemisphere, I wonder why the SD_SHARE_LLC flag is not enabled
> for the MC domain?
>
>> So by using llc_mask as cpu_coregroup_mask() we run the trouble of 
>> assuming
>> MC to be similar to LLC. So it will impact Power 10/11 Systems.
>>
>> In commit b5ea300a17e3 sched/cache: Make LLC id continuous, we define
>> #define llc_mask(cpu) cpu_coregroup_mask(cpu)
>>
>> defining it llc_mask to cpu_coregroup_mask means MC should be LLC.
>> This is not true for some architectures atleast on Power.
>>
>
> OK.
>
>> So shouldn't it be using
>> #define llc_mask(cpu) per_cpu(sd_llc, cpu)
>>
>> This should work for systems where LLC is sub-coregroup, coregroup 
>> (or super
>> coregroup: Lets say some archs want LLC at PKG and cluster at 
>> coregroup).
>>
>> if we do that, I dont think we even need the else case where we say
>> #define llc_mask(cpu) cpumask_of(cpu)
>>
>
> I suppose you are referring to
> sched_domain_span(per_cpu(sd_llc, cpu)).
>
> Indeed, deriving the LLC from the SD_SHARE_LLC level offers
> better scalability. However, this approach would involve scheduler
> domains, which can be truncated by cpuset partitions - a scenario we
> prefer to avoid.
>
> thanks,
> Chenyu
>

