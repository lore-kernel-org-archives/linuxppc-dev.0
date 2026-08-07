Return-Path: <linuxppc-dev+bounces-25581-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDF2C2A09B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 13:05:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGks508NMz3c4l;
	Fri, 07 Aug 2026 23:05:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786107912;
	cv=none; b=JOopld+plsBTBsWxiQ6HtE9OSM7p9xuN5AIMPEYAqX5ihKAl/1kAKnq3MDGveEnQED8A7OHOOK7kouCy0s1XIT1Gz/MNNlZQwVBqXR1B3+1Rhq0ciV97HoWTXjauZ7ldq+wN+4l5z5SSjRGN5465o0iHI8rFl/e7AVpVvb8BQ7xtURBzaQDQrofRGm6D6oWydfum7NxDB92Sei34H8aTLKJjujEt7oKv53lhk682rJfhPSw9T4+vMbU5GqUyijflu5AHOXl885DhfAw+twRlkqF+Mw74narJ851WH+NJD0CsesPuIWPArwrB/FGCftAYKp3nDSUD1SfcgmOaHgX/NA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786107912; c=relaxed/relaxed;
	bh=c7Zt2cJcYDfRFlMdh4SH0h3y2GANc4Ok5cTjrhSHrhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzaUCXOUOCwbsE+OKfL5SnK56xGbS5n1YananBvrCsNOMS30e27QENToRoxpnyEpxdSXQ9UNeqGtfYNc7lMqVWJK5/2zBtNIpCa2xdOllU6HWSKmjHq7ivFVOmrHA3Sqg/FwTYcH1/qnTpPGK/XjptH4Xq3VUQIn6tpd0Fqah2s31QszvrETbo8ErbG7L1dpPND8y6TllkEJTGq+X+0PBeW2etYXoZueVGoPT5YXH2QOC5GgmtXYibDAYw5P3J1ANpqPwP8GrIgxVHQC351s6Es45EXtl/bXUS8ijfpiEpmtlk6cMBaBaqn6tGyDELArDJVS4/UAHB9htensDcSIwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WHa9Pmxt; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WHa9Pmxt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGks40F9kz3c4f
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 23:05:11 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677Cm4SG1413128;
	Fri, 7 Aug 2026 13:05:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=c7Zt2c
	JcYDfRFlMdh4SH0h3y2GANc4Ok5cTjrhSHrhE=; b=WHa9PmxtHNomM3e9BNUpuB
	HwTvjtwCjN72MnPsZUMMZjZTg3emgJi7rAwQ899cvzfAsHovqSB89M7v9zEgLboR
	jAjhx/nu/oWLnVaKGHIb7BABSBDDrx0MgiaPhMdJDsfDy8kbxvj9mcCfnF39jwkK
	YFKmfZg4rCrMUMRVfhQ6vijVPGuC8XoozYvQ38MAqLHwkV6odS1KN51buTIsLh0d
	2ANIcTDipF5bMOxx2Inkw17wdPDnasGTiMr7TRhJoEuB0/B+4bhx+Vji093fYR9u
	uAqSVUqqED0uZbEVJ/0z4GOV06oM+KZRa2sp7Do4k5gUcU8u6kEOuv46ecPcC9Wg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy02bva7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 13:04:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677CuHbI028708;
	Fri, 7 Aug 2026 13:04:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qyvva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 13:04:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677D4txw39256376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 13:04:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13A9A2004E;
	Fri,  7 Aug 2026 13:04:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01D6620063;
	Fri,  7 Aug 2026 13:04:52 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  7 Aug 2026 13:04:51 +0000 (GMT)
Date: Fri, 7 Aug 2026 18:34:58 +0530
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
Message-ID: <20260807182905.c357b7de-95-amachhiw@linux.ibm.com>
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
 <20260807161434.73dfde8c-36-amachhiw@linux.ibm.com>
 <8q6ikvqo.ritesh.list@gmail.com>
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
In-Reply-To: <8q6ikvqo.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=G6ws1dk5 c=1 sm=1 tr=0 ts=6a75d7fc cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=h3gdUq23L0XHQMYVencA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEwMCBTYWx0ZWRfX7XHbdyWVZZUp
 bz971WoWmET5t5COtd1tpChD6GwHuWz0KZt87obkz4RFQU+kmByMqHDO6En/0sMw/xTlV8cdTJP
 ThWfLSrfXban3+LKqyXX1jD91hFFsD6oOyJJu9t9saWdbbYbJHVeZ+o5Q/WABrbJbAIxxNXig+x
 OA0RNOzo/ytJyIyL3w8X+DSGdSiU3Tmw+IywUm61XYaB3x6Tj+xGmWsF+XaDN3wmAgyFiu2uBu1
 JEJbSrTzNRNfWUBRElBMT450hH4CIghyDZmHsN8zlJ0RqoKcur4W5i+VdQAJRd76a7dTOWbQkqu
 UuvNZpkM6FOda31Csmqn5oGB39kWFlj/Zp4/UmzkOj3tvIDHSNuQJ4LxA6kAwyglSSZvw5hr6N6
 tuxwtFCb/FJEPgxHfLaB0k0Cw0AS2dJ0DCEb6Pt9RWHJzRzlH1lhijUQIOEEPlZTnAuytkHzkvX
 voXns7bpBxV8DmA1ViQ==
X-Proofpoint-ORIG-GUID: Dlan0QoHbDmDevN3o__qjBND2Ck4EdFP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEwMCBTYWx0ZWRfXy7JInibYBrrc
 YJgrblyoTkc/LWIPSGrex3rWH/i/8LucFZR/kPn3S6My2H5Mcgu6+118GlMlqQGu5XD93L5anR1
 Gs7bL1NcYoijmJ5V2EmQmnl7s4sUJBI=
X-Proofpoint-GUID: x4LCc1u6ywBL69xwSiNo8KjmO2kF_yiN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070100

On 2026/08/07 05:06 PM, Ritesh Harjani wrote:
> Amit Machhiwal <amachhiw@linux.ibm.com> writes:
> 
> > Hi Ritesh,
> >
> > Thanks for reviewing this patch. Please find my response inline below.
> >
> > On 2026/08/07 08:38 AM, Ritesh Harjani wrote:
> >> Amit Machhiwal <amachhiw@linux.ibm.com> writes:
> >> 
> >> > Introduce a new capability and ioctl to expose CPU compatibility modes
> >> > supported by the host processor for nested guests.
> >> >
> >> > On IBM POWER systems, newer processor generations (N) can operate in
> >> > compatibility modes corresponding to earlier generations, like (N-1) and
> >> > (N-2). This is particularly relevant for nested virtualization, where
> >> > nested KVM guests may need to run with a specific processor compatibility
> >> > level.
> >> >
> >> > Introduce KVM_CAP_PPC_COMPAT_CAPS capability and the corresponding
> >> > KVM_PPC_GET_COMPAT_CAPS vm ioctl. The ioctl returns a bitmap describing
> >> > the compatibility modes supported by the host in respective bit numbers,
> >> > allowing userspace (e.g., QEMU) to select an appropriate compatibility
> >> > level when configuring nested KVM guests.
> >> >
> >> > The ioctl handling is added in kvm_arch_vm_ioctl() and retrieves host
> >> > CPU compatibility capabilities via a PowerPC-specific backend
> >> > implementation when available.
> >> >
> >> > The struct kvm_ppc_compat_caps places the 'size' field first so it can
> >> > be read alone via get_user() before copy_struct_from_user() is called,
> >> > avoiding pointer arithmetic to locate the size field.
> >> >
> >> > The ioctl is defined using _IO so the ioctl number remains stable even if
> >> > the struct grows in future versions. It uses copy_struct_from_user() and
> >> > copy_struct_to_user() to provide forward- and backward-compatible
> >> > extensibility: older userspace passing a smaller struct to a newer kernel
> >> > gets zero-padded trailing fields, while newer userspace passing a larger
> >> > struct to an older kernel (usize > ksize) gets sizeof(struct
> >> > kvm_ppc_compat_caps) written back to host_caps.size so it can retry with the
> >> > older kernel-supported size, after which the kernel returns -E2BIG.
> >> >
> >> > KVM_PPC_COMPAT_CAPS_SIZE_VER0 is defined as a frozen integer constant
> >> > (24) marking the size of the initial struct version, used as the
> >> > minimum floor for size field validation, similar to other versioned
> >> > struct interfaces in the kernel.
> >> >
> >> > The 'flags' field is reserved for future use. The kernel rejects any
> >> > call where flags is non-zero with -EINVAL, preventing garbage values
> >> > from being baked into ABI permanently.
> >> >
> >> > The ioctl returns appropriate error codes: EINVAL for an invalid size
> >> > or non-zero reserved fields, E2BIG if new userspace provides a larger
> >> > struct than the kernel knows about (with ksize written back into
> >> > host_caps.size for the retry), EFAULT for failed copy operations, and
> >> > ENOTTY if the backend doesn't implement get_compat_caps.
> >> >
> >> > Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> >> > Tested-by: Gautam Menghani <gautam@linux.ibm.com>
> >> > Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
> >> > Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> >> > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> >> > ---
> >> > Changes in this version:
> >> >   - KVM_CAP_PPC_COMPAT_CAPS: add hv_enabled guard to align the capability
> >> >     check with ioctl availability; a PR KVM VM on pseries now correctly
> >> >     returns 0 for the capability [Sashiko]
> >> >
> >> >  arch/powerpc/include/asm/kvm_ppc.h  |  1 +
> >> >  arch/powerpc/include/uapi/asm/kvm.h |  8 ++++
> >> >  arch/powerpc/kvm/powerpc.c          | 71 +++++++++++++++++++++++++++++
> >> >  include/uapi/linux/kvm.h            |  3 ++
> >> >  4 files changed, 83 insertions(+)
> >> >
> >> > diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
> >> > index 0953f2daa466..169ea6a7fbad 100644
> >> > --- a/arch/powerpc/include/asm/kvm_ppc.h
> >> > +++ b/arch/powerpc/include/asm/kvm_ppc.h
> >> > @@ -319,6 +319,7 @@ struct kvmppc_ops {
> >> >  	bool (*hash_v3_possible)(void);
> >> >  	int (*create_vm_debugfs)(struct kvm *kvm);
> >> >  	int (*create_vcpu_debugfs)(struct kvm_vcpu *vcpu, struct dentry *debugfs_dentry);
> >> > +	int (*get_compat_caps)(struct kvm_ppc_compat_caps *host_caps);
> >> >  };
> >> >  
> >> >  extern struct kvmppc_ops *kvmppc_hv_ops;
> >> > diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
> >> > index 077c5437f521..19e53d5ae540 100644
> >> > --- a/arch/powerpc/include/uapi/asm/kvm.h
> >> > +++ b/arch/powerpc/include/uapi/asm/kvm.h
> >> > @@ -437,6 +437,14 @@ struct kvm_ppc_cpu_char {
> >> >  	__u64	behaviour_mask;		/* valid bits in behaviour */
> >> >  };
> >> >  
> >> > +/* For KVM_PPC_GET_COMPAT_CAPS */
> >> > +struct kvm_ppc_compat_caps {
> >> > +	__u64	size;			/* Size of this structure */
> >> > +	__u64	flags;			/* Reserved for future use */
> >> > +	__u64	compat_capabilities;	/* Capabilities supported by the host */
> >> > +};
> >> > +#define KVM_PPC_COMPAT_CAPS_SIZE_VER0	24 /* sizeof first published struct */
> >> > +
> >> >  /*
> >> >   * Values for character and character_mask.
> >> >   * These are identical to the values used by H_GET_CPU_CHARACTERISTICS.
> >> > diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> >> > index b6b83fe3233f..e64b3cfadd3a 100644
> >> > --- a/arch/powerpc/kvm/powerpc.c
> >> > +++ b/arch/powerpc/kvm/powerpc.c
> >> > @@ -703,6 +703,13 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
> >> >  			}
> >> >  		}
> >> >  		break;
> >> > +#if defined(CONFIG_KVM_BOOK3S_HV_POSSIBLE)
> >> > +	case KVM_CAP_PPC_COMPAT_CAPS:
> >> > +		r = 0;
> >> > +		if (hv_enabled && kvmhv_on_pseries())
> >> 
> >> I think sashiko is just complaining in the 1st patch because we have not
> >> yet wired up the kvmppc_hv_ops->get_compat_caps() yet in patch-1. I
> >> think it is expecting..
> >> 
> >> if (hv_enabled && kvmhv_on_pseries() && kvmppc_hv_ops->get_compat_caps)
> >> 
> >> But either way is fine.
> >> 
> >> 
> >> > +			r = 1;
> >> > +		break;
> >> > +#endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
> >> >  	default:
> >> >  		r = 0;
> >> >  		break;
> >> > @@ -2469,6 +2476,70 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
> >> >  		r = kvm->arch.kvm_ops->svm_off(kvm);
> >> >  		break;
> >> >  	}
> >> > +	case KVM_PPC_GET_COMPAT_CAPS: {
> >> > +		struct kvm_ppc_compat_caps host_caps = {};
> >> > +		u64 usize;
> >> > +
> >> > +		/*
> >> > +		 * Read the size field first to drive copy_struct_from_user.
> >> > +		 * size must be the first field of the struct.
> >> > +		 */
> >> > +		r = -EFAULT;
> >> > +		if (get_user(usize, (__u64 __user *)argp))
> >> > +			goto out;
> >> > +
> >> > +		/*
> >> > +		 * Enforce a minimum: reject buffers smaller than the initial
> >> > +		 * struct version (VER0). This allows old userspace compiled
> >> > +		 * against the original struct to still work on a newer kernel
> >> > +		 * that has grown the struct with appended fields.
> >> > +		 */
> >> > +		r = -EINVAL;
> >> > +		if (usize < KVM_PPC_COMPAT_CAPS_SIZE_VER0)
> >> > +			goto out;
> >> > +
> >> > +		/*
> >> > +		 * New userspace with a larger struct called an older kernel.
> >> > +		 * Write back ksize in host_caps.size so userspace knows which
> >> > +		 * older struct to retry with, then fail with -E2BIG.
> >> > +		 */
> >> > +		if (usize > sizeof(host_caps)) {
> >> > +			host_caps.size = sizeof(host_caps);
> >> > +			r = -EFAULT;
> >> > +			if (put_user(host_caps.size, (__u64 __user *)argp))
> >> > +				goto out;
> >> > +			r = -E2BIG;
> >> > +			goto out;
> >> > +		}
> >> 
> >> You anyways mentioned copy_struct_from_user() is taking care of both
> >> forward and backward compat. Then what is the point of this check?
> >> shouldn't we get rid of this complete if logic? I don't see a point of
> >> this if we are anyway using copy_struct_from_user().
> >
> > The pre-check is intentional and serves a purpose that
> > copy_struct_from_user() alone cannot provide: explicit kernel struct
> > size discovery.
> >
> > copy_struct_from_user() returns -E2BIG when usize > ksize and trailing
> > bytes are non-zero — but it gives userspace no way to know what ksize to
> > retry with. It also silently succeeds when trailing bytes are zero,
> > which means a new userspace on an old kernel would never learn the
> > kernel's struct size at all.
> >
> > This design is different by intent: when new userspace passes a larger
> > struct, we always return -E2BIG and write back sizeof(host_caps) into
> > the size field so userspace learns the exact kernel-supported size and
> > can retry with it. This explicit negotiation is verified in the ABI
> > extensibility testing in the cover letter ("Newer struct on QEMU, older
> > kernel -> works"). The explicit -E2BIG + ksize writeback makes the
> > version negotiation unambiguous.
> >
> 
> yup, my bad, should have seen the comment in the code above.

No worries...

> 
> But isn't this a bad design? Tomorrow, say we have a v2, a larger
> version of this struct and if your newer Qemu (with larger struct size)
> is running on an older kernel with a smaller struct size, then you will
> fail it because usize > ksize even though the userspace has zero filled
> the rest of the trailing bytes... 

You're right and thanks for pointing this out. A newer userspace that
zero-initialises the new fields (e.g. struct caps = {}; caps.size =
sizeof(caps);) is a valid forward-compat call — zero means "use default
for unknown fields", which is exactly the contract
copy_struct_from_user() is designed to honour. Forcing a round-trip in
that case is wrong.

I'll drop the manual usize > sizeof(host_caps) pre-check and let
copy_struct_from_user() own the usize > ksize path entirely.

One small correction to your suggested snippet though: put_user()
return value is ignored there. put_user() returns 0 on success or
-EFAULT on failure, so if the write-back fails we'd silently return
-E2BIG instead of -EFAULT. The fix is straightforward:

  diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
  index e64b3cfadd3a..ed48f069fb76 100644
  --- a/arch/powerpc/kvm/powerpc.c
  +++ b/arch/powerpc/kvm/powerpc.c
  @@ -2498,29 +2498,28 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
                  if (usize < KVM_PPC_COMPAT_CAPS_SIZE_VER0)
                          goto out;
   
  -               /*
  -                * New userspace with a larger struct called an older kernel.
  -                * Write back ksize in host_caps.size so userspace knows which
  -                * older struct to retry with, then fail with -E2BIG.
  -                */
  -               if (usize > sizeof(host_caps)) {
  -                       host_caps.size = sizeof(host_caps);
  -                       r = -EFAULT;
  -                       if (put_user(host_caps.size, (__u64 __user *)argp))
  -                               goto out;
  -                       r = -E2BIG;
  -                       goto out;
  -               }
  -
                  /*
                   * copy_struct_from_user() handles forward/backward compat:
                   *   usize == ksize: verbatim copy
                   *   usize <  ksize: zero-pad trailing (old userspace, new kernel)
  +                *   usize >  ksize: succeed iff trailing bytes are zero, else -E2BIG
                   */
                  r = copy_struct_from_user(&host_caps, sizeof(host_caps),
                                            argp, usize);
  -               if (r)
  +               if (r) {
  +                       /*
  +                        * New userspace with a larger struct called an older
  +                        * kernel. Write back ksize in host_caps.size so
  +                        * userspace knows which older struct to retry with,
  +                        * then fail with -E2BIG.
  +                        */
  +                       if (r == -E2BIG)
  +                               if (put_user((__u64)sizeof(host_caps),
  +                                            (__u64 __user *)argp))
  +                                       r = -EFAULT;
                          goto out;
  +               }
   
                  /* Reserved fields must be zero */
                  r = -EINVAL;

This preserves -EFAULT priority if put_user() fails, consistent with
how the get_user() guard earlier in the same handler works.

Will post v8 with this fix.

Thanks,
Amit

>      if (usize > sizeof(host_caps)) 
> 
> Instead wouldn't it be better if we do something like this?
> 
> 		r = copy_struct_from_user(&host_caps, sizeof(host_caps),
> 					  argp, usize);
> 		if (r) {
> 			if (r == -E2BIG)
> 				put_user(sizeof(host_caps), &argp->size);
> 			goto out;
> 		}
> 
> So, we only fail if the userspace has passed a newer struct and the
> trailing bytes, which are unknown to this older kernel, are zeroed,
> otherwise we return -E2BIG. We also write the ksize back, so the user
> knows what ksize it supports.
> 
> This would avoid an unncessary round trip and will simplify the
> userspace design, isn't it?
> 
> >> 
<snip>

