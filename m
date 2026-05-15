Return-Path: <linuxppc-dev+bounces-20970-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D45DBCD4F25
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2026 10:50:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gH3rv38JCz2xT6;
	Fri, 15 May 2026 20:50:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778842255;
	cv=none; b=Qhn1tm3CZbk508PPwHFBbwmXHBwr0bimRNRGt9guM3HlsVPgGSOQ1+BJzaMQ1Qo2o1nBVAv2pYj6boLY5B1mI/Kz7BQRdQdElafriW90l8nHHpe3CNYcge3dLKVufJrEWg/lzkdbpQU6LKFgUTvQvd+nz6T41wJDBBhUpcNWIpjzG6c6tajyXFMcpy5PFlPa30wSFOYUl+rjVpMca0fmW1zTNiBICG5TcH5l1+jJEsZ/OT2nftQpgJPUzscH4PeklwEiFJX2IbtP2Ad2Hq6rmWp7zFfuaUmKkOY9UwKWkppaW4eJ3FkmcVeJyWGp/vSPmV3di8wfhQ1QIsSKJ9Fllw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778842255; c=relaxed/relaxed;
	bh=fogqdzUuIj5eY+AIUvnt4DvIbdEheTIUjQ0nCw8l21U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NUHjxRDVjM7yS3FicGfLhGWR/E8k8wCreLSWTBng6b/9Fv4SKyYqWQZFpfDkcdXtmYYRr8+MNQ7FUMRRGy70v4MGpiE9jNDq0ItZtpdYVlpyIf9JXI+iovksF0hSEege1rjOzfKMElH0WiVa0tU22UQfbFhKZbpKx0ZA2lq+ZP+zveSsZE8xbKP8CLASx5MCB74b2HuFrhQB5l//zgQuqwwSH2PIu4U3x8uirPmpOUyJYVW7ULiKZnoNS6Pt88lBiZhv1C6qWIZELcYspRQ92qZJZpxwybPFCS8xGSsDHphOGyjsWkMNrKT8XJ9Ka5dp+bo4bEokNRer+ENQJ1Ucdw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BeJQJ+yM; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=anushree.mathur@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BeJQJ+yM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=anushree.mathur@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gH3rt3Kp6z2xFl
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2026 20:50:53 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FAieuT3950738;
	Fri, 15 May 2026 10:50:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fogqdz
	UuIj5eY+AIUvnt4DvIbdEheTIUjQ0nCw8l21U=; b=BeJQJ+yMe66CTP7Xtaa5qe
	rdTrcicRvCkYAuLlnwz6kPU4OJl9be4uJxCSi4UwsrOGXUsUKsxRYnPbW++br8Po
	0utajN274QBaiH5YPNWy8iGze7Q6H4uUeDKgwSrT/oRgT8EUep2xgzfpl+AWMv/U
	efyikx2NU8suK2R9HdRlWi28f98TXnOxwYAokYoR9kiNuq0pZAcj1FENCsC6LzLo
	ZInEcw00OMsKiCiDnHB98WnM9v4H2AwMjIFt1l5+W29J5JtugPxa0B9LAQ+DxtUC
	I0qkcgBBUgWbAXfrZ3UiiYRbG72xsiwtxGXAGSRlW4L9vx4U8Kbzhj/ZmVXWcKiA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e5m8yau06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 10:50:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64FAd7Hk030252;
	Fri, 15 May 2026 10:50:30 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e5kvck4r5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 10:50:30 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64FAoTRb23331328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 May 2026 10:50:29 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44F8E58063;
	Fri, 15 May 2026 10:50:29 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A3B458065;
	Fri, 15 May 2026 10:50:25 +0000 (GMT)
Received: from [9.61.251.54] (unknown [9.61.251.54])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 May 2026 10:50:24 +0000 (GMT)
Message-ID: <105cc1ee-d0a9-4d6e-9faa-4f91ef2c519e@linux.ibm.com>
Date: Fri, 15 May 2026 16:20:23 +0530
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
Subject: Re: [PATCH v2 0/5] KVM: PPC: Handle CPU compatibility mode for nested
 guests
To: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        anushree.mathur@linux.ibm.com
References: <20260513100755.83215-1-amachhiw@linux.ibm.com>
Content-Language: en-US
From: Anushree Mathur <anushree.mathur@linux.ibm.com>
In-Reply-To: <20260513100755.83215-1-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: HQCrUiHB_zaICgpUBS1Fdg6AB4tFz0xk
X-Authority-Analysis: v=2.4 cv=Os5/DS/t c=1 sm=1 tr=0 ts=6a06fa78 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=q7P96uELB6eWBjni9OYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: kUehQ2Yelhc546v-_PeubJuHf9A4tRgp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDEwNyBTYWx0ZWRfX5jsdZ5LBzpxT
 /F3YnSEqya5TvqMdjw0nzNCSPkwTBGIzJjdNZczOy6AOgG1Js+u/OAkpGxFs6vcOeIL3/Gcc5RK
 mfTtZnjRRaioRo5ez++LLJ+dYkgZVkbzM1HrghEPmWHkK1UmmyEu3xF4TEfzYGPBox7TOIK5HFm
 0nhR9IhD2sEu/eMbx4SAyFfMr3+6kGA8asrMBGhun7Zo6e3sbmfmGFWq46tTbROT4orPlQGUBGt
 XF/Qi9JIZhhXTPpsNCjFxtkknJ8VtanOIGL0hRQ12UgzKzU/ciD16PIcnr+cLrhVhOCrfNF24qA
 sYglwvAQ+cQVZLnEcL8bbJWA7rrODb99DuvtMeIO2MvEh/f0NDVJ4MJHtsL0uLSLHtJ+NRIanwK
 8WeyQFzksSl+rbQMGd4792fWsoVhd2Ct4yjCMDUJKUedDhcZQ1Bn4Uz/GQYr7aPYLYS1bwzaBa2
 oYMYflaSW055uo5gK/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 impostorscore=0 clxscore=1011 lowpriorityscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150107



On 13/05/26 3:37 PM, Amit Machhiwal wrote:
> On POWER systems, newer processor generations can operate in compatibility
> modes corresponding to earlier generations (e.g., a Power11 system running
> in Power10 compatibility mode). In such cases, the effective CPU level
> exposed to guests differs from the physical processor generation.
>
> This creates a problem for nested virtualization. When booting a nested KVM
> guest (L2) inside a host KVM guest (L1) running in a compatibility mode,
> userspace (e.g., QEMU) may derive the CPU model from the raw hardware PVR
> and attempt to configure the nested guest accordingly. However, the L1
> partition is constrained by the compatibility level negotiated with the
> hypervisor (L0), and requests exceeding that level are rejected, leading to
> guest boot failures such as:
>
>    KVM-NESTEDv2: couldn't set guest wide elements
>
> This series addresses the issue in two steps:
>
> 1. Detect and reject invalid compatibility requests early in KVM to avoid
>     late failures.
>
> 2. Provide a mechanism for userspace to query the effective CPU
>     compatibility modes supported by the host, so it can select an
>     appropriate CPU model for nested guests.
>
> To achieve this, the series introduces a new KVM capability and ioctl
> (KVM_CAP_PPC_COMPAT_CAPS / KVM_PPC_GET_COMPAT_CAPS) that expose the
> compatibility modes supported by the host.
>
> The implementation supports both:
>
>    - PowerVM (nested API v2), where compatibility information is obtained
>      via the H_GUEST_GET_CAPABILITIES hypercall.
>    - PowerNV (nested API v1), where compatibility is derived from the device
>      tree ("cpu-version") representing the effective processor compatibility
>      level.
>
> This allows userspace (e.g., QEMU) to select a CPU model consistent with
> the host compatibility mode, avoiding mismatches and enabling successful
> nested guest boot.
>
> Changes in v2:
>    - Squashed patches 2 and 3 from v1 (capability introduction and ioctl
>      wiring) into a single patch for better logical grouping
>    - Changed kvm_ppc_compat_caps.flags from __u32 to __u64 for consistency
>      and future extensibility
>    - Addressed other review comments
>    - Improved commit messages with clearer explanations of the changes
>
> Patch summary:
>    [1/5] Validate arch_compat against host compatibility mode
>    [2/5] Introduce KVM_CAP_PPC_COMPAT_CAPS and wire up ioctl
>    [3/5] Implement capability retrieval for PowerVM (API v2)
>    [4/5] Add PowerNV support (API v1)
>    [5/5] Document the new ioctl
>
> Tested on:
>    - Power11 pSeries LPAR in Power10 compatibility mode (nested API v2)
>    - Power10 PowerNV system (and QEMU TCG PowerNV 11) with nested
>      virtualization (API v1) with various combinations of KVM L1/L2 guests
>      in various supported compatibility modes.
>
> With this series, nested guests boot successfully in configurations where
> they previously failed due to compatibility mismatches.
>
> Related QEMU series:
>    A corresponding QEMU series adds support for querying and using these
>    compatibility capabilities when configuring nested KVM guests:
>    https://lore.kernel.org/all/20260502140021.69712-1-amachhiw@linux.ibm.com/
>
> v1: https://lore.kernel.org/linuxppc-dev/20260430054906.94431-1-amachhiw@linux.ibm.com/
>
> Amit Machhiwal (5):
>    KVM: PPC: Book3S HV: Validate arch_compat against host compatibility
>      mode
>    KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and wire up ioctl
>    KVM: PPC: Book3S HV: Implement compat CPU capability retrieval for KVM
>      on PowerVM
>    KVM: PPC: Book3S HV: Add support for compat CPU capabilities for KVM
>      on PowerNV
>    KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl
>
>   Documentation/virt/kvm/api.rst      | 35 ++++++++++++++++
>   arch/powerpc/include/asm/kvm_ppc.h  |  1 +
>   arch/powerpc/include/uapi/asm/kvm.h |  6 +++
>   arch/powerpc/kvm/book3s_hv.c        | 63 +++++++++++++++++++++++++++++
>   arch/powerpc/kvm/powerpc.c          | 21 ++++++++++
>   include/uapi/linux/kvm.h            |  4 ++
>   6 files changed, 130 insertions(+)
>
>
> base-commit: 1d5dcaa3bd65f2e8c9baa14a393d3a2dc5db7524

Hi Amit,
I tried booting up a guest on P11 lpar booted with P10 compat mode 
applying your patch along with the qemu patch series and it has been 
working perfectly fine.

Host lscpu:

lscpu
Architecture:                ppc64le
   Byte Order:                Little Endian
CPU(s):                      80
   On-line CPU(s) list:       0-79
Model name:                  POWER10 (architected), altivec supported


Guest lscpu:

lscpu
Architecture:                ppc64le
   Byte Order:                Little Endian
CPU(s):                      10
   On-line CPU(s) list:       0-9
Model name:                  POWER10 (architected), altivec supported

Feel free to add :

Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>

Thank you!
Anushree Mathur

