Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0B0C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 01:44:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BF972075C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 01:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/X+LbE5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BF972075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ZphY10fJzDqWS
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 12:44:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="I/X+LbE5"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Zpfk5s1jzDqLF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2019 12:43:10 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id q1so4535196pfi.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Jan 2019 17:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BmFn7kEqOoM8HVylSIWAfzxIstDUaFsc+wa4gGeuK+8=;
 b=I/X+LbE5wjvFAh0JEI3CxsZPEWO+ozpYYSI5qQlUTn9aOoh/2MnCS1s+7+OHMRqcMx
 C/mk5I+le+O2nMZp3Mp2p4KUFrugDP65LWOfCdKHKhPklLnSVpwCIOnxi2bBUwHkog8k
 l7h3HPVbl9SRphxV+jKpOfgVhOx1qzHYP62Y/lnfBML1KRBktqPe6srV/Lj23GTkGlqL
 1/t4VtHamNw1wZ/tTFzmf3QzSUIodhduqsYWrfqENrAUwIUeZ5MoGa1uH4E0Ok4hP8o3
 VSQk01VvSpvX62T6loqzC6c8rJj/YycZ4NlP5lsmK4zvwgkGKT4vs22R36j4lysqHdPH
 fODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=BmFn7kEqOoM8HVylSIWAfzxIstDUaFsc+wa4gGeuK+8=;
 b=rdgnnAzx9oRs47u7QL0u9lAe4izEAceFlnw+lONiDVB0sWSjT6Aqpl1rVbuq9c5Dye
 tyOa1gNA9KNl0Y3Iv+BmGFQNpE8Y4BAn+cJ/E+BxYc3nqsIJr8HMbE9RJepdQh6qQsqy
 xN8WoSY/LSt5PdnaWuRi6BKo3dBjtWkx6g/w937Br6Ac/HwNxqj6CoF0NwBEigG1Ye2F
 oC/BFv442awpEp14v47IP8F+J+Qtxh9bd/85/zJ8ix34SKHi+L/4qz7Che2KoCFu77nF
 MsfDqO8y7mu4BRiwHgPtDamdTaNaugcOD7vgl0lV4TcMB/WOlDMt0qJhMUZGd0VOZQO4
 ndyg==
X-Gm-Message-State: AJcUukdaopOJgTz34N+RUyBMeT+U03WYgprvyJfiXCngBTbLn0drnDYq
 xpXBgHl8yFG30ZbYNz8Lp7dyyJXHrIo=
X-Google-Smtp-Source: ALg8bN7T8PpOhBq0aLaVOT7LsWROzuHJOzY8MQDvIJeFELzH0Nzg2nb1XuMGbILl0+gL6tXQJ6Bvng==
X-Received: by 2002:a63:4706:: with SMTP id u6mr7179005pga.95.1547084588458;
 Wed, 09 Jan 2019 17:43:08 -0800 (PST)
Received: from aurora.jms.id.au (natp-s01-129-78-56-201.gw.usyd.edu.au.
 [129.78.56.201])
 by smtp.gmail.com with ESMTPSA id f67sm147708925pff.29.2019.01.09.17.43.05
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 09 Jan 2019 17:43:07 -0800 (PST)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Thu, 10 Jan 2019 12:43:02 +1100
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/vdso32: Drop -mabi=elfv1 for 32 bit objects
Date: Thu, 10 Jan 2019 12:42:58 +1100
Message-Id: <20190110014258.20963-1-joel@jms.id.au>
X-Mailer: git-send-email 2.19.1
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
Cc: Nick Desaulniers <ndesaulniers@google.com>, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Daniel Axtens <dja@axtens.net>

All 64-bit objects need to specify the flag to be compiled correctly, we
just don't need it for 32-bit objects. GCC just ignored it, but clang
doesn't.

Link: https://github.com/ClangBuiltLinux/linux/issues/240
Signed-off-by: Daniel Axtens <dja@axtens.net>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/powerpc/kernel/vdso32/Makefile | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/powerpc/kernel/vdso32/Makefile b/arch/powerpc/kernel/vdso32/Makefile
index 50112d4473bb..6bd41756e0c7 100644
--- a/arch/powerpc/kernel/vdso32/Makefile
+++ b/arch/powerpc/kernel/vdso32/Makefile
@@ -34,6 +34,20 @@ obj-y += vdso32_wrapper.o
 extra-y += vdso32.lds
 CPPFLAGS_vdso32.lds += -P -C -Upowerpc
 
+# clang refuses to accept -mabi=elfv1 for when using the
+# 64-bit target in 32-bit mode
+ifdef CONFIG_CC_IS_CLANG
+ifdef CONFIG_PPC64
+AFLAGS_REMOVE_getcpu.o += -mabi=elfv1
+endif
+AFLAGS_REMOVE_sigtramp.o += -mabi=elfv1
+AFLAGS_REMOVE_gettimeofday.o += -mabi=elfv1
+AFLAGS_REMOVE_datapage.o += -mabi=elfv1
+AFLAGS_REMOVE_cacheflush.o += -mabi=elfv1
+AFLAGS_REMOVE_note.o += -mabi=elfv1
+endif
+
+
 # Force dependency (incbin is bad)
 $(obj)/vdso32_wrapper.o : $(obj)/vdso32.so
 
-- 
2.19.1

