Return-Path: <linuxppc-dev+bounces-24198-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25AB8C44501
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 09:30:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzvD54WxYz2y8p;
	Tue, 14 Jul 2026 19:30:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784021413;
	cv=none; b=NvWtzH/bOC6BmUI/j3GzLC4ac0MDIVm1ExpuSzq7WubRe5Eyp040TNM62rTLLQlsZYtkMDSMhuwfJhj3TG73JXycLtG4RfUzxERv1ZkHgGFUa+CwFvVZFOpPBMgkjmqkdwuchtYjQGV9nDtzMQY6AmRauZOG9DilXb/ieJeNlJq30GOzqlkGnvm5hehxIHKlPD+CdENUVFe4YkMMfIhCuQ00gWpc0EACe+8otKG1rC6+aGOW/xdq5o+h/viEG5ofO+CGT0Wo8b1O6LVRoSq0CSMt6IcPDcWN+iYXarZmlqr+nTmhTitGxJZD1FxfUrLQwTmvvMATRoo7cUWfVDk3tA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784021413; c=relaxed/relaxed;
	bh=KsLqHTsSjtEyTiMvODN6Jo4cCBjfs+wJF6eDvu5pKs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vf2vDICYoR3aDbmPKHGwA+dzE4ljKVBRw30xPd5WLVepGRimlda58viCtybmnWFBx6mmnSerZ6ypo4vlhugW7QNTydij0y/UWmO4cUc4Hf+glpzCbxEWlpBANcQfxrh948VlLcV3Y1hZoL4BszlQqwZsheAr6uYE4od7CRyqbDNg/uIjvbJoJ6WNGKcfDGIu9dN5234kliGRj1qDb3j+YLfDrTSksbgnx5jVqfURPzaktkCUEtjtsCKV8CTkSj4gZlXVwcm8d2CTju2divSLim0yWFy2cM2zJaO8H/sRg+4UhVm9wor8+8lMKg64Wc7mHvim06spgwbMLGu5cqkNUA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oSkWYJJT; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oSkWYJJT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzvD45PHyz2y7W;
	Tue, 14 Jul 2026 19:30:12 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E6fxd3547339;
	Tue, 14 Jul 2026 09:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=KsLqHTsSjtEyTiMvODN6J
	o4cCBjfs+wJF6eDvu5pKs8=; b=oSkWYJJTuizqtVfu34shHhYLIH6fXXOH2pUYL
	5dB9f2EHryrPGpaI2OOLJV/lgWP0eBah2t1+60V7mYHPKebO/k2D0dlK1P8XdF9Y
	Gc3VyglT26TXBbSM307Bar2ZY00T9Rq3m1o/CtIlgqOsARj09sorE6dvMcKjIQyD
	B4aiUrjWPaQd/sNAghdBBnsQl4KlBDjyWq8jkDbRXdRrNFF1NTAaL4BrpyCtX0S2
	PKPCA+rfHIVJpq7kIb+70/fwG8eoPhvqMraz/K3/AjNc3o5yd9cSa1AGlJbfHDc4
	RpYGQxPJdxTW3hE59Uv/ZeJFMQKUCcwUPh0kJzNN9RZOX7GyQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbmxh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 09:29:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66E9JbGo031203;
	Tue, 14 Jul 2026 09:29:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nh9y26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 09:29:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66E9TnGh50004258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 09:29:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2148E20043;
	Tue, 14 Jul 2026 09:29:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 51BA220040;
	Tue, 14 Jul 2026 09:29:44 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.126.150.29])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 14 Jul 2026 09:29:44 +0000 (GMT)
Date: Tue, 14 Jul 2026 14:59:42 +0530
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>, skiboot@lists.ozlabs.org,
        arbab@linux.ibm.com, mahesh@linux.ibm.com, chleroy@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] powerpc/numa: Allow cpu_to_coregroup_id without
 PPC_SPLPAR
Message-ID: <alYBhu2wN0QeXJB0@linux.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.ibm.com>
References: <20260605055242.1757485-5-srikar@linux.ibm.com>
 <20260605055242.1757485-7-srikar@linux.ibm.com>
 <wlv3v6ag.ritesh.list@gmail.com>
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
In-Reply-To: <wlv3v6ag.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a560192 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=8nJEP1OIZ-IA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=_vDUOehEt5VO5bzHM80A:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA5NiBTYWx0ZWRfXwkHTqBS2vHQM
 lIOMSRypr+EcnLE9AnafC/7yF+UM9JXryB/mNEklY1gc4dEEgby9Ky8cF6Wobm7NwLfFv75TIvb
 EX29jaeQVye/ImVdXQsmU0OYWtnpH4O94GrOKh8xtToMh+E8r32e2cxF68aiRhHnXTbr6nDaQiu
 DQceZdHDyI7QpkDOCLJGuNILexZFz7rLhDFxoPFj/pMFBo1KRv22/4zuSNOJNmZi/U/XGXz2wbQ
 CFsU7Y/DKDnkbZJRm3xRcxksCXNgb/L+vPnjcyrACh2M2eAyWTLXA8C81KuY6F18KvdymXWMCbK
 2ImaaNpWfCy3Df0FFc8/X5GCMYMvtbuU4UYnUmDMFKJmvtaIwHQY7SEb5+H2HA/RMbnljGi5FaV
 7a5aHkiKhGhBDM/IQoAkvhBeobxBr11eiQsOx5ZOcpahOnafqJvQYXQmcot0mUZb73jzdSC/qNz
 BPhT9TJL2wtDRk6ZNmw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA5NiBTYWx0ZWRfX0JQatvh/4dzx
 8tXT5Qh1+iP0MCrxheWS/Ykj7mcDkqaj15RnlzBZw8NIOTCsktYjaMc3r7TDU7VHIcuDzcZnz+5
 N6OIYhgjyMdf+pNzlHF6nBLgGODbRg8=
X-Proofpoint-GUID: pNIlILCeCA6qbR2nvGoWNEZQ68j9bdsL
X-Proofpoint-ORIG-GUID: BN0Z4-sYrpmzj3oPZNB2utw6EWluaR_b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140096

* Ritesh Harjani <ritesh.list@gmail.com> [2026-07-10 09:34:55]:

> Srikar Dronamraju <srikar@linux.ibm.com> writes:
> 
> > Make cpu_to_coregroup_id() available outside PPC_SPLPAR so it can be
> > used by platforms that do not rely on the SPLPAR-specific VPHN path.
> >
> > Keep the existing fallback behavior by returning the core ID when
> > coregroup information is unavailable.
> >
> 
> Looks like this mainly brings the cpu_to_coregroup_id() outside of
> CONFIG_PPC_SPLPAR gate. 
> 

Yes, thats the intent of the patch


> > Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
> > ---
> > Changelog from v1:
> > - Handle comments from Christophe Leroy; Remove extern key word in
> >   declaration
> >
> >  arch/powerpc/include/asm/topology.h | 15 +++++++--------
> >  arch/powerpc/mm/numa.c              | 22 ++++++++++++++++------
> >  2 files changed, 23 insertions(+), 14 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
> > index 66ed5fe1b718..385715f1ad56 100644
> > --- a/arch/powerpc/include/asm/topology.h
> > +++ b/arch/powerpc/include/asm/topology.h
> > @@ -71,6 +71,7 @@ extern void map_cpu_to_node(int cpu, int node);
> >  extern void unmap_cpu_from_node(unsigned long cpu);
> >  #endif /* CONFIG_HOTPLUG_CPU */
> >  
> > +int cpu_to_coregroup_id(int cpu);
> >  #else
> >  
> >  static inline int early_cpu_to_node(int cpu) { return 0; }
> > @@ -107,14 +108,6 @@ static inline void map_cpu_to_node(int cpu, int node) {}
> >  static inline void unmap_cpu_from_node(unsigned long cpu) {}
> >  #endif /* CONFIG_HOTPLUG_CPU */
> >  #endif /* CONFIG_SMP */
> > -
> > -#endif /* CONFIG_NUMA */
> > -
> > -#if defined(CONFIG_NUMA) && defined(CONFIG_PPC_SPLPAR)
> > -void find_and_update_cpu_nid(int cpu);
> > -extern int cpu_to_coregroup_id(int cpu);
> > -#else
> > -static inline void find_and_update_cpu_nid(int cpu) {}
> >  static inline int cpu_to_coregroup_id(int cpu)
> >  {
> >  #ifdef CONFIG_SMP
> > @@ -124,6 +117,12 @@ static inline int cpu_to_coregroup_id(int cpu)
> >  #endif
> >  }
> >  
> > +#endif /* CONFIG_NUMA */
> > +
> > +#if defined(CONFIG_NUMA) && defined(CONFIG_PPC_SPLPAR)
> > +void find_and_update_cpu_nid(int cpu);
> > +#else
> > +static inline void find_and_update_cpu_nid(int cpu) {}
> >  #endif /* CONFIG_NUMA && CONFIG_PPC_SPLPAR */
> >  
> >  #include <asm-generic/topology.h>
> > diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> > index c44a80d8fc11..9aa71eb7e96b 100644
> > --- a/arch/powerpc/mm/numa.c
> > +++ b/arch/powerpc/mm/numa.c
> > @@ -1428,6 +1428,21 @@ void find_and_update_cpu_nid(int cpu)
> >  	pr_debug("%s:%d cpu %d nid %d\n", __func__, __LINE__, cpu, new_nid);
> >  }
> >  
> > +static int topology_update_init(void)
> > +{
> > +	topology_inited = 1;
> > +	return 0;
> > +}
> > +device_initcall(topology_update_init);
> > +
> > +#else
> > +static long vphn_get_associativity(unsigned long cpu,
> > +					__be32 *associativity)
> > +{
> > +	return -1;
> > +}
> > +#endif /* CONFIG_PPC_SPLPAR */
> > +
> >  int cpu_to_coregroup_id(int cpu)
> >  {
> >  	__be32 associativity[VPHN_ASSOC_BUFSIZE] = {0};
> > @@ -1453,10 +1468,5 @@ int cpu_to_coregroup_id(int cpu)
> >  	return cpu_to_core_id(cpu);
> >  }
> >  
> > -static int topology_update_init(void)
> > -{
> > -	topology_inited = 1;
> > -	return 0;
> > +	return coregroup_id;
> >  }
> 
> These above two lines seems to be out of any function scope. So applying
> only patch-1 & patch-2 will give a compile error. This needs fixing.
> 

Yes, will fix this

> -ritesh
> 
> > -device_initcall(topology_update_init);
> > -#endif /* CONFIG_PPC_SPLPAR */
> > -- 
> > 2.43.0

-- 
Thanks and Regards
Srikar Dronamraju

