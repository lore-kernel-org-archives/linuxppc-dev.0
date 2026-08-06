Return-Path: <linuxppc-dev+bounces-25498-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F6EC56208
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 17:07:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGDGx73WGz3bdq;
	Fri, 07 Aug 2026 03:07:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786036041;
	cv=none; b=THEwey5cVHcZf81z5yo1pPXZf7lC1rH37yUlr/TJezTr42+nsW6hi6IhkQJqTfV1nOPXm1Kq2QeVhMCikxMXI73b2hDZTzfrEAIoR7zTOovHaFXUBzJiQoxua1u27+pql8ULNhu+IbStNTqe9uzGfnqkGOzjqn5+wHrVXAjnCFutmBp/vG43oQvTyf0eq4gnN3+F4du2CV3isbaifM/8rMB6T3iHzkuT+0Kfk+vg7YR0Gj+ELAAQEYrNjI/pTw2v7rTVTu5ob/hTvRarXU1a6OF+qDegvkI+3/nhGiqkX2PsLIbrh/rE95gQkPT0TxdGsRDczCpPoI6/mCYkA98xRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786036041; c=relaxed/relaxed;
	bh=hZp7e7dIlQxUDnIW8kQff93JDHqedshCQ1iI7RADpG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l2zvlP5CCuDn1UejfBBrr6Z+jeCOORFCDm6EEmqqeX+nKaiWgv2ylBujdZP2ZfxK4SCpCoLSpYwDVQTdrUR/NpRLWvddn64J+5N73hg/0g7ADdgVUCH2i0I5RDa/WYmCp6UR1ZvQOI4kgLtviJgwpA8pNr1qEE+6r4BEGihtmuvl4LMwwM6e4t7bQs13BhMDWXBcaVY6fA0QEnvzRt+9LCgJmWdH7svXufihmOyRdnMvJZ8G5OoTCt8gxpTAIPgmL6k5jqby3jcQ08O9WV7ewi8JDMLMnKCwTKmYxwkUvprTFTgQml9/OZ5/R1fyjtUesbv8W2gWhwVH+JAcEgXuYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CtOkUGM0; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CtOkUGM0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGDGx0tRtz308Q
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 03:07:20 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676Eo8E93015445;
	Thu, 6 Aug 2026 17:07:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=hZp7e7dIlQxUDnIW8kQff93JDHqedshCQ1iI7RADp
	G4=; b=CtOkUGM01jWYd+0EksiuYWR8PPwOMgo6aulgnvdtlloYAkYZd/QSnxXoK
	nJrfsSgnjPobOorClKX44gkXIR/lAQwWxXJMswdhx06fK020qGZ4QEEFRTDTAOsC
	WlkbJV8Ipoo81e15gZQl7+WwBIazOWmrL39/Rd4fe0sxmU7HBQjWB2MQ131+z2iK
	y6dMPewGMyLf/iRP7iqioynoQkOLCazZwk12VNp0Ityj9vtWdIKJGXR3b7qK0yXl
	oBPEwynymxHa06hcg0lOcwIrpiP4n21FNtI+5Ai4pA5OpP1gKq4xKUWUKfwyaXFL
	maxif6q4ZQo1L2Cfx0ZVJw2LPcMtQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8ev0t3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 17:07:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676GuTFI018423;
	Thu, 6 Aug 2026 17:07:00 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhm1mr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 17:07:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676H6uJi36176346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 17:06:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C11320043;
	Thu,  6 Aug 2026 17:06:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DFB020040;
	Thu,  6 Aug 2026 17:06:53 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.29.233])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 17:06:52 +0000 (GMT)
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
Subject: [PATCH v7 0/4] KVM: PPC: Expose CPU compatibility modes for nested guests
Date: Thu,  6 Aug 2026 22:36:41 +0530
Message-ID: <20260806170645.11892-1-amachhiw@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: ZYXlxonhNNxBEJ5utJHSrr3Ky77LrfEP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEzMSBTYWx0ZWRfX7VS88CQEYY3b
 vnqd2vrCeL7V0kic2ihogYbUGid2C3hFY+xG31VaRBj5BeOgisJAFonYnHBUUruAzznubFQlIuF
 wstM2iToIxzsuzUALxWEYcHUFVIx4Zk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEzMSBTYWx0ZWRfX9/nVShq9OMTy
 isadjKyuUKan8iDwXpjjWYYNZLVMrPOJ9RgGNib1Qrm3zcfA7VQlV6xz0ENmiBJhUB7k7w2EDQ8
 ZVLGvBPXlNTcHUukXE7x8VRB8e/5TX17AFXYuwpurOpkEFbAox0+rW5DH8TPYWXt2dN70WsAZho
 +j5wj500LV55YlOfGbsqIGTQqagk/GQZgtsqs2ZMR37wtSntrIgIvHbml1RIpdzDun3GIF1kznL
 yLQ/PCUJjgKEXXtw8YKtm66uutRkQ1RQCP2/3Ew2ka2Ywvulim1heDUNNwcd3q8IjOc8AxTxkbB
 hoZMi8Hh3zCXQKaXwRdav+7R/lyixxfmcQF1Di2buPRYvabX0MK0oF6PRRqhZPQ9aELO5HtV8JF
 JfaCdeZAcwS3P4jEwVYIUkM2SHefQYpdB7vABNOGf6yYCxpOQbU6Aj6lgbDozDMUa4LTHuPombC
 Oldnu42ML3P81CZG5wQ==
X-Proofpoint-GUID: bFcZNtkpB8f19eQOku9Hx6tIkkyC2h5a
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a74bf35 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=h7u5zJOLz3W6SXC_pSsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060131

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

Changes in v7:
 - KVM_CAP_PPC_COMPAT_CAPS: add hv_enabled guard to align the capability check
   with ioctl availability; a PR KVM guest on pseries now correctly returns 0
   for the capability [Sashiko]

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

 Documentation/virt/kvm/api.rst      | 79 +++++++++++++++++++++++++++++
 arch/powerpc/include/asm/kvm_ppc.h  |  1 +
 arch/powerpc/include/uapi/asm/kvm.h | 18 +++++++
 arch/powerpc/kvm/book3s_hv.c        | 56 ++++++++++++++++++++
 arch/powerpc/kvm/powerpc.c          | 71 ++++++++++++++++++++++++++
 include/uapi/linux/kvm.h            |  3 ++
 6 files changed, 228 insertions(+)


base-commit: fcaeecb8b0cd44f77d03b28de0671258d4db18f8
prerequisite-patch-id: 7755786f0e4f415e47065ff1972765008727fe10
-- 
2.50.1 (Apple Git-155)

