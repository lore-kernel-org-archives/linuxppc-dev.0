Return-Path: <linuxppc-dev+bounces-25644-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A237C55174
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Aug 2026 16:12:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hHQyZ0qqsz2yMl;
	Sun, 09 Aug 2026 02:12:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786205542;
	cv=none; b=lIibNaaDcOy2ExnrOcbrpzszvM/Kc1gw8MIhm3GgBDInLEHwnrAjR5N04H1TEyXB80jIewd5WwX8+mMbe6YuAyy0JvhkExMkSZuZPLBfzOHyRKxITX0nsUFBkd7eSnF17MSx2K/3ZImG9B7zJLzRqfEnq+68Wtfa+dm3FDa+F8tAHdqCOoazgeRpUGAMe4AQccL32E7M5f5OIvEHyi7tARuCZQmWtSTQB/+Z0g6PSxw+IGzTgz5n6RDNMv4XLY86mNaPR79mo0lkI5Pf68m7IykLakvJ/z3VE2KA1aZJxhnySBm3CgTwkypoi9OA6uflfo4Bmt4IRraxq8PaAU4JKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786205542; c=relaxed/relaxed;
	bh=lZwlVTNj7OOOxgK9ejPIwcRvkeE/xNbOIQ8klNyds+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RGemz4chaOCzt9NbTSCN/SYMV4CP2D0Q2H1xsOnhfcSR3xOHt5B6gpgXbOLMCC2giTPvgai92fzkx9/V4NeKOUwusHkj6ZTIySQIuIj8p3RZ5FdaHqiTUPzDHGn61CZnmme1FF1d+DL/OPsNgxyjjAPmjMX0SRYC3DCFb5hda+R1LhwVQbbJdnD1mHs/zqLbqpX0QoitJrK/62zR9a3SAKStSVztDKmbaK4e2Flj9NeBdpW5fs/gB8onbJx3N9K9RJ7tArKt3mS92wREMvn4ocsPVKVSfufkNZXk0VigilyNebkPRFxFSGT3ywIhKXBO8itZcWLsUjygFdlWeKSOww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QF7KtsJH; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QF7KtsJH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hHQyY1spKz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Aug 2026 02:12:20 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 678E1ZIK2693186;
	Sat, 8 Aug 2026 16:12:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=lZwlVTNj7OOOxgK9ejPIwcRvkeE/xNbOIQ8klNyds
	+U=; b=QF7KtsJHwc9BQVafrpHK7LrWaOzGdTjAG8fmjvzRTFGiv8c/zWP+UkC6z
	zg8e9Sy1FsM/uwHo6md2GAbcU1LAfGysLQzT38Zsn9yRYcH0mWrtM5NXmFnZPNJk
	bksRwcPNvHgHdp6V0Ye8bhiSIB73Mvd7ro4glbf5Pvs62shwyZxulXeeQNGGb1jB
	ynRubkijwl/0oD5xrbqWh5i8tgst7+/5S5/jk1al7i9p7sw/UIK5SFMeMQeDW8qr
	HkyDjiKg2cCTuyiMyh0yZAeNICHpWqJvWz46AmTWGKzCwiZUKomrDl1WSK+H5cmN
	TCNNNwRT9xejSKlV69WiP9cjvARGw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjyhmk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Aug 2026 16:12:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 678GBG2R021800;
	Sat, 8 Aug 2026 16:12:07 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4r42y7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Aug 2026 16:12:07 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 678GC3NA49938860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 8 Aug 2026 16:12:03 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A32FB20043;
	Sat,  8 Aug 2026 16:12:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3D4A20040;
	Sat,  8 Aug 2026 16:11:59 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.213.63])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  8 Aug 2026 16:11:59 +0000 (GMT)
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
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Gautam Menghani <gautam@linux.ibm.com>
Subject: [PATCH v9 0/4] KVM: PPC: Expose CPU compatibility modes for nested guests
Date: Sat,  8 Aug 2026 21:41:44 +0530
Message-ID: <20260808161148.66673-1-amachhiw@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDEzNyBTYWx0ZWRfX8xvSi9qKJgGr
 lPFExvAIhGouIofL/rp/+4cjKdN4iZVsrtURCdmSq5ryqdmPK1CbhqC3MRDJbCPqfisSVEfTqNA
 iUzJ0C+fXQMWd1bLyMYD8OwdYKt/GbjMStvajCs9HXAm1Is1HRJ99y/lbXNjzqASLn7F/Fu9gtp
 ECrQqoGpkedZiOMDa5pjZICywzbg+DEgVyhBn/MUcn1oUJjx54dPTyhedMLL7RIPYN0ekZVJlGS
 qmWh1nhlga5lk5c7nnW/L7MMv/jVXWN3MXUQWUqzRB6/eKht4SJMtO5+nFacL8vMjTeiZZ7NVA6
 gR5WCLL+kly6h35jSoxQEi0mvk/dw/406mKpsatVlCKmuDtG2j/OAbmehn5wwHJraUTnifRB+PK
 8rWhNqX2gCW+h/IFaTULaPlXgJUhjbQKoy27HzeDyNGhsM7W3VDaDRpH77j2Gpo6Ys5NB5vAgFg
 uNmvHnpnFiMr38GwzUQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA4MDEzNyBTYWx0ZWRfX7qAvNqwGoyZy
 HDV/+PDWBr7r+d3IV1maHLL3ARG+zLiqlkY9JsDmK3bhBEY7evOwqj9xTHLlszrXzw2M+yIvXGF
 fVPNbFjWvKML06TpRwl8MZXZ75VyFoM=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a775559 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=h7u5zJOLz3W6SXC_pSsA:9
X-Proofpoint-GUID: gfVgtX7stDoKXvO6Utm7nMefJPc42dKt
X-Proofpoint-ORIG-GUID: IZBMdVmp0olwgQxMDbQVSZYFMpRl7ll4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-08_05,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608080137

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

Changes in v9:
 - Simplify versioning paragraph in api.rst: drop the three-case
   explanation of copy_struct_{from,to}_user() behaviour; keep a single
   sentence referencing the functions [Ritesh]

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
v8: https://lore.kernel.org/linuxppc-dev/20260807172433.82045-1-amachhiw@linux.ibm.com/
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

 Documentation/virt/kvm/api.rst      | 77 ++++++++++++++++++++++++++++
 arch/powerpc/include/asm/kvm_ppc.h  |  1 +
 arch/powerpc/include/uapi/asm/kvm.h | 18 +++++++
 arch/powerpc/kvm/book3s_hv.c        | 56 +++++++++++++++++++++
 arch/powerpc/kvm/powerpc.c          | 78 +++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h            |  3 ++
 6 files changed, 233 insertions(+)


base-commit: a7c7074b58d28c4206d666a12aa2e33447b3c581
prerequisite-patch-id: 7755786f0e4f415e47065ff1972765008727fe10
-- 
2.50.1 (Apple Git-155)


