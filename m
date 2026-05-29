Return-Path: <linuxppc-dev+bounces-21708-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BCCCD6E53
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 10:32:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRfn435whz2yQL;
	Fri, 29 May 2026 20:32:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780050744;
	cv=none; b=a3K7tkUHoHRTU+IaPTDkzAsKZOID2PtwYrC4M++9nY4GPtiIpnwXASip8wVlQVL1xGSsY6hEIFhjSm4YtbqKDKRA3l0A3jWjP4H4swAYgZI/mYJPrVY+eiN/BHh6eei8hz3+0Ee5Rc1ymGCioFVHAySMptgOCxr+uxeN+sJuBO2wYn2nwL46WAAXPrQ+RV1+xIwAmCoTfhy5JX60wzWHVYoSjmEAaZkarzGSb8HLT+jWUq9SbeoPmchxP5RbmBnNz1A1yVF4HARLbxkgI2A6o816B1miL+HaRJxDx0Lhk++fGI9Xc+vQE493+2wY9+IGRCR7yxy6USVYEaTzVpx8cg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780050744; c=relaxed/relaxed;
	bh=/Z/W8/jUuKr9oj0D3KcLhsBpkcdAs5PL0TqMfAe1NGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtqggCImIcmQA4V2588DkNjPDPSZCT1qmix+bHaoYIGZF+kpTl3MLD70G5Gjl7huiH0Cgg8pBRzAnSBpeBAXz36V+m7x6JOe+3a0LzNI7IUhGHwDhoOEPrkrU+CW7z1Xwb3uyiDHZI3Dla0UfEVesHqOYNsYiH7U0xyYSMhLx8vqiGBwpvru85vZhfgwGXMsxNEaG6KeZAcruoZR+B38biZqJ6Gh8kmZ2QmgQ2pmzS/lQdvjJ/Dz4gIDcNXVY0WGy2SE6ElJrxxptfSHOkqy5cb6AiWahjdS15bQZKje/aq1iNp7BPxepyABtgNla7msRjYWNYYAaEycql9lmrPCsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fXHFLgdZ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fXHFLgdZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRfn2107Cz2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 20:32:21 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TAURM63217825;
	Fri, 29 May 2026 10:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=/Z/W8/jUuKr9oj0D3KcLhsBpkcdAs5PL0TqMfAe1NGQ=; b=fXHFLgdZASJF
	keWoChl1f+p0f8QfKL6v0yx3zuO548Nh2xazuVUGxYi70ITna560UwYqsUX7QXXd
	dz3pB63mt7Rmt45h6prpOZLrmiVDhp6kwRZE9w40oydWP85+WmQPz50heuewzsHm
	2Oop/K7kzUqCG+n5Wk4PR/xse7gV0Fp7wIKwKR2SYjS2vM4al6ydFbUjNFQmp1NM
	eYpZHVvowWdGNxGeevJSYzHcKLXqPte8OBXyQoPoktyGFFQ+e473E7UvJulpnwuZ
	OuwksA/AzHkPPzW92Jp9AEqK97G5w/9H5xbYUhMPVt4wFpoLIK1dblLFvGwG2VDm
	VqAvMjwJNQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee88bfrs7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 10:32:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TAO8Fo007527;
	Fri, 29 May 2026 10:32:03 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrc547h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 10:32:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TAW0Nc45941140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 10:32:00 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 027902004D;
	Fri, 29 May 2026 10:32:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED2EA20040;
	Fri, 29 May 2026 10:31:57 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.126.150.29])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 10:31:57 +0000 (GMT)
Date: Fri, 29 May 2026 16:01:57 +0530
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>,
        skiboot@lists.ozlags.org, arbab@linux.ibm.com, mahesh@linux.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/topology: Support coregroup in PowerNV
Message-ID: <ahlrHdPKEXzSm1yM@linux.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.ibm.com>
References: <20260524010017.140408-1-srikar@linux.ibm.com>
 <6387fb12-76f1-4503-8ac2-3ca777c0186e@kernel.org>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <6387fb12-76f1-4503-8ac2-3ca777c0186e@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDEwMCBTYWx0ZWRfX6I6BEJnoGWes
 oxPXsE9agQQJ3WRiFSeOs01OL7WfdiPDm2FeTTOvvzu3nnKQe3n8AMeQhaGM/8XG/vH88eCXGw+
 dwbTrgBdZCNrndRx0NewVFHZlotws4lMBoS5SFwtoRA1NyyD2McmxBTt6LcjFb7N0n40S1QFJwP
 Tx7F1riw+8iEHAOqr6jJFl0xCZDmvuo+Pv4Ig+z32ElD9ngTqa/qxCIu1vpWgUV5Ouwj+0gAXgm
 HFKampNetnPqRSoqs3hEiVfihdz0WBCM9AXwszkLKNf1wIN2OCkMnHjaeIve10Yl4PC05pIAoVZ
 JxrS12mcCL96xAkar/gPQ5TEjMppNlPsZQ08PiLrD/YPghuv9J9N7Q9yPDPR454TSsUReA4TqLe
 zzfk/4XqldPcxklmOhycZJni3N+1VtIqDIDbKDaN4J4sxSGK6aXcwCbqPzQ/qlctXGkJQE0kbkU
 w2J+OZdgE7PJU7d10TA==
X-Proofpoint-ORIG-GUID: AFFxDPPl4UHJXPGPE7w0YYZpo9U23QrS
X-Authority-Analysis: v=2.4 cv=IJEyzAvG c=1 sm=1 tr=0 ts=6a196b24 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=8nJEP1OIZ-IA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=S6HiPNHpWCteLltP99QA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: R-Upo_3J6AbCmgGkdHITBbFAzplxP4CV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290100

* Christophe Leroy (CS GROUP) <chleroy@kernel.org> [2026-05-29 09:58:25]:

> Le 24/05/2026 à 03:00, Srikar Dronamraju a écrit :
> > Coregroup support was only available on PowerPC on PowerVM LPARs.
> > However if firmware were to expose coregroup-id to the kernel, then
> > coregroup can even be supported on PowerNV too.
> > 

Thanks Christophe for taking a look.

> > +extern int cpu_to_coregroup_id(int cpu);

> No new 'extern' for function prototypes (allthough it is only a move),
> that's pointless. checkpatch.pl --strict will likely complain about it.
> 

Ok, will do..

> >   #else
> >   static inline int early_cpu_to_node(int cpu) { return 0; }
> > @@ -107,14 +108,6 @@ static inline void map_cpu_to_node(int cpu, int node) {}
> >   static inline void unmap_cpu_from_node(unsigned long cpu) {}
> >   #endif /* CONFIG_HOTPLUG_CPU */
> >   #endif /* CONFIG_SMP */
> > -
> > -#endif /* CONFIG_NUMA */
> > -
> > -#if defined(CONFIG_NUMA) && defined(CONFIG_PPC_SPLPAR)
> > -void find_and_update_cpu_nid(int cpu);
> > -extern int cpu_to_coregroup_id(int cpu);
> > -#else
> > -static inline void find_and_update_cpu_nid(int cpu) {}
> >   static inline int cpu_to_coregroup_id(int cpu)
> >   {
> >   #ifdef CONFIG_SMP
> > @@ -124,6 +117,12 @@ static inline int cpu_to_coregroup_id(int cpu)
> >   #endif
> >   }
> > +#endif /* CONFIG_NUMA */
> > +
> > +#if defined(CONFIG_NUMA) && defined(CONFIG_PPC_SPLPAR)
> > +void find_and_update_cpu_nid(int cpu);
> > +#else
> > +static inline void find_and_update_cpu_nid(int cpu) {}
> >   #endif /* CONFIG_NUMA && CONFIG_PPC_SPLPAR */
> >   #include <asm-generic/topology.h>
> > diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> > index f4cf3ae036de..9b45cc9e1f27 100644
> > --- a/arch/powerpc/mm/numa.c
> > +++ b/arch/powerpc/mm/numa.c
> > @@ -432,7 +432,7 @@ static void __init initialize_form2_numa_distance_lookup_table(void)
> >   static int __init find_primary_domain_index(void)
> >   {
> > -	int index;
> > +	int index = -1;
> >   	struct device_node *root;
> >   	/*
> > @@ -502,12 +502,9 @@ static int __init find_primary_domain_index(void)
> >   		distance_ref_points_depth = MAX_DISTANCE_REF_POINTS;
> >   	}
> > -	of_node_put(root);
> > -	return index;
> > -
> >   err:
> >   	of_node_put(root);
> > -	return -1;
> > +	return index;
> >   }
> >   static void __init get_n_mem_cells(int *n_addr_cells, int *n_size_cells)
> > @@ -892,12 +889,32 @@ static int __init numa_setup_drmem_lmb(struct drmem_lmb *lmb,
> >   	return 0;
> >   }
> > +/*
> > + * If hierarchy extends beyond primary_domain_index + 1, then next
> > + * level corresponds to coregroup.
> > + */
> > +static int detect_and_enable_coregroup(const __be32 *associativity, int index)
> > +{
> > +	if (!associativity)
> > +		return -1;
> 
> Even if 'index' is not 0 ?

In the hypothetical case, where we don't have the associativity for a CPU,
then which coregroup should we place this CPU. Placing it in arbitrary group
can confuse the scheduler and cause more issues.
Hence I guess, its better to return -1.

> 
> > +
> > +	if (!index) {
> > +		index = of_read_number(associativity, 1);
> > +
> > +		if (index > primary_domain_index + 1)
> > +			coregroup_enabled = 1;
> > +		else
> > +			index = -1;
> > +	}
> > +	return index;
> > +}
> 
> I'd prefer something more flat:
> 
> 	if (index)
> 		return index;
> 
> 	index =  of_read_number(associativity, 1);
> 
> 	if (index <= primary_domain_index + 1)
> 		return -1;
> 
> 	coregroup_enabled = 1;
> 	return index;
> 

Again, if a particular associativity doesn't have coregroup info, we are
probably better of disabling coregroup for all. Since we can't enable
coregroup for some CPUs and disable for other CPUs. And we can't add default
coregroup too since that would confuse the scheduler. For example 2 CPUs
from 2 nodes may end up being part of the same coregroup because of default
numbering.  This will lead to topology_span_sane() cribbing.

May be we should also reset coregroup_enabled, whenever index is set to -1.

> > +

-- 
Thanks and Regards
Srikar Dronamraju

