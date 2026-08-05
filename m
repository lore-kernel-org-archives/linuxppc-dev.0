Return-Path: <linuxppc-dev+bounces-25428-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E3BC55ABA
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2026 11:09:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFSNb2JX3z2y1Y;
	Wed, 05 Aug 2026 21:09:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785928175;
	cv=none; b=CR/Pl9pt9t69t3ecmCruIPqifqLxMngsbjNc+KVC/Hy8WXmmger14KTYCXSOYs3qwOLqKNq3rKynB6iyuMUWXphnoULeuMo3BHczO8Yr3xxclXG9vlop6BCkDVqctEMpm6OiraLB/s6uQgAvhaSp0HCzgJj5TWduyQSM7iSqE8+Y6heNdgM5fGe/RvTG8DZPmYWwmyBxtWL/UunJOeKXTAeJZPvK3VDcNGIeEC3U8LX0GLs2GF2TQ5SioD9DQOX6bNetQnRjO4z5MUyLf0MeMEq/2ISLmA7ZEF0FggC7JD20baosjgW72DeegVLqSylIJm0ZHgC/hOFfLuI2rxBeiw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785928175; c=relaxed/relaxed;
	bh=Qn1vz2hp1SWeyMHZMmjxND0R5biofDL7IVKus5yCsjw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z5RoiZrlXeigBcWnU9+Aka5dmm5V5aX1loaVkrhURpAa3MxUlB68FLIrQD94wkQSWVAeT3k72snewymotsKkC9Znh0oeMrDAhoYEmG9sDLkhdOMprREs3AlCU+6ewbd1fi39FXCgFybXbFLwxUP3bP/LkU5OthgDWxqKAFlmJwn77ii7gzDrqpv4jyNbCdxEFXv6jpDbr9qVxwoEVtSwpbLKW5DxeRPI2aGvON8TvVjK/u21PIJoTQiQWpdJtTL32RLUP8XPVmNFHhYcDvsOjfLhdKbtTXOZB7/iuuMilsDAFsWNeTePCBroP25PPkWRzgHVNCzHhncizq9tn3n/xg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HwqaOnV7; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HwqaOnV7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFSNZ2lHFz2xqM
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 21:09:33 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758m30s1504211
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Aug 2026 11:09:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Qn1vz2hp1SWeyMHZMmjxND0R5biofDL7IVKus5yCs
	jw=; b=HwqaOnV71s93x1Axa4qKzbMMoKopzSaDOE+3uP5gbXaCkl6lOPoXi69T4
	QI84ARYtRp2frZWsWxq24L7XdQX9W0jwWSyeoqp74KP+ZRQ61e2gdVAJYhzGFSv9
	8bfouSYrIkCrrFM/80wA1IFuu+aQnnAK8wWU7tBReEj2YBFae1See0t3X80XDcBh
	u6HwT67juh7iINxKUzARI4yUxkYmdbB9dC+LlwSMFmGD+eMImkLrqQKQnt9I4dhp
	OgAdEVhHkDPxh+qt2sArzjK5d78d0F3e6ctaMAhTXTOHK1Vv/yVIO8sspAbk9Ymk
	Z6nAHpPMwwz4sHnSRBgjOPA14D/qQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqtkd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 11:09:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675AuHZm020186
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Aug 2026 11:09:31 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbge1fh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 11:09:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675B9Rku51642754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 11:09:27 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 166562004B;
	Wed,  5 Aug 2026 11:09:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1677D20040;
	Wed,  5 Aug 2026 11:09:26 +0000 (GMT)
Received: from jupiter.ibm.com (unknown [9.39.28.36])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 11:09:25 +0000 (GMT)
From: Mahesh Salgaonkar <mahesh@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH v3 0/4] Base support for Power12
Date: Wed,  5 Aug 2026 16:39:20 +0530
Message-ID: <20260805110924.3853410-1-mahesh@linux.ibm.com>
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
X-Proofpoint-GUID: valeeVMg3YOncV6KkjiMpAk1JOU-Qo42
X-Proofpoint-ORIG-GUID: valeeVMg3YOncV6KkjiMpAk1JOU-Qo42
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX28U+eW43o4Re
 JrgH3gqiXMheNoGWqci8f3tKmW4btzR/IZPR79PN/7LuK3YbtI1utViJdoUx7ZSgK4nQtn1Dwo3
 HQMZP7UiE/Yy7Ey3S4uzSwXfsGwLnrQ=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a7319eb cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=3CkFMB8pvBsbaMSk_jkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX9NVVzaa/H90a
 eEXoxIzJB63HlzDkluiskVdnL2g5Jb/4haQsL4cRAPY3lLqWhx+K6IZTIAPP0UT4vGHTJxuTFel
 YY1rrbfoha5odfpm+21LP+iY0OQ+Xf1tgNnyDAc9Xs01hvH5LG0Qsd6KxM7lykUzwIQ1Nd64ziE
 nR/57fa0x28bPPDP5ZF652tSglwCiMdcUpzuVobkoO/T3gpBh5ZxpVk/z93q7lKIEjbciTtCgy4
 UiVwvrnm3w1yvXOLW7uYwa12eiheg3n4mS5oFuE/Zf2YO2B0sYj0rHbCXbKw06NEsMPybNSQW9y
 7NFYOKyGEGE4ZgKZeUtt5zBoMJ+rysr7arxYylktH63ljwmBaUeM9EVMC4tH0HUVzasoxiSgGcu
 FOsPZk63E/r/tgFhcJinjwcaEsLCBGkfa25JEtqwXXEeDMSXyI70X+hn369lGSQNuXMU2T7Qp7h
 Yf7a2ynThTD03XVKkSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050086

This series enables Power12 raw and architected mode with Performance
Monitoring support.

Changes in v3
- Rebase patch series on v7.2-rc6
- Remove extra tab in #define to maintain visual alignment.
- Remove unintentional whitespace change.
- See v2 at https://lore.kernel.org/linuxppc-dev/20260803155724.3272052-1-mahesh@linux.ibm.com/

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
 arch/powerpc/include/asm/prom.h           |   3 +-
 arch/powerpc/include/asm/reg.h            |   5 +-
 arch/powerpc/include/asm/synch.h          |   6 +-
 arch/powerpc/include/uapi/asm/cputable.h  |   2 +
 arch/powerpc/kernel/cpu_setup_power.c     |  43 ++
 arch/powerpc/kernel/cpu_specs_book3s_64.h |  36 ++
 arch/powerpc/kernel/dt_cpu_ftrs.c         |  37 ++
 arch/powerpc/kernel/prom_init.c           |  46 ++-
 arch/powerpc/kernel/setup-common.c        |   1 +
 arch/powerpc/kvm/book3s_hv.c              |   9 +-
 arch/powerpc/mm/book3s64/hash_native.c    |  22 +-
 arch/powerpc/mm/init_64.c                 |   4 +-
 arch/powerpc/perf/Makefile                |   2 +-
 arch/powerpc/perf/core-book3s.c           |   2 +
 arch/powerpc/perf/internal.h              |   1 +
 arch/powerpc/perf/power12-events-list.h   |  78 ++++
 arch/powerpc/perf/power12-pmu.c           | 466 ++++++++++++++++++++++
 20 files changed, 760 insertions(+), 23 deletions(-)
 create mode 100644 arch/powerpc/perf/power12-events-list.h
 create mode 100644 arch/powerpc/perf/power12-pmu.c

-- 
2.55.0


