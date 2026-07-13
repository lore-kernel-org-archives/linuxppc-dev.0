Return-Path: <linuxppc-dev+bounces-24083-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FF9C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 04:00:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gz7y466J7z2xqM;
	Mon, 13 Jul 2026 14:00:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783915228;
	cv=none; b=FzpU0euJ+Vj20ZNBGCbXKp3OX4LwTB/KI4QIHdM699bZAfEZDvCp6XDfXhztu56dTZGCrX5Ab5gYgxtHzvhP30OAazDFaVayH8zD5OhvEcvyLuBonj17B8hzeZ9q+qlcMIo+BOY/KqMACt0IIKKIX/eNRtLcDs+cge12oRdHLOOtS6bNKD8OJ7t9eIJoWvGlxDehU9itvAajSDxethiOrC7A1QczFE25qHMU1YBSeb6UYPGrRs5anQY13gqeisEgegtEc+V9WH2ujp3iegyvglOr/jly665gHtea2z7N+jZkn/k32TWP7R1tXsdNlGbSGIDuJG40h8GzpvinroXbkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783915228; c=relaxed/relaxed;
	bh=WlHhu1Q+xzTF8bbFAGz93JWNPU7N/wflReqwQ79BzBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibjqzwmjLY2KxfaXnI+nx+xYu5vMB6xgRZGwGX9a2u4Ms6538ZCF7U+EZYuzSY2yuPuFD9ewkpE9TAH/xJqTJzMUZ4vzVwypsx+2uEsFMjozsd7dCmXYMd3EXKbljhVmlBIqJMTUbOZgliKGUxc3V4aA6D4gm2sol6gbCIyy7zBdKJNpek23euGKZVh17JVGikJ9Z+iWx5dpJ8rdK1EJBdQHOV8IcPaueIQaUQbj6Qakrlrb3+r7jDI9sJfJNKDEPwLtJT6Hx8TnTZ249aFWIcJgQ78lzieA1a7hDqohtzwcOH0CX2gvHEcrUZp8reF8DPgRQVqkNC4ZkvlSdE86Rw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RKwOlIoJ; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RKwOlIoJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gz7y40DTZz2xVY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 14:00:27 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D3Bfi11283661;
	Mon, 13 Jul 2026 04:00:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WlHhu1Q+xzTF8bbFA
	Gz93JWNPU7N/wflReqwQ79BzBI=; b=RKwOlIoJvDURCWvqpLllcY2g0KH9iaH0y
	sD3EMiCECYDeQmVgWYSuE0CYmIikf6UPOhkAmCncpfQPe/WlDq4vWBQuwTklKPOl
	tT90++bAIonllMOQ23g5oNRTzxi4eCjJtwSkrZMJv66SdiELtN62xFtETyKL65x/
	2saso4GGmZ1jWqU67P4HLRqq+MklILqz1CefqbudcLUZGI60pdFZbs/MyUFrXZV8
	mQ69/9+HHV4I/+ACXD0ldUgasJghBHK0/dIIXvjnKLP+Eq46B1/rVu8yPG7UL9qD
	ZJ8ov5XOsyMg5zJlr1jvv+r6IpS+qWWO3I9sIkTGtQzFM4ObZ6f9w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fber86gn8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 04:00:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66D3ncAK014922;
	Mon, 13 Jul 2026 04:00:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15jkx8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 04:00:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66D406Tw50463088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 04:00:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0972820040;
	Mon, 13 Jul 2026 04:00:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE2102004F;
	Mon, 13 Jul 2026 04:00:02 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.bl1-in.ibm.com (unknown [9.123.14.142])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 04:00:02 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        ritesh.list@gmail.com
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com,
        hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com,
        venkat88@linux.ibm.com, stable@vger.kernel.org,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PATCH v2 1/3] powerpc/pseries: Move H_WATCHDOG definitions to a common header
Date: Mon, 13 Jul 2026 09:29:52 +0530
Message-ID: <20260713035954.1559605-2-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260713035954.1559605-1-sourabhjain@linux.ibm.com>
References: <20260713035954.1559605-1-sourabhjain@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDAzNCBTYWx0ZWRfX5Bt7pO4bu+MQ
 rt4XSQVuHc/H6kenRW/hYcHkHgWMQTh8AdBc4ACakkXq+QTo8HnZF+2xjILuJIwGsFi+rxTURBz
 5puz+qduLF+M0g8tfOFVMkml/M7hluduvAIiCe1JAUk2ngJ4kuVNXvz+gbXLdtqsqvKdhh1+H7g
 uiviri10VrpMz5JKpYzhxCfaoOfqjrX8i75EQeDDFurndcNB63dyN3dv/Xx1YovVVZFQTcmk110
 Wd1AUDU8AuDEbSa1pGcbRSA/Qvbh0W4pw2h+IinRQigi+WHRmHGMgwNUTNsBgGGU6V+iHX1uFoF
 elEiWKd5ea070u0QyuhyvuuHIsWI5uxttsMHteiO8DNfkdSpfJpvoLuXCDiQqzo+3m4xn9s9aL/
 ZVF9WSOtp84BAWvLpb3UvLoiz+tq18HfRr2qj3EtYv+dEG75BTxDtokHuT8vUDnmivvtTUdQFbg
 eZ+qTM3w9tEpzAUScuw==
X-Proofpoint-ORIG-GUID: rL_-M4gxF_dLXV3US6xznv2T1ZMPwIs6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDAzNCBTYWx0ZWRfXxeDlFbsh4CS9
 5Y8Gxz6vUjVgLz1FSKDcF41x2tizN6Om3mHKW5ennVQBvWrC9ztkR+8gzxY3MSfC8i8EJLq9OLG
 j7e/xVs1cUzihYXxHoXqnykyNJTQqAE=
X-Authority-Analysis: v=2.4 cv=TpzWQjXh c=1 sm=1 tr=0 ts=6a5462cb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=GYsGH9NJgqgsJyUot8sA:9
X-Proofpoint-GUID: Q5ai_6-jgueiHRD2Lj2_slL8c23QVex-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130034

The H_WATCHDOG input and output definitions are currently local to the
pseries watchdog driver. The next patch in this series also needs these
definitions to issue H_WATCHDOG hypercalls outside the watchdog driver.

Move the H_WATCHDOG definitions to a new common header,
asm/papr-watchdog.h, so they can be shared without duplicating the
PAPR watchdog definitions.

No functional changes.

Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/include/asm/papr-watchdog.h | 58 ++++++++++++++++++++++++
 drivers/watchdog/pseries-wdt.c           | 53 +---------------------
 2 files changed, 59 insertions(+), 52 deletions(-)
 create mode 100644 arch/powerpc/include/asm/papr-watchdog.h

diff --git a/arch/powerpc/include/asm/papr-watchdog.h b/arch/powerpc/include/asm/papr-watchdog.h
new file mode 100644
index 000000000000..fb3a511aa861
--- /dev/null
+++ b/arch/powerpc/include/asm/papr-watchdog.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _ASM_POWERPC_CRASHDUMP_PPC64_H
+#define _ASM_POWERPC_CRASHDUMP_PPC64_H
+
+/*
+ * H_WATCHDOG Input
+ *
+ * R4: "flags":
+ *
+ *         Bits 48-55: "operation"
+ */
+#define PSERIES_WDTF_OP_START	0x100UL		/* start timer */
+#define PSERIES_WDTF_OP_STOP	0x200UL		/* stop timer */
+#define PSERIES_WDTF_OP_QUERY	0x300UL		/* query timer capabilities */
+
+/*
+ *         Bits 56-63: "timeoutAction" (for "Start Watchdog" only)
+ */
+#define PSERIES_WDTF_ACTION_HARD_POWEROFF	0x1UL	/* poweroff */
+#define PSERIES_WDTF_ACTION_HARD_RESTART	0x2UL	/* restart */
+#define PSERIES_WDTF_ACTION_DUMP_RESTART	0x3UL	/* dump + restart */
+
+/*
+ * H_WATCHDOG Output
+ *
+ * R3: Return code
+ *
+ *     H_SUCCESS    The operation completed.
+ *
+ *     H_BUSY	    The hypervisor is too busy; retry the operation.
+ *
+ *     H_PARAMETER  The given "flags" are somehow invalid.  Either the
+ *                  "operation" or "timeoutAction" is invalid, or a
+ *                  reserved bit is set.
+ *
+ *     H_P2         The given "watchdogNumber" is zero or exceeds the
+ *                  supported maximum value.
+ *
+ *     H_P3         The given "timeoutInMs" is below the supported
+ *                  minimum value.
+ *
+ *     H_NOOP       The given "watchdogNumber" is already stopped.
+ *
+ *     H_HARDWARE   The operation failed for ineffable reasons.
+ *
+ *     H_FUNCTION   The H_WATCHDOG hypercall is not supported by this
+ *                  hypervisor.
+ *
+ * R4:
+ *
+ * - For the "Query Watchdog Capabilities" operation, a 64-bit
+ *   structure:
+ */
+#define PSERIES_WDTQ_MIN_TIMEOUT(cap)	(((cap) >> 48) & 0xffff)
+#define PSERIES_WDTQ_MAX_NUMBER(cap)	(((cap) >> 32) & 0xffff)
+
+#endif /* _ASM_POWERPC_CRASHDUMP_PPC64_H */
diff --git a/drivers/watchdog/pseries-wdt.c b/drivers/watchdog/pseries-wdt.c
index 48d67f7c972a..e97b943e1d3c 100644
--- a/drivers/watchdog/pseries-wdt.c
+++ b/drivers/watchdog/pseries-wdt.c
@@ -12,61 +12,10 @@
 #include <linux/platform_device.h>
 #include <linux/time64.h>
 #include <linux/watchdog.h>
+#include <asm/papr-watchdog.h>
 
 #define DRV_NAME "pseries-wdt"
 
-/*
- * H_WATCHDOG Input
- *
- * R4: "flags":
- *
- *         Bits 48-55: "operation"
- */
-#define PSERIES_WDTF_OP_START	0x100UL		/* start timer */
-#define PSERIES_WDTF_OP_STOP	0x200UL		/* stop timer */
-#define PSERIES_WDTF_OP_QUERY	0x300UL		/* query timer capabilities */
-
-/*
- *         Bits 56-63: "timeoutAction" (for "Start Watchdog" only)
- */
-#define PSERIES_WDTF_ACTION_HARD_POWEROFF	0x1UL	/* poweroff */
-#define PSERIES_WDTF_ACTION_HARD_RESTART	0x2UL	/* restart */
-#define PSERIES_WDTF_ACTION_DUMP_RESTART	0x3UL	/* dump + restart */
-
-/*
- * H_WATCHDOG Output
- *
- * R3: Return code
- *
- *     H_SUCCESS    The operation completed.
- *
- *     H_BUSY	    The hypervisor is too busy; retry the operation.
- *
- *     H_PARAMETER  The given "flags" are somehow invalid.  Either the
- *                  "operation" or "timeoutAction" is invalid, or a
- *                  reserved bit is set.
- *
- *     H_P2         The given "watchdogNumber" is zero or exceeds the
- *                  supported maximum value.
- *
- *     H_P3         The given "timeoutInMs" is below the supported
- *                  minimum value.
- *
- *     H_NOOP       The given "watchdogNumber" is already stopped.
- *
- *     H_HARDWARE   The operation failed for ineffable reasons.
- *
- *     H_FUNCTION   The H_WATCHDOG hypercall is not supported by this
- *                  hypervisor.
- *
- * R4:
- *
- * - For the "Query Watchdog Capabilities" operation, a 64-bit
- *   structure:
- */
-#define PSERIES_WDTQ_MIN_TIMEOUT(cap)	(((cap) >> 48) & 0xffff)
-#define PSERIES_WDTQ_MAX_NUMBER(cap)	(((cap) >> 32) & 0xffff)
-
 static const unsigned long pseries_wdt_action[] = {
 	[0] = PSERIES_WDTF_ACTION_HARD_POWEROFF,
 	[1] = PSERIES_WDTF_ACTION_HARD_RESTART,
-- 
2.52.0


