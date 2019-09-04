Return-Path: <SRS0=Ib4m=W7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7706C3A5A7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Sep 2019 12:03:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 422CD22CF5
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Sep 2019 12:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oBtpp6D8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 422CD22CF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46NjCF1HVRzDqv8
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Sep 2019 22:03:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="oBtpp6D8"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Nj2m3cjHzDqZ1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Sep 2019 21:56:16 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id u72so6939691pgb.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Sep 2019 04:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4pI70l4XnGTNGABUr04/BNiwcPY5f5gPieLvwPJRSWM=;
 b=oBtpp6D8iwnxtENefQks8pgodGsVl5YdSXLok9sgBSDPp+55kdJw26A9k0clq3dB/k
 Cxn4X1C4MQKSO6qRHe85CzDJJ0XeFvskW76R4mEXqUT6g5Ed2ffVbm2e3DIrRWWWiAzu
 NhCV02KcEwAb3pzOxWhqigvHKuAGt4YgpfDSK4HqpXvTowYqKg3cBnMCSpDMmZTuSZPN
 lkmreEwYzH6G74R7wYa4XroXYxpVtwsRPpFAZy2vIVwv+2wqmyFS09Y0oAxZvOpJ7PhJ
 PtvDB98a4AFseXMlu2cuEyqO2nLqiC4b3XCktuRSisd2EXleTAWI37SgdrdxUhm/7IJ/
 7lIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4pI70l4XnGTNGABUr04/BNiwcPY5f5gPieLvwPJRSWM=;
 b=WCYwgJituRUReMQnH0q8BDOiGrKzWGcPOiW/iW0AoR7aR4cD2N7eZAsCyJmgKqeoyC
 uoAQOFd+hKR/NL4sx9o8F+15MJEWw+k7umrbrlNwm+r5gAl1TJ5n5rgfdy+rBCelvXfv
 irKnNdVkj2eIlyCr7iJVErAWkiqz163GmwH4zSYUX+pwybs5nzQiqe8xgqeTsVEEu4SI
 /CcHVOP6FfTVdZngutOYcOkiXFtE/ClDALbZPnhuSRFgZx/cUGOCSyg3WJcpokl1v317
 6KnQNuIN7i+IYz6pT51H0O3xFhXXT4IRf7WH8YCEacPPoC4MzU4rF2wf6E2N+OBJwLsK
 Y9Tg==
X-Gm-Message-State: APjAAAVqQSBreUyO1Js/1E4RDKPQw/qJUmDjIewV7KqyiUjEtVqE0N5Q
 b2gAI1Ymyimno9TXKpuLamUlSbuc
X-Google-Smtp-Source: APXvYqyJyPDM92YnVhsluek1Cex9R9teiqLij22kPndRIk5ZQ6sq7LcfpfWtYHvDBFQ7q5G6bScoVQ==
X-Received: by 2002:a62:d14c:: with SMTP id t12mr12338016pfl.185.1567598173313; 
 Wed, 04 Sep 2019 04:56:13 -0700 (PDT)
Received: from bobo.local0.net ([203.63.189.78])
 by smtp.gmail.com with ESMTPSA id g18sm19554789pgm.9.2019.09.04.04.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 04:56:12 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 02/20] powerpc/64s/exception: Add GEN_COMMON macro that
 uses INT_DEFINE parameters
Date: Wed,  4 Sep 2019 21:55:17 +1000
Message-Id: <20190904115535.18559-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190904115535.18559-1-npiggin@gmail.com>
References: <20190904115535.18559-1-npiggin@gmail.com>
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

No generated code change.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index e6ad6e6cf65e..591ae2a73e18 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -206,6 +206,9 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 #define IMASK		.L_IMASK_\name\()
 #define IKVM_REAL	.L_IKVM_REAL_\name\()
 #define IKVM_VIRT	.L_IKVM_VIRT_\name\()
+#define ISTACK		.L_ISTACK_\name\()
+#define IRECONCILE	.L_IRECONCILE_\name\()
+#define IKUAP		.L_IKUAP_\name\()
 
 #define INT_DEFINE_BEGIN(n)						\
 .macro int_define_ ## n name
@@ -246,6 +249,15 @@ do_define_int n
 	.ifndef IKVM_VIRT
 		IKVM_VIRT=0
 	.endif
+	.ifndef ISTACK
+		ISTACK=1
+	.endif
+	.ifndef IRECONCILE
+		IRECONCILE=1
+	.endif
+	.ifndef IKUAP
+		IKUAP=1
+	.endif
 .endm
 
 .macro INT_KVM_HANDLER name, vec, hsrr, area, skip
@@ -670,6 +682,10 @@ END_FTR_SECTION_NESTED(CPU_FTR_CFAR, CPU_FTR_CFAR, 66)
 	.endif
 .endm
 
+.macro GEN_COMMON name
+	INT_COMMON IVEC, IAREA, ISTACK, IKUAP, IRECONCILE, IDAR, IDSISR
+.endm
+
 /*
  * Restore all registers including H/SRR0/1 saved in a stack frame of a
  * standard exception.
@@ -1221,13 +1237,7 @@ EXC_VIRT_BEGIN(data_access, 0x4300, 0x80)
 EXC_VIRT_END(data_access, 0x4300, 0x80)
 INT_KVM_HANDLER data_access, 0x300, EXC_STD, PACA_EXGEN, 1
 EXC_COMMON_BEGIN(data_access_common)
-	/*
-	 * Here r13 points to the paca, r9 contains the saved CR,
-	 * SRR0 and SRR1 are saved in r11 and r12,
-	 * r9 - r13 are saved in paca->exgen.
-	 * EX_DAR and EX_DSISR have saved DAR/DSISR
-	 */
-	INT_COMMON 0x300, PACA_EXGEN, 1, 1, 1, 1, 1
+	GEN_COMMON data_access
 	ld	r4,_DAR(r1)
 	ld	r5,_DSISR(r1)
 BEGIN_MMU_FTR_SECTION
-- 
2.22.0

