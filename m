Return-Path: <linuxppc-dev+bounces-22924-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 311B2CDB46F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2026 11:11:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gl2Sh45sDz2y71;
	Tue, 23 Jun 2026 21:11:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782213092;
	cv=none; b=LpJrTczq027Wiga6HcXODjYSC07OJ74XOqwmzzScD9T4oBXG39Q6B7LmTpPDz2JgTO4sznfRPiI04DmnxQBfm4C40jjOE1u8f3e41ITNLbKr1SiyceRTZMyma/7AlJsOEJ9A7vBjEW59Hb5w3vbHMEtxy/NpyrFYIAhAtZL1mHSfNEwsA92v9AbpjVLbLgj2zP0gpBNX2g5LevlShzXfenUdjb5nG2x9BEmnJ9wRucRuGg+utM83C6NRqlbUCDRXx6ZluT0+GCerc4WaQimzsAO0+QJMsk0fzYfVbUO2YTmnOj8wtUmJvUKK7MUGlhyzvdiOpIVLiTkpR58MandTZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782213092; c=relaxed/relaxed;
	bh=yBJ486POfh/CKy6R2QtDtV9gbKdDWXkD+wPSnN31lpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyz/JjtJNQBT77u7BryL+RRVz4fz3XTU+Jbswzhy5iMj9/IUlYtJ6qHpFufqHcjkUt6IW1cJlSsh7Fb3GgHznq7dfxbECZhzbT57Q153sahYA2VewhdL/Db50zfiL0KO3L06MWcZGNPpNQoZpq6YEScuyu0WsKRS0zxQ2oCyRxfp9Z75tRZ4Kv1wk/9oiAu69/+DDNCTMiob7S9BB/HMJH3+hWWhoryr2HMlQsIHjvRaanjfwCWeejh1y6FUpG3Htn/z/V1fwC3OHIJo9GsoyeUcYQF+WBGaWf7A5s5Wh+fI94aOqCrwCjscA7pwgKXExCLw6+HGl5I9brGXx6VDlw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sollDm0k; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sollDm0k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gl2Sf67x9z2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 21:11:30 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N6mJG31148009;
	Tue, 23 Jun 2026 11:11:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=yBJ486POfh/CKy6R2QtDtV9gbKdDWX
	kD+wPSnN31lpc=; b=sollDm0kbCJlaU/lFWyIFoEhv4C+GcZgNxN1J1TUPfxQXQ
	TaSy31dSsbVjriyDeMwPhUQiQ38Q7lOeO4tdLRqaverRMYdOHosLwLVuSgKB2HWs
	sG5/ctAqMi3DQi+eHuElIAw8Kwq/zm5F6oH5pRN0swMr8poJDDCgq3zzrnd13Ri4
	vLYWpDYGijo9eAXTNYFbjpC0eIxT/UhIWN6GFEeAQjjn3QN6bLgtIgn8cDNzZket
	l2kXm9v7+o+wxLvFTLYfvEQ8rPPUWqxycEqXK4D11IDW+rtfGlGZoYMwWMPb5FsG
	zBE/p/4kGZ1arUlVTp9CWiREyHKAgl4xLgYnOSZg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4e3hx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 11:11:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NB51WJ029114;
	Tue, 23 Jun 2026 11:11:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66k2w88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 11:11:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NBB63947120656
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 11:11:06 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B11E720043;
	Tue, 23 Jun 2026 11:11:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2DED20040;
	Tue, 23 Jun 2026 11:11:03 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 23 Jun 2026 11:11:03 +0000 (GMT)
Date: Tue, 23 Jun 2026 16:41:07 +0530
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
Subject: Re: [PATCH v4 1/4] KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and
 wire up ioctl
Message-ID: <20260623162456.90450414-ec-amachhiw@linux.ibm.com>
Mail-Followup-To: Vaibhav Jain <vaibhav@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anushree Mathur <anushree.mathur@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, lkp@intel.com
References: <20260616123314.82721-1-amachhiw@linux.ibm.com>
 <20260616123314.82721-2-amachhiw@linux.ibm.com>
 <871pe3cazk.fsf@vajain21.in.ibm.com>
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
In-Reply-To: <871pe3cazk.fsf@vajain21.in.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA4OCBTYWx0ZWRfX1BptHr0N9O7T
 E3XRE/YUWCJ0qc6xCLG4fgzvVnNcMtJKkapdhTCFGHkHmzPczRroVqQ97HuLI+JmaLwpDlj5DGP
 /mNjmLcYlZ1yHW74WZclcJrssMuHV3Q=
X-Proofpoint-ORIG-GUID: x-4ir4d2p3xj8J67if6-Sa0rLus3Eqw3
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3a69d0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=BK828DTCH-fAdFGChxgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA4OCBTYWx0ZWRfX98JKAv1aDOV8
 gdE3HTqJ1rAId7dv6vSWoQPxtGijm2SxcE2ecWl2srcoISQJ7hFJV/qcN44uDsKnwC3ymOxkpP3
 DSBf/xaa4zwTDJ3QAZIe0s8kfHOxAnjodDyGwX68SFPhXpoM1RfOIBnmAKZylZ1qzjP6kp/C92b
 4SFexWP4niEZW7Ecaz+S24ph07zDoLrn8kAFQkDYXmlIgBDY9kGhCSyb9pxe9OAEFg5xhZvN4Zx
 /83bMKLdU1DWVuyzr58mYHm6+G2tlDv01rw8eG3tZQUt3qbuoPydUb/GmYx5dEmc6SoKEVvID16
 VorBEtXLJix5rZlmAfPnik3+j1Kj3mkCjJy8SUsM4C6pnhErYIjTEKLGHrf7l7RpmJcG6/E1vH6
 zBnOW1kehHc7lvL5jtBk/QzVUkfaUi4PPFghhb+rveEINikNJU0WfEjL3y5TVQ402K8m8QD2hsD
 9IzuBtzMM2cL4YmNELQ==
X-Proofpoint-GUID: KX-dP-pr8Lp8SFQyJWIDVbrs4G8XgU3B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230088

Hi Vaibhav,

Thanks for the detailed review. My responses are inline below.

On 2026/06/19 11:44 AM, Vaibhav Jain wrote:
> Hi Amit.
> 
> Thanks for the patch and incorporating V3 review comments. Further
> review comments inline below:
> 
> Amit Machhiwal <amachhiw@linux.ibm.com> writes:
> 
> > Introduce a new capability and ioctl to expose CPU compatibility modes
> > supported by the host processor for nested guests.
> >
> > On IBM POWER systems, newer processor generations (N) can operate in
> > compatibility modes corresponding to earlier generations, like (N-1) and
> > (N-2). This is particularly relevant for nested virtualization, where
> > nested KVM guests may need to run with a specific processor compatibility
> > level.
> >
> > Introduce KVM_CAP_PPC_COMPAT_CAPS capability and the corresponding
> > KVM_PPC_GET_COMPAT_CAPS vm ioctl. The ioctl returns a bitmap describing
> > the compatibility modes supported by the host in respective bit numbers,
> > allowing userspace (e.g., QEMU) to select an appropriate compatibility
> > level when configuring nested KVM guests.
> >
> > The ioctl handling is added in kvm_arch_vm_ioctl() and retrieves host
> > CPU compatibility capabilities via a PowerPC-specific backend
> > implementation when available. The implementation validates the structure
> > size from userspace to ensure forward compatibility and returns
> > appropriate error codes (EINVAL for invalid size, EFAULT for copy
> > failures, ENOTTY if backend is not implemented). The struct
> > kvm_ppc_compat_caps includes a size field to support future ABI
> > extensions.
> >
> > Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > ---
> >  arch/powerpc/include/asm/kvm_ppc.h  |  1 +
> >  arch/powerpc/include/uapi/asm/kvm.h |  7 ++++++
> >  arch/powerpc/kvm/powerpc.c          | 35 +++++++++++++++++++++++++++++
> >  include/uapi/linux/kvm.h            |  4 ++++
> >  4 files changed, 47 insertions(+)
> >
> > diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
> > index 0953f2daa466..169ea6a7fbad 100644
> > --- a/arch/powerpc/include/asm/kvm_ppc.h
> > +++ b/arch/powerpc/include/asm/kvm_ppc.h
> > @@ -319,6 +319,7 @@ struct kvmppc_ops {
> >  	bool (*hash_v3_possible)(void);
> >  	int (*create_vm_debugfs)(struct kvm *kvm);
> >  	int (*create_vcpu_debugfs)(struct kvm_vcpu *vcpu, struct dentry *debugfs_dentry);
> > +	int (*get_compat_caps)(struct kvm_ppc_compat_caps *host_caps);
> >  };
> >  
> >  extern struct kvmppc_ops *kvmppc_hv_ops;
> > diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
> > index 077c5437f521..8a38be6c3b03 100644
> > --- a/arch/powerpc/include/uapi/asm/kvm.h
> > +++ b/arch/powerpc/include/uapi/asm/kvm.h
> > @@ -437,6 +437,13 @@ struct kvm_ppc_cpu_char {
> >  	__u64	behaviour_mask;		/* valid bits in behaviour */
> >  };
> >  
> > +/* For KVM_PPC_GET_COMPAT_CAPS */
> > +struct kvm_ppc_compat_caps {
> > +	__u64	flags;			/* Reserved for future use */
> > +	__u64	size;			/* Size of this structure */
> Suggesting moving the 'size' as the first member of the struct. That way
> copying the struct from userspace becomes bit easier.

Yeah, I think it would make more sense and will simplify the
copy_from_user() call. I will make the change in v5. I will change to:

  struct kvm_ppc_compat_caps {
  	__u64	size;
  	__u64	flags;
  	__u64	compat_capabilities;
  };

> 
> > +	__u64	compat_capabilities;	/* Capabilities supported by the host */
> > +};
> > +
> >  /*
> >   * Values for character and character_mask.
> >   * These are identical to the values used by H_GET_CPU_CHARACTERISTICS.
> > diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> > index 98de68379b18..9153b0034b45 100644
> > --- a/arch/powerpc/kvm/powerpc.c
> > +++ b/arch/powerpc/kvm/powerpc.c
> > @@ -701,6 +701,13 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
> >  			}
> >  		}
> >  		break;
> > +#if defined(CONFIG_KVM_BOOK3S_HV_POSSIBLE)
> > +	case KVM_CAP_PPC_COMPAT_CAPS:
> > +		r = 0;
> > +		if (kvmhv_on_pseries())
> > +			r = 1;
> > +		break;
> > +#endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
> >  	default:
> >  		r = 0;
> >  		break;
> > @@ -2467,6 +2474,34 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
> >  		r = kvm->arch.kvm_ops->svm_off(kvm);
> >  		break;
> >  	}
> > +	case KVM_PPC_GET_COMPAT_CAPS: {
> > +		struct kvm_ppc_compat_caps host_caps;
> > +		u64 user_size;
> > +
> > +		r = -EFAULT;
> > +		/* First, get the size field from userspace to validate */
> > +		if (copy_from_user(&user_size, &((struct kvm_ppc_compat_caps
> > +		     __user *)argp)->size, sizeof(user_size))) {
> move the struct size member to the first field. That way
> from_from_user() call is simplified and you wont have to do some wired
> pointer arithmetic.

Will do as mentioned above.

> 
> 
> > +			goto out;
> > +		}
> > +
> > +		/* Validate size - must be at least the current structure size */
> > +		r = -EINVAL;
> > +		if (user_size < sizeof(host_caps))
> > +			goto out;
> Check should be strengthed to
>  if (user_size != sizeof(host_caps))
> So that in case used space sends a struct larger than what kernel knows
> abt it will be rejected. This will prevent surprises in future in case
> VMM sends a larger struct expecting kernel to know abt it but an older
> kernel only knows abt older smaller sized struct. Also look at the
> review comment below.

Agreed. I'll change the validation to use strict equality. This is
simpler and clearer - userspace must provide exactly the size the kernel
expects.

> 
> > +
> > +		r = -ENOTTY;
> > +		memset(&host_caps, 0, sizeof(host_caps));
> > +		if (!kvm->arch.kvm_ops->get_compat_caps)
> > +			goto out;
> > +
> > +		r = kvm->arch.kvm_ops->get_compat_caps(&host_caps);
> > +		/* Set the actual size of the structure we're returning */
> > +		host_caps.size = sizeof(host_caps);
> > +		if (!r && copy_to_user(argp, &host_caps, sizeof(host_caps)))
> > +			r = -EFAULT;
> You are allowing a future userspace VMM to potentially send a larger
> 'struct kvm_ppc_compat_caps' that what kernel knows about. This makes
> error handling in userspace bit involved since there might be some
> fields in the 'struct kvm_ppc_compat_caps' given from userspace may
> remain un-initialized when userspace sees it. So please mention this
> subtle behaviour should be mentioned in patch description and also
> update it the doc in the later patch.

With the strict equality check (user_size != sizeof(host_caps)), this
concern should be addressed - we won't accept larger structs from
userspace. However, I'll still improve the documentation to:

1. In the commit message:
   - Explain the size field validation
   - Document that exact size match is required
   - Clarify error handling behavior

2. In Documentation/virt/kvm/api.rst:
   - Add improved documentation for KVM_PPC_GET_COMPAT_CAPS
   - Document the size field requirement and validation

Thanks,
Amit

> 
> > +		break;
> > +	}
> >  	default: {
> >  		struct kvm *kvm = filp->private_data;
> >  		r = kvm->arch.kvm_ops->arch_vm_ioctl(filp, ioctl, arg);
> > diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> > index 6c8afa2047bf..1788a0068662 100644
> > --- a/include/uapi/linux/kvm.h
> > +++ b/include/uapi/linux/kvm.h
> > @@ -996,6 +996,7 @@ struct kvm_enable_cap {
> >  #define KVM_CAP_S390_USER_OPEREXEC 246
> >  #define KVM_CAP_S390_KEYOP 247
> >  #define KVM_CAP_S390_VSIE_ESAMODE 248
> > +#define KVM_CAP_PPC_COMPAT_CAPS 249
> >  
> >  struct kvm_irq_routing_irqchip {
> >  	__u32 irqchip;
> > @@ -1349,6 +1350,9 @@ struct kvm_s390_keyop {
> >  #define KVM_GET_DEVICE_ATTR	  _IOW(KVMIO,  0xe2, struct kvm_device_attr)
> >  #define KVM_HAS_DEVICE_ATTR	  _IOW(KVMIO,  0xe3, struct kvm_device_attr)
> >  
> > +/* Available with KVM_CAP_PPC_COMPAT_CAPS */
> > +#define KVM_PPC_GET_COMPAT_CAPS	_IOR(KVMIO,  0xe4, struct kvm_ppc_compat_caps)
> > +
> >  /*
> >   * ioctls for vcpu fds
> >   */
> > -- 
> > 2.50.1 (Apple Git-155)
> >
> >
> 
> -- 
> Cheers
> ~ Vaibhav

