Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C59C6786F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 03:31:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0668E20821
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 03:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ukcOrHEV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0668E20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42lDPr2s0qzF22r
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 14:30:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ukcOrHEV";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ukcOrHEV"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42lDMG3P5lzF1Q6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 14:28:42 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id o19-v6so6542677pll.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 20:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hkiQMuZb68Bws7nm5qJb3wroH0iBRmJTrQHyerd/nO4=;
 b=ukcOrHEVCv2LEMCZE//ejDKs7a5piuP2u4nyoWJQcmu/xXveMEECC3WuhN8BSs1TYc
 0dXKTKHhpRZ/c7YD13HmHtFbxebdOXABl5qWgPt5k3WIu3PrmEReQ0i7YIFU2a8HDHK8
 HPhVzrFWmKSAyDoaxX9+1aAmIMcQFIC+rJ7niHGoQo+9HxuR7NpdiKfJE6JfcAAsbzYD
 0dks3Pv6QSOVRrNGqo/BasXMTCDyOLWk9AzIYDGdP8Bt7YVqKwwVXCCJ7Q49QIgDQ9dx
 FCzimZViXPmStK/FVmxOGfChOF1coZ12IwaIi+wmWaQDUBHiekPieDv0Ho9sTyYpULwb
 1OTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=hkiQMuZb68Bws7nm5qJb3wroH0iBRmJTrQHyerd/nO4=;
 b=Ut2wTx1IQAuZ7Ydyo5S4nKe4dHKAKkryzxfbP/AJAtc3rx/coeAqVBSnR79OdyC+xA
 2gNNHClq498XcuMkHzAAT9kWivBi56bjGvonMvg+mcAc4O1tGsNwpXy8wRXtCIJ+a2Dz
 xL+zNxAdAj+aRIrGbUtA0A/+GHYtYA3wXYCW9zRCuAtx3rxA0zg1dkob4ISURNhSVqER
 ijpTgm72ZvM3rKw2sm14OOm1VmV+cnTpzj1GBcVKeRQDxO0nEwm7fpagIuhcUmJZDFOR
 DRP5PMRFXnJWu8eBL8znUufM2zshRjBd5CFctchGVFVkqEia55lGhHEBz9h1u3+ov7lA
 OrZA==
X-Gm-Message-State: AGRZ1gIUW87z4nM6jsV6EIgsTlY7eCWaqUrK9glAAh9MKc7Y388TsCGT
 T+7eQd7ULTie/lQzXscf8l4=
X-Google-Smtp-Source: AJdET5ekT1N4gQefzp/9Q2i4Yh1OE/2oSEa0bXUqfygddbX/1/Tx44yxD2f4cIDbdA4tf1f2mRSWLQ==
X-Received: by 2002:a17:902:6909:: with SMTP id
 j9-v6mr1439240plk.221.1540956520142; 
 Tue, 30 Oct 2018 20:28:40 -0700 (PDT)
Received: from aurora.jms.id.au ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id b62-v6sm27195786pfa.159.2018.10.30.20.28.35
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 30 Oct 2018 20:28:38 -0700 (PDT)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Wed, 31 Oct 2018 13:58:31 +1030
From: Joel Stanley <joel@jms.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] raid6/ppc: Fix build for clang
Date: Wed, 31 Oct 2018 13:58:29 +1030
Message-Id: <20181031032829.18131-1-joel@jms.id.au>
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
 lib/raid6/Makefile | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/lib/raid6/Makefile b/lib/raid6/Makefile
index 2f8b61dfd9b0..3a844e6fd01c 100644
--- a/lib/raid6/Makefile
+++ b/lib/raid6/Makefile
@@ -18,6 +18,21 @@ quiet_cmd_unroll = UNROLL  $@
 
 ifeq ($(CONFIG_ALTIVEC),y)
 altivec_flags := -maltivec $(call cc-option,-mabi=altivec)
+
+ifdef CONFIG_CC_IS_CLANG
+# clang ppc port does not yet support -maltifec when -msoft-float is
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

