Return-Path: <linuxppc-dev+bounces-23242-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3658CC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 05:14:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqp9D4qRFz2yQL;
	Wed, 01 Jul 2026 15:14:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782882880;
	cv=none; b=dn7GC5i1aZoI1dk1Ad7mDVb3nwM5fQP6I0FUDvHGkljGftlSohYwc9H1brR6yGICdvMYF0Z6IbUA2oz/yBTSDgevNpAnHyQcFK7ElPxQIyvshRl6cRNekR7WmwITgjB4uDidpxeHvkv7IINsjKd8alw2TbO1FhvbI6fiWJ4W4/WbQ5Ia+ybGseA31E2vIalJYpGhnnP6nlqhLAKBvO3tajXH7cGBb0b4flMdFv8fOPQ+k+PMyPuLHRboE/CfNq0so2wmDxQjNIdGwihSZjgoorg/J8NTri37xb8InllT7a1D33qjUsIiYsEIt92v7NpgN9hPOpWxJAogzjq2w88zIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782882880; c=relaxed/relaxed;
	bh=S5e8R5eD8N7+GbmnMHJFifr7jA0SVD038k9b5/0AZFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qu+d+8i6qrJwMF+3EotSgH6d+0Q9oFeqeiqI9aMZiDeSsA0JqQpY58WDCTVou0xB5PFAQotCLPP6S9qG3Q7sbOUummLGHZ+W5JcrRbSn4bKlkzYynCE5RQfJxtJ5YT8+4ANbYjtT9MTexR94/5iRElmNWmJ9P25cmbEMP1Byoy4RcS5tO3api6A01KNiNU2/Tv+W///jm6490b/gMuyaMfQzxMhnFyKic6GS36d/xMQ2c7fmes4D1hHqQ5sLH5by/FUHx0gS8+gGoylQuKzRUuf4Ij3GkhRrwM18/zd2sUQfg9T6yeR8j5Un4WMzMDpn/mv3BLkW/z0X5JcEJ2PIJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RWQlsccL; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RWQlsccL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqp9C2Cvwz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 15:14:38 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6613ICZj4061354;
	Wed, 1 Jul 2026 05:14:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=S5e8R5eD8N7+GbmnMHJFifr7jA0SVD038k9b5/0AZ
	Fo=; b=RWQlsccLw+tW2X18Vnp0f5fVho3wiXaxWM6RAuyCZ3fgOJm6AtEYTEoZ9
	iffIDXslF08GAgF3UXMWFEusxz1XU8cniX2lQQ93q+f/IuVpOawMJ3wUI9vvthdX
	q6IxRDryczbrvEduH/euEGwBSafbMi6UhDBqTXP0D4wHa+afb/oyTalHPYV10Jhu
	MbE4IOX8FypWTJHuve8CeVFdt7XnOo1dwDd+8nSzm/MXzvJ8BezXXnQHbtLAOYbK
	RfftU+akwDkTCu/opxWsYujMkYCpccRcskkKUNvr3xbI+jecb244Yky6Iy+Ftf4P
	mMk9B0Js2F2gwINoCzVjXYX30SpRg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qg2ke0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 05:14:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66154cNa004868;
	Wed, 1 Jul 2026 05:14:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhdnxs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 05:14:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6615EMAV30474786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 05:14:22 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F53720049;
	Wed,  1 Jul 2026 05:14:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A3ED20040;
	Wed,  1 Jul 2026 05:14:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.211.190])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 05:14:18 +0000 (GMT)
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
Subject: [PATCH v5 0/4] KVM: PPC: Expose CPU compatibility modes for nested guests
Date: Wed,  1 Jul 2026 10:44:05 +0530
Message-ID: <20260701051409.51820-1-amachhiw@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a44a234 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=s5-7cpnY7qlMe_O-y8EA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA0NiBTYWx0ZWRfX61wf++2t63ms
 RVACXXR5VWmXDYV3+3I3Ot8i8P92IlaPxsyEK45XQUeUFWqDYbUMJUgkXBeFpKa9T1D8NTvfRiM
 ovPyq/qZ6IqkhJGhOmrqshvkR7963kU=
X-Proofpoint-GUID: 5PSovUEPhJhFQOmx0ipuWAt7OuW-dg0q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA0NiBTYWx0ZWRfX1Op9FaEOBraY
 f4dfobZkZrFi16F2rfR41FMraGSf+XMIr6EE/m7ocKlu4abhmNDuTpOGq7jovebmS4KHdSwEWZF
 B1vv9qgs7xVVZ8oAN6SAWLLub1WNWwsyI4nbkmxo89+kiNluH6nI4tJENsCP+74zXmqzqoKTGJg
 8CFxpJAXYFsNscif4AdtYINRR/AfzvcNYAqjhwro7sEohb3JZeN4krbkcyQq4pZ/XQjOEzoHKw1
 3nUS51mjleVN9YMF4zp1aU5M1ujN4DvbXMM74Q5K9QtJXDE2Pcqac5jvpN5OqQlldU96U89g5cm
 TBMsrroJ8uoFFg1/x1w0bpre6AIqXHrvHL+ixmv5IxxFvY2mEQoZKHSI76rceFyvpfBVjnYpi4m
 6UJeZgkcFsn5yPfcq+jD7pVl/6FSdbq0BrfOZ8CU+UxgiZrmx5QES0MeK6ojhS9RfKkKm99+7y7
 ZhhOXdxqlTlfvE5HtNg==
X-Proofpoint-ORIG-GUID: hUJFSkNsPuCnxgqGumWyJ_lhY_ZAIIJ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010046

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

Note: This series is built on top of patches [1] and [2] which must be
applied first. Patch [1] ensures arch_compat is validated against the host
compatibility mode before this series adds the capability query mechanism.
Patch [2] sets CPU_FTR_P11_PVR for Power11 and later processors, which is
needed for proper CPU feature detection in dt-cpu-ftrs environments.

Changes in v5:
  - Moved 'size' to be the first member of struct kvm_ppc_compat_caps;
    replaced strict size equality with copy_struct_from_user/to_user for
    proper forward and backward ABI compatibility; added
    KVM_PPC_COMPAT_CAPS_SIZE_VER0 as a frozen version floor constant and
    flags == 0 enforcement to prevent ABI ambiguity (patch 1) - [Vaibhav,
    Amit]
  - Updated PowerVM implementation to use cached nested_capabilities
    instead of a live H_GUEST_GET_CAPABILITIES hcall; added a
    WARN_ON_ONCE(!nested_capabilities) sanity check (patch 2) - [Vaibhav,
    Amit]
  - Converted switch in kvmppc_map_compat_capabilities() to use fallthrough
    for cumulative compat mode reporting; added of_node_put() in
    for_each_node_by_type() to fix OF node reference leak; check 'rc'
    error before assigning capabilities (patch 3) - [Vaibhav, Harsh]
  - Updated documentation to reflect extensibility model, added E2BIG
    error (patch 4) - [Amit]

Changes in v4:
  - Added 'size' field to struct kvm_ppc_compat_caps for forward
    compatibility and ABI extensibility
  - Implemented size validation in ioctl handler to ensure correct structure
    size from userspace
  - Introduced KVM-specific capability constants (KVM_PPC_COMPAT_CAP_POWER9/
    10/11) instead of exposing hypervisor-internal H_GUEST_CAP_* constants
  - Added capability masking using KVM_PPC_COMPAT_BITMASK to ensure only
    supported processor modes are exposed
  - Enhanced error handling with comprehensive error codes (EINVAL, EFAULT,
    ENOTTY) and detailed documentation
  - Removed Tested-by tags pending re-testing with v4 changes
  - Separated validation patch (patch 1 from v3) and sent independently [1]

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
  [1/4] Introduce KVM_CAP_PPC_COMPAT_CAPS and wire up ioctl
  [2/4] Implement capability retrieval for KVM on PowerVM (API v2)
  [3/4] Add KVM on PowerNV support (API v1)
  [4/4] Document the new ioctl

Testing (with QEMU v4 patches and on top of patches [1] and [2]):

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
A corresponding QEMU v4 series will be sent soon.

Previous QEMU versions:
v3: https://lore.kernel.org/all/20260616113915.25589-1-amachhiw@linux.ibm.com/
v2: https://lore.kernel.org/all/20260502140021.69712-1-amachhiw@linux.ibm.com/
v1: https://lore.kernel.org/all/20260430061333.37905-1-amachhiw@linux.ibm.com/

Previous versions:
==================
v4: https://lore.kernel.org/linuxppc-dev/20260616123314.82721-1-amachhiw@linux.ibm.com/
v3: https://lore.kernel.org/linuxppc-dev/20260522152744.55251-1-amachhiw@linux.ibm.com/
v2: https://lore.kernel.org/linuxppc-dev/20260513100755.83195-1-amachhiw@linux.ibm.com/
v1: https://lore.kernel.org/linuxppc-dev/20260430054906.94431-1-amachhiw@linux.ibm.com/

References:
===========
[1] https://lore.kernel.org/all/20260609053327.61563-1-amachhiw@linux.ibm.com/
[2] https://lore.kernel.org/all/20260614173437.26352-1-amachhiw@linux.ibm.com/

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
 arch/powerpc/kvm/book3s_hv.c        | 58 +++++++++++++++++++++
 arch/powerpc/kvm/powerpc.c          | 71 ++++++++++++++++++++++++++
 include/uapi/linux/kvm.h            |  4 ++
 6 files changed, 231 insertions(+)


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
prerequisite-patch-id: e328a3183c9e9499436c666c30f3659c44e6f3a2
prerequisite-patch-id: 4662f01d2101cfae8502f04290658deed60eec26
-- 
2.50.1 (Apple Git-155)


