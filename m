Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF43C10F03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 21:58:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 800032148D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 21:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="JoV0DWkt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 800032148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pclh3sKwzDqLv
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 07:58:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (mailfrom)
 smtp.mailfrom=flex--ndesaulniers.bounces.google.com
 (client-ip=2607:f8b0:4864:20::74a; helo=mail-qk1-x74a.google.com;
 envelope-from=3e3-_xawkdgqpfgucwnpkgtuiqqing.eqonkpwzrre-fgxnkuvu.qbncdu.qti@flex--ndesaulniers.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="JoV0DWkt"; 
 dkim-atps=neutral
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com
 [IPv6:2607:f8b0:4864:20::74a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pbjL4KsNzDqQN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 07:11:26 +1000 (AEST)
Received: by mail-qk1-x74a.google.com with SMTP id s70so14299318qka.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 14:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=eHYZmjesflQdPVGOTGQwO4393GXn5tkz07pTFvSiuzs=;
 b=JoV0DWktfcvqI23dn2nF/pzJYfmDnrGO6DLOHhfm/g5OBEdGH7oA0Q5TOmf19zZAaj
 Q60IUoBjPZL39JkzbYjAO7l6GMwxpXnq1wEG8XgusrrYQVYtiA9g6jneFurYicXl+xSC
 qMS48VdntQhrXMpnnYMv0GMmCfrI3gj0PCPD/kxdao4CZllYceM+0GVfK4esyjY8ef3/
 FMxMTYl+zc9LYZ/kbIADFqFRmmi83ENVLSsGuTRJvCgmd9EjwqQdy5yaaNy/aLrfnYdQ
 zSDWWRtFJs9jB0BfTS9KpoESyRcwDiZRmJOj5rvAaboL3Tlzk5CMQompoROIODMjs28W
 1DEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=eHYZmjesflQdPVGOTGQwO4393GXn5tkz07pTFvSiuzs=;
 b=azBPTuWiNxxlJ8IcLkN3HUzh3dFf4iA8aB7lPOnqwXr0WteXarCV+f2y9bst6QYB5C
 0S/je12xk0E0dql7vIE+OwzJBnF1tihSrmX7SmJn9e968bR48on86IuQjB1+9Hfi9lmy
 Pz9o1m8iqvs2qqswASJJuM/yumUJYK9gjtH4zofJOYGWeI9JAYJKbY/WfzgigsoDMolw
 lIlycrnfxwlFyts/ZPG+QWgwA295TqtDtfX+vhkwGD66Mxhbzh4eIw99Crowi9wC9vUa
 YQ62pB6ODbghdKg1QfWPCkHuVivrjykcFBtvi0FuUDk6BbqLhm9xGhVV9bBwG/Kx2PSW
 cShQ==
X-Gm-Message-State: APjAAAWVDEj0Sd5rcF9si3ch/u6FWHMTwpIgSNTw3RR0MRYiA149v2DB
 U1w3z4IdJxVpEHmjeIpxyn9WoPWlmUZ10EvZqto=
X-Google-Smtp-Source: APXvYqwvUVrI5w7+HQ4Voz3Luialg00FkdVOpOuknQ3P85DcnoM1jeEyL7v3WA7N01k1YkXV8bVpSe0gA0rJoBxFp+U=
X-Received: by 2002:a37:9902:: with SMTP id b2mr10745835qke.239.1556053883187; 
 Tue, 23 Apr 2019 14:11:23 -0700 (PDT)
Date: Tue, 23 Apr 2019 14:11:14 -0700
Message-Id: <20190423211116.261111-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH] powerpc: vdso: drop unnecessary cc-ldoption
From: Nick Desaulniers <ndesaulniers@google.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org
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
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, clang-built-linux@googlegroups.com,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Dmitry Vyukov <dvyukov@google.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Towards the goal of removing cc-ldoption, it seems that --hash-style=
was added to binutils 2.17.50.0.2 in 2006. The minimal required version
of binutils for the kernel according to
Documentation/process/changes.rst is 2.20.

Link: https://gcc.gnu.org/ml/gcc/2007-01/msg01141.html
Cc: clang-built-linux@googlegroups.com
Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/powerpc/kernel/vdso32/Makefile | 5 ++---
 arch/powerpc/kernel/vdso64/Makefile | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/vdso32/Makefile b/arch/powerpc/kernel/vdso32/Makefile
index ce199f6e4256..06f54d947057 100644
--- a/arch/powerpc/kernel/vdso32/Makefile
+++ b/arch/powerpc/kernel/vdso32/Makefile
@@ -26,9 +26,8 @@ GCOV_PROFILE := n
 KCOV_INSTRUMENT := n
 UBSAN_SANITIZE := n
 
-ccflags-y := -shared -fno-common -fno-builtin
-ccflags-y += -nostdlib -Wl,-soname=linux-vdso32.so.1 \
-		$(call cc-ldoption, -Wl$(comma)--hash-style=both)
+ccflags-y := -shared -fno-common -fno-builtin -nostdlib \
+	-Wl,-soname=linux-vdso32.so.1 -Wl,--hash-style=both
 asflags-y := -D__VDSO32__ -s
 
 obj-y += vdso32_wrapper.o
diff --git a/arch/powerpc/kernel/vdso64/Makefile b/arch/powerpc/kernel/vdso64/Makefile
index 28e7d112aa2f..32ebb3522ea1 100644
--- a/arch/powerpc/kernel/vdso64/Makefile
+++ b/arch/powerpc/kernel/vdso64/Makefile
@@ -12,9 +12,8 @@ GCOV_PROFILE := n
 KCOV_INSTRUMENT := n
 UBSAN_SANITIZE := n
 
-ccflags-y := -shared -fno-common -fno-builtin
-ccflags-y += -nostdlib -Wl,-soname=linux-vdso64.so.1 \
-		$(call cc-ldoption, -Wl$(comma)--hash-style=both)
+ccflags-y := -shared -fno-common -fno-builtin -nostdlib \
+	-Wl,-soname=linux-vdso64.so.1 -Wl,--hash-style=both
 asflags-y := -D__VDSO64__ -s
 
 obj-y += vdso64_wrapper.o
-- 
2.21.0.593.g511ec345e18-goog

