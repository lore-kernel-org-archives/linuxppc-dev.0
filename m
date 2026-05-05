Return-Path: <linuxppc-dev+bounces-20473-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F711FF885A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 09:50:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8tzM5Wddz2xfB;
	Tue, 05 May 2026 19:50:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777974607;
	cv=none; b=XNuE4GmYNrQ51v5u3IPQ8f4Mp8/zrcrLZ2w9nB1FrqgOwYuw/0c/QG+qUhedJvqvJsrMVbrWHJ7mec8YCVLQtrLuB6rr3gE850W4UPm6nr4+YRsQCKsUiFDjQPMnaj2E5iT68Za3Uh0XOAoEutk9ujKOnT1qMW9AM0ZnPEnbGPvdx5lpOjnU/LOhEId//AoKEPjNvh7OpCZXhoORTcNaIh8eh4RLuT6cuSyqv+sSihrxRph/bLM2BQBQE50KlRl16WchJWNdOQA4l5265XF21po/JHKc1BAJCrJL4Xta6AL/yMPkzR3HjPWP3UvtPFaI37AiV0Cwe3TAC+wsu/UnnA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777974607; c=relaxed/relaxed;
	bh=wg84ntOAW2Dwegt+EtfJkt0bJBi0L3C+LRr1yoq0bqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VVENgkH2w8uMjceFwjeuprqsvTKTWNj34Cnr7KB/evyMwaxLpkJVG1K3FupPeracJZwVcutvqSR+trQTLJOG3uUG7NYci+P6/b+X4F9r3kMK7uJSe/TCeJjY6mOnvXXk+SB6s9PB2uGslXjvQScOihZV7UiqNTxRcZv+O9P+PpjVWi1us8DMfqFUAnQOT+Jm/xqzMDN/jnUTHdV4qYgE2Wrz5lomP5F+kPS4fsSZreo4BQH9VAFNyQi7qYtFsvMnmV2BIlyuTJE3BG3hcP8wzr6WYNklkcs9UpK3bWumvEryqbpiMBnGmE15z7730h3cfT8ESZeNHn3nhe9uZ06iPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lAsft1xP; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lAsft1xP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8tzL36R8z2xSF
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 19:50:05 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6456YUq92732371;
	Tue, 5 May 2026 09:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wg84nt
	OAW2Dwegt+EtfJkt0bJBi0L3C+LRr1yoq0bqc=; b=lAsft1xPoeDnhk2jjhOsJZ
	W5RZI0FcCBEg1aE99DY8N4kiroavVG+lN8srg0+JQdg2YafLDCT4z5fzDVkKVuAM
	OzWOL7aCNw5l9vUoqdRR6BFKvm1GRwdp1gVq5TN3FmMBdpha6TLAUFfVuqEH86D2
	yFrHxextKRAkS5E1lv9dL+fVLtYixnFVHh3uOpUsnIdzhjJb/wEEU6T7gHzoFV1W
	fkPccua5j1ZM9IXU80xDnR7kZbMc9vPuZvJntYwd1SLcVCkZu0o8mFLW1k2e8prh
	LFXl0NEjZkGQMVkQvbBh6fS4GaOAPh1o2wTNj1YI+tQJ3DOSfG9Tl2JuwY0L15xg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9v7b10a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 09:49:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6459dZFJ001660;
	Tue, 5 May 2026 09:49:55 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtg8ut5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 09:49:55 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6459nrao3605374
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 May 2026 09:49:53 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5169158065;
	Tue,  5 May 2026 09:49:53 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53E6E58052;
	Tue,  5 May 2026 09:49:50 +0000 (GMT)
Received: from [9.123.0.169] (unknown [9.123.0.169])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 May 2026 09:49:49 +0000 (GMT)
Message-ID: <a85ed3d9-2a7e-4e63-93ef-c38c4b9a4305@linux.ibm.com>
Date: Tue, 5 May 2026 15:19:48 +0530
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
Subject: Re: [PATCH 5/6] KVM: PPC: Book3S HV: Add support for compat CPU
 capabilities for KVM on PowerNV
Content-Language: en-GB
To: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>, Nicholas Piggin
 <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260430054906.94431-1-amachhiw@linux.ibm.com>
 <20260430054906.94431-6-amachhiw@linux.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260430054906.94431-6-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA4OSBTYWx0ZWRfX2nKzsJOBRHqD
 5cxYCVjh1F4sQWDMDAEmjRHWrOauBllx8EPE4RVIvXKK1pe4z8uC9RyaezCkof3pw1xtwXdK8dp
 aQfPVz1OZ3lQxFj42kQqwRVL2ntCVsDz9I28DcRPPYbUf5NFTwvGHyU6DNTiddWc/spZvueJYKd
 xcvAMzN5isHEdrVlSNV+QoZpnh+upAvfGLg3Us90luCRvoV2i2TrnYylJRoCKkmoV6Hs2Mwzrf/
 dnQGhxMCjAI1/nLSur3gq4Y3WJNKQW/kowAD61P8bPTKmIxfQu8IeysiKQ+NIQ17TWSHTaDvyJa
 Itu3JNegZSIYLXxxGrxdJhy+k6793ntjjjcTgwwq1tdSLgvNwlu8wrOAbVyLkdBu/KuBvHgKEUK
 DyZcahOvc/s/4ho2yp73PK4lnwSsWVw+bvVrdQN7xh1rJpMeLHg95cOSCz14wzzbGzUHfAxLoAi
 Lu9Cz2g6KHtza8bTJNw==
X-Proofpoint-GUID: 3bxmTmYm5aOtlNoUAHoSlI-du3CG43pf
X-Proofpoint-ORIG-GUID: Dl4g9JgMdUTLWArVAiTB7EOJW-eGJQUS
X-Authority-Analysis: v=2.4 cv=eu/vCIpX c=1 sm=1 tr=0 ts=69f9bd44 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22
 a=VnNF1IyMAAAA:8 a=snkozyE_eINVwAcpY-AA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050089



On 30/04/26 11:19 am, Amit Machhiwal wrote:
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
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>   arch/powerpc/kvm/book3s_hv.c | 37 +++++++++++++++++++++++++++++++++++-
>   1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index d602d90111d1..25d05f1ccb72 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -6516,16 +6516,51 @@ static bool kvmppc_hash_v3_possible(void)
>   	return true;
>   }
>   
> +static int kvmppc_map_compat_capabilities(const __be32 cpu_version,
> +				      unsigned long *capabilities)
> +{
> +	switch (cpu_version) {
> +	case PVR_ARCH_31_P11:
> +		*capabilities |= H_GUEST_CAP_POWER11;

Should this be:

+               *capabilities |= H_GUEST_CAP_POWER11 |
+                                H_GUEST_CAP_POWER10 |
+                                H_GUEST_CAP_POWER9;

Likewise, the remaining as applicable?

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
>   static int kvmppc_get_compat_cpu_caps(struct kvm_ppc_compat_caps *host_caps)
>   {
>   
> +	struct device_node *np;
>   	unsigned long capabilities = 0;
> +	const __be32 *prop = NULL;
>   	long rc = -EINVAL;
> +	u32 cpu_version;
>   
>   	if (kvmhv_on_pseries()) {

Commit title says PowerNV, but here were are doing only for PowerVM?

> -		if (kvmhv_is_nestedv2())
> +		if (kvmhv_is_nestedv2()) {
>   			rc = plpar_guest_get_capabilities(0, &capabilities);
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
>   		host_caps->compat_capabilities = capabilities;
>   	}
>   


