Return-Path: <linuxppc-dev+bounces-25337-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C2BC55ABA
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 07:25:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDlT03Crkz2yMl;
	Tue, 04 Aug 2026 17:25:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785828356;
	cv=none; b=lnukPEk7iE3laEWgiMXeFqGz4JR8izBvYgFAL16Arbi+RgBY76ZSwrrRaekRTCGt1Wn7HU+Aa55Qv9uGJlH6Z9dlucD7ELCCcX+fF8VV4716OkGtcy2qMllhG/2RIHveOwMxXwGZ/j6sI30dSauzHo29CDOT4t8JjpJaQgXEm6zjOco7hxGIk6k88B8ZBahHjUgR/vMdWXSN+SqlEGQZJpca/TaKETp1S8UzouL++8IUx5Yv3RoEt2Pbnz7B8wSbXyeqQH5cK0z0PB9zYQPa1geMRv3eNFH2gDFfVdmgjN79O6WNtYiWMEGvfVLQlp0LuQY+2ePcmjHdUzucC5NbZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785828356; c=relaxed/relaxed;
	bh=FqgS6sUxjL/eSw+uw7CCtyNv4vtpf1TjPChcsBOIGgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6ec+l76IFiJ8QejggfGeVhsLR7VZF9819PiHaT5QV2O84PdI6+Ck77w7QRTW+ene1fWsR0y6F/Pzj51AfKvr6Lw8qmUx0lnL5Z1WBJLyyy2N1u5fAB9h/Nwzp4i2ZGkU4CisNn+/GEwxJ1lGtPjBEpKNyWjIxU4ayZMU3W+iD1e62f21KPrwM3+qixgkA9nuKNRz+odJqjkO9RhpPMb7TJXAvACJI7DNBG0djECPEYM+WB9HaXIE4H6RTkBDYCoN9Pcl2UbuXZKSPS32LvSyh8NdQF/UFDpqyk51TISHI3+WyJIXiHl1wCMf49g3lJDscLKnIkzKMz4Sw4gK7UDbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FOury1ZN; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FOury1ZN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDlSz3xJCz2y1Y
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 17:25:55 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6741J6Al3574025;
	Tue, 4 Aug 2026 07:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=FqgS6sUxjL/eSw+uw7CCtyNv4vtpf1
	TjPChcsBOIGgo=; b=FOury1ZN5a0u9abmFEji0WoWYxbG5AcVQ6rut2L5LMjgGV
	636Holau1xFGJmxYGDC3kK4/GYp6i85F+1dZirFR7RuBX0aWVBqCqxhl8b65mY0e
	emPMBS9RVAVJCnMZiPf+F+iN69lq3wuMYyufmUe6Kr8dLImi3s946V2aUgSCUE3F
	r10vmLYAtCON98XZv1fX0+xfDy4e43opUoK/TL5itlEFFDf88AoECLMOhVvKnn1F
	HND+zWEhkMs3a+/2rjtBhwX0vVrY0tFhGWy82fkytoHvR9Wjc032lszU59wZtRAK
	PIZc4g9EDs3GXHrNYIP7TO2edRkuXm3jL/8DAx8A==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hmj9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 07:25:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6747BNqN019657;
	Tue, 4 Aug 2026 07:25:43 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4k0x6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 07:25:42 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6747PcDp28967348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 07:25:38 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6ED6E2004D;
	Tue,  4 Aug 2026 07:25:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BEC120043;
	Tue,  4 Aug 2026 07:25:35 +0000 (GMT)
Received: from Unknown_32:98:3c:96:ca:91 (unknown [9.39.29.19])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  4 Aug 2026 07:25:34 +0000 (GMT)
Date: Tue, 4 Aug 2026 12:55:26 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 1/4] KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and
 wire up ioctl
Message-ID: <anGT5rS60ns59jY-@Unknown_32:98:3c:96:ca:91>
References: <20260701051409.51820-1-amachhiw@linux.ibm.com>
 <20260701051409.51820-2-amachhiw@linux.ibm.com>
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
In-Reply-To: <20260701051409.51820-2-amachhiw@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA1NyBTYWx0ZWRfX04Q52i7QFuBd
 Zt2LfCAv1NoCYIEXDKIbTQ88Cyauw8KtmzS2EX3R8fXIsiHmUpYkPyenLaBNxOx1PbwPuNz5fN8
 5ZYf0ZO0z6dA4rDsTUijuQYk/Oalidk=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a7193f8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=CNzKiYKY9MUnoQtC34kA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA1NyBTYWx0ZWRfXwyYHmXBFSENh
 PSSsdTN8Sysru73AblVjKEuJNA675TU2DrBtSjdLewN8TDp8jpOhtqA99AdkyVv6XsQ9Ha0Gasd
 iMr/Clse1kRiBLiCcrBks04wlMFwKPG4UtjJYAikwrCuJU5dRQe4wbHOe9JGeNRn+XqKYksBTUg
 7sHv+p+WcRcWsNdumqyqSBT1zBIAVr3mxMMbJNFq8PGQDRDIVK5VA3AUBtRtO/LSgnhG7PDJN9m
 4K+YuWO4wCT/WgNMNVb6aTP/jlq8000Js0bDNnJutIsTj/m3V/fGgUbStNQcFt9uhtzJaPggbUn
 FzSweKG84EQUDCzlF3AsPo9iu/3ZCAReonGOs/WP79L2RqtilUMLbcB/NrxJgvjzhJwe+EwwK2A
 ksX+nU9Jm+Ghy3F+BpgagQXGsp9wR1VwE1RqlmF8XN4Jdxd4+R+uRJrDWkCsljDvNye/AVjtrQM
 cbdHizYs+IsF8iULCYg==
X-Proofpoint-ORIG-GUID: yuRiCyUZ9j1C8TTjONbuuIbYkNt17Cj7
X-Proofpoint-GUID: pvGheUSniW-WMWGDpjuoprpvnXvhH-hn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040057

On Wed, Jul 01, 2026 at 10:44:06AM +0530, Amit Machhiwal wrote:
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
> implementation when available.
> 
> The struct kvm_ppc_compat_caps places the 'size' field first so it can
> be read alone via get_user() before copy_struct_from_user() is called,
> avoiding pointer arithmetic to locate the size field.
> 
> The ioctl is defined using _IO so the ioctl number remains stable even if
> the struct grows in future versions. It uses copy_struct_from_user() and
> copy_struct_to_user() to provide forward- and backward-compatible
> extensibility: older userspace passing a smaller struct to a newer kernel
> gets zero-padded trailing fields, while newer userspace passing a larger
> struct to an older kernel (usize > ksize) gets sizeof(struct
> kvm_ppc_compat_caps)written back to host_caps.size so it can retry with the
> older kernel-supported size, after which the kernel returns -E2BIG.
> 
> KVM_PPC_COMPAT_CAPS_SIZE_VER0 is defined as a frozen integer constant
> (24) marking the size of the initial struct version, used as the
> minimum floor for size field validation, similar to other versioned
> struct interfaces in the kernel.
> 
> The 'flags' field is reserved for future use. The kernel rejects any
> call where flags is non-zero with -EINVAL, preventing garbage values
> from being baked into ABI permanently.
> 
> The ioctl returns appropriate error codes: EINVAL for an invalid size
> or non-zero reserved fields, E2BIG if new userspace provides a larger
> struct than the kernel knows about (with ksize written back into
> host_caps.size for the retry), EFAULT for failed copy operations, and
> ENOTTY if the backend doesn't implement get_compat_caps.
> 
> Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
> Changes in this version:
>   - Moved size as the first member of the struct
>   - Replaced strict size equality check with copy_struct_from_user() and
>     copy_struct_to_user() for proper forward and backward ABI compatibility
>   - Added KVM_PPC_COMPAT_CAPS_SIZE_VER0 (24) as a frozen version floor
>     constant, following the convention used by similar interfaces in the kernel
>   - Added flags == 0 enforcement to prevent uninitialized stack values from
>     being baked into ABI permanently
> 
>  arch/powerpc/include/asm/kvm_ppc.h  |  1 +
>  arch/powerpc/include/uapi/asm/kvm.h |  8 ++++
>  arch/powerpc/kvm/powerpc.c          | 71 +++++++++++++++++++++++++++++
>  include/uapi/linux/kvm.h            |  4 ++
>  4 files changed, 84 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
> index 0953f2daa466..169ea6a7fbad 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -319,6 +319,7 @@ struct kvmppc_ops {
>  	bool (*hash_v3_possible)(void);
>  	int (*create_vm_debugfs)(struct kvm *kvm);
>  	int (*create_vcpu_debugfs)(struct kvm_vcpu *vcpu, struct dentry *debugfs_dentry);
> +	int (*get_compat_caps)(struct kvm_ppc_compat_caps *host_caps);
>  };
>  
>  extern struct kvmppc_ops *kvmppc_hv_ops;
> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
> index 077c5437f521..19e53d5ae540 100644
> --- a/arch/powerpc/include/uapi/asm/kvm.h
> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> @@ -437,6 +437,14 @@ struct kvm_ppc_cpu_char {
>  	__u64	behaviour_mask;		/* valid bits in behaviour */
>  };
>  
> +/* For KVM_PPC_GET_COMPAT_CAPS */
> +struct kvm_ppc_compat_caps {
> +	__u64	size;			/* Size of this structure */
> +	__u64	flags;			/* Reserved for future use */
> +	__u64	compat_capabilities;	/* Capabilities supported by the host */
> +};
> +#define KVM_PPC_COMPAT_CAPS_SIZE_VER0	24 /* sizeof first published struct */
> +
>  /*
>   * Values for character and character_mask.
>   * These are identical to the values used by H_GET_CPU_CHARACTERISTICS.
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 98de68379b18..a2919b8b31c0 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -701,6 +701,13 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
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
> @@ -2467,6 +2474,70 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
>  		r = kvm->arch.kvm_ops->svm_off(kvm);
>  		break;
>  	}
> +	case KVM_PPC_GET_COMPAT_CAPS: {
> +		struct kvm_ppc_compat_caps host_caps = {};
> +		u64 usize;
> +
> +		/*
> +		 * Read the size field first to drive copy_struct_from_user.
> +		 * size must be the first field of the struct.
> +		 */
> +		r = -EFAULT;
> +		if (get_user(usize, (__u64 __user *)argp))
> +			goto out;
> +
> +		/*
> +		 * Enforce a minimum: reject buffers smaller than the initial
> +		 * struct version (VER0). This allows old userspace compiled
> +		 * against the original struct to still work on a newer kernel
> +		 * that has grown the struct with appended fields.
> +		 */
> +		r = -EINVAL;
> +		if (usize < KVM_PPC_COMPAT_CAPS_SIZE_VER0)
> +			goto out;
> +
> +		/*
> +		 * New userspace with a larger struct called an older kernel.
> +		 * Write back ksize in host_caps.size so userspace knows which
> +		 * older struct to retry with, then fail with -E2BIG.
> +		 */
> +		if (usize > sizeof(host_caps)) {
> +			host_caps.size = sizeof(host_caps);
> +			r = -EFAULT;
> +			if (put_user(host_caps.size, (__u64 __user *)argp))
> +				goto out;
> +			r = -E2BIG;
> +			goto out;
> +		}
> +
> +		/*
> +		 * copy_struct_from_user() handles forward/backward compat:
> +		 *   usize == ksize: verbatim copy
> +		 *   usize <  ksize: zero-pad trailing (old userspace, new kernel)
> +		 */
> +		r = copy_struct_from_user(&host_caps, sizeof(host_caps),
> +					  argp, usize);
> +		if (r)
> +			goto out;
> +
> +		/* Reserved fields must be zero */
> +		r = -EINVAL;
> +		if (host_caps.flags)
> +			goto out;
> +
> +		r = -ENOTTY;
> +		if (!kvm->arch.kvm_ops->get_compat_caps)
> +			goto out;
> +
> +		r = kvm->arch.kvm_ops->get_compat_caps(&host_caps);
> +		if (r)
> +			goto out;
> +
> +		host_caps.size = sizeof(host_caps);
> +		r = copy_struct_to_user(argp, usize, &host_caps,
> +					sizeof(host_caps), NULL);
> +		break;
> +	}
>  	default: {
>  		struct kvm *kvm = filp->private_data;
>  		r = kvm->arch.kvm_ops->arch_vm_ioctl(filp, ioctl, arg);
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 419011097fa8..1cf9a959669e 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -997,6 +997,7 @@ struct kvm_enable_cap {
>  #define KVM_CAP_S390_KEYOP 247
>  #define KVM_CAP_S390_VSIE_ESAMODE 248
>  #define KVM_CAP_S390_HPAGE_2G 249
> +#define KVM_CAP_PPC_COMPAT_CAPS 250
>  
>  struct kvm_irq_routing_irqchip {
>  	__u32 irqchip;
> @@ -1350,6 +1351,9 @@ struct kvm_s390_keyop {
>  #define KVM_GET_DEVICE_ATTR	  _IOW(KVMIO,  0xe2, struct kvm_device_attr)
>  #define KVM_HAS_DEVICE_ATTR	  _IOW(KVMIO,  0xe3, struct kvm_device_attr)
>  
> +/* Available with KVM_CAP_PPC_COMPAT_CAPS */
> +#define KVM_PPC_GET_COMPAT_CAPS	_IO(KVMIO,  0xe4)

Can you use another ioctl number for this? This group of ioctls is for
fds returned by "KVM_CREATE_DEVICE"

/* ioctls for fds returned by KVM_CREATE_DEVICE */
#define KVM_SET_DEVICE_ATTR       _IOW(KVMIO,  0xe1, struct kvm_device_attr)
#define KVM_GET_DEVICE_ATTR       _IOW(KVMIO,  0xe2, struct kvm_device_attr)
#define KVM_HAS_DEVICE_ATTR       _IOW(KVMIO,  0xe3, struct kvm_device_attr)


> +
>  /*
>   * ioctls for vcpu fds
>   */
> -- 
> 2.50.1 (Apple Git-155)
> 
> 

Thanks,
Gautam

