Return-Path: <linuxppc-dev+bounces-24417-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C67C4450A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 19 Jul 2026 13:00:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h33fk5BBVz2xYg;
	Sun, 19 Jul 2026 23:00:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784466046;
	cv=none; b=lKiOqGPusBlZ/4LbTqDBgm4Y1b57W4C34aawifJ7+vUqfSFxnc14PNpEv7lg1845xDP8+b3ZM9cqM5nLqGrASchGa89yfl62KeANu0TA/vrFmwsKWao4aEFQ5SsbA98EpiF6pvMrDNmeV/CfL7SNYXZ4xHfwEhZtiObzcvllnpZbIIBPf40Y8JIldxcH/XMkatNvw+57M8d7CNlwfz92mJX4ywW4MbX2d9dzi5zKYLGnhrsShPywH/Vr4Z22z0LvmatGtLFNRmsEdCiOrTSCnAVY6QJRFqxXrMqvBXrFTvZIcpo52z+NCTE40sVzsAAnDWrwsgqQFXFF0OTjRi21kg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784466046; c=relaxed/relaxed;
	bh=9jWfDmwdhTGoqfNFTEeqe4nf2DNYa7FlOgeY6USlaFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EHVH3MV9MrX1xhdHjOuQLJDhN2HAz2nsVzuIqwq8mySVEV1FmG4jzRmc3jCS6dyKVzIQ78pGFCriVXruVrBA1qnsmWO6kQwXcFGfQrhrft+66nBIrRsIj0+DZRW4gltsPWzFBwm1Gjrn/JHFBV1meKxsPGGrPP+62zaw8yxYgaInbIDSkvH7e8NG0eK22nuk6evWA/ENxJZzNX7Go/7Jd0fVG4oY2er4/5c8Albs/KyZwRJkT8prLuTkoS4pM+S9eUgY/YMYuxSc22OD1ZgxYncqro0DWlh7J4xSYq6aUEii2pZIRSi697ZAvnNyLhmckxlpqRPfiSQ6rKXHP8UX7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QCw/Qc+b; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rathc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QCw/Qc+b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rathc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h33fj5Cl2z2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jul 2026 23:00:45 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JBBoqC3351320;
	Sun, 19 Jul 2026 13:00:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=9jWfDmwdhTGoqfNFTEeqe4nf2DNYa7FlOgeY6USla
	Fs=; b=QCw/Qc+b1Slq6jzWeSVcFMyrxGT+ukFOZIqZuIHcFHMq1jFpW+PS2Ynvy
	I1WOTIJLW3yhUVpIl66ggxdRHjB6KJOetHDfCpbLLZNmhgOawiwe1mR4EPZ7C6R7
	xkEvmy1Y0iK1WzyLJq0GVkCwXccnYQjFFTaWJ/3Rpy2hTbWNleAQAWcP8qkVy0zV
	nGtHzBNjvD9Ddi8KBJieZXtvdFMwHveC2frfC+ejVYVpM8Od/aYOXZVTcjL/Z3MD
	vfnbTFXiyykvCZTaxujB8zGyTBYWCkl6rbnsC4zsYpThsdSrjIMIZJGcmZosKQQR
	4Ckq8nB9drgWewN5S4zHSlCk2ZT1Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ab3fs3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Jul 2026 13:00:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66JCna26032399;
	Sun, 19 Jul 2026 13:00:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1g1fd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Jul 2026 13:00:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66JD0ZoE48496994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Jul 2026 13:00:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32AB820043;
	Sun, 19 Jul 2026 13:00:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4834520040;
	Sun, 19 Jul 2026 13:00:31 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown [9.124.218.35])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 19 Jul 2026 13:00:30 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: thuth@redhat.com
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, lvivier@redhat.com,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        andrew.jones@linux.dev, sbhat@linux.ibm.com,
        Chinmay Rath <rathc@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v2 0/6] powerpc improvements
Date: Sun, 19 Jul 2026 18:30:21 +0530
Message-ID: <20260719130027.2347519-1-rathc@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDEzOSBTYWx0ZWRfX69uWcnsT1qz8
 8twoL0+AZ0eounXEcTGfo/1w4gzI5cJYFjcv9gNEw/U3RQlXEYgXrGptfguVlkYsMlk6hloD72X
 AV1YXBKHk7oh3F54PAhQEV/ViGtFVsGrT5LnfqsVRMDHnixU0xZ+10f+q7Zmtm+GaTp5ilwURg3
 7eu7gJWlnZgoCsKl1tgVjBP7I2XfsA81mc9zB1DDAL7FycP0lfYb9N3OnYOFoNVm66O0j/RwXWh
 lsISCeZ/kBWLddspKZ0MQta5G9alO4QeBM6pKhKWknk+vcp2A2ktzQ5ojH1aQfAiZ5D4xv2NPAa
 cHKnBKH6SyX/nVM4WZdhvezmfuktypa4LWVp9y0Vs3gjCyd2MPU+1002IQmJ6iMft1SEonMrU/E
 ee3yrS8Bikos0+dvNpxRoH9wAyOBMGEuyuUvbTDqrjgr1mKyQ5+a1xvfBKGO2Hy36snr7M+QtN2
 3t2H8PIrv4ypF79SZpg==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a5cca78 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=p0WdMEafAAAA:8 a=KPU2q0h6MznVOrGVyXwA:9
X-Proofpoint-ORIG-GUID: 8i2l8iREW0qpTc3CM_cPvEg-65nPYMQX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDEzOSBTYWx0ZWRfX2ft8x7xTpBty
 AJGd8RH7Tknvr92Q2ekyO0tFhfoR6LxzE1xrOYPABSD257of2gef2brD9Ty3227cH3JPYS+rsl9
 89nFqw2+RW+hLZRe10sWKp938/QY70g=
X-Proofpoint-GUID: DEBAe5hHC6MMGHI3vj_Xj9jhk0-sY6Vp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607190139

This series aims to add a couple of new powerpc tests and improve the
powerpc build structure.

This is originally Nick's work. The last version (v10) of which can be seen here :
https://lore.kernel.org/linuxppc-dev/20240612052322.218726-1-npiggin@gmail.com/
Couple of patches from the series are already merged.

Since it has been 2 years since this series was posted, I originally
posted this as a RFC. This v1 series has changes accomodating the review comments
received in the RFC :
https://lore.kernel.org/kvm/20260602064806.3101025-1-rathc@linux.ibm.com/
v1:
https://lore.kernel.org/kvm/20260708105122.1177210-1-rathc@linux.ibm.com/

I have rebased the patches to the upstream state.
For the patches which did not require any changes in the existing upstream code,
I have retained the "Reviewed-by"s and "Acked-by" (patch 3,5 & 6) from
Nick's series. I have also added Andrew's "Reviewed-by" received on
patch 2 in the RFC. Nick had originally introduced powernv tests as well.
Removed it for now since it was causing CI failure in the current upstream.

Link to Gitlab tree with patches :
https://gitlab.com/rathc/kvm-unit-tests/-/tree/ppc64
Link to Gitlab pipeline :
https://gitlab.com/rathc/kvm-unit-tests/-/pipelines/2688519679

Change log from RFC to v1:
1. Patch 2: Added Andrew's "Reviewed-by".
2. Patch 4: Removed usage of gitlab-ci group to run test - Thomas
   It would be nice to make use of the gitlab-ci group, but doing the
   change of all archs would make sense in a separate series. I look
   forward to doing that.
3. Patch 6: Removed addition of panic test in gitlab-ci group - Thomas

There was a discussion on the build failing in Travis CI with Clang, in the
RFC, which I have addressed there.

Change log from v1 to v2:
Patch 4: Addressed all comments by Thomas :
1. Removed extra blank line.
2. Removed accel=kvm test from gitlab-ci.
3. smp = 2 preserved in atmoics test.

Nicholas Piggin (6):
  powerpc: add pmu tests
  configure: Make arch_libdir a first-class entity
  powerpc: Remove remnants of ppc64 directory and build structure
  powerpc: gitlab CI update
  scripts/arch-run.bash: Fix run_panic() success exit status
  powerpc: Add a panic test

 .gitlab-ci.yml                             |  18 +-
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
 powerpc/unittests.cfg                      |   8 +
 scripts/arch-run.bash                      |   1 +
 50 files changed, 806 insertions(+), 194 deletions(-)
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


