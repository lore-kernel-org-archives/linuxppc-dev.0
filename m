Return-Path: <linuxppc-dev+bounces-21639-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB3DACD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2026 16:32:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRBpq3vdHz2yVZ;
	Fri, 29 May 2026 02:32:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779985939;
	cv=none; b=XDCezdAFnQC43xjgVmU3Y8RD/uHVLs32EXkH2YLHrdaxguq4nZ0bkXzXX82monWNuYs3PEb9ZPAi0PYiYU1tjDjQoySmxxzCdWbvpDUr+UQVX3dmPTt8XzQnVSQ8ZNED8FvTe1eXFesYu9kcqnqY9yr/Aiifg1UBgQaEMme6cizrTKyvtbRqJ+kUU+fVuysFzttXKxJDewTRWwCuRsuebSb+ml/GX6ZFf0DpDxTLMNNTTyz7LxD/fG2GQU+f/cGlEo/F3UEJhM8LB7nv/4VwvBnzlBhJRN9yhSwOFMa79J17uq7CcGuqwVANzghkK2FDPiBgDMM1gH90jstxAx9mlg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779985939; c=relaxed/relaxed;
	bh=sZ/3zsgfFpr9WT6Sm6/DEKxy6a3g7HttVjuT1iUulT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ea8OWIewswibQd3rwO5Z0Fj5tWGRhuSS+rAi1VAZjijwF6kRdoE08TtDYpFPQufOp+waWq+ISCixDMXQdLVZNDC0lR6lYjZeaaktaLCqh0G0aghhs3c0V6EMu39zG6fL1L5M9bwTq8SCjrfkYMq7QV8SRJAiob82f0RR+NkNqYZxvItDoXcfDM1dxmzG25C3ARTCw/cMaOXBH9r05F6KvvhFQz1MpyGb+5xty6qz2rLw1L777g3MDO+knFeRLyRPo07zdc9orovRqriRbOWy1zW30Jnukc/VthgHyUI8yCxBIfF6gzv64pmQ9qeVJW/bqGOSFkcXDXGyocoF/4macw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GnPLXGv7; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GnPLXGv7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRBpn5v5Jz2yVP
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 02:32:17 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SDNLVC3786229;
	Thu, 28 May 2026 16:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sZ/3zs
	gfFpr9WT6Sm6/DEKxy6a3g7HttVjuT1iUulT0=; b=GnPLXGv75Vep5jgDCtliO4
	2m120FckaCwhR8eRLi6R5yrYYfHxwupm6JkexDoJU9GcQ4G7GMMp05QjN0ay91UO
	y1sOyCI0Z3AvRO3L5C67am+fzhT7cqSb2FYe9BjtS4HQOLoCziBG+kLmlAb0zBbz
	Iocz1m9qYg7IQnFO0VGH6uKEpevvPXp/ZWECqohHrRtPZOggbfxZZrzBPRId2Q2T
	WlNXlG1ulivwDXHCeB7BBENzD3TvpcArI1nyBQiTihpTd4/ZSHtG6vWapjJHu1Zz
	8N65eZ9XJihiYRBoxzj2SG3KAFbRZS7YHStRT12XP9no8WQOizPstBp4W3+2DS5Q
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee889bukp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 16:32:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64SGO8kP019383;
	Thu, 28 May 2026 16:32:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrc0x42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 16:32:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64SGVuJe30999038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 May 2026 16:31:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBF7F20043;
	Thu, 28 May 2026 16:31:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E20820040;
	Thu, 28 May 2026 16:31:54 +0000 (GMT)
Received: from [9.39.21.229] (unknown [9.39.21.229])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 May 2026 16:31:54 +0000 (GMT)
Message-ID: <3498bef8-8835-4971-a753-029d73acffc7@linux.ibm.com>
Date: Thu, 28 May 2026 22:01:53 +0530
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
To: Srikar Dronamraju <srikar@linux.ibm.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Chen, Yu C"
 <yu.c.chen@intel.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Peter Zijlstra <peterz@infradead.org>, tim.c.chen@linux.intel.com
References: <51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com>
 <74a61427-b5d8-41ad-bc5b-508ee246d510@linux.ibm.com>
 <ahhlrQ1XO47FusNi@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <ahhlrQ1XO47FusNi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: q44Cs2VvoVweE22JUP4ANzipouBX8VFV
X-Proofpoint-GUID: q44Cs2VvoVweE22JUP4ANzipouBX8VFV
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a186e01 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=QyXUC8HyAAAA:8 a=LYr38pXJs4cQmFbG4cYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE2MyBTYWx0ZWRfX4BO9CU0pnVBB
 JFH++PMmI7il7QBrgvVPxyEYx9PxvIOWmphNhci0LKUi265arUkTIMYcOHMoeDmvZZcJsZEw5oL
 UPwxAGJnkuRJBbTT5WfjYrXLMnI+h6OlmstI8FvAjtqcdCWIzdJZVHiNkiSZHFt78LnJx0KSzKt
 55Nf0Vn7zB7NkYHfPxoCtR/ol8q0PI7WWayyPlMge0aQrch4q6E2vilPlObSJ8patKMZa+xp+jY
 oUFm7KbFz1j2idrlNHbT8jmRYy8f+w2r1lbJbHJc4BvbHjc4lesrAaeCWCDjMJCQHaziRA7Vbgg
 +1bMk6kZpuKkIO9/3DRBsZ5S4BpJ9hbKoZJ1K05N5QP1ujy6jfPsT8ZEgiPE98R5FXdZd9oXa82
 KE6xorwe5scnUoNMtbYOpp9Frf03ITAuasEPothpQc2Dm11XU8+uT64ngkdmpsjQbzTA1YaDdKW
 26TB5ZuYO9/g2hBk62A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605280163



On 5/28/26 9:26 PM, Srikar Dronamraju wrote:
> * Shrikanth Hegde <sshegde@linux.ibm.com> [2026-05-28 16:57:54]:
> 
>>
>>
>> On 5/25/26 7:37 PM, Venkat Rao Bagalkote wrote:
>>> Greetings!!!
>>>
>>> I am seeing an early boot kernel panic due to NULL pointer dereference
>>> on a POWER9 (pSeries) system when testing linux-next (next-20260522).
>>>
>>
>> Hi Venkat, Ritesh,
>> Could you please try the below diff and see if it helps.
>> This helps to fix boot problem for SPLPAR for me.
>>
>> Hi Chenyu,
>> Let me know if I have to send the patch. Or
>> if you want to add more comments or change it feel free to pick it up and send it.
>> Either way is fine. Let me know.
>>
>> Hi Prateek, Srikar,
>> I hope the below diff makes sense. Please check.
>>
>> nit: llc_mask is still under CONFIG_SCHED_MC, for ppc it is set to true
>> always for SMP systems, and for others it is LLC domain. So not a concern i guess.
>> ---
>>
>>  From 10e9413cef063446d67dc02c2b44e1ea582e5d53 Mon Sep 17 00:00:00 2001
>> From: Shrikanth Hegde <sshegde@linux.ibm.com>
>> Date: Thu, 28 May 2026 06:16:44 -0400
>> Subject: [PATCH] topology: Provide arch_llc_mask for cache aware scheduling
>>
>> Venkat Reported a boot kernel panic next-20260522. Git bisect pointed to
>> b5ea300a17e3 ("sched/cache: Make LLC id continuous")
>>
>> Stacktrace points to llc_mask being null.
>>
>> NIP [c000000000e58504] _find_first_bit+0x44/0x130
>> LR [c000000000e58500] _find_first_bit+0x40/0x130
>> Call Trace:
>> build_sched_domains+0xad8/0xe50
>> sched_init_smp+0xa8/0x164
>> kernel_init_freeable+0x250/0x370
>> ret_from_kernel_user_thread+0x14/0x1c
>>
>> On powerpc, cpu_coregroup_mask is available only when the underlying
>> hardware support coregroup. In shared LPAR, QEMU guest or power9 etc
>> coregroup isn;t supported. In such cases llc_mask was being referrenced
>> when it was null leading to panic.
>>
>> on powerpc, LLC is at SMT core level. So assumption that coregroup(MC)
>> domain point to LLC is wrong. Provide a way for archs to say where its
>> LLC is if it not at MC domain.
>>
>> Fixes: b5ea300a17e3 ("sched/cache: Make LLC id continuous")
>> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>> Closes: https://lore.kernel.org/all/51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com/
>> Suggested-by: Chen, Yu C <yu.c.chen@intel.com>
>> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>> ---
>>   arch/powerpc/include/asm/topology.h |  3 +++
>>   arch/powerpc/kernel/smp.c           | 10 ++++++++++
>>   kernel/sched/topology.c             |  9 +++++++++
>>   3 files changed, 22 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
>> index 66ed5fe1b718..bd1db3b1dbb0 100644
>> --- a/arch/powerpc/include/asm/topology.h
>> +++ b/arch/powerpc/include/asm/topology.h
>> @@ -131,6 +131,9 @@ static inline int cpu_to_coregroup_id(int cpu)
>>   #ifdef CONFIG_SMP
>>   #include <asm/cputable.h>
>> +const struct cpumask *arch_llc_mask(int cpu);
>> +#define arch_llc_mask	arch_llc_mask
>> +
>>   struct cpumask *cpu_coregroup_mask(int cpu);
>>   const struct cpumask *cpu_die_mask(int cpu);
>>   int cpu_die_id(int cpu);
>> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
>> index 3467f86fd78f..cc8e87d6cae9 100644
>> --- a/arch/powerpc/kernel/smp.c
>> +++ b/arch/powerpc/kernel/smp.c
>> @@ -1101,6 +1101,16 @@ const struct cpumask *cpu_die_mask(int cpu)
>>   }
>>   EXPORT_SYMBOL_GPL(cpu_die_mask);
>> +const struct cpumask *arch_llc_mask(int cpu)
>> +{
>> +	/* Power9, CACHE domain is the LLC*/
>> +	if (shared_caches)
>> +		return cpu_l2_cache_mask(cpu);
>> +
>> +	/* For others, SMT domain is the LLC*/
>> +	return cpu_smt_mask(cpu);
>> +}
> 
> Why dont we do
> #define arch_llc_mask cpu_l2_cache_mask
> 

I would prefer to keep the abstraction. This leaves
room for implementation details.


