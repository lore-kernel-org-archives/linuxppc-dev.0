Return-Path: <linuxppc-dev+bounces-25432-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BEF2C56201
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2026 11:10:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFSNn5VNkz2y8c;
	Wed, 05 Aug 2026 21:09:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785928185;
	cv=none; b=i7RC/a+VvHr/dj0yoWQV+jEqOSSD6nabxmuGH9PUNW4ZT1xS+BkNNRjOYLgp6xT8k5n29QnIMt5YSx87QvEs8aN7iLWmcnUjUZZjZ/vXkjvdF6NnRdMADSTb43tA4SeA0bFppm8nDeYBqeLswI4aW+KJD31jujz+QaqAlaO0gHD/3ZYFywB58HHu1bK2Wj9g/XN4b0yeWWyDerWy6RZiBPBStbiIujN+wRh+T0GU7+GOgbTgUkTsI//KI2Y+Vk0zmmKYzYY556v+wRRvmIt2eC1XVHUihCWrwbhx0XBQHcIxPSq1rGc+cn/G7CtPxRX0PpqZZu54wqCRKzzZqT2ZRA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785928185; c=relaxed/relaxed;
	bh=tNG0xkk3z6OZUvWZo9k46TvZTI8ZPmGHu/SC3Du+DBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XuUGk7YV58IvY1zeMgQTv5kplmQAp3ozX9IYIIU43pyOZX4ewH/2W9vr0aTHqnGUJ2NQQfmdK2Lw7JicID2hHlwYq1JSrvbeFacTnqlKamCjlpM+5/4QgMlvRMbnAIUpTIX9vVRFauX4Tk9SuttBBqOh7yuHG1ojkufoDOWDxLbtrnOxOugi/Ulji0V0B7WH8vL4Jhr+ksbceHtB8aq4zPSDYxDen0e/ptO4aIoecat/1F6nkKwclFCEuwVzYgatRm66k7Xx/QE9b7gN8+z3ZRGACV5n3pgTPCL/KMkw1k9kjt3mMwDtszxwVhhlViFYLl955DGFNIQdB+PxaW30Ug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Wy2uyacJ; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Wy2uyacJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFSNm4zjLz2y1Y
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 21:09:44 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758lnf91503344
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Aug 2026 11:09:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tNG0xkk3z6OZUvWZo
	9k46TvZTI8ZPmGHu/SC3Du+DBQ=; b=Wy2uyacJI4NCSN+HIZShmrlm6J2ufJgfu
	g69+K3sOEYwoS1e++YspbjJvsJwX/pO8Yjt+eFULccrQ/YTDsDchhk6YbruqD3gu
	sZwK8CP+1yWqMsKDI+UaaEyPEEV1lFzKAWDV5Il58vRSV4+d55HVJgSRDSn9/H+A
	8BTyDVPXTK97/Bz/m/P9U+1HSACC0QAck2JHAXG0fJXrcKdnlyWpRia+Zp65fpOZ
	Y/t6DpvG+CrrYdYS3m8WvJ+8r5SvRqa2Z0n+nR96TbdPMx8xlTL0nyqGS2nyTJJI
	7+4oeurT8dG16L6dTXfUTe5gpq3ImOCEkNgeOSF+3SfJAbRgFOlyA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqtkdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 11:09:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675AuG9I011190
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Aug 2026 11:09:41 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhe58v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 11:09:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675B9bu038142290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 11:09:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CE932004B;
	Wed,  5 Aug 2026 11:09:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F35C20040;
	Wed,  5 Aug 2026 11:09:35 +0000 (GMT)
Received: from jupiter.ibm.com (unknown [9.39.28.36])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 11:09:34 +0000 (GMT)
From: Mahesh Salgaonkar <mahesh@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Athira Rajeev <atrajeev@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Praveen K Pandey <praveen@linux.ibm.com>
Subject: [PATCH v3 4/4] powerpc/perf: Add power12 Base Performance Monitoring support
Date: Wed,  5 Aug 2026 16:39:24 +0530
Message-ID: <20260805110924.3853410-5-mahesh@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805110924.3853410-1-mahesh@linux.ibm.com>
References: <20260805110924.3853410-1-mahesh@linux.ibm.com>
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
X-Proofpoint-GUID: cm0qTlNR-BID6F3fng13VxGQrcwrRWXh
X-Proofpoint-ORIG-GUID: cm0qTlNR-BID6F3fng13VxGQrcwrRWXh
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX4Zw5jYqKeb6H
 AaUjzJsrWI7l2dbBMpteFk8+NfVtd/gLpVhl3b/UOGkdUfnS8RU6k5ct7+tPOMfCY3xPDxMMQwo
 B14zDMoetFJwoa+I/duejVRfaAFbeqQ=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a7319f6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=2l87ty8nhBJ9UoGYMqwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX7awmsQtu6o81
 Sn5Pm5vUwxv9frpqtYp/+EdVW4MQsq7RnhHPQcfX9j4sHy/Rmr+fuAEtPYpjzrtq0Nm+cm22C3P
 /61qye0g6rP6PfRwOkVgv6m8o0jhLShEbQ7PpWluoMWgKsVQidLFyIpjiPNgLJXmjd/H101ck50
 zFbTOZvvYO/nr9Sx/qJWPfbHN3hmw/AMeSS+yT7S7CRlWGWFhIfw74Ued7rkqq7IrS0mNEL55Sx
 WOT/QLNJQrhACHqcJzu+5YsGAqJLOWRUM2FMxZkkB/7SU4AiXC72+4xD4rnmvyGFbAveRWj6m6i
 /P2O/MXtUANUuPG9uS+JQlwWkbik89HRJeo4IREYHYO/uSUXo0KHjJBcAQeKxKX1BgtD2FSxLz2
 2m2OVdKne1EdmPfYeuPPENSZm3ZLF2QmSC9z6q3HBCNTTNGLDFeZPwb6mlwkcvC6N+BZW4qBvxY
 ygFaHESD/Sh/6QaMDTw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050086

From: Athira Rajeev <atrajeev@linux.ibm.com>

Base enablement patch to register performance monitoring hardware
support for power12. Patch introduce the raw event encoding format,
defines the supported list of events, config fields for the event
attributes and their corresponding bit values which are exported via
sysfs.

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Tested-by: Praveen K Pandey <praveen@linux.ibm.com>
---
Change in v2:
- Fix typo reported by Nikhil
---
 arch/powerpc/perf/Makefile              |   2 +-
 arch/powerpc/perf/core-book3s.c         |   2 +
 arch/powerpc/perf/internal.h            |   1 +
 arch/powerpc/perf/power12-events-list.h |  78 ++++
 arch/powerpc/perf/power12-pmu.c         | 466 ++++++++++++++++++++++++
 5 files changed, 548 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/perf/power12-events-list.h
 create mode 100644 arch/powerpc/perf/power12-pmu.c

diff --git a/arch/powerpc/perf/Makefile b/arch/powerpc/perf/Makefile
index 78dd7e25219ee..bcc804c413381 100644
--- a/arch/powerpc/perf/Makefile
+++ b/arch/powerpc/perf/Makefile
@@ -7,7 +7,7 @@ obj-$(CONFIG_PPC_PERF_CTRS)	+= core-book3s.o
 obj64-$(CONFIG_PPC_PERF_CTRS)	+= ppc970-pmu.o power5-pmu.o \
 				   power5+-pmu.o power6-pmu.o power7-pmu.o \
 				   isa207-common.o power8-pmu.o power9-pmu.o \
-				   generic-compat-pmu.o power10-pmu.o bhrb.o
+				   generic-compat-pmu.o power10-pmu.o bhrb.o power12-pmu.o
 obj32-$(CONFIG_PPC_PERF_CTRS)	+= mpc7450-pmu.o
 
 obj-$(CONFIG_PPC_POWERNV)	+= imc-pmu.o
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 720b1a5009226..10ded865583c3 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2613,6 +2613,8 @@ static int __init init_ppc64_pmu(void)
 		return 0;
 	else if (!init_power11_pmu())
 		return 0;
+	else if (!init_power12_pmu())
+		return 0;
 	else if (!init_ppc970_pmu())
 		return 0;
 	else
diff --git a/arch/powerpc/perf/internal.h b/arch/powerpc/perf/internal.h
index a70ac471a5a5d..84d6ca209c492 100644
--- a/arch/powerpc/perf/internal.h
+++ b/arch/powerpc/perf/internal.h
@@ -11,4 +11,5 @@ int __init init_power8_pmu(void);
 int __init init_power9_pmu(void);
 int __init init_power10_pmu(void);
 int __init init_power11_pmu(void);
+int __init init_power12_pmu(void);
 int __init init_generic_compat_pmu(void);
diff --git a/arch/powerpc/perf/power12-events-list.h b/arch/powerpc/perf/power12-events-list.h
new file mode 100644
index 0000000000000..cc26796d418b3
--- /dev/null
+++ b/arch/powerpc/perf/power12-events-list.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Performance counter support for POWER12 processors.
+ *
+ * Copyright 2026 Athira Rajeev, IBM Corporation.
+ */
+
+/*
+ * Power12 event codes.
+ */
+EVENT(PM_CYC,				0x600f4);
+EVENT(PM_DISP_STALL_CYC,			0x100f8);
+EVENT(PM_EXEC_STALL,				0x30008);
+EVENT(PM_INST_CMPL,				0x500fa);
+EVENT(PM_BR_CMPL,                               0x4d05e);
+EVENT(PM_BR_MPRED_CMPL,                         0x400f6);
+EVENT(PM_BR_FIN,				0x10068);
+EVENT(PM_MPRED_BR_FIN,				0x27098);
+EVENT(PM_LD_DEMAND_MISS_L1_FIN,			0x400f0);
+
+/* All L1 D cache load references counted at finish, gated by reject */
+EVENT(PM_LD_REF_L1,				0x100fc);
+/* Load Missed L1 */
+EVENT(PM_LD_MISS_L1,				0x3e054);
+/* Store Missed L1 */
+EVENT(PM_ST_MISS_L1,				0x300f0);
+/* L1 cache data prefetches */
+EVENT(PM_LD_PREFETCH_CACHE_LINE_MISS,		0x1002c);
+/* Demand iCache Miss */
+EVENT(PM_L1_ICACHE_MISS,			0x200fc);
+/* Instruction fetches from L1 */
+EVENT(PM_INST_FROM_L1,				0x04080);
+/* Instruction Demand sectors writtent into IL1 */
+EVENT(PM_INST_FROM_L1MISS,			0x03F00000001C040);
+/* Instruction prefetch written into IL1 */
+EVENT(PM_IC_PREF_REQ,				0x040a0);
+/* The data cache was reloaded from local core's L3 due to a demand load */
+EVENT(PM_DATA_FROM_L3,				0x10340000003C040);
+/* Demand LD - L3 Miss (not L2 hit and not L3 hit) */
+EVENT(PM_DATA_FROM_L3MISS,			0x300fe);
+/* All successful D-side store dispatches for this thread */
+EVENT(PM_L2_ST,					0x010000046080);
+/* All successful D-side store dispatches for this thread that were L2 Miss */
+EVENT(PM_L2_ST_MISS,				0x26880);
+/* Total HW L3 prefetches(Load+store) */
+EVENT(PM_L3_PF_MISS_L3,				0x100000016080);
+/* Data PTEG reload */
+EVENT(PM_DTLB_MISS,				0x300fc);
+/* ITLB Reloaded */
+EVENT(PM_ITLB_MISS,				0x400fc);
+
+EVENT(PM_CYC_ALT,				0x0001e);
+EVENT(PM_INST_CMPL_ALT,				0x00002);
+
+/*
+ * Memory Access Events
+ *
+ * Primary PMU event used here is PM_MRK_INST_CMPL (0x401e0)
+ * To enable capturing of memory profiling, these MMCRA bits
+ * needs to be programmed and corresponding raw event format
+ * encoding.
+ *
+ * MMCRA bits encoding needed are
+ *     SM (Sampling Mode)
+ *     EM (Eligibility for Random Sampling)
+ *     TECE (Threshold Event Counter Event)
+ *     TS (Threshold Start Event)
+ *     TE (Threshold End Event)
+ *
+ * Corresponding Raw Encoding bits:
+ *     sample [EM,SM]
+ *     thresh_sel (TECE)
+ *     thresh start (TS)
+ *     thresh end (TE)
+ */
+
+EVENT(MEM_LOADS,				0x35340401e0);
+EVENT(MEM_STORES,				0x353c0401e0);
diff --git a/arch/powerpc/perf/power12-pmu.c b/arch/powerpc/perf/power12-pmu.c
new file mode 100644
index 0000000000000..89cc704b8324c
--- /dev/null
+++ b/arch/powerpc/perf/power12-pmu.c
@@ -0,0 +1,466 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Performance counter support for Power12 processors.
+ *
+ * Copyright 2026 Athira Rajeev, IBM Corporation.
+ */
+
+#define pr_fmt(fmt)	"power12-pmu: " fmt
+
+#include "isa207-common.h"
+
+/*
+ * Raw event encoding for Power12:
+ *
+ *        60        56        52        48        44        40        36        32
+ * | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - |
+ *   | | [ ]   [ src_match ] [  src_mask ]   | [ ] [ l2l3_sel ]  [  thresh_ctl   ]
+ *   | |  |                                  |  |                         |
+ *   | |  *- IFM (Linux)                     |  |        thresh start/stop -*
+ *   | *- BHRB (Linux)                       |  src_sel
+ *   *- EBB (Linux)                          *invert_bit
+ *
+ *        28        24        20        16        12         8         4         0
+ * | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - |
+ *   [   ] [  sample ]   [ ] [ ]   [ pmc ]   [unit ]   [ ] |  m   [    pmcxsel    ]
+ *     |        |        |    |                        |   |  |
+ *     |        |        |    |                        |   |  *- mark
+ *     |        |        |    *- L1/L2/L3 cache_sel    |   |*-radix_scope_qual
+ *     |        |        sdar_mode                     |
+ *     |        *- sampling mode for marked events     *- combine
+ *     |
+ *     *- thresh_sel
+ *
+ * Below uses IBM bit numbering.
+ *
+ * MMCR1[x:y] = unit    (PMCxUNIT)
+ * MMCR1[24]   = pmc1combine[0]
+ * MMCR1[25]   = pmc1combine[1]
+ * MMCR1[26]   = pmc2combine[0]
+ * MMCR1[27]   = pmc2combine[1]
+ * MMCR1[28]   = pmc3combine[0]
+ * MMCR1[29]   = pmc3combine[1]
+ * MMCR1[30]   = pmc4combine[0]
+ * MMCR1[31]   = pmc4combine[1]
+ *
+ * if pmc == 3 and unit == 0 and pmcxsel[0:6] == 0b0101011
+ *	MMCR1[20:27] = thresh_ctl
+ * else if pmc == 4 and unit == 0xf and pmcxsel[0:6] == 0b0101001
+ *	MMCR1[20:27] = thresh_ctl
+ * else
+ *	MMCRA[48:55] = thresh_ctl   (THRESH START/END)
+ *
+ * if thresh_sel:
+ *	MMCRA[45:47] = thresh_sel
+ *
+ * if l2l3_sel:
+ * MMCR2[56:60] = l2l3_sel[0:4]
+ *
+ * MMCR1[16] = cache_sel[0]
+ * MMCR1[17] = cache_sel[1]
+ * MMCR1[18] = radix_scope_qual
+ *
+ * if mark:
+ *	MMCRA[63]    = 1		(SAMPLE_ENABLE)
+ *	MMCRA[57:59] = sample[0:2]	(RAND_SAMP_ELIG)
+ *	MMCRA[61:62] = sample[3:4]	(RAND_SAMP_MODE)
+ *
+ * if EBB and BHRB:
+ *	MMCRA[32:33] = IFM
+ *
+ * MMCRA[SDAR_MODE]  = sdar_mode[0:1]
+ */
+
+/*
+ * Some power12 event codes.
+ */
+#define EVENT(_name, _code)     enum{_name = _code}
+
+#include "power12-events-list.h"
+
+#undef EVENT
+
+/* MMCRA IFM bits - POWER12 */
+#define POWER12_MMCRA_IFM1		0x0000000040000000UL
+#define POWER12_MMCRA_IFM2		0x0000000080000000UL
+#define POWER12_MMCRA_IFM3		0x00000000C0000000UL
+#define POWER12_MMCRA_BHRB_MASK		0x00000000C0000000UL
+
+extern u64 PERF_REG_EXTENDED_MASK;
+
+/* Table of alternatives, sorted by column 0 */
+static const unsigned int power12_event_alternatives[][MAX_ALT] = {
+	{ PM_INST_CMPL_ALT,		PM_INST_CMPL },
+	{ PM_CYC_ALT,			PM_CYC },
+};
+
+static int power12_get_alternatives(u64 event, unsigned int flags, u64 alt[])
+{
+	int num_alt = 0;
+
+	num_alt = isa207_get_alternatives(event, alt,
+					  ARRAY_SIZE(power12_event_alternatives), flags,
+					  power12_event_alternatives);
+
+	return num_alt;
+}
+
+static int power12_check_attr_config(struct perf_event *ev)
+{
+	u64 val;
+	u64 event = ev->attr.config;
+
+	val = (event >> EVENT_SAMPLE_SHIFT) & EVENT_SAMPLE_MASK;
+	if (val == 0x10 || isa3XX_check_attr_config(ev))
+		return -EINVAL;
+
+	return 0;
+}
+
+GENERIC_EVENT_ATTR(cpu-cycles,			PM_CYC);
+GENERIC_EVENT_ATTR(instructions,		PM_INST_CMPL);
+GENERIC_EVENT_ATTR(branch-instructions,		PM_BR_FIN);
+GENERIC_EVENT_ATTR(branch-misses,		PM_MPRED_BR_FIN);
+GENERIC_EVENT_ATTR(cache-references,		PM_LD_REF_L1);
+GENERIC_EVENT_ATTR(cache-misses,		PM_LD_DEMAND_MISS_L1_FIN);
+GENERIC_EVENT_ATTR(mem-loads,			MEM_LOADS);
+GENERIC_EVENT_ATTR(mem-stores,			MEM_STORES);
+
+CACHE_EVENT_ATTR(L1-dcache-load-misses,		PM_LD_MISS_L1);
+CACHE_EVENT_ATTR(L1-dcache-loads,		PM_LD_REF_L1);
+CACHE_EVENT_ATTR(L1-dcache-prefetches,		PM_LD_PREFETCH_CACHE_LINE_MISS);
+CACHE_EVENT_ATTR(L1-dcache-store-misses,	PM_ST_MISS_L1);
+CACHE_EVENT_ATTR(L1-icache-load-misses,		PM_L1_ICACHE_MISS);
+CACHE_EVENT_ATTR(L1-icache-loads,		PM_INST_FROM_L1);
+CACHE_EVENT_ATTR(L1-icache-prefetches,		PM_IC_PREF_REQ);
+CACHE_EVENT_ATTR(LLC-load-misses,		PM_DATA_FROM_L3MISS);
+CACHE_EVENT_ATTR(LLC-loads,			PM_DATA_FROM_L3);
+CACHE_EVENT_ATTR(LLC-prefetches,		PM_L3_PF_MISS_L3);
+CACHE_EVENT_ATTR(LLC-store-misses,		PM_L2_ST_MISS);
+CACHE_EVENT_ATTR(LLC-stores,			PM_L2_ST);
+CACHE_EVENT_ATTR(branch-load-misses,		PM_BR_MPRED_CMPL);
+CACHE_EVENT_ATTR(branch-loads,			PM_BR_CMPL);
+CACHE_EVENT_ATTR(dTLB-load-misses,		PM_DTLB_MISS);
+CACHE_EVENT_ATTR(iTLB-load-misses,		PM_ITLB_MISS);
+
+static struct attribute *power12_events_attr[] = {
+	GENERIC_EVENT_PTR(PM_CYC),
+	GENERIC_EVENT_PTR(PM_INST_CMPL),
+	GENERIC_EVENT_PTR(PM_BR_FIN),
+	GENERIC_EVENT_PTR(PM_MPRED_BR_FIN),
+	GENERIC_EVENT_PTR(PM_LD_REF_L1),
+	GENERIC_EVENT_PTR(PM_LD_DEMAND_MISS_L1_FIN),
+	GENERIC_EVENT_PTR(MEM_LOADS),
+	GENERIC_EVENT_PTR(MEM_STORES),
+	CACHE_EVENT_PTR(PM_LD_MISS_L1),
+	CACHE_EVENT_PTR(PM_LD_REF_L1),
+	CACHE_EVENT_PTR(PM_LD_PREFETCH_CACHE_LINE_MISS),
+	CACHE_EVENT_PTR(PM_ST_MISS_L1),
+	CACHE_EVENT_PTR(PM_L1_ICACHE_MISS),
+	CACHE_EVENT_PTR(PM_INST_FROM_L1),
+	CACHE_EVENT_PTR(PM_IC_PREF_REQ),
+	CACHE_EVENT_PTR(PM_DATA_FROM_L3MISS),
+	CACHE_EVENT_PTR(PM_DATA_FROM_L3),
+	CACHE_EVENT_PTR(PM_L3_PF_MISS_L3),
+	CACHE_EVENT_PTR(PM_L2_ST_MISS),
+	CACHE_EVENT_PTR(PM_L2_ST),
+	CACHE_EVENT_PTR(PM_BR_MPRED_CMPL),
+	CACHE_EVENT_PTR(PM_BR_CMPL),
+	CACHE_EVENT_PTR(PM_DTLB_MISS),
+	CACHE_EVENT_PTR(PM_ITLB_MISS),
+	NULL
+};
+
+static const struct attribute_group power12_pmu_events_group = {
+	.name = "events",
+	.attrs = power12_events_attr,
+};
+
+PMU_FORMAT_ATTR(event,          "config:0-59");
+PMU_FORMAT_ATTR(pmcxsel,        "config:0-7");
+PMU_FORMAT_ATTR(mark,           "config:8");
+PMU_FORMAT_ATTR(combine,        "config:10-11");
+PMU_FORMAT_ATTR(unit,           "config:12-15");
+PMU_FORMAT_ATTR(pmc,            "config:16-19");
+PMU_FORMAT_ATTR(cache_sel,      "config:20-21");
+PMU_FORMAT_ATTR(sdar_mode,      "config:22-23");
+PMU_FORMAT_ATTR(sample_mode,    "config:24-28");
+PMU_FORMAT_ATTR(thresh_sel,     "config:29-31");
+PMU_FORMAT_ATTR(thresh_stop,    "config:32-35");
+PMU_FORMAT_ATTR(thresh_start,   "config:36-39");
+PMU_FORMAT_ATTR(l2l3_sel,       "config:40-44");
+PMU_FORMAT_ATTR(src_sel,        "config:45-46");
+PMU_FORMAT_ATTR(invert_bit,     "config:47");
+PMU_FORMAT_ATTR(src_mask,       "config:48-53");
+PMU_FORMAT_ATTR(src_match,      "config:54-59");
+PMU_FORMAT_ATTR(radix_scope,	"config:9");
+PMU_FORMAT_ATTR(thresh_cmp,     "config1:0-17");
+
+static struct attribute *power12_pmu_format_attr[] = {
+	&format_attr_event.attr,
+	&format_attr_pmcxsel.attr,
+	&format_attr_mark.attr,
+	&format_attr_combine.attr,
+	&format_attr_unit.attr,
+	&format_attr_pmc.attr,
+	&format_attr_cache_sel.attr,
+	&format_attr_sdar_mode.attr,
+	&format_attr_sample_mode.attr,
+	&format_attr_thresh_sel.attr,
+	&format_attr_thresh_stop.attr,
+	&format_attr_thresh_start.attr,
+	&format_attr_l2l3_sel.attr,
+	&format_attr_src_sel.attr,
+	&format_attr_invert_bit.attr,
+	&format_attr_src_mask.attr,
+	&format_attr_src_match.attr,
+	&format_attr_radix_scope.attr,
+	&format_attr_thresh_cmp.attr,
+	NULL,
+};
+
+static const struct attribute_group power12_pmu_format_group = {
+	.name = "format",
+	.attrs = power12_pmu_format_attr,
+};
+
+static const struct attribute_group *power12_pmu_attr_groups[] = {
+	&power12_pmu_format_group,
+	&power12_pmu_events_group,
+	NULL,
+};
+
+static int power12_generic_events[] = {
+	[PERF_COUNT_HW_CPU_CYCLES] =			PM_CYC,
+	[PERF_COUNT_HW_INSTRUCTIONS] =			PM_INST_CMPL,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] =		PM_BR_FIN,
+	[PERF_COUNT_HW_BRANCH_MISSES] =			PM_MPRED_BR_FIN,
+	[PERF_COUNT_HW_CACHE_REFERENCES] =		PM_LD_REF_L1,
+	[PERF_COUNT_HW_CACHE_MISSES] =			PM_LD_DEMAND_MISS_L1_FIN,
+};
+
+static u64 power12_bhrb_filter_map(u64 branch_sample_type)
+{
+	u64 pmu_bhrb_filter = 0;
+
+	/* BHRB and regular PMU events share the same privilege state
+	 * filter configuration. BHRB is always recorded along with a
+	 * regular PMU event. As the privilege state filter is handled
+	 * in the basic PMC configuration of the accompanying regular
+	 * PMU event, we ignore any separate BHRB specific request.
+	 */
+
+	/* No branch filter requested */
+	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY)
+		return pmu_bhrb_filter;
+
+	/* Invalid branch filter options - HW does not support */
+	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY_RETURN)
+		return -1;
+
+	if (branch_sample_type & PERF_SAMPLE_BRANCH_IND_CALL) {
+		pmu_bhrb_filter |= POWER12_MMCRA_IFM2;
+		return pmu_bhrb_filter;
+	}
+
+	if (branch_sample_type & PERF_SAMPLE_BRANCH_COND) {
+		pmu_bhrb_filter |= POWER12_MMCRA_IFM3;
+		return pmu_bhrb_filter;
+	}
+
+	if (branch_sample_type & PERF_SAMPLE_BRANCH_CALL)
+		return -1;
+
+	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY_CALL) {
+		pmu_bhrb_filter |= POWER12_MMCRA_IFM1;
+		return pmu_bhrb_filter;
+	}
+
+	/* Every thing else is unsupported */
+	return -1;
+}
+
+static void power12_config_bhrb(u64 pmu_bhrb_filter)
+{
+	pmu_bhrb_filter &= POWER12_MMCRA_BHRB_MASK;
+
+	/* Enable BHRB filter in PMU */
+	mtspr(SPRN_MMCRA, (mfspr(SPRN_MMCRA) | pmu_bhrb_filter));
+}
+
+#define C(x)	PERF_COUNT_HW_CACHE_##x
+
+/*
+ * Table of generalized cache-related events.
+ * 0 means not supported, -1 means nonsensical, other values
+ * are event codes.
+ */
+static u64 power12_cache_events[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
+	[C(L1D)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)] = PM_LD_REF_L1,
+			[C(RESULT_MISS)] = PM_LD_MISS_L1,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)] = 0,
+			[C(RESULT_MISS)] = PM_ST_MISS_L1,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)] = PM_LD_PREFETCH_CACHE_LINE_MISS,
+			[C(RESULT_MISS)] = 0,
+		},
+	},
+	[C(L1I)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)] = PM_INST_FROM_L1,
+			[C(RESULT_MISS)] = PM_L1_ICACHE_MISS,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)] = PM_INST_FROM_L1MISS,
+			[C(RESULT_MISS)] = -1,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)] = PM_IC_PREF_REQ,
+			[C(RESULT_MISS)] = 0,
+		},
+	},
+	[C(LL)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)] = PM_DATA_FROM_L3,
+			[C(RESULT_MISS)] = PM_DATA_FROM_L3MISS,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)] = PM_L2_ST,
+			[C(RESULT_MISS)] = PM_L2_ST_MISS,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)] = PM_L3_PF_MISS_L3,
+			[C(RESULT_MISS)] = 0,
+		},
+	},
+	 [C(DTLB)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)] = 0,
+			[C(RESULT_MISS)] = PM_DTLB_MISS,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)] = -1,
+			[C(RESULT_MISS)] = -1,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)] = -1,
+			[C(RESULT_MISS)] = -1,
+		},
+	},
+	[C(ITLB)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)] = 0,
+			[C(RESULT_MISS)] = PM_ITLB_MISS,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)] = -1,
+			[C(RESULT_MISS)] = -1,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)] = -1,
+			[C(RESULT_MISS)] = -1,
+		},
+	},
+	[C(BPU)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)] = PM_BR_CMPL,
+			[C(RESULT_MISS)] = PM_BR_MPRED_CMPL,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)] = -1,
+			[C(RESULT_MISS)] = -1,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)] = -1,
+			[C(RESULT_MISS)] = -1,
+		},
+	},
+	[C(NODE)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)] = -1,
+			[C(RESULT_MISS)] = -1,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)] = -1,
+			[C(RESULT_MISS)] = -1,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)] = -1,
+			[C(RESULT_MISS)] = -1,
+		},
+	},
+};
+
+#undef C
+
+/*
+ * Set the MMCR0[CC56RUN] bit to enable counting for
+ * PMC5 and PMC6 regardless of the state of CTRL[RUN],
+ * so that we can use counters 5 and 6 as PM_INST_CMPL and
+ * PM_CYC.
+ */
+static int power12_compute_mmcr(u64 event[], int n_ev,
+				unsigned int hwc[], struct mmcr_regs *mmcr,
+				struct perf_event *pevents[], u32 flags)
+{
+	int ret;
+
+	ret = isa207_compute_mmcr(event, n_ev, hwc, mmcr, pevents, flags);
+	if (!ret)
+		mmcr->mmcr0 |= MMCR0_C56RUN;
+	return ret;
+}
+
+static struct power_pmu power12_pmu = {
+	.name			= "Power12",
+	.n_counter		= MAX_PMU_COUNTERS,
+	.add_fields		= ISA207_ADD_FIELDS,
+	.test_adder		= ISA207_TEST_ADDER,
+	.group_constraint_mask	= CNST_CACHE_PMC4_MASK,
+	.group_constraint_val	= CNST_CACHE_PMC4_VAL,
+	.compute_mmcr		= power12_compute_mmcr,
+	.config_bhrb		= power12_config_bhrb,
+	.bhrb_filter_map	= power12_bhrb_filter_map,
+	.get_constraint		= isa207_get_constraint,
+	.get_alternatives	= power12_get_alternatives,
+	.get_mem_data_src	= isa207_get_mem_data_src,
+	.get_mem_weight		= isa207_get_mem_weight,
+	.disable_pmc		= isa207_disable_pmc,
+	.flags			= PPMU_HAS_SIER | PPMU_ARCH_207S |
+				  PPMU_ARCH_31 | PPMU_HAS_ATTR_CONFIG1 |
+				  PPMU_P10,
+	.n_generic		= ARRAY_SIZE(power12_generic_events),
+	.generic_events		= power12_generic_events,
+	.cache_events		= &power12_cache_events,
+	.attr_groups		= power12_pmu_attr_groups,
+	.bhrb_nr		= 32,
+	.capabilities           = PERF_PMU_CAP_EXTENDED_REGS,
+	.check_attr_config	= power12_check_attr_config,
+};
+
+int __init init_power12_pmu(void)
+{
+	unsigned int pvr;
+	int rc;
+
+	pvr = mfspr(SPRN_PVR);
+	if (PVR_VER(pvr) != PVR_POWER12)
+		return -ENODEV;
+
+	/* Set the PERF_REG_EXTENDED_MASK here */
+	PERF_REG_EXTENDED_MASK = PERF_REG_PMU_MASK_31;
+
+	rc = register_power_pmu(&power12_pmu);
+	if (rc)
+		return rc;
+
+	/* Tell userspace that EBB is supported */
+	cur_cpu_spec->cpu_user_features2 |= PPC_FEATURE2_EBB;
+
+	return 0;
+}
-- 
2.55.0


