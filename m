Return-Path: <linuxppc-dev+bounces-21633-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9941CD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2026 15:54:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gR9zL2HNzz2xM7;
	Fri, 29 May 2026 01:54:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779983678;
	cv=none; b=dTDJktzVALibpV9v8u5eBCdncrs9ZYl1z7KYe392NROsrBmK0I4K4pzESydqAI9edlDfi8k7IafbbnsIiY2GoG2NkPexDry9ecI0OADfxawM3XblszOwj9DtSRCioLJg0OwpryAZNKyl7bZzPis/cdwdjwlUQkpvOaRjpciGCWeSQedWBWs+zIQnFD8zi97nfPP37vbLSD5F1uIRrCifZgB5xi2EAbfahdUq0nl0c8Ef24eNIHMKn9pf96/cy+wlnyNbys5EV6R+tpQveg7D7Nyg8nNDcI3vUic/niybUPLZTzyNLj1KXmmod/36Ow1DvkG3uGUjkjQokkulvrMQVw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779983678; c=relaxed/relaxed;
	bh=DaOxr4purVo3rO4nQnAe8UYu+E7pia7mX+5o8talBko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErfKaSFtAcTzIfAipIqiprMHydEouNpNo99u13r5Qg6fPNQbC842V6DEJwvGIL+LxfkrPWlGq0fobq8RLEmbCeVicJqTXfvnokGag1N0i3/O9d01I7D25f0oT7k7OFH/Hm4sL8zZsSGqc5NCYRSQaSixGA4xOgLoTSSgh/LkgOF94SQylmtKyCJlQz7R3h1TKYrZVI951r7yBTYEU9kWw3EXr3ZkQYpygak1Q4kA3CXRHTFPqJ/bTqvONQk35ETbx7HFWBUNhGUg4Vj0h58gPYX8gxO21EjX1Xfy9s2EAyRi2EE5XfhLMu7y9i+OWE1GJ5+fNwv7YxjAzOGhl+g7ow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mZ7CuhA4; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mZ7CuhA4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gR9zJ5pBJz2xM6
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 01:54:35 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SBxaTj035143;
	Thu, 28 May 2026 15:54:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=DaOxr4purVo3rO4nQnAe8UYu+E7pia7mX+5o8talBko=; b=mZ7CuhA4sG0N
	7dxDfg92XiO4ZMTi0oWitwJxftjv0S7opfaLB5a80zwISzHpMwl9e36pEaQHLeiz
	QM6DYuONJacDl2nJY31eVWV3SnTDHUNXhFrL71Lp4ssXkWJ76Gxs2vF3XC8ngKR6
	dDKdH9U7R9lO2wEM5bP3bTwTvx/knAq4LFrBO1s9idgEqysE4K+CsVrzT7zVLiyg
	tsOahih1mJVwmjP2lG7CEv1xkZewiKKEUE1oGK9HEPsWJf+sW0y45E6mH7I2X3R+
	0sJ0STQrPkTpcLIFAvdNM1Ik6sv1QRgKZU5B3qRbxwWBTCLVObHVP6YKf12UoZRg
	CXFfKzxJHQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee88bbpge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 15:54:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64SFdTqe028777;
	Thu, 28 May 2026 15:54:17 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrb8trn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 15:54:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64SFsEjo52101510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 May 2026 15:54:14 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 254BE20040;
	Thu, 28 May 2026 15:54:14 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E42B20043;
	Thu, 28 May 2026 15:54:11 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.126.150.29])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 May 2026 15:54:11 +0000 (GMT)
Date: Thu, 28 May 2026 21:24:10 +0530
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, venkat88@linux.ibm.com,
        maddy@linux.ibm.com, riteshh@linux.ibm.com, chleroy@kernel.org,
        tim.c.chen@linux.intel.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sched@vger.kernel.org, kprateek.nayak@amd.com
Subject: Re: [BUG] sched/cache: "Make LLC id continuous" causes NULL cpumask
Message-ID: <ahhlIh3pKkjWY2o_@linux.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.ibm.com>
References: <51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com>
 <ahUogeqIq5km7JSr@linux.ibm.com>
 <058664ab-0982-4c13-9d4b-caa2f7616b0f@amd.com>
 <20260526140856.139657-1-yu.c.chen@intel.com>
 <d45877d5-86f1-4581-b3e0-59ceb722de3a@linux.ibm.com>
 <912676bc-230e-410f-a5fe-153b0f304aee@intel.com>
 <42a19577-fe56-44b4-b0ed-37cde6d03ff5@linux.ibm.com>
 <508a604b-2d30-47f4-a63c-36778a1d47c7@linux.ibm.com>
 <db443a1e-e6fc-491c-a38a-1cafc8e674cd@intel.com>
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
In-Reply-To: <db443a1e-e6fc-491c-a38a-1cafc8e674cd@intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE1OCBTYWx0ZWRfX6kovxB1W3U+5
 C4MzjtS7kY8cPMm6YvtgXuXg7vZWKja0pf47djAV3YjsyIxm3XdSnTadgDpw5UHXSxk96rJ0LlO
 YVZz7jAGq9eZ/d21il5gNu0cMZc0NuPzgLbZmnUeA7hKUtRbE+8DSgBdxcbcJeC0mvbiD+oTH23
 l0BN7fjD3VOjmZgrs+KITQ+KMShwn01ihR662UIIyercMRCRmYvosHy9gr8Bz8Idey1fFjEGbhj
 Th16pBFFO5+RQdrzf4gOUzcLD02eW0tkO+RIrmd+weXfPZwEIo5IK0Pki/82gjtCMOnZrdDJ1wH
 IYyF2XEQsh0mc8uKc3hToDiw5jfoBT1HNCu6rRI9y+soTo9S8zcMsBU8/P6Wg5VqjkJSU5nuqYm
 1HL3tVoxlqSzUu2a26gfap4WY8C8G9U21DDtByURs2WZws8+OWwH5h7VP8cjd+OhjgYt2Gz3JZZ
 x4WWXDjXku/LjMlZ1ig==
X-Proofpoint-ORIG-GUID: MsIPZaOu5rFt4wwEImH6MwfkKC3TVNBw
X-Authority-Analysis: v=2.4 cv=IJEyzAvG c=1 sm=1 tr=0 ts=6a18652a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=8nJEP1OIZ-IA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=QyXUC8HyAAAA:8
 a=1UoP0w5reD1NFdx0UpgA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: MsIPZaOu5rFt4wwEImH6MwfkKC3TVNBw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605280158

* Chen, Yu C <yu.c.chen@intel.com> [2026-05-28 17:12:41]:

> On 5/28/2026 12:58 PM, Shrikanth Hegde wrote:
> > 
> > 
> > On 5/27/26 11:37 PM, Shrikanth Hegde wrote:
> 
> [ ... ]
> 
> > > diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/
> > > include/ asm/topology.h
> > > index 66ed5fe1b718..bd1db3b1dbb0 100644
> > > --- a/arch/powerpc/include/asm/topology.h
> > > +++ b/arch/powerpc/include/asm/topology.h
> > > @@ -131,6 +131,9 @@ static inline int cpu_to_coregroup_id(int cpu)
> > >   #ifdef CONFIG_SMP
> > >   #include <asm/cputable.h>
> > > 
> > > +const struct cpumask *arch_llc_mask(int cpu);
> > > +#define arch_llc_mask  arch_llc_mask
> > > +
> > >   struct cpumask *cpu_coregroup_mask(int cpu);
> > >   const struct cpumask *cpu_die_mask(int cpu);
> > >   int cpu_die_id(int cpu);
> > > diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> > > index 3467f86fd78f..26c15c786c55 100644
> > > --- a/arch/powerpc/kernel/smp.c
> > > +++ b/arch/powerpc/kernel/smp.c
> > > @@ -1101,6 +1101,13 @@ const struct cpumask *cpu_die_mask(int cpu)
> > >   }
> > >   EXPORT_SYMBOL_GPL(cpu_die_mask);
> > > 
> > > +const struct cpumask *arch_llc_mask(int cpu)
> > > +{
> > > +       if (has_coregroup_support())
> > > +               return cpu_coregroup_mask(cpu);
> > > +       return cpu_smallcore_mask(cpu);
> > 
> > 
> > This function body needs change, since LLC is not at MC.
> > and I didn't account for power9.
> > 
> > Rest of the structure is what i would prefer the direction to go.
> > This will help future architectures too to account for their specific
> > needs.
> > 
> > What do you think?
> > 
> 
> Yes this direction look good to me. Regarding the arch_llc_mask(),
> how about the following per Srikar's description
> 
> const struct cpumask *arch_llc_mask(int cpu)
> {
> 	/* Power9, CACHE domain is the LLC*/	if (shared_caches)
> 		return cpu_l2_cache_mask(cpu);
> 
> 	/* P7, P8, P10, P11, SMT domain is the LLC*/	return cpu_smt_mask(cpu);

       On P7, P8, P10, P11, cpu_l2_cache_mask should be same as cpu_smt_mask
       so I dont see a point of checking if(shared caches)

	We can as well return 
#define arch_llc_mask cpu_l2_cache_mask


-- 
Thanks and Regards
Srikar Dronamraju

