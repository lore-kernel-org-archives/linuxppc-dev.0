Return-Path: <linuxppc-dev+bounces-28964-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BC7CA5FED
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Oct 2026 12:24:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hzb6b2wD7z30V2;
	Tue, 06 Oct 2026 23:24:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791289479;
	cv=none; b=PD2qfSIwHQSdhJu+cp5PAMv8P18FcgxexRcsIvjd1oPMKRbZzxwjKdZCoiEMXaWRcoyvowWzZ5CZTdDA64KCOeq9y3oip6izt09vsQo3lAaNzsc/7Nhvl0K09CnBndU8wAKu9lM0o6+C4C5lbWIntBb+JpJidbdjnsM1PgLSvfMSwIkfFt4g07h3QTxvqdhLrgFQLVgkX+AlLIGbThzH7G+FXFrq8uIKSqtGoqUq/0drdux47D1FggrzOKA8u/jhVYdbBCvd5SYgheaPHmxAOGeApod1Ku1DCRPwIKz39xospqIIRTs+wnfpqmtCukhpbZqgCWit65q7A0xpHOBVyA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791289479; c=relaxed/relaxed;
	bh=C+zoc7oGbtC3fEjZzjfOVnYalrPVzXXdmo8kUzPqF00=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dZVU3J291t+VmyhAJhxZogBg2Nsh7xkyEV/dI9km3ZT3+JrAehFTNeQyMVGmwMzj0e+0k4ReO9ouobA7O7GH3U9yrC5Sb0e2kIEgyI+y6fXkOSfCCw1Lsi9O2wpUKbJjuCsBqtdqc0ZC4pEM60ix0kZVHjX5MIbemE/JikOOQDNeOhh1bv9iqxSJX20x16so1zxIYTqNA7F/wwRvey9BFPLF2ainSvdU7Jezh6aKkkvuOPHkhsqUkLznoEsT69vcxoFWOv4cv+S5qakOJ2eb4F8dOV4r4+AL/osd+zEc448/lqhrGre1qw+lzjyGPbbYMSk58krO9XKFBodGY7GYAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=r6BpvhNV; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=r6BpvhNV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hzb6Z2qTjz30St
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 23:24:37 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696BZYqU2400147;
	Tue, 6 Oct 2026 12:24:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=C+zoc7oGbtC3fEjZzjfOVnYalrPV
	zXXdmo8kUzPqF00=; b=r6BpvhNVBWKEj78vbom2svpfGZ8JM+eDMcsI98A9oIBY
	8oK1McjGjjqbb8OOkglw/jnGPK+MMRQIdyynB+wcnusbBFhGHxPndMEeS3J73GS7
	pDoIFmZpU0f+o/aOIGiyefC9CW9XCBp9lPKnaGuwVTUAvYjflwC5rbsS3tq3TRIF
	djqvc75h9Hd9acenSMjFKyn9TSYThwIdH2nE7gECEIjFej65/oaAf0nUFRgUE23W
	Xz/Oje+dLweS79fMS44rNgp+9HOBFMFnJ3m2RHxPTpftl3EUaNFqIZxbZryK9AXV
	/KsA7l1KOQDUYUMieJwjBRU1blaXVlSgiZN0BaZ+bA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2r4fy3ek-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 12:24:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 696BWVl4242255;
	Tue, 6 Oct 2026 12:24:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3eqy9ka2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 12:24:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 696COFcs37814758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 12:24:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 141672004E;
	Tue,  6 Oct 2026 12:24:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A62AF2004B;
	Tue,  6 Oct 2026 12:24:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.214.4])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Oct 2026 12:24:10 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, kvm-ppc@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gautam Menghani <gautam@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        R Nageswara Sastry <rnsastry@linux.ibm.com>,
        Alexander Graf <agraf@suse.de>, linux-hardening@vger.kernel.org,
        stable@vger.kernel.org, Avi Kivity <avi@redhat.com>
Subject: [PATCH v3 0/3] KVM: PPC: Fixes for Book3S HV HPT locking and paired-single decoding
Date: Tue,  6 Oct 2026 17:54:01 +0530
Message-ID: <20261006122404.99358-1-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TOPQ2Fla c=1 sm=1 tr=0 ts=6ac4e874 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=oqY91GN2WXtsPlI78dAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA0OCBTYWx0ZWRfX/t3z9SrS9xyT
 /apWL4UfNmfUAk79bcKhw1Yk+Uzdmn33pM3kthOXiqPnlRay219u8JadMGZdg29zpD2cQ2gk6LJ
 sB7FnvJN1yPlCuMnM2BcGdJJFZQretUIkpTf/ic3DuBQHtcLJItIVEo2wpQJn1OZqF0+CvcCZnn
 YdFhoMqgrrPhHAi3ACMUj3Sm5cLIL9Ws91zYxpXXOsfOI+O8WgVtiJ7jYqELr5CHlt6U99whJ0d
 Vyj6pDKSkMkNTXqGN9Qqk1zzyxneuogaSSsyU6Nmc/zvY3hfQaq7XrqWWfH7w8yLPUTW353ROXf
 7179rd9syqKgE1LCagVpuXo3zuPbneSp5UKxLJ23UdEAG40VYyIQjP61RpEu0Tm33JI0LgRHt8+
 1frsFpbagxxhMC60rls59zF4+iCu8uEVMd7o0pHEeItYYZfi4BtPohnVdnrofq4kEdv8+ipyfCz
 Wh6xsAnElnvEYAFw+9A==
X-Proofpoint-GUID: FPMorKzIomUgpvXsPoTvw-NSE_KvZ-y1
X-Proofpoint-ORIG-GUID: j0MJPDwhh1d3XkqVnIY_GHm7BWHwGdky
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA0OCBTYWx0ZWRfX7li4L611Mr8/
 9ZoZSuFaEqfShWWGHOZcNY1f28oVV9AcU11lkcvfJWacj9YKpojA4QPKUJvyvo0FDf1D8WXsl3t
 v3Li7wuQ4R/69ottU1h0MMJs3554dMs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060048

This series addresses bug fixes across KVM PPC Book3S HV
locking/synchronization and paired-single instruction decoding.

Patches 1 & 2 fix synchronization and preemption issues introduced in
commit 6165d5dd99db ("KVM: PPC: Book3S HV: add virtual mode handlers for
HPT hcalls and page faults"):

- Patch 1 adds SRCU read lock protection when walking memslots during
  virtual-mode HPT hcalls to prevent use-after-free races with concurrent
  memslot updates.

- Patch 2 adds preempt_disable() around all virtual-mode HPTE bit-lock
  holders — both the guest vCPU paths (kvmppc_hpte_hv_fault() and
  kvmppc_pseries_do_hpt_hcall()) and the host-side paths
  (kvm_unmap_rmapp(), kvm_age_rmapp(), resize_hpt_rehash_hpte()) — to
  prevent CPU stalls and deadlocks on preemption.

Patch 3 fixes paired-single D-form instruction emulation:

- Patch 3 fixes get_d_signext() to correctly extract the full 12-bit D
  displacement field and perform proper two's-complement sign extension.

Testing:
========
All test kernel builds were compiled with CONFIG_DEBUG_ATOMIC_SLEEP=y.
The following scenarios were verified:

1. Power9 PowerNV (L0) in Radix mode:
   - Booted L0 host with kernel containing all 3 patches.
   - Booted KVM guests in both Radix and Hash modes.
   - Ran kernel build workload inside guests — no errors observed.
   - Booted L1 guest with the same kernel — booted and ran cleanly.

2. Power9 PowerNV (L0) in Hash mode:
   - Booted L0 host with kernel containing all 3 patches.
   - Booted KVM guest in Hash mode.
   - Ran kernel build workload inside guest — no errors observed.
   - Booted L1 nested guest with the same kernel — booted and ran cleanly.

3. Power10 LPAR (L1):
   - Booted Power10 LPAR with the patched kernel.
   - Booted KVM guest and ran workloads — no errors observed.

Changes in v3:
==============
- v2: https://lore.kernel.org/all/20260930173750.56759-1-amachhiw@linux.ibm.com/
- Patch 2:
  - Fixed preemption window in kvm_unmap_rmapp() and kvm_age_rmapp(): moved
    preempt_disable() before lock_rmap() so both the rmap lock and the HPTE
    bit-lock are held under a single non-preemptible section, and added
    preempt_enable() on all early exits and retry paths before cpu_relax().
  - Cleaned up kvm_test_clear_dirty_npages(): removed redundant per-iteration
    preempt_disable()/preempt_enable() pairs since the caller
    kvmppc_hv_get_dirty_log_hpt() already holds preempt_disable() across the
    entire loop.
  - Reworded commit message to clearly detail the per-function locking design
    and rationale.
  - Picked up Reviewed-by tag from Shrikanth Hegde.
- Patch 3:
  - Picked up Reviewed-by tag from Shrikanth Hegde.

Changes in v2:
==============
- v1: https://lore.kernel.org/all/20260928122837.8782-1-amachhiw@linux.ibm.com/
- Patch 2: Extended preempt_disable()/preempt_enable() coverage to also wrap
  the HPTE bit-lock hold windows in four host-side virtual-mode functions:
  kvm_unmap_rmapp(), kvm_age_rmapp(), kvm_test_clear_dirty_npages(), and
  resize_hpt_rehash_hpte(). These were identified as vulnerable by Sashiko AI
  review and confirmed correct by audit.
- Dropped Reviewed-by from Ritesh as the patch was materially extended.
- Patch 2: Added warning comment above kvmppc_pseries_do_hpt_hcall()
  documenting the preemption requirement.

Amit Machhiwal (3):
  KVM: PPC: Book3S HV: Add SRCU protection for virtual-mode HPT hcalls
  KVM: PPC: Book3S HV: Add preempt_disable() around virtual-mode HPTE
    bit-lock users
  KVM: PPC: Fix get_d_signext() 12-bit displacement for paired-single
    D-form

 arch/powerpc/kvm/book3s_64_mmu_hv.c      | 10 +++
 arch/powerpc/kvm/book3s_hv.c             | 80 +++++++++++++-----------
 arch/powerpc/kvm/book3s_paired_singles.c |  7 +--
 3 files changed, 56 insertions(+), 41 deletions(-)


base-commit: 2c3418fffa9d037b2038a6db48be63f9e2291806
-- 
2.54.0 (Apple Git-157)


