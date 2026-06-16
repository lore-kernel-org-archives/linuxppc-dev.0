Return-Path: <linuxppc-dev+bounces-22701-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DE3CD98E6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2026 12:34:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfmf94kpvz3brH;
	Tue, 16 Jun 2026 22:34:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781613297;
	cv=none; b=HlO0JPZidRzIOmErJ97rn+3EXF1+9dQXWn7qPabtTg31EImbl6Q8guB3kHQKfigSX8h5QZkJ17ReIPNMQL3usdJ7eFOWds6YFEFhDU2t4zipDJ6SCDx1js3Llgnw2qsBITbPknJbtas6WWW4ag45jjD5e64gUvTsGtAuQ7+YpTC9lzYjXNanf2xKcoJll7rh59ckhprmZG7xfuLzFeEMEd/weYrtOac6o3Q4K/gi+7TLThdXEKdsiIkIXI53SSUV5+9cZuPr+fcFv6TEhx7wfte6PZ3s7dpNPO2+NnwZ7sAU7avix6K3HEXPlVElJ4ZY6sc48GAH10nGLorxv2mOyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781613297; c=relaxed/relaxed;
	bh=5pyvMbbO/zVcdUIua1Suq6SmgFWRdBdBU1ZTsdC+p6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AcHxw2n5SJz0Un1zZr9gcD8dxjeuJER+RlEanLZpmjBFhIDEjzehrmjSQNnTLvT8kpXCz0y4Vajr7yyGcXj4ZSDzsjNA0FWzJvmMeKa4PeaBJPH9zAvSVQSU3qlontRopYzNJCamuGMy8Lt7TeliAh0EYhIRDIv0Ot1fA9FRI//XEscN2o9jLNY7JiTrOkQJKrofWDxLZRgdBrNyKnvR1n5MUWdkW0C3Z+fyf2NoAENWcNfzhZp+q9EBq+TTVua34ycAIxR88KTrPIlstZPfimgippUaLYtUQ9TSTkVufmIpuN7pICBufVK57BYE7WG1yJpw9kI7f4mrEEkD+FAm6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=baBknnLl; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=baBknnLl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfmf859x1z3bqh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 22:34:56 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GAILT81396038;
	Tue, 16 Jun 2026 12:34:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=5pyvMbbO/zVcdUIua1Suq6SmgFWRdBdBU1ZTsdC+p
	6c=; b=baBknnLl2bbSYOivw3PEosd30ZiAagLD7L7Lljw5IwY2yFCpJMe1Khlny
	8rVhkW+yhfAsb91+qFdOBmVlm2mrd/smQdN7PiLOOLPGVpaeauc8dLcbcQICYhAW
	b3mg9womaV4gKkddOpg1LdDPEKr8yZgoB9w3Xg/03xfcQYrhZNdWmlbGlawvZr7Q
	mKMcAqDgrhIqgYMbuq5JEA4l40wdE0E0GqtaJ6HY4Z7RsTUAYz04puPN8irfFy6l
	wQStTg9JjEoHShdWfdc4WQVTMZ0TMorfKAS7yQ0IeTjgo9gp/FE2QXTT/D1Y9mZm
	48tKKzwpjs27DxdfmApFrjALSKPgw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1h85nun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 12:34:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GCYiuB022466;
	Tue, 16 Jun 2026 12:34:44 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4esm7y326e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 12:34:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65GCYeEL58130798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 12:34:40 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6000E2004D;
	Tue, 16 Jun 2026 12:34:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A681D20049;
	Tue, 16 Jun 2026 12:34:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.31.150])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jun 2026 12:34:36 +0000 (GMT)
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
Subject: [PATCH v4 0/4] KVM: PPC: Expose CPU compatibility modes for nested guests
Date: Tue, 16 Jun 2026 18:03:10 +0530
Message-ID: <20260616123314.82721-1-amachhiw@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDEyNSBTYWx0ZWRfX2T6x9XF4jLcu
 7Afsy3NDxr8D/foySUjwUeoedYRcBMxgWQa/gSYgub0qxJHMWwEW+iJS7UmpHMGb7VfeBTysL1C
 JFP3gKTmrRdVKoo3SkzUdCSO2ubmfV8=
X-Proofpoint-ORIG-GUID: yr4qgDg3lwo4MpYrVixyRYeeJDDzfiM1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDEyNSBTYWx0ZWRfXwl2pP5wfTYu2
 Kgot+1vFx0RFTYks04tAtXbYUOpupSu7hIfxiUuE0hZ+vnbMQq7EqtEmrvKb2ofYIVDPZx+QnlX
 bL/Br83DyUGS23yUgwcKUIJj+HkEhlfbFJqrTjc4WcFFX+kSjglvnV+VmHJTy3gnN594NKWA7B2
 blOPtixvpFKwXXRYbtiKS2M2X0gJrLjjBRDDvgE4JmxmgctGEMOJFGF8Yz6o1iqsNhaZdRWlBcG
 nUsVdPbqSbVVM0Gp+BFTLrKJk3oFAmIaIoBN5c7zLq2BULFMbjgCt8gak8AjTmViTnEPOaz16UX
 X5yakKKVrOqSa+8bUHA2+meQ6JcMFzJiOAfk9ZdmGaO39GDk6tbTJ9tXXkz7pqY7bOR0dyu7UXl
 UieUriusKNuaT1tFMb92nhpbhrvwGU4My3pGCpPz/3IpCof8ILw2T+6PQQj1XnBLd54a9xy4GXh
 jNCgsga5IdweB9+eMFw==
X-Authority-Analysis: v=2.4 cv=U9uiy+ru c=1 sm=1 tr=0 ts=6a3142e5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=h7u5zJOLz3W6SXC_pSsA:9
X-Proofpoint-GUID: rxoX_yvF6DpIybin5nfvRW1acZiaCy5I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160125

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
   information, ensuring userspace gets validated, consistent data.

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

Note: This series is built on top of patches [1] and [2] which must be
applied first. Patch [1] ensures arch_compat is validated against the host
compatibility mode before this series adds the capability query mechanism.
Patch [2] sets CPU_FTR_P11_PVR for Power11 and later processors, which is
needed for proper CPU feature detection in dt-cpu-ftrs environments.

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
  [2/4] Implement capability retrieval for PowerVM (API v2)
  [3/4] Add PowerNV support (API v1)
  [4/4] Document the new ioctl

Testing (with QEMU v3 patches and on top of patches [1] and [2]):

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
  
  On P11 LPAR in P10 compat (L1)
  ------------------------------
    - P10 (host compat) L2 KVM guest -> works

  On P10 PowerVM LPAR (L1)
  ------------------------
    - P10 L2 KVM guest -> works

With this series, nested guests boot successfully in configurations where
they previously failed due to compatibility mismatches.

Related QEMU series:
--------------------
A corresponding QEMU v3 series adds support for querying and using these
compatibility capabilities when configuring nested KVM guests:

v3: https://lore.kernel.org/all/20260616113915.25589-1-amachhiw@linux.ibm.com/
v2: https://lore.kernel.org/all/20260502140021.69712-1-amachhiw@linux.ibm.com/
v1: https://lore.kernel.org/all/20260430061333.37905-1-amachhiw@linux.ibm.com/

Previous versions:
------------------
v3: https://lore.kernel.org/linuxppc-dev/20260522152744.55251-1-amachhiw@linux.ibm.com/
v2: https://lore.kernel.org/linuxppc-dev/20260513100755.83215-1-amachhiw@linux.ibm.com/
v1: https://lore.kernel.org/linuxppc-dev/20260430054906.94431-1-amachhiw@linux.ibm.com/

References:
-----------
[1] https://lore.kernel.org/all/20260609053327.61563-1-amachhiw@linux.ibm.com/
[2] https://lore.kernel.org/all/20260614173437.26352-1-amachhiw@linux.ibm.com/

Amit Machhiwal (4):
  KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and wire up ioctl
  KVM: PPC: Book3S HV: Implement compat CPU capability retrieval for KVM
    on PowerVM
  KVM: PPC: Book3S HV: Add support for compat CPU capabilities for KVM
    on PowerNV
  KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl

 Documentation/virt/kvm/api.rst      | 47 ++++++++++++++++++++++++++
 arch/powerpc/include/asm/kvm_ppc.h  |  1 +
 arch/powerpc/include/uapi/asm/kvm.h | 16 +++++++++
 arch/powerpc/kvm/book3s_hv.c        | 52 +++++++++++++++++++++++++++++
 arch/powerpc/kvm/powerpc.c          | 35 +++++++++++++++++++
 include/uapi/linux/kvm.h            |  4 +++
 6 files changed, 155 insertions(+)


base-commit: 8b308f96484e37d92d2fc6b72b091f60496c000e
prerequisite-patch-id: ce9521668d549f2bd731d321a38f720b789e0b4e
prerequisite-patch-id: 4662f01d2101cfae8502f04290658deed60eec26
-- 
2.50.1 (Apple Git-155)


