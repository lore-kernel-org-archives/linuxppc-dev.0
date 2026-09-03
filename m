Return-Path: <linuxppc-dev+bounces-26465-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6A8C624D4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2026 07:51:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbBcq2Nljz2yvR;
	Thu, 03 Sep 2026 17:51:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788421899;
	cv=none; b=GD1umJDVx6/A+xP4u59mxEBua48A91Jvoe8kXDe7agmhhjLJJAs6IoxpDtnFQx93wlfOu/TX6F90ozVD0J1NlIx9oTY2Hc4mGoaVVPSHrpa/z1ksrtZS8rX9AYGLZtxdyRIg5DDOlx7mGEUv2OAshorvaaIfeJMpcavK6iWpDOxfjG7iVc9oy2PKT1GY0jdo9gs/N0hOy9m5wtcAhVXtcAeBZOGJrg6LHr7yBWE1pAWeAn+G/JM4ppWqlnwzjDYXm7f0HqNhqE0mXBCBadz3VL02sXJTaL6lDuWeZKxRzpuDgr2Q8PzK5jGwrLgYoxcOx933v8ISuQIM3M0JsWqM9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788421899; c=relaxed/relaxed;
	bh=acT7QjZNdUmpfnBE9uBNeofdPEPn+BimCrNJZCbn/To=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KeB6pANpLH9PXa+erB/to9cVtoGiy3Rn09KraRdJwpKkkc0CuxmYpYmWKIU6+pnrjdk66rhkwSuoiYRoTUOPYZhHwoYsZwUoqCPZs+NX6zYE+bie5FPudQCiCr6nLbDbG1ALqjZ3I8wZzI8QRySX9/pqh2DUkT0U3fH1d6LgrZ7KXhz+GX3EppJ12+NaW/qA4TtAf1XCVoaSyAcaVhqbfyJlJ3sNygjaNs0ozlnDxNs4K3QvmDCvQlIxD9GTzpvxVB/+0K+ZKGjuSNh2XReK6TRQi52a2GR1TUw+uASHg/al+eYaa6WikGBnXQmQYtqY+Y9h7SaTZDRr4TqkaO4giQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=3jP4Qdtf; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=s2g2u1zE; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=3jP4Qdtf;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=s2g2u1zE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 603 seconds by postgrey-1.37 at boromir; Thu, 03 Sep 2026 17:51:36 AEST
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbBcm0Ytqz2yrD
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 17:51:35 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788421297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=acT7QjZNdUmpfnBE9uBNeofdPEPn+BimCrNJZCbn/To=;
	b=3jP4QdtfvdGKafZk4gV8HAs0JKCcq1g5wS/L1M3Qb1c7h/bp22yYQ4TGtOpk0Mr1S/c40K
	vezg61PPYZqPkMIMi0P+MeWnhIYlWcTdnwH+SRrFrQj+nHm3Q7XiGS+vPJ4prnY7NtnqS4
	Xcm7eDuut8ABcFWFXYthMXqf5wGy9Ccz9usV3DQF9udUqTs+ZSL1h0G/e/uPiHShZ/Ewxu
	mmqEjU6o4o8g1buldyiSf74wUiAqSpfnewCZQA6Jv6yvahNkaYBKs1k4bYgN+RF3gqYYZY
	9mJxAv66dqtq8g2IiUO/pUOHIbenwPQiYRyIjphamnJW3UILkPOqYRUhshZy9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788421297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=acT7QjZNdUmpfnBE9uBNeofdPEPn+BimCrNJZCbn/To=;
	b=s2g2u1zE4MoDzQePYnFomJgqRmXe5nRTN2VoD8bDtfLrzofrwt3d1WEshMMUnT7M9XzlRA
	0xw/D3K/rl1yL3Bw==
Date: Thu, 03 Sep 2026 09:41:28 +0200
Subject: [PATCH v2 13/15] sh: Remove AT_VECTOR_SIZE_ARCH from UAPI
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
Message-Id: <20260903-at-vector-size-arch-v2-13-5bc32a71e3d8@linutronix.de>
References: <20260903-at-vector-size-arch-v2-0-5bc32a71e3d8@linutronix.de>
In-Reply-To: <20260903-at-vector-size-arch-v2-0-5bc32a71e3d8@linutronix.de>
To: Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
 linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-alpha@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788421286; l=1608;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=YKN2r1KwV0S2heb/8Y+Jhhyff24Np1SwL0Bw1UDwB4U=;
 b=useSqq1PQgc5jzt7dwdzir5U98FAJIkoH55nFNQGYdoiuFZAdgXYdssF8gR1E00nS8bRYsyyN
 V4+Vyu8LX0EAHidn3hUqdF1MdUf5WBlzeDxA5S/zQiX92l2UKGbW/Vx
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

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
2.55.0


