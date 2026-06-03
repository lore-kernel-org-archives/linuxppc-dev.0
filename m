Return-Path: <linuxppc-dev+bounces-21939-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39108CD6E55
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 04:01:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVYsw4TQsz2yRF;
	Wed, 03 Jun 2026 14:01:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780459300;
	cv=none; b=SyEPmST/ZE4KNcMvnvLx8hTvmbMxydf986OaT6GKYq/5pO4XbVCWa3k0VyI1AwknRTfEiGt6sXYRUGrAt5K8KboHy4YKN5IrSXDsAGmkmjigTiIwWIzkxUyzzWr7NT495HbVtvq1gvbP9EtqbBX6v4RL2zSC4q6EbEXSkhnh6RbbRQDNwguxbWsKUeaZ+10UbKFtV0ugz+4JLDoA/1KZAsbYiu+Q3db8JAAGpur6DfKWQIBuxMblYtk41i8ca/gpvvatbx1pXoiHGdA15wxIaFJqb9NkD+uO4OL4tyDBI1KNZUAfMUo2b3mEDdK0pwYX6bQB9/zz5Pu+X3HDnxxYzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780459300; c=relaxed/relaxed;
	bh=UPBlMP9hQEtINQ3vjaQwZNSbl/u+4iwIMssXJtWi0DU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L8ZNHJp4B++fyqs35RqyP3VmooLfIA8rm3yBbzLxoGb2cYr0rSkd1K/2wIZcEsiNrO3CD17XqD264Mq1Q32Y4F2N+nAV6oSEDgz9n9vD+cmoepBdfhjzuenA4EcHT3foeAMTZkCAgb3mAGKljLa2v7ei/PhGSygVV2NeOGgmJ+wAZQHqVyRxOZhTQOZuC3zFQfteeG0GrPO8JyBjzg1swYFilXVAHOsELdENQ6hFCgDR0vRPjtHePmu+XI6Actzh0Qr8lCOmUyRavj+kP9VTDKmI1W0xc4KfRhFDSgBKSAi4v7YWYSRC04j4/tuAt3mzLSoZGcLaPjB/z3lc3f6F2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bClDwcfz; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bClDwcfz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVYsv6X0jz2xg3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 14:01:39 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652H1gRr745528;
	Wed, 3 Jun 2026 04:01:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=UPBlMP9hQEtINQ3vjaQwZNSbl/u+4i
	wIMssXJtWi0DU=; b=bClDwcfzAkJkeiOqMXmCc5PEFXE3I3xdsFBSdsPHlkjdWM
	f8n8F61wyD/4pVb91e9oWgsIrOA16Y0hwCwFXvcaSxTlszDYP8WLndUBK725r4Eg
	nkkbb0DHdZzxA2PJ+Bar8ossMjmIhaXyRYJr5MjYGTxTUYYkSEYtC+kDhJEDRiJp
	6RWLSwgSgkKwfJGYYzBGZnMKG9Kd/TQs9FkDG81ZRYSwJ1x9FA3IztBkzfR1IZD6
	Sgj4piEG8BXPSuu3iU+aAh7l61UIjpI17ODQy+/aB8f/h11o1G9WP4JTBeoN5TRj
	CvXT5SFRaz4ldF4A9tMBtq/dHfisNfu+PtIjsYdQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqm511e0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 04:01:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6533sPMK016895;
	Wed, 3 Jun 2026 04:01:28 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcwye4af-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 04:01:28 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65341RqS23134820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 04:01:27 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B420D5805D;
	Wed,  3 Jun 2026 04:01:27 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6863458059;
	Wed,  3 Jun 2026 04:01:21 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.39.22.158])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with SMTP;
	Wed,  3 Jun 2026 04:01:21 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Wed, 03 Jun 2026 09:31:19 +0530
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
Subject: Re: [PATCH v3 3/5] KVM: PPC: Book3S HV: Implement compat CPU
 capability retrieval for KVM on PowerVM
In-Reply-To: <20260522152744.55251-4-amachhiw@linux.ibm.com>
References: <20260522152744.55251-1-amachhiw@linux.ibm.com>
 <20260522152744.55251-4-amachhiw@linux.ibm.com>
Date: Wed, 03 Jun 2026 09:31:19 +0530
Message-ID: <87mrxcz300.fsf@vajain21.in.ibm.com>
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
X-Proofpoint-GUID: d_p16zOZ3eFJgsKSfmna2KTU7Q69yGcY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDAzMCBTYWx0ZWRfXw0zaWrN9xnpy
 FNex/jb6cboGbMHLkgxY9iiNtcDWtwBP25OIpf1tjV5Cl8D0/BiZPGpXNcN+cewkaFYOaZFG+zh
 wPS8hxJbfZpCCul+zdUMdsR9r50hhWDtdRVbY63rhfT9bpkUTuZSPv6besGXaKqX3LJoSUMsQi3
 kGJt5F8watoAUE56wF/RPzl1maoDsL3YwhcB03+4dXAZEmAE3JG6jwM5rnXZdJD1VSzHPNb5uqv
 dIZyKP2k2Pwc2WcqTJS1YQ5Ry/V0e3womX/yY7mV0z2iHktrK01mDVQLPm4dEKbXed3oKwB6pGk
 oFUC5FMGBg/H2LthEsUBz7P2c06uGBGmoCR6rUPdJNcec0MM6Bo3dAVMajyLZc46uImcm4t0ur5
 EGD8i8eHSM4n0wdWfMC0AgIvba3uCSyL5idVX4UbElki1r5qeeTixS/QB1A7xgYrGPb7qKmqP1H
 YJykl85K4cxfr0ZNPDQ==
X-Proofpoint-ORIG-GUID: n4h1H4qTTZIoz8vfQV7U_81VzjOris2V
X-Authority-Analysis: v=2.4 cv=Vf3H+lp9 c=1 sm=1 tr=0 ts=6a1fa71a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=3xnOzpcvsEFGoBSC2dMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030030

Hi Amit,

Thanks for the patch. My review comments inline below:

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> On POWER systems, the host CPU may run in a compatibility mode (e.g., a
> Power11 processor operating in Power10 compatibility mode). In such
> cases, the effective CPU level exposed to guests differs from the
> physical processor generation.
>
> When running nested KVM guests, QEMU derives the host CPU type using
> mfpvr(), which reflects the physical processor version. This can result
> in a mismatch between the CPU model selected by QEMU and the
> compatibility mode enforced by the host, leading to guest boot failures.
>
> For example, booting a nested guest on a Power11 LPAR configured in
> Power10 compatibility mode fails with:
>
>   KVM-NESTEDv2: couldn't set guest wide elements
>   [..KVM reg dump..]
>
> This occurs because QEMU selects a CPU model corresponding to the
> physical processor (via mfpvr()), while the host operates in a lower
> compatibility mode. As a result, KVM rejects the requested compatibility
> level during guest initialization.
>
> Add support for retrieving host CPU compatibility capabilities for
> nested guests on PowerVM (PAPR nested API v2). The hypervisor provides
> the effective compatibility levels via the H_GUEST_GET_CAPABILITIES
> hcall, which reflects the processor modes negotiated between the Power
> hypervisor (L0) and the host partition (L1).
>
> On pseries systems, obtain the capability bitmap using
> plpar_guest_get_capabilities() and return it via struct
> kvm_ppc_compat_caps. This information is then exposed to userspace
> through the KVM_PPC_GET_COMPAT_CAPS ioctl.
>
> Hook the implementation into the Book3S HV kvmppc_ops so that it can be
> invoked by the generic KVM ioctl handling code.
>
> Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>  arch/powerpc/kvm/book3s_hv.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 249d1f2e4e2c..38de7040e2b7 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -6522,6 +6522,21 @@ static bool kvmppc_hash_v3_possible(void)
>  	return true;
>  }
>  
> +
> +static int kvmppc_get_compat_cpu_caps(struct kvm_ppc_compat_caps *host_caps)
> +{
> +	unsigned long capabilities = 0;
> +	long rc = -EINVAL;
> +
> +	if (kvmhv_on_pseries()) {
> +		if (kvmhv_is_nestedv2())
> +			rc = plpar_guest_get_capabilities(0,
> &capabilities);

since this value will trikle back to userspace please apply a mask on
the hcall return value so that any reserved and non-PVR related bits
doesnt leak back to userspace.

> +		host_caps->compat_capabilities = capabilities;
> +	}
> +
> +	return rc;
> +}
> +
>  static struct kvmppc_ops kvm_ops_hv = {
>  	.get_sregs = kvm_arch_vcpu_ioctl_get_sregs_hv,
>  	.set_sregs = kvm_arch_vcpu_ioctl_set_sregs_hv,
> @@ -6564,6 +6579,7 @@ static struct kvmppc_ops kvm_ops_hv = {
>  	.hash_v3_possible = kvmppc_hash_v3_possible,
>  	.create_vcpu_debugfs = kvmppc_arch_create_vcpu_debugfs_hv,
>  	.create_vm_debugfs = kvmppc_arch_create_vm_debugfs_hv,
> +	.get_compat_cpu_ver = kvmppc_get_compat_cpu_caps,
>  };
>  
>  static int kvm_init_subcore_bitmap(void)
> -- 
> 2.50.1 (Apple Git-155)
>
>

-- 
Cheers
~ Vaibhav

