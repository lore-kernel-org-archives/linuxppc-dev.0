Return-Path: <SRS0=Er2m=7W=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F83FC433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2020 07:18:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFA6920835
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2020 07:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIQmEdvf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA6920835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49h1gv2fJ3zDqVC
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2020 17:18:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102e;
 helo=mail-pj1-x102e.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=JIQmEdvf; dkim-atps=neutral
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49h0JT2HcfzDqlc
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jun 2020 16:16:57 +1000 (AEST)
Received: by mail-pj1-x102e.google.com with SMTP id m2so940154pjv.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2020 23:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rKfUjglDOVyzflc8oiqPOKNNxsCBrisCi40ZVFiBBhE=;
 b=JIQmEdvfO7+wPWPd3Mf7736B0od+V2keZbehrnUdkfwjE6dWf+ppQRq7RzEDNyXc/L
 NaCBKw2NBd9khNOBUHHX/5MHQ6XQq8SxRGFOYD5vqxSFMpAjUPhKYyGti7Tx5QFQQqk7
 4uXuAX46xT+GIwLJxFcjZgepWA69rOxZOy4N5SddZbRxqAOK0n3ZyEL/kbZ4lQE0iUGt
 EXYzl3ykA/2Efvdce8aofSqnbmYb18bI4mzQU0SA6WtI7ut7wqBYEKgRl3waOizb7QEa
 wSy2CgwEJ8U+vxso6xvH51RmwqbRf0rBf/bkrQNW79xeuYgl8oa0m32zodUx/4Y08r/7
 5aFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rKfUjglDOVyzflc8oiqPOKNNxsCBrisCi40ZVFiBBhE=;
 b=Y9WYQB9zGT/bW2pDotazCKDHnS/qG08WXhVCc/ACCUXVPyCTfVCP0RKIFtO9jv9d3r
 sYTBBrReqDGxEN4uEItS9XGpUjESfTjvSFwj1C7aLiGk/SEgvYliyfPdE+OpwCzcuK8E
 yDCIAG5YzK70NG4wuAewHZ8oNBelCBV7YJlJBDas4V8KJkmMUoNgwBj01KJeXNdeScAS
 osvVAorV5E9fSfnbgQoNtVjKdRvqKaN2WHCpiukVER1kODVShyaOpJ8TQxSFPO/5IMrX
 vca1d7R72Se8xyRZbljbRAS6nPSNRmPwpx0ecAftznpM2L98dDmp7ZVI6HADEFoHtIS7
 160g==
X-Gm-Message-State: AOAM531TF2ZVf/NQADuYgyPDCIxmryfyZpnJMoJjsgzuTc9j/t7fRivv
 2u0oM9E2l8NSR4nlg005IaRdwrgyEXI=
X-Google-Smtp-Source: ABdhPJypDI0aw+cAgVjUIDlfofsCFM7F/Ym8NqPjwbo2ZGs3r74yvBw60DXXxDI0NKyZ67OaurkVAg==
X-Received: by 2002:a17:90a:b30d:: with SMTP id
 d13mr3001078pjr.181.1591683414750; 
 Mon, 08 Jun 2020 23:16:54 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com ([61.68.71.10])
 by smtp.gmail.com with ESMTPSA id k12sm7567981pgm.11.2020.06.08.23.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 23:16:54 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: 
Subject: [PATCH 5/7] powerpc/64s: Move branch cache flushing bcctr variant to
 ppc-ops.h
Date: Tue,  9 Jun 2020 16:16:29 +1000
Message-Id: <20200609061631.844390-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200609061631.844390-1-npiggin@gmail.com>
References: <20200609061631.844390-1-npiggin@gmail.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/ppc-opcode.h | 2 ++
 arch/powerpc/kernel/entry_64.S        | 6 ++----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 2a39c716c343..79d511a38bbb 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -195,6 +195,7 @@
 #define OP_LQ    56
 
 /* sorted alphabetically */
+#define PPC_INST_BCCTR_FLUSH		0x4c400420
 #define PPC_INST_BHRBE			0x7c00025c
 #define PPC_INST_CLRBHRB		0x7c00035c
 #define PPC_INST_COPY			0x7c20060c
@@ -432,6 +433,7 @@
 #endif
 
 /* Deal with instructions that older assemblers aren't aware of */
+#define	PPC_BCCTR_FLUSH		stringify_in_c(.long PPC_INST_BCCTR_FLUSH)
 #define	PPC_CP_ABORT		stringify_in_c(.long PPC_INST_CP_ABORT)
 #define	PPC_COPY(a, b)		stringify_in_c(.long PPC_INST_COPY | \
 					___PPC_RA(a) | ___PPC_RB(b))
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 2ba25b3b701e..a115aeb2983a 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -261,8 +261,6 @@ _ASM_NOKPROBE_SYMBOL(save_nvgprs);
 1:	nop;			\
 	patch_site 1b, patch__call_flush_branch_caches
 
-#define BCCTR_FLUSH	.long 0x4c400420
-
 .macro nops number
 	.rept \number
 	nop
@@ -293,7 +291,7 @@ flush_branch_caches:
 	li	r9,0x7fff
 	mtctr	r9
 
-	BCCTR_FLUSH
+	PPC_BCCTR_FLUSH
 
 2:	nop
 	patch_site 2b patch__flush_count_cache_return
@@ -302,7 +300,7 @@ flush_branch_caches:
 
 	.rept 278
 	.balign 32
-	BCCTR_FLUSH
+	PPC_BCCTR_FLUSH
 	nops	7
 	.endr
 
-- 
2.23.0

