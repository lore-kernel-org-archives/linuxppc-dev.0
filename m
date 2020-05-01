Return-Path: <SRS0=sn4m=6P=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EC2C4724C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 May 2020 04:32:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 995772071C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 May 2020 04:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVT0hdIE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 995772071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49CzrJ1fpYzDqrm
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 May 2020 14:32:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::544;
 helo=mail-pg1-x544.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=lVT0hdIE; dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49Cytz1rM5zDq9R
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2020 13:50:03 +1000 (AEST)
Received: by mail-pg1-x544.google.com with SMTP id o185so4040654pgo.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2020 20:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=BhUTsQjugv+WVOhbVsksIiOgcS9MTH+qNFehoKZrcLw=;
 b=lVT0hdIEVpsHJ9yALsHGObjHVW/bQ9GMwABoykrmJW1eiddGLGS1rG62o8XuXKXvWW
 G/5+ZIThgoBsTrEsqLmb6rJcL0C4JPDEzEf/HLrDArISiP0hUGVFzUzaYjpBN8k1KJ0Q
 DwZs5TUnoDM7fAJniMmTVRP9ClSwDu8PNpwaT0SzmqvwPlsCogAIbQU3FRHqcO2wqRGt
 f0/6jQtvvwtC1fmfNdcfu6kZF056rIObk79pGQZAKPRf+xQa6ubPhTXQccefoA06QTrK
 HmfcDsIwkXXVYrvdpEtJHi4qe8Yr9PQCUEorkOBGOXtxaSNLDB8bJ8otUSJzkPpJndVe
 kTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=BhUTsQjugv+WVOhbVsksIiOgcS9MTH+qNFehoKZrcLw=;
 b=WV8pwwgTHE7B554fQKXfCpb7vD4tT+bRmrZsLdxDXleSpbE4Yts0P4Q0JPNwkS38aF
 XwARRO+PKsEoBUy+69nbjmwSHZgCQokKgZZmMgMKJr766FB1DS+4tJecJshN/qYoF5LS
 GseyUrURsgfUmdwIdIqb9++diS/1UxwP1ixsLdtYGeEjv1N9CBjMPEdmPfY8e4/zj1sj
 6TiNFwlHqMdMuZWJeUWDyA4f4NajSyvYGz7YiIcQO25tLHaFB3deqahAi6SdlJMIZM3m
 DX8Re1vY03EeU+X7S8YbUtVNBmyTwzkNLjD01gulZEUYGC7sGSuc2O/tLFTRObpdgAcs
 Ts+g==
X-Gm-Message-State: AGi0Pua97tVRnFNXdsLu5gxDZ1pFv7IKAD1k764YxGDqtQqBGmKPzS/D
 j6OqDIGHejL0RaMN3IK77OMwJ5d34RORGA==
X-Google-Smtp-Source: APiQypLyt6D9g+rfcsGTWxGe6ACGST3uf4gCJWQyarMnDX5Dr00CTCJCWzkpiN2GiaDP0EHCRhnYLQ==
X-Received: by 2002:a62:6443:: with SMTP id y64mr2247151pfb.100.1588305001098; 
 Thu, 30 Apr 2020 20:50:01 -0700 (PDT)
Received: from localhost.localdomain
 (180-150-65-4.b49641.syd.nbn.aussiebb.net. [180.150.65.4])
 by smtp.gmail.com with ESMTPSA id w28sm940082pgc.26.2020.04.30.20.49.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 20:50:00 -0700 (PDT)
From: Jordan Niethe <jniethe5@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v7 24/28] powerpc: Test prefixed code patching
Date: Fri,  1 May 2020 13:42:16 +1000
Message-Id: <20200501034220.8982-25-jniethe5@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200501034220.8982-1-jniethe5@gmail.com>
References: <20200501034220.8982-1-jniethe5@gmail.com>
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
Cc: alistair@popple.id.au, npiggin@gmail.com, bala24@linux.ibm.com,
 naveen.n.rao@linux.vnet.ibm.com, Jordan Niethe <jniethe5@gmail.com>,
 dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Expand the code-patching self-tests to includes tests for patching
prefixed instructions.

Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
---
v6: New to series
---
 arch/powerpc/lib/Makefile             |  2 +-
 arch/powerpc/lib/code-patching.c      | 21 +++++++++++++++++++++
 arch/powerpc/lib/test_code-patching.S | 19 +++++++++++++++++++
 3 files changed, 41 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/lib/test_code-patching.S

diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 546591848219..5e994cda8e40 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -16,7 +16,7 @@ CFLAGS_code-patching.o += -DDISABLE_BRANCH_PROFILING
 CFLAGS_feature-fixups.o += -DDISABLE_BRANCH_PROFILING
 endif
 
-obj-y += alloc.o code-patching.o feature-fixups.o pmem.o inst.o
+obj-y += alloc.o code-patching.o feature-fixups.o pmem.o inst.o test_code-patching.o
 
 ifndef CONFIG_KASAN
 obj-y	+=	string.o memcmp_$(BITS).o
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index b32fa707725e..7107c6d01261 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -699,6 +699,24 @@ static void __init test_translate_branch(void)
 	vfree(buf);
 }
 
+#ifdef __powerpc64__
+static void __init test_prefixed_patching(void)
+{
+	extern unsigned int code_patching_test1[];
+	extern unsigned int code_patching_test1_expected[];
+	extern unsigned int end_code_patching_test1[];
+
+	__patch_instruction((struct ppc_inst *)code_patching_test1,
+			    ppc_inst_prefix(1 << 26, 0x00000000),
+			    (struct ppc_inst *)code_patching_test1);
+
+	check(!memcmp(code_patching_test1,
+		      code_patching_test1_expected,
+		      sizeof(unsigned int) *
+		      (end_code_patching_test1 - code_patching_test1)));
+}
+#endif
+
 static int __init test_code_patching(void)
 {
 	printk(KERN_DEBUG "Running code patching self-tests ...\n");
@@ -707,6 +725,9 @@ static int __init test_code_patching(void)
 	test_branch_bform();
 	test_create_function_call();
 	test_translate_branch();
+#ifdef __powerpc64__
+	test_prefixed_patching();
+#endif
 
 	return 0;
 }
diff --git a/arch/powerpc/lib/test_code-patching.S b/arch/powerpc/lib/test_code-patching.S
new file mode 100644
index 000000000000..91aab208a804
--- /dev/null
+++ b/arch/powerpc/lib/test_code-patching.S
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 IBM Corporation
+ */
+
+	.text
+
+#define globl(x)		\
+	.globl x;	\
+x:
+
+globl(code_patching_test1)
+	nop
+	nop
+globl(end_code_patching_test1)
+
+globl(code_patching_test1_expected)
+	.long 1 << 26
+	.long 0x0000000
-- 
2.17.1

