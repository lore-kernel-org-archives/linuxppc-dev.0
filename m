Return-Path: <linuxppc-dev+bounces-26895-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85510C79F8C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 08:52:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfvgD4CQbz305b;
	Wed, 09 Sep 2026 18:51:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788943896;
	cv=none; b=X6HU1qwEbSCDSWdttan1mKD3OUsz+qqSLTVW/+cjMQ7oAzsWV9dEK+OtaQRvujQu/Y0T8rS/jkAUjc2sT044EzqLl4O8QPy/s8lML4NiCwwbzA6QypvzPNKwomq2px3/SlXwSpXwOTywAQ12iNoLaGtRdQtoLXiZfyy58wErjKTpX9lFJHVqUV8SUvnirXkcivq4SZ+i0ytrf/5mcMFk5o5xxsHltjszpzA+seGSZgfX1+vDGybRtZOwRybGinN0RFTrMBbGHc4//ouJ1JOs1WY/ajnC7uWTWUL9CNLgcoRDbZfvR91tu1HHTqyREk2xEzmf/mpbTwWlOaYRV63Ofg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788943896; c=relaxed/relaxed;
	bh=CQ6ZZ42sEo0FMBMnZaDqvhvFmH70JPCseJfddupHf7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LhiXxMPWFjqSw25aTBEPFNKZ4QQgcUQxrUO97lLIn5w+ZFQ7DGiI9v7QyfWBKQhbXVSwbIEPWlVdVfaEHcVVGQLLVWVgPewZii5abAuxVTFWzAKoJ3niMC2fBGdtsOojAda+/ap8U8w6LB+Yf0uclJirZjEe4KHFpAG8DTpQNZOFWus4h+k1uespYb4bFXEBYQk35FLJ931gd7u/r13hvf19sJEurkzhm9OboyuZ91XqRGVfziycUradi0z8vP8uQYsnUem/Cymh0JlwfaZkHdP6tsKHrenPMemU9yKgnqTiYoiN+11JdCCV9RtBtae93agw3eMD4b+zEuW5VsIwqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=IdgLyGap; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=VVFeQNO/; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=IdgLyGap;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=VVFeQNO/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfvg8510zz2yvM
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 18:51:32 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788943884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CQ6ZZ42sEo0FMBMnZaDqvhvFmH70JPCseJfddupHf7M=;
	b=IdgLyGapCdf08hmIlLUWBy5AL4aW14xA2DS8OXFT1Zb3CfDnLbwZzDeXVhoDtbepPja8BN
	ryTtklMY2ERezCHSjJlc8z6NqAmiDSIy1DJogjFxpiZHuvKq7I5LB3MdZv9H4OozHj6Tng
	jbuQ4bPlOXu2wnT85khiyqOCKQBqOycEa8gaAjPIKxtVnd7LNbfnR49SgNv8Yl+pmxE0Ms
	s+Yl7j6gRiBR+fdcJhs4gs56Mczg7vk4/5aJnJbPl7DjBAqCEpkK7rppWwNbmLG9BrzDR7
	ChLjxpdfSnPxkp9jo/Sqv2fznf1ecuWEK6Jrcl1M/D7NpH6KpEFrKYbzuewvbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788943884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CQ6ZZ42sEo0FMBMnZaDqvhvFmH70JPCseJfddupHf7M=;
	b=VVFeQNO/Qr/Vdm/q5BIomEtSc9i3kd9MK5TvsOwwjy2HYSUJfnaUQnR6L8aW7POLHXLm9j
	GGUXnc3tC3NpprCg==
Date: Wed, 09 Sep 2026 10:51:20 +0200
Subject: [PATCH 07/15] sparc/vdso: Move __VDSO_PAGES to asm/vdso.h
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260909-vdso-asm-generic-vsyscall-h-v1-7-63ae856cc659@linutronix.de>
References: <20260909-vdso-asm-generic-vsyscall-h-v1-0-63ae856cc659@linutronix.de>
In-Reply-To: <20260909-vdso-asm-generic-vsyscall-h-v1-0-63ae856cc659@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
 sparclinux@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788943875; l=1764;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=VaPdauFQWLU0KJEV2a1f+WJtOXR8fxXaZFpswc0b434=;
 b=jH77Q51ITwUmOjNWzqUo9lEC+d/JgkdmQkYyv3oztNYP+7L0bV4RFQRJ0PdkZOHP7kKbcLVEn
 InKr6KCGEt+AhGlPxfVPXNdvyax8i9utdLhbRU/m9JgTxddcG4QStTx
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Most architectures define the __VDSO_PAGES page macro in asm/vdso.h.

Align the SPARC headers.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/sparc/include/asm/vdso.h          | 6 ++++++
 arch/sparc/include/asm/vdso/vsyscall.h | 2 --
 arch/sparc/vdso/vdso-layout.lds.S      | 2 +-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/include/asm/vdso.h b/arch/sparc/include/asm/vdso.h
index f08562d10215..b17c37c8075b 100644
--- a/arch/sparc/include/asm/vdso.h
+++ b/arch/sparc/include/asm/vdso.h
@@ -5,6 +5,10 @@
 #ifndef _ASM_SPARC_VDSO_H
 #define _ASM_SPARC_VDSO_H
 
+#define __VDSO_PAGES 4
+
+#ifndef __ASSEMBLER__
+
 struct vdso_image {
 	void *data;
 	unsigned long size;   /* Always a multiple of PAGE_SIZE */
@@ -17,4 +21,6 @@ extern const struct vdso_image vdso_image_64_builtin;
 extern const struct vdso_image vdso_image_32_builtin;
 #endif
 
+#endif /* __ASSEMBLER__ */
+
 #endif /* _ASM_SPARC_VDSO_H */
diff --git a/arch/sparc/include/asm/vdso/vsyscall.h b/arch/sparc/include/asm/vdso/vsyscall.h
index b08e0bd5e309..ff62b291e4eb 100644
--- a/arch/sparc/include/asm/vdso/vsyscall.h
+++ b/arch/sparc/include/asm/vdso/vsyscall.h
@@ -3,6 +3,4 @@
 #ifndef _ASM_SPARC_VDSO_VSYSCALL_H
 #define _ASM_SPARC_VDSO_VSYSCALL_H
 
-#define __VDSO_PAGES 4
-
 #endif /* _ASM_SPARC_VDSO_VSYSCALL_H */
diff --git a/arch/sparc/vdso/vdso-layout.lds.S b/arch/sparc/vdso/vdso-layout.lds.S
index 180e5d0ee071..920396203a2e 100644
--- a/arch/sparc/vdso/vdso-layout.lds.S
+++ b/arch/sparc/vdso/vdso-layout.lds.S
@@ -6,7 +6,7 @@
 
 #include <vdso/datapage.h>
 #include <vdso/page.h>
-#include <asm/vdso/vsyscall.h>
+#include <asm/vdso.h>
 
 SECTIONS
 {

-- 
2.55.0


