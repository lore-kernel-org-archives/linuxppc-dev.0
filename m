Return-Path: <linuxppc-dev+bounces-25016-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C844BC53200
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 14:54:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9Fj56g47z2ygW;
	Thu, 30 Jul 2026 00:54:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785336857;
	cv=none; b=W2Un3kBUaDm9Qvqe2N2CP7pKOS4+XvU9Im82ifyDqxgVJaPib4xkQHBrY1G9SQ2MLRhxjQfYXv1p2KL7q+G6LZ8BkRyWHHUbF2tJUsVlb/HycaWord8YMs5VRGLFM1x8D7X7rTM1zrKaQb3IoLLTPyFpwdMaO++U7OXoMGRuhrS9RAVwjGYT+WllroQtbuHpufXukUe9l5BScGtZwv4RhkE0gY70R72yr+m1Ww3xCeMAU9uKD+3Zw9zo15Ue1DDdp0e4FNGGdoIUkZqQbpapOTe/YEJ3cca8f2wvA3Jt6JCwq4El2kZYwbeVGXxoHUsklScQF3lRsl0haHsP9mNBhw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785336857; c=relaxed/relaxed;
	bh=8x+udSqhzakEmu48jpIiBSP9yGjwhGYUVmstpH0Goos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N22Ka6+Pai1x16uOlQlkPQAlkS30tiAHuqLYwVSt3ennXB111Urs9YhuSW0jED2tvWc7GX8AZFWbGzanfbyADf2Lif4IX8spci3aRUrnrDUw3XQI3QPOXmT5jYJi+w6jkKhJFmGIZC6VDFJ4F8YK7zXjUTi470b1KuhZzd7jFIp2EiqhvWwaUfVPQbnFk+z5v2lBkyef9BAMUVef98y/+i/Nus6vzPH7WUvuvdicGqihuUOURaHuak1nflx6wBtHk0ebszUWPf9m/EeU47iCtd9khYvjDro/rwXKFZsadshMwgCPwuhLkGneeAOO1lxUcDSFSB7irQL78BxLl9Bh2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mdNyyB/9; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mdNyyB/9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9Fj45mVfz2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 00:54:16 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TEmELB322963
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 14:54:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=8x+udSqhzakEmu48jpIiBSP9yGjwhGYUVmstpH0Go
	os=; b=mdNyyB/9gZtaeO8mNtRt3chjc8hJ5//AcEZJbA52Evrtkq9AVFICinCqp
	G89k9yQgb/EptU4CEcRXj6TY/BYgzH7TNLmMLyzAqLyV7srDoSy4dEXsN9Mtzh8y
	MdauMX+Her+RvEsuBNlObTn19Ot9iUQN/aLeZ/6BH6MU+15ClpO1OvctkOJCmk5O
	Fyop2Hd4Nx5m4aRkYjyyPb4eiM7uQ32ntH8679Rf6x+x+vROyHS0/kXr5yoOvRWy
	yVtyo1GZdO/Ito7P6XgDGylPtbAWqqfg7L3YvPi5vP285xNt0UvAEBWZQTg33Ly5
	nvBONYj1mklNfKYAEI88QRTHteJaw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xu965-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 14:54:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TEfPiC029192
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 14:54:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fk75mb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 14:54:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TEs8Rs31260928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 14:54:08 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F33B12004D;
	Wed, 29 Jul 2026 14:54:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D38C20040;
	Wed, 29 Jul 2026 14:54:07 +0000 (GMT)
Received: from jupiter.ibm.com (unknown [9.39.23.158])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 14:54:06 +0000 (GMT)
From: Mahesh Salgaonkar <mahesh@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH 0/4] Base support for Power12
Date: Wed, 29 Jul 2026 20:24:01 +0530
Message-ID: <20260729145405.3230272-1-mahesh@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
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
X-Proofpoint-GUID: L3wNgeTuI5aKqzhh03Dvhuts4y90nfV5
X-Proofpoint-ORIG-GUID: L3wNgeTuI5aKqzhh03Dvhuts4y90nfV5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMCBTYWx0ZWRfXws6OwuGfXD3A
 cbLXTk6Okwisuq2dfo5Vou5QN6YJpH1sX73d13I9NZnR9hZLBE2Fh2WAz+A+mWabqLXTfSQM6FT
 n3vMCFZcOqcxE/ZAlZ1Kla5VNGD3El4=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6a1415 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=uhfDVMxXC6tmgyIzHsYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMCBTYWx0ZWRfX0h8U5rJU5LHO
 D8Yu539G5q4eBArs4SyE6jeQaOGmrdYVSfYzNGN3sfiLEM+GZRcwehOmEUbHGCGnsDw7TvZviCa
 fGIwcvbw+4vusT7ylMx+54JelxGAQHMKUpsxjXmWfID1XYkEzTkTC2wGq+BIxmSecjiceWuKQFt
 Ax7JJ+EJvKDVvkLXlp9Gh/Coz//I30U5wN1fNNuZhBFcp30Zu3VJtXXRylHTyRuNer31Nr78/fZ
 B1dcf8kExzWs77IWXQegYdEljJ+3P7QWyQS78fCsD/h9IfpO9ex4fJ1tMmK8osQnFdE8faJxGWV
 bDuvdSar1rQ5NjLTQMGnKtXQw/xrwrtVp6PhwSOwrZgdlaqziIL+NQQvUzBkWrgiA3chHysXwGG
 gowCBigDLMs5TpOuratPBNbIvqLBVn4gkuikkxINYCm+OEjenASy03gEEB9Jl1Rspk0gAYR8vdq
 p/SKr0Lbr2E7vFSVZJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290120

This series enables Power12 raw and architected mode with Performance
Monitoring support.

Athira Rajeev (1):
  powerpc/perf: Add power12 Base Performance Monitoring support

Mahesh Salgaonkar (1):
  powerpc/pseries: Limit PVR list to 16 entries for CAS negotiation

Nicholas Piggin (1):
  powerpc: Add Power12 raw mode

Ritesh Harjani (IBM) (1):
  powerpc: Add Power12 architected mode

 arch/powerpc/include/asm/cpu_setup.h      |   2 +
 arch/powerpc/include/asm/cputable.h       |  17 +-
 arch/powerpc/include/asm/mmu.h            |   1 +
 arch/powerpc/include/asm/prom.h           |   1 +
 arch/powerpc/include/asm/reg.h            |   5 +-
 arch/powerpc/include/asm/synch.h          |   6 +-
 arch/powerpc/include/uapi/asm/cputable.h  |   2 +
 arch/powerpc/kernel/cpu_setup_power.c     |  43 ++
 arch/powerpc/kernel/cpu_specs_book3s_64.h |  36 ++
 arch/powerpc/kernel/dt_cpu_ftrs.c         |  37 ++
 arch/powerpc/kernel/prom_init.c           |  30 +-
 arch/powerpc/kernel/setup-common.c        |   1 +
 arch/powerpc/kvm/book3s_hv.c              |   9 +-
 arch/powerpc/mm/book3s64/hash_native.c    |  22 +-
 arch/powerpc/mm/init_64.c                 |   4 +-
 arch/powerpc/perf/Makefile                |   2 +-
 arch/powerpc/perf/core-book3s.c           |   2 +
 arch/powerpc/perf/internal.h              |   1 +
 arch/powerpc/perf/power12-events-list.h   |  78 ++++
 arch/powerpc/perf/power12-pmu.c           | 466 ++++++++++++++++++++++
 20 files changed, 742 insertions(+), 23 deletions(-)
 create mode 100644 arch/powerpc/perf/power12-events-list.h
 create mode 100644 arch/powerpc/perf/power12-pmu.c

-- 
2.55.0


