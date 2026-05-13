Return-Path: <linuxppc-dev+bounces-20843-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F1BCD37B6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 10:08:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFq0r3SMbz2xpp;
	Wed, 13 May 2026 20:08:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778666908;
	cv=none; b=ivu9ov3DfCqhUEQH2h9qqwl9tKuZI2RoyQTLqYh/2mrOca6PBdvbzEOCA3ZVvG2ETp+gdx0s3RxNoKc/PYkGAPzok/ze9c54lRx3S65cL/gBpVKAHai0hfdYamhEYfiUTiIZbilJMEkWFHs1O0j3cueRs9rP7M0EeHk60J+t5xcuAbFKwUvkqNRvSaDrfR3ANx7FlV7CRrDTIFdzKgjwCCoQOFUEfKK3pxmua478VntoW1PhfdEzxCbNLZz29VhxHedDxAHyU3Avh+KnFnxTTUiFLpo6iRkMbP1mPL8vYLZE19cbrYWzlUSrIisToPMg5r5TKZB1kD8PNODXDYFwiA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778666908; c=relaxed/relaxed;
	bh=fMpRHD3ruO3rnNVYkCmn+4bpnMn6HHOvClfCzfzd1ls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K0MoCYZq7g9BLPEyQFyQViOj6ULi9rUkuJz02GD1t3doMzw+HC0WBwRAeAdU6yGD8Rxmh3K0o6zTY9Ux93dQN95hvAFrKg9nzXgYwDODRIxcMwoyL5ar8HGVTxIE0pJu2sRQBgz4tZF65dnuTsUgyUWsg/nz+VGZaIohmIvMn1Rx/aOnR65N02MVlar/veAcYMtkT75ZD1+iIlVEKEk6wxkHZIJPPSL1ZXDaQtGaYJH6rUXgOXEJD9tWrGeyrbIg49FmJBrFb63DlQayJmCnsc88ECHkD2qEhuANXqKKoYHHfeizHbbCkeDz0RSRvzno79eBNpLWqjgU//kRp/nusg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hvSJ6WrI; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hvSJ6WrI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFq0q2Dx6z2xn3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 20:08:26 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D1e3Js3185798;
	Wed, 13 May 2026 10:08:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=fMpRHD3ruO3rnNVYkCmn+4bpnMn6HHOvClfCzfzd1
	ls=; b=hvSJ6WrIktf5wdd67uizxJQYfkNVLLV9x0imB3u6Q6D4KDO/u25DjTzbh
	Irs5Wmr03vatTCaXNJdAE9q2JgM/Fr5tP9QzTNbA/IeZajd4iEdrB7jKlun4QjBf
	rSoXTne21H6cU1bdFnW/LnPJMOHzPFWH/cwFPUXjOljJMGisdYk2UC/N/n9yhb4K
	k1ObEaIIzwpjYc7fm4NO8bdnZCT0Tv2O2xnqOjrzubhvl76DlRhOg/dzCWl+kQsi
	dQU+3+LcpLAQjySzwk/NFNLdFpD++dM37psChZ7F32yh/Ha8AsvZfFLYDjfp1GDG
	wpxrLRNYM1E45SxD0P+iAYNym/+5A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv5f64m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 10:08:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64D9sQLB024102;
	Wed, 13 May 2026 10:08:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgy9t0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 10:08:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64DA885P27722054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 May 2026 10:08:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFB0720065;
	Wed, 13 May 2026 10:08:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72FEC2004E;
	Wed, 13 May 2026 10:08:06 +0000 (GMT)
Received: from mac.bl1-in.ibm.com (unknown [9.123.0.51])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 May 2026 10:08:06 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v2 0/5] KVM: PPC: Handle CPU compatibility mode for nested guests
Date: Wed, 13 May 2026 15:37:49 +0530
Message-ID: <20260513100755.83215-1-amachhiw@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=cPHQdFeN c=1 sm=1 tr=0 ts=6a044d8e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=3pgwaEq9XIEntMmap7EA:9
X-Proofpoint-ORIG-GUID: y9-KWnxWXJWbYLPCLwWH5rwCgeT8vksM
X-Proofpoint-GUID: ruOk59LsWJi6Zq5oNzltl2S6mCEuC3We
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDEwNSBTYWx0ZWRfX3Edk23Lte1t/
 KYgIUg4m38Yl6C+5yWQDFlW1cnh474TSrRelxGmMWVLvcaWFdNUJuKuBYSSkedFvVqu0aXn9wMP
 lFc8ea1UMiwmYnaPk++Iqkko/TpDpksiUq1YkQNnR9Lbww6sfCpXEt9Z3QKk7RCh5Zix7yt3jGs
 bxmkLQgXreI/ana6nf+ncbKL1iIVfyr0rqKP6Ig76nmymVG9RC8YGQE8aj431YahFgD1kFFNk5e
 7OnU1mHXghPueBNWy4gNmTnsQ6FU1b1X3KQmQbjmBho9BobE2kEtT4tAB4XONU/lg0kdfU4tFNC
 otg/+uCcuxWfOqZbqf9hnLjkSE8rlyKH7HK8IQd2p5rLo5wXjgkkaJcelkoadhIzkTlvlBpOXKL
 Sf3/9+Gvp2A1SS30eGouWaOJE6DLpwZ2oz/nKgxi6XscN2O4oTuMAotvBLD8Pvu12/ftNhDaofE
 0bXfk4e2BmNQf8shz4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130105

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

The implementation supports both:

  - PowerVM (nested API v2), where compatibility information is obtained
    via the H_GUEST_GET_CAPABILITIES hypercall.
  - PowerNV (nested API v1), where compatibility is derived from the device
    tree ("cpu-version") representing the effective processor compatibility
    level.

This allows userspace (e.g., QEMU) to select a CPU model consistent with
the host compatibility mode, avoiding mismatches and enabling successful
nested guest boot.

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


