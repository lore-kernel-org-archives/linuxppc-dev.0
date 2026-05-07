Return-Path: <linuxppc-dev+bounces-20569-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F5FCD343F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 May 2026 14:54:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gBFf2503Lz2xQC;
	Fri, 08 May 2026 00:54:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778165690;
	cv=none; b=ncxwi25qWuERe3mb45/7OQD+PjgB/Ti5emgCLZATZtnrRfTXoLr9Ym08wcxW6pK6Y+Tfty1hAxA47a7XUdBKwedOcpo/nbieJ4kfl0uX2sPBgdKYn4b6/GjNbXPq+ZY5d36Y8wfKxl+fqOi30ANPbElBa3mR1YWmG73G56cfB6i1nx4AfrQYi9pMBk7h5foGgR1e5ui2Niy9HH5LDxNvs40N3GKXissYgq8g0lzrvmyBnDooE6LPRjRyodiqh1olJPfwLUe1PTAwK24TVdCMdP8PjEjHhWqsUD666B7F7Y9oGUyVRnFuvVkI8yp1hoOrVdQGtQFPjNYV73w3uw8Wrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778165690; c=relaxed/relaxed;
	bh=kz6P/cTXNPwJg82hPrz81dbLJxMLFsVHrvIaK6Y73wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTnoCojQh9YFxpmWGmE7P+DOXSOhO5iGDnCQJScqNInhWjTwhnzrN/KdFrPDM2SgTlJGswcHqWsvUha2jSfTGOpzl5OgK3BXgeTRI7ffo+iYlo8uBVRlHouVphEnXCf0ljKQU25tkAPBh6fCEVhF/Yxn7Yr04T4nlBRUBBvk5ypQRZAzzfI14YseZoBt4ZPE6Thy4PO80P43ZIYxGacy5bUB5u8bcN/W3d5g+5Eg+H3RBFF5WSFsbkMg2KcbKFVXeeRJsIsCCqG5ZfvNfoumASI1ICdOAz6uP5puvLPD1Wnod2U5ohugcLUUV/bUm5vuXtjDuhJ6maub96z3Ed5MKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XWm9Jy50; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XWm9Jy50;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gBFf057ynz2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 May 2026 00:54:47 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647BwbhR3053960;
	Thu, 7 May 2026 14:54:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kz6P/c
	TXNPwJg82hPrz81dbLJxMLFsVHrvIaK6Y73wo=; b=XWm9Jy50dGh+oCqZ4EZmdH
	yEb/ULX8x2ARHeuHlCuxEIK462RWxAOUyO2SoucAJfB2wh2alUguvzJnVlA5JXQk
	1tmzJquGYFZ9zT4nnNTI0p4OKQkM9mE/JmPlTy+ScI1cnZM3g/m5TiWfsK6xu3IK
	HnMTYXKMikrAuGMqDYdMUsmc7RahTVEuLHIerYMAKKxr4RyVb+Yc7SvuK1vV6dtr
	xvtt4J/Icjl/Be+ZpoNFw4PPH0cK4Lt+2YfT9xlm0rzONCGnXWaVDMf1t/3dqGz0
	BGCVzTugF8sPdEBiY6NVxdg7pat60RXlqdMNtmlSiPtFeWlITzL3sUS3qanPALDw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9xxx5y4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 14:54:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 647EddCg004623;
	Thu, 7 May 2026 14:54:36 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dww3hc2eu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 14:54:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 647EsWpp40632710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 May 2026 14:54:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39F892004B;
	Thu,  7 May 2026 14:54:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C079E20040;
	Thu,  7 May 2026 14:54:28 +0000 (GMT)
Received: from Amits-MacBook-Pro.local (unknown [9.124.211.112])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  7 May 2026 14:54:28 +0000 (GMT)
Date: Thu, 7 May 2026 20:24:22 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] KVM: PPC: Book3S HV: Implement compat CPU capability
 retrieval for KVM on PowerVM
Message-ID: <20260507195732.48b03c43-2b-amachhiw@linux.ibm.com>
Mail-Followup-To: Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Vaibhav Jain <vaibhav@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260430054906.94431-1-amachhiw@linux.ibm.com>
 <20260430054906.94431-5-amachhiw@linux.ibm.com>
 <52c78fd5-e987-4140-bb37-f358fc25c7e6@linux.ibm.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52c78fd5-e987-4140-bb37-f358fc25c7e6@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE0NiBTYWx0ZWRfX1nB6EcY/pjyW
 MiP4TZuap/Ge31LzZU/fOXKE8m54IaFJtFo906Fw7kyiYSNgIM7fJ8Kr8jEZNgMSQluK/+FCK4M
 Aeqoq27grQhbOHMV61Rc6e/W+3Gl5R76NDN390wWex4Vqk6OrHCqMQ5uckGqxaPUnFtoThqULqt
 Rt2zrNpCUN0QIHlRmlgi6UuadqcXqh9YffnZZpSyrCqCZQ22dn1WqcfpDXlfasB5mVy7t+1CJ+P
 zUoTOhDV7eZARYSZ0hbXRvwP3N79oVKVyeZWl1MVzhXSGwP8dY1nGmeIRZ/yJDLArgl0TY2hfiP
 z0r1hPQVTxMbTRHurCiHqr/5e7DED6ciwIzKsp1jR7mtZ8QEiYE5LOknRdviCNfy1xXjZ9kfJPc
 dmflGOBKbJKq8NgTF0dGyP5FMYXFvucLUDLdeGQwcwRAFuzIickPLg2z/6XOxvRWJ5drYjxXxLl
 ifCMDw2LrAWYsmKYAOg==
X-Proofpoint-ORIG-GUID: YcDSgLB1tgONo6bmiLOGfFjYmJk5_FeL
X-Proofpoint-GUID: kYy46AwlE31DofFwqAU9AESoFaPM8M35
X-Authority-Analysis: v=2.4 cv=ctWrVV4i c=1 sm=1 tr=0 ts=69fca7ad cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=YJwquTfWpi-7YPPFYTYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070146

On 2026/05/05 02:55 PM, Harsh Prateek Bora wrote:
> 
> 
> On 30/04/26 11:19 am, Amit Machhiwal wrote:
> > On POWER systems, the host CPU may run in a compatibility mode (e.g., a
> > Power11 processor operating in Power10 compatibility mode). In such
> > cases, the effective CPU level exposed to guests differs from the
> > physical processor generation.
> > 
> > When running nested KVM guests, QEMU derives the host CPU type using
> > mfpvr(), which reflects the physical processor version. This can result
> > in a mismatch between the CPU model selected by QEMU and the
> > compatibility mode enforced by the host, leading to guest boot failures.
> > 
> > For example, booting a nested guest on a Power11 LPAR configured in
> > Power10 compatibility mode fails with:
> > 
> >    KVM-NESTEDv2: couldn't set guest wide elements
> >    [..KVM reg dump..]
> > 
> > This occurs because QEMU selects a CPU model corresponding to the
> > physical processor (via mfpvr()), while the host operates in a lower
> > compatibility mode. As a result, KVM rejects the requested compatibility
> > level during guest initialization.
> > 
> > Add support for retrieving host CPU compatibility capabilities for
> > nested guests on PowerVM (PAPR nested API v2). The hypervisor provides
> > the effective compatibility levels via the H_GUEST_GET_CAPABILITIES
> > hcall, which reflects the processor modes negotiated between the Power
> > hypervisor (L0) and the host partition (L1).
> > 
> > On pseries systems, obtain the capability bitmap using
> > plpar_guest_get_capabilities() and return it via struct
> > kvm_ppc_compat_caps. This information is then exposed to userspace
> > through the KVM_PPC_GET_COMPAT_CAPS ioctl.
> > 
> > Hook the implementation into the Book3S HV kvmppc_ops so that it can be
> > invoked by the generic KVM ioctl handling code.
> > 
> > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > ---
> >   arch/powerpc/kvm/book3s_hv.c | 17 +++++++++++++++++
> >   1 file changed, 17 insertions(+)
> > 
> > diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> > index 948c6b099a29..d602d90111d1 100644
> > --- a/arch/powerpc/kvm/book3s_hv.c
> > +++ b/arch/powerpc/kvm/book3s_hv.c
> > @@ -6516,6 +6516,22 @@ static bool kvmppc_hash_v3_possible(void)
> >   	return true;
> >   }
> > +
> > +static int kvmppc_get_compat_cpu_caps(struct kvm_ppc_compat_caps *host_caps)
> > +{
> > +
> > +	unsigned long capabilities = 0;
> > +	long rc = -EINVAL;
> > +
> > +	if (kvmhv_on_pseries()) {
> > +		if (kvmhv_is_nestedv2())
> 
> If this is only intended for nested APIv2, it should reflect in commit
> log/title, otherwise, we need to return success with capabilities set to 0
> for non-nestedv2 case.

This patch is specific to nested API v2. I tried to convey that through the “KVM
on PowerVM” in the commit title, and I also described the API v2 scope in the
commit log. If that is still not explicit enough, I can update the title and
commit log in the next revision to make the limitation clearer.

> 
> Also, better to have combined check for pseries and nestedv2 if we are not
> handling other cases.

We are, in the next patch.

> 
> > +			rc = plpar_guest_get_capabilities(0, &capabilities);
> > +		host_caps->compat_capabilities = capabilities;
> 
> Do we need to take care of PowerNV case ?

Next patch takes care of it.

Thanks,
Amit

> > +	}
> > +
> > +	return rc;
> > +}
> > +
> >   static struct kvmppc_ops kvm_ops_hv = {
> >   	.get_sregs = kvm_arch_vcpu_ioctl_get_sregs_hv,
> >   	.set_sregs = kvm_arch_vcpu_ioctl_set_sregs_hv,
> > @@ -6558,6 +6574,7 @@ static struct kvmppc_ops kvm_ops_hv = {
> >   	.hash_v3_possible = kvmppc_hash_v3_possible,
> >   	.create_vcpu_debugfs = kvmppc_arch_create_vcpu_debugfs_hv,
> >   	.create_vm_debugfs = kvmppc_arch_create_vm_debugfs_hv,
> > +	.get_compat_cpu_ver = kvmppc_get_compat_cpu_caps,
> >   };
> >   static int kvm_init_subcore_bitmap(void)
> 

