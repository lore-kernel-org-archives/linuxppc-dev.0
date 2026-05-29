Return-Path: <linuxppc-dev+bounces-21706-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D22CD5BD2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 10:15:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRfPq4RHsz2yQL;
	Fri, 29 May 2026 20:15:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780049743;
	cv=none; b=UAaCSGIpRqRnyplTfD9R97I/A8qebQIO+rsogbBB2p2oi+moOkrCMRTveBC8CLJhWY3nuvbVu2s8ZMk8V6wLM4P2pqKVDJRRFJDdwrlAz0TNmF5ytERJCoox/s5m2Vi4gJsvrwz1UXyRifCwQGB6/oD7NXOImAqLhLdvCmpg8DEzWKeJPB2a6rBB3DdDf0pQ4TbrNDvr/mG94lYL3rYTur3QvavYNzfQJfP8HCP9ko7t/kajpRLsmT9TKREl/SPFNyF1CtARN3hRIeXBSpVmeLXOm4NjTn2sa17TUWZfCv5p5zO+Yt7BDFUkR0S3VCrWq/bhOEngsbiFX2qLKEGJ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780049743; c=relaxed/relaxed;
	bh=uy6t5ppD1nY+GglA2XoAiIuSE97XRVs9Lr9qT794SiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ku+coZvML/gH0XFPIem7sCEEh69yGo3jh+bwQMH5r3c35hrG3/phGEdcDqzw+ohHaWxEQq11bnNPvYHXX3NZ2bcnZCms4dDRGFfTVcqG6iirnzdXiOoIPQhaRHlXUNyZlvJh4kJEYuwJjoWcWTXZ+4Wmo3UBWP1Y18hyPtHgyS7MMswGGsKM8I0H5hJ+TiD0lwQPn+eBfzr8xZkOKq223lNdj1rJMuLPJU1xWwfGdEoCtLVEfnzqxZ4CKOxRLnFdhVqjB/fUp5p9yyIcViRuGgwil4Ed+aWWomNtjmjMQfGDeDJfvNtqnRhc3hSWoQdHVl9i1ws81/8hoSOUsedkQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hSV/vthy; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hSV/vthy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRfPp4DVsz2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 20:15:41 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SLlhCX1684655;
	Fri, 29 May 2026 10:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=uy6t5ppD1nY+GglA2XoAi
	IuSE97XRVs9Lr9qT794SiM=; b=hSV/vthy5rrvWcEUEjF4xtTtt9H9DHoUg0Xep
	3ApAMW9c2I4KPMujcrYH0TRZvo3ZQih7Fh0aeGXcA2TB/loEV3ytkRt39hZqQ/xq
	lXpR6B31EpPhZ7RpxB+sXO2xrIlOxk0rOnFRTEPqvC9zjZXuNlX8jHMR1sIimI11
	RRuu7SpulT8s9arHUhkyFPKXrrVOwcwcU/HNDdJeUIk4cN5I+13GKtlhSdR3yOzy
	TdF55pQ9LOxYegcElLsjEq9At3DbpmPBByM8qQcrlcsgq23HT6d66MlM5HAZqRnA
	Dlcp7Vq6JdmhwYnK1+fR/xajeHiGCgIkr4Zam/MdC7h0egiUg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884g1k9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 10:15:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TA9O0q022777;
	Fri, 29 May 2026 10:15:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrc51nb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 10:15:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TAFMWe8454638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 10:15:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E223F20040;
	Fri, 29 May 2026 10:15:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 438582004B;
	Fri, 29 May 2026 10:15:19 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.126.150.29])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri, 29 May 2026 10:15:19 +0000 (GMT)
Date: Fri, 29 May 2026 15:45:18 +0530
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, peterz@infradead.org,
        mingo@kernel.org, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, venkat88@linux.ibm.com,
        yu.c.chen@intel.com, tim.c.chen@linux.intel.com,
        kprateek.nayak@amd.com, riteshh@linux.ibm.com, stable@vger.kernel.org,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: Re: [PATCH] sched/topology: Provide arch_llc_mask for cache aware
 scheduling
Message-ID: <ahlnNsaQH-zg5tV2@linux.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.ibm.com>
References: <20260529075712.1181039-1-sshegde@linux.ibm.com>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20260529075712.1181039-1-sshegde@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=fIYJG5ae c=1 sm=1 tr=0 ts=6a19673f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=8nJEP1OIZ-IA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8 a=UZhIc3m1dWDYcD9tvD4A:9
 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: 84M-2t6QsD-y15zqN6r6FdqxPN0jhaF7
X-Proofpoint-GUID: nwXy-Tm7YMjuiWDOdsK30iKORNlUITXV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDEwMCBTYWx0ZWRfX0hnZS8YC9wVD
 QYHyvNoXC7jpVx4jT4ZppDeHTeUMTEG44HcJCPGjY+X5k35NAcp+lgDjS9Xeuiquo0i5OVPf3Ug
 F6AOhd1y6Oq21MPVjdqXIAkeUaeeY57mmSS+NZsLEmKlvGS5B33iW+C+L0IWfiZOpVl17AI4k4b
 RXNnyJT005qyFGtXLiOFx83jHP9aA3mfQaMQTYz2bxWVUbFp3gS2QnWs5+OK4TgIVvp/HoAfmjg
 2VJZI7snZylAcFPpQOhcpR/IznVm8dl+7Z8orZurntX1Egwqp6XW+y5z56fO677L3Hs4/wH0QUi
 BRPaZ+DfXzeIB9DUoVEea2OJcsltl8vPbIEgWQEk5zISDLuP63EzQbQTfOLN5iDt0ANLCWVMikV
 PF0C5JpQp716vfHUbKuAteErBIZSo+lpNJ3qPyP04597c1KeKpVEvy6dBOh6gERYwIAqLk0k/WA
 wO4C6zDxnCtrYIiO5UA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290100

* Shrikanth Hegde <sshegde@linux.ibm.com> [2026-05-29 13:27:12]:

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
> On powerpc, LLC is at SMT core level. So assumption that coregroup(MC)
> domain point to LLC is wrong. Provide a way for archs to say where its
> LLC is if it not at MC domain. 
> 
> Based on tip/master at 5c89783224e9 ("Merge branch into tip/master: 'x86/tdx'")
> Cc: stable@vger.kernel.org
> 
> Fixes: b5ea300a17e3 ("sched/cache: Make LLC id continuous")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/all/51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com/
> Reviewed-by: Chen Yu <yu.c.chen@intel.com>
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com> 
> Tested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Co-developed-by: Chen, Yu C <yu.c.chen@intel.com>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/topology.h |  6 ++++++
>  kernel/sched/topology.c             | 13 +++++++++++--
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
> index 66ed5fe1b718..e3de0f3d8b86 100644
> --- a/arch/powerpc/include/asm/topology.h
> +++ b/arch/powerpc/include/asm/topology.h
> @@ -135,6 +135,12 @@ struct cpumask *cpu_coregroup_mask(int cpu);
>  const struct cpumask *cpu_die_mask(int cpu);
>  int cpu_die_id(int cpu);
>  
> +/* Points to where the LLC is. On power9 this will point at CACHE
> + * domain, On others it will point to SMT domain. In all cases
> + * cpu_l2_cache_mask points to where LLC is
> + */

Nit: Regular comment style could have been better.

> +#define arch_llc_mask(cpu)     cpu_l2_cache_mask(cpu)
> +
>  #ifdef CONFIG_PPC64
>  #include <asm/smp.h>
>  
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index df2ceb54c970..622e2e01974c 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2063,12 +2063,21 @@ const struct cpumask *tl_mc_mask(struct sched_domain_topology_level *tl, int cpu
>  	return cpu_coregroup_mask(cpu);
>  }
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
>  #else
> -#define llc_mask(cpu) cpumask_of(cpu)
> +#define arch_llc_mask(cpu) cpumask_of(cpu)
>  #endif
>  
> +#define llc_mask(cpu) arch_llc_mask(cpu)
> +

Instead of having another define, could we have modified current users of
llc_mask() to arch_llc_mask()? Again its not a problem, but why have 2
defines since both point to the same thing.

>  const struct cpumask *tl_pkg_mask(struct sched_domain_topology_level *tl, int cpu)
>  {
>  	return cpu_node_mask(cpu);
> -- 
> 2.47.3
> 

Otherwise, looks good to me.

Reviewed-by: Srikar Dronamraju <srikar@linux.ibm.com>

-- 
Thanks and Regards
Srikar Dronamraju

