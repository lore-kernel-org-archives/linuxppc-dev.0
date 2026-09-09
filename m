Return-Path: <linuxppc-dev+bounces-26889-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57DF6C79F8C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 08:51:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfvg53708z2yqT;
	Wed, 09 Sep 2026 18:51:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788943889;
	cv=none; b=GAnIH714tmvmjDPBMhZ17+uola9oH8PfbAUuTwCTOVSLZX3QoZm9GdfLYF/OTJES89/mbC/kkqG44s16/iITcImspKKSwLwS0+xxCCf3AQkneb6h4nK4dAr+Hw8ivr9cIhH2qUIZ9o+qtjt8+jnEq+nrj5JlGM+iNx1G1L4MilcMolf/VANX4FiLtxBUeL5TPLNboYVgm3iCpAh/SH9mA50QVQwZGq0neHev0E+DXf6KPPiMdh5uAFX+PaSv+bQ/EMtsD3brTA9PaBp9uTM+lPkefGioILIk6WJtrWMSBNdjLsHT45wbSJDPDmS3M+rMa+gQz3nEulscKK8DuljXng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788943889; c=relaxed/relaxed;
	bh=csWZa+FXPkZtKlamZnzOe5wDFOkHxV9+VSViUYlt1Zs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KNEFw5rapTd5ir8Tzuyt+SokV53OtkgrsT/DSANlRxofLDyh1jQTzg63frr3d/zQx9k5uPcv0P5e/Oaz1OFZnjgCx77WPqP7eTKQrhMNUq8DmMh//REluDIYMfG1glGiTf5RcmUbEdYHnKP9JzXIS+zvQsvjPhc4U5BKuWMlyL9ydLekkbSeorQ/OmcuS5tA9nGzU8fwBJQjnCMviXY88NXx8hfqDGa6Bs6dR+GT0ToMux1/y6Rv5M+Q6kP3N54H3pbtp3Kt+4uMGhe8glUOq0CsWox4cqtgenu5ISXzlwbeuikDc/2BJQ25X2nUd0xOocJUSJYVLvajcbvz2ywGcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=zLyb9Fwu; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=N/A0UM8L; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=zLyb9Fwu;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=N/A0UM8L;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfvg36Qbdz2ypw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 18:51:27 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788943882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=csWZa+FXPkZtKlamZnzOe5wDFOkHxV9+VSViUYlt1Zs=;
	b=zLyb9Fwu7jbI0CwCPLxrGbMAjONAtXhsvd2aOXrsZeTIM+Vd6cAkXeT/9cSCtBgc6rUvND
	gGL505R+4si2jE3aeqnbSbLIG8k98l5iRxrDYXFAKQOWMVSkZxKFlP21c6TSMA2i/iy116
	/ylwRK8HcPiR9PgT8J7h2y8C76UQ6h/hhfKtVfvGj6xJZzmOon5VHgnFpIj7kux2X934+R
	88gvKVckykd4QMY7I4EvAl22PfX5GKMA8NcVnV99WfoKqT9h3DM3L6nfOz4IF1LXAzPclD
	t74OiDujJWbszZsh0qrw62upWw14+r6iyZ4jcroh7b+1fqc9tncGYHc7XAbHiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788943882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=csWZa+FXPkZtKlamZnzOe5wDFOkHxV9+VSViUYlt1Zs=;
	b=N/A0UM8L3DUA6/r4Ux30sANcZeIqXCYs4ZXEjCKOONRgT4pANRJ15Uu4BotsUrawfjPr6e
	4wH9FEacXhaQoNBg==
Date: Wed, 09 Sep 2026 10:51:16 +0200
Subject: [PATCH 03/15] vdso/getrandom: Define fallback
 __arch_get_vdso_u_rng_data() in getrandom.c
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
Message-Id: <20260909-vdso-asm-generic-vsyscall-h-v1-3-63ae856cc659@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788943875; l=1595;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Inx1GMMAL9hTofIIG5CeNr2zKHZu0vdSWjUErNB5P+Q=;
 b=S5UXcl0xftPFhFxyzIYGTlv2hiN5xVRt8TcojCGkIIJlfpcJoQYHo8t1Vw1w+qVFkJDkfU+DX
 KiIc9K+4lvbCboRLbKhU8xLm4rTxtAlsgsM1YN6LzOWh2SHeS6QsfsX
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

__arch_get_vdso_u_rng_data() is only used in getrandom.c. vsyscall.h
has become a dumping ground for different kinds of fallbacks.

Move the fallback function definition into getrandom.c,
similar to other fallbacks.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/asm-generic/vdso/vsyscall.h | 7 -------
 lib/vdso/getrandom.c                | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/vdso/vsyscall.h b/include/asm-generic/vdso/vsyscall.h
index fe12fb1fb442..cdf7b39cd349 100644
--- a/include/asm-generic/vdso/vsyscall.h
+++ b/include/asm-generic/vdso/vsyscall.h
@@ -4,13 +4,6 @@
 
 #ifndef __ASSEMBLER__
 
-#ifndef __arch_get_vdso_u_rng_data
-static __always_inline const struct vdso_rng_data *__arch_get_vdso_u_rng_data(void)
-{
-	return &vdso_u_rng_data;
-}
-#endif
-
 #ifndef __arch_update_vdso_clock
 static __always_inline void __arch_update_vdso_clock(struct vdso_clock *vc)
 {
diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
index 2851afa9154f..6ff46549281c 100644
--- a/lib/vdso/getrandom.c
+++ b/lib/vdso/getrandom.c
@@ -19,6 +19,13 @@
 /* Bring in default accessors */
 #include <vdso/vsyscall.h>
 
+#ifndef __arch_get_vdso_u_rng_data
+static __always_inline const struct vdso_rng_data *__arch_get_vdso_u_rng_data(void)
+{
+	return &vdso_u_rng_data;
+}
+#endif
+
 #define MEMCPY_AND_ZERO_SRC(type, dst, src, len) do {				\
 	while (len >= sizeof(type)) {						\
 		__put_unaligned_t(type, __get_unaligned_t(type, src), dst);	\

-- 
2.55.0


