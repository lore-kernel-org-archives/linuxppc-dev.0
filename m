Return-Path: <linuxppc-dev+bounces-21707-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45FCCD5BD2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 10:28:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRfht03JBz2yQL;
	Fri, 29 May 2026 20:28:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780050525;
	cv=none; b=DFIgRIeBk1/6QJsxImwblw31cCKXtfTbYd+W8i4JLhOtCOKwx6wl2DTI40JBNrTrcesNDffiWSxiTM/ByoN50U79B0g9cjjBUxc7t2RQnQemdO2LltR+O4gMLDXRk82fzVI/JyFNYb03sYrcH+yujezlqit2uHo66jTtCG+Bq25K91sXxGLNVV/r2Sk9F82ItW+QRtS7DRiyzHMzhBt8v/awrpz8VNJKzw9pMN5DmITgtAa+1xDaf4aqGPVnOc8qgdFqJRj8Jt8aLOlu4/tV+N1DCOcsI95sejNMJFXieE/ATGTFtph5vN0JdegG0no9qFSQz49fg3yUM7h3QRdXyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780050525; c=relaxed/relaxed;
	bh=73ijo5CtYGwj6cMTdH7VlrUWfPogso7oUWOQmYA0u5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWGOb8YpboWrxxUOJ131sgNQMdPY5yaByUVdlA/GZ7LmDKBlH+eBqKwCqLLad3seNqeoQ0QU4HJ+TMcSVsD/ohjRcx87m8eupW606MGMglKiXagXKpst6XB6LHuMU1AKfJgPKzHA1BAr2NHuA/FAgIs/m6w9H4TYDWca+ZcJ7fQWKQdnXWj6QB6k6yVJnGtemPyj8KJxyaVBVxT7fXZNRbwO+rpfdVtbN3KaOzsrxX1+ah2JEqHmbPf1SSSg/+++adKRy/+y4fOLsL9cig5TwbKDwnOjOgRy7xxu3X8o/NXkbA8uSaXaoYSoyKkFPnV+T+sNEcztbDo/xvOvgPQK6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QWigdeIP; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QWigdeIP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRfhs03fCz2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 20:28:44 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SLlgFJ1467756;
	Fri, 29 May 2026 10:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=73ijo5CtYGwj6cMTdH7VlrUWfPogso
	7oUWOQmYA0u5s=; b=QWigdeIPcsPtv5E7NFvr7f8irUPJpH1pO2hka3QoCavVnT
	UeybWBbybbAkDH7xnZ2cLvVmPBUo8/d8P8rnzPpRLuv0MqMlVLA++boaRGxhMgYB
	Px0J2BROVvd/t/efxgCqYQKu3FPU3pnuN4I9fJZdkJV9YPyFXSzJvmvwoCJdO+FJ
	sUB4oyn5ANN/tFAx+hVm+viQ2AIEmKEOMulcfmw3VIpqJWuJD8rhplTFGyUKmfBl
	MV0L3K7IRmRCBlJ8iJIMQndxXV815fVkCsNV0JmBSWz41B2LSHcxhQvTv30rvqYf
	lQX/+qVBLzJFC7hC8k/gzNyZ9FgjxrJRNyHWAYhQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee886g3k0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 10:28:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TAO95L028519;
	Fri, 29 May 2026 10:28:26 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrbd3f7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 10:28:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TASNxS52494676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 10:28:23 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C9C520043;
	Fri, 29 May 2026 10:28:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BD4C2004D;
	Fri, 29 May 2026 10:28:20 +0000 (GMT)
Received: from Amits-MacBook-Pro.local (unknown [9.123.0.51])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 29 May 2026 10:28:20 +0000 (GMT)
Date: Fri, 29 May 2026 15:58:15 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lkp@intel.com
Subject: Re: [PATCH v3 1/5] KVM: PPC: Book3S HV: Validate arch_compat against
 host compatibility mode
Message-ID: <20260529141530.fc225a67-e9-amachhiw@linux.ibm.com>
Mail-Followup-To: Ritesh Harjani <ritesh.list@gmail.com>, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Vaibhav Jain <vaibhav@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lkp@intel.com
References: <20260522152744.55251-1-amachhiw@linux.ibm.com>
 <20260522152744.55251-2-amachhiw@linux.ibm.com>
 <pl2g6xbz.ritesh.list@gmail.com>
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
In-Reply-To: <pl2g6xbz.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: gVM7-xNLxCUksu8_mdoQ5tH8bxrKBAv_
X-Authority-Analysis: v=2.4 cv=Z8Dc2nRA c=1 sm=1 tr=0 ts=6a196a4c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=Y84buafM2nOP-rCehcwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDEwMCBTYWx0ZWRfX0ryEmmrLboTs
 hZjaZ7bOY3SFtgcn/DMeM94MYunsSq36yorTBcD8RYXIRpOgTR38PntB3PLAdtqLUUtrAaTVo2U
 H34Qeoy9pfJCngb67+cD5Riywg/D8h1PKyQMl4+3MYrARUxZGtL9FsTA9GzIKluy274jKecZNtv
 kFVuc/BSeiTVeW0i0aJVs+0xjGvXn+GZLjDaWiDvgcI/U+PSZsYaiEjW2PxA7EfCcjSRafN7Mr1
 uYB9vHQeDCgLBZbk5aPnZEJCFCELfw2CpBfG4PYHFGRQvJS90w73WGiOaQG7Ct7CbB9vJaG6srh
 AF54gmYgZ20uUBEf0q67AKDIu+lhNa8hdZMwOYfFVMgJB8U+dTG/rbZu+lwYxaVaowLId4wquKJ
 jWymRF/aM3wIvRLlogHe/X4mLEYfTMnFGDz5aIl/Q3M8AN4+mLlmfe9PaN9ZJMFzwYh7mZK3tUX
 hjQoXGOX4nr670HJkXQ==
X-Proofpoint-ORIG-GUID: fdffp1RQRWBy5kwV0EKgxVQzGLvO9Z7k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290100

Hi Ritesh,

Thanks for taking a look at this patch. Please find my response inline
below:

On 2026/05/28 08:43 AM, Ritesh Harjani wrote:
> Amit Machhiwal <amachhiw@linux.ibm.com> writes:
> 
> > On IBM POWER systems, newer processor generations can operate in
> > compatibility modes corresponding to earlier generations. This becomes
> > relevant for nested virtualization, where nested KVM guests may need to
> > run with a specific processor compatibility level.
> >
> > Currently, when running a nested KVM guest (L2) inside a Power11 pSeries
> > logical partition (L1) booted in Power10 compatibility mode, the guest
> > fails to boot while setting 'arch_compat'. This happens because the CPU
> > class is derived from the hardware PVR (via mfspr()), which reflects the
> > physical processor generation (Power11), rather than the effective
> > compatibility mode (Power10).
> >
> > As a result, userspace may request a Power11 arch_compat for the L2
> > guest. However, the L1 partition, running in Power10 compatibility, has
> > only negotiated support up to Power10 with the Power Hypervisor (L0).
> > When H_SET_STATE is invoked with a Power11 Logical PVR, the hypervisor
> 
> s/H_SET_STATE/H_GUEST_SET_STATE 

Good catch! I'll fix this in the next version.

> 
> > rejects the request, leading to a late guest boot failure:
> >
> >   KVM-NESTEDv2: couldn't set guest wide elements
> >   [..KVM reg dump..]
> >
> 
> I think irrespective of the other UAPI changes, we should still get this
> fixed - so that we don't see a late KVM guest boot failure msgs.
> 
> So, in this review, I would like to mainly look at fixing this issue
> first and would request if we can defer the UAPI changes as a separate
> patch series please.

This patch only enables the guest boot to bail out early instead of going upto
making an H_GUEST_SET_STATE hcall with a non supported compatibility mode. In
addition to that, it does not fix the real problem where guest fails to boot on
Power11 LPAR booted in a Power10 compatibility mode.

I understand your point and to make the segregation explicitly clear, I shall
update the cover letter to mention that patch 1 only takes care of failing
earlier as soon as an invalid compatibility mode is detected and Patch 2-5
introduce a new uAPI for evaluating the right compatibility mode.

The actual L2 guest boot fix with L1 booted in a compatibility mode is done via
the next 4 patches which enables correct compatibility mode detection using the
newly introduced uAPI. So, we would still want to prioritize the whole series
instead of just this one patch.

> 
> 
> > This situation should be detected earlier. Rejecting unsupported
> > 'arch_compat' values in 'kvmppc_set_arch_compat()' avoids issuing an
> > invalid H_SET_STATE hcall and provides a clearer failure mode.
> 
> s/H_SET_STATE/H_GUEST_SET_STATE

Will rectify in the next version.

> 
> >
> > Add a check to reject Power11 'arch_compat' requests when the host is
> > running in Power10 compatibility mode, returning -EINVAL early instead
> > of deferring the failure to the hypervisor.
> >
> > Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> > Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > ---
> >  arch/powerpc/kvm/book3s_hv.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> > index 61dbeea317f3..249d1f2e4e2c 100644
> > --- a/arch/powerpc/kvm/book3s_hv.c
> > +++ b/arch/powerpc/kvm/book3s_hv.c
> > @@ -446,7 +446,19 @@ static int kvmppc_set_arch_compat(struct kvm_vcpu *vcpu, u32 arch_compat)
> >  			guest_pcr_bit = PCR_ARCH_300;
> >  			break;
> >  		case PVR_ARCH_31:
> > +			guest_pcr_bit = PCR_ARCH_31;
> > +			break;
> >  		case PVR_ARCH_31_P11:
> > +			/*
> > +			 * Need to check this for ISA 3.1, as Power10 and
> > +			 * Power11 share the same PCR. For any subsequent ISA
> > +			 * versions, this will be taken care of by the guest vs
> > +			 * host PCR comparison below.
> > +			 */
> > +			if ((PVR_ARCH_31 & cur_cpu_spec->pvr_mask) ==
> > +				cur_cpu_spec->pvr_value) {
> > +				return -EINVAL;
> > +			}
> 
> Instead of the complicated check can we simply do this?
> 			if (!cpu_has_feature(CPU_FTR_P11_PVR))
> 				return -EINVAL;

Sure, I can base this check on CPU features.

Thanks,
Amit

> 
> which means that if the Qemu is trying to set the arch_compat with P11
> PVR (arch_compat) and if the host cpu FTR doesn't support P11 PVR, then
> simply return -EINVAL
> 
> -ritesh
> 

