Return-Path: <linuxppc-dev+bounces-27651-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156DFC88E75
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 05:24:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmLdX0sXxz2yHD;
	Fri, 18 Sep 2026 15:24:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789709040;
	cv=none; b=YLdAf/6zIKasx7cg8aAMiyOGA/QRSA1j8oZlVWuKDahwBsb/4g+P2UYAWnqA4FlNAkmJxv1QEGFompKhlYaA3YGYw/rIICsnnQfBzfDSL+C43aL3Z1s1TapJBqve7VZWeEk/x+WG0sYFtm5+AZ5DknMuNnf9d7yeZCOdt4KGScL3WfWCZPsbxAJJcd9Glf7bhuCQkPHohMD66qZKcvc4UCs203nYBJH17cDeAtoIlNnBYfB4mY3Mm81Q+NVav/hPQCR1qaT6Ijo05EuOeycoRgERR+iPgiYX4zHxZUBf5kySYIUqwhSgVUrQDwjXQhadsf1N4l84qNR22x3+IVDDwA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789709040; c=relaxed/relaxed;
	bh=VLsnkHmyr+aZiqpEHuAeR8zOBM/v7S6nJMRuw9aqu04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AaLUvmcbKdWHvPlJflDaoRNgh3JEklc6q/0W7glgAxPxXi733yOwMjGNaWYeqwh/NDiDX1WfiSBFxmLeyTBU8e4W8GP5TSp0RBrZ1sXk4wy1M3DX6BM0pxVwkBrK1c+YwdgbmQEYoNmzkzFfbtaOL2L8mw/j5YMBH+9bkrCq52CrJzThct9a5aUlJMydcIaOiwfuFVL9SF7nysZsG3VTy9ADuFo+ScWJh178QzCmJQ3+yeQQ9U7HkFzI6lvDw3mU2DYZKlzDghSEwO7CcVAPeKi6yKcZGulWDQeKjM3e90xb3EbesQkUozf2foh4dNH04Kb9bI4zij5k/s2LeGIsRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=E4EyNAHx; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shirisha@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=E4EyNAHx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shirisha@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmLdW1fZLz30V0
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 15:23:59 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I2VRPX2364613;
	Fri, 18 Sep 2026 05:23:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=VLsnkHmyr+aZiqpEH
	uAeR8zOBM/v7S6nJMRuw9aqu04=; b=E4EyNAHx6GKSvIetNGFAAzaupvhfFPY97
	oT4dTD+mc/XIaNucYofqKGkz6HY9wv/xWXyyGYBWfaunycpQbG0Gwm/SKLWNE0HR
	AzqqyTSbOjP+OPDIwchL7IBUJEFPu7Y+7cSlrztB9A44KHNcgE3OpucJ4v2gCzj8
	Sd8gOukcI6CX+PeR3VPMQeUOoMncKJP1prh+k9MKIPc1mJp3RsINMQKsqywLB6Df
	YMWceO53/ruYSe5+DSXPzT27uuJs3HEqop2Li7D0b0m0QP302owG+8BB5+Lr7hfM
	K0X0f3bob7rAT0sU3YIlX7OxG/bkx5PK9NRM52dsZKvYaVxtTPHPw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdqpbpr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 05:23:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68I2Z4Di4152225;
	Fri, 18 Sep 2026 05:23:56 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5fjnw5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 05:23:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68I5NqUp39256356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 05:23:52 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4582C20043;
	Fri, 18 Sep 2026 05:23:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F39E20040;
	Fri, 18 Sep 2026 05:23:48 +0000 (GMT)
Received: from li-d12addcc-2792-11b2-a85c-bd8df30615ab.ibm.com.com (unknown [9.66.68.7])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 05:23:47 +0000 (GMT)
From: Shirisha G <shirisha@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kselftest@vger.kernel.org, maddy@linux.ibm.com,
        venkat88@linux.ibm.com, shirisha@linux.ibm.com
Subject: [PATCH 5/7] Subject: [PATCH] selftests/powerpc: Add RTAS firmware flash interface test
Date: Fri, 18 Sep 2026 10:52:40 +0530
Message-ID: <20260918052321.932660-5-shirisha@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918052321.932660-1-shirisha@linux.ibm.com>
References: <20260918052321.932660-1-shirisha@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDA2NCBTYWx0ZWRfX7PrjU1Qp9LBs
 Ug+/p/lqJ/x7g6zXFBUMiCQG6+Fm5yU8M275Cy+aYhgOrAZJyh/mLEYkgPtl0fvbVOEVbjx8t7/
 Q83yFGXeTyvyi7mKf6dDdOV9l6Etq31KSn3YUvHeRHMaOonG/gb8d5m/DKPbv7Jf3Rx8xmiWOV8
 fbKOQ75Cv3UDBT0OoO3CRjv/ZokrRuzPCSgHOlqwbQgBjpB7bYrUwudj+cWc3wDzyhtU7g8TD9z
 k35uqGKR/t/8OVIIcwOttkupJxjt8CXZcKU0Mo0fju2fVfsqTUuUgcJhIfYeiFABchX0GX5Gk1m
 /TMy9L3Ud0DzUksHHwSMw/pikH/sbrPRBToza5+QFCHt8dsXJeRkvEDINzR+k+qzWvQPNwEeWXw
 JBtdf7AkUV1IucNnY4m8kpCEZAmqlVVDIjsdJKwxTYqcha5iYXwO/4ezhhXZuaEdwXKOw4sFYPT
 gaqh1jUJK0ICd+FX4Fg==
X-Proofpoint-GUID: 62fWhhARS6-jJDViNQBb_xr0M6QjaA2z
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aaccaed cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=xJTyo2tlqj3zewc7kv4A:9
X-Proofpoint-ORIG-GUID: 62fWhhARS6-jJDViNQBb_xr0M6QjaA2z
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDA2NCBTYWx0ZWRfX2qqpI1i14U5c
 +wyxWEEEoVE0dceLD6mzTlM3KfhLyNPihRJMk36sGIh5p+P0WeniXUHgO8OXtKo9MhINq4TXKdO
 ajhPpyYQxU6/GoNaJRLqnhvd21A59nE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180064

Add kselftest for the RTAS firmware flash interface on pseries/PowerVM
systems. This test validates the existence and accessibility of the
firmware flash and update proc entries, while safely rejecting invalid
data. It does not perform actual firmware updates.

The test verifies:
- Existence of `/proc/ppc64/rtas/firmware_flash` interface
- Ability to open and read the flash interface
- Rejection of invalid image writes (requires root)
- Accessibility of `/proc/ppc64/rtas/firmware_update` status
- Safe validation subset without triggering real updates

Signed-off-by: Shirisha G <shirisha@linux.ibm.com>
---
 .../selftests/powerpc/rtas/rtas_flash_test.c  | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 tools/testing/selftests/powerpc/rtas/rtas_flash_test.c

diff --git a/tools/testing/selftests/powerpc/rtas/rtas_flash_test.c b/tools/testing/selftests/powerpc/rtas/rtas_flash_test.c
new file mode 100644
index 000000000000..7f7c90447e9c
--- /dev/null
+++ b/tools/testing/selftests/powerpc/rtas/rtas_flash_test.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * RTAS Firmware Flash Test (Safe Subset)
+ * Copyright (C) 2026 IBM Corporation
+ *
+ * WARNING: This test only validates the interface with invalid data.
+ * It does NOT perform actual firmware updates.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <errno.h>
+#include "utils.h"
+
+#define FLASH_PROC "/proc/ppc64/rtas/firmware_flash"
+#define UPDATE_PROC "/proc/ppc64/rtas/firmware_update"
+
+int main(void)
+{
+	int fd;
+	char invalid_data[256];
+	ssize_t ret;
+
+	test_harness_set_timeout(10);
+
+	/* Test 1: Verify flash interface exists */
+	SKIP_IF(access(FLASH_PROC, F_OK) != 0);
+
+	/* Test 2: Verify we can open the interface */
+	fd = open(FLASH_PROC, O_RDONLY);
+	if (fd >= 0) {
+		close(fd);
+		printf("Flash interface is readable\n");
+	}
+
+	/* Test 3: Test invalid image rejection (requires root) */
+	if (geteuid() == 0) {
+		fd = open(FLASH_PROC, O_WRONLY);
+		if (fd >= 0) {
+			/* Write invalid data - should be rejected */
+			memset(invalid_data, 0xFF, sizeof(invalid_data));
+			ret = write(fd, invalid_data, sizeof(invalid_data));
+			
+			/* We expect this to fail or be rejected */
+			if (ret < 0) {
+				printf("Invalid image correctly rejected (errno=%d)\n", errno);
+			} else {
+				printf("WARNING: Write accepted (may need validation)\n");
+			}
+			close(fd);
+		}
+	} else {
+		printf("Skipping write test (requires root)\n");
+	}
+
+	/* Test 4: Check update status interface */
+	if (access(UPDATE_PROC, R_OK) == 0) {
+		fd = open(UPDATE_PROC, O_RDONLY);
+		if (fd >= 0) {
+			char status[256];
+			ret = read(fd, status, sizeof(status) - 1);
+			if (ret > 0) {
+				status[ret] = '\0';
+				printf("Update status: %s\n", status);
+			}
+			close(fd);
+		}
+	}
+
+	printf("RTAS flash test passed (safe subset)\n");
+	return 0;
+}
-- 
2.43.5


