Return-Path: <linuxppc-dev+bounces-25279-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC1BC55184
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 15:57:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDLss30HXz30F0;
	Tue, 04 Aug 2026 01:57:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785772657;
	cv=none; b=DdQfODzZSuqvmo43gTJcxtO3NAy+CPgzsWqzEMqnyHHOTUs8djS7pLKCknfvROjJ4SUieYQVoDmRcMZipONGDNFXueHI2H0vjXfkIPZ+iW9EXYe1hcrVAYCNVvC3Saao6ndJmGbU+JIVeNklfqBnHEfzfVFN3//2q4ol/HS61KLfBxtALf4H1KpjxEWLPBrT4ExpQn3yoj/cMfWnsk8iByUjE7C0OBQ9lV01UqJX3o4NsxAGmGdsJAIryBrjwbvfs9AZC+ScsMT+MVGU3ggtXMtrEmTIOuCAMWisc6PyFJeCXT9QuCwm7kBzqipp60rASd7Bw398uxeDrifaY2jaHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785772657; c=relaxed/relaxed;
	bh=GAHK6bqfniJ+VCT34B/WO9G0pczgmZr1jzf1BiN3Sts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HRaXh4JaG7UTf0xoWVWebLcK+TappPiKwUdK/EaBvarsG9wtjoUlca6w7UEnuEmnlV70qi9kFa3Ml0STBT02qserCONzJTjJkiRpSSXrTGWRqgufumWVN+tFGABC3ziN7jDrOndZ8tIY1jZEKwo1mWsashMyG0ny2CxMbo4jnZ4QAJaHS8QWqYKXLv6lnYjzSQX1MsgTVJjXwtN/cql2nTgoz9gJ9STDj2kt/Y8oFp7GTxgZhy2awolSKGZ/sdKkkzdlC6LSfoWiEXdb5beLCf5AzrGzrljxc1VNdGlftyV7ddQOetRnr4vPqU7U3WVAOMj1/PsCUysPn3DzcLkMKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gjf++ODW; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gjf++ODW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDLsr0nZjz2yQJ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 01:57:34 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EHqh82206303
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Aug 2026 15:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=GAHK6bqfniJ+VCT34B/WO9G0pczgmZr1jzf1BiN3S
	ts=; b=gjf++ODWgm+CDATJ3dlHTHInoaqcjpgKXVgLprrSfXvWlpzjTxjS+ZrRb
	dgOdY+jTaoiT3u0nWDwPh5GQyRIpi4mG33T216ujr+EVcnbFJgJEbdGMapZijQ8b
	9uQW2k/8xpbNGYdzqCnKmOVncR2CpUxY2iz8Gu3d+YJCBWO00dCIQE4ogkirZ7ip
	fDqPoooyxA9GjppP09BJT/Lq9t/3JPVQW+69bCrtvO7CgWIdBPjQOxGWI1jZkvwF
	meiu+DzcJ9gBo33NM1LyTnnYk9OamW6ukAfvCzZtTkEKvK4y8WVIZumANaMls4ay
	VqFfvrTS3ftKH34EVj1e63ER+x4/A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77g1fnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 15:57:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673FuOUl025701
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Aug 2026 15:57:31 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtydv1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 15:57:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673FvRwQ36241702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 15:57:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2585B2004B;
	Mon,  3 Aug 2026 15:57:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3698D20040;
	Mon,  3 Aug 2026 15:57:26 +0000 (GMT)
Received: from jupiter.ibm.com (unknown [9.39.27.35])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 15:57:25 +0000 (GMT)
From: Mahesh Salgaonkar <mahesh@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH v2 0/4] Base support for Power12
Date: Mon,  3 Aug 2026 21:27:20 +0530
Message-ID: <20260803155724.3272052-1-mahesh@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX9UjOBdXx6MRm
 ui0wCHr5D1d2+4PF6Rh/UJ11/FyqGVu1ps/IAgp1TyPRZL7xar1YUqRAx1t3me+lVfdI160cWTk
 XU4jeIlboitd0ZKzamUtovNqFPOL8uSXAqYnM36kSfjHktVDoKwEIbPKnVH5CgfZTqouRkUbW4V
 5aiBoDQ2lycqToTRDQLXdW+TZotljBmpCKBjEyfjWB83j0K/HnljkqhBL37U7GNYQFtRSbtoRau
 3RM6l0lcPj8aE0PHHLVNJcJHqaVHAl/2AwTRMw442CcYbFtcLEaChNJGd0Xpus7RT67aatTNUev
 EjFdqThcpgsmXkX1YT4Wn4jkBRT3gLHTIdpASmr1YQfFfNPeeqjVp1dmFvRX4GPsNGs6fKv7a6G
 IH2YnteewEwuBbIcR9TbATenBl0MixFLtZ/RgItHaJ+IlTlqsQHbKmI26JJ4oY6f9Rhc8/KdqLg
 5rQQSWKRMmqdx9nHwnA==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a70ba6c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=wf_Bq18p4sLT3iSGlooA:9
X-Proofpoint-GUID: BkTCWB9TsbVws2nld7D98mMxspvfr36A
X-Proofpoint-ORIG-GUID: BkTCWB9TsbVws2nld7D98mMxspvfr36A
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfXyhf4SjwNBYGJ
 eAkpC4JNnxaSRepQd0yLsErfBJ8nEWSUJIZeuTCU1Wb69z3lL5WCkUKZ8ooRU6ql7WYNPIa5nBX
 twVq8ItTcYcEjMnoVVR3mLMDqMr+cV4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030141

This series enables Power12 raw and architected mode with Performance
Monitoring support.

Chnages in v2:
- Fix typo reported by Nikhil
- Define a named macro CAS_MAX_PVR_ENTRIES
- See v1 at https://lore.kernel.org/linuxppc-dev/20260729145405.3230272-1-mahesh@linux.ibm.com/

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
 arch/powerpc/kernel/prom_init.c           |  47 ++-
 arch/powerpc/kernel/setup-common.c        |   1 +
 arch/powerpc/kvm/book3s_hv.c              |   9 +-
 arch/powerpc/mm/book3s64/hash_native.c    |  22 +-
 arch/powerpc/mm/init_64.c                 |   4 +-
 arch/powerpc/perf/Makefile                |   2 +-
 arch/powerpc/perf/core-book3s.c           |   2 +
 arch/powerpc/perf/internal.h              |   1 +
 arch/powerpc/perf/power12-events-list.h   |  78 ++++
 arch/powerpc/perf/power12-pmu.c           | 466 ++++++++++++++++++++++
 20 files changed, 759 insertions(+), 23 deletions(-)
 create mode 100644 arch/powerpc/perf/power12-events-list.h
 create mode 100644 arch/powerpc/perf/power12-pmu.c

-- 
2.55.0


