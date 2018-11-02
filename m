Return-Path: <SRS0=pcIm=NN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89BEC0044C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 00:47:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0372520666
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 00:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKsCC6US"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0372520666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42mNhC4fcwzF31t
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 11:47:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WKsCC6US";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="WKsCC6US"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42mNdf5MJnzDrJs
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Nov 2018 11:45:10 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id b11-v6so167335pfi.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Nov 2018 17:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HIonunmopofPGzSNm75ie2dBu2DrhPo42aMJpvxj16s=;
 b=WKsCC6USfGKBWf7sdRhHN+Ns+u3Qi32TVhckF5ZO7P/46ZbZOBigxEMdQQKLJPL+If
 RLmfgP2oPrqyib7TPKpSWDcTGx0c2xjbYUQC9p599wXUdy+GhNG67bKZv2bOp+/w6Pyl
 hNHmJluj5nx0is7boind93FL8tpe7hkyfaoqP2By9AVVoJtA9sUAtsI0VusJVckORxZe
 KR/VocN/LnSRTni4VQq30Ki6Lavr230lNBIVivTgksMdYullPVBZHEiiWSyeR/1lqJeK
 yNnCG2SzaTXAQ2vx38V1cTnMUj3DtTsaRrDQ02i5vd6RjlhTa5FSHhbUAT0Rkjvd1Y8J
 +oyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=HIonunmopofPGzSNm75ie2dBu2DrhPo42aMJpvxj16s=;
 b=bqbNoH8OkEu07DkGx93HJxjx4rJBBPog4dvCMUdZyh7WtkILdVC7NndHMW+NFCemb+
 sqGRQQGnoNveaf2WgylQoUBcozKZkJZg07/W/VclmjJQOIQkEWhGihfn1SwNFETvPsqg
 EM6Py8c2KOSwLxJD57hcAA/QdzHwPl9QWthMSPP0I6ZFQogYrKwX7UVwIEei7bOUPszt
 4xuhj4NtNsrhIxZzpI5raGMoowz//S7DfDzZ8mhCXjlQEUFIuURjd6z2DdkYQ1IEwAzC
 ix6nfyLET9taNN2aCBtetaqbWY11mrF6ZoZOoJP43NB8ihbCE69MbfpxJ2TWEdF1QIkw
 UMTQ==
X-Gm-Message-State: AGRZ1gLNx+iPqzZa+DLshs86/5VP+zLjETD4a0WE5uq9gps0RnWp0M3s
 FXM7GEDBKJl7SPOHsMfxbPQ=
X-Google-Smtp-Source: AJdET5cmBd3bR6iAqNr57q7YSwG+um3oWBF7hrdjWIvB8uSJMQ1tF2ARax6rnTkjlWiSdx27TnvnEw==
X-Received: by 2002:a62:e707:: with SMTP id
 s7-v6mr9865843pfh.124.1541119507975; 
 Thu, 01 Nov 2018 17:45:07 -0700 (PDT)
Received: from aurora.jms.id.au ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id q7-v6sm26252401pgv.78.2018.11.01.17.45.03
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 01 Nov 2018 17:45:07 -0700 (PDT)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Fri, 02 Nov 2018 11:15:00 +1030
From: Joel Stanley <joel@jms.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] raid6/ppc: Fix build for clang
Date: Fri,  2 Nov 2018 11:14:55 +1030
Message-Id: <20181102004455.10157-1-joel@jms.id.au>
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
Cc: Jinsong Ji <jji@us.ibm.com>, Nick Desaulniers <ndesaulniers@google.com>,
 Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

We cannot build these files with clang as it does not allow altivec
instructions in assembly when -msoft-float is passed.

Jinsong Ji <jji@us.ibm.com> wrote:
> We currently disable Altivec/VSX support when enabling soft-float.  So
> any usage of vector builtins will break.
>
> Enable Altivec/VSX with soft-float may need quite some clean up work, so
> I guess this is currently a limitation.
>
> Removing -msoft-float will make it work (and we are lucky that no
> floating point instructions will be generated as well).

This is a workaround until the issue is resolved in clang.

Link: https://bugs.llvm.org/show_bug.cgi?id=31177
Link: https://github.com/ClangBuiltLinux/linux/issues/239
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v2: fix typo in comment, thanks Jinsong

 lib/raid6/Makefile | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/lib/raid6/Makefile b/lib/raid6/Makefile
index 2f8b61dfd9b0..7ed43eaa02ef 100644
--- a/lib/raid6/Makefile
+++ b/lib/raid6/Makefile
@@ -18,6 +18,21 @@ quiet_cmd_unroll = UNROLL  $@
 
 ifeq ($(CONFIG_ALTIVEC),y)
 altivec_flags := -maltivec $(call cc-option,-mabi=altivec)
+
+ifdef CONFIG_CC_IS_CLANG
+# clang ppc port does not yet support -maltivec when -msoft-float is
+# enabled. A future release of clang will resolve this
+# https://bugs.llvm.org/show_bug.cgi?id=31177
+CFLAGS_REMOVE_altivec1.o  += -msoft-float
+CFLAGS_REMOVE_altivec2.o  += -msoft-float
+CFLAGS_REMOVE_altivec4.o  += -msoft-float
+CFLAGS_REMOVE_altivec8.o  += -msoft-float
+CFLAGS_REMOVE_altivec8.o  += -msoft-float
+CFLAGS_REMOVE_vpermxor1.o += -msoft-float
+CFLAGS_REMOVE_vpermxor2.o += -msoft-float
+CFLAGS_REMOVE_vpermxor4.o += -msoft-float
+CFLAGS_REMOVE_vpermxor8.o += -msoft-float
+endif
 endif
 
 # The GCC option -ffreestanding is required in order to compile code containing
-- 
2.19.1

