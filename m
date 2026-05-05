Return-Path: <linuxppc-dev+bounces-20446-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E115CD3430
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 08:46:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8sYj5PTgz2xMV;
	Tue, 05 May 2026 18:46:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777970777;
	cv=none; b=V+5u7u6Iv/gmKNLvXEnpfXaMDP6FHmEWjXSS2TZanqOT6xzit3RDl1qCCxb1s6CHFNz4aZqBVkpA9wxWHCnVI8yP7/G7TP4OkhNOsfx85+2lCuQgC7VVWFTUW2SywUFr2Eo0s5kDl8zpBtQyzUmAOdKNmneqUouRTfc7t9UUmdKqjDLFxrH1Sx74Dc0YkvFbJHEdJFGiwNdqru3MfBlM7BNKXgMvIvTpmaygsl6SMmGlVuOwtPac+oNxs0nPfSHk65qBfb7tn6PWGljstu2uy4v/uRaliRdcrgZ2zEaLEzBOuOjhfLHCFqxavcmzf+PSGRfrtvOX6poPKIzGFa1ntw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777970777; c=relaxed/relaxed;
	bh=d0Mn/ftRuCckYwuZNppZ5KkQr4Jo+z8dgPiIWJT8JOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eeDVsg4vBH1pSIUJPekKpNbXvwANmrqPPJ72cHO6o9tPKXcvtVHK7jyLaLdheuHsBpHpK2AItS4D4/gJN/L18GIHq61RxKUQojCWt4NvidmqhR60w+Wq9hrd7gRK/KWZwXDSrm/pRgFT1kSdDV7fXrLZN3AofPBeMU6cCkDu6pZ22p1JHY40fTpmo5B8yM5rNdlwg5rGr4afqUMM92tDj73wEemde1bSQKnVqln6Lvb+K4xDv1t3gdWZMvAQ5CbV++aKQJb4+gbz79H2WROp9JIGrhPkgbt1DVcGNPf3GbYvpWwjLD8mJK8wdD7KT2g8aL5rMgwhUChrNy16WwkXZg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=svabLHPe; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=svabLHPe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8sYh6l5Dz2xGc
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 18:46:16 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644M0YPG1421455;
	Tue, 5 May 2026 08:46:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=d0Mn/f
	tRuCckYwuZNppZ5KkQr4Jo+z8dgPiIWJT8JOU=; b=svabLHPel4laSrFGEb3f6g
	kb6wUDTyCBCnmvlcEdwYemHlqPJ6HX+G7G+mIwalPdyCVwkBU34ej3U0/2ZGjIdC
	Ih22auTeH3QIAmgTlWDfcBMjdACkIOODewBtszV0M4b+DlilX4ITPcK/k4EJeJNW
	e+xIn1t1FsZF4jzu1MQa+SFifrWqiTK93YO4UXBP+WQvs1Y9Xt2qhX1LhZzJuEv5
	qWFMhxMpbS1HpGuXZDVfqS0+SxzeIHK1VQQFzc8dKhmwzbdTPI4Hbw3yaFkMzWpi
	/q+ax+ej4ey2XalkTtGzSKLEdCHUPnhVDC22v2GZARZGRBp7F90c2dDuIHMEUJ6A
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x4jq3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 08:46:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6458dPxG030497;
	Tue, 5 May 2026 08:46:06 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuyw0vue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 08:46:06 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6458k5Eq19792606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 May 2026 08:46:05 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 160E45805F;
	Tue,  5 May 2026 08:46:05 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4FF55805C;
	Tue,  5 May 2026 08:46:01 +0000 (GMT)
Received: from [9.123.0.169] (unknown [9.123.0.169])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 May 2026 08:46:01 +0000 (GMT)
Message-ID: <1d2e6647-1fbf-48bf-8bb9-f4f3fb80677b@linux.ibm.com>
Date: Tue, 5 May 2026 14:16:00 +0530
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] KVM: PPC: Wire up KVM_PPC_GET_COMPAT_CAPS ioctl
Content-Language: en-GB
To: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>, Nicholas Piggin
 <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260430054906.94431-1-amachhiw@linux.ibm.com>
 <20260430054906.94431-4-amachhiw@linux.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260430054906.94431-4-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA3OSBTYWx0ZWRfXyIIAKcMcHM31
 yOA77LpWYhlTDr5XnBu9R9JHYCF4cZcM91qFEs2NxLyfu8szTmhBN+Z0C8xWTQRYVqQqOkJDF0i
 Gmj1yZCbagsY04cPeEZKR+tY1SMIqiAmru90OyBBpLvSxgELnbz5T7/QCClCGjjBhOmhcbZApRr
 VDLFjaJjPnDgm8T/xY6ONKESPr1iL1Q2gRVzPpiKl4NkjaBsFn6JC1dGdovQAi4GDYBUMz5E9Pg
 VmgFV+LwUkebBWwrG1dYRnSxZS+/HfYsm/21i6LYGMi8GyYyVdj92jO8cC+XP5ikK8dWvVBYz2/
 tDXtcXqyhh5KwZzG6hWyz98RsgUbTglJqs8so4X/NNqaoI9rFZY9pkOKvtBKEJTBY4R+xMUmS3d
 2HAK+ose1tt67AY8sMRofZ/00ONvO6dwPy2C/RpF91sXkVwDqLYasP0noP25wEtu3NdZjTERzyq
 x5Smfd/rwGNs2Xag5DA==
X-Proofpoint-ORIG-GUID: Spvpu8iu38YI7hYrSdQ9I39b-QiSMeYN
X-Proofpoint-GUID: 4mKBTlhkNxUy_eaOI0Cvv9ziFNQUNIqX
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69f9ae4f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22
 a=VnNF1IyMAAAA:8 a=sPJX90SquX2_Vg3AoWIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050079



On 30/04/26 11:19 am, Amit Machhiwal wrote:
> Add handling for KVM_PPC_GET_COMPAT_CAPS in kvm_arch_vm_ioctl() and
> advertise support via KVM_CAP_PPC_COMPAT_CAPS.
> 
> The ioctl retrieves host CPU compatibility capabilities via a
> PowerPC-specific backend implementation when available. If the
> capability is not supported, the ioctl returns success with no
> capabilities set, allowing userspace to fall back gracefully.
> 
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>   arch/powerpc/include/asm/kvm_ppc.h |  1 +
>   arch/powerpc/kvm/powerpc.c         | 19 +++++++++++++++++++
>   2 files changed, 20 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
> index 0953f2daa466..cadfb839e836 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -319,6 +319,7 @@ struct kvmppc_ops {
>   	bool (*hash_v3_possible)(void);
>   	int (*create_vm_debugfs)(struct kvm *kvm);
>   	int (*create_vcpu_debugfs)(struct kvm_vcpu *vcpu, struct dentry *debugfs_dentry);
> +	int (*get_compat_cpu_ver)(struct kvm_ppc_compat_caps *host_caps);
>   };
>   
>   extern struct kvmppc_ops *kvmppc_hv_ops;
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 00302399fc37..f35017d83d77 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -697,6 +697,12 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>   			}
>   		}
>   		break;
> +#if defined(CONFIG_KVM_BOOK3S_HV_POSSIBLE)
> +	case KVM_CAP_PPC_COMPAT_CAPS:
> +		if (kvmhv_on_pseries())

What about PowerNV ?
Also, can't we just check if get_compat_cpu_ver is initialized and 
return accordingly ?

> +			r = 1;
> +		break;
> +#endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
>   	default:
>   		r = 0;
>   		break;
> @@ -2463,6 +2469,19 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
>   		r = kvm->arch.kvm_ops->svm_off(kvm);
>   		break;
>   	}
> +	case KVM_PPC_GET_COMPAT_CAPS: {
> +		struct kvm_ppc_compat_caps host_caps;
> +
> +		memset(&host_caps, 0, sizeof(host_caps));
> +		if (!kvm->arch.kvm_ops->get_compat_cpu_ver)
> +			goto out;

I guess we want to init r = 0 before returning in this case.
Also prefer break over goto unless really needed.

> +
> +		r = kvm->arch.kvm_ops->get_compat_cpu_ver(&host_caps);
> +		if (!r && copy_to_user(argp, &host_caps,
> +				     sizeof(host_caps)))
> +			r = -EFAULT;
> +		break;
> +	}
>   	default: {
>   		struct kvm *kvm = filp->private_data;
>   		r = kvm->arch.kvm_ops->arch_vm_ioctl(filp, ioctl, arg);


