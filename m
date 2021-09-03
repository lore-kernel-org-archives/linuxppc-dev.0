Return-Path: <SRS0=Q8z7=NZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F20FC433EF
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Sep 2021 12:58:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49D2E610C8
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Sep 2021 12:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 49D2E610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H1Hs74SG7z2yw6
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Sep 2021 22:58:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=S+m2zczX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1032;
 helo=mail-pj1-x1032.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=S+m2zczX; dkim-atps=neutral
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H1HrM2vjjz2xrb
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Sep 2021 22:57:21 +1000 (AEST)
Received: by mail-pj1-x1032.google.com with SMTP id
 d3-20020a17090ae28300b0019629c96f25so3843625pjz.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Sep 2021 05:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TMHclhCvfwQV8iPUsIbu4B/w/VhFRgOjdCnzyEkr9Sw=;
 b=S+m2zczXWkmp21n0xPeLx66B/ddiZcEJHK9R5+gN6qbfMN3IHodBv2r8yqs1sVsPp2
 HcOgLGZh/Gc1QsFlJY79F4PwEgDNPuVWYUZX7Q7dz0ZDwIwU1QcsfiysgIA3IkbdbarP
 jk2aFxFpHgh+0jDLoMDNvxXR7LaK8VWooH56c6jhOB5k5kMEydRcI/gnCzj4q6TvDkf9
 H79QEOnZTdL40i2/qQY6FvuYoh5R+neMCZMU3/fpyDiUiNMcYRLgB6udq7pMnt6YgD3k
 YHbHdDkeEBSYowSgiWGUhyeqlz7DMMkK8X7gzXX1u8d5pfEXTAU72caHIU68pJzemRcy
 yYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TMHclhCvfwQV8iPUsIbu4B/w/VhFRgOjdCnzyEkr9Sw=;
 b=PgFbiKXUGXc+L/cxgwaVX1ubFabq5WVEnbzUPWzgg50QW1MY9qFoJB6tw6+c6l/xG6
 xYwm7EcCqHlERUiM3mFXKHqPCFDMhPMuJfo6cdxQYLuy2dq/ZVng4le3j3TN8F7HamE9
 oEhe0CkafiaD23Cs79nPsRg0g0BhXYm0kjdIzcc8RQuCQ4bGqIcyO28qjzzkGonaBrAu
 qjnOmxvRSJuDVlRAwuHoWRcgNPUDgklAVXs6V0ZvABElmvwRjGKuDxeLHpkMNDk8gyTd
 jyuwxqt0x+wTRjnnULEJJbUoiYR65EynChfxDBnGHR31gGYfORkAJ4w64dOWTKIMy341
 cs4Q==
X-Gm-Message-State: AOAM530JFhUa9IFrbQE70dFQRTTDnZcKKkTpZ6LHH8DzDvY9CUzvb06m
 PDUaCyKGQZcpeQ79GW90pLRouglnC3w=
X-Google-Smtp-Source: ABdhPJyMx2+CyNb6JzGBrXJeyzwLwvJjg3g4ngMXM6TMWIPolwqAgCeKvIhrTXahjv/e9hQWgFsPHw==
X-Received: by 2002:a17:90b:38c7:: with SMTP id
 nn7mr731495pjb.38.1630673839752; 
 Fri, 03 Sep 2021 05:57:19 -0700 (PDT)
Received: from bobo.ibm.com (203-219-56-12.tpgi.com.au. [203.219.56.12])
 by smtp.gmail.com with ESMTPSA id x16sm6352225pgc.49.2021.09.03.05.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Sep 2021 05:57:19 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 2/2] selftests/powerpc: Add scv versions of the basic TM
 syscall tests
Date: Fri,  3 Sep 2021 22:57:07 +1000
Message-Id: <20210903125707.1601269-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210903125707.1601269-1-npiggin@gmail.com>
References: <20210903125707.1601269-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Eirik Fuller <efuller@redhat.com>, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The basic TM vs syscall test code hard codes an sc instruction for the
system call, which fails to cover scv even when the userspace libc has
support for it.

Duplicate the tests with hard coded scv variants so both are tested
when possible.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 .../selftests/powerpc/tm/tm-syscall-asm.S     | 32 ++++++++++++++++-
 .../testing/selftests/powerpc/tm/tm-syscall.c | 36 +++++++++++++++----
 2 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/powerpc/tm/tm-syscall-asm.S b/tools/testing/selftests/powerpc/tm/tm-syscall-asm.S
index bd1ca25febe4..e59e93aad2cf 100644
--- a/tools/testing/selftests/powerpc/tm/tm-syscall-asm.S
+++ b/tools/testing/selftests/powerpc/tm/tm-syscall-asm.S
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#include <ppc-asm.h>
+#include <basic_asm.h>
 #include <asm/unistd.h>
 
 	.text
@@ -26,3 +26,33 @@ FUNC_START(getppid_tm_suspended)
 1:
 	li	r3, -1
 	blr
+
+FUNC_START(getppid_scv_tm_active)
+	PUSH_BASIC_STACK(0)
+	tbegin.
+	beq 1f
+	li	r0, __NR_getppid
+	scv	0
+	tend.
+	POP_BASIC_STACK(0)
+	blr
+1:
+	li	r3, -1
+	POP_BASIC_STACK(0)
+	blr
+
+FUNC_START(getppid_scv_tm_suspended)
+	PUSH_BASIC_STACK(0)
+	tbegin.
+	beq 1f
+	li	r0, __NR_getppid
+	tsuspend.
+	scv	0
+	tresume.
+	tend.
+	POP_BASIC_STACK(0)
+	blr
+1:
+	li	r3, -1
+	POP_BASIC_STACK(0)
+	blr
diff --git a/tools/testing/selftests/powerpc/tm/tm-syscall.c b/tools/testing/selftests/powerpc/tm/tm-syscall.c
index becb8207b432..9a822208680e 100644
--- a/tools/testing/selftests/powerpc/tm/tm-syscall.c
+++ b/tools/testing/selftests/powerpc/tm/tm-syscall.c
@@ -19,24 +19,37 @@
 #include "utils.h"
 #include "tm.h"
 
+#ifndef PPC_FEATURE2_SCV
+#define PPC_FEATURE2_SCV               0x00100000 /* scv syscall */
+#endif
+
 extern int getppid_tm_active(void);
 extern int getppid_tm_suspended(void);
+extern int getppid_scv_tm_active(void);
+extern int getppid_scv_tm_suspended(void);
 
 unsigned retries = 0;
 
 #define TEST_DURATION 10 /* seconds */
 #define TM_RETRIES 100
 
-pid_t getppid_tm(bool suspend)
+pid_t getppid_tm(bool scv, bool suspend)
 {
 	int i;
 	pid_t pid;
 
 	for (i = 0; i < TM_RETRIES; i++) {
-		if (suspend)
-			pid = getppid_tm_suspended();
-		else
-			pid = getppid_tm_active();
+		if (suspend) {
+			if (scv)
+				pid = getppid_scv_tm_suspended();
+			else
+				pid = getppid_tm_suspended();
+		} else {
+			if (scv)
+				pid = getppid_scv_tm_active();
+			else
+				pid = getppid_tm_active();
+		}
 
 		if (pid >= 0)
 			return pid;
@@ -82,15 +95,24 @@ int tm_syscall(void)
 		 * Test a syscall within a suspended transaction and verify
 		 * that it succeeds.
 		 */
-		FAIL_IF(getppid_tm(true) == -1); /* Should succeed. */
+		FAIL_IF(getppid_tm(false, true) == -1); /* Should succeed. */
 
 		/*
 		 * Test a syscall within an active transaction and verify that
 		 * it fails with the correct failure code.
 		 */
-		FAIL_IF(getppid_tm(false) != -1);  /* Should fail... */
+		FAIL_IF(getppid_tm(false, false) != -1);  /* Should fail... */
 		FAIL_IF(!failure_is_persistent()); /* ...persistently... */
 		FAIL_IF(!failure_is_syscall());    /* ...with code syscall. */
+
+		/* Now do it all again with scv if it is available. */
+		if (have_hwcap2(PPC_FEATURE2_SCV)) {
+			FAIL_IF(getppid_tm(true, true) == -1); /* Should succeed. */
+			FAIL_IF(getppid_tm(true, false) != -1);  /* Should fail... */
+			FAIL_IF(!failure_is_persistent()); /* ...persistently... */
+			FAIL_IF(!failure_is_syscall());    /* ...with code syscall. */
+		}
+
 		gettimeofday(&now, 0);
 	}
 
-- 
2.23.0

