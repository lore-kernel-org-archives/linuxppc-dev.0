Return-Path: <linuxppc-dev+bounces-25553-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB53C5AC7C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 10:55:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGgzW67n6z3c2P;
	Fri, 07 Aug 2026 20:55:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786100135;
	cv=none; b=MWGXybCIAJStlD0GL+9KeRaSNGkLbqSaXOpCM0Xgsl3zLzQLdKB8Zf8gdLXJxYZ7qwyea/Rzf+xWwWAF2Cw1verCRI1BDD+HdsDx6lZV2ui1hvlnISzI63wR8xDXI3hoAQofXtrIU0JEhKuG5z+ASXoJtlW54S5VV6pIrUxp0H0Nn4fWauWF0UY012iklBJSPRwCHT5lXZ9a0td6W7tsgXrNQkPnex581YXDg8yq0n6yuwEd0jPpv1+mbl6XyQMu0bg3xcTKIEw0+0KWxO9dN3uAyDPF3562XcTyWYXdtxCUChRExRg7UPNjfka4mqNI5S9lZT5m+UpGoTU6OuwVDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786100135; c=relaxed/relaxed;
	bh=FhMUvN1ZH/kzeW+JdrJSF0af5o9jdQInEKs11LICy9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ox5rF8lclFZsB+PzDfA0c9H1z3SoaDeM28KFITHioXvXwPsQXCBQqh0Dlf7TTXA15oyi7yJnxo82EOkKDyMrExRM2qgmfrSmnA/Ljc4l/kY6KoOQy0KUQKhlMEy/uVFcbo2ezsr4+S4mS8yoflYQV68nNP0bVFg1oLKIqHqHMpTGjLRvIoAg4hIvFlZENaLgRJiWrQsMKe4WpEg2qcpn1yyjx1aNFg7L5lpCkhL/ROTFnnHQbJiTV7RvkHFV7luwa1x9Fg4kbpMBf1R9p7PNGu1pW7iszl0iG3ApbUrblovQdEzOiVh3TA/CSx6+VV79fgAkDjjbRXn7M1BXWOy8GA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Huwv0tAv; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Huwv0tAv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGgzV5HZ5z3c2K
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 20:55:33 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770HmZX016229;
	Fri, 7 Aug 2026 10:55:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FhMUvN
	1ZH/kzeW+JdrJSF0af5o9jdQInEKs11LICy9Y=; b=Huwv0tAv1O97yiygLCcdmc
	3rkrskjTyLAQAHOhrsAHfttG0nJttMHycT297W4J6Q7BtGtaOXmQPgKRl5lI92tQ
	47dJWYOPlVQbMOWcY6oeSq3XgbjXQgcE/EBY/xKzJGyMT9pPAq8bThehduzipYdK
	bCMUL8SN3iBjrwvSRqdSkXeeRe4k8nKEWk8+DEjHBdOT1XtQSYzTakWAgBrRpRWB
	ylB7SmaO4K5yqYJojGsupXGuzsaJvampoEarojeJ0qIHDPVtRgsr7dKwksB9ngOo
	4atG7IK/LdcE/iRRapJC3Bi4IExKq5O3QZaHCcLC3c50bpZt4cwQibSNlkS4jzHA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy00bd10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 10:55:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677AfGw7002693;
	Fri, 7 Aug 2026 10:55:18 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgq5nd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 10:55:18 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677AtEZK52167094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 10:55:14 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD81D20040;
	Fri,  7 Aug 2026 10:55:14 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 890F320043;
	Fri,  7 Aug 2026 10:55:11 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  7 Aug 2026 10:55:11 +0000 (GMT)
Date: Fri, 7 Aug 2026 16:25:18 +0530
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
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Gautam Menghani <gautam@linux.ibm.com>
Subject: Re: [PATCH v7 1/4] KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and
 wire up ioctl
Message-ID: <20260807161434.73dfde8c-36-amachhiw@linux.ibm.com>
Mail-Followup-To: Ritesh Harjani <ritesh.list@gmail.com>, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Vaibhav Jain <vaibhav@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Gautam Menghani <gautam@linux.ibm.com>
References: <20260806170645.11892-1-amachhiw@linux.ibm.com>
 <20260806170645.11892-2-amachhiw@linux.ibm.com>
 <ik5mlj9n.ritesh.list@gmail.com>
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
In-Reply-To: <ik5mlj9n.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA4MyBTYWx0ZWRfX4S+G0ecUNXt6
 X8ftRQHrJR2yemtI9NVcyoSGmu6006xQzg18nfoH+oHb6H+LpK/l4xchUchd5SYN/nTDdkUiLYM
 kTxOcqhblZXXoE7P3PB3z3uBbDZODNk=
X-Authority-Analysis: v=2.4 cv=VPTtWdPX c=1 sm=1 tr=0 ts=6a75b997 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=r1NVWg1ErzynySsFdvIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: t6ba9-YfGOqhjufxySW-MpPgkryIHLvJ
X-Proofpoint-GUID: 5jDpvQ_FYB9IkOgyrmz6lPgRxZGSXk2h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA4MyBTYWx0ZWRfXzMMx8Sw/ir4+
 xB5jIsDsJ9JrgkQY9Soavt7WSNxx63zjtE5Zt/W1FhnKAdllPulkJAbTf6BmgoKKf1s4b2veMPX
 Xb6PS+LpMzzMWFVHweerlHgW1qmoFWMmQbB9TZFtiaCrlQdylRjV2lhNBH/3GLaEod95qGMqRGM
 zqYUOrm4M0ddqkKw5JW6HorQrjAGVwOKKGtQksll3oKoI3AWpFzK4eZ2yTP9hhmM+VqApRBGblt
 /5+gWSyAc1Usbn16iVL2eeU6XbgumG87JUhyQlKbbB8vNkD+1cpy0mVhM1E2/MesPjMllcz702U
 6v/cXrthF7I+YbY0X/tPvTCcG+1ygQUMhNsQiY9L03WnbMk6nBwFxSnED58MHeZQE234E0b0wB+
 PGNQBKjDL4DYTlTmM3UPJjx80iUkqFBCDqMd1wDvjj5bRA6eHrAFeKRqxnE1UTalbyNBClyfS51
 ImbHIohAg1MRW7iwpYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070083

Hi Ritesh,

Thanks for reviewing this patch. Please find my response inline below.

On 2026/08/07 08:38 AM, Ritesh Harjani wrote:
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
> > implementation when available.
> >
> > The struct kvm_ppc_compat_caps places the 'size' field first so it can
> > be read alone via get_user() before copy_struct_from_user() is called,
> > avoiding pointer arithmetic to locate the size field.
> >
> > The ioctl is defined using _IO so the ioctl number remains stable even if
> > the struct grows in future versions. It uses copy_struct_from_user() and
> > copy_struct_to_user() to provide forward- and backward-compatible
> > extensibility: older userspace passing a smaller struct to a newer kernel
> > gets zero-padded trailing fields, while newer userspace passing a larger
> > struct to an older kernel (usize > ksize) gets sizeof(struct
> > kvm_ppc_compat_caps) written back to host_caps.size so it can retry with the
> > older kernel-supported size, after which the kernel returns -E2BIG.
> >
> > KVM_PPC_COMPAT_CAPS_SIZE_VER0 is defined as a frozen integer constant
> > (24) marking the size of the initial struct version, used as the
> > minimum floor for size field validation, similar to other versioned
> > struct interfaces in the kernel.
> >
> > The 'flags' field is reserved for future use. The kernel rejects any
> > call where flags is non-zero with -EINVAL, preventing garbage values
> > from being baked into ABI permanently.
> >
> > The ioctl returns appropriate error codes: EINVAL for an invalid size
> > or non-zero reserved fields, E2BIG if new userspace provides a larger
> > struct than the kernel knows about (with ksize written back into
> > host_caps.size for the retry), EFAULT for failed copy operations, and
> > ENOTTY if the backend doesn't implement get_compat_caps.
> >
> > Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> > Tested-by: Gautam Menghani <gautam@linux.ibm.com>
> > Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
> > Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > ---
> > Changes in this version:
> >   - KVM_CAP_PPC_COMPAT_CAPS: add hv_enabled guard to align the capability
> >     check with ioctl availability; a PR KVM VM on pseries now correctly
> >     returns 0 for the capability [Sashiko]
> >
> >  arch/powerpc/include/asm/kvm_ppc.h  |  1 +
> >  arch/powerpc/include/uapi/asm/kvm.h |  8 ++++
> >  arch/powerpc/kvm/powerpc.c          | 71 +++++++++++++++++++++++++++++
> >  include/uapi/linux/kvm.h            |  3 ++
> >  4 files changed, 83 insertions(+)
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
> > index 077c5437f521..19e53d5ae540 100644
> > --- a/arch/powerpc/include/uapi/asm/kvm.h
> > +++ b/arch/powerpc/include/uapi/asm/kvm.h
> > @@ -437,6 +437,14 @@ struct kvm_ppc_cpu_char {
> >  	__u64	behaviour_mask;		/* valid bits in behaviour */
> >  };
> >  
> > +/* For KVM_PPC_GET_COMPAT_CAPS */
> > +struct kvm_ppc_compat_caps {
> > +	__u64	size;			/* Size of this structure */
> > +	__u64	flags;			/* Reserved for future use */
> > +	__u64	compat_capabilities;	/* Capabilities supported by the host */
> > +};
> > +#define KVM_PPC_COMPAT_CAPS_SIZE_VER0	24 /* sizeof first published struct */
> > +
> >  /*
> >   * Values for character and character_mask.
> >   * These are identical to the values used by H_GET_CPU_CHARACTERISTICS.
> > diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> > index b6b83fe3233f..e64b3cfadd3a 100644
> > --- a/arch/powerpc/kvm/powerpc.c
> > +++ b/arch/powerpc/kvm/powerpc.c
> > @@ -703,6 +703,13 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
> >  			}
> >  		}
> >  		break;
> > +#if defined(CONFIG_KVM_BOOK3S_HV_POSSIBLE)
> > +	case KVM_CAP_PPC_COMPAT_CAPS:
> > +		r = 0;
> > +		if (hv_enabled && kvmhv_on_pseries())
> 
> I think sashiko is just complaining in the 1st patch because we have not
> yet wired up the kvmppc_hv_ops->get_compat_caps() yet in patch-1. I
> think it is expecting..
> 
> if (hv_enabled && kvmhv_on_pseries() && kvmppc_hv_ops->get_compat_caps)
> 
> But either way is fine.
> 
> 
> > +			r = 1;
> > +		break;
> > +#endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
> >  	default:
> >  		r = 0;
> >  		break;
> > @@ -2469,6 +2476,70 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
> >  		r = kvm->arch.kvm_ops->svm_off(kvm);
> >  		break;
> >  	}
> > +	case KVM_PPC_GET_COMPAT_CAPS: {
> > +		struct kvm_ppc_compat_caps host_caps = {};
> > +		u64 usize;
> > +
> > +		/*
> > +		 * Read the size field first to drive copy_struct_from_user.
> > +		 * size must be the first field of the struct.
> > +		 */
> > +		r = -EFAULT;
> > +		if (get_user(usize, (__u64 __user *)argp))
> > +			goto out;
> > +
> > +		/*
> > +		 * Enforce a minimum: reject buffers smaller than the initial
> > +		 * struct version (VER0). This allows old userspace compiled
> > +		 * against the original struct to still work on a newer kernel
> > +		 * that has grown the struct with appended fields.
> > +		 */
> > +		r = -EINVAL;
> > +		if (usize < KVM_PPC_COMPAT_CAPS_SIZE_VER0)
> > +			goto out;
> > +
> > +		/*
> > +		 * New userspace with a larger struct called an older kernel.
> > +		 * Write back ksize in host_caps.size so userspace knows which
> > +		 * older struct to retry with, then fail with -E2BIG.
> > +		 */
> > +		if (usize > sizeof(host_caps)) {
> > +			host_caps.size = sizeof(host_caps);
> > +			r = -EFAULT;
> > +			if (put_user(host_caps.size, (__u64 __user *)argp))
> > +				goto out;
> > +			r = -E2BIG;
> > +			goto out;
> > +		}
> 
> You anyways mentioned copy_struct_from_user() is taking care of both
> forward and backward compat. Then what is the point of this check?
> shouldn't we get rid of this complete if logic? I don't see a point of
> this if we are anyway using copy_struct_from_user().

The pre-check is intentional and serves a purpose that
copy_struct_from_user() alone cannot provide: explicit kernel struct
size discovery.

copy_struct_from_user() returns -E2BIG when usize > ksize and trailing
bytes are non-zero — but it gives userspace no way to know what ksize to
retry with. It also silently succeeds when trailing bytes are zero,
which means a new userspace on an old kernel would never learn the
kernel's struct size at all.

This design is different by intent: when new userspace passes a larger
struct, we always return -E2BIG and write back sizeof(host_caps) into
the size field so userspace learns the exact kernel-supported size and
can retry with it. This explicit negotiation is verified in the ABI
extensibility testing in the cover letter ("Newer struct on QEMU, older
kernel -> works"). The explicit -E2BIG + ksize writeback makes the
version negotiation unambiguous.

> 
> > +
> > +		/*
> > +		 * copy_struct_from_user() handles forward/backward compat:
> > +		 *   usize == ksize: verbatim copy
> > +		 *   usize <  ksize: zero-pad trailing (old userspace, new kernel)
> 
> +		 *   usize >  ksize: succeed iff the trailing bytes userspace
> +		 *                   sent are zero, else -E2BIG
> 
> shouldn't we add usize > ksize case details, like ^^^,  which
> copy_struct_from_user() handles since we are already adding the details
> of other 2 cases.

The comment is intentionally limited to two cases. By the time we reach
copy_struct_from_user(), the usize > sizeof(host_caps) case has already
been caught by the pre-check above and returned -E2BIG. So
copy_struct_from_user() can only ever see usize == ksize or usize <
ksize at this point — those are the only two cases worth documenting
here.

Adding the usize > ksize case would be misleading since that code path
is unreachable for this call site.

> 
> 
> </btw snip from copy_struct_from_user kdoc>
> 
>  * There are three cases to consider:
>  *  * If @usize == @ksize, then it's copied verbatim.
>  *  * If @usize < @ksize, then the userspace has passed an old struct to a
>  *    newer kernel. The rest of the trailing bytes in @dst (@ksize - @usize)
>  *    are to be zero-filled.
>  *  * If @usize > @ksize, then the userspace has passed a new struct to an
>  *    older kernel. The trailing bytes unknown to the kernel (@usize - @ksize)
>  *    are checked to ensure they are zeroed, otherwise -E2BIG is returned.
>  *
>  * Returns (in all cases, some data may have been copied):
>  *  * -E2BIG:  (@usize > @ksize) and there are non-zero trailing bytes in @src.
>  *  * -EFAULT: access to userspace failed.
>  
> > +		 */
> > +		r = copy_struct_from_user(&host_caps, sizeof(host_caps),
> > +					  argp, usize);
> > +		if (r)
> > +			goto out;
> > +
> > +		/* Reserved fields must be zero */
> > +		r = -EINVAL;
> > +		if (host_caps.flags)
> > +			goto out;
> > +
> > +		r = -ENOTTY;
> > +		if (!kvm->arch.kvm_ops->get_compat_caps)
> > +			goto out;
> > +
> > +		r = kvm->arch.kvm_ops->get_compat_caps(&host_caps);
> > +		if (r)
> > +			goto out;
> > +
> > +		host_caps.size = sizeof(host_caps);
> 
> shouldn't this be, since we don't want to be reporting a larger size to
> the user?
> 
>           host_caps.size = min_t(u64, usize, sizeof(host_caps));

At this point in the code, usize has already been bounds-checked to
[KVM_PPC_COMPAT_CAPS_SIZE_VER0, sizeof(host_caps)], so min_t(u64, usize,
sizeof(host_caps)) is always equal to usize here — the min_t never
actually clamps anything.

Thanks,
Amit

