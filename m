Return-Path: <linuxppc-dev+bounces-21811-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291D0CD6E56
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Jun 2026 11:26:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gTWrS4fSvz2xqn;
	Mon, 01 Jun 2026 21:26:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780313208;
	cv=none; b=cBBGhwEpurMBNQPvqK7U+JpBcDbDDvsPiD2zN4sKOhxZCJFJZyw8fSvSvi5sAutnIXhht/pQzmDzNX0A9GvtgSSo6T+VXPEFTYIFws2GoI+IR8t0me2tHvSxEEfXyJTa15MpWIuB57v512Jv9m5o4+342vRH1QEiIJcrAjzTwnl7qex/MsuvwSuMpOYNqRn8FZ8teQeWganGVbAyHfGPcsRH4ahyrtd9iQlR56PSv9SB8K8CNp3tuvxxoepoGfM4/haZ0YMhYLasq25YOb+5REM4eZvj45ISw78Dbnaop5AJ+d20RZqFRnR14spq3satpdqc5xM79qwJsm/5l8HskA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780313208; c=relaxed/relaxed;
	bh=EHtJczlzPsaw96sfgjdcb7909B2TunaiprAsMSFmrXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F9j7o0cyY4CurVTTY0I6Y7oez132/0dnTWSQX8A95I9ecLsDY+xKDezM169sevLL86qbPn/XLshGvpXQmyfGMSIUNt+mdmuzHTPDN8PvL7fXfN3hEZl49JpH6z6xS8F+BfjJ+VAbzHXkJas2XDQl+nOpe+0Z3VBagpARlZx+l4QxPE8cRlwIs8Ply9gcWZcrnyE9b6hG5zefkMvIvLncB8FWZxhR6GFEUh+U5GdSZA2bt47Kn6vB5wZw1zKqoRECP6Y1jkGpzNMaw+7aYrjMAZ7lLf3A4TTpRXELFbVHqgXWb7qB1IKeCZVHjJStiFwIEKqsifukwn4ou8z+FvkqLg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XctIx1+N; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XctIx1+N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gTWrQ08s5z2xdh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jun 2026 21:26:45 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6514APAU3708091;
	Mon, 1 Jun 2026 11:26:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=EHtJczlzPsaw96sfgjdcb7909B2TunaiprAsMSFmr
	XA=; b=XctIx1+NexJmGxqwmgdYHLMq26TR905dr9iVjd1OU4pzBWmg9SZegX0Tf
	LCUwhAvynbIDtBXkaLEOCnRIdJZJKPisljYK3gv3EpTz0mX8a780JrNfxK2ftzN3
	vruv1JG9DaLvgGwHLjBRYfkLjFzbPp9ZupKxy+lPx9qmw9MFg8UXvKp+r3EnKm53
	pDbFxFfRYjuxZIFBEqTmriDAP/vOkEnJD21zdqxO6XF/sofRTUma6Wmz3P1uICSm
	xbeO/nKkyABleVeRjka8/s+bTBNnn19yvbMFvs1z85wjAYaMRrq5peoncj89TqDy
	qo5w3bGrRlQVTc+VYysXC0kWya1Yw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpae05br-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 11:26:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651BO8Tp023788;
	Mon, 1 Jun 2026 11:26:24 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqh5qw9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 11:26:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 651BQLPw57016760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 11:26:21 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E39CA2004F;
	Mon,  1 Jun 2026 11:26:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D47720040;
	Mon,  1 Jun 2026 11:26:18 +0000 (GMT)
Received: from shivang.bl1-in.ibm.com (unknown [9.123.12.247])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jun 2026 11:26:18 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, thuth@redhat.com,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Subject: [PATCH] powerpc/powernv: Cache OPAL check_token() results
Date: Mon,  1 Jun 2026 16:55:20 +0530
Message-ID: <20260601112520.161605-1-shivangu@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a1d6c62 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=cfGK7pAvqkcwuHOd0NgA:9
X-Proofpoint-GUID: 3J9yil8-VSsPEZOV2Ho9WB5emZ1dweoP
X-Proofpoint-ORIG-GUID: 3cIZLfS7NjxrkyUVIx_G-P9my0RWHDrA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDExMSBTYWx0ZWRfX46jnKkNyDhzq
 emNSi1XE6BUD3PpY5BOE87ZDehswbgvXmqypZ7rJVhz14nPMnn6jKQqp+2aVSKKBz6IJFUF23ui
 R3u74NCpr/XtDU98M4O1uSKMGXapK+Ymco7K+WyefH/tmv/6c1vbc598vLH+wlzLcp7LMVpNSMO
 6/I4O/gv62bzVzezTZL2y8VAtfOCixGxO4daRBVkqTX9nVJ0+HBbF4ykfGS6ruM2t2mNc5u7a0P
 7ntF08Zrmkd+jIqetE7T99aZGweoMuyK7TAswubD0WPSSmkAa547cTQxwa3My2dDlkeoRT2ashL
 GPwzqMWzd+awMYwBLOqChxF3AlqFyI2UxvzZ8IlamEYhRWXivEXq3H+qjdfE/7Lyjbk4zu23/IV
 jD821y7IbTOd1PTCTlHq2PILwI5PD3+53e9/dF5dw1W2ezWxOxgG43GhV3eCk/Ne5qkeyRi5R+x
 cxl1hX31G9TwFE8rOCg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010111

Add a caching layer for the opal_check_token() OPAL call to avoid
repeated firmware calls for token availability checks.

The opal_check_token() function is used to determine if a specific
OPAL firmware call is supported on the current platform. This check
is performed frequently during boot and runtime, resulting in
unnecessary firmware calls for the same token values.

This reduces firmware call overhead during boot and runtime token
checks while maintaining compatibility with existing code.

Testing with buildroot images shows OPAL calls reduced from
35578 to 28983, before console bring-up.

Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <chleroy@kernel.org>
Cc: Aditya Gupta <adityag@linux.ibm.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
 arch/powerpc/include/asm/opal.h            |  1 +
 arch/powerpc/platforms/powernv/opal-call.c |  2 +-
 arch/powerpc/platforms/powernv/opal.c      | 55 ++++++++++++++++++++++
 3 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 0a398265ba04..e7e11479122b 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -156,6 +156,7 @@ int64_t opal_pci_next_error(uint64_t phb_id, __be64 *first_frozen_pe,
 int64_t opal_pci_poll(uint64_t id);
 int64_t opal_return_cpu(void);
 int64_t opal_check_token(uint64_t token);
+int64_t opal_check_token_call(uint64_t token);
 int64_t opal_reinit_cpus(uint64_t flags);
 
 int64_t opal_xscom_read(uint32_t gcid, uint64_t pcb_addr, __be64 *val);
diff --git a/arch/powerpc/platforms/powernv/opal-call.c b/arch/powerpc/platforms/powernv/opal-call.c
index 021b0ec29e24..00325c189e69 100644
--- a/arch/powerpc/platforms/powernv/opal-call.c
+++ b/arch/powerpc/platforms/powernv/opal-call.c
@@ -207,7 +207,7 @@ OPAL_CALL(opal_validate_flash,			OPAL_FLASH_VALIDATE);
 OPAL_CALL(opal_manage_flash,			OPAL_FLASH_MANAGE);
 OPAL_CALL(opal_update_flash,			OPAL_FLASH_UPDATE);
 OPAL_CALL(opal_resync_timebase,			OPAL_RESYNC_TIMEBASE);
-OPAL_CALL(opal_check_token,			OPAL_CHECK_TOKEN);
+OPAL_CALL(opal_check_token_call,		OPAL_CHECK_TOKEN);
 OPAL_CALL(opal_dump_init,			OPAL_DUMP_INIT);
 OPAL_CALL(opal_dump_info,			OPAL_DUMP_INFO);
 OPAL_CALL(opal_dump_info2,			OPAL_DUMP_INFO2);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 1946dbdc9fa1..c32035136efa 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -73,6 +73,12 @@ static struct task_struct *kopald_tsk;
 static struct opal_msg *opal_msg;
 static u32 opal_msg_size __ro_after_init;
 
+/* Token cache for opal_check_token() */
+#define OPAL_TOKEN_CACHE_SIZE 256  /* Covers tokens 0-255, including OPAL_LAST (178) */
+static unsigned long opal_token_cache[BITS_TO_LONGS(OPAL_TOKEN_CACHE_SIZE)] __ro_after_init;
+static bool opal_token_cache_initialized __ro_after_init;
+static void opal_token_cache_init(void);
+
 void __init opal_configure_cores(void)
 {
 	u64 reinit_flags = 0;
@@ -1125,8 +1131,57 @@ EXPORT_SYMBOL_GPL(opal_flash_read);
 EXPORT_SYMBOL_GPL(opal_flash_write);
 EXPORT_SYMBOL_GPL(opal_flash_erase);
 EXPORT_SYMBOL_GPL(opal_prd_msg);
+
+/**
+ * opal_check_token - Check if an OPAL call token is supported
+ * @token: OPAL token number to check
+ *
+ * Returns 1 if supported, 0 if not.
+ * Uses a cached bitmap for fast lookups after initialization.
+ */
+int64_t opal_check_token(uint64_t token)
+{
+	/* Initialize if not done before */
+	if (!opal_token_cache_initialized) {
+		opal_token_cache_init();
+	}
+
+	/* Use cached result */
+	if (token < OPAL_TOKEN_CACHE_SIZE) {
+		return test_bit(token, opal_token_cache);
+	}
+
+	/* Fall back to direct OPAL call for out-of-range tokens */
+	return opal_check_token_call(token);
+}
 EXPORT_SYMBOL_GPL(opal_check_token);
 
+/**
+ * opal_token_cache_init - Initialize the OPAL token cache
+ *
+ * Called during opal_init() to populate the token cache by querying
+ * OPAL firmware for all tokens in the supported range.
+ */
+static void opal_token_cache_init(void)
+{
+	uint64_t token;
+	int64_t result;
+
+	pr_debug("Initializing OPAL token cache\n");
+
+	/* Query OPAL for each token and cache the result */
+	for (token = 0; token < OPAL_TOKEN_CACHE_SIZE; token++) {
+		result = opal_check_token_call(token);
+		if (result == 1)
+			set_bit(token, opal_token_cache);
+	}
+
+	/* Mark cache as initialized - enables fast path */
+	opal_token_cache_initialized = true;
+
+	pr_info("OPAL token cache initialized\n");
+}
+
 /* Convert a region of vmalloc memory to an opal sg list */
 struct opal_sg_list *opal_vmalloc_to_sg_list(void *vmalloc_addr,
 					     unsigned long vmalloc_size)
-- 
2.53.0


