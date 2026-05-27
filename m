Return-Path: <linuxppc-dev+bounces-21553-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40DCDCD4F54
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 07:05:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQLHT52stz2xYh;
	Wed, 27 May 2026 17:05:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779865541;
	cv=none; b=NZCdLKX88tDE/NqfI36Q2ZB2xCn2p978zNUHMP5fdbLjepyXnUeiSKQe76by8kuoZgroHlUPmz9ie0/c5FmGZBBMR7qHedweIBszKrJB+g5SPxp7ZR17sV3m6ZirtFsuBXhHU/cVMocLlhXKEXSPHPiE9kv5Hc0tImaDEmrfs1YaN7HrATTrBLZQI7O8b+lRmC/s0RH+jczIjoNnlo/3GsBrsLrkiARmSaIWEI3ECeueVgRl6HUVdPaGNUgTv0753ZEj/jeNFuEwa8IBVpXxUj9jgOJvrqPSrpm69CQNV4as5/D6S4SQZutVAVue6UmjPBp2nPvrpnRLbR/hcQxfZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779865541; c=relaxed/relaxed;
	bh=O1aQP44ZoxAX72dAapJVEPm8r6aoaJ7Bb3zs5LEUm8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P6gOAHJ5YNN1Z+QcKSpuCU2VvuykPWS4Yiz/5pQ/Xl3DUkgBZoLAhwMX5GwsSQQ+LEERtve+t3krd3+ZAWprDxm/0i40ozZ2EFYOAT4nZRy22h5ONIR6f8J9c3z9wUupRhThzBdIefvNOyh9eFsququwkKZWWnhttROP5WsI9epEfnZgUyUNDGwrN8T13sKZtdccbiNtBsFEHKc9uM074qygrtMeBDDQK42yUslTgPUIHZb1uEOve0Vkd3xINUm2HL3cWSFfXRaaYyGVWrXbFr48jzSUrVh+5gxrnKFytNXLMZHILaiWbrjVrhKjw2BqFd+ogQlIIBSk7G/sUq312g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Qm1X/66J; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Qm1X/66J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQLHS6TK7z2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 17:05:40 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QL4lZk272399;
	Wed, 27 May 2026 07:05:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=O1aQP4
	4ZoxAX72dAapJVEPm8r6aoaJ7Bb3zs5LEUm8s=; b=Qm1X/66Jlw28c4bLoFquC7
	effKgcKlY6msT/R7evJNBpqwcAs38e9in+vtcUO3ZCcikay3FMyKqeq8BCr3JPrA
	9xQmtyk6LSdwgNiM+hkiNONo1RXI0ddHRpdAHMp89867oNozFHWP+tBlHIsNGq3k
	9CyCck3wY0X6RWau0QD6c9GQvzSS9vZzHxVU5pp5iUydpKmBVD9iOA1gJhzu4N7L
	2+/LsUvJld+ckVpIZYfy6bA5Ih6DDZe8Q4eHoo72oS0pp1AeA2yqYQgR9cuxXjuJ
	FINXe6TyrMc6vlK19Zn9Z/myfHm554CUHD1NBkQAYRrPk2r/pPsWVRMv35UKuVSg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nq6w3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 07:05:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64R6sMuZ014968;
	Wed, 27 May 2026 07:05:28 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrb1uh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 07:05:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64R75OHm57409810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 07:05:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A9DC20043;
	Wed, 27 May 2026 07:05:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 468F320040;
	Wed, 27 May 2026 07:05:21 +0000 (GMT)
Received: from [9.39.21.117] (unknown [9.39.21.117])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 May 2026 07:05:21 +0000 (GMT)
Message-ID: <eaefc945-f2e5-458c-9d63-ead737c982bf@linux.ibm.com>
Date: Wed, 27 May 2026 12:35:20 +0530
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
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-sched@vger.kernel.org, tim.c.chen@linux.intel.com,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Chen, Yu C" <yu.c.chen@intel.com>,
        Srikar Dronamraju <srikar@linux.ibm.com>
References: <51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com>
 <bca40921-d351-4439-ae6a-9e5294f23e2e@intel.com>
 <ahUQE-AgvOAQV_mI@linux.ibm.com>
 <a0e3f4f4-03b6-4bb1-881f-06bf5abca1a3@intel.com>
 <8675afde-5c7f-4717-be7a-a473bd1af381@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <8675afde-5c7f-4717-be7a-a473bd1af381@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: o36wkTYfmX6wkg53Xz2lLR8nf0TE3yUT
X-Proofpoint-ORIG-GUID: o36wkTYfmX6wkg53Xz2lLR8nf0TE3yUT
X-Authority-Analysis: v=2.4 cv=QIJYgALL c=1 sm=1 tr=0 ts=6a1697b8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=QyXUC8HyAAAA:8
 a=Vc7GBhowq85ZZSl4faYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDA2MiBTYWx0ZWRfX3qzY6zTHIpWp
 e/6FccgoVaINBGawA/Uabhyy8A6e+mULpK8QGKT3s2v0ivXsW3v4SaX1K6lxY2RavxPckP/UG1Q
 e68sCEjOrgWeSC07NPI4AT/22STdbxUGt5/irfkPEKXY6DvWG7u04ho0MYfoyr/FBzoqc9maQ2u
 D4bySOsHPbzJL5JyusuaKtp2mTP7A3kZtMzRLe15AzPCj2t3EITJFvbJYWaspg5uh5Ez+yBLE6h
 DI4q8K4xDSRKm6nnTrHuGlG7reoKsK8WZz5ft01hIJXlLzkGatNhwBnv5uuWXMocFXKJHFLEl7z
 GUXO40RVuqvuIYDw5DRGmYaPuPA9NnIVD+G1CZR0D2XyzF/JVs9gSvonpu+DtQ8Rk1DIO6tNjXf
 j6IsSm00BRRrz+7JW64wX1e2H8p+ClGzmScMj2iGK6nNHCNY7bnl4lELZcOfAD7K/8IcgQcsl4J
 YWMhH0GjHPHdbAs1oIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605270062



On 5/26/26 10:54 AM, Venkat Rao Bagalkote wrote:
> 
> On 26/05/26 9:38 am, Chen, Yu C wrote:
>> Hi Venkat,
>>
>> On 5/26/2026 11:14 AM, Srikar Dronamraju wrote:
>>> * Chen, Yu C <yu.c.chen@intel.com> [2026-05-25 23:35:45]:
>>>
>>>> Hi Venkat,
>>>>
>>>> On 5/25/2026 10:07 PM, Venkat Rao Bagalkote wrote:
>>>>> Greetings!!!
>>>>>
>>>>> I am seeing an early boot kernel panic due to NULL pointer dereference
>>>>> on a POWER9 (pSeries) system when testing linux-next (next-20260522).
> 
> 
> This issue is seen on P11 as well.
> 
> [    0.006697] smp: Brought up 1 node, 16 CPUs
> [    0.006702] Big cores detected but using small core scheduling
> [    0.006752] BUG: Kernel NULL pointer dereference on read at 0x00000000
> [    0.006755] Faulting instruction address: 0xc000000020adbb6c
> [    0.006759] Oops: Kernel access of bad area, sig: 7 [#1]
> [    0.006762] LE PAGE_SIZE=4K MMU=Radix  SMP NR_CPUS=8192 NUMA pSeries
> [    0.006767] Modules linked in:
> [    0.006772] CPU: 4 UID: 0 PID: 1 Comm: swapper/4 Not tainted 7.1.0- 
> rc5-next-20260525 #1 PREEMPT(lazy)
> [    0.006777] Hardware name: IBM,9080-HEX Power11 (architected) 
> 0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
> [    0.006781] NIP:  c000000020adbb6c LR: c0000000202e5a58 CTR: 
> 0000000000000000
> [    0.006784] REGS: c0000000283d7890 TRAP: 0300   Not tainted (7.1.0- 
> rc5-next-20260525)
> [    0.006788] MSR:  8000000002009033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 
> 44002242  XER: 20040003
> [    0.006796] CFAR: c0000000202e5a54 DAR: 0000000000000000 DSISR: 
> 00080000 IRQMASK: 0
> [    0.006796] GPR00: 0000000000000000 c0000000283d7b50 c000000021abf100 
> 0000000000000010
> [    0.006796] GPR04: 0000000000000010 0000000000000030 0000000000000000 
> c000000028365500
> [    0.006796] GPR08: 0000000000000000 c000000022213598 000000003b77d000 
> 0000000000000000
> [    0.006796] GPR12: c00000002005d8f0 c000000000008000 c0000000283cb578 
> c0000000283cb400
> [    0.006796] GPR16: c0000000283c9000 c000000022218b20 c0000000222330e8 
> 00000000ffffffff
> [    0.006796] GPR20: fffffffffffffff6 0000000000000000 c000000022da36e0 
> 0000000000000000
> [    0.006796] GPR24: 0000000000000000 0000000000000000 c0000000283c9178 
> c0000000227b5f00
> [    0.006796] GPR28: c00000002831c1e8 c000000022db5980 0000000000000000 
> 0000000000000000
> [    0.006835] NIP [c000000020adbb6c] _find_first_bit+0xc/0xc0
> [    0.006842] LR [c0000000202e5a58] build_sched_domains+0x7d8/0xb40
> [    0.006847] Call Trace:
> [    0.006849] [c0000000283d7b50] [c0000000202e5408] 
> build_sched_domains+0x188/0xb40 (unreliable)
> [    0.006854] [c0000000283d7c90] [c000000022034380] 
> sched_init_domains+0x118/0x168
> [    0.006860] [c0000000283d7ce0] [c000000022032b14] 
> sched_init_smp+0xa8/0x158
> [    0.006865] [c0000000283d7d30] [c000000022005674] 
> kernel_init_freeable+0x1ac/0x294
> [    0.006870] [c0000000283d7dd0] [c000000020011718] kernel_init+0x2c/0x1c4
> [    0.006874] [c0000000283d7e30] [c00000002000debc] 
> ret_from_kernel_user_thread+0x14/0x1c
> [    0.006878] ---- interrupt: 0 at 0x0
> [    0.006881] Code: eb610038 7fc3f378 eb810040 eba10048 38210060 
> ebc1fff0 ebe1fff8 7c0803a6 4e800020 7c681b78 7c832379 4d820020 
> <e9280000> 38e3ffff 39400000 78e7d7e2
> [    0.006895] ---[ end trace 0000000000000000 ]---
> [    0.006898]
> 
> 
> Regards,
> 
> Venkat.
> 

Venkat,

Was it on P11 on Shared LPAR?

