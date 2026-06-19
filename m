Return-Path: <linuxppc-dev+bounces-22784-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D014CD98F6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 06:12:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghS1j2fDbz2y1Y;
	Fri, 19 Jun 2026 16:12:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781849561;
	cv=none; b=DXSCtTnTJK9OuFrt1WE5dQpv9Cjz7kH+NmeNYXXftvr/YmXqNNB0hzu3Aa146eWNp2wpiDRc9bTofzVwkKdQMlOi1PIGfgo5Nz9zb3sGUGcO4Y/GbkDsTO06vhEcQqpzM2XBeDumfx1hn0Ds5iKTgF+7RG8G4kpyTuuKZZBDMoAkuOKaLe02DBdo2Pklc6EsVHa9cw2KW7n/O8fpTOUj0gwA7hT1Cy9vkQZ58fryGgDi7RixYkFxdSY/vzBMs2rHya0IU+BPQViZkONsjnMXXktDfot3npw12k/bwr8PQ2uw4jM5qyG0zEI1U5zvJD2qwY51w3Zf3jyOVkiQqk1w5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781849561; c=relaxed/relaxed;
	bh=WtC5hHf9h6L90wSQyUu2lgo4SnHxcLRlNmqRIbquDTk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TzW3zTLJwzEcHj5togV3fsOLmHq7PUWm1AJtoKEmhwo+6hJ6Ea6E22naUCS1jQaxJRAwOPWb2sdEeblBe2kt8mTcVNkGAkRF7Y7NjwbUnPNpJLvZefm13+9StfVVCyeWeyDbgQPbaAdJtcjQlDOuhcWPVIIrnB3stGpzTlO/+EF1sg1fsPoQQE/7a5ME3QzPRP3ol7iC+G6wYHQkmWsu3OpnGdgoMlopFxywFtFNSnt+3sogYRrcax8R4cPuCwCcRdy9v88l6xNxT2ix9cKWpMssJ/bS3ArmKtGeyfkAOsXGfvBXdQHGLi3Am35uyzyh4BZfaY/Ai6BmyEZJjVZddQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nvofcwHn; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nvofcwHn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghS1h3NHgz2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2026 16:12:39 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J3IKs11152589;
	Fri, 19 Jun 2026 06:12:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=WtC5hHf9h6L90wSQyUu2lgo4SnHxcL
	RlNmqRIbquDTk=; b=nvofcwHnip07Rd9CIIDCBuTD5u9x1OE4aSELsHXyAVVeEi
	VZhu+SuctGEdPmFwn55AWuCerNh//cwcm439wexGCi1ERXDN74xH+Pke3hroTdb2
	WV6qG+2m+1dCkPX30UEBskPNeDhGrFiai0+Bi0bx8Al7hsz6zxTUSgjfPigaRlxO
	VrJgoJgBDkBm3rIIecd3b5sDe5l6x89RTUWU+8wuz72ajDXvMeCXTbZmvePgF1Fc
	OF0HBwgLlynAmJzDZ2H7UPw20nzZZg8qsPCl4dItEWF9Qymw8mf+7ttE+lBk1a6y
	5E0fy5V7Fd0UsvZIWtnlPFw22aDZSqURzsd+JUtg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqtv342-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 06:12:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65J64dHr016589;
	Fri, 19 Jun 2026 06:12:28 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev1727f8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 06:12:28 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65J6CRQF7078420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 06:12:27 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D6855804B;
	Fri, 19 Jun 2026 06:12:27 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D0DE58059;
	Fri, 19 Jun 2026 06:12:20 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.39.17.1])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with SMTP;
	Fri, 19 Jun 2026 06:12:20 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Fri, 19 Jun 2026 11:42:18 +0530
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
Subject: Re: [PATCH v4 3/4] KVM: PPC: Book3S HV: Add support for compat CPU
 capabilities for KVM on PowerNV
In-Reply-To: <20260616123314.82721-4-amachhiw@linux.ibm.com>
References: <20260616123314.82721-1-amachhiw@linux.ibm.com>
 <20260616123314.82721-4-amachhiw@linux.ibm.com>
Date: Fri, 19 Jun 2026 11:42:18 +0530
Message-ID: <875x3fcb3x.fsf@vajain21.in.ibm.com>
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
X-Proofpoint-ORIG-GUID: N4EJi2mYoEf3fnX90jYjSgQrXpCQN8gb
X-Proofpoint-GUID: oGEcKsV8oUvIPZMtX3MTwT9d1acX56UD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA1MSBTYWx0ZWRfX165EVOfcr1AJ
 oxHBt0NF651KpevIwDvC0TlVcPSD/cbE6CxuZuXde3HDpv9v71tjs337S3rTrNH+JCo4hC5Rg1g
 XFSOnuZF+a712j0wzAppVw60voPDnXetEA5nRnEVHLinP4axjZylIiDJaEDnKhhs2ueKvh7VbFW
 aWh7E8z4XrAlEesFeldM+8maHP+c5i5LlHb+GDIXn/JsB60W9spJhLd+6icst5Urb80hixpDAls
 ChYDC+wIz6PrFSZ9tlNoAjpVsUmuZfpBcCVL7VCBilp5OYenwfK32iCdlsIeOnhCsaO7PW1VlVq
 wrqeQCITfXt8jzdkx0Rfrg5jnjTgzRHZU5BkHsMQDKIhjCtx4HZN1V1vXaudT4FVrLADo4Z8Y7d
 XnpYLvzmNtMuYczNV8ufKEI6f5UU4wDadVXVBMQL7A8Rvi4q6VySuJ6SB83EIVixvIIgxjX/v2N
 9zkvX742oXVbXGvwCaA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA1MSBTYWx0ZWRfX+/BXOG94N0EX
 CJNTDem/2AfWtY9R/lL01s4lfYINTxKSX1qOh0DhP2hnv4TpR/TROIrngYSVGbw1zz/KvS9sFlm
 OMvBQnefOiDIXfb9eO2ZzWDUlwGLLpU=
X-Authority-Analysis: v=2.4 cv=B4KJFutM c=1 sm=1 tr=0 ts=6a34ddcd cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=o01m_0irJwqdz-O0wKQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190051

Hi Amit.

Thanks for the patch and incorporating V3 review comments. Further
review comments inline below:

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
> value to the corresponding compatibility capability bitmap using
> KVM-specific constants.
>
> Introduce a helper to translate CPU version values into KVM_PPC_COMPAT_CAP
> bits and integrate it into kvmppc_get_compat_caps(). The implementation
> applies masking to ensure only supported processor modes are exposed.
>
> This allows userspace to query host CPU compatibility modes on both
> PowerVM and PowerNV platforms via the KVM_PPC_GET_COMPAT_CAPS ioctl.
>
> Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>  arch/powerpc/kvm/book3s_hv.c | 37 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index f674386df62c..375e7a7fa9f8 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -6523,15 +6523,50 @@ static bool kvmppc_hash_v3_possible(void)
>  	return true;
>  }
>  
> +static int kvmppc_map_compat_capabilities(const __be32 cpu_version,
> +				      unsigned long *capabilities)
> +{
> +	switch (cpu_version) {
> +	case PVR_ARCH_31_P11:
> +		*capabilities |= KVM_PPC_COMPAT_CAP_POWER11;
Do you need to do 'break' here instead of falling through. Since P11
host can support P10 and P9 compat modes

> +		break;
> +	case PVR_ARCH_31:
> +		*capabilities |= KVM_PPC_COMPAT_CAP_POWER10;
> +		break;
> +	case PVR_ARCH_300:
> +		*capabilities |= KVM_PPC_COMPAT_CAP_POWER9;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
>  
>  static int kvmppc_get_compat_caps(struct kvm_ppc_compat_caps *host_caps)
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
>  			rc = plpar_guest_get_capabilities(0, &capabilities);
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
should you check for 'rc' error here before assigning 'capabilities' to
'host_caps->compat_capabilities' . I understand it will be set to '0'
due to its initialization at the top of the function. But would be
better to make it more explicit

>  		host_caps->compat_capabilities = capabilities &
>  							KVM_PPC_COMPAT_BITMASK;
>  	}
> -- 
> 2.50.1 (Apple Git-155)
>
>

-- 
Cheers
~ Vaibhav

