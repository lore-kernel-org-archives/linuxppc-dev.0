Return-Path: <linuxppc-dev+bounces-25384-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D77C55184
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 18:07:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hF1jL01pHz2yLY;
	Wed, 05 Aug 2026 04:07:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785866853;
	cv=none; b=dpUnWKTLxsJ5s/7FeUNj1ha6xzYRmIz54RrX2SVyLnq2tQzL/kGFV3I3gIxvUclCdJ343mKPrCNOrh8ZAdUbJjvM9aABfD6nGw0k5XKqkkRT5feaQqJOgVBML6HzJa7i3UQbwRFA2Ii37WaFTsOVM5pfvtScPP2k4tK9kh4gk6tEm9JRmIMO19rdj71/cay16VxkfBjwG/J/2BmmtuN4wpW66BFTVxFKvfNuDb8SsILCdkSg2y+kiepjFKO3juxmw6BfI45Noqe2gNYuby31cUSJzn0GAX2ETZaCZyAK0bIUtFBdQGkzIm4h+NBeDMNOY9YV/sdrjUDtAvI6vkiP9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785866853; c=relaxed/relaxed;
	bh=B1tdDoMdjI/edwrfeWJUOcTxU6qlA1BigMxQ/o05Awk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EgE/3mqv2/4e96GmU3ItZes11lAmdsFVlLiOgpY9O89znv7CbbeNtA4PcjIi3BmYd3Pp7IIDIZZmqF/eR78vTrQot9LqIkeOckGulXVf+dSgDxf06eoG2dpVRggW1zbU5bVGn7hWVayPvS93nK7RkOGeJ7295GkMOdHEr7dKZz6hpYBD1sGN3DRdPs1njrFtLslb4OSv9e2tpb/H+VAlLg0QVGrH29zHKjjepDt3NJNoBVJzQEY+cNo4jX4OqSgEJTry5oZLGMxCS/MfYkpq3mlUA3TXeUWWXC2SzfWCruavj0BnvIDAmdyC3Q3AS9iAdLJi/zcd05LQJwGahouCKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BArlU6Kj; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BArlU6Kj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hF1jK0xCvz2yH5
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 04:07:32 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674FlXg63598933;
	Tue, 4 Aug 2026 18:07:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=B1tdDoMdjI/edwrfeWJUOcTxU6qlA1BigMxQ/o05A
	wk=; b=BArlU6KjJ2xv7mLJAtyYPeh89LJDtrAfWHXHFV6m2K5XBhlSpLjW3jbKH
	AZfowk/2xm2VrWmQgS1qvBDRvr+A/ETGp/I4UVVfF4wrZN2UhzOoCO7DWkaN9Gw9
	CWySX1GjO6Udjqu7roO0aLW2Ibn6yR7XSdiySzAiSsFtNhQyz0ZKkcEPdIROhXzp
	rBF8AmM7twLN7QfpiXIzOpss/BL5U9wMcrqGR7TJNvyQa4czwnU1QabasKsWd706
	U7sgJw7lyj7o+p4pXOy669NCU81z78CPapGqv5eiTIdBflLU1X2GJ+9YUnCVJZPC
	kaXticB0yPZIL9222Zsp38yclttbg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqq7q6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 18:07:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674HuHrn019927;
	Tue, 4 Aug 2026 18:07:19 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugw385e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 18:07:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674I7Fxr35389742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 18:07:16 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9CAF82004E;
	Tue,  4 Aug 2026 18:07:15 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C8772004B;
	Tue,  4 Aug 2026 18:07:12 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.28.45])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 18:07:11 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>,
        Amit Machhiwal <amachhiw@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v6 0/4] KVM: PPC: Expose CPU compatibility modes for nested guests
Date: Tue,  4 Aug 2026 23:37:01 +0530
Message-ID: <20260804180705.59160-1-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
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
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 7bmwyHflP4NVJYmhpMFvsOVu04KzKXa1
X-Proofpoint-ORIG-GUID: gVGxR_g8TGJF-BunpEBxxwzTu9w1Ppq3
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE0NCBTYWx0ZWRfXyZJkPJ9XqJ2q
 gEs8YRpGpQOmc80b/OE9SH/6mkYIaVl9wkkEf3Q7lX7ItWBhKEo0gJTNl/+rN9Vhbimf8PcBDpw
 S0EQL/X7W5Nf5ujQF1yLmy4uw9RoW4Y=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a722a59 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=h7u5zJOLz3W6SXC_pSsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE0NCBTYWx0ZWRfXx1d7AnOMSyVN
 byM5fc32iWopzasc2gQB20mWLiwdHQOyiJXFfUJA5Qwm/v0ScvqxkC72DAgBJai94qMK6zJk0m7
 PgNKyEkWwEXkPPzs8JwxVWtOHSGbD6kx44mt61wmyKeuE8ma/t4nK18m/09z9pkPN3eHd5mID/H
 fLP8c/f762Wky4N91m+32kUJNZNPEr5iGRVdvrd8xv9dIalyQOK8YIQgJZ9JkmJ+GtD8FEtu+hD
 Ylf0Xghj/SKmUV15uDI8BFNZf/RtwLUfYdJ9BcMjXw4KexKMBgnaLkHJBFjCMOkDgLn56/nyZ+b
 y62NUwYy+e9tjG+UgKw1kmaUemobr6FWZMOVAdqv+rd9Dito9wIc7EpjZlxSorM0k6MrJvE6eMg
 EXAL8+zEXPIagUHzkp9XNtao8aua4qGnD6TuLf7dFG7ROmZLpOAjGo09uXd4POFcCdCVYRI4Zbs
 Emzuha/H6HOcItMn3RQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040144

On POWER systems, newer processor generations can operate in compatibility
modes corresponding to earlier generations (e.g., a Power11 system running
in Power10 compatibility mode). In such cases, the effective CPU level
exposed to guests differs from the physical processor generation.

This creates a problem for nested virtualization. When booting a nested KVM
guest (L2) inside a host KVM guest (L1) running in a compatibility mode,
userspace (e.g., QEMU) may derive the CPU model from the raw hardware PVR
and attempt to configure the nested guest accordingly. However, the L1
partition is constrained by the compatibility level negotiated with the
hypervisor (L0), and requests exceeding that level are rejected, leading to
guest boot failures such as:

  KVM-NESTEDv2: couldn't set guest wide elements

This series provides a mechanism for userspace to query the effective CPU
compatibility modes supported by the host, so it can select an appropriate
CPU model for nested guests.

To achieve this, the series introduces a new KVM capability and ioctl
(KVM_CAP_PPC_COMPAT_CAPS / KVM_PPC_GET_COMPAT_CAPS) that expose the
compatibility modes supported by the host.

Why a new UAPI?
===============
While cpu-version is available in /proc/device-tree/cpus/<cpu#>/cpu-version
on both L1 booted on PowerNV and PowerVM LPARs, the UAPI approach is
preferable for several reasons:

1. pHYP (L0) capabilities: On PowerVM, we need to rely on capabilities
   negotiated with pHYP in KVM, not just device tree properties. The
   cpu-version property depicts the current compat mode but doesn't point
   to what all compat modes are supported for the nested guest.

2. procfs dependency: Not all systems run with procfs enabled (CONFIG_PROC_FS
   is optional). Minimal configurations like buildroot might disable it, but
   KVM ioctl works regardless since it accesses kernel data structures
   directly.

3. Kernel validation: The kernel validates and normalizes the compatibility
   information, ensuring userspace gets validated, consistent data.

4. Abstraction & stability: /proc/device-tree is an implementation detail.
   The UAPI provides a stable interface that won't break if the underlying
   mechanism changes.

5. Semantic clarity: KVM_PPC_GET_COMPAT_CAPS clearly expresses what
   compatibility modes can be used for KVM guests, vs. parsing device tree
   which requires understanding the semantic meaning of cpu-version.

The implementation supports both:

  - KVM on PowerVM (nested API v2), where compatibility information is
    served from the cached nested_capabilities value, originally obtained
    via the H_GUEST_GET_CAPABILITIES hypercall at module init.
  - KVM on PowerNV (nested API v1), where compatibility is derived from the
    device tree ("cpu-version") representing the effective processor
    compatibility level.

This allows userspace (e.g., QEMU) to select a CPU model consistent with
the host compatibility mode, avoiding mismatches and enabling successful
nested guest boot.

Note: This series is built on top of patch [1] which must be applied first.
Patch [1] ensures arch_compat is validated against the host compatibility
mode before this series adds the capability query mechanism.
Commit e4de1b9cb3b5 ("powerpc/dt_cpu_ftrs: Set CPU_FTR_P11_PVR for Power11
and later processors") which was also a prerequisite has been merged upstream.

Changes in v6:
  - Changed KVM_PPC_GET_COMPAT_CAPS ioctl number from 0xe4 to 0xb8 to
    avoid placing it in the KVM_CREATE_DEVICE fd ioctl range (0xe0-0xe3);
    relocated definition to sit alongside other PPC vm ioctls (patch 1)
    - [Gautam]
  - kvmppc_map_compat_capabilities(): changed parameter type from
    'const __be32' to 'u32' to fix Sparse type annotation warning (patch 3)
    - [Sashiko]
  - kvmppc_get_compat_caps(): replaced of_get_property() + be32_to_cpup()
    with of_property_read_u32() for implicit length validation and cleaner
    endianness handling (patch 3) - [Sashiko]
  - Documentation: corrected :Parameters: from (out) to (in/out) since
    userspace must set size and flags before calling (patch 4) - [Sashiko]

Patch summary:
  [1/4] Introduce KVM_CAP_PPC_COMPAT_CAPS and wire up ioctl
  [2/4] Implement capability retrieval for KVM on PowerVM (API v2)
  [3/4] Add KVM on PowerNV support (API v1)
  [4/4] Document the new ioctl

Testing (with QEMU v4 patches and on top of patch [1]):

KVM APIv1 Testing
=================
  On P10 PowerNV machine (L0)
  ---------------------------
    - P10 L1 KVM guest -> works
      - P10 nested L2 KVM guest -> works
      - P9 compat nested L2 KVM guest -> works
    - P9 compat L1 KVM guest -> works
      - P9 nested L2 KVM guest -> works

  On Powernv11 TCG Guest (L0)
  ---------------------------
    - P11 PowerNV TCG L0 guest -> works
    - P11 L1 KVM guest -> works
      - P11 L2 KVM guest -> works
    - P10 compat L1 KVM guest -> works
      - P10 L2 KVM guest -> works
    - P9  compat L1 KVM guest -> works
      - P9 L2 KVM guest -> works

KVM APIv2 Testing
=================
  On P11 PowerVM LPAR (L1)
  ------------------------
    - P11 L2 KVM guest -> works
    - P10 compat L2 KVM guest -> works
    - P9 compat L2 KVM guest fails to boot as expected
    - Without QEMU patches but Linux patches
      - P11 L2 KVM guest -> works
      - P10 compat L2 KVM guest -> works
      - P9 compat L2 KVM guest fails to boot as expected
    - Without Linux patches but QEMU patches
      - P11 L2 KVM guest -> works
      - P10 compat L2 KVM guest -> works

  On P11 LPAR in P10 compat (L1)
  ------------------------------
    - P10 (host compat) L2 KVM guest -> works
    - Without QEMU patch but Linux patches
      - P10 guest fails to boot as expected (error: kvm run failed Invalid argument)
    - Without Linux patch but QEMU patches
      - P10 guest fails to boot as expected (KVM: unknown exit, hardware reason ffffffffffffffea)

  On P10 PowerVM LPAR (L1)
  ------------------------
    - P10 L2 KVM guest -> works
    - P9 compat L2 KVM guest fails to boot as expected

TCG pSeries Guest
=================
    - P11 (default) pSeries guest boots fine

ABI Extensibility Testing (struct size 32, extra member)
=========================================================
    - Newer struct on QEMU, older kernel -> works (kernel returns -E2BIG,
      QEMU retries with correct size)
    - New struct on Linux kernel, older QEMU -> works (kernel zero-pads
      trailing fields, QEMU gets correct data)

With this series, nested guests boot successfully in configurations where
they previously failed due to compatibility mismatches.

Related QEMU series:
====================
A corresponding QEMU v5 series will be sent soon.

Previous QEMU versions:
v4: https://lore.kernel.org/all/20260701052341.62289-1-amachhiw@linux.ibm.com/
v3: https://lore.kernel.org/all/20260616113915.25589-1-amachhiw@linux.ibm.com/
v2: https://lore.kernel.org/all/20260502140021.69712-1-amachhiw@linux.ibm.com/
v1: https://lore.kernel.org/all/20260430061333.37905-1-amachhiw@linux.ibm.com/

Previous versions:
==================
v5: https://lore.kernel.org/linuxppc-dev/20260701051409.51820-1-amachhiw@linux.ibm.com/
v4: https://lore.kernel.org/linuxppc-dev/20260616123314.82721-1-amachhiw@linux.ibm.com/
v3: https://lore.kernel.org/linuxppc-dev/20260522152744.55251-1-amachhiw@linux.ibm.com/
v2: https://lore.kernel.org/linuxppc-dev/20260513100755.83195-1-amachhiw@linux.ibm.com/
v1: https://lore.kernel.org/linuxppc-dev/20260430054906.94431-1-amachhiw@linux.ibm.com/

References:
===========
[1] https://lore.kernel.org/all/20260714175432.86388-1-amachhiw@linux.ibm.com/

Amit Machhiwal (4):
  KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and wire up ioctl
  KVM: PPC: Book3S HV: Implement compat CPU capability retrieval for KVM
    on PowerVM
  KVM: PPC: Book3S HV: Add support for compat CPU capabilities for KVM
    on PowerNV
  KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl

 Documentation/virt/kvm/api.rst      | 79 +++++++++++++++++++++++++++++
 arch/powerpc/include/asm/kvm_ppc.h  |  1 +
 arch/powerpc/include/uapi/asm/kvm.h | 18 +++++++
 arch/powerpc/kvm/book3s_hv.c        | 56 ++++++++++++++++++++
 arch/powerpc/kvm/powerpc.c          | 71 ++++++++++++++++++++++++++
 include/uapi/linux/kvm.h            |  3 ++
 6 files changed, 228 insertions(+)


base-commit: 848acc8ffe1b7cd5f1bf427b93069becfebc2c9d
prerequisite-patch-id: 7755786f0e4f415e47065ff1972765008727fe10
-- 
2.50.1 (Apple Git-155)


