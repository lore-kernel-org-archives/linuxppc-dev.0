Return-Path: <linuxppc-dev+bounces-25400-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDDDC55174
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2026 04:32:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFHZn0w5Vz2xpn;
	Wed, 05 Aug 2026 14:32:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785904369;
	cv=none; b=hGHE115prx+mduQAKxgIDDwzVVXGFTrTXR5rh18PRmgMDI7EN2XqwAqlhhuu7tYD6Mrw+iv7qYNXQnDFC1hUB8QiwF2lz7GTevHx7e+u83xHihMaX9gK1lL6bPuR08S6YcEZLeAv14XnMNPFL+5Ifh0WFr6ODN2IihdCJSi5oCLZ24IvRxYqQWnGN5I2MLakjKnZgWd24CGMjlL3ddaChIQZnZys/AeKQrmFgaGpEbZZhKavmMvT/hDvvw5t6AuScAj1ITsiqehah1CaDYbjcBrb0JZs5/BX3oiYavxjq4Sr4JKCWq29eUc932HRsNjSEJG+jjTJj1Ea0q39rQgx4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785904369; c=relaxed/relaxed;
	bh=sHJ1iPvT8K2mXnbeba6IcA2Xdi7doDnL2X/2P1fLIpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V0fJRaG8sUNeNXF3SBFdq36lm8QYhqUk28fuiGI5QXrcxEgxBud4XsERo6tZsgjTpodSEZTFD2z9kEjwTFIoCCfF5+fu4RDFf042vl7nN1u9HgqjV6OMjXxUTSZE+TX7Erx9AJ+SfWJjqH8bZSZUmW1g9phZELWwMOTSDiU75v0IFptf+8M3G8XaF74dAkO+8Wcan4IW+eoUNsboA54u47B0lkmV6jDs9flaSlPJBN9gZxJDfFJ1dt38I+YMkLDHRCHJfNOoylpmAEkYgJlRwapmTbPLeXr4vToC7/ke1Yhku5r6ThAXPqCrLFsyCArXre79LXlBynjXxdNmSWfVKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HmmaCqJK; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=anushree.mathur@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HmmaCqJK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=anushree.mathur@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFHZm0JqHz2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 14:32:47 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6752nE5R2612541;
	Wed, 5 Aug 2026 04:32:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sHJ1iP
	vT8K2mXnbeba6IcA2Xdi7doDnL2X/2P1fLIpI=; b=HmmaCqJKrbW6vQy3TsH0tU
	/6gYb1weOydiIVhE+x0a7X+q6Yo6l3wPs54lGXVwlaK0+OU+36Cp73Y/KOlxEabl
	7NWkJiqVxqdX2XiwZHac4yx4E1hixHYd2Uo/bobX3/fWWX7O+9VSKxTZhdW23sua
	v7a6QT+zLxbtRms5rRfRuoewJxmuahmV+2XjyLlmxDsbbVdIeQhu8u+OtJRTM48O
	UdpZDTmBIpd847MJEeTVb0yUw3wGVRgg11AFaFQIIyji+pzlNbo+SmjdPoACxoWc
	dW1ZZAjbYQXQi+qMFTFr8gALP6Q99ResQt3Ytm8Em0q6v+YL8Gs7IBfCpikE+tdw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a417vj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 04:32:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6754QM6X009481;
	Wed, 5 Aug 2026 04:32:33 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhcwat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 04:32:33 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6754WWPT13369944
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 04:32:32 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DCF1580A3;
	Wed,  5 Aug 2026 04:32:32 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EE7D58156;
	Wed,  5 Aug 2026 04:32:27 +0000 (GMT)
Received: from [9.61.246.192] (unknown [9.61.246.192])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 04:32:16 +0000 (GMT)
Message-ID: <4c1f7c37-56c9-4fa9-94ae-c867872da353@linux.ibm.com>
Date: Wed, 5 Aug 2026 10:02:15 +0530
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
Subject: Re: [PATCH v6 0/4] KVM: PPC: Expose CPU compatibility modes for
 nested guests
To: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
References: <20260804180705.59160-1-amachhiw@linux.ibm.com>
Content-Language: en-US
From: Anushree Mathur <anushree.mathur@linux.ibm.com>
In-Reply-To: <20260804180705.59160-1-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a72bce3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Lms9HglfbqfVGmd6hngA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -22EsFqoBbEErTSaiDVW_rs_5lzvDxzf
X-Proofpoint-GUID: tUXB9BNiuAM8LPj7TbytVNr8cIqMDoH3
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDAyOSBTYWx0ZWRfXzz+le/8tdkFd
 MMAsnNYiGZSpTg8SrjGncEL+5WTN3+yv2Uc7rCnH1GUc9NzEhffXf866dT4gHG6zwf6wEuOSg2g
 xj0s03rOm2/QXyk6m5tcsv9gmGV/USw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDAyOSBTYWx0ZWRfXwQtuSVyiL5x3
 dZ3ig3d2mwIU3p7fRkrT/jFs6DHTL/eqS6C2QeRzE3yxyGGChYjLWEhmGSRYUtwG/ba4UIVL7dn
 vXPAnrM3L0S7oC7XJTUvDycd6m9PJhweMjDJ08AntqhwmdHAOkWalBjZJ5ixCnKwwBwajrxtRDP
 K0gt35RyHA+KUgA44i7AdDJEZEUZOgz1lnE5eYKFKpyfkurAOdPlJuse9xc1Rfjpn3QNLiY/mhf
 Sm2oaXGsI4i7mHNcBBcmvN7MF54EQbfPE3a0nNXzBSvSVU0XmT4UygAO4VY7J28oaAzke2pNcuR
 +roM2eW0+mzT7Q5pjnDnkLO8Cib2iR6dxhlrB78zce1QOv+zOMf1sGjPHsjZ128tvvkyLshKYCy
 UtXumVt1AxXDUu7SKBDIT6XXx1GWBA8BjlKBPjIzkAl0mtgITUkHjt2OzN4TE0WaEuwR4xsKVtE
 Sw4BV16EpDwT7eKUebQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_01,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050029



On 04/08/26 11:37 PM, Amit Machhiwal wrote:
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
> This series provides a mechanism for userspace to query the effective CPU
> compatibility modes supported by the host, so it can select an appropriate
> CPU model for nested guests.
>
> To achieve this, the series introduces a new KVM capability and ioctl
> (KVM_CAP_PPC_COMPAT_CAPS / KVM_PPC_GET_COMPAT_CAPS) that expose the
> compatibility modes supported by the host.
>
> Why a new UAPI?
> ===============
> While cpu-version is available in /proc/device-tree/cpus/<cpu#>/cpu-version
> on both L1 booted on PowerNV and PowerVM LPARs, the UAPI approach is
> preferable for several reasons:
>
> 1. pHYP (L0) capabilities: On PowerVM, we need to rely on capabilities
>     negotiated with pHYP in KVM, not just device tree properties. The
>     cpu-version property depicts the current compat mode but doesn't point
>     to what all compat modes are supported for the nested guest.
>
> 2. procfs dependency: Not all systems run with procfs enabled (CONFIG_PROC_FS
>     is optional). Minimal configurations like buildroot might disable it, but
>     KVM ioctl works regardless since it accesses kernel data structures
>     directly.
>
> 3. Kernel validation: The kernel validates and normalizes the compatibility
>     information, ensuring userspace gets validated, consistent data.
>
> 4. Abstraction & stability: /proc/device-tree is an implementation detail.
>     The UAPI provides a stable interface that won't break if the underlying
>     mechanism changes.
>
> 5. Semantic clarity: KVM_PPC_GET_COMPAT_CAPS clearly expresses what
>     compatibility modes can be used for KVM guests, vs. parsing device tree
>     which requires understanding the semantic meaning of cpu-version.
>
> The implementation supports both:
>
>    - KVM on PowerVM (nested API v2), where compatibility information is
>      served from the cached nested_capabilities value, originally obtained
>      via the H_GUEST_GET_CAPABILITIES hypercall at module init.
>    - KVM on PowerNV (nested API v1), where compatibility is derived from the
>      device tree ("cpu-version") representing the effective processor
>      compatibility level.
>
> This allows userspace (e.g., QEMU) to select a CPU model consistent with
> the host compatibility mode, avoiding mismatches and enabling successful
> nested guest boot.
>
> Note: This series is built on top of patch [1] which must be applied first.
> Patch [1] ensures arch_compat is validated against the host compatibility
> mode before this series adds the capability query mechanism.
> Commit e4de1b9cb3b5 ("powerpc/dt_cpu_ftrs: Set CPU_FTR_P11_PVR for Power11
> and later processors") which was also a prerequisite has been merged upstream.
>
> Changes in v6:
>    - Changed KVM_PPC_GET_COMPAT_CAPS ioctl number from 0xe4 to 0xb8 to
>      avoid placing it in the KVM_CREATE_DEVICE fd ioctl range (0xe0-0xe3);
>      relocated definition to sit alongside other PPC vm ioctls (patch 1)
>      - [Gautam]
>    - kvmppc_map_compat_capabilities(): changed parameter type from
>      'const __be32' to 'u32' to fix Sparse type annotation warning (patch 3)
>      - [Sashiko]
>    - kvmppc_get_compat_caps(): replaced of_get_property() + be32_to_cpup()
>      with of_property_read_u32() for implicit length validation and cleaner
>      endianness handling (patch 3) - [Sashiko]
>    - Documentation: corrected :Parameters: from (out) to (in/out) since
>      userspace must set size and flags before calling (patch 4) - [Sashiko]
>
> Patch summary:
>    [1/4] Introduce KVM_CAP_PPC_COMPAT_CAPS and wire up ioctl
>    [2/4] Implement capability retrieval for KVM on PowerVM (API v2)
>    [3/4] Add KVM on PowerNV support (API v1)
>    [4/4] Document the new ioctl
>
> Testing (with QEMU v4 patches and on top of patch [1]):
>
> KVM APIv1 Testing
> =================
>    On P10 PowerNV machine (L0)
>    ---------------------------
>      - P10 L1 KVM guest -> works
>        - P10 nested L2 KVM guest -> works
>        - P9 compat nested L2 KVM guest -> works
>      - P9 compat L1 KVM guest -> works
>        - P9 nested L2 KVM guest -> works
>
>    On Powernv11 TCG Guest (L0)
>    ---------------------------
>      - P11 PowerNV TCG L0 guest -> works
>      - P11 L1 KVM guest -> works
>        - P11 L2 KVM guest -> works
>      - P10 compat L1 KVM guest -> works
>        - P10 L2 KVM guest -> works
>      - P9  compat L1 KVM guest -> works
>        - P9 L2 KVM guest -> works
>
> KVM APIv2 Testing
> =================
>    On P11 PowerVM LPAR (L1)
>    ------------------------
>      - P11 L2 KVM guest -> works
>      - P10 compat L2 KVM guest -> works
>      - P9 compat L2 KVM guest fails to boot as expected
>      - Without QEMU patches but Linux patches
>        - P11 L2 KVM guest -> works
>        - P10 compat L2 KVM guest -> works
>        - P9 compat L2 KVM guest fails to boot as expected
>      - Without Linux patches but QEMU patches
>        - P11 L2 KVM guest -> works
>        - P10 compat L2 KVM guest -> works
>
>    On P11 LPAR in P10 compat (L1)
>    ------------------------------
>      - P10 (host compat) L2 KVM guest -> works
>      - Without QEMU patch but Linux patches
>        - P10 guest fails to boot as expected (error: kvm run failed Invalid argument)
>      - Without Linux patch but QEMU patches
>        - P10 guest fails to boot as expected (KVM: unknown exit, hardware reason ffffffffffffffea)
>
>    On P10 PowerVM LPAR (L1)
>    ------------------------
>      - P10 L2 KVM guest -> works
>      - P9 compat L2 KVM guest fails to boot as expected
>
> TCG pSeries Guest
> =================
>      - P11 (default) pSeries guest boots fine
>
> ABI Extensibility Testing (struct size 32, extra member)
> =========================================================
>      - Newer struct on QEMU, older kernel -> works (kernel returns -E2BIG,
>        QEMU retries with correct size)
>      - New struct on Linux kernel, older QEMU -> works (kernel zero-pads
>        trailing fields, QEMU gets correct data)
>
> With this series, nested guests boot successfully in configurations where
> they previously failed due to compatibility mismatches.
>
> Related QEMU series:
> ====================
> A corresponding QEMU v5 series will be sent soon.
>
> Previous QEMU versions:
> v4: https://lore.kernel.org/all/20260701052341.62289-1-amachhiw@linux.ibm.com/
> v3: https://lore.kernel.org/all/20260616113915.25589-1-amachhiw@linux.ibm.com/
> v2: https://lore.kernel.org/all/20260502140021.69712-1-amachhiw@linux.ibm.com/
> v1: https://lore.kernel.org/all/20260430061333.37905-1-amachhiw@linux.ibm.com/
>
> Previous versions:
> ==================
> v5: https://lore.kernel.org/linuxppc-dev/20260701051409.51820-1-amachhiw@linux.ibm.com/
> v4: https://lore.kernel.org/linuxppc-dev/20260616123314.82721-1-amachhiw@linux.ibm.com/
> v3: https://lore.kernel.org/linuxppc-dev/20260522152744.55251-1-amachhiw@linux.ibm.com/
> v2: https://lore.kernel.org/linuxppc-dev/20260513100755.83195-1-amachhiw@linux.ibm.com/
> v1: https://lore.kernel.org/linuxppc-dev/20260430054906.94431-1-amachhiw@linux.ibm.com/
>
> References:
> ===========
> [1] https://lore.kernel.org/all/20260714175432.86388-1-amachhiw@linux.ibm.com/
>
> Amit Machhiwal (4):
>    KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and wire up ioctl
>    KVM: PPC: Book3S HV: Implement compat CPU capability retrieval for KVM
>      on PowerVM
>    KVM: PPC: Book3S HV: Add support for compat CPU capabilities for KVM
>      on PowerNV
>    KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl
>
>   Documentation/virt/kvm/api.rst      | 79 +++++++++++++++++++++++++++++
>   arch/powerpc/include/asm/kvm_ppc.h  |  1 +
>   arch/powerpc/include/uapi/asm/kvm.h | 18 +++++++
>   arch/powerpc/kvm/book3s_hv.c        | 56 ++++++++++++++++++++
>   arch/powerpc/kvm/powerpc.c          | 71 ++++++++++++++++++++++++++
>   include/uapi/linux/kvm.h            |  3 ++
>   6 files changed, 228 insertions(+)
>
>
> base-commit: 848acc8ffe1b7cd5f1bf427b93069becfebc2c9d
> prerequisite-patch-id: 7755786f0e4f415e47065ff1972765008727fe10

Hi Amit,
I have tested this patch and it works as expected. Here is my analysis :

I booted a host with Power10 compat mode and tried following scenarios -


lscpu on host :

Architecture:                ppc64le
   Byte Order:                Little Endian
CPU(s):                      8
   On-line CPU(s) list:       0-7
Model name:                  POWER10 (architected), altivec supported


Before applying the patch :

When I am trying to bringup the guest on a compat mode host it was 
bringing up a Power11 guest and was failing as

[ 1411.578944] [   T2928] KVM-NESTEDv2: couldn't set guest wide elements
[ 1411.578963] [   T2928] vcpu 000000000b9c4155 (0):
[ 1411.578968] [   T2928] pc  = 000000007daf9790  msr = 
8000000000103000  trap = ffffffea
[ 1411.578973] [   T2928] r 0 = 8000000000003000  r16 = 0000000000000000
[ 1411.578978] [   T2928] r 1 = 000000007e581e20  r17 = 0000000000000000
[ 1411.578982] [   T2928] r 2 = 000000007db26c00  r18 = 0000000000000000
[ 1411.578985] [   T2928] r 3 = 0000000000000000  r19 = 0000000000000000
[ 1411.578989] [   T2928] r 4 = 0000000002e30c80  r20 = 0000000000000000
[ 1411.578993] [   T2928] r 5 = 000000007df80000  r21 = 0000000000000000
[ 1411.578996] [   T2928] r 6 = 0000000000200000  r22 = 00000000018c5fd6
[ 1411.579000] [   T2928] r 7 = 000000007df80000  r23 = 000000007db21cc0
[ 1411.579003] [   T2928] r 8 = 000000007db6e5d8  r24 = 000000007db66000
[ 1411.579006] [   T2928] r 9 = 000000007e6655d8  r25 = 000000007e665508
[ 1411.579010] [   T2928] r10 = 000000007db6e5d0  r26 = 00000000018c5fd6
[ 1411.579013] [   T2928] r11 = 0000000000003000  r27 = 0000000000000003
[ 1411.579017] [   T2928] r12 = 8000000000000001  r28 = 000000007db6e5e0
[ 1411.579020] [   T2928] r13 = 0000000000000000  r29 = 000000007db224b0
[ 1411.579024] [   T2928] r14 = 0000000000000000  r30 = 000000007daf274c
[ 1411.579028] [   T2928] r15 = 0000000000000000  r31 = 000000007db76000
[ 1411.579033] [   T2928] ctr = 000000007daf1b44  lr  = 000000007daf1b7c
[ 1411.579037] [   T2928] srr0 = 000000007daf9790 srr1 = 8000000000102000
[ 1411.579041] [   T2928] sprg0 = 0000000000000000 sprg1 = 000000000000ff10
[ 1411.579045] [   T2928] sprg2 = 0000000000000000 sprg3 = 0000000000000000
[ 1411.579049] [   T2928] cr = 20000402  xer = 0000000020040000 dsisr = 
00000000
[ 1411.579054] [   T2928] dar = 0000000000000000
[ 1411.579057] [   T2928] fault dar = 0000000000000000 dsisr = 00000000
[ 1411.579061] [   T2928] SLB (0 entries):
[ 1411.579064] [   T2928] lpcr = 0040000000020400 sdr1 = 
0000000000000000 last_inst = ffffffffffffffff
[ 1411.579069] [   T2928] trap=0xffffffea | pc=0x7daf9790 | 
msr=0x8000000000103000





After applying this patch along with the qemu built with it's dependent 
patch 
(https://lore.kernel.org/all/20260804182914.83091-1-amachhiw@linux.ibm.com/):

I am able to bringup a guest and it got boot up with Power10 by default:


lscpu on guest -

ltcbonn53-vm2:~ # lscpu
Architecture:                ppc64le
   Byte Order:                Little Endian
CPU(s):                      8
   On-line CPU(s) list:       0-7
Model name:                  POWER10 (architected), altivec supported
   Model:                     2.0 (pvr 0082 0200)
   Thread(s) per core:        2
   Core(s) per socket:        4
   Socket(s):                 1



Please feel free to add my tested-by:
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>


Thank you,
Anushree Mathur

