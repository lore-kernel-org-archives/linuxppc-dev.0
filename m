Return-Path: <linuxppc-dev+bounces-24421-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C113AC4450A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 19 Jul 2026 13:03:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h33jL17H9z2ylm;
	Sun, 19 Jul 2026 23:03:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784466182;
	cv=none; b=JUNy3jiMlS78kl2K+7mfL6dO3pvkjSgpPQKDkp38mRBj2kOGADy1byZz69fRXNiBFCY9+SKDrfdOUNNtLQV4SH75dX4NGU8VpfJozw2V6XIvslwaTJAo50IgBL3PEFeGicVu5LnZXz86G0lfdhLs+gnWG9MNdyGQ8lyc9unj2w/sbhdGzZQnheZ+FxU6D49A+ruInleSGmtlm3bZjDzS5m6LVJ6k24BMHkRgIjSFsZhm15P2Y+e8aevICWHrw9/SfKaseCTAkHc0JGWaCy7AaOnBQJHPKRgumucm+ASGcToo7jYvpFWov9jC3qrTgozeTgkOW9cFYybFGz2ynI4E4A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784466182; c=relaxed/relaxed;
	bh=c7OHmAxHXIs8M9Z3ATtSo3f/CmwyD6t5nXmuNzRbp60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jkLrs8HmHpJ6fbcPibjbbsDgMlQJMUSzHRng/QSV2xBtCtLM6vwCB1Spv+2NMugOdLQMaRFHcu/UdLTm5MlLGSJFxfvYkVEdtxj+08/kKbEW553Y6Y30cg3HZ15MtXyLn4UGREnqhu1w0xYqvVQFBgGvySS22a+TALgy5fReS0xh8Nvi80Q7NF8CjAxKehmVla+7H13ACuiJtiQf5i43z1kTdzA3oy5sJ+iCMGxA/cIHwSY6U3mKPf1fysr8V//07OD3vi2ICNu+cPiIs25Xyo9tuCG7yuGfjcbTmPtA6hRR19QQ4VG3NKWWRiJZej8aSa8VnXjhc4m5zhilsPda/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PnbHmWPc; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rathc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PnbHmWPc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rathc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h33jK3HJkz2yQL
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jul 2026 23:03:01 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JBBhR03351163;
	Sun, 19 Jul 2026 13:02:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=c7OHmAxHXIs8M9Z3A
	TtSo3f/CmwyD6t5nXmuNzRbp60=; b=PnbHmWPc9rRizAYTgFkxEnL89Pf7jSdHj
	m1OMeExBWxcMep7/z9yn5iSmd9xZgNZvSAJYJdI4bLPo7arZdrpu/4yNE7r4AlJe
	HWbMqGz1wdUesiZG97RMo3zAbXrhQ96S6pRq9DCws1iAfVSGtsggPZIJ4Ti2Xzpc
	a/0IZMrG57K+bqYFnZ4btiDiuaX7CAynY0iaqts+7m4CBqGwhMJA6++E+bQ0jgCR
	IiYQdKc3fqP8N5P4JTUpud9BqvGjd9EtsZSaC6kjbuGPILxZe/NtEMt2odhBa3d8
	5B0rUjOhh2OF5/LBX1D4FP1z57IbxtmGNmcBDRvrAoSd/Byajd6kg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ab3fxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Jul 2026 13:02:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66JCnh2p001549;
	Sun, 19 Jul 2026 13:02:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6vssd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Jul 2026 13:02:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66JD2qPo48103886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Jul 2026 13:02:52 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B8E52004D;
	Sun, 19 Jul 2026 13:02:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45B932004B;
	Sun, 19 Jul 2026 13:02:46 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown [9.124.218.35])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 19 Jul 2026 13:02:45 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: thuth@redhat.com
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, lvivier@redhat.com,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        andrew.jones@linux.dev, sbhat@linux.ibm.com,
        Chinmay Rath <rathc@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v2 4/6] powerpc: gitlab CI update
Date: Sun, 19 Jul 2026 18:30:25 +0530
Message-ID: <20260719130027.2347519-5-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260719130027.2347519-1-rathc@linux.ibm.com>
References: <20260719130027.2347519-1-rathc@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDEzOSBTYWx0ZWRfX979detqnrt1v
 C1xWpblgTt48px8IfChffjEQ+hjRBqVrDmQnnRJUcLNlRehcVwWpIh9h4z5VmKWURBIvq2AVzil
 a4ka1B6KYVGiU/OtE0ofHhkkTh8JNMLonAT8rm4qw66voZm250vCnEV8fc9kYANn5rRlNmIyVMT
 8fq50EOknbrZEzMLk0obYO/Te8PYmwd7WMJ6reocS/fE6MeSRF+t2boe6bttE3WhY5hrE05YlAB
 s0TN66GDz7OF7arBWeSuNYOMINuLdUwi5X1VyMA3r5lsg2XCOj32MJhs4eHKSJxg2RKzcuRg42t
 9S/kvF+4NXHdShe8bHEN2mZ0hlgpDNTo0JZr2F6TuwF4PnX2A3c5uNkX8v3cOCQhI0d7ZunFsNg
 xAzbbU1IBPpZAfKEFtcSzN0IBvrMy2o5Dn90h0DBAQ7aglST/c0hkhfaH/KfTLCwimzwGMCsIWf
 /ZZRI4GnIvo57MWRFMw==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a5ccb01 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=Fv72k0K-abCLAsPJMrwA:9
X-Proofpoint-ORIG-GUID: 4gwswNAMFv17wtPqW8J-7sGh7w7I3CCW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDEzOSBTYWx0ZWRfX4dC8JLWlTfHS
 ao4TnNr975dGttwG1PKSJaXT0fNnlAjHOkwuxrq+W5UxEL5EpIiHmHcl9XY6BOCWfuCujse8CKs
 9brIe5G2vENXod/g6UGHOQ7/5b09vPc=
X-Proofpoint-GUID: PYtr-62G8VTBTx_rVSN2hO-wCwR4kIfB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607190139

From: Nicholas Piggin <npiggin@gmail.com>

Adds a few additional tests that are known to work in CI.

To control overhead, ppc64be is used to test 64k page size, ppc64le is
used to test 4k page size.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 .gitlab-ci.yml | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index ab1be5f4..89329cd3 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -190,13 +190,15 @@ build-ppc64be:
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
@@ -209,10 +211,11 @@ build-ppc64be:
       spapr_hcall
       spapr_vpa
       sprs
+      sprs-migration
       timebase
       timebase-icount
       | tee results.txt
- - if grep -q FAIL results.txt ; then exit 1 ; fi
+ - grep -q PASS results.txt && ! grep -q FAIL results.txt
 
 build-ppc64le:
  extends: .intree_template
@@ -220,11 +223,13 @@ build-ppc64le:
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
@@ -237,10 +242,11 @@ build-ppc64le:
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
-- 
2.53.0


