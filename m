Return-Path: <linuxppc-dev+bounces-25610-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B728C2A09B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 17:25:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGrcx4t8gz3c7H;
	Sat, 08 Aug 2026 03:25:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786123505;
	cv=none; b=DYcsy+JLAZPyu5SZCz5GMxckShLOHzw0TJV6O1Ei+VfMMKW/itFZXueIvflRElll0xDm7Y9SQhpuj4HylqLjrfMsDxmVoE4+11qkAqKZxj/wtvgyAhp3p/LnvuiPETr1W1O/qxxJn1Phlvh2sk8hMSFD7p0XFXR9h9RHMjBKC+Fo00tMfOaFB5Eb7Rm86Jt2AcWCIBUfoDlPNYPQ7LK/rZa/XiEkFFB9FFnj/MXzItydrCRFGtHoZycaVK9BRm08jaYp/gnLC5Q1/ds79NzvwJTJEtoQmWIL6vuPDqgpFkl7SqKqDHgJQnWWx/xo/EtHie24mC9NXGcsUgPWqjAkjg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786123505; c=relaxed/relaxed;
	bh=6zXcROzwnPwPNTPbSGxkyl3EGFh9uFhqtCcqOGeviVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lNDxLgvQD297Snx3Ilk6dl/Ke5Sol2eBNkcTYwVnZMD83HYmgHN+V/e68skrU3Vatc73xrLHyICC6r4Zs/iXOfwwt6fNx/8l3MJ14XDOpuYEeoFJ7ToJotBkzoCSZEG1HpHpdy7lMPf7Wh888pu4bDZHFAYdbJev6uP5JWisVo4Fogyjm89opwQXQmM0C7MDdX568PyxovGXBGazKQjJB/WVOi7y5mMv52sVCCYDsRtbeHKzfNHlU/NlbyHBq9j3uFDXDWYedK1l6+9uWHqOBofx4Ng2Do4+M2CYrni0vUPi9S2ccReWBGeEh7709Y1WC7KHgGD5c7b+F5eJ9rda1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PMox8cLq; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PMox8cLq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGrcw65nVz3c6f
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Aug 2026 03:25:04 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677GlWoi2000828;
	Fri, 7 Aug 2026 17:24:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=6zXcROzwnPwPNTPbSGxkyl3EGFh9uFhqtCcqOGevi
	Vc=; b=PMox8cLqAPVJwVRiBATYaZYQWXOdqyfNXCTmKmcI8tEnRb6oZlmqb/3uf
	NDsWqYF43eN4eGnZSM7zWwzUMGm5stHPhh03xqOZfXOHS5s5KFAFuD9lXELoK6wJ
	7FB8emE7nuF2MuoXvJnREHRyhfwRDMVmHobhcI9xHiRQLwD7OhAH7CAP/rX60zvY
	E/nX6kuN/eBJGPPHidFpa9yswXkniyA8aNsD1TyeZKA1f35ADSGKjQ1J3gfV3rky
	EnbWrNZnECUvLXe8c4QOuyAURkXRweDe7C0UBxKWddNnayGPZKgo9L86QovshKPv
	RKArwbJQEJJzK0LKVDH8j+BLS5sZg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy0453a6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 17:24:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677HBIYM013485;
	Fri, 7 Aug 2026 17:24:46 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswu00e3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 17:24:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677HOgVN38469968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 17:24:42 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 375F620043;
	Fri,  7 Aug 2026 17:24:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B5A720040;
	Fri,  7 Aug 2026 17:24:38 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.216.72])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 17:24:38 +0000 (GMT)
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
Subject: [PATCH v8 0/4] KVM: PPC: Expose CPU compatibility modes for nested guests
Date: Fri,  7 Aug 2026 22:54:29 +0530
Message-ID: <20260807172433.82045-1-amachhiw@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEzNSBTYWx0ZWRfX1jDcFaET/iGx
 GD26NqgO0S/My8eWJ+e/Lo00PUjQXyO85afStQVxat/FzYIY7UtmL993ZLXo+uYeDHzh9qFW+tL
 AzexsK5MtyZffSn6l0i7xzuDppJlz3Y2nrdunvV6bYeNrbNjv2oMKrJWa2rIhbQxl1lfE0rXSxZ
 3b299FpiZSdx+9uZYGqkrFC8P4VH9V71WH8bI48Zg+D5v1aC8MFXh96P0jiSMNjwiLFh0PCU79S
 I+eHUZZZ7YoGLca3vtYIIqy56iEz/83imAFHQ8Shx8XRCHzw5pFLbajgHUZlkRnaL2mSxt//JbK
 1wHOR92yzwUZNqoPxAkbksSTDpJckldgGc1ZDxLIptBH8mpkN/QBlFMQL6duCKsx2TfGGMzfevn
 D3CA2axrF1Adz7iZMrhd6tp5BaResQtAcMkJDXPO7U4ap0pYmrdT8mcy6oX6CxDDeboRiwMdjLY
 JjBlZS5bYMVSGVdq3cg==
X-Proofpoint-ORIG-GUID: 75o5t-FBHQuXH7CaBpL_lBEwvwmXAORk
X-Proofpoint-GUID: jRMFwv4TaiYrO9vTtrGRBdEi3Fx3mliT
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEzNSBTYWx0ZWRfX3XkNQ1j/4xFA
 TugffiAPdQa3mwRWJ0+ubIR4ytaC90r90r2ejSYFomsSb3B7pAU/lFjqfYeU+BYFlbE1A5BRURt
 M3LyK33Mh4JbdG6Z5PLHGgcnTEpSSPY=
X-Authority-Analysis: v=2.4 cv=WLpPmHsR c=1 sm=1 tr=0 ts=6a7614df cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=h7u5zJOLz3W6SXC_pSsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070135

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

Changes in v8:
 - Add PAGE_SIZE guard after get_user() to bound the check_zeroed_user()
   scan in the usize > ksize path [Ritesh]
 - Drop the manual usize > sizeof(host_caps) pre-check; delegate the
   usize > ksize path entirely to copy_struct_from_user(), which succeeds
   when trailing bytes are zero (valid forward-compat) and returns -E2BIG
   only when they are non-zero. Handle -E2BIG by writing back ksize with
   proper -EFAULT escalation if put_user() fails. [Ritesh]
 - Fix host_caps.size writeback on success path: use
   min_t(u64, usize, sizeof(host_caps)) instead of sizeof(host_caps) to
   avoid reporting a larger size than the kernel actually populated when
   new userspace passes a larger struct with zero trailing bytes. [Ritesh]
 - Update documentation to reflect the corrected three-case versioning
   contract and the revised E2BIG semantics. [Ritesh]

Patch summary:
  [1/4] Introduce KVM_CAP_PPC_COMPAT_CAPS and wire up ioctl
  [2/4] Implement capability retrieval for KVM on PowerVM (API v2)
  [3/4] Add KVM on PowerNV support (API v1)
  [4/4] Document the new ioctl

Testing (with QEMU v5 patches and on top of patch [1]):

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
QEMU v5 series:
https://lore.kernel.org/all/20260804182914.83091-1-amachhiw@linux.ibm.com/

Previous QEMU versions:
v4: https://lore.kernel.org/all/20260701052341.62289-1-amachhiw@linux.ibm.com/
v3: https://lore.kernel.org/all/20260616113915.25589-1-amachhiw@linux.ibm.com/
v2: https://lore.kernel.org/all/20260502140021.69712-1-amachhiw@linux.ibm.com/
v1: https://lore.kernel.org/all/20260430061333.37905-1-amachhiw@linux.ibm.com/

Previous versions:
==================
v7: https://lore.kernel.org/linuxppc-dev/20260806170645.11892-1-amachhiw@linux.ibm.com/
v6: https://lore.kernel.org/linuxppc-dev/20260804180705.59160-1-amachhiw@linux.ibm.com/
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

 Documentation/virt/kvm/api.rst      | 89 +++++++++++++++++++++++++++++
 arch/powerpc/include/asm/kvm_ppc.h  |  1 +
 arch/powerpc/include/uapi/asm/kvm.h | 18 ++++++
 arch/powerpc/kvm/book3s_hv.c        | 56 ++++++++++++++++++
 arch/powerpc/kvm/powerpc.c          | 78 +++++++++++++++++++++++++
 include/uapi/linux/kvm.h            |  3 +
 6 files changed, 245 insertions(+)


base-commit: f9a2394a23482bfd330911e9c8295b71724feacd
prerequisite-patch-id: 7755786f0e4f415e47065ff1972765008727fe10
-- 
2.50.1 (Apple Git-155)


