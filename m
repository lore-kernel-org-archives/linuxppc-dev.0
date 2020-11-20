Return-Path: <SRS0=wfc/=E2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9343BC2D0E4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2020 22:44:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80D292236F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2020 22:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="CSj11HYA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D292236F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CdBSD74kKzDr3V
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Nov 2020 09:44:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--morbo.bounces.google.com
 (client-ip=2607:f8b0:4864:20::b4a; helo=mail-yb1-xb4a.google.com;
 envelope-from=360w4xwukdfwgil5iaiiaf8.6igfchorjj6-78pfcmnm.itf45m.ila@flex--morbo.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20161025 header.b=CSj11HYA; dkim-atps=neutral
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com
 [IPv6:2607:f8b0:4864:20::b4a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CdBN40yMXzDqyw
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2020 09:40:45 +1100 (AEDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a126so13522254ybb.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2020 14:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc; bh=d+bIZ09nG8hw+ySjYPTAu1+6YR5JEF4dm7h9RsWiYik=;
 b=CSj11HYAwXoLO/bTOWahWYZ245Tj2efGfJyfcoNT4TDiUwNdKu8AK8Vy3ljvFF7nAt
 K0i0/0g7ZqZkr6mGDDJCj7zPy/DqfK+etqj+JKpe5t6o/lhzMEuIAB/tdGe4tKgoauXo
 wZMXq0xkfflL3lhwFlAcHhO5vHVco9k410Uv8OboiLV2UBQwWrJ7Y/OinohyB78dyha1
 P/W9SamgKT7kAxfj55vr4SLDBqIj6/ObFq+BzVXRdc4PGTqsy30wTHFicrSXoSKq8XX/
 R0vaj66XlOII1/e7OqW4gQ0PHws+BJAh/gmIpKwLhjGqHDkefjrCC2RyizwXLjhmjNPa
 5HKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=d+bIZ09nG8hw+ySjYPTAu1+6YR5JEF4dm7h9RsWiYik=;
 b=qGijIac03wpacrlM1DsihMyX9UEQnX4e0BsCQM2fzkeB06yBb831R5YLjU77Ui9iHw
 x5/V0o4lEesLxc8P6Y34rw1xSHbqWuMZLwjaDJ18NraQgOcP9nG2r/kVge+7NbmwZ3fk
 0vUt7sr5Wvg6UMjnNZin1CcetsG9nnuoiH2GKCeAUzV7bVdQRV8syjP1/ESbxUjwvnUk
 ofUrh01doUS6eyeF1HHTwDt4G7QGUPMsvfQr68Jxc4wff3sjVf5uBl65efKbQQOXok2C
 XzMAE8YAExreKFFVPUqDT2qkXIouFrJGJaWB5XqCh1hmVulRHBZsbZpM3lr5X1ZrI6oz
 NS1w==
X-Gm-Message-State: AOAM532dlQrtwMcJeJlLwsGwBRLCUdTS69EavbU10OcxDwWlqbUf48ND
 UGl+IAcge8wkIOI/I5a/2/B3h7gv
X-Google-Smtp-Source: ABdhPJyh0wl3htiuHCSYoNb4GGXs51BTzAsohHHC2UrpSiiqvwVNxcFqJ8uJa0WKSWY2TyDsk2LegGiRrA==
X-Received: from fawn.svl.corp.google.com ([100.116.77.50]) (user=morbo
 job=sendgmr) by 2002:a25:7481:: with SMTP id
 p123mr21066335ybc.167.1605912043815; 
 Fri, 20 Nov 2020 14:40:43 -0800 (PST)
Date: Fri, 20 Nov 2020 14:40:33 -0800
In-Reply-To: <20201120224034.191382-1-morbo@google.com>
Message-Id: <20201120224034.191382-3-morbo@google.com>
Mime-Version: 1.0
References: <20201118223513.2704722-1-morbo@google.com>
 <20201120224034.191382-1-morbo@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v3 2/3] powerpc/boot: Use clang when CC is clang
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

The gcc compiler may not be available if CC is clang.

Signed-off-by: Bill Wendling <morbo@google.com>
---
 arch/powerpc/boot/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index f8ce6d2dde7b..68a7534454cd 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -21,7 +21,11 @@
 all: $(obj)/zImage
 
 ifdef CROSS32_COMPILE
+ifdef CONFIG_CC_IS_CLANG
+    BOOTCC := $(CROSS32_COMPILE)clang
+else
     BOOTCC := $(CROSS32_COMPILE)gcc
+endif
     BOOTAR := $(CROSS32_COMPILE)ar
 else
     BOOTCC := $(CC)
-- 
2.29.2.454.gaff20da3a2-goog

