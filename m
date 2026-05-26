Return-Path: <linuxppc-dev+bounces-21495-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1529CD5BB4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 04:59:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPgX86b5Yz2xPb;
	Tue, 26 May 2026 14:59:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779771560;
	cv=none; b=ERecfE8biPkPntfvosMHOHlZuBp7ghoa2GpdeG3P1q5/2X6BBXRyLyXkUBLPtM+Ykmld7Z2oXeQ7YDip03fl09WcoGy2o1jbDA4kn1ywymduftNQbozAfNRgpfOKNKVhPC44RDT2FGZ9Xgpwp56F51r11SE2LK7zr0Bja0GW2zRla91eejTxq0vN2Dh3ewPRvpMDNV6cGVHKw5BICME39UHpdLmhQ8gbkpMO4uplWfLmgbasZ2k0vFlk4U4e+iR19i4i1pq78Z8fbZNeJsKqxnQHROb/QRq1INZnFEJ4DcSek65hQhwoqIwYnXEq8KkJV/3EQR6NNkMsnJzuGgaM1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779771560; c=relaxed/relaxed;
	bh=Nc3ma8qmCX0UFeFDUnoqB8psIfYbrsAOCcpr0D6wYxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4BWBdST8SNoEZxu+oo8Omfxiw5o1aaC7BSJSa97B5b+ztxLF23bdPrm6d0Y0H92myy45PYToYiUXdNRO4ty4ga8SoOegDos7ECenJC4ePhYtz+oYCnlPa47tboknhFq29FVQoaJqyIKG5dLgmWeVxldsrGMTLBeCZK30fMJqCIDjKZBXnDj73nl1zaYvRA5V63GqLPEJBkmdYfr4KYsiAu3MEDaTwWPY/4S/mbD2HC6G2mEn7xv/XAhvOVJNJWW/+4PhO0MkK+ZjgTceC1fcoBUtDl4APyn5wELYsoynT5B0Qe2xnpQbOWVURAEhEknmBmsJfbxhyOixb7CqnEPsA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=n1ByRuPf; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=n1ByRuPf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPgX73m9Gz2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 14:59:18 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PIxcAW2442093;
	Tue, 26 May 2026 04:58:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=Nc3ma8qmCX0UFeFDUnoqB
	8psIfYbrsAOCcpr0D6wYxM=; b=n1ByRuPfeI0oNv6OqAiPPJ4CysIKYKxpHN4FR
	y7cEYHOQTd1CWMy659hMKdKF8FdFpIJy1KQwqClXzkWEh779H0/HcCRdbgv3On7E
	t4nBv3RnWCcO/jqj5yGdsqxRC5qygmxj+Xi4t8l3Hgh9SBeavxp/Dhjg/iJaPbJ4
	sCl8twhGv0NGscjDj21GTzWs9KNJsQ9RDsQIATMbxiV3UMaWoucumJySEKrqo7qb
	163oWHCt7L83i9eAQin11G5g+v73SPBmRDqpi4v/Nw+8uybZJwE4+uR8hnv8gNho
	5fYzUBdr7B3WU4GH09+dUeppKsGTukb3dNlh7TiJsHZXcMnSw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4qbtbd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 04:58:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64Q4sAbU011581;
	Tue, 26 May 2026 04:58:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ebqjjqsc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 04:58:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64Q4wiXo53215688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 May 2026 04:58:44 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 633A420043;
	Tue, 26 May 2026 04:58:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D48BE20040;
	Tue, 26 May 2026 04:58:41 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.126.150.29])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 26 May 2026 04:58:41 +0000 (GMT)
Date: Tue, 26 May 2026 10:28:41 +0530
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
Message-ID: <ahUogeqIq5km7JSr@linux.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.ibm.com>
References: <51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com>
 <bca40921-d351-4439-ae6a-9e5294f23e2e@intel.com>
 <ahUQE-AgvOAQV_mI@linux.ibm.com>
 <a0e3f4f4-03b6-4bb1-881f-06bf5abca1a3@intel.com>
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
In-Reply-To: <a0e3f4f4-03b6-4bb1-881f-06bf5abca1a3@intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDAzNyBTYWx0ZWRfX1qpjgx/kb9vO
 Bbs3b+6gvhDoEJcYqq41RfgRqX6AjylpYwvQe5kzQqbx2kD/fHxLS2W7kNK49NVp+kPZlmE6DNO
 40YWms0L3CyuT3/p9zVVAm5fZe+zvQYXPMntwjKRUFYtCUDalqwbQ7JbNJyAvEqqe0uT3SOvtX/
 Sn17CWqE4dhqyHrrJ/NmTY8QWuuPl/hVfKc/V2Ekc4NAeaBGeZtC1NqpaMOnkgfi9ScU8xSbFiR
 wv6OCnz0AzboqU8iBw6JWcwoOZ/WuUhwF+2OnlLBq3TnIFzUkAWgrI+6TxntdiFbVcpZmcEpv55
 +KG5hKRImGBG0b0VT2f5pYcdo4DwM1iFH5xSRHDoXplTzgnAxRPRIShzhmcBDjDeveT/uiIm60O
 2/dabbZXeYxFM+EtrwLDfFBc0Utpc6B1PpjSqAC2jJoSopNldDMYWcFyAxCM2RpGrpUq/sIBVJn
 PtaHlqtonZnQZRqNKeA==
X-Authority-Analysis: v=2.4 cv=KItqylFo c=1 sm=1 tr=0 ts=6a152889 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=8nJEP1OIZ-IA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=N8J75DuAAAAA:8
 a=j168DjVmHo8SW3EahXAA:9 a=wPNLvfGTeEIA:10 a=nD1YRifxtKbQKNhUHPb7:22
X-Proofpoint-ORIG-GUID: W9gy1L56yWX0fDZu_sKTLT4lZ1xiAv4N
X-Proofpoint-GUID: W9gy1L56yWX0fDZu_sKTLT4lZ1xiAv4N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-26_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260037

Hi Chen,

> > > It seems that cpumask_first(llc_mask(i)) is accessing
> > > NULL cpu_coregroup_mask():
> > 
> > > has_coregroup_support() is false, thus cpu_coregroup_map
> > > is never allocated in smp_prepare_cpus().
> > > This machine is a "shared system" VM. We should probably
> > > let the LLC id generation fall back to using L2 id if
> > > cpu_coregroup_mask is unavailable (which restores the
> > > behavior before this patch). I'm wondering if the following
> > > change would help(need IBM friends' help on this):
> > 
> > Power9 and below systems, dont have coregroup.
> > Its not because of shared LPAR. But its true for dedicated LPARs too.
> > Only Power10 and above systems have hemisphere where we add MC/coregroup
> > support.
> > 
> 
> OK, thanks for the correction. Are you saying coregroup_enabled is false
> on Power9 and older hardware, and set to true on Power10? Power10 has a
> corresponding device-tree property, which is parsed to enable hemisphere
> support in find_possible_nodes(). This is why has_coregroup_support()
> returns true for Power10.
> 

Yes, Chen,
coregroup_enabled is true only on Power 10 +
Yes we decipher coregroup from the device-tree properties.

> > > +struct cpumask *cpu_coregroup_mask(int cpu)
> > > +{
> > > +       if (!has_coregroup_support())
> > > +               return cpu_l2_cache_mask(cpu);
> > > +
> > > +       return per_cpu(cpu_coregroup_map, cpu);
> > > +}
> > > +
> > 
> > While this is a work-around for the problem in Power9
> > It will hurt Power10 and Power11 systems.
> > As has been alluded by Prateek, MC is not LLC on Power.
> 
> Could you please elaborate on the cache topology?
> Specifically, could you clarify what the LLC is for Power9
> and Power10 respectively? Is it always the L2 cache?
> 
> I have checked the IBM documentation available at:
> https://hc32.hotchips.org/assets/program/conference/day1/HotChips2020_Server_Processors_IBM_Starke_POWER10_v33.pdf
> According to the document, a hemisphere corresponds to a 64MB
> L3 cache shared by 8 cores. Since the MC domain spans a single
> hemisphere, I wonder why the SD_SHARE_LLC flag is not enabled
> for the MC domain?

If we look at the presentation you pointed above, L2 is 2Mb per SMT8 Core.
L3 is local 8MB per SMT8 core which together form a 64MB l3-buffer per
hemisphere. L3 is a Victim cache and All L3 together form a L3.1 buffer.

In practice, we split the cache per small core aka SMT4 core.  So we have
1Mb L2 per SMT4 core, 4Mb L3 per SMT4 Core.  L3 is a Victim cache and All L3
combine to form L3.1 buffer. Hence for now we still consider L2 to be LLC.

On Power9, L2 is at CACHE domain
On all other Power Systems (P7,P8, P10, P11), L2 is at SMT domain.
On Power, We haven taken L2 as LLC.

lscpu (on Power 10)
Architecture:        ppc64le
Byte Order:          Little Endian
CPU(s):              480
On-line CPU(s) list: 0-479
Thread(s) per core:  8
Core(s) per socket:  15
Socket(s):           4
NUMA node(s):        4
Model:               2.0 (pvr 0080 0200)
Model name:          POWER10, altivec supported
CPU max MHz:         3249.0000
CPU min MHz:         3249.0000
L1d cache:           32K
L1i cache:           48K
L2 cache:            1024K
L3 cache:            4096K
NUMA node0 CPU(s):   0-119
NUMA node1 CPU(s):   120-239
NUMA node2 CPU(s):   240-359
NUMA node3 CPU(s):   360-479

L2 Cache reported here is for SMT4 Core.


lscpu (on Power 9)
Architecture:        ppc64le
Byte Order:          Little Endian
CPU(s):              128
On-line CPU(s) list: 0-127
Thread(s) per core:  8
Core(s) per socket:  8
Socket(s):           2
NUMA node(s):        2
Model:               2.2 (pvr 004e 0202)
Model name:          POWER9 (architected), altivec supported
Hypervisor vendor:   pHyp
Virtualization type: para
L1d cache:           32K
L1i cache:           32K
L2 cache:            512K
L3 cache:            10240K
NUMA node0 CPU(s):   0-63
NUMA node1 CPU(s):   64-127
Physical sockets:    2
Physical chips:      1
Physical cores/chip: 8

L2 Cache reported here is for SMT8 Core aka CACHE domain.


> 
> > So by using llc_mask as cpu_coregroup_mask() we run the trouble of assuming
> > MC to be similar to LLC. So it will impact Power 10/11 Systems.
> > 
> > In commit b5ea300a17e3 sched/cache: Make LLC id continuous, we define
> > #define llc_mask(cpu) cpu_coregroup_mask(cpu)
> > 
> > defining it llc_mask to cpu_coregroup_mask means MC should be LLC.
> > This is not true for some architectures atleast on Power.
> > 
> 
> OK.
> 
> > So shouldn't it be using
> > #define llc_mask(cpu) per_cpu(sd_llc, cpu)
> > 
> > This should work for systems where LLC is sub-coregroup, coregroup (or super
> > coregroup: Lets say some archs want LLC at PKG and cluster at coregroup).
> > 
> > if we do that, I dont think we even need the else case where we say
> > #define llc_mask(cpu) cpumask_of(cpu)
> > 
> 
> I suppose you are referring to
> sched_domain_span(per_cpu(sd_llc, cpu)).
> 
> Indeed, deriving the LLC from the SD_SHARE_LLC level offers
> better scalability. However, this approach would involve scheduler
> domains, which can be truncated by cpuset partitions - a scenario we
> prefer to avoid.
> 

Shouldnt cache-aware scheduling be worried about cpuset partitions too.
If a cpuset has subset of LLC cores, then we should Scheduler assume it can
control complete LLC?

-- 
Thanks and Regards
Srikar Dronamraju

