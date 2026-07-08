Return-Path: <linuxppc-dev+bounces-23811-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B893C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 10:52:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwFKP6K1Sz3078;
	Wed, 08 Jul 2026 20:52:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783507929;
	cv=none; b=Qsymt2gUNLVABDMIx3KxLtQCC6kQIhx1sHVCsghNioW3QgTsXPWnS8IUJ+iPYZQw77HKy7UPo7NOUX7xQJGPc0bMGcLuwn3R4s98rWEuy91J5sDGDhXoZeZAoCVdc+R2SJ48VREJIRsRGcUw9AOgudgfFYmJk0ly5z9tgst1nVK8SwkblDdlZuGwKK8OWG+6cXLkQ+jVOTIFPnLp5Z6IzwHsd2LN1xNTya5HSOIg7VkHfMNm4NgzsKlF6cbARfWyyWNjADZKS4lxlVe/xM2mTTNQ/l96b8u1I5ajX8t5e9DHftFZMD/IBm7QXDf8Co7IAmkE8PandtKsizv1fhfhcg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783507929; c=relaxed/relaxed;
	bh=nomQMmJIA5GimD4K9IPQTUvBW2Pv5d5DPAjBHj+vIK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZAsbvlwroHaSOMYTfMW+BsxDfyv583/5HWK/cUX2NqFM2gphvv+fWotzth3oziCYR5gH+rWkZqlcqNvJrlH8ChwP/IOXRKYScp/k+iaOc4cMf91tY+BqEAaUzMYPFZ+p/lsp+bihSQNdSihIXFsTLUfuG/J4u/DDp2WSRR2qGkmABz0jM6KbGvVtxd8glsilSVoJL59mIVZfhu1JW/4Xe259SIJZ+BGUxxknGTzwHz1SObuXFjjJMfpapBqEntxXb4L1p19ly2L/fRDnRBcJgqk/I7EQzvULT/Lb873csDtutJqLYwhb7PVx2V0c3tPcVzmkzcCwmr+FWPDrKkaHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KJIqgkZY; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=rathc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KJIqgkZY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=rathc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwFKN6dTVz306S
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 20:52:08 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6688J7si1831797;
	Wed, 8 Jul 2026 10:52:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nomQMmJIA5GimD4K9
	IPQTUvBW2Pv5d5DPAjBHj+vIK8=; b=KJIqgkZY8wujVtBwbSb5htQAVEnRB7JhO
	urNyKCep0g/IAlzAXBj573tMpjNYUs8ubC2MUUQlLPmqe5K2WyZEgSEZrGZYLCW0
	fvhueKBYK5jmI85v5KZDBiJ5TqFcfr3W6yx492wOGq9NHlA5/fhtSwH5oMqeDFYa
	KjoGvLzTMwLTY0T/33jLqz5+G/B6aDLJ68aKOIUIn5vcQVdtivnMK1vw1lDIpn2X
	pKVbPxekzsHvcBjWd6mrPsP23YjwKlKBsXyOAwGETPzZ/oAOuLAelW+GmjsGSjCx
	yiWfyU72xktJotMd6bPnW2AoQXWys/luF9GmKY/MdGFAD9O4rLztQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stsvc4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 10:52:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 668AYdhg008818;
	Wed, 8 Jul 2026 10:52:03 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgq7v4y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 10:52:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 668Apxer51904928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jul 2026 10:51:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5535620043;
	Wed,  8 Jul 2026 10:51:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F29D62004B;
	Wed,  8 Jul 2026 10:51:55 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown [9.39.26.49])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jul 2026 10:51:55 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: thuth@redhat.com
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, lvivier@redhat.com,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        andrew.jones@linux.dev, sbhat@linux.ibm.com,
        Chinmay Rath <rathc@linux.ibm.com>
Subject: [kvm-unit-tests PATCH 4/6] powerpc: gitlab CI update
Date: Wed,  8 Jul 2026 16:21:20 +0530
Message-ID: <20260708105122.1177210-5-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708105122.1177210-1-rathc@linux.ibm.com>
References: <20260708105122.1177210-1-rathc@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 7uoKHsDaL54lf1ZReKpPztxXnJhn_iyc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDEwNSBTYWx0ZWRfX7eWwbNjAyBD4
 r5B7zzTC56dGF27NPVNTxU3bt2Cxw/kK6QUBneKD1vWjcCLLCoiC42nlGyTdqkdcpjHX7oTJNPx
 QR4+GkPXqvKmYuTHD96GTJc8ye/VmMU=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4e2bd4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=eeYWF6t0w1cpnsO5Rs4A:9
X-Proofpoint-GUID: ehiTM5H6fPK9rs4GBXkW6r8TecLXrQ4c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDEwNSBTYWx0ZWRfX8It013a+R47s
 QIFT7irXXhc9NeG3YAucwHFjVJBZFEofTTp2cHKrkCxFB8fahH18gcQYwVNjLjoDKiNfMXGVgVu
 1n6r2D8sTFJtUlLjz+Np70CL9TTuuHfCBx+NlrBq+bNNNTE0sXPzeOAGP0gn0syHvfVAK5jCZrP
 5p5TnmAZfMAS9k1YTW26zZryoZWgskxVxlf0FzN7OxO2tx0JTGH9ILY/nJxoH1hOBt9Q74G4NOF
 oD7gKxEkSBf80EbMtzvv6b0a7yzCWAY2w8urBfy8YAWuS432yZvQH3j5pNOmae6mzKmMx2WC5a3
 4dRftLDm8zfNygc/IUaHPklmriscIDez8QV5oOIe6ipm4GhaNReGzNiPmdrFJJKB8r3Hh8s0W/G
 950id7YGqNjD5n4digALf+KCg78F7vNv+jQ8VbNhnADTLv8X6jeJuUNtg0dpxl5toybvaTPCWYf
 ZCv8rkHu4oKJoLrpgaA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080105

From: Nicholas Piggin <npiggin@gmail.com>

Adds a few additional tests that are known to work in CI.

To control overhead, ppc64be is used to test 64k page size, ppc64le is
used to test 4k page size.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 .gitlab-ci.yml        | 19 ++++++++++++++-----
 powerpc/unittests.cfg |  9 ++++++++-
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index ab1be5f4..b28d1eb5 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -190,18 +190,21 @@ build-ppc64be:
  - dnf install -y qemu-system-ppc gcc-powerpc64-linux-gnu nmap-ncat
  - mkdir build
  - cd build
- - ../configure --arch=ppc64 --endian=big --cross-prefix=powerpc64-linux-gnu-
+ - ../configure --arch=ppc64 --endian=big --page-size=64k --cross-prefix=powerpc64-linux-gnu-
  - make -j2
- - ACCEL=tcg ./run_tests.sh
+ - ACCEL=tcg MAX_SMP=8 ./run_tests.sh
       atomics
+      atomics-migration
       emulator
       interrupts
       mmu
+      pmu
       rtas-get-time-of-day
       rtas-get-time-of-day-base
       rtas-set-time-of-day
       selftest-migration
       selftest-migration-skip
+      selftest-migration-ci
       selftest-setup
       sieve
       smp
@@ -209,10 +212,12 @@ build-ppc64be:
       spapr_hcall
       spapr_vpa
       sprs
+      sprs-migration
       timebase
       timebase-icount
       | tee results.txt
- - if grep -q FAIL results.txt ; then exit 1 ; fi
+ - grep -q PASS results.txt && ! grep -q FAIL results.txt
+
 
 build-ppc64le:
  extends: .intree_template
@@ -220,16 +225,19 @@ build-ppc64le:
  - dnf install -y qemu-system-ppc gcc-powerpc64-linux-gnu nmap-ncat
  - ./configure --arch=ppc64 --endian=little --cross-prefix=powerpc64-linux-gnu-
  - make -j2
- - ACCEL=tcg ./run_tests.sh
+ - ACCEL=tcg MAX_SMP=8 ./run_tests.sh
       atomics
+      atomics-migration
       emulator
       interrupts
       mmu
+      pmu
       rtas-get-time-of-day
       rtas-get-time-of-day-base
       rtas-set-time-of-day
       selftest-migration
       selftest-migration-skip
+      selftest-migration-ci
       selftest-setup
       sieve
       smp
@@ -237,10 +245,11 @@ build-ppc64le:
       spapr_hcall
       spapr_vpa
       sprs
+      sprs-migration
       timebase
       timebase-icount
       | tee results.txt
- - if grep -q FAIL results.txt ; then exit 1 ; fi
+ - grep -q PASS results.txt && ! grep -q FAIL results.txt
 
 build-riscv32:
  extends: .outoftree_template
diff --git a/powerpc/unittests.cfg b/powerpc/unittests.cfg
index 60c73086..62630ead 100644
--- a/powerpc/unittests.cfg
+++ b/powerpc/unittests.cfg
@@ -24,6 +24,14 @@ file = selftest-migration.elf
 machine = pseries
 groups = selftest migration
 
+# make a kvm-only version for CI for now
+# TCG accel support with Qemu and distro release used in gitlab CI needs to checked.
+[selftest-migration-ci]
+file = selftest-migration.elf
+machine = pseries
+groups = nodefault selftest migration
+accel = kvm
+
 [selftest-migration-skip]
 file = selftest-migration.elf
 machine = pseries
@@ -94,7 +102,6 @@ accel = tcg,thread=single
 
 [atomics]
 file = atomics.elf
-smp = 2
 
 [atomics-migration]
 file = atomics.elf
-- 
2.53.0


