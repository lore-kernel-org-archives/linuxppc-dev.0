Return-Path: <linuxppc-dev+bounces-20568-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBACECD343B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 May 2026 14:19:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gBDrj2xSMz2xQC;
	Fri, 08 May 2026 00:19:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778163541;
	cv=none; b=WLapmsakh8TB8zpInJDwNKPkBcz3DKLaxH/PUhgtYNSWrPtIbMPa9isgOkYNHlE4MVAHi/0rmjwDLe76Oxglp7O/SNy5QyZNDjBF7vTH0JTxCqJpxsVeGwKMPjciN9vMDWN0mgsCbkS4IPStUO9ruNams6UuYgupxaGl5iaJB1Ix9MFW6w2PIxY0HdRVBXBkh+rYKfwhrpD4XvzPJsh71DsRwq2cOd/FINhPgQKWcTnTDXU6kVxKQGU9544qiijgWBBeLbCvULHa4IT3HII4+n3PI9c6jncmoiQpwYUm1Q6hkMS3etB51PoL+u+MScOHkJ7giuf8X42vm4FKSlE9zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778163541; c=relaxed/relaxed;
	bh=8iiB9jyMp4thVCVeuZnS8ulX0xF6Dn3WdDjdxZHg26s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQJ30Iw3rSI/Vm4If2w3q7N3r8lWg1npjCD9h7f9Dv62WfKOba6NeSq2cjqYRZs52febTacbZBnbg+Wmm38aC531Sum3Rv3TRxgC1t0mqlHOn6S7e4ibpQFIgHMFnar1VtD3eeSv78m/x9TXfjh7K/v0U7v8C7c3/DMwVYJjWqXs9h6OXyz9y+xWFkc2yLqj/fKSEgecwbii/tgPM+2mskegFANW0Vbcj5Ieg5R6AXo6282Ol3t/RhdScpmgh2tfD1ZXAwPaihRndn7dFQsY734ka+ubcBNy6F+RAvBjguksFVqxpTf5vciGELsXKA/bEwp5k/rgIIAALgTbMjhNVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YrogDzf5; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YrogDzf5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gBDrh2XJGz2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 May 2026 00:18:59 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6476Xw5J347004;
	Thu, 7 May 2026 14:18:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=8iiB9jyMp4thVCVeuZnS8ulX0xF6Dn
	3WdDjdxZHg26s=; b=YrogDzf5g5/fsPMW90eiBu1D4F2r/Ora+FqUg9azwsi+M1
	Utu7ZwOB/awe3qD+fmNG0dF4EAVEnpCxuIQDqMaaDBBt0k/U2pSjFhDBNTJ8Peg3
	LkXjWv0GGUgGX1OZwJp2lfOTaoYugRdq8gk5jx1VVA6EfrRvn0EnF2YcWpkf8oNy
	BIP63INFTjtThf/YzL8JiKBtKqW28AVAhCsrK2GYlQDy/H2n+O6cDDz3Y8mxuN9u
	0Z+Y6aneRysA3eQXvtGg1CDYQN4Ycp4YhNLUBc1ZM8jUdjCnfil2hJ1iG+Ewt652
	6fSfiIUXGxi4m/fr4mFI2Fl+A+qb9e70099rLMbg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x4xxbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 14:18:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 647E9gSK013501;
	Thu, 7 May 2026 14:18:49 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtgksbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 14:18:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 647EIjaD43319756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 May 2026 14:18:45 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B8F220040;
	Thu,  7 May 2026 14:18:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D96E52004D;
	Thu,  7 May 2026 14:18:41 +0000 (GMT)
Received: from Amits-MacBook-Pro.local (unknown [9.124.211.112])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  7 May 2026 14:18:41 +0000 (GMT)
Date: Thu, 7 May 2026 19:48:38 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] KVM: PPC: Wire up KVM_PPC_GET_COMPAT_CAPS ioctl
Message-ID: <20260507193102.d5336129-b0-amachhiw@linux.ibm.com>
Mail-Followup-To: Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Vaibhav Jain <vaibhav@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260430054906.94431-1-amachhiw@linux.ibm.com>
 <20260430054906.94431-4-amachhiw@linux.ibm.com>
 <1d2e6647-1fbf-48bf-8bb9-f4f3fb80677b@linux.ibm.com>
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
In-Reply-To: <1d2e6647-1fbf-48bf-8bb9-f4f3fb80677b@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE0MSBTYWx0ZWRfXz76wir/TBxQg
 zzAjm8hdjwlRJCfBMI7SIPdsGGCP2UMHHtKddhd7Qn++qKhkEYMP9EK+hQwcdLSQIxCT4XpsxKU
 qgFHs1ReJTBNKB+omyemQZnnnuJYmSwafBT1OXXo2WkfGOR7ymwwlEmhW67dNMA2ULikoiIgq5m
 RMYK4vacaJqktKKxJMGUTEg5oCDTYHnJ1Y4odi8gMDoiG9sM49IY44GVR/fIqKYtE6HND+Wc8K6
 FLO+M6gT53qer06wF1o6F1K/0Yi4l9LKIhxFhnzMy5nnESeGIUS6liRzE1anvuE/TqAycYSWHu6
 4UZvDohqRUFN77eGpV5f7GVMTX1/dGSf5XJRxIU6i/HyCUka0DbTU6j4CXti7jDbqM8WZ7S1aHt
 YEvaoQScKzSLLZR7wCE+fDZhc5nNy89HOBLtBLhHxp/rYKEbGYbhOwJccEpKIlVQKSTUfeVrU1z
 BtofZou0fFuIqoGJH/A==
X-Proofpoint-ORIG-GUID: 5sa-RygdWmAX1aVaw2NITpkDrodHStFT
X-Proofpoint-GUID: 9odj-MsVoUrnpWdkjhj3vhNJ0nmCQ9pk
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69fc9f4a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=ZkftaYFX4FKCwpE1Cl0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070141

On 2026/05/05 02:16 PM, Harsh Prateek Bora wrote:
> 
> 
> On 30/04/26 11:19 am, Amit Machhiwal wrote:
> > Add handling for KVM_PPC_GET_COMPAT_CAPS in kvm_arch_vm_ioctl() and
> > advertise support via KVM_CAP_PPC_COMPAT_CAPS.
> > 
> > The ioctl retrieves host CPU compatibility capabilities via a
> > PowerPC-specific backend implementation when available. If the
> > capability is not supported, the ioctl returns success with no
> > capabilities set, allowing userspace to fall back gracefully.
> > 
> > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > ---
> >   arch/powerpc/include/asm/kvm_ppc.h |  1 +
> >   arch/powerpc/kvm/powerpc.c         | 19 +++++++++++++++++++
> >   2 files changed, 20 insertions(+)
> > 
> > diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
> > index 0953f2daa466..cadfb839e836 100644
> > --- a/arch/powerpc/include/asm/kvm_ppc.h
> > +++ b/arch/powerpc/include/asm/kvm_ppc.h
> > @@ -319,6 +319,7 @@ struct kvmppc_ops {
> >   	bool (*hash_v3_possible)(void);
> >   	int (*create_vm_debugfs)(struct kvm *kvm);
> >   	int (*create_vcpu_debugfs)(struct kvm_vcpu *vcpu, struct dentry *debugfs_dentry);
> > +	int (*get_compat_cpu_ver)(struct kvm_ppc_compat_caps *host_caps);
> >   };
> >   extern struct kvmppc_ops *kvmppc_hv_ops;
> > diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> > index 00302399fc37..f35017d83d77 100644
> > --- a/arch/powerpc/kvm/powerpc.c
> > +++ b/arch/powerpc/kvm/powerpc.c
> > @@ -697,6 +697,12 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
> >   			}
> >   		}
> >   		break;
> > +#if defined(CONFIG_KVM_BOOK3S_HV_POSSIBLE)
> > +	case KVM_CAP_PPC_COMPAT_CAPS:
> > +		if (kvmhv_on_pseries())
> 
> What about PowerNV ?

I'm not sure if understand the question completely. The goal is to handle the
compatibility mode for a nested guest, i.e., an L2 KVM guest booted inside a
pSeries KVM L1 booted on a PowerNV host with HV compatibilities and as well as
on a Logical Parition booted on PowerVM, hence the check. Does that answer your
question?

> Also, can't we just check if get_compat_cpu_ver is initialized and return
> accordingly ?
> 
> > +			r = 1;
> > +		break;
> > +#endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
> >   	default:
> >   		r = 0;
> >   		break;
> > @@ -2463,6 +2469,19 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
> >   		r = kvm->arch.kvm_ops->svm_off(kvm);
> >   		break;
> >   	}
> > +	case KVM_PPC_GET_COMPAT_CAPS: {
> > +		struct kvm_ppc_compat_caps host_caps;
> > +
> > +		memset(&host_caps, 0, sizeof(host_caps));
> > +		if (!kvm->arch.kvm_ops->get_compat_cpu_ver)
> > +			goto out;
> 
> I guess we want to init r = 0 before returning in this case.

Sure, will do in the next version.

> Also prefer break over goto unless really needed.

I used goto out; to stay consistent with the existing exit paths in this
function, where similar branches go through the same out label. I do not have a
strong preference either way. Please let me know your views.

Thanks,
Amit

> 
> > +
> > +		r = kvm->arch.kvm_ops->get_compat_cpu_ver(&host_caps);
> > +		if (!r && copy_to_user(argp, &host_caps,
> > +				     sizeof(host_caps)))
> > +			r = -EFAULT;
> > +		break;
> > +	}
> >   	default: {
> >   		struct kvm *kvm = filp->private_data;
> >   		r = kvm->arch.kvm_ops->arch_vm_ioctl(filp, ioctl, arg);
> 

