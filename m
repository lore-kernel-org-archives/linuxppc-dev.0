Return-Path: <linuxppc-dev+bounces-21940-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44AA5CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 04:17:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVZDZ5Zmwz2yRF;
	Wed, 03 Jun 2026 14:17:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780460270;
	cv=none; b=hiFuiH9gK2z+Y9nu5F02bK3ks4uwwIEKGN/S9xjVe16XPl8TklYl/akYvnKXYZd1Zike9CUfDAuTY3J6AABTPp+zW1/P8wFmUX0t/04xi8cXXLCJypiGt6w5R2NRE1FhVRM9jB30AWL8s8o9jowKCQuVs2MhHrlrHjKbF8pE2Iz5vJUGsQWhgFs32QftOzuhXvoSOa9MZvFBfqzy5nl8BIz71/B6KI1iWemR6KvdSKDQZ4M21aLKI4J+gp/dTXxBbJfe9yLDVIy45K4FM4HKc11jw2uULVVqkQdyJ9wYgU7zKbYBDyekTSGvH/cbz4PpfnEzZPuzGJxWwNpijKvsWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780460270; c=relaxed/relaxed;
	bh=F/F78NEv08EoKp0VIyvNTtQciFWlhYcXnKYix/etr3Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b/DM7m3HxTmJ06rF7373p/a0htdJXPunRarXwF/pg9p6ceyxiNXCGrpbfZN7Qxxnm4zFagiopCEJoPyyC4ct+DtPqJ/ab1c8ZF1gT8JvJtJDOiyIrqApMNp8CG/sNyVVsnSqYaDEqNItcUt2k8r5ijBF28naQiR7yuIOlGZo0V1Ipz4tB5UUjcHDHm52FK+kaPj15RFd8TiGmOjk2/jK6dN4qql1dJKpHGXl7hBd6DkJPZ2GktO4MnPAPWPVFLtc/H+HsC7n1Nq07hI2QBwv6gzHRoy4GKpfnzPy8HFq/PUM/aZjdJxG5zVxwVANde+ajuzZnPdbDYi498bXhPYReA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fEultLRE; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fEultLRE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVZDY7059z2xg3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 14:17:49 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652J23gW2223981;
	Wed, 3 Jun 2026 04:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=F/F78NEv08EoKp0VIyvNTtQciFWlhY
	cXnKYix/etr3Y=; b=fEultLRENtP+ONvsixqkN0ImF/h3c0AC2A/CdZOR2Zl7o4
	dQhYWadkQ/nxbJ8OaJQ5N9PUD0PvG3Jk7o5iIhGO07NN7e2DRdzzHGJ24uWthy/o
	Iks0sDnOgGzMRRFPRaTTCwjbUMb51vNeTeK2FcAYn51yjB5OX6UHIfD0MEdJjWK4
	1e/XWHGTy7Fmztobct23PSW7BG8G3vuZ7sfoFBmSqYVMKRk6i/pGS1a2AcKX+PIY
	AW0TdBfJJQs/OhypnH5R38Gp7rIz/TwZxJq0M7Xq3criNfEzdp8XOmIG7OdiMxK6
	SrbFKdocrHmhGZ2FPNA0b8Y29nYME0oj+AgYNloQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd49682-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 04:17:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6533sNRI016884;
	Wed, 3 Jun 2026 04:17:38 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcwye6ae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 04:17:38 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6534HbIc24642104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 04:17:37 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E5B35803F;
	Wed,  3 Jun 2026 04:17:37 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B569D58054;
	Wed,  3 Jun 2026 04:17:30 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.39.22.158])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with SMTP;
	Wed,  3 Jun 2026 04:17:30 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Wed, 03 Jun 2026 09:47:29 +0530
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
Subject: Re: [PATCH v3 4/5] KVM: PPC: Book3S HV: Add support for compat CPU
 capabilities for KVM on PowerNV
In-Reply-To: <20260522152744.55251-5-amachhiw@linux.ibm.com>
References: <20260522152744.55251-1-amachhiw@linux.ibm.com>
 <20260522152744.55251-5-amachhiw@linux.ibm.com>
Date: Wed, 03 Jun 2026 09:47:29 +0530
Message-ID: <87jysgz292.fsf@vajain21.in.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDAzNSBTYWx0ZWRfX7SnlCCsdLysf
 FlrsYAb6KV1zqoL7srBtnWz8E5bAYjJZmED0IR1kUoqtSc3Vn8cPKukHV0tGXyPLs/waiUUlXPl
 3+fu8VUK0F39t11x1iK3LXwTICrxc/5KmZoHJemOoGZVVYCWoHy6SDA3OQ4cLlcdeuT1gsExqA5
 byIWDxEbjOcGNqX0RpD5QdshUL77Eomh+L0OlKlFiUUh9Hr+VlvPVnfNlill/MrxPZSN/wFywEJ
 OQ3PP/wBPE6WqG+qFPwpGM+TyA+HWNH4WxzWLJCNSgh1uipSHneQNnpZTrAJdqFWDNGDRZBmkCQ
 rcDLoETaJ8eVCFHE5InoyJHHbT/5kiaV7wqDC8ZnqeGqQh/PBEj+S0C6bPZPkk2ODxpuqnPFV5l
 6Y2WuNXyKAt1IV4vXU1qh5eMRDXAP+CtNKDhSBwx5K9+knfIHzhGz+67qjKKsW6Q9VCWLaiYimz
 YSmaUD/9CCoKCWJ1eIg==
X-Proofpoint-GUID: tI3qAk0fTHMqAvUgWZTqABnCBHl9GrBQ
X-Proofpoint-ORIG-GUID: wSnv7YfzqleDVtSTx-grc6_CHyqyAg5v
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a1faae4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=o01m_0irJwqdz-O0wKQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030035

Hi Amit,

Thanks for the patch. My review comments inline:

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> Currently, when booting a compatibility-mode KVM guest (L1) on a PowerNV
> hypervisor (L0), the guest runs with the expected processor
> compatibility level. However, when booting a nested KVM guest (L2)
> inside the L1, QEMU derives the CPU model from the raw host PVR and
> attempts to run the nested guest at that level, instead of honoring the
> compatibility mode of the L1.
>
> Extend host CPU compatibility capability reporting to support nested
> virtualization on PowerNV systems (PAPR nested API v1).
>
> For nested API v2 (PowerVM), compatibility capabilities are obtained
> from the hypervisor via the H_GUEST_GET_CAPABILITIES hcall. This
> information is not available on PowerNV systems.
>
> For nested API v1, derive the compatibility capabilities from the L1
> guest by reading the "cpu-version" property from the device tree, which
> reflects the effective (logical) processor compatibility level. Map this
> value to the corresponding compatibility capability bitmap.
>
> Introduce a helper to translate CPU version values into compatibility
> capability bits and integrate it into kvmppc_get_compat_cpu_caps().
>
> This allows userspace to query host CPU compatibility modes on both
> PowerVM and PowerNV platforms via the KVM_PPC_GET_COMPAT_CAPS ioctl.
>
> Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>  arch/powerpc/kvm/book3s_hv.c | 37 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 38de7040e2b7..18774c49af85 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -6522,15 +6522,50 @@ static bool kvmppc_hash_v3_possible(void)
>  	return true;
>  }
>  
> +static int kvmppc_map_compat_capabilities(const __be32 cpu_version,
> +				      unsigned long *capabilities)
> +{
> +	switch (cpu_version) {
> +	case PVR_ARCH_31_P11:
> +		*capabilities |= H_GUEST_CAP_POWER11;
> +		break;
> +	case PVR_ARCH_31:
> +		*capabilities |= H_GUEST_CAP_POWER10;
> +		break;
> +	case PVR_ARCH_300:
> +		*capabilities |= H_GUEST_CAP_POWER9;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
>  
>  static int kvmppc_get_compat_cpu_caps(struct kvm_ppc_compat_caps *host_caps)
>  {
> +	struct device_node *np;
>  	unsigned long capabilities = 0;
> +	const __be32 *prop = NULL;
>  	long rc = -EINVAL;
> +	u32 cpu_version;
>  
>  	if (kvmhv_on_pseries()) {
> -		if (kvmhv_is_nestedv2())
> +		if (kvmhv_is_nestedv2()) {
>  			rc = plpar_guest_get_capabilities(0,
>  	&capabilities);
Need to mask capabilities as mentioned in the review comments for
previous patch. I would suggest creating a helper that performs the
hcall and applies the mask which can then be used at
plpar_guest_get_capabilities() call sites.

> +		} else {
> +			for_each_node_by_type(np, "cpu") {
> +				prop = of_get_property(np, "cpu-version", NULL);
> +				if (prop) {
> +					cpu_version = be32_to_cpup(prop);
> +					break;
> +				}
> +			}
> +			if (!prop)
> +				return -EINVAL;
> +			rc = kvmppc_map_compat_capabilities(cpu_version,
> +								&capabilities);
> +		}
>  		host_caps->compat_capabilities = capabilities;
>  	}
>  
> -- 
> 2.50.1 (Apple Git-155)
>

-- 
Cheers
~ Vaibhav

