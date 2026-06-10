Return-Path: <linuxppc-dev+bounces-22421-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 876F6CD8CB2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 15:53:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gb9L61dttz2yrX;
	Thu, 11 Jun 2026 01:53:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781106814;
	cv=none; b=VdTiCo+nMqpGQKJHfxrfoKWIO/4wYBqXZ8G/mZAOq+fdvLgt5d+aTyb7RsVBhU1BObPjrS4uc6CY1f47o2xbNtTmbDA6e9sLwZWh1T7zJY2tA2tITnqn06pvizsekS2vtswmNDJbVrMnJbj12nqMGYd84WOvkm7HuqqvGssZ0DZxOVygtP2jvnk3dK6/RnH7GrkznmSTkyEOHwY7woRU9mWzeDivFzX1PR0LrWtp9LP3sG8ZuLxUak6I7IUQMKrqF9edOnqsG31N07su92W8XDX3mLqHqbP3qLPs7lExeAUkKyyT7SBvwIMz+TnAw6j5K83IWrH7BFR9KuIqlG9vBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781106814; c=relaxed/relaxed;
	bh=g2E5FiZ63LRQIjfKGaaxoNu3uHCI5b0O4yQZ5HCqp38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eryQuBnjPWYpMZEx1M7t+FAmUOAKj5i3BQWJ09xZifXvQkwsLyM6GMoUBMpOz/7VyiqHAr597ycQj8prQQc32wv+sE7GjfRA21vp+edUT9+8+fT5gpSiDDwb/1y9IhzC18GI0WByYsiO6TIeVWIIu14G4Q7D8/9T+oW196ZSRlgIH6qwrZ28rcuxRsxEhj/6JTQfXDyThORbcwkwwTzrM4btRWok4aSHD+AJlAg/rGEpC01U9FX+zhmr1atHvcRoQsEmOmXsfdM7P0my2YngvkbnAiwgFwfXDapQlmku4e7IF2t5YqAABq2lYIFt7z3aRBbqu16PeNpadx52+Yg6eg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bF+TY6su; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bF+TY6su;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gb9L53nWLz2ykX
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 01:53:32 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A7m09X3513101;
	Wed, 10 Jun 2026 15:53:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=g2E5FiZ63LRQIjfKGaaxoNu3uHCI5b
	0O4yQZ5HCqp38=; b=bF+TY6suCU7NSUN42/xQ8hAiMiLkJ/omkP9OHFZtm6ufnm
	oX8ejIdjOM7Vi7w+4ADrs71k99YhZLCe4I9UfZQh9GKAdLhlZl9zr/fL/YhPfD6J
	DfcseSLIJXvANMmdwu0L4D2hSVAONj8sdlFJBfIpu1KRBodBNEHzyLVyz2wUgJjX
	sEw9KnhsdIMQ8zBFZOcv7cXng+y0FQqjGO3cqS6ul59v4e80+RoQkDeoSh3xM8tS
	JuYGDkbPgRSmU+q5nWQgBESFJZWvcAAUGqiuu63tUAxIaSLzbTzVI2KXZFJQKPzE
	mvJvks8NCtcyUsc2dW9XPgPJvqxLBar7B3R41Y7w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb241xt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 15:53:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65AFntBE004934;
	Wed, 10 Jun 2026 15:53:21 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03g73b5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 15:53:21 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65AFrIe044368306
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 15:53:18 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FF8920049;
	Wed, 10 Jun 2026 15:53:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C79E20040;
	Wed, 10 Jun 2026 15:53:15 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 10 Jun 2026 15:53:15 +0000 (GMT)
Date: Wed, 10 Jun 2026 21:23:17 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lkp@intel.com
Subject: Re: [PATCH v3 4/5] KVM: PPC: Book3S HV: Add support for compat CPU
 capabilities for KVM on PowerNV
Message-ID: <20260610212254.3cec19b0-ef-amachhiw@linux.ibm.com>
Mail-Followup-To: Vaibhav Jain <vaibhav@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anushree Mathur <anushree.mathur@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, lkp@intel.com
References: <20260522152744.55251-1-amachhiw@linux.ibm.com>
 <20260522152744.55251-5-amachhiw@linux.ibm.com>
 <87jysgz292.fsf@vajain21.in.ibm.com>
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
In-Reply-To: <87jysgz292.fsf@vajain21.in.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=b4uCJNGx c=1 sm=1 tr=0 ts=6a298873 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=C8Vz2Ujs2r1iiY_tozkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: QS9JKwRuI7EoydCswWm4uUnL-s98AkHl
X-Proofpoint-GUID: 3aN2sU-fgy2MYeKTz0nVVxtBonT1tyqA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDE0OCBTYWx0ZWRfX1EnIf+YbxpRy
 5srb6zES9vsIinzvkbAQkr395H2uGvsOyOp8qiVIgTFdPlCiMkyHXSyJ+Eqgtb0XhTyD8j5PtzR
 v98Zcfe72P8lCipU5X0KKLmMWKNmW2wUoUXmDVOJe8eIyha+SglKBFqSW+WSQEV/sEhl9o9kIxY
 ezjZUxxJ5bqT+zOd8W+J0YvcWhjygs5yN5lcPfCFbtEdtBjWE1d1re/XzzsvPmvAQd8ZyofOsNm
 9uTlFEWoal7hLg36rY9pJkjIFIQ6+MKrT7xxw2wn3Q79v9+9TUa07640Rt/6J/ERJhjoiiPyUmD
 vuwCIZ/aCOWo3jZV3zNhrf6eli+Au9Bovsm7MFIlTNSd9/JkDpOi5xlTgUkOmWx90kygmxwyy6K
 SLnwb9VKDgy0bPTGMRKYrvG+ZUEvEqbuxcUQZjDs8xMG22BN0ho20SHOnNYpByh6z1jPDSy64k+
 tZxQSK7Sig5c87Dp0jg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100148

On 2026/06/03 09:47 AM, Vaibhav Jain wrote:
> Hi Amit,
> 
> Thanks for the patch. My review comments inline:
> 
> Amit Machhiwal <amachhiw@linux.ibm.com> writes:
> 
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
> > Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> > Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > ---
> >  arch/powerpc/kvm/book3s_hv.c | 37 +++++++++++++++++++++++++++++++++++-
> >  1 file changed, 36 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> > index 38de7040e2b7..18774c49af85 100644
> > --- a/arch/powerpc/kvm/book3s_hv.c
> > +++ b/arch/powerpc/kvm/book3s_hv.c
> > @@ -6522,15 +6522,50 @@ static bool kvmppc_hash_v3_possible(void)
> >  	return true;
> >  }
> >  
> > +static int kvmppc_map_compat_capabilities(const __be32 cpu_version,
> > +				      unsigned long *capabilities)
> > +{
> > +	switch (cpu_version) {
> > +	case PVR_ARCH_31_P11:
> > +		*capabilities |= H_GUEST_CAP_POWER11;
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
> >  
> >  static int kvmppc_get_compat_cpu_caps(struct kvm_ppc_compat_caps *host_caps)
> >  {
> > +	struct device_node *np;
> >  	unsigned long capabilities = 0;
> > +	const __be32 *prop = NULL;
> >  	long rc = -EINVAL;
> > +	u32 cpu_version;
> >  
> >  	if (kvmhv_on_pseries()) {
> > -		if (kvmhv_is_nestedv2())
> > +		if (kvmhv_is_nestedv2()) {
> >  			rc = plpar_guest_get_capabilities(0,
> >  	&capabilities);
> Need to mask capabilities as mentioned in the review comments for
> previous patch. I would suggest creating a helper that performs the
> hcall and applies the mask which can then be used at
> plpar_guest_get_capabilities() call sites.

Sure, will do.

Thanks,
Amit

> 
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
> >  		host_caps->compat_capabilities = capabilities;
> >  	}
> >  
> > -- 
> > 2.50.1 (Apple Git-155)
> >
> 
> -- 
> Cheers
> ~ Vaibhav

