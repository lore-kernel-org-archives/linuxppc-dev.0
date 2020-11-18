Return-Path: <SRS0=sQnj=EY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29323C5519F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2020 22:42:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42AE22468D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2020 22:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="LS7a0FIt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42AE22468D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CbyVH3NcwzDqc5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2020 09:41:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--morbo.bounces.google.com
 (client-ip=2607:f8b0:4864:20::f4a; helo=mail-qv1-xf4a.google.com;
 envelope-from=3tag1xwukdniacfzc4cc492.0ca96bildd0-12j96ghg.cn9yzg.cf4@flex--morbo.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20161025 header.b=LS7a0FIt; dkim-atps=neutral
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com
 [IPv6:2607:f8b0:4864:20::f4a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CbyM11ns2zDqbr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2020 09:35:37 +1100 (AEDT)
Received: by mail-qv1-xf4a.google.com with SMTP id s8so2588612qvr.20
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2020 14:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc; bh=V1Vpf/r+3OfbIuN6VyOcWCKY6n9LDBI1U6QyMc3bnGY=;
 b=LS7a0FItnZc0gIHOQHFKN77JpJ8UkHUmaeeRrcUPFa1MazuNvTijFA/TKJSnE9PKTi
 FJMWVqm276iXCwqHHQMKHLpyfzYSXrfpkomqmu9XG47QJl9RiwXz71zML6jQucodhfpK
 56L8b3jpP4UEpZ2i4EHOsgW6JvHAgh+aijHHmmgIeyer5pRwfpfaGzyhzNVlnaae8AVI
 FOLi43PwPKYyBujiUwyD1VmWlEcjfachnZv/xMAjQAr9brCVrkvw/u26l39S1Z+9inMI
 RW+ga+Jiucvj3o47sL/tG59yxYNgb8n9jGROITvLHCRpABmJo6u4f/VTpQPeoceU+/dN
 SPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=V1Vpf/r+3OfbIuN6VyOcWCKY6n9LDBI1U6QyMc3bnGY=;
 b=OHUhghUHjftSuYNin3MDnf3ZvTZDnxF75caMCB8zRXzGeS2ABfRsKmRfgqYdDZDoga
 QwIpUZooNdDm2fQRQfqO8fD8cOm/mH4g3Sg97Ml9zcqbqP+WKLFlYVNyC85KiluO2Zrp
 H4Cf0Q27y8FYcBsGraqgFLx1Tzj0eFOcAZzzHzuBH+Fu8Htd6e/wKtIwMb6mvFDRVhDl
 Wwhc4ABwCFt8L48L60tSNrE6QeYUEDV34FA1pwKvxdQvtWRZNepaM5j2ZeDrwmdbvbky
 +B09JErSGtAA+abIsVRNUxrgDqe3Zz14zjN9FG+cTiE/XsQIsXaJhBslZwBtchY8I8EP
 Du0Q==
X-Gm-Message-State: AOAM533GhsXZevwjiHZOFz/V/9rUNGUp2ZbE0+sGhH/eeRy9skw1HbHf
 B9auE2o8IXnwzfiQzCCbV6arABsr
X-Google-Smtp-Source: ABdhPJzvRz3hGsBvsWKO5f+Gfe7Rt0OvPt9PbJzdjI+CX0cTcdNsBz3SYabilOnTAZiuh2/8iMIr8bVQ3A==
X-Received: from fawn.svl.corp.google.com ([100.116.77.50]) (user=morbo
 job=sendgmr) by 2002:a0c:db8c:: with SMTP id m12mr7355504qvk.11.1605738933668; 
 Wed, 18 Nov 2020 14:35:33 -0800 (PST)
Date: Wed, 18 Nov 2020 14:35:13 -0800
In-Reply-To: <20201017004752.415054-3-morbo@google.com>
Message-Id: <20201118223513.2704722-4-morbo@google.com>
Mime-Version: 1.0
References: <20201017004752.415054-3-morbo@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH 3/3] powerpc/64s: feature: work around inline asm issues
From: Bill Wendling <morbo@google.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
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
Cc: Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The clang toolchain treats inline assembly a bit differently than
straight assembly code. In particular, inline assembly doesn't have the
complete context available to resolve expressions. This is intentional
to avoid divergence in the resulting assembly code.

We can work around this issue by borrowing a workaround done for ARM,
i.e. not directly testing the labels themselves, but by moving the
current output pointer by a value that should always be zero. If this
value is not null, then we will trigger a backward move, which is
explicitly forbidden.

Signed-off-by: Bill Wendling <morbo@google.com>
---
 arch/powerpc/include/asm/feature-fixups.h | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/feature-fixups.h b/arch/powerpc/include/asm/feature-fixups.h
index b0af97add751..34331c4ba61a 100644
--- a/arch/powerpc/include/asm/feature-fixups.h
+++ b/arch/powerpc/include/asm/feature-fixups.h
@@ -36,6 +36,18 @@ label##2:						\
 	.align 2;					\
 label##3:
 
+/*
+ * If the .org directive fails, it means that the feature instructions
+ * are smaller than the alternate instructions. This used to be written
+ * as
+ *
+ * .ifgt (label##4b-label##3b) - (label##2b-label##1b)
+ *      .error "Feature section else case larger than body"
+ * .endif
+ *
+ * but clang's assembler complains about the expression being non-absolute
+ * when the code appears in an inline assembly statement.
+ */
 #define MAKE_FTR_SECTION_ENTRY(msk, val, label, sect)		\
 label##4:							\
 	.popsection;						\
@@ -48,11 +60,8 @@ label##5:							\
 	FTR_ENTRY_OFFSET label##2b-label##5b;			\
 	FTR_ENTRY_OFFSET label##3b-label##5b;			\
 	FTR_ENTRY_OFFSET label##4b-label##5b;			\
-	.ifgt (label##4b- label##3b)-(label##2b- label##1b);	\
-	.error "Feature section else case larger than body";	\
-	.endif;							\
-	.popsection;
-
+	.popsection;						\
+	.org . - ((label##4b-label##3b) > (label##2b-label##1b));
 
 /* CPU feature dependent sections */
 #define BEGIN_FTR_SECTION_NESTED(label)	START_FTR_SECTION(label)
-- 
2.29.2.454.gaff20da3a2-goog

