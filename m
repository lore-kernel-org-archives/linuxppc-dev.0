Return-Path: <linuxppc-dev+bounces-21491-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF68CD5BD0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 03:14:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPdCk0ZgBz2xSb;
	Tue, 26 May 2026 13:14:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779765298;
	cv=none; b=W0Bl1Vik28ajOnTQVMuH5vqApxsEYSUcXxDgKywhnZGXno2H64Cr0ESHCp3ViTQmbphvzFstqS1BvhySoUQvAnbkhyKxI1AYloAjFdfvBeNeHUcIZnxn+G+Nc4aeeVYjWBJ3VQozfKlsjC7hyvAE/RT/K4pq+lI41V+YRf8/hkU+rtUsoTyCXx80QyaM8naiG9AiORmmqrINvNzYKPaLYq6DWLlFJhhuEEyACIB4OxHUj9Rdpim3rLYIYmkKCmACHXaWjvy4vacbp06UCBTRMKQp94cEc9dEgqkQyxAfdqQyWwdT7la/o9Vth2lX2bVV9LZEplQ0ImfVNgpy+UTZOg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779765298; c=relaxed/relaxed;
	bh=OCLu3VjHEldHgGOyAPgxNkZAlasfWemigoDGm3VMA08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7gL5zrcJ7lw+Gjhcv1jod5ONf1E3CaZxg3QI0xgoZWMe/FUagtTo0xKrKQsDi28m87Vhoh/xz1LuT+30dbIg6zCwIm/zJ3Ql6mFEhZzBUfynx3aEqPfx9BlzbkGqAQVCO2a4n/NN+T3XLGcmVgYQVBe+cc7OuRrl4p1LK3Cqstbi8fyNy24vGbU6LNMAS7s1mJECE+SpbzNzcjnMjsyZjt0VFLLmdeL9hF0p7AYTv4EogUvj8fl33zMg9Yuws4EoXMs7yTM5fzPQ1dI6WNoReXbt7qiBXUQfuXEjnQSkTV6sNuJXdiHqGn86Podt1LADa8Ru9zxF6VTQKASUTMMSg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UuoGigCY; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UuoGigCY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPdCh6RbJz2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 13:14:56 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PArM1N1139703;
	Tue, 26 May 2026 03:14:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=OCLu3VjHEldHgGOyAPgxN
	kZAlasfWemigoDGm3VMA08=; b=UuoGigCY1vgSGiKDsABhJ5jUlrVdYEi77iAWw
	dI9orYQhDzVIiuBBc/rszHQFr0fYYCcPW/z5xQgZqLkZlqpKNaQYWy4+AN/yewlb
	Px4xH0v+rz+gNsowZpkw41vxsHmRBRske23gMrWJsHnT3CIWSQqZ2+YC/q9hhtgF
	9DoJDxjPYXC3wcVg6eDZhsMFTT4DqFw8PdTUhblQjtMvzOpLaKIbCixpCryRMJlA
	n9TUd8YtceKgqVynbF+/cKUWz3rVGik8u5WTC96pxSlJXw7zKTG0BQOiAZLVD45s
	t0tHwy3vbMHVmdbsx6ZhNb353uV17ZAk75pqJfCL3owXtB6FA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4s2a3tt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 03:14:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64Q39VC0013209;
	Tue, 26 May 2026 03:14:35 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ebrsg7a7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 03:14:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64Q3EVQ153477776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 May 2026 03:14:31 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88ED82004D;
	Tue, 26 May 2026 03:14:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA97720040;
	Tue, 26 May 2026 03:14:28 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.126.150.29])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 26 May 2026 03:14:28 +0000 (GMT)
Date: Tue, 26 May 2026 08:44:27 +0530
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-sched@vger.kernel.org, tim.c.chen@linux.intel.com,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [BUG] sched/cache: "Make LLC id continuous" causes NULL cpumask
 dereference in build_sched_domains on POWER9
Message-ID: <ahUQE-AgvOAQV_mI@linux.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.ibm.com>
References: <51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com>
 <bca40921-d351-4439-ae6a-9e5294f23e2e@intel.com>
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
In-Reply-To: <bca40921-d351-4439-ae6a-9e5294f23e2e@intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _JP--fyYK0CAMhEL_LtKoCKo4SX90Ktx
X-Authority-Analysis: v=2.4 cv=Sq2gLvO0 c=1 sm=1 tr=0 ts=6a15101e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=8nJEP1OIZ-IA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=QyXUC8HyAAAA:8
 a=bMPtyg5wVyCigGFRr4EA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDAyNSBTYWx0ZWRfX0EuWD7KBtQ7B
 UrSv96v9wEMZQaCxNU8Tf4Oo5JdJ19bS8fpzG5EDeHZHu+vLJNLJxNYEQUz/3noam+nFbYSbZO6
 NAEXjKfEy7LfLghVMI00OIPA9uTy6FWMeDWKVzzy3mmP8hSmMispEtmp7VFaQf2EuB7fKNvHBzC
 sQyjf8PHE2eL8VR9LPP60NBhyiHQmYzz6j2hSrLNBmt1lxU3gXfYllRDwgovvWMO27DQ/R1kxeO
 dfwBQWlPa2BEqTbznus8b0dlFp2y04CrRbGN08Z4FD6QRdN2OE9HK4MS3XelGmrG85fk7drBN8G
 YSAJbM05JyQCsqCz0MRJ7mUHUnYV6BRDmb9AS7M47y4UM3U2GmzrWoH9vv29H90FJc+X1FrsGxV
 2dBGK190T7dUqywoQ1c1Em6D3K/+YvICE/hquoyMBonHICRO0k5RG5TV5MwYoyADetLSwnIzf2X
 PwOlNiuJ/DwIWv7rTiA==
X-Proofpoint-ORIG-GUID: _JP--fyYK0CAMhEL_LtKoCKo4SX90Ktx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-26_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260025

* Chen, Yu C <yu.c.chen@intel.com> [2026-05-25 23:35:45]:

> Hi Venkat,
> 
> On 5/25/2026 10:07 PM, Venkat Rao Bagalkote wrote:
> > Greetings!!!
> > 
> > I am seeing an early boot kernel panic due to NULL pointer dereference
> > on a POWER9 (pSeries) system when testing linux-next (next-20260522).
> 
> It seems that cpumask_first(llc_mask(i)) is accessing
> NULL cpu_coregroup_mask():

> has_coregroup_support() is false, thus cpu_coregroup_map
> is never allocated in smp_prepare_cpus().
> This machine is a "shared system" VM. We should probably
> let the LLC id generation fall back to using L2 id if
> cpu_coregroup_mask is unavailable (which restores the
> behavior before this patch). I'm wondering if the following
> change would help(need IBM friends' help on this):

Power9 and below systems, dont have coregroup.
Its not because of shared LPAR. But its true for dedicated LPARs too.
Only Power10 and above systems have hemisphere where we add MC/coregroup
support.

> 
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 3467f86fd78f..cf6c2e4190ab 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -1042,11 +1042,6 @@ static const struct cpumask
> *tl_smallcore_smt_mask(struct sched_domain_topology_
>  }
>  #endif
> 
> -struct cpumask *cpu_coregroup_mask(int cpu)
> -{
> -       return per_cpu(cpu_coregroup_map, cpu);
> -}
> -
>  static bool has_coregroup_support(void)
>  {
>         /* Coregroup identification not available on shared systems */
> @@ -1056,6 +1051,14 @@ static bool has_coregroup_support(void)
>         return coregroup_enabled;
>  }
> 
> +struct cpumask *cpu_coregroup_mask(int cpu)
> +{
> +       if (!has_coregroup_support())
> +               return cpu_l2_cache_mask(cpu);
> +
> +       return per_cpu(cpu_coregroup_map, cpu);
> +}
> +

While this is a work-around for the problem in Power9
It will hurt Power10 and Power11 systems.
As has been alluded by Prateek, MC is not LLC on Power.
So by using llc_mask as cpu_coregroup_mask() we run the trouble of assuming
MC to be similar to LLC. So it will impact Power 10/11 Systems.

In commit b5ea300a17e3 sched/cache: Make LLC id continuous, we define
#define llc_mask(cpu) cpu_coregroup_mask(cpu)

defining it llc_mask to cpu_coregroup_mask means MC should be LLC.
This is not true for some architectures atleast on Power.

So shouldn't it be using
#define llc_mask(cpu) per_cpu(sd_llc, cpu)

This should work for systems where LLC is sub-coregroup, coregroup (or super
coregroup: Lets say some archs want LLC at PKG and cluster at coregroup).

if we do that, I dont think we even need the else case where we say
#define llc_mask(cpu) cpumask_of(cpu)

-- 
Thanks and Regards
Srikar Dronamraju

