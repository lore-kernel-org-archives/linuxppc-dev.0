Return-Path: <linuxppc-dev+bounces-21402-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF3DCD5BB3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 15:28:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMTgl1mtSz2xSN;
	Sat, 23 May 2026 01:28:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779463699;
	cv=none; b=nUkt92A7hfjrtoq1O46pAsTcuztRNZKAVsFJFUTjh4k827XEoxXB4HcdehFZM5WiQ6cXSg9SGUxhaZsG/xwhwy1YaV9vT+IOD6OVt2pcXA7hz+/7fWD/7meZJnrlWcYAkNTZ05RSG2BDonZ5z5YiQr7e9nwen78EpKZJSz40Dk5qXAc3OK/JJl3WKmvFNSFvF/CyOA0dIilRyVU0pKv7c6aA3zIRT9Y+lECXa2v3XccLZnjDN6/A2HilZKM5hXDoLh+OBOQaBC8UgxB7k+Uf95MfbslZ0LSW74+qHh6cqBT+8aplULqBpdwP6KSgPw3+z5uSVNk0Wu7YerSvpyzSQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779463699; c=relaxed/relaxed;
	bh=rMrxGouPSv/RreY0Aq+Pr4WXmG770mQeP5vSZQlFE1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GLHLqCqL1krN5JuVeSUh64kqEgN71+jeB/4/pAL2JiuWUr0wKwMaLvLLVShdavh1sKGd2VtUGYHODSKrtk5yzXfr5zGpFc72RRB5IuOFdpzRDwRsUKq7/5pZ2/MHqqTXSEhRts7efHrWMXWU7SnbbZdV3S9NxmcTXQY1yqJxcucyx6ORGB79W33qYhHZ2P9UiVIkO/6NMV2xZA5xn9wUon/HzADcWNwFS1H0wf6cC1CyfOfXWbEInqeWU83xLGEvOVjw9QxTrxD4XqbQEuUp3lbnBSa64Rrl2rcea0X0AsmX1EXaoUmunkqdbSaa8XF53+gPvxucqINB736HUJPjXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ROYfWapt; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ROYfWapt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMTgk1B8wz2xK4
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 May 2026 01:28:17 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MEYxmc2191659;
	Fri, 22 May 2026 15:27:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=rMrxGouPSv/RreY0Aq+Pr4WXmG770mQeP5vSZQlFE
	1A=; b=ROYfWaptcTTaa6DH8qXsx/ilF9y0OxFZsmzIF53EzE15tlYLYEYC4EO8C
	FG+OstVtU5bULxrfhtfUNSaKlZTsfCM3Bcb7pvJVzvDPN/RO9ZbR8QkmuqXCQdxx
	tYgXo6KnB5dRgQJ/YqsKFjFngEi4C6ul2uuPKhtQpAtdvsYFxFWIF9iJyiJaLBlK
	fB9tONaiJtOmRX/KahTV3FfE3OejxzMJJCeBhxSsPsgYyEw4JLAjuRUEIDlEDT5y
	pqBBpnR/ueq7UPsiYIaHTBpPfQwnearqzwJlbyQ1bbPp+0rjwvU5suqyUyBNgQvR
	lZItyqvX/46INma76kMSmW2tO5mTg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hawk6td-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 15:27:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64MFO7lj013973;
	Fri, 22 May 2026 15:27:57 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75kyh5wx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 15:27:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64MFRraX23659004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 15:27:53 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 529212004B;
	Fri, 22 May 2026 15:27:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E313E20043;
	Fri, 22 May 2026 15:27:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.216.126])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 May 2026 15:27:49 +0000 (GMT)
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
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lkp@intel.com
Subject: [PATCH v3 0/5] KVM: PPC: Handle CPU compatibility mode for nested guests
Date: Fri, 22 May 2026 20:57:39 +0530
Message-ID: <20260522152744.55251-1-amachhiw@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE1MCBTYWx0ZWRfX4dQaiEJFMzwV
 Dr3Vm1pDwnJA4jaIA8CtSpq8uTbwRRa1iZBXTv2xggVWODP6fm/crVu3bVk9sef+6BRd9Dr0LTg
 Gdy6xk8pp85S5JiP72+ZNQ0YsCK494RRnh3+n+URtkk7bDNO3hsvZpdJ+KntLkNlJFyrBND8MG4
 pcVVlQdhZaed73wzI82DCi17lp30P8+cvlxrwT0DQjb70Tz/WotBkkRPg/kwiAibwg7D17kVWq9
 lR3LZ7qZa0VlWr6ozeDp6qzZArE2z9NbSG6RTL0cVj7R9lz1lWhSthgJSGNUfU+DXdNcBeUy7k4
 3rb0XmiGput7axMQBqs+zCnpJ8ChHELZoo79ZmK6DZfC5yHZWG3Jk/y6pcIUgzntjjiMckd82IZ
 5EsdvMH4ru/hA3uK7Czf40XDUP9DmCuVN7nQvqmBN7EnZmwVs8unSkZbTLI03/cFfnqJV4awaNl
 B4WQD9LCE8V5tRKgjog==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a1075fe cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=XsWQ994mRvDqN3FwEnAA:9
X-Proofpoint-ORIG-GUID: lxJtId-GrOVNYhhDbsrrvrB1xA96ZzBt
X-Proofpoint-GUID: SKu5a__dTSr5dQAhGxcMvxMyNk8g9BNq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220150

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

This series addresses the issue in two steps:

1. Detect and reject invalid compatibility requests early in KVM to avoid
   late failures.

2. Provide a mechanism for userspace to query the effective CPU
   compatibility modes supported by the host, so it can select an
   appropriate CPU model for nested guests.

To achieve this, the series introduces a new KVM capability and ioctl
(KVM_CAP_PPC_COMPAT_CAPS / KVM_PPC_GET_COMPAT_CAPS) that expose the
compatibility modes supported by the host.

Why a new UAPI?
---------------
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
   information. Patch 1 adds validation logic that rejects invalid
   compatibility requests early, ensuring userspace gets validated,
   consistent data.

4. Abstraction & stability: /proc/device-tree is an implementation detail.
   The UAPI provides a stable interface that won't break if the underlying
   mechanism changes.

5. Semantic clarity: KVM_PPC_GET_COMPAT_CAPS clearly expresses what
   compatibility modes can be used for KVM guests, vs. parsing device tree
   which requires understanding the semantic meaning of cpu-version.

The implementation supports both:

  - PowerVM (nested API v2), where compatibility information is obtained
    via the H_GUEST_GET_CAPABILITIES hypercall.
  - PowerNV (nested API v1), where compatibility is derived from the device
    tree ("cpu-version") representing the effective processor compatibility
    level.

This allows userspace (e.g., QEMU) to select a CPU model consistent with
the host compatibility mode, avoiding mismatches and enabling successful
nested guest boot.

Changes in v3:
  - Added "Why a new UAPI?" section to cover letter addressing questions
    about the need for a new UAPI vs. using existing mechanisms like
    /proc/device-tree
  - Fixed initialization of 'r' in KVM_PPC_GET_COMPAT_CAPS ioctl handler
    from 0 to -ENOTTY for proper error handling when the operation is not
    supported
  - Added Vaibhav's "Suggested-by" tags
  - Have retained Anushree's "Tested-by" tags as no major code changes
  - Fixed documentation build warning reported by kernel test robot and
    added "Reported-by" and "Closes" tags to patch 5

Changes in v2:
  - Squashed patches 2 and 3 from v1 (capability introduction and ioctl
    wiring) into a single patch for better logical grouping
  - Changed kvm_ppc_compat_caps.flags from __u32 to __u64 for consistency
    and future extensibility
  - Addressed other review comments
  - Improved commit messages with clearer explanations of the changes

Patch summary:
  [1/5] Validate arch_compat against host compatibility mode
  [2/5] Introduce KVM_CAP_PPC_COMPAT_CAPS and wire up ioctl
  [3/5] Implement capability retrieval for PowerVM (API v2)
  [4/5] Add PowerNV support (API v1)
  [5/5] Document the new ioctl

Tested on:
  - Power11 pSeries LPAR in Power10 compatibility mode (nested API v2)
  - Power10 PowerNV system (and QEMU TCG PowerNV 11) with nested
    virtualization (API v1) with various combinations of KVM L1/L2 guests
    in various supported compatibility modes.

With this series, nested guests boot successfully in configurations where
they previously failed due to compatibility mismatches.

Related QEMU series:
  A corresponding QEMU series adds support for querying and using these
  compatibility capabilities when configuring nested KVM guests:
  https://lore.kernel.org/all/20260502140021.69712-1-amachhiw@linux.ibm.com/

v2: https://lore.kernel.org/linuxppc-dev/20260513100755.83215-1-amachhiw@linux.ibm.com/
v1: https://lore.kernel.org/linuxppc-dev/20260430054906.94431-1-amachhiw@linux.ibm.com/

Amit Machhiwal (5):
  KVM: PPC: Book3S HV: Validate arch_compat against host compatibility
    mode
  KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and wire up ioctl
  KVM: PPC: Book3S HV: Implement compat CPU capability retrieval for KVM
    on PowerVM
  KVM: PPC: Book3S HV: Add support for compat CPU capabilities for KVM
    on PowerNV
  KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl

 Documentation/virt/kvm/api.rst      | 35 ++++++++++++++++
 arch/powerpc/include/asm/kvm_ppc.h  |  1 +
 arch/powerpc/include/uapi/asm/kvm.h |  6 +++
 arch/powerpc/kvm/book3s_hv.c        | 63 +++++++++++++++++++++++++++++
 arch/powerpc/kvm/powerpc.c          | 21 ++++++++++
 include/uapi/linux/kvm.h            |  4 ++
 6 files changed, 130 insertions(+)


base-commit: 1d5dcaa3bd65f2e8c9baa14a393d3a2dc5db7524
-- 
2.50.1 (Apple Git-155)

