Return-Path: <linuxppc-dev+bounces-24574-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF910C4452F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 03:39:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h435f0Kgmz2yfS;
	Tue, 21 Jul 2026 13:39:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784605141;
	cv=none; b=WaMFM55MnFti4rPxvhSt0nTZoPjOuF7Np1y+6tZD9AVU13Ww/v3kBpS94rp/VenlurC4BQ8EQ8chLF7Db/ouFVWxgtX00ReqCGbA1WY5zAtEvOrjGYVmfclSQkBZS8Oh+WCKVHt8JIlRunzhXcX5yzUP59tarO3R0wbdgwDEPtcyTNZnVpDrQIC0tUq4gSizCCQuoetbrJc8Df3H0Ki1VQhv7HscL+5VpZV4g54/1QrjVJj2/YLq50R3TdTPpyFc/XK1aggHe9d3Lo19iwXuFWasyTPv+Japzv3PJjT3GsGPSqGGshM8KXK+lpLjomKhEIHbZXu5R454TNV9ZzqCxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784605141; c=relaxed/relaxed;
	bh=FdEP23wB1gY5cRnjDi3zTlaxnfi3YURRFyYUYQF9rDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WIEF9VKrt7wzqU2Hb0ocPdVnMQt8Xtp+GrGonV06xXB3TezIO+7FBi+B+PeBgnIN7Arf+lsAxkNxzih4IO+br6+GR5maKnyM+ZDmBv4PzjbDGkYtY3BEAF0guTbp7Ossgkx5IfojOmQPyFKo4zN9AQHCvabDSSN3JqCoA2IhVOn1F+zuQRmKWxlAswluhxWHgVJ/7QI64MyyXL+j/ORfU0+VeITqvZEg9onKnGVPjU1x4MBFSQDmnIZuirmwg48xPTU5yxHla1JCJzPyYUQF4NbMkk8956KA4uUXfT3OujhEmgnNv+oGdOeCN1TzKI4lE/k54Y+bYSYzlmoEkEPaUA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GnLOaV+w; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GnLOaV+w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h435c5yJ7z2xwN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 13:39:00 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KND3PB1676443;
	Tue, 21 Jul 2026 03:38:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FdEP23wB1gY5cRnjD
	i3zTlaxnfi3YURRFyYUYQF9rDk=; b=GnLOaV+wQtRQecNHBw0MvUcenUAGukO8W
	kr8JbRldzGiIFYT993UsUnA+H0dQTdqc735rwN8L7w+bqSZyeD/rHaS5dAyPiMoV
	qmBpYzHdxOYXdCTQlTr8x+bNR38pCAUhQIl/4Uv1TabABli6QuzKkAHsljCACPlm
	f+aPlaKrmTLQQ82OY/GBtmenmVqF0C3yL4EZXl9T4e3g1WaEpabrFNWGVLiI8LFm
	hzrXtTqHuC5vX4zHUCI9nOo/+acKKLdzhro+gNPDuxCFsQlO5NgeUF+vWwpL5C2A
	tSER1y3Fr1r6fRaCV2yz/E5v5wAjmr8KrHhhSCmEuYPbAjQZy8/fw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77aap2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 03:38:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66L3JaEM016190;
	Tue, 21 Jul 2026 03:38:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgy8a1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 03:38:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66L3ch3v53412204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jul 2026 03:38:43 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5E652004B;
	Tue, 21 Jul 2026 03:38:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 478A820040;
	Tue, 21 Jul 2026 03:38:39 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.ibm.com (unknown [9.124.218.117])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Jul 2026 03:38:39 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: mahesh@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        christophe.leroy@csgroup.eu, gregkh@linuxfoundation.org,
        oohall@gmail.com, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        tyreld@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
        ganeshgr@linux.ibm.com, sourabhjain@linux.ibm.com, haren@linux.ibm.com,
        nnmlinux@linux.ibm.com, thuth@redhat.com
Subject: [PATCH v3 2/5] powerpc/rtas: Allocate ibm,errinjct buffer below RTAS limit
Date: Tue, 21 Jul 2026 09:08:02 +0530
Message-ID: <20260721033815.5300-3-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260721033815.5300-1-nnmlinux@linux.ibm.com>
References: <20260721033815.5300-1-nnmlinux@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: twXFHZE4nGCvlxpQbm6v5h019NP8WBoy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDAzMCBTYWx0ZWRfX2ZpqpFX3Tz+U
 0d2QDduG5xWG6BpH7HIyBg3kpobSKXC60O3YSQ0TYGYrI56AJX65MzFpG1PfKsgAlESyQcxLswq
 JDJgmcJxHLZRfFzJn2cxlxuznaWOFOU=
X-Proofpoint-GUID: LdUIXWTSoXhF4F7gsCsaMiykgI9trZnU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDAzMCBTYWx0ZWRfXxxgB4Xk9ghYx
 at6vlVevxydC6EGs9XosBbRsiLasDfzl1aF7QkQP5DORxnpBnzo95ksxif4klwsg74GOeabqKZ3
 10O7nzCoua4FtRWsXxO0I8vT3SdfiiIybh4w3FRYtnIlgLdXWS5EC7RBuOitIFmVfqr4fVBEBIQ
 kq/Rxlu1g9tbo6rmRIVX0/QlB9SKrV6jHLrqGE0RIIKSPWOJAabLcwoLxqySvHPCk/1QXQTWKAo
 sBV49u1RYXQD2iHedY6hB51+s1FDl9cO8Qi0f+tQ3MS8ly9GBXQt8WKca5YqZmcooFFf0MlB750
 EG+zy1xRFshgusg01+qnSvBJzBw6R/NRcpYLkJk2yNEsPXmTTmaqc1KGCmvie9pekRbFS+/IVji
 7Bh3P5dQPB0tLOfuT9miJcI68p+J347+UHuNUdeuIWP1+HPlXelkSC1YDSrtYcz/hv3uAtFrtWq
 ntPNh5otQIEKCkymZDA==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a5ee9ca cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=k2PC6WYSJxEsxUIcpbgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210030

ibm,errinjct requires a caller-provided work buffer whose physical
address is passed to RTAS firmware.

A static C array such as:

  char rtas_errinjct_buf[1024] __aligned(SZ_1K);

only guarantees alignment, not physical placement.  If the array lands
above the RTAS-safe range (RTAS_INSTANTIATE_MAX, 1 GB) or above 4 GB,
RTAS receives a truncated or invalid address and the injection call
will fail silently or corrupt memory.

Instead, introduce rtas_errinjct_buf as a global unsigned long storing
the physical address allocated during rtas_initialize() using
memblock_phys_alloc_range() with the same rtas_region upper bound used
for rtas_rmo_buf.  This matches the existing placement model for
RTAS-accessible buffers and guarantees the physical address fits in 32
bits.

  Usage:
    void *buf    = __va(rtas_errinjct_buf);       /* kernel VA to fill */
    u32  buf_phys = lower_32_bits(rtas_errinjct_buf); /* PA for RTAS */

Always check upper_32_bits(rtas_errinjct_buf) == 0 before passing the
lower 32 bits to RTAS.

Add rtas_errinjct_mutex to serialise the complete open-session /
inject / close-session firmware call sequence.  A mutex is required
because the sequence involves multiple rtas_call() invocations with
possible busy/extended-delay retries that may sleep.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 arch/powerpc/include/asm/rtas.h | 26 ++++++++++++++++++++++++++
 arch/powerpc/kernel/rtas.c      | 17 +++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index d046bbd5017d..59e3c1296018 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -4,6 +4,7 @@
 #ifdef __KERNEL__
 
 #include <linux/mutex.h>
+#include <linux/sizes.h>
 #include <linux/spinlock.h>
 #include <asm/page.h>
 #include <asm/rtas-types.h>
@@ -519,6 +520,31 @@ int rtas_get_error_log_max(void);
 extern spinlock_t rtas_data_buf_lock;
 extern char rtas_data_buf[RTAS_DATA_BUF_SIZE];
 
+/*
+ * RTAS error-injection work buffer.
+ *
+ * ibm,errinjct requires a caller-provided work buffer whose physical
+ * address is passed to firmware.  A static C array only guarantees
+ * alignment, not physical placement; if it lands above the RTAS-safe
+ * range or above 4 GB, RTAS receives a truncated or bogus address.
+ *
+ * rtas_errinjct_buf stores the physical address allocated during
+ * rtas_initialize() using memblock_phys_alloc_range() with the same
+ * rtas_region upper bound used for rtas_rmo_buf, matching the existing
+ * placement model for RTAS-accessible buffers.
+ *
+ * Use __va(rtas_errinjct_buf) to obtain the kernel virtual address for
+ * filling the buffer, and lower_32_bits(rtas_errinjct_buf) to pass the
+ * physical address to RTAS (after checking upper_32_bits() == 0).
+ *
+ * rtas_errinjct_mutex must be held across the complete
+ * ibm,open-errinjct / ibm,errinjct / ibm,close-errinjct sequence.
+ */
+#define RTAS_ERRINJCT_BUF_SIZE	SZ_1K
+
+extern unsigned long rtas_errinjct_buf;
+extern struct mutex rtas_errinjct_mutex;
+
 /* RMO buffer reserved for user-space RTAS use */
 extern unsigned long rtas_rmo_buf;
 
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 27d53f34494d..7883f973e8c9 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -769,6 +769,17 @@ EXPORT_SYMBOL_GPL(rtas_data_buf);
 
 unsigned long rtas_rmo_buf;
 
+/*
+ * Physical address of the ibm,errinjct work buffer.  Allocated during
+ * rtas_initialize() using memblock_phys_alloc_range() below rtas_region
+ * so the address fits in 32 bits and is safe to pass to RTAS firmware.
+ */
+unsigned long rtas_errinjct_buf;
+EXPORT_SYMBOL_GPL(rtas_errinjct_buf);
+
+DEFINE_MUTEX(rtas_errinjct_mutex);
+EXPORT_SYMBOL_GPL(rtas_errinjct_mutex);
+
 /*
  * If non-NULL, this gets called when the kernel terminates.
  * This is done like this so rtas_flash can be a module.
@@ -2109,6 +2120,12 @@ void __init rtas_initialize(void)
 		panic("ERROR: RTAS: Failed to allocate %lx bytes below %pa\n",
 		      PAGE_SIZE, &rtas_region);
 
+	rtas_errinjct_buf = memblock_phys_alloc_range(RTAS_ERRINJCT_BUF_SIZE,
+						      SZ_1K, 0, rtas_region);
+	if (!rtas_errinjct_buf)
+		panic("ERROR: RTAS: Failed to allocate %lu bytes below %pa\n",
+		      (unsigned long)RTAS_ERRINJCT_BUF_SIZE, &rtas_region);
+
 	rtas_work_area_reserve_arena(rtas_region);
 }
 
-- 
2.54.0


