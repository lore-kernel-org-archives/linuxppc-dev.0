Return-Path: <linuxppc-dev+bounces-22419-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39EC7CD8CB9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 15:47:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gb9CK5fGqz2yrX;
	Thu, 11 Jun 2026 01:47:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781106461;
	cv=none; b=IbLX1bbphThh87wzDZCxkc3lHU3d3Lq8C/v0byBC9zpGSVltlj+CMrvrQvIzOFj2gkPvN9v4/MZ3p0yJu6/8TiL5RDNJKmY4KD2qNQtbbzu23NFkQ5hSeF+qvCgjZNr39zsMF3lYcCtfLwXJZWwD16oNoww+/MJwWVPhwxxYq/eU1LWsSj4WvYuHEABwOiLsFCuBLfL2gjMCD3t42epZvirBXmUOrWQvXgzvI2S0rqUGvJiVpcQ1D9cC8fZQRgR4RycWBpUZ3liXY+q1MafJZ5mc1951uObKn782GSkD7fVpfAers54jOb4i/pXG+ctSsFP58gsTNguO+NBKUvSs2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781106461; c=relaxed/relaxed;
	bh=F9Hypa89gAReOQHmEvxQjPNyohIgM32phqPh11LBjt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUB/5Z1C7Q4plRItnOidaJoFkLgnu7j8r5rMqeQVdnURFlZWD6yoMyR8XOni9S/zrlbLoG6uHTwiSUAPe7oKOTqnR5+L8kNipe0C5oNpIzOrhWGSWCtJZ+M0kxDG8t+LQiuavivdGboog+RYP5KnLYyIorvoMNrQ5GOlG5nED0Jy3ps3l8yhqudw+vSdqXbAbpC1qz90A4SKtLKF3WS5mnrBOhpIfuB6BGu8vB7sy+c6aOTWTsf7hvgdgq93AkkyPx0RW7spjnMuQjaes8GhUNBqwK9YH7a/0SLxX3NjoYIGYkBqmDQnvIjTQk9s7QAIZzkp+SCyqvZxsCD6jO7ZRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pa6SHsBT; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pa6SHsBT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gb9CJ61JDz2ykX
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 01:47:40 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65AEdhiv2688319;
	Wed, 10 Jun 2026 15:47:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=F9Hypa89gAReOQHmEvxQjPNyohIgM3
	2phqPh11LBjt8=; b=pa6SHsBTWp0nMu3fzJxb/bGwc6BJK7ZKhF9FaR1fx0Ufxk
	rfdJFLbpIXl5HUaoXnD1POVpjGUYYAUGd5TrphQJkqyKG72gBTMJD1CrIlcPFAkg
	SqNgUpblFlpwtXh8Z5UNooPnAg00vjUlJCAKBLtGxruWOCrMhP+IPFLZ/YPzL/4e
	y6ZayUbGAV4CU+gfALJthW45f77J4vY8j8XaKSghp811f0v0/q5nM7xsETIQcml5
	mVXA0ros/AD2AbjeGkETiMQYG5KB6sDlM5yQY7B6WILm6KDlRiNSAtiao4t0H0Qa
	f6khlivQ7ZyMpt+Qgwdl/l0o8mMihtWIzXVC5e9A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ye9gg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 15:47:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65AFYZbQ024799;
	Wed, 10 Jun 2026 15:47:20 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en0jyf15t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 15:47:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65AFlGNp42402180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 15:47:16 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 619D720043;
	Wed, 10 Jun 2026 15:47:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4F3620040;
	Wed, 10 Jun 2026 15:47:13 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 10 Jun 2026 15:47:13 +0000 (GMT)
Date: Wed, 10 Jun 2026 21:17:15 +0530
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
Subject: Re: [PATCH v3 2/5] KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and
 wire up ioctl
Message-ID: <20260610211350.ff62b2d0-b2-amachhiw@linux.ibm.com>
Mail-Followup-To: Vaibhav Jain <vaibhav@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anushree Mathur <anushree.mathur@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, lkp@intel.com
References: <20260522152744.55251-1-amachhiw@linux.ibm.com>
 <20260522152744.55251-3-amachhiw@linux.ibm.com>
 <87pl28z3nx.fsf@vajain21.in.ibm.com>
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
In-Reply-To: <87pl28z3nx.fsf@vajain21.in.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDE0OCBTYWx0ZWRfX0C6egcHhst3L
 HPev97mR/2sUqiVqHluSoCUveOzqLg8IUomZovfeYzm6hzgIHu4DXlwtxctQQudS24RYcKOiISF
 vxAk6y+SGRbFbr0RiBLAT8aJgcR4OTl/yewY5V2mJ6d15SOblnxYbYw4UjfsZZtQMuNULCpRW5d
 b2YeiKI67pxJykJuP+br70Lmt9dWvfolBLElepOvQ6UbC0PBFerRFqALJzSZlQ97HqyGrASieov
 np8jpNPJGr0loGmY/6qGdI45uCURc0QN2B5n9XVVkbf4/RzCdxpeGm52HGwah9QQ1c5+tHtBR3U
 A9maXK3pi8Cc1zB2gaXhMipifU45oK9r/CEXYC7jzFTTWJrGPLpixclq/lPrA8HcH2i1oJzHFHc
 Kad1IscooJZgFrZSAjaYVhF+J3C19epnKJC/heAEvPC6qkFvBif7rgW6ZvqQVGihCmkatcx/ksO
 WDYOc2yhIXFYjAaZ+kw==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a298709 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=hyIHeesGBAN42lQhcX0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: LyhLHReaSS3CryATyGIns3pCiYTxPKyl
X-Proofpoint-ORIG-GUID: RF6bcsE0KgeEwzTJaYnq6IRHeV7H30aj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100148

Hi Vaibhav,

Thanks for reviewing the patches. Please find my response inline.

On 2026/06/03 09:16 AM, Vaibhav Jain wrote:
> Hi Amit,
> 
> Thanks for this patch. Few review comments below:
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
> > implementation when available. If the capability is not supported, the
> > ioctl returns success with no capabilities set, allowing userspace to
> > fall back gracefully.
> >
> > Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> > Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > ---
> >  arch/powerpc/include/asm/kvm_ppc.h  |  1 +
> >  arch/powerpc/include/uapi/asm/kvm.h |  6 ++++++
> >  arch/powerpc/kvm/powerpc.c          | 21 +++++++++++++++++++++
> >  include/uapi/linux/kvm.h            |  4 ++++
> >  4 files changed, 32 insertions(+)
> >
> > diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
> > index 0953f2daa466..cadfb839e836 100644
> > --- a/arch/powerpc/include/asm/kvm_ppc.h
> > +++ b/arch/powerpc/include/asm/kvm_ppc.h
> > @@ -319,6 +319,7 @@ struct kvmppc_ops {
> >  	bool (*hash_v3_possible)(void);
> >  	int (*create_vm_debugfs)(struct kvm *kvm);
> >  	int (*create_vcpu_debugfs)(struct kvm_vcpu *vcpu, struct dentry *debugfs_dentry);
> > +	int (*get_compat_cpu_ver)(struct kvm_ppc_compat_caps *host_caps);
> >  };
> >  
> >  extern struct kvmppc_ops *kvmppc_hv_ops;
> > diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
> > index 077c5437f521..081d6c7f7f70 100644
> > --- a/arch/powerpc/include/uapi/asm/kvm.h
> > +++ b/arch/powerpc/include/uapi/asm/kvm.h
> > @@ -437,6 +437,12 @@ struct kvm_ppc_cpu_char {
> >  	__u64	behaviour_mask;		/* valid bits in behaviour */
> >  };
> >  
> > +/* For KVM_PPC_GET_COMPAT_CAPS */
> > +struct kvm_ppc_compat_caps {
> > +	__u64	flags;			/* Reserved for future use */
> Please introduce a size field also for the UAPI so that in this
> structure can evolve in future without breaking kernel ABI.

Sure, adding a size field for validations and future extensibility makes
sense. I'll add it in the next version.

> 
> > +	__u64	compat_capabilities;	/* Capabilities supported by the host */
> > +};
> > +
> >  /*
> >   * Values for character and character_mask.
> >   * These are identical to the values used by H_GET_CPU_CHARACTERISTICS.
> > diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> > index 00302399fc37..02b834ebd8d3 100644
> > --- a/arch/powerpc/kvm/powerpc.c
> > +++ b/arch/powerpc/kvm/powerpc.c
> > @@ -697,6 +697,13 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
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
> > @@ -2463,6 +2470,20 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
> >  		r = kvm->arch.kvm_ops->svm_off(kvm);
> >  		break;
> >  	}
> > +	case KVM_PPC_GET_COMPAT_CAPS: {
> > +		struct kvm_ppc_compat_caps host_caps;
> > +
> > +		r = -ENOTTY;
> > +		memset(&host_caps, 0, sizeof(host_caps));
> > +		if (!kvm->arch.kvm_ops->get_compat_cpu_ver)
> > +			goto out;
> > +
> > +		r = kvm->arch.kvm_ops->get_compat_cpu_ver(&host_caps);
> > +		if (!r && copy_to_user(argp, &host_caps,
> > +				     sizeof(host_caps)))
> As mentioned above please introduce a size field in the structure thats
> being copied to the userspace and use the size field to copy the
> apporiate structure to the userspace. Otherwise a future kernel may
> unintentionally overwrite unintended userspace memory if it happens to
> be using a  larger structure size then what VMM knows about.

Sure, I'll add a validation around the structure size.

> 
> > +			r = -EFAULT;
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
> > +#define KVM_PPC_GET_COMPAT_CAPS	_IOR(KVMIO,  0xe4, struct
> > kvm_ppc_compat_caps)
> Minor: you may want to align the name of the newly introduced kvmppc_ops
> to KVM CAP you are introducing here.

Will do.

Thanks,
Amit

> 
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

