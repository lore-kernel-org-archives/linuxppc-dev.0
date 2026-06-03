Return-Path: <linuxppc-dev+bounces-21936-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF064CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 03:47:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVYYy055Fz2yRF;
	Wed, 03 Jun 2026 13:47:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780458469;
	cv=none; b=T6FnNC09/Bj1y0obHUvTrSqEBmZld+bQC3Z1iL0Qu86Fo1v6FFRDWQTgRxZd5UIVVReAF9OrhNFGXa+SU8nTLIFbPlEwf1KWImU/+X3lzPSKD4pZVWWnSLLb8j9XCkOL1Rm5cRhzDygozhlMvAplBhAbF8dub5KCYsbHFAHoQQ+wM2Q0pJfTkBfxZSCGfHfNc49CmCV/LIoYr07xLu6CMMCkZ3c3ZvZXSpn9N2/8Kzf5X2iBkV6eSLOAZV2E1hp4z15D5niRzCsCC9xQMpqQH2lA9scHMFw4CPchYKto648RplgF/tyd8EZ2WDgKsxd4CPjoGa40Dmro652lTlSSPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780458469; c=relaxed/relaxed;
	bh=t6Gl0YqP2SCw23q9TRrHCOHvIFcfCSxWI/Eej9Zoc24=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TTUNSEc6QnAUVWa11E1etCLNsbAyhQf++3ulYiy7kWc11jHgNg2Pw4ostIzgZswcqXP2shqSy323C+Fxua3LH1gm3GqYjqiwJKAbG8l4/oB5yHtONxO89i6QzVMJ0BbhoRx17Z6Npru8koiYmRETPbjSNOtJrV0g9a42t+0K3FLiQtLuqmymseHosmt+nxJ0M21w1pNZ1vi1V3F6XUK7ZqYWAwOo8cKTCcFhPziuDg5ryPqgFt/GTAtafPTl1CdJd2YjgXNnknUSGL/GWfaVy6WVJFmmtGlUjWo90Q1o6wvOZYqTdTGA1/EpYvPTurl1mwhkQanK5QxVuSUlP+Lq4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=naqH1DyQ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=naqH1DyQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVYYx035Dz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 13:47:48 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652GbWdT2403947;
	Wed, 3 Jun 2026 03:47:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=t6Gl0YqP2SCw23q9TRrHCOHvIFcfCS
	xWI/Eej9Zoc24=; b=naqH1DyQ+MyMkwKXvjH82M73/1kcnKmiwHte1O4glzNS+O
	vEeEYSzraqk+QwNf14dbJ2gzy53OH0g7iDtRi/7hKt5K7u+mrdg4DUZmwSrUt5Oz
	oV8JIVd4M3z/ywRxh3UtTMmfwZ5UNfGG4gB2E7QXOpw1WsjX+aUORFwn1OJ2SqLX
	dV68jcLSXYB3gWepPRoXM5yqsX+TSoSHRUwGtiNS1et0wpufKzzlsX+ofxrWMxnY
	Ulehxhmf2hbuG3S0G3DKDqdzpPqTiETCV/hdwpX/aCCAnMf+/zfSl3jkHL/tZsGn
	qLftOV1sne8BYGyMGw9vNYyMtxFYzJdLHaur0N1g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpae8juh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 03:47:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6533d8Ts011273;
	Wed, 3 Jun 2026 03:47:35 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ega7qejtc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 03:47:35 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6533lXKa28050080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 03:47:34 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0CA258069;
	Wed,  3 Jun 2026 03:47:33 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D28058065;
	Wed,  3 Jun 2026 03:47:27 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.39.22.158])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with SMTP;
	Wed,  3 Jun 2026 03:47:27 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Wed, 03 Jun 2026 09:16:58 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Anushree Mathur
 <anushree.mathur@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman
 <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lkp@intel.com
Subject: Re: [PATCH v3 2/5] KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and
 wire up ioctl
In-Reply-To: <20260522152744.55251-3-amachhiw@linux.ibm.com>
References: <20260522152744.55251-1-amachhiw@linux.ibm.com>
 <20260522152744.55251-3-amachhiw@linux.ibm.com>
Date: Wed, 03 Jun 2026 09:16:58 +0530
Message-ID: <87pl28z3nx.fsf@vajain21.in.ibm.com>
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
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a1fa3d8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=4zjtUS3i9mBYUgs5ur4A:9
X-Proofpoint-GUID: _QBguawx_mjIpM1PqneZN0Q4F7p5LXok
X-Proofpoint-ORIG-GUID: AvjG9nml9LIWM4fIzC2exBRfOxleuUNF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDAzMCBTYWx0ZWRfX2l8GF/9l7tKa
 afw/yBsL21E9s2ewTJbdGEAm2UbhnDPf4e7G/P9DTRAiUDzTHMn+LozuhxUR5VZyfPIIjaSnXzN
 csvL9EsbCJ+OuWxv9RSIb6Hu0oqRJbajOJDtiXkRkKVEdsTXIhAu16PugoJE6p7OxgbR/vaa50G
 A41yhlXgvic3ab/FSRBkcmh8MV3UkqSMC1OM2EguBgIWjC6zFcotjSG4CMxqRXJ0NqssQ9zo7/L
 jY++0v0B6rQWXvnJXWIBZzfJBmBgUAV8B0mNu1uz+g+TNr7run8KnfVIfOGWM9DSnHlATKHlE8e
 ZYGAwJgQ76Ki0Z/JGNIff05GgNNcrV93I+s0fwYYi6ra9BC1R1ZYPQEa8OjhB+5oXIQHQHDfB7q
 oLC250SQkIJwvrzIIaUTDA/cyIMipGK/cc4/4MvxzvDVzZQ1DFbVKPzmEX601WP/8qQlmxEnCqG
 2bgdvRMxSz3l4LAUh0Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030030

Hi Amit,

Thanks for this patch. Few review comments below:

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> Introduce a new capability and ioctl to expose CPU compatibility modes
> supported by the host processor for nested guests.
>
> On IBM POWER systems, newer processor generations (N) can operate in
> compatibility modes corresponding to earlier generations, like (N-1) and
> (N-2). This is particularly relevant for nested virtualization, where
> nested KVM guests may need to run with a specific processor compatibility
> level.
>
> Introduce KVM_CAP_PPC_COMPAT_CAPS capability and the corresponding
> KVM_PPC_GET_COMPAT_CAPS vm ioctl. The ioctl returns a bitmap describing
> the compatibility modes supported by the host in respective bit numbers,
> allowing userspace (e.g., QEMU) to select an appropriate compatibility
> level when configuring nested KVM guests.
>
> The ioctl handling is added in kvm_arch_vm_ioctl() and retrieves host
> CPU compatibility capabilities via a PowerPC-specific backend
> implementation when available. If the capability is not supported, the
> ioctl returns success with no capabilities set, allowing userspace to
> fall back gracefully.
>
> Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/kvm_ppc.h  |  1 +
>  arch/powerpc/include/uapi/asm/kvm.h |  6 ++++++
>  arch/powerpc/kvm/powerpc.c          | 21 +++++++++++++++++++++
>  include/uapi/linux/kvm.h            |  4 ++++
>  4 files changed, 32 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
> index 0953f2daa466..cadfb839e836 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -319,6 +319,7 @@ struct kvmppc_ops {
>  	bool (*hash_v3_possible)(void);
>  	int (*create_vm_debugfs)(struct kvm *kvm);
>  	int (*create_vcpu_debugfs)(struct kvm_vcpu *vcpu, struct dentry *debugfs_dentry);
> +	int (*get_compat_cpu_ver)(struct kvm_ppc_compat_caps *host_caps);
>  };
>  
>  extern struct kvmppc_ops *kvmppc_hv_ops;
> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
> index 077c5437f521..081d6c7f7f70 100644
> --- a/arch/powerpc/include/uapi/asm/kvm.h
> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> @@ -437,6 +437,12 @@ struct kvm_ppc_cpu_char {
>  	__u64	behaviour_mask;		/* valid bits in behaviour */
>  };
>  
> +/* For KVM_PPC_GET_COMPAT_CAPS */
> +struct kvm_ppc_compat_caps {
> +	__u64	flags;			/* Reserved for future use */
Please introduce a size field also for the UAPI so that in this
structure can evolve in future without breaking kernel ABI.

> +	__u64	compat_capabilities;	/* Capabilities supported by the host */
> +};
> +
>  /*
>   * Values for character and character_mask.
>   * These are identical to the values used by H_GET_CPU_CHARACTERISTICS.
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 00302399fc37..02b834ebd8d3 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -697,6 +697,13 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  			}
>  		}
>  		break;
> +#if defined(CONFIG_KVM_BOOK3S_HV_POSSIBLE)
> +	case KVM_CAP_PPC_COMPAT_CAPS:
> +		r = 0;
> +		if (kvmhv_on_pseries())
> +			r = 1;
> +		break;
> +#endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
>  	default:
>  		r = 0;
>  		break;
> @@ -2463,6 +2470,20 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
>  		r = kvm->arch.kvm_ops->svm_off(kvm);
>  		break;
>  	}
> +	case KVM_PPC_GET_COMPAT_CAPS: {
> +		struct kvm_ppc_compat_caps host_caps;
> +
> +		r = -ENOTTY;
> +		memset(&host_caps, 0, sizeof(host_caps));
> +		if (!kvm->arch.kvm_ops->get_compat_cpu_ver)
> +			goto out;
> +
> +		r = kvm->arch.kvm_ops->get_compat_cpu_ver(&host_caps);
> +		if (!r && copy_to_user(argp, &host_caps,
> +				     sizeof(host_caps)))
As mentioned above please introduce a size field in the structure thats
being copied to the userspace and use the size field to copy the
apporiate structure to the userspace. Otherwise a future kernel may
unintentionally overwrite unintended userspace memory if it happens to
be using a  larger structure size then what VMM knows about.

> +			r = -EFAULT;
> +		break;
> +	}
>  	default: {
>  		struct kvm *kvm = filp->private_data;
>  		r = kvm->arch.kvm_ops->arch_vm_ioctl(filp, ioctl, arg);
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 6c8afa2047bf..1788a0068662 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -996,6 +996,7 @@ struct kvm_enable_cap {
>  #define KVM_CAP_S390_USER_OPEREXEC 246
>  #define KVM_CAP_S390_KEYOP 247
>  #define KVM_CAP_S390_VSIE_ESAMODE 248
> +#define KVM_CAP_PPC_COMPAT_CAPS 249
>  
>  struct kvm_irq_routing_irqchip {
>  	__u32 irqchip;
> @@ -1349,6 +1350,9 @@ struct kvm_s390_keyop {
>  #define KVM_GET_DEVICE_ATTR	  _IOW(KVMIO,  0xe2, struct kvm_device_attr)
>  #define KVM_HAS_DEVICE_ATTR	  _IOW(KVMIO,  0xe3, struct kvm_device_attr)
>  
> +/* Available with KVM_CAP_PPC_COMPAT_CAPS */
> +#define KVM_PPC_GET_COMPAT_CAPS	_IOR(KVMIO,  0xe4, struct
> kvm_ppc_compat_caps)
Minor: you may want to align the name of the newly introduced kvmppc_ops
to KVM CAP you are introducing here.

> +
>  /*
>   * ioctls for vcpu fds
>   */
> -- 
> 2.50.1 (Apple Git-155)
>
>

-- 
Cheers
~ Vaibhav

