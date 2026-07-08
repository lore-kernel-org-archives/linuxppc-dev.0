Return-Path: <linuxppc-dev+bounces-23807-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7CC2C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 10:51:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwFK50Mv5z2xll;
	Wed, 08 Jul 2026 20:51:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783507912;
	cv=none; b=i73mcEfrI//M1rcvqtWnunv6Dc6VIMsxHrrP8cxbzpQxzZD8M3e/0j5VKWOlfKOunMHF6DIaqw/9VZfyliwcXnFNisWri6Wbdy8doABOOf4xj/IH2gP9tj9wCE7Hv5KDQR0WGiTypcvUGD/gkJ6wQiQP7Wbi71mA0ty0SXroPnNAB3/WPyRMA7RJmaSP/dH6/UEdTxC/cN1gGgS0pw/xgF4aWUDOvH4VHrnR8Js4MLTlmJULzjBsWd0LprC/8NwV/bvkGYHqp1lOeUvlsTp7frZGE7t5WnYuQwxWK4OiRwi2ECVi+JDPe2pt6cG9EfqfW+GJcBiYmFocpfrEOn3Kow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783507912; c=relaxed/relaxed;
	bh=u9sYlIvETNxWVuQUv9U2arMtkAyz2YI2oezQ8hfpJ3o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AZWCah7A2YkPkLCGMBpRCA9cRpBNVbv3PYpGEN7/g+v+RgW0ig5ioico1I/d1AE3a6UtDTeSiX6mVnExMviLi9wtJvxzBYx8m92+qwD0iG40eeigXeGgPJC2cd8Qun6SQmksyB3FJ4kdXQOVBFeEBwKXBzGoj4sK51rcduc4ubPu2eLdY4GK+yxC+V1IkLqApSOQHVl4I+6m1jnm7RbO/0RSqk5XQxvvzb7HBIkgnFXh2vCejfFUSrs6BbnEegBgpx77Gjm3tJgEcxxJtuFN4Pku5tivpDeVZexyFbp6D9+Nf7nF7wWyf4C2Z9ROKSbKMRnzR0IGD0ttff14lFMHGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oRsz2gwW; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rathc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oRsz2gwW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rathc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwFK35WQ8z2xWY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 20:51:51 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6688IDoX2501467;
	Wed, 8 Jul 2026 10:51:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=u9sYlIvETNxWVuQUv9U2arMtkAyz2YI2oezQ8hfpJ
	3o=; b=oRsz2gwWYZ3+ZsqK/sw74WniQziP/ECrxt6ujiqvCFN4JAqDrxVcj/CBQ
	DVgkKr2OY40pihEj8UfWb/behxT0NY97gLusXYYe7JO1dvcbPPyO+zKzGmVz/2fX
	wuTLyrU1GJ85Hp1ExvcdCRgG9Dsme6a8e7faDfhdVsGwu0LGElRnLVUFvhty2yaW
	bQhyRiQBaUgZZE+Uno8bAGrBD/CLx3dZiRWeyt3FF02DeIUThjNfxOhJjTSgstPg
	kmU8j3bH+Qm6lyf19jkuHnhJLepbe/Xju7oLI2JAMqmedMbjWCZtPQzXHQx+FtAp
	64Aa7+GRwa3qfBUD0idyNdY0K+H4A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4v05m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 10:51:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 668Anf7d023502;
	Wed, 8 Jul 2026 10:51:45 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqg7dyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 10:51:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 668Apf8V61538582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jul 2026 10:51:41 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A48ED2004D;
	Wed,  8 Jul 2026 10:51:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BD9B20040;
	Wed,  8 Jul 2026 10:51:38 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown [9.39.26.49])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jul 2026 10:51:38 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: thuth@redhat.com
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, lvivier@redhat.com,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        andrew.jones@linux.dev, sbhat@linux.ibm.com,
        Chinmay Rath <rathc@linux.ibm.com>
Subject: [kvm-unit-tests PATCH 0/6] powerpc improvements
Date: Wed,  8 Jul 2026 16:21:16 +0530
Message-ID: <20260708105122.1177210-1-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
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
X-Proofpoint-GUID: v9vLOWwA-r0fFO7U2TRC-ZOzEhhSFmKl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDEwNSBTYWx0ZWRfX9uOIighe0I5Q
 yZ/qBU83qw1ncvpc4k3zZTmFpc0N79zATL0JPgkNYoCrn6gP1Jzs63aDKLUEeE0+RXX881dt9w6
 dkrzekVB3gMt6PQhgRoWE55Mc1R7v9Kx1HRpbIm8UQWT5lRmnfjEaHKvS1Eq0q/ETGhMDQozhYY
 nZddgsKrAwJ7bKX4LOaosqnfftc0EzpMDR1DXV6a+S5U3p/z38l21yQe7oAvwu3O+FQjEP5ENNp
 aQ3rEbgW4VhM0IrIsy5pzHT8hnRIkQD8calR9GtSvVgltTj4SHonW21ii27+H3G/sO2w+KXpTp3
 q4+DBUe+BkbKljL2lE0mHPej2xTwxz+Vq9nARWe3eSg6i9H5hJD67FnspMkElP55cj/vs/+ggJ2
 NaSdoTQL8sTjN8ht+dIqHg+nkNxKhvv7iw+FrHA/NKYJj38nz5LVOG/uILJ1TLgiqdGl3ew8KE0
 vm6NuLShZFBftelyIUg==
X-Proofpoint-ORIG-GUID: j8QmQ9qetwYtgVkanB61CEyb2ZiU2QSB
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4e2bc2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=p0WdMEafAAAA:8 a=qbmh3WIrUlWDy8wL8UgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDEwNSBTYWx0ZWRfX5aO0wHYZeoHI
 ZP3RiwRFfR6vVcvWj1MR749jCnmy+4SuH1gUfZ1x64+T3q1M2Uv3Qpa10RkvOhWaj+e5flmYSmz
 o8UycDz5dTbBu/k1E02AUdbGCs/RAWc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080105

This series aims to add a couple of new powerpc tests and improve the
powerpc build structure.

This is originally Nick's work. The last version (v10) of which can be seen here :
https://lore.kernel.org/linuxppc-dev/20240612052322.218726-1-npiggin@gmail.com/
Couple of patches from the series are already merged.

Since it has been 2 years since this series was posted, I originally
posted this as a RFC. This v1 series has changes accomodating the review comments
received in the RFC :
https://lore.kernel.org/kvm/20260602064806.3101025-1-rathc@linux.ibm.com/

I have rebased the patches to the upstream state.
For the patches which did not require any changes in the existing upstream code,
I have retained the "Reviewed-by"s and "Acked-by" (patch 3,5 & 6) from
Nick's series. I have also added Andrew's "Reviewed-by" received on
patch 2 in the RFC. Nick had originally introduced powernv tests as well.
Removed it for now since it was causing CI failure in the current upstream.

Link to Gitlab tree with patches :
https://gitlab.com/rathc/kvm-unit-tests/-/tree/ppc64
Link to Gitlab pipeline :
https://gitlab.com/rathc/kvm-unit-tests/-/pipelines/2661271889

Change log from RFC :
1. Patch 2: Added Andrew's "Reviewed-by".
2. Patch 4: Removed usage of gitlab-ci group to run test - Thomas
   It would be nice to make use of the gitlab-ci group, but doing the
   change of all archs would make sense in a separate series. I look
   forward to doing that.
3. Patch 6: Removed addition of panic test in gitlab-ci group - Thomas

There was a discussion on the build failing in Travis CI with Clang, in the
RFC, which I have addressed there.

Nicholas Piggin (6):
  powerpc: add pmu tests
  configure: Make arch_libdir a first-class entity
  powerpc: Remove remnants of ppc64 directory and build structure
  powerpc: gitlab CI update
  scripts/arch-run.bash: Fix run_panic() success exit status
  powerpc: Add a panic test

 .gitlab-ci.yml                             |  21 +-
 MAINTAINERS                                |   1 -
 Makefile                                   |   2 +-
 configure                                  |  21 +-
 lib/{ppc64 => powerpc}/asm-offsets.c       |   0
 lib/{ppc64 => powerpc}/asm/asm-offsets.h   |   0
 lib/{ppc64 => powerpc}/asm/atomic.h        |   0
 lib/{ppc64 => powerpc}/asm/barrier.h       |   4 +-
 lib/{ppc64 => powerpc}/asm/bitops.h        |   4 +-
 lib/{ppc64 => powerpc}/asm/io.h            |   4 +-
 lib/{ppc64 => powerpc}/asm/mmu.h           |   0
 lib/{ppc64 => powerpc}/asm/opal.h          |   4 +-
 lib/{ppc64 => powerpc}/asm/page.h          |   6 +-
 lib/{ppc64 => powerpc}/asm/pgtable-hwdef.h |   6 +-
 lib/{ppc64 => powerpc}/asm/pgtable.h       |   2 +-
 lib/powerpc/asm/processor.h                |   2 +
 lib/{ppc64 => powerpc}/asm/ptrace.h        |   6 +-
 lib/powerpc/asm/reg.h                      |   9 +
 lib/powerpc/asm/rtas.h                     |   1 +
 lib/powerpc/asm/setup.h                    |   1 +
 lib/powerpc/asm/spinlock.h                 |   6 +
 lib/powerpc/asm/stack.h                    |   3 +
 lib/{ppc64 => powerpc}/asm/vpa.h           |   0
 lib/{ppc64 => powerpc}/mmu.c               |   0
 lib/{ppc64 => powerpc}/opal-calls.S        |   0
 lib/{ppc64 => powerpc}/opal.c              |   0
 lib/powerpc/rtas.c                         |  16 +
 lib/powerpc/setup.c                        |  20 +
 lib/{ppc64 => powerpc}/stack.c             |   0
 lib/ppc64/.gitignore                       |   1 -
 lib/ppc64/asm/handlers.h                   |   1 -
 lib/ppc64/asm/hcall.h                      |   1 -
 lib/ppc64/asm/memory_areas.h               |   6 -
 lib/ppc64/asm/ppc_asm.h                    |   1 -
 lib/ppc64/asm/processor.h                  |   1 -
 lib/ppc64/asm/reg.h                        |   1 -
 lib/ppc64/asm/rtas.h                       |   1 -
 lib/ppc64/asm/setup.h                      |   1 -
 lib/ppc64/asm/smp.h                        |   1 -
 lib/ppc64/asm/spinlock.h                   |   6 -
 lib/ppc64/asm/stack.h                      |  11 -
 lib/ppc64/asm/time.h                       |   1 -
 powerpc/Makefile                           | 111 +++-
 powerpc/Makefile.common                    |  94 ----
 powerpc/Makefile.ppc64                     |  31 --
 powerpc/pmu.c                              | 567 +++++++++++++++++++++
 powerpc/run                                |   2 +-
 powerpc/selftest.c                         |  17 +-
 powerpc/unittests.cfg                      |  17 +-
 scripts/arch-run.bash                      |   1 +
 50 files changed, 817 insertions(+), 195 deletions(-)
 rename lib/{ppc64 => powerpc}/asm-offsets.c (100%)
 rename lib/{ppc64 => powerpc}/asm/asm-offsets.h (100%)
 rename lib/{ppc64 => powerpc}/asm/atomic.h (100%)
 rename lib/{ppc64 => powerpc}/asm/barrier.h (83%)
 rename lib/{ppc64 => powerpc}/asm/bitops.h (69%)
 rename lib/{ppc64 => powerpc}/asm/io.h (50%)
 rename lib/{ppc64 => powerpc}/asm/mmu.h (100%)
 rename lib/{ppc64 => powerpc}/asm/opal.h (90%)
 rename lib/{ppc64 => powerpc}/asm/page.h (94%)
 rename lib/{ppc64 => powerpc}/asm/pgtable-hwdef.h (93%)
 rename lib/{ppc64 => powerpc}/asm/pgtable.h (99%)
 rename lib/{ppc64 => powerpc}/asm/ptrace.h (89%)
 create mode 100644 lib/powerpc/asm/spinlock.h
 rename lib/{ppc64 => powerpc}/asm/vpa.h (100%)
 rename lib/{ppc64 => powerpc}/mmu.c (100%)
 rename lib/{ppc64 => powerpc}/opal-calls.S (100%)
 rename lib/{ppc64 => powerpc}/opal.c (100%)
 rename lib/{ppc64 => powerpc}/stack.c (100%)
 delete mode 100644 lib/ppc64/.gitignore
 delete mode 100644 lib/ppc64/asm/handlers.h
 delete mode 100644 lib/ppc64/asm/hcall.h
 delete mode 100644 lib/ppc64/asm/memory_areas.h
 delete mode 100644 lib/ppc64/asm/ppc_asm.h
 delete mode 100644 lib/ppc64/asm/processor.h
 delete mode 100644 lib/ppc64/asm/reg.h
 delete mode 100644 lib/ppc64/asm/rtas.h
 delete mode 100644 lib/ppc64/asm/setup.h
 delete mode 100644 lib/ppc64/asm/smp.h
 delete mode 100644 lib/ppc64/asm/spinlock.h
 delete mode 100644 lib/ppc64/asm/stack.h
 delete mode 100644 lib/ppc64/asm/time.h
 delete mode 100644 powerpc/Makefile.common
 delete mode 100644 powerpc/Makefile.ppc64
 create mode 100644 powerpc/pmu.c

-- 
2.53.0


