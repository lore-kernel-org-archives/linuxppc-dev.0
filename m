Return-Path: <linuxppc-dev+bounces-29000-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C670FCA5FFC
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Oct 2026 18:21:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0M0F4bF2z30MY;
	Thu, 08 Oct 2026 05:21:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791397309;
	cv=none; b=HeCjedrLlOccYuGFF7qpoGpE/pwHB7TM8EkKqOh7WJutHSLdApIVwc2pRiWUxocsw1U5FJL57BVHmaDfyQ/uNI2CTrueo6xYle9I8ddsjIJ+sS5R7MNEZCbRPQoQpylQTo+wm8dbOcrMx+clKFvIjn7AB7O5SUCwogtU85f+lxrMme/R2ZRWBtnujhTZnXQpXXdoXbzazXC3Ldcl+1YGqzDs8CfIDm+J9iHdmTbYSFkCJ5G2pORdxK8V25vRE4Xnvhyzh5B83WIBOH5ksFtK3Iz4TPV3t2qh2Usfj9v3XPgQ3qZsE79PeJffqddYJgY/RoXJ7wY9DhZFwUfZDGqoYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791397309; c=relaxed/relaxed;
	bh=GU1Bvvjpzc1zDr1nopl45pEqfM2oSBCiefeyNlIwmiI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MMrALKL8CWm2qepQ2qbcSjtuTS2Vv0zkjwHgzuvGBh+r8chiqrVgWZ3NB1j7V2xvdfZ/YKoxVG1rBbWBMlhzaFcs4dMYm1UlHAD4Tdp1owbLCrgef4q6j6Xrj5TV0B4UcUmVZyhljxI/F8h4UfhPGvE16eM4bRseXQdp3y7wTJtFxdZrazvma1i4QmPdsvuuw7wAiLO9B8IXdvnaMLYLzofYvswU6h0Z3LpHaMsjHZWZVIe9iEgG/nOf06KTPQvnd7kE85fSSGIf93eColLtlQkRbW/qQvbauCT1amHU8v2aiSxcWcD2tdnXbxIJAjR/lO5TqqT3yCRcep8ssENmfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ib/kF1lk; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ib/kF1lk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0M0C6GY4z30Cj
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 05:21:47 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697F5Z7s2848328;
	Wed, 7 Oct 2026 18:21:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=GU1Bvvjpzc1zDr1nopl45pEqfM2o
	SBCiefeyNlIwmiI=; b=ib/kF1lk6Mn06ak6t5qARNhjbYW6JBb5eYViJ1i1m67U
	EQkZK7fajgpgMyo2tJ3BAXk8weISlrPQDr2mkU3xUK1TD6ZRS2x4ETMXghkVQK2B
	3VdY2yW3NB9Dak69efJZo+JZX8YbD+O6UY500uqynYBe4C5AmkOJ0kNelC1uaAtO
	4v9DBuvpjb3cvBRJ3d+Zf6YAYQu8OMhtH9rqyF4PaDq3rSl13j287SCUPIx5JyU1
	Qpml4Z8D4c3FFFWuFF/cYaGWYVf/VvImnh7murVCs21uB4itKVdI9XMElwS3CrGI
	vBSpKt0D2tgw8oZz4DIXji3v4T3D3qVXwbqYYepMqA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2sbve3v1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 18:21:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 697IHjJE2245468;
	Wed, 7 Oct 2026 18:21:27 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h58d5m40s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 18:21:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697ILOoC44040630
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 18:21:24 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAAD020040;
	Wed,  7 Oct 2026 18:21:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0A9820043;
	Wed,  7 Oct 2026 18:21:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.25.208])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Oct 2026 18:21:19 +0000 (GMT)
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
Subject: [PATCH v4 0/3] KVM: PPC: Fixes for Book3S HV HPT locking and paired-single decoding
Date: Wed,  7 Oct 2026 23:51:12 +0530
Message-ID: <20261007182116.12479-1-amachhiw@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: Tlllwgnp8UCx4npqwxwsD0x-pkJs09H9
X-Authority-Analysis: v=2.4 cv=KJHPn1Fo c=1 sm=1 tr=0 ts=6ac68da8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=2Y6ooFEFlL5WLg1mQeIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: QGrdh6uD99DFf2v5d1vQqoXy6BEJx0r7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA3MiBTYWx0ZWRfXwgpcxVndUEPK
 pukQZEa9wmVMObHop2f4MrJcpwcWS7191RsBljQ+94J8W5cYPUQPwCUNpArN3z9VWYjLP4yDFXH
 zeUslXA0dO166Z31nXwg+kEUtMcb6NQa34PjQXavxqQctWcG0/BtuQJD7IMVO7PIP7AELztuFCO
 pQESqP4hHV/vJoMmfSQ1Mo45KFxMoS+1QWTC/oS/PKg99nkfr1VDG0ftW52IjikWyZg0SIF1hn4
 dr0HE4iQTLwCIFFjbizTTofBqm52VMVMNvqpvcf1ls8Y0QdlA6gDUiMlmzL1PlJEVL/ZwZ8nc7Q
 Lm2CGmikXTNO7sB+NjsDlMeBxTrMiJrsTW91jPh3qa0mLZfNhLl3lgb0oHMkXoMHdwpaOmxKyem
 bHT8X7LAv+h0kGgz4VS1bgcmulZEWyIzcHX8oHY0AW+PIGYD+Za+0M/Dd8XHGCBEixZ+91PHrJL
 olvu4D8Xj9qXvt786Lw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA3MiBTYWx0ZWRfX5bW/fkuBpZSr
 nN5iGja1eHMYYFaII9sZ1bpHiAqM2x5GF+gYEI758SN+xwsQtqggkWaP4RGyq3wTxCAZwOeazUR
 WkyI0GE9BJh8ahYc5nYMItSvNAgvl8M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070072

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

Changes in v4:
==============
- v3: https://lore.kernel.org/all/20261006122404.99358-1-amachhiw@linux.ibm.com/
- Patch 2:
  - Fixed missing preemption guard in kvm_htab_write(): introduced
    kvmppc_virtmode_do_h_remove(), a thin wrapper that brackets
    kvmppc_do_h_remove() with preempt_disable()/preempt_enable(), mirroring
    the existing kvmppc_virtmode_do_h_enter() pattern.  Replaced both raw
    kvmppc_do_h_remove() call sites in kvm_htab_write() with the new wrapper.
  - Updated commit message to document the kvm_htab_write() fix.
  - Dropped Reviewed-by from Shrikanth Hegde as the patch was materially
    extended.

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

 arch/powerpc/kvm/book3s_64_mmu_hv.c      | 33 +++++++++-
 arch/powerpc/kvm/book3s_hv.c             | 80 +++++++++++++-----------
 arch/powerpc/kvm/book3s_paired_singles.c |  7 +--
 3 files changed, 77 insertions(+), 43 deletions(-)


base-commit: 602042bf29f6efde39cfb5fdd9289bf4854bc0c5
-- 
2.54.0 (Apple Git-157)


