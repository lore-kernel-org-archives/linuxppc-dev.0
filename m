Return-Path: <linuxppc-dev+bounces-21635-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775B0CD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2026 15:56:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRB1t1Dz0z2xM7;
	Fri, 29 May 2026 01:56:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779983810;
	cv=none; b=CzxK+pGd/YPFIsaUKvZd5ey85SB/F/ORRzLdsARY24eMfth2WuMZ8OV++7qJvupskR9eTDavZlhBu7zwN6UiunmcPosXtSC129HCykX61iXhLUI0Emr2qXRnfaPAfucolEHmVUdI3Ff2UrEnLYznLq5ELVSpWOUv+DkcQ4kG7ZnjgxuS2lTZm+VMZSdDqeK+Hxx1WIhGTc9kpIPOZBmNW/nAnz09ip77ZkObengsfwz2jHZvMhlURkfkQPwfb6gu2dO0LR6wIA62WhRbPz3VP7anRscpD+Z4fnAnUoUsG7W/n1H10pvcMgG6X+nKfvsfXz3xM21TDWjW/YtO59kclQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779983810; c=relaxed/relaxed;
	bh=cNkxc9sLuJA0XrfBtdWwOnD8/eXz7hbYesaACC5IJ+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1Y8vaSOEvkuumiPQXb3AhIaLjHNnMu17Pre5pZi4dlCY+EFEb15PmxtkYGLFSG6169lOblO/pH5SnJlA492dndX2HNeMAZGSaRO76sqjyKzvebqQPFMF0rlv6iHNTHtnli9mrB1CvSjy2Z6ZmU+HK/1z1kGc6mTTu4wUeL92YvPOBx70jJ6GB2WF3+3a5oNAE56aZUCe0UPsfzriygLdIZF9lAxwoiMZgYzfdiECEBaQNCLASQQ1MUgQRsZS2Iw3fWlG0wPWoLDg8qNU3SRP0h2uB9gaD4Z5NYGPMK+PX/ppto2/3WZ9AyzKWxOiZzjdh1/tWDmAhbONDe56nnL+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YzcPUofA; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YzcPUofA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRB1s33l0z2xM6
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 01:56:49 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SC2aXo3782344;
	Thu, 28 May 2026 15:56:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=cNkxc9sLuJA0XrfBtdWwO
	nD8/eXz7hbYesaACC5IJ+k=; b=YzcPUofA+Sf9+qXcYymtGby9A+Ty+DKJsLqiy
	caUQsunVKAmD1gYOqzllWgWuiwuChdsyMgP9suwvoPXLe/MYP8XT6ussDHRmv2Rh
	LSiHiW4Y7TkUwHCfNNkEZxfDj/EQxJDIUWt90rgJZnzBHRrzSWMyXSwg6gl4RuSP
	MJTJ+PfgLeXEHlnP3CRNZPKTH0+kFYnpLEpxzMTUHkwaFi7cRPTYgEDOLdCOnSaF
	ik0VfEg+mHzZH1lBK2nXeZa9d1UN1f+8xgti2FCgBzptgR2n7MewoDFGi7MeFkcm
	64qsRigs88XcXKyNywtsqkyLVreyUkv7Gm92mCZLCIWkKZf7w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee889bq23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 15:56:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64SFsDgM020619;
	Thu, 28 May 2026 15:56:36 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrc0t4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 15:56:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64SFuW4i50528636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 May 2026 15:56:32 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B226620043;
	Thu, 28 May 2026 15:56:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F9DE20040;
	Thu, 28 May 2026 15:56:30 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.126.150.29])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 28 May 2026 15:56:30 +0000 (GMT)
Date: Thu, 28 May 2026 21:26:29 +0530
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Chen, Yu C" <yu.c.chen@intel.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Peter Zijlstra <peterz@infradead.org>, tim.c.chen@linux.intel.com
Subject: Re: [BUG] sched/cache: "Make LLC id continuous" causes NULL cpumask
 dereference in build_sched_domains on POWER9
Message-ID: <ahhlrQ1XO47FusNi@linux.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.ibm.com>
References: <51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com>
 <74a61427-b5d8-41ad-bc5b-508ee246d510@linux.ibm.com>
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
In-Reply-To: <74a61427-b5d8-41ad-bc5b-508ee246d510@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GqzKQX6ycKQC50mdvB6KJWXgjTpLdqKy
X-Proofpoint-GUID: GqzKQX6ycKQC50mdvB6KJWXgjTpLdqKy
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a1865b5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=8nJEP1OIZ-IA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=QyXUC8HyAAAA:8 a=LOsdni359b1Uqou2fmgA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE1OCBTYWx0ZWRfX3nmX+zRVu2I2
 PzFfRicTwB9U2lu6DVDYXjciHzoZWfDz/rr8rzcHGhp+8wVPTW/2m4w+OmQvQaidFPHU368cAyu
 saQo9IXcy0p0rziSQ1jKW+4nTb0T/sPMG9URxvWGZZtQXWX7z1RxRQfszKqf4t0+HD/D8SjyZQU
 h65ROYaSWu3F7rWkQHVqOQe69Plxb/x890PjLPblhua1MFqvWLsMsaL3zrUmcfGrLAvFcXVXwTn
 1ncRGUsHud+IkqQ2c+3978vYSUOdN/1PLTV0zkECvslaVTfRv3Ze3CmR3dI37gVdtBByFxe2Rhs
 ICC3u/0S9J+7jYWh8X0MJd16FLCMH1gk9k8NH/66RCZ/+UgkvVRc2CbZ4+l+I7F7Mhbz9FGgJjy
 WHaOD0AKJ8UNqxeATjRH5mnBctg9h1JMXGM3AB4Wj401OHYfKRbWjc9V5//HSUsRZG1eTH6/Fvm
 rSN8jcRMy1xELapNkIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605280158

* Shrikanth Hegde <sshegde@linux.ibm.com> [2026-05-28 16:57:54]:

> 
> 
> On 5/25/26 7:37 PM, Venkat Rao Bagalkote wrote:
> > Greetings!!!
> > 
> > I am seeing an early boot kernel panic due to NULL pointer dereference
> > on a POWER9 (pSeries) system when testing linux-next (next-20260522).
> > 
> 
> Hi Venkat, Ritesh,
> Could you please try the below diff and see if it helps.
> This helps to fix boot problem for SPLPAR for me.
> 
> Hi Chenyu,
> Let me know if I have to send the patch. Or
> if you want to add more comments or change it feel free to pick it up and send it.
> Either way is fine. Let me know.
> 
> Hi Prateek, Srikar,
> I hope the below diff makes sense. Please check.
> 
> nit: llc_mask is still under CONFIG_SCHED_MC, for ppc it is set to true
> always for SMP systems, and for others it is LLC domain. So not a concern i guess.
> ---
> 
> From 10e9413cef063446d67dc02c2b44e1ea582e5d53 Mon Sep 17 00:00:00 2001
> From: Shrikanth Hegde <sshegde@linux.ibm.com>
> Date: Thu, 28 May 2026 06:16:44 -0400
> Subject: [PATCH] topology: Provide arch_llc_mask for cache aware scheduling
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
> coregroup isn;t supported. In such cases llc_mask was being referrenced
> when it was null leading to panic.
> 
> on powerpc, LLC is at SMT core level. So assumption that coregroup(MC)
> domain point to LLC is wrong. Provide a way for archs to say where its
> LLC is if it not at MC domain.
> 
> Fixes: b5ea300a17e3 ("sched/cache: Make LLC id continuous")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/all/51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com/
> Suggested-by: Chen, Yu C <yu.c.chen@intel.com>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/topology.h |  3 +++
>  arch/powerpc/kernel/smp.c           | 10 ++++++++++
>  kernel/sched/topology.c             |  9 +++++++++
>  3 files changed, 22 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
> index 66ed5fe1b718..bd1db3b1dbb0 100644
> --- a/arch/powerpc/include/asm/topology.h
> +++ b/arch/powerpc/include/asm/topology.h
> @@ -131,6 +131,9 @@ static inline int cpu_to_coregroup_id(int cpu)
>  #ifdef CONFIG_SMP
>  #include <asm/cputable.h>
> +const struct cpumask *arch_llc_mask(int cpu);
> +#define arch_llc_mask	arch_llc_mask
> +
>  struct cpumask *cpu_coregroup_mask(int cpu);
>  const struct cpumask *cpu_die_mask(int cpu);
>  int cpu_die_id(int cpu);
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 3467f86fd78f..cc8e87d6cae9 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -1101,6 +1101,16 @@ const struct cpumask *cpu_die_mask(int cpu)
>  }
>  EXPORT_SYMBOL_GPL(cpu_die_mask);
> +const struct cpumask *arch_llc_mask(int cpu)
> +{
> +	/* Power9, CACHE domain is the LLC*/
> +	if (shared_caches)
> +		return cpu_l2_cache_mask(cpu);
> +
> +	/* For others, SMT domain is the LLC*/
> +	return cpu_smt_mask(cpu);
> +}

Why dont we do 
#define arch_llc_mask cpu_l2_cache_mask


-- 
Thanks and Regards
Srikar Dronamraju

