Return-Path: <linuxppc-dev+bounces-20570-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A95CD3439
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 May 2026 15:07:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gBFwB4fWkz2xQC;
	Fri, 08 May 2026 01:07:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778166426;
	cv=none; b=h+RLr8jK1Lt5LLa/1jXDnyvNrU0sQdpr29QpAesoVri2rLBZJzCNJs1dSyvJicTONrrpYnhoMeYAE3P+CEhgDAL+IKr+p34NedQhLvE2LuMgZ1c1rf03+vDLMDFu8ffZiP4+cJDfB/VHqKtMXaSfdtkexhg4EaHWqinbIzrIh75A0piyfzzKi87HYbA4AcqCu2JcxTf3e6e/6dzK/WXbWIk+qtqI1LpPS+xMRcyI5hPWdL5wxVbuFmWgNl94hmumPMmlW/+8wU4yjuhdJUj3SvNMfEkr1NdagC/FEnGv+X61sIOhsmSqOq6QyPukCGU5w1wCDZiiXwDhCDDM/cW8lA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778166426; c=relaxed/relaxed;
	bh=AI+UjuAiJf6+17WOZwiFG4mJNtQQwC3cEwKQHVVcLEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbEUUhQS2+sSlV/gibYvnE6iu49EwHmexoSFp0+UK79rf47pU7TZdE6SxsqVFaIkVHLfSAXDVG+C67aIjhYOyW17bP4kAX49tBiFAAA+0GW8LFatPlw9S5ruHRIwcJnzIZpl/iNvMAXkkucudvnXWYtrxfww7Y4zwtOjV9bSNlTdzKUcCwPxHGsnMJ3/WbzOUSRRM2bnkVrcUgY9kO8CChuvhjpcNv7IvpFiJ4ufxvcQKFPls8msBjH2BWUjgEYm0Ai8fQNCddkTtvA9UWRVBdD2ADa7j8sX4Mn7pynG3ASX8BM/4k3kjKbgqjbgyQEuL/Mn1v59uXFhpZL9D5iPwA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LnQDItZD; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LnQDItZD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gBFw94NV4z2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 May 2026 01:07:05 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647Cv3cg963512;
	Thu, 7 May 2026 15:06:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=AI+UjuAiJf6+17WOZwiFG4mJNtQQwC
	3cEwKQHVVcLEw=; b=LnQDItZDrU5XXaoWo7Ede1fWKWb0dBPRWekqIatKl4gjf6
	lDT0XjjUhINef7jj1Io6tP8SczxlqeudUfaxjYtuIBxrAc6Js80BO1iQmSC7pSNG
	sFxYIdhWyOvZzXrD5EYf0qoLSHsFEBj5Abq9ih2qK9esiBAtcD148nDUo75B/fzn
	DaQCdX2BWo+OChC4xzFuTdLOdS7+LPoYo8nvsZzYogca456M0a8uB7LKJB1NJ/7D
	cJE5gGX96kzM6hCI1hNb9dwlJhfikd/HzhWfkmGAFIxKRsbex5qt3FaCbD3vjgAm
	rjPzsZinN4y57qHDVBcflm+G4yXcE2ip/lwtzBEg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9v7qb5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 15:06:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 647Esdxt022212;
	Thu, 7 May 2026 15:06:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwx9ykwtj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 15:06:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 647F6o6g35389824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 May 2026 15:06:50 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 503F120040;
	Thu,  7 May 2026 15:06:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6CF62004B;
	Thu,  7 May 2026 15:06:46 +0000 (GMT)
Received: from Amits-MacBook-Pro.local (unknown [9.124.211.112])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  7 May 2026 15:06:46 +0000 (GMT)
Date: Thu, 7 May 2026 20:36:44 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] KVM: PPC: Book3S HV: Add support for compat CPU
 capabilities for KVM on PowerNV
Message-ID: <20260507202740.96fb259f-22-amachhiw@linux.ibm.com>
Mail-Followup-To: Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Vaibhav Jain <vaibhav@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260430054906.94431-1-amachhiw@linux.ibm.com>
 <20260430054906.94431-6-amachhiw@linux.ibm.com>
 <a85ed3d9-2a7e-4e63-93ef-c38c4b9a4305@linux.ibm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a85ed3d9-2a7e-4e63-93ef-c38c4b9a4305@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE1MSBTYWx0ZWRfXwfpw52DNWer8
 Hm7sGCqmXP9okHAJzs/3prUPDEzMgBBb2anDZEUkWxSJdvWtm4nUZFqX2kkDVPc30+MtSrIAwNC
 MU1yvZg72yyzSNFU9vDzlYOpDXDiHDAII2WGfeh7AD2h/SSnbWe2jEB//hOzyn2m66+HZLH+nop
 +i63u4a0a/Hvk/yQu4Z27AKp2d7JeSgagSccQJE1gG3sClZ2tl9B2Ql4oqUOur6cXT5mhnDAWsh
 gas1hH+NzCRiCYl6rgKv6wILoXxKAhbdUb/JADBG0Lu9S7+dLRFxnPcqktL+ylffG+JZlE5WsgR
 We3EFvxXRT+dsYo8StqNAKqFqQlQHnOQ+8S723crW8vxoxGnKpCwsb2ohQRYOWAQIVCCVLNUrZi
 9dEIKKQWjCwprYV4U+4tiBAfDOjwz8kq7yqJ+1292sZfBqXrwKsS4a+HvWsJuwoia7I5yguMe2T
 bYM2AShybSVuI5zsBNw==
X-Proofpoint-GUID: 0Yvh8uWqcGo9uBmB5Q0WUQvWVPYemsCG
X-Proofpoint-ORIG-GUID: KA80EO_QdnMVrLHOf_ZFslS5rbeGCqzC
X-Authority-Analysis: v=2.4 cv=eu/vCIpX c=1 sm=1 tr=0 ts=69fcaa8f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=zP3cuQ7fCVtn8bkGV5YA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070151

On 2026/05/05 03:19 PM, Harsh Prateek Bora wrote:
> 
> 
> On 30/04/26 11:19 am, Amit Machhiwal wrote:
> > Currently, when booting a compatibility-mode KVM guest (L1) on a PowerNV
> > hypervisor (L0), the guest runs with the expected processor
> > compatibility level. However, when booting a nested KVM guest (L2)
> > inside the L1, QEMU derives the CPU model from the raw host PVR and
> > attempts to run the nested guest at that level, instead of honoring the
> > compatibility mode of the L1.
> > 
> > Extend host CPU compatibility capability reporting to support nested
> > virtualization on PowerNV systems (PAPR nested API v1).
> > 
> > For nested API v2 (PowerVM), compatibility capabilities are obtained
> > from the hypervisor via the H_GUEST_GET_CAPABILITIES hcall. This
> > information is not available on PowerNV systems.
> > 
> > For nested API v1, derive the compatibility capabilities from the L1
> > guest by reading the "cpu-version" property from the device tree, which
> > reflects the effective (logical) processor compatibility level. Map this
> > value to the corresponding compatibility capability bitmap.
> > 
> > Introduce a helper to translate CPU version values into compatibility
> > capability bits and integrate it into kvmppc_get_compat_cpu_caps().
> > 
> > This allows userspace to query host CPU compatibility modes on both
> > PowerVM and PowerNV platforms via the KVM_PPC_GET_COMPAT_CAPS ioctl.
> > 
> > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > ---
> >   arch/powerpc/kvm/book3s_hv.c | 37 +++++++++++++++++++++++++++++++++++-
> >   1 file changed, 36 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> > index d602d90111d1..25d05f1ccb72 100644
> > --- a/arch/powerpc/kvm/book3s_hv.c
> > +++ b/arch/powerpc/kvm/book3s_hv.c
> > @@ -6516,16 +6516,51 @@ static bool kvmppc_hash_v3_possible(void)
> >   	return true;
> >   }
> > +static int kvmppc_map_compat_capabilities(const __be32 cpu_version,
> > +				      unsigned long *capabilities)
> > +{
> > +	switch (cpu_version) {
> > +	case PVR_ARCH_31_P11:
> > +		*capabilities |= H_GUEST_CAP_POWER11;
> 
> Should this be:
> 
> +               *capabilities |= H_GUEST_CAP_POWER11 |
> +                                H_GUEST_CAP_POWER10 |
> +                                H_GUEST_CAP_POWER9;
> 
> Likewise, the remaining as applicable?

Not necessarily. This function will be called only when we are booting a nested
KVM guest (L2) on KVM on PowerNV. So, when the L1 KVM guest is booted in a
compat mode, L2 is supposed to boot with the same PVR version as that of the L1
which is already taken care of with the current changes, unless L2 as well
booted with a max-cpu-compat - which would anyway take a different path for
setting the compat.

> 
> > +		break;
> > +	case PVR_ARCH_31:
> > +		*capabilities |= H_GUEST_CAP_POWER10;
> > +		break;
> > +	case PVR_ARCH_300:
> > +		*capabilities |= H_GUEST_CAP_POWER9;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> >   static int kvmppc_get_compat_cpu_caps(struct kvm_ppc_compat_caps *host_caps)
> >   {
> > +	struct device_node *np;
> >   	unsigned long capabilities = 0;
> > +	const __be32 *prop = NULL;
> >   	long rc = -EINVAL;
> > +	u32 cpu_version;
> >   	if (kvmhv_on_pseries()) {
> 
> Commit title says PowerNV, but here were are doing only for PowerVM?

Not really. This would take of both the cases. The else part specifically takes
care of the API v1 nested guests on PowerNV platforms.

Thanks,
Amit

> > -		if (kvmhv_is_nestedv2())
> > +		if (kvmhv_is_nestedv2()) {
> >   			rc = plpar_guest_get_capabilities(0, &capabilities);
> > +		} else {
> > +			for_each_node_by_type(np, "cpu") {
> > +				prop = of_get_property(np, "cpu-version", NULL);
> > +				if (prop) {
> > +					cpu_version = be32_to_cpup(prop);
> > +					break;
> > +				}
> > +			}
> > +			if (!prop)
> > +				return -EINVAL;
> > +			rc = kvmppc_map_compat_capabilities(cpu_version,
> > +								&capabilities);
> > +		}
> >   		host_caps->compat_capabilities = capabilities;
> >   	}
> 

