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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF10C3A5A7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Sep 2019 12:21:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B96F22CED
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Sep 2019 12:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGN57lLx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B96F22CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Njc26cYDzDqvN
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Sep 2019 22:21:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="kGN57lLx"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Nj352P5pzDqcQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Sep 2019 21:56:33 +1000 (AEST)
Received: by mail-pg1-x544.google.com with SMTP id u17so11126487pgi.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Sep 2019 04:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5ZmsHhdmjn8P3iLIFdrowDUZZICRhM5xaT/QNpS7Fe8=;
 b=kGN57lLx0ELcOYy1fqgxnwxa7e/vGO+g0PbWPz+0pcvt0YE1YRmGgo8FmhuH/eoKCv
 3/YxxnpmoWDSH1bigyMoUimyLBmz1opCWC01NGvNZDaiXrGnKZcYiLkiBqAxxOlfRC97
 XLLa5NYEMvhOLkVrqysr2jmlC2z94Pi85M1WBAsvKp5pvzuT/OXc0AJjM94Kywp+eNRE
 kJeg+KqH/de0IlQSP5Apj/tHU4hoPqPd1KvuDnNCJS/BHhYDLrADOreY3vhST7G8NIEN
 texjBLVMJOCC23xDpeGzAxkcjrhMhQ4d47stFVrvQ5IL0gYcdkmHdKfeil86dT6uc+pr
 sN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5ZmsHhdmjn8P3iLIFdrowDUZZICRhM5xaT/QNpS7Fe8=;
 b=BfijN+RfuljG79QzFuDnjdpITAYPPyYW1vXV4rQzbDLKSolWQzruE0+FBTJh6ExMME
 by3mBi7s8RYbFzvXuFQJ4PjLHtK5jTA6fREbA7Cws1WCGVdy8RID9zZPcXeq8ceva9bJ
 kMGTwY1QYBpUXbQ81qWaA1tIxc7F5RbdSPhZHDkD3tihhZjvULTSfgwCAoOTu4UQTyU+
 Be5Z0dO171vENFSl2LCt9ppjbR1v6+gJktShxKAq96F0r+YSGyumD2gijzrnBMq7xYDB
 +CK3uFHevIT/0yGohK00S01re56RLDh4Tzh8jGKwXGIuLwv1HarcpFrQrgJOLx/0k/je
 qo2A==
X-Gm-Message-State: APjAAAUOsYnJpNJBX+hC5Wr8kSQvyyd12jYtKVNryJ96vzchYxDEn/nO
 T4Me5Oq7jmm4bfzRYzrhkTl0cGZy
X-Google-Smtp-Source: APXvYqzhJFHbKFdKphdQ9pcYHe8S2+wJwuAh103FruyhkNUs8/NEQAS7ImKBZqodlo92xARXX2aRkw==
X-Received: by 2002:a17:90a:2ecb:: with SMTP id
 h11mr4458706pjs.108.1567598190275; 
 Wed, 04 Sep 2019 04:56:30 -0700 (PDT)
Received: from bobo.local0.net ([203.63.189.78])
 by smtp.gmail.com with ESMTPSA id g18sm19554789pgm.9.2019.09.04.04.56.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 04:56:29 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 09/20] powerpc/64s/exception: Add ISIDE option
Date: Wed,  4 Sep 2019 21:55:24 +1000
Message-Id: <20190904115535.18559-10-npiggin@gmail.com>
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

Rather than using DAR=2 to select the i-side registers, add an
explicit option.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index bef0c2eee7dc..b8588618cdc3 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -199,6 +199,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 #define IVEC		.L_IVEC_\name\()
 #define IHSRR		.L_IHSRR_\name\()
 #define IAREA		.L_IAREA_\name\()
+#define IISIDE		.L_IISIDE_\name\()
 #define IDAR		.L_IDAR_\name\()
 #define IDSISR		.L_IDSISR_\name\()
 #define ISET_RI		.L_ISET_RI_\name\()
@@ -231,6 +232,9 @@ do_define_int n
 	.ifndef IAREA
 		IAREA=PACA_EXGEN
 	.endif
+	.ifndef IISIDE
+		IISIDE=0
+	.endif
 	.ifndef IDAR
 		IDAR=0
 	.endif
@@ -542,7 +546,7 @@ END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,948)
 	 */
 	GET_SCRATCH0(r10)
 	std	r10,IAREA+EX_R13(r13)
-	.if IDAR == 1
+	.if IDAR && !IISIDE
 	.if IHSRR
 	mfspr	r10,SPRN_HDAR
 	.else
@@ -550,7 +554,7 @@ END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,948)
 	.endif
 	std	r10,IAREA+EX_DAR(r13)
 	.endif
-	.if IDSISR == 1
+	.if IDSISR && !IISIDE
 	.if IHSRR
 	mfspr	r10,SPRN_HDSISR
 	.else
@@ -625,16 +629,18 @@ END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,948)
 	std	r9,GPR11(r1)
 	std	r10,GPR12(r1)
 	std	r11,GPR13(r1)
+
 	.if IDAR
-	.if IDAR == 2
+	.if IISIDE
 	ld	r10,_NIP(r1)
 	.else
 	ld	r10,IAREA+EX_DAR(r13)
 	.endif
 	std	r10,_DAR(r1)
 	.endif
+
 	.if IDSISR
-	.if IDSISR == 2
+	.if IISIDE
 	ld	r10,_MSR(r1)
 	lis	r11,DSISR_SRR1_MATCH_64S@h
 	and	r10,r10,r11
@@ -643,6 +649,7 @@ END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,948)
 	.endif
 	std	r10,_DSISR(r1)
 	.endif
+
 BEGIN_FTR_SECTION_NESTED(66)
 	ld	r10,IAREA+EX_CFAR(r13)
 	std	r10,ORIG_GPR3(r1)
@@ -1311,8 +1318,9 @@ ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
 
 INT_DEFINE_BEGIN(instruction_access)
 	IVEC=0x400
-	IDAR=2
-	IDSISR=2
+	IISIDE=1
+	IDAR=1
+	IDSISR=1
 	IKVM_REAL=1
 INT_DEFINE_END(instruction_access)
 
@@ -1341,7 +1349,8 @@ INT_DEFINE_BEGIN(instruction_access_slb)
 	IVEC=0x480
 	IAREA=PACA_EXSLB
 	IRECONCILE=0
-	IDAR=2
+	IISIDE=1
+	IDAR=1
 	IKVM_REAL=1
 INT_DEFINE_END(instruction_access_slb)
 
-- 
2.22.0

