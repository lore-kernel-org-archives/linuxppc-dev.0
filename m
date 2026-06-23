Return-Path: <linuxppc-dev+bounces-22927-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B92CDB46F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2026 13:02:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gl4w772xpz2y71;
	Tue, 23 Jun 2026 23:01:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782219719;
	cv=none; b=T2+jqgNGlYF8h7Xp7yMiLioRdwM+9aKjUrR5QszBlSsvyVyuAWKFER41/O14XlQbM50WWsC71N+VwD90lmi984647xgP6g9oVemHrV+nvzlVUIJbxLk/vvzIfRzFoU1QCJOJ8sEDkOArHdQgavXGp1WFdCoMM4M+voCZYvBl1Q95bxrqaVpFJ547BT5BnrNxmo0aK9Ys0esVWGyCwBTKPoUzrVELfzMiaxX5fRdAS/87O1whbp0L0kgLb1xi60F0EzpgGlhr/KbCZ0c8lBAq3wK1selks5y1LI+lcqD0bCY2dIAvz1G2c7C2/zZLzyJkWsHJb+qxdbYMnHacm4tVQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782219719; c=relaxed/relaxed;
	bh=w6elhn4r5ihfZJdLjDIsTMREYOWlqzgcP54/V9V1lrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XI3xxT03HizJFNtb4rza1qk4a+4aE7/AFM6MItby66jfjhu1J7GPLDH4mpqXpalC0PB/Y7sGXenDPEp3mDYk1c4EcAPmB2DRd3/fJhMeCRsHNPbIEonSUugatOOVTDxNHH/EMns5NSEu1JCPLas5767cJFT1dFipZ4p1oFxDu8uzO4bQUexcnVY4xT55rrKW3LXSe/Y1fxuaTCH5xWJVQYzLvQ0qrQFbrB9tpefXrAf2MswdVK1/ZDolg1dAieiQz+ec3IPpizhOEqhlP6WU1cEU2igBXD/kRbiZDOhOH9ujim0AVtspITmfioZP4/nOOyzeGYzeFhuqxU4Dt8266Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZJYBkQxK; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZJYBkQxK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gl4w63Yjmz2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 23:01:58 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmjjE1984495;
	Tue, 23 Jun 2026 13:01:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=w6elhn4r5ihfZJdLjDIsTMREYOWlqz
	gcP54/V9V1lrM=; b=ZJYBkQxKzSsj7QQTg2Bz/jOIjMgUeZfLRlZMnXB3sbuq8W
	1cuZEIvny8Dx6Falpuxu3cXPnxuN1/50rliQOECU+JiO4a6TA+lu02pplwSgOu75
	LIbHbAGZSzR1k3VC+8gASwokybSmpH6ugoMGFynCmjgHXO8Pn1FCbZNrPQktAYiU
	AhwnE4nfq7HTHdbi+KoTprVDkkLSVET9PRVin1KxUcpule7C5dQuIWiAqzQHSHcG
	2kbkMDvE14dqODlAM55laaNylfdMCHHh5p4uJsgXrw67a+t2qfvd1gynY02anv8n
	ePDdFKdhuuWhXVJGZktnPILVNY2LKSVhPRBEWX0w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjc3em9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 13:01:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NCnjio027631;
	Tue, 23 Jun 2026 13:01:44 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6phb8hp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 13:01:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65ND1eaP49021242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 13:01:40 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8129020040;
	Tue, 23 Jun 2026 13:01:40 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8E902004B;
	Tue, 23 Jun 2026 13:01:37 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 23 Jun 2026 13:01:37 +0000 (GMT)
Date: Tue, 23 Jun 2026 18:31:41 +0530
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
Subject: Re: [PATCH v4 2/4] KVM: PPC: Book3S HV: Implement compat CPU
 capability retrieval for KVM on PowerVM
Message-ID: <20260623182912.8ad606a1-ea-amachhiw@linux.ibm.com>
Mail-Followup-To: Vaibhav Jain <vaibhav@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anushree Mathur <anushree.mathur@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, lkp@intel.com
References: <20260616123314.82721-1-amachhiw@linux.ibm.com>
 <20260616123314.82721-3-amachhiw@linux.ibm.com>
 <878q8bcbh6.fsf@vajain21.in.ibm.com>
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
In-Reply-To: <878q8bcbh6.fsf@vajain21.in.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=X4Ni7mTe c=1 sm=1 tr=0 ts=6a3a83ba cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=V7CP62GcylaPN-88zJAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEwNSBTYWx0ZWRfX61y9CJ89zjs3
 hzcIaz7u/F5MMEJmRXiPjw3JNPks0VcxHdouxrEfFd9liYhtHBkIvXf4Rw2yHvQbUB1qs8VIiRQ
 91f+YUirWShuicZxvRyo2keFjppQBhg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEwNSBTYWx0ZWRfXwAJux7A0F4tr
 5KrkhZr2P9SxU1B/A9zaXsmtyFU9al2APqFEx8S0rTt6e7oZpClgJlbdPp7HooF3IwwfqBj44tQ
 Ks3NyVWhORtoB6P//GVvROgPB/8vajkRruJrwMVkJvWtp36QnUz8XHZNI28+raYLcexxMeFKenk
 37/Xzf/FNHF6pzttxw9p8wH8aNFbIfc0CRa63DFQ1X4UAs8MfOlf8gVLXfOymer82mGaCOLA6yb
 JXDANSBoa6LDcsh04tJNipBWehFk6HHg2f1oFuTZQKQzI74y4xD6Q/WWgqwUz+BWLnbZbsqf9kM
 3Brfit6dzoB8q25xTQgnkmNvzGVCd/v3mN4M9LIISTdAw4mVQKLbcrnc3b+EpiKMbGP7ONe5PEr
 6B0tZq3zxPaeKvmfVtZvuLZfqT5I7STd98igjG7iHl39OYTAgKYpE4bCG8f0sWwf2joUCemLSyg
 6tMZRJrMLg6Tcm4QSqQ==
X-Proofpoint-ORIG-GUID: WmihYSYPCIc3Akfxpd39k7jb76VZLIjM
X-Proofpoint-GUID: LFf3dELWknKTgufp5u4x4zQO6vhPnemw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230105

Hi Vaibhav,

Thanks for revewing this patch. My response is inline.

On 2026/06/19 11:34 AM, Vaibhav Jain wrote:
> Hi Amit.
> 
> Thanks for the patch and incorporating V3 review comments. Further
> review comments inline below:
> 
> Amit Machhiwal <amachhiw@linux.ibm.com> writes:
> 
> > On POWER systems, the host CPU may run in a compatibility mode (e.g., a
> > Power11 processor operating in Power10 compatibility mode). In such
> > cases, the effective CPU level exposed to guests differs from the
> > physical processor generation.
> >
> > When running nested KVM guests, QEMU derives the host CPU type using
> > mfpvr(), which reflects the physical processor version. This can result
> > in a mismatch between the CPU model selected by QEMU and the
> > compatibility mode enforced by the host, leading to guest boot failures.
> >
> > For example, booting a nested guest on a Power11 LPAR configured in
> > Power10 compatibility mode fails with:
> >
> >   KVM-NESTEDv2: couldn't set guest wide elements
> >   [..KVM reg dump..]
> >
> > This occurs because QEMU selects a CPU model corresponding to the
> > physical processor (via mfpvr()), while the host operates in a lower
> > compatibility mode. As a result, KVM rejects the requested compatibility
> > level during guest initialization.
> >
> > Add support for retrieving host CPU compatibility capabilities for
> > nested guests on PowerVM (PAPR nested API v2). The hypervisor provides
> > the effective compatibility levels via the H_GUEST_GET_CAPABILITIES
> > hcall, which reflects the processor modes negotiated between the Power
> > hypervisor (L0) and the host partition (L1).
> >
> > On pseries systems, obtain the capability bitmap using
> > plpar_guest_get_capabilities() and return it via struct
> > kvm_ppc_compat_caps. The implementation defines KVM-specific capability
> > constants (KVM_PPC_COMPAT_CAP_POWER9/10/11) and applies masking to ensure
> > only supported processor modes are exposed to userspace. This information
> > is then exposed through the KVM_PPC_GET_COMPAT_CAPS ioctl.
> >
> > Hook the implementation into the Book3S HV kvmppc_ops so that it can be
> > invoked by the generic KVM ioctl handling code.
> >
> > Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > ---
> >  arch/powerpc/include/uapi/asm/kvm.h | 11 ++++++++++-
> >  arch/powerpc/kvm/book3s_hv.c        | 17 +++++++++++++++++
> >  2 files changed, 27 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
> > index 8a38be6c3b03..730488681443 100644
> > --- a/arch/powerpc/include/uapi/asm/kvm.h
> > +++ b/arch/powerpc/include/uapi/asm/kvm.h
> > @@ -443,7 +443,16 @@ struct kvm_ppc_compat_caps {
> >  	__u64	size;			/* Size of this structure */
> >  	__u64	compat_capabilities;	/* Capabilities supported by the host */
> >  };
> > -
> > +/*
> > + * Capability bits for compat_capabilities field in kvm_ppc_compat_caps.
> > + * These bits indicate which processor compatibility modes are supported.
> > + */
> > +#define KVM_PPC_COMPAT_CAP_POWER9	(1ULL << 62)
> > +#define KVM_PPC_COMPAT_CAP_POWER10	(1ULL << 61)
> > +#define KVM_PPC_COMPAT_CAP_POWER11	(1ULL << 60)
> > +#define KVM_PPC_COMPAT_BITMASK		(KVM_PPC_COMPAT_CAP_POWER9 | \
> > +					 KVM_PPC_COMPAT_CAP_POWER10 | \
> > +					 KVM_PPC_COMPAT_CAP_POWER11)
> >  /*
> >   * Values for character and character_mask.
> >   * These are identical to the values used by H_GET_CPU_CHARACTERISTICS.
> > diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> > index f9380ef65750..f674386df62c 100644
> > --- a/arch/powerpc/kvm/book3s_hv.c
> > +++ b/arch/powerpc/kvm/book3s_hv.c
> > @@ -6523,6 +6523,22 @@ static bool kvmppc_hash_v3_possible(void)
> >  	return true;
> >  }
> >  
> > +
> > +static int kvmppc_get_compat_caps(struct kvm_ppc_compat_caps *host_caps)
> > +{
> > +	unsigned long capabilities = 0;
> > +	long rc = -EINVAL;
> > +
> > +	if (kvmhv_on_pseries()) {
> > +		if (kvmhv_is_nestedv2())
> > +			rc = plpar_guest_get_capabilities(0,
> > &capabilities);
> I think instead of making the hcall you should use the
> 'nested_capabilities' extern symbol as it would already the same
> value. This symbol is already accessible in 'book3s_hv.c'

Agreed! Will change to use nested_capabilities directly instead of
making the hcall. This is more efficient as this will help reduce an
hcall overhead while the value is already cached during module
initialization (in kvmhv_nested_init()).

Thanks,
Amit

> 
> > +		host_caps->compat_capabilities = capabilities &
> > +							KVM_PPC_COMPAT_BITMASK;
> > +	}
> > +
> > +	return rc;
> > +}
> > +
> >  static struct kvmppc_ops kvm_ops_hv = {
> >  	.get_sregs = kvm_arch_vcpu_ioctl_get_sregs_hv,
> >  	.set_sregs = kvm_arch_vcpu_ioctl_set_sregs_hv,
> > @@ -6565,6 +6581,7 @@ static struct kvmppc_ops kvm_ops_hv = {
> >  	.hash_v3_possible = kvmppc_hash_v3_possible,
> >  	.create_vcpu_debugfs = kvmppc_arch_create_vcpu_debugfs_hv,
> >  	.create_vm_debugfs = kvmppc_arch_create_vm_debugfs_hv,
> > +	.get_compat_caps = kvmppc_get_compat_caps,
> >  };
> >  
> >  static int kvm_init_subcore_bitmap(void)
> > -- 
> > 2.50.1 (Apple Git-155)
> >
> >
> 
> -- 
> Cheers
> ~ Vaibhav

