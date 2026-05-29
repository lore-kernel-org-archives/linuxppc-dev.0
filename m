Return-Path: <linuxppc-dev+bounces-21680-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7EF7CD5BD2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 06:59:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRZ3j3QZKz2xnK;
	Fri, 29 May 2026 16:59:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780037985;
	cv=none; b=W3DtmCnz2NlAKIT5hWURFUxYVrrzOFbKauF0B9ajDQynTjzK1xqkdFWq+hK6przrSYEGwKSBnhZhOg++boMpNRQkjAq9yN3Pd2iMJ/+YzN1+tJb84okyRHe8m3AFmZiCv8ZDYPqegloJbKYKiSEjFDeV7uR1i0XMvMqy1t54X6B+wr+3zTEohJcORnz9+chkLOAUV+4L+SwR43wMiEgOkyJV5hOPcYhRsaEeUeY5hTDIiKu/h3vhaAC6Do6h2S7wacnrKyNzYahJB+2XWs5Ce/irXoTcp52Uv7reO96bmvzaxw43WZdMo3L1LzUZMmlVaa8LPc8Svt/4EaFiea9Yng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780037985; c=relaxed/relaxed;
	bh=XfWkutqJcgw5mPwttpn5Eb9YOub78ax6IhTgr4R7FKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eXovtmc9tvSR89ZD0XtEDXkP+q9WVTMdff1If64DYm4NX855fOXWR1dPmAK2AGh+WqvSC8+DIdX2n+Dh1Llmmt0Ob29ptDLc+nMYmWZoxhsOFrKGaSBJhFj9/fG73qQgYhQf93PPm9ylx084/eHL+L/NNKf6XWhlkHnLJk9fOMnlS4rxnPwPm/fhalL06UWvxq2+nmmdzNBDTnjlRR+im732r9/5CPHaBI5JTNKR35L4X4LloJJ3SKUWqUWx1JYWFlb+j2kgrYdbMVtDSvcdo3/Q5hfAZls4htI/6Wk6nzHeHjHnq514tFFAtvZNbmP7SLvCAqrnj460rf3No3w5Qg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PflULOIn; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PflULOIn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRZ3h5GL4z2xWP
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 16:59:44 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SLmq972420645;
	Fri, 29 May 2026 06:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XfWkut
	qJcgw5mPwttpn5Eb9YOub78ax6IhTgr4R7FKs=; b=PflULOInoew+BA/mVBOJoS
	eGWd0ZsTK3KSqC9r7++9SysFyFHyDCuYhjlx7Mq+32dGVVt6rZyyWWDpU5ersvxq
	+KrgqJ0tewHQuPODYiVFfh+SUvJd9yMTDazF3GtkVZVAq/1cgCHDoVkjXPvCs8+J
	pVIdQIpE2HEm8R6lAt4lbqfFfPPH8Luv7YRblrMFDd9nbOuEZmsv+5+bqrEcI3Yl
	o98kUPFJO2ox8qmNPHgWKi/ldqc3M6mVR826a5oqmNnrScU0qtE5MSRKArm/Eqje
	2yjDOGKt4jcKkwevDwcJarGd0vlces39T0WrDqnhxq+EZJx/i65ekkZQwlnNkGDQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884q4xg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 06:59:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64T6s6Tc018472;
	Fri, 29 May 2026 06:59:29 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrbc4ac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 06:59:29 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64T6xSK926739312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 06:59:28 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1569558056;
	Fri, 29 May 2026 06:59:28 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6ADE58052;
	Fri, 29 May 2026 06:59:24 +0000 (GMT)
Received: from [9.61.245.85] (unknown [9.61.245.85])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 06:59:24 +0000 (GMT)
Message-ID: <8d1485ae-8a9a-4991-8ca7-9ff7b6c4aca9@linux.ibm.com>
Date: Fri, 29 May 2026 12:29:23 +0530
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
To: Shrikanth Hegde <sshegde@linux.ibm.com>,
        "Chen, Yu C"
 <yu.c.chen@intel.com>, tim.c.chen@linux.intel.com,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Srikar Dronamraju <srikar@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com>
 <85ff1fec-632c-4e5a-9b47-5d4b4a70a1a2@linux.ibm.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <85ff1fec-632c-4e5a-9b47-5d4b4a70a1a2@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=L4MtheT8 c=1 sm=1 tr=0 ts=6a193952 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=_aYY1UhqxzgcnjgfhtgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ZGEAhgQCCpiCiO-y2cpolK9UMFLIvlNY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDA2MiBTYWx0ZWRfX/39rA8D4YEK/
 d7yJnPn0Hkuj6/jNot0N3AWdu3dKEceMU1jwI9hzS4sA1dW4Sxg4G1xL22LgLD8bB1QNQN5QZbL
 kj8P/rDw2iaQwiEARr12+Kiisa38inBS1Yy1gw0bkSL1ke9Nzbomel8PNjtk+1mcMkju2oXw2Mz
 PgdhOmZvlPt7x1fgAaw56tXlwHaT59FYivhdxnY+T7NbCqWlwH3IGBfI7UM9D5RSVBN0aLi0vTZ
 AoMPtTFq+AfP/pNb+q9kBGbcUj5h8/uu51DI1134sDKH+QZQ02MGgzCREvz6EJ8IFOiv1R8x5IU
 xado+M5hNLWzvqlFJiQd2/j/pnGE9tH2HP2SikXDhWC7KQgPxIQxETd+6sFf7XnOw9sYbNmjHZs
 7jEdYOTmXDWYAAfQQa6birZr1i1ELnG7ktwBEIUEDftauGVEnmo31anY8CYTOQGBA4yFg36QhPl
 NznyBnfmR/JrmSTGZUA==
X-Proofpoint-GUID: ZGEAhgQCCpiCiO-y2cpolK9UMFLIvlNY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290062


On 29/05/26 9:28 am, Shrikanth Hegde wrote:
> Hello. Sorry for too many mails.
>
> On 5/25/26 7:37 PM, Venkat Rao Bagalkote wrote:
>> Greetings!!!
>>
>> I am seeing an early boot kernel panic due to NULL pointer 
>> dereference on a POWER9 (pSeries) system when testing linux-next 
>> (next-20260522).
>>
>>
>
> Based on srikar's suggestion to keep the below,
> #define arch_llc_mask(cpu)     cpu_l2_cache_mask(cpu)
>
> which makes it pretty much what chenyu had here
> https://lore.kernel.org/all/8d14c844-b4a8-4af6-acab-2cfdd42225be@intel.com/ 
>
>
> I added the changelog and comments. removed the changes in !CONFIG_MC 
> case since powerpc
> defines it always. I have changed the chenyu tag to Co-developed-by: 
> instead.
>
> I have carried the tested-by and reviewed-by tags since patch is
> still more or less the same.
>
> This is based on tip/master at
> 5c89783224e9  Merge branch into tip/master: 'x86/tdx'
> I am planning to send it based on tip tree.
> Let me know if has to be against a any different tree.
>
> Please let me know if there are any concerns.
> verified below too fixes the panic seen in shared LPAR.
>
> ============================================
>
> From: Shrikanth Hegde <sshegde@linux.ibm.com>
> Date: Thu, 28 May 2026 23:23:43 -0400
> Subject: [PATCH] sched/topology: Provide arch_llc_mask for cache aware 
> scheduling
>
> Venkat Reported a boot kernel panic next-20260522. Git bisect pointed to
> b5ea300a17e3 ("sched/cache: Make LLC id continuous")
>
> Stacktrace points to llc_mask being null.
>
> NIP [c000000000e58504] _find_first_bit+0x44/0x130
> LR [c000000000e58500] _find_first_bit+0x40/0x130
> Call Trace:
> build_sched_domains+0xad8/0xe50
> sched_init_smp+0xa8/0x164
> kernel_init_freeable+0x250/0x370
> ret_from_kernel_user_thread+0x14/0x1c
>
> On powerpc, cpu_coregroup_mask is available only when the underlying
> hardware support coregroup. In shared LPAR, QEMU guest or power9 etc
> coregroup isn't supported. In such cases llc_mask was being referenced
> when it was null leading to panic.
>
> on powerpc, LLC is at SMT core level. So assumption that coregroup(MC)
> domain point to LLC is wrong. Provide a way for archs to say where its
> LLC is if it not at MC domain.
>
> Fixes: b5ea300a17e3 ("sched/cache: Make LLC id continuous")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: 
> https://lore.kernel.org/all/51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com/
> Reviewed-by: Chen Yu <yu.c.chen@intel.com>
> Tested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Co-developed-by: Chen, Yu C <yu.c.chen@intel.com>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---


Tested this fix, by applying on top of commit 
b5ea300a17e37eada7a98561fbd34a3054578713 and on P9, its booting fine. 
Please add the below tag.


Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.


>  arch/powerpc/include/asm/topology.h |  6 ++++++
>  kernel/sched/topology.c             | 13 +++++++++++--
>  2 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/topology.h 
> b/arch/powerpc/include/asm/topology.h
> index 66ed5fe1b718..e3de0f3d8b86 100644
> --- a/arch/powerpc/include/asm/topology.h
> +++ b/arch/powerpc/include/asm/topology.h
> @@ -135,6 +135,12 @@ struct cpumask *cpu_coregroup_mask(int cpu);
>  const struct cpumask *cpu_die_mask(int cpu);
>  int cpu_die_id(int cpu);
>
> +/* Points to where the LLC is. On power9 this will point at CACHE
> + * domain, On others it will point to SMT domain. In all cases
> + * cpu_l2_cache_mask points to where LLC is.
> + */
> +#define arch_llc_mask(cpu)     cpu_l2_cache_mask(cpu)
> +
>  #ifdef CONFIG_PPC64
>  #include <asm/smp.h>
>
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index df2ceb54c970..622e2e01974c 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2063,12 +2063,21 @@ const struct cpumask *tl_mc_mask(struct 
> sched_domain_topology_level *tl, int cpu
>      return cpu_coregroup_mask(cpu);
>  }
>
> -#define llc_mask(cpu) cpu_coregroup_mask(cpu)
> +/*
> + * Majority of architectures have LLC at MC domain level with exception
> + * such as powerpc. Provide a way for arch to specify where its LLC is
> + * if it falls in exception category
> + */
> +# ifndef arch_llc_mask
> +#define arch_llc_mask(cpu) cpu_coregroup_mask(cpu)
> +# endif
>
>  #else
> -#define llc_mask(cpu) cpumask_of(cpu)
> +#define arch_llc_mask(cpu) cpumask_of(cpu)
>  #endif
>
> +#define llc_mask(cpu) arch_llc_mask(cpu)
> +
>  const struct cpumask *tl_pkg_mask(struct sched_domain_topology_level 
> *tl, int cpu)
>  {
>      return cpu_node_mask(cpu);

