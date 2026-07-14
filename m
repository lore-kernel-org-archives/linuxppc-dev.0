Return-Path: <linuxppc-dev+bounces-24197-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9012CC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 09:28:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzvBX4DxPz304Q;
	Tue, 14 Jul 2026 19:28:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784021332;
	cv=none; b=hhRskXWM5NqPNQOKQ5oMhHFyp1R+gLIi9B1IBYkCIGLQj3R9p05WfVHjtl8JOGr+dKOzkatzAauTsJ36o/Dxln5SruK5V/dVu2jAlfvGVnnDk8RIfn3lrAc9Z4mrBdHo/DYB7BmLESFOoo8jeYeq+f+QYORKrTwuHcC0prM1/aNgy73eaBm7eK/zM27cFbG9Whgn7VYGjGuEbWRqIX0Ie+I43MC1sV/oG2pgsdatb17DTnXTT567g7ghof+Ehrm1NBMAk/x6nryb7tZswVLS2eTEq21XKJicC2gcJT4GoTALWiGjb7ECR3i1LA3F3qZSbX/a0R6hZUpHk7VqJZwZtA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784021332; c=relaxed/relaxed;
	bh=5H9KTAiViFqk+x2EC9ZqvjfeXhHYmCLxxZr7aG86JRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OiPSR2Ojvbyptop8PGmHsZJuijzPkzYTPuL54bqiPZio2yLHFGcTo17O4ICTartRR+2E+z0GRudfjIcldjjq3vmuwNTVfcjjUlWXEvMhvdZw9kNDsKbLV8H+gD0g5ze4oZdIufTbYJKSqLR+vvBWI7VZDUYc+nl0OD+IsuYvorPetYXEnCBwHbfLIAD6zHYJE1dT/6fO9bWENSIOZk9vO9ZfCu938nGKSe87m4lTCo2Oa1LmhwX79exTifZJqhBLJlXEPFDEPZ6mRpgAjIqpXLwbgINqGWnsPTiplvgHxq+8vO1Tf69eAL5t3NWAugSHsRejDzrOTcixt9On5NJiPw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oAQ5Vc3o; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oAQ5Vc3o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzvBW4Lm4z2xVY;
	Tue, 14 Jul 2026 19:28:51 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E6fjRC570179;
	Tue, 14 Jul 2026 09:28:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=5H9KTAiViFqk+x2EC9Zqv
	jfeXhHYmCLxxZr7aG86JRo=; b=oAQ5Vc3o6LvOa9eUufdrrHoa0DYpPyRCSWhQW
	qBUnTrQ4EO2dL+YCPqOi6ytPfT0vb4FV9l16iF5xf/Ek5XsMDVNvTfxwesUb3fr1
	CfJ7w/15e/zCBAJU8ICKJGAmEQ8rtbzJW539S51fp84xKFAPem56vmIxTayZW5aG
	88iSQaEVTCu+qAohZ/1gtm1bGepMRhczGRwS3sqtsyUHTw5lHrojbLiFDcZLfrmr
	HUJoObu+ZVaijdI/+crdDp80rNNnPgUC+T1v6KvmXq3FuyNw6MUNxgyJ1UupTboz
	4S5SSMr1WNSRq2LYKvk7KPEuHUvXwjGevfLjnqgpEr95HO2JA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegt5dm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 09:28:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66E9Jdsf025310;
	Tue, 14 Jul 2026 09:28:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hw25n4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 09:28:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66E9SVwB49545646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 09:28:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD1092004B;
	Tue, 14 Jul 2026 09:28:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D8C520040;
	Tue, 14 Jul 2026 09:28:27 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.126.150.29])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 14 Jul 2026 09:28:27 +0000 (GMT)
Date: Tue, 14 Jul 2026 14:58:25 +0530
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
Subject: Re: [PATCH v2 3/3] powerpc/numa: Support coregroup on PowerNV
Message-ID: <alYBOcxjv6DqxUyT@linux.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.ibm.com>
References: <20260605055242.1757485-5-srikar@linux.ibm.com>
 <20260605055242.1757485-8-srikar@linux.ibm.com>
 <v7anv1ib.ritesh.list@gmail.com>
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
In-Reply-To: <v7anv1ib.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: pGiJ2ZXrBtD4ZCYGfYRiwiigggNzTGGU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA5NiBTYWx0ZWRfX6+kaKao9HguP
 VMJuk/XXokehF7O/ucEsVsuifcQ1LeFl9mwSaOJENZNiL8K9NDkKzC0zqURJzDoLyH+IWCoFC1l
 2mDB88Z6XcwXK4PO9xQgk1qebjuNDkQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA5NiBTYWx0ZWRfX5cERscBcd9bs
 sriglzH+DDA8oUsZTq+2/GenmMAkQU7IDV5niO12Uc6nPJP7yhSW6gETLRIIddPJiUbdEimhFpt
 8OVITzG/U6OqZcfTi5zxQDdnO84u5RhCwWwtcfr53AjaXdFZbglx90JS6ovKh+FkhJgVJicRV0q
 yKQVxniDB8YMgPmWrzmkSARefGeH/fwSNp4x4gLs8JO6B72qVQRIRaW75Qq5STPPSiytZ7+MVnb
 cjW3IpoyyJnbBGQfIDxH7aEcbH7hXvdF7ujFo94kdvEsqxAKhnKeN7zMCyaL5DHwqpPEu99zx8c
 8k5c1dSg6ccHLU7nCZQ5gnECidaK+Ak97zcytUQCgC9oNoxFFXvTd/d2LOBjMKoG681WPUgYIJz
 MOTa7QoV8XNzIXs5kW2NKAQqVILjBMVQDjeEUdr6VMT1kqlF8Y/rk+cb59vrdQZ4R/Cw08X+4Ni
 o9gNyjs0YQQOpnCcBmQ==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a560146 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=8nJEP1OIZ-IA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=UivGAdU0P_aAEp21OzIA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: iOWhyvUIBfDOEcmmdOEqJ_2bCnAUyhtv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140096

* Ritesh Harjani <ritesh.list@gmail.com> [2026-07-10 11:18:12]:

> Srikar Dronamraju <srikar@linux.ibm.com> writes:
> 
> > Coregroup support on powerpc has so far been limited to PowerVM LPARs.
> > However, PowerNV can also support coregroups when firmware exposes the
> > required coregroup information through the associativity hierarchy.
> >
> > Detect coregroup support by checking whether primary_domain_index is the
> > penultimate domain in the CPU node's ibm,associativity property. On
> > PowerNV, a non-penultimate primary_domain_index indicates that firmware
> > provides an additional level for coregroup information.
> >
> > This keeps the logic compatible with PowerVM systems, where
> > primary_domain_index is likewise not the penultimate associativity
> > domain.
> >
> > Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
> > ---
> > Changelog from v1: https://lkml.kernel.org/r/20260524010017.140408-1-srikar@linux.ibm.com
> > - Handle comments from Christophe Leroy; make code more flat
> >
> >  arch/powerpc/mm/numa.c | 56 ++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 46 insertions(+), 10 deletions(-)
> >
> > diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> > index 9aa71eb7e96b..e97b624203ea 100644
> > --- a/arch/powerpc/mm/numa.c
> > +++ b/arch/powerpc/mm/numa.c
> > @@ -889,12 +889,32 @@ static int __init numa_setup_drmem_lmb(struct drmem_lmb *lmb,
> >  	return 0;
> >  }

Hi Ritesh,

Thanks for the review.

> >  
> > +/*
> > + * If hierarchy extends beyond primary_domain_index + 1, then next
> > + * level corresponds to coregroup.
> > + */
> > +static int detect_and_enable_coregroup(const __be32 *associativity, int index)
> 
> Do we care about it's return value? We are not reading that in the
> patch.

Yes, We do care about the return value. If the index is set to -1, we don't
retry enabling the coregroup.

> this function is mainly only needed in __init, can we mark it so.

Yes, this will be done.

> 
> > +{
> > +	if (!associativity || index == -1)
> > +		goto out;
> > +
> > +	index = of_read_number(associativity, 1);
> > +
> > +	if (index > primary_domain_index + 1) {
> > +		coregroup_enabled = 1;
> > +		return index;
> > +	}
> > +out:
> > +	coregroup_enabled = 0;
> > +	return -1;
> > +}
> 
> For PowerVM, we now have two places which will enable coregroup_enabled
> during mem_topology_setup(). Is there some way we can unify that?
> 

For PowerVM, we have two extra associativity properties
ibm,ibm,current-associativity-domains and ibm,max-associativity-domains.
On PowerNV, these two properties are not used/exported.

All we depend is the layout of these properties to determine if coregroup is
enabled. If the layout tells us that there is place after
primary_domain_index for coregroup, we assume coregroup is enabled.

So in this patch, we hook at the place we look at each of the CPU
associativity. This should work for both PowerVM and PowerNV.

So, I can think of two options.
1. Remove the previous logic of depending on PowerVM specific code.
2. Allow the previous logic to be around. Since its not going to hurt
functionally or performance wise.

> This also means we enable coregroup in case of PowerVM with SPLPAR when
> per-cpu VPHN associativity index > primary_domain_index+1. But this
> isn't reflected in your commit msg. The commit msg only says this
> affects PowerNV.

I don't think, I said this affects PowerNV only. But I still don't think
the logic would change. The logic to enable coregroup remains the same.
Just that we may now be depending on the 1st CPU associativity instead of
the PowerVM specific properties.

> 
> setup_arch
>   mem_topology_setup
>     parse_numa_properties
>       detect_and_enable_coregroup() {...
>        // coregroup_enabled = 0/1
>         	index = of_read_number(associativity, 1);
> 
> 	        if (index > primary_domain_index + 1) {
>             		coregroup_enabled = 1;
>                     		return index;
>             }
> 
>       }
>     <...>
>     find_possible_nodes() {...
>         	prop_length /= sizeof(int);
> 	        if (prop_length > primary_domain_index + 2)
> 		       coregroup_enabled = 1;
>     }
> 
> > +
> >  static int __init parse_numa_properties(void)
> >  {
> >  	struct device_node *memory, *pci;
> > -	int default_nid = 0;
> > -	unsigned long i;
> > +	int default_nid = 0, index = 0;
> >  	const __be32 *associativity;
> > +	unsigned long i;
> >  
> >  	if (numa_enabled == 0) {
> >  		pr_warn("disabled by user\n");
> > @@ -927,7 +947,6 @@ static int __init parse_numa_properties(void)
> >  	 */
> >  	for_each_present_cpu(i) {
> >  		__be32 vphn_assoc[VPHN_ASSOC_BUFSIZE];
> > -		struct device_node *cpu;
> >  		int nid = NUMA_NO_NODE;
> >  
> >  		memset(vphn_assoc, 0, VPHN_ASSOC_BUFSIZE * sizeof(__be32));
> > @@ -935,7 +954,9 @@ static int __init parse_numa_properties(void)
> >  		if (__vphn_get_associativity(i, vphn_assoc) == 0) {
> >  			nid = associativity_to_nid(vphn_assoc);
> >  			initialize_form1_numa_distance(vphn_assoc);
> > +			index = detect_and_enable_coregroup(vphn_assoc, index);
> >  		} else {
> > +			struct device_node *cpu;
> >  
> >  			/*
> >  			 * Don't fall back to default_nid yet -- we will plug
> > @@ -948,6 +969,7 @@ static int __init parse_numa_properties(void)
> >  			associativity = of_get_associativity(cpu);
> >  			if (associativity) {
> >  				nid = associativity_to_nid(associativity);
> > +				index = detect_and_enable_coregroup(associativity, index);
> >  				initialize_form1_numa_distance(associativity);
> >  			}
> >  			of_node_put(cpu);
> > @@ -1445,7 +1467,9 @@ static long vphn_get_associativity(unsigned long cpu,
> >  
> >  int cpu_to_coregroup_id(int cpu)
> >  {
> > -	__be32 associativity[VPHN_ASSOC_BUFSIZE] = {0};
> > +	int coregroup_id = cpu_to_core_id(cpu);
> > +	struct device_node *cpunode = NULL;
> > +	const __be32 *associativity;
> >  	int index;
> >  
> >  	if (cpu < 0 || cpu > nr_cpu_ids)
> > @@ -1454,19 +1478,31 @@ int cpu_to_coregroup_id(int cpu)
> >  	if (!coregroup_enabled)
> >  		goto out;
> >  
> > -	if (!firmware_has_feature(FW_FEATURE_VPHN))
> > -		goto out;
> > +	if (firmware_has_feature(FW_FEATURE_VPHN)) {
> > +		__be32 tmp[VPHN_ASSOC_BUFSIZE] = {0};
> >  
> > -	if (vphn_get_associativity(cpu, associativity))
> > +		if (vphn_get_associativity(cpu, tmp))
> > +			goto out;
> > +
> > +		associativity = tmp;
> > +
> > +	} else {
> > +		cpunode = of_get_cpu_node(cpu, NULL);
> > +		if (!cpunode)
> > +			goto out;
> > +
> > +		associativity = of_get_associativity(cpunode);
> > +	}
> > +	if (!associativity)
> >  		goto out;
> >  
> >  	index = of_read_number(associativity, 1);
> >  	if (index > primary_domain_index + 1)
> > -		return of_read_number(&associativity[index - 1], 1);
> > +		coregroup_id = of_read_number(&associativity[index - 1], 1);
> >  
> >  out:
> > -	return cpu_to_core_id(cpu);
> > -}
> 
> Looks like leftover removed from previous patch. This change should be
> fixed in patch-2 itself.

True, will do the needful.

> 
> > +	if (cpunode)
> > +		of_node_put(cpunode);
> >  
> >  	return coregroup_id;
> >  }
> > -- 
> > 2.43.0
> 
> -ritesh

-- 
Thanks and Regards
Srikar Dronamraju

