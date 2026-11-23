Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8172D606A31A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 09:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=TyvVEjET;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=UeyrNx36
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jY1MK5SHmz308H;
	Mon, 23 Nov 2026 20:47:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795427261;
	cv=none; b=LoWHEIIkbNMAU1H4i1I4ocJstlGb4uFu/WLCjeR2l/p9QEqd7tL1CnL7Pl+VDcTCauYGGfu2OzX7yVIUyquBos2ZqsocR/h3S6mSxyeQi1ygttpM1geBd6j8iRRMXGJp7qAXzohBWCpoz8wv2CUym1cQA/08qxDrMrkf9Kneh0kqCXpmy88dlUOgNBZ43t0dc2R04jl/646U+p/2cijTX4lREiY09y1hIqXJk29xD9TYFzNTbszVbGjjYVO+N3qVx7gRcjN3T0RsSlBXZke77TAejA2a8VizjLGzpXWmDaNnyb3HPzake3sBReNvjVY5Kl9nZcAS7t2nkSceEOFwwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795427261; c=relaxed/relaxed;
	bh=Dp9YyKBWCSEjb6xrb6VMG09P6jqIzXjTgw7J5S2fTA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VPEftukqrsqxQavaIMsnlfD7LySqwR1mS29flv6AJBQqSYtmSwDBo7TIY32aVLvotbuijvKKatS2z0OdSFKRIkv2+gYTODo1I24pG8TJcKv4CUbn6iwNTQ3kHGBDlJTpOiwRmnVRvTM2wj8O55457aKs4AuMJvMA+IT1fd0fiU7Vlng4Gxn1PZGbtO+Ra4L7AFSFuruKifbc6SrtT9CAG92rJxjtoIf8EbokKbbswl8mCMnTibTsx7ZGIgbcFQiVW8ypf0Sn9O1/7p1wJO+a6AR7EnWegS2S9sBji1vieyhRxLwgpPlt6Z1Dpke4VloljuOK27nk8jhIvcA4yzIIww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=TyvVEjET; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=UeyrNx36; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=TyvVEjET;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=UeyrNx36;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jY1MH1j24z2y89
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 20:47:38 +1100 (AEDT)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795426655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dp9YyKBWCSEjb6xrb6VMG09P6jqIzXjTgw7J5S2fTA4=;
	b=TyvVEjET6MQnliSzrqpnj+WkaFtU1zdWalGJrq4lM+AG+q+GryJ6uLyXM3uuKuMjPwI8Q7
	hXW9l92VNUnHMqFEWfhzIP/+ank7W2QypcCihnx37IfZQBhZP3LFb7GNb+YNj3CHfGSbs5
	ZhZR+iPlg/bcytywj2VDrgqzMWW1DBlh2cJuaI/J0WVIFHmyAwJi5zM/82k6QefOlFt1dz
	tg0ik+MAZFWoUZhTqe87bhvHbNeg3maMBV/cDtE0aW/fZiImJGJWeAXysA5to544DrSSxJ
	G84S2kJq5OpbCqnzmKWFT3UfGcp35UD7EOdsH8gcGg1UZbcf7aAajTe5p6hbsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795426655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dp9YyKBWCSEjb6xrb6VMG09P6jqIzXjTgw7J5S2fTA4=;
	b=UeyrNx36ELx+2TKAHU7bC/JsVRcYrQLbDiG5FMpmWcJSPNqa84GS7ohHzM60dWu8RXOreK
	Iht1lJnEMVjGIzAg==
Date: Mon, 23 Nov 2026 10:37:18 +0100
Subject: [PATCH v3 13/15] sh: Remove AT_VECTOR_SIZE_ARCH from UAPI
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261123-at-vector-size-arch-v3-13-d342dae9e843@linutronix.de>
References: <20261123-at-vector-size-arch-v3-0-d342dae9e843@linutronix.de>
In-Reply-To: <20261123-at-vector-size-arch-v3-0-d342dae9e843@linutronix.de>
To: Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
 linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-alpha@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795426640; l=1608;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=ztfIXLUSH0CwIJyGBvoNgGeeiOG70QOYQ4pFqwwxIFQ=;
 b=LKBQXJ0mP2V6uYDx8P6XIyIzFshAJA1+7kRDjBNYWfzYxsdonu5uj4s7DWGYZrkTi/6jZXHLX
 /DLzlefFrAKCVL70qHWqHj3o6sDBv0xorI5veF399VQjaRzOqml8CsX
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

There is nothing userspace can do with this value. In the kernel is
always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
userspace and also changes from time to time.

Move the symbol to a kernel-internal header.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 arch/sh/include/asm/auxvec.h      | 7 +++++++
 arch/sh/include/uapi/asm/auxvec.h | 8 +++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/sh/include/asm/auxvec.h b/arch/sh/include/asm/auxvec.h
new file mode 100644
index 000000000000..f0830808eb19
--- /dev/null
+++ b/arch/sh/include/asm/auxvec.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_SH_AUXVEC_H
+#define __ASM_SH_AUXVEC_H
+
+#define AT_VECTOR_SIZE_ARCH 5 /* entries in ARCH_DLINFO */
+
+#endif /* __ASM_SH_AUXVEC_H */
diff --git a/arch/sh/include/uapi/asm/auxvec.h b/arch/sh/include/uapi/asm/auxvec.h
index 63fcc39e2c6a..cf0f13da977a 100644
--- a/arch/sh/include/uapi/asm/auxvec.h
+++ b/arch/sh/include/uapi/asm/auxvec.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __ASM_SH_AUXVEC_H
-#define __ASM_SH_AUXVEC_H
+#ifndef __UAPI_ASM_SH_AUXVEC_H
+#define __UAPI_ASM_SH_AUXVEC_H
 
 /*
  * Architecture-neutral AT_ values in 0-17, leave some room
@@ -30,6 +30,4 @@
 #define AT_L1D_CACHESHAPE	35
 #define AT_L2_CACHESHAPE	36
 
-#define AT_VECTOR_SIZE_ARCH 5 /* entries in ARCH_DLINFO */
-
-#endif /* __ASM_SH_AUXVEC_H */
+#endif /* __UAPI_ASM_SH_AUXVEC_H */

-- 
2.56.1


