Return-Path: <linuxppc-dev+bounces-17528-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096D1E9B36A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Mar 2026 12:27:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPdSn314mz3cNt;
	Mon, 02 Mar 2026 23:26:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772454361;
	cv=none; b=CymLAfDdrwwjFNX11dDZMrvmbsH8jN9VLiycbaUubk2zfMYE6xYuTx5/OqxJWyx3zzS4LRrNXhtFY9Del82vTdITE/qruH75CSIjVtydCko1tMufMQDHGQvpHs8iv3TksaxFhJgT8iRSUWHIxCsC0b7TF8XP81q2oOqTzBaXxKKDzct01wmS2z8BoZwZ44oupZMV5paTFX2AI986BFOGHWK5LSqhCDbMT9PlIwvE15crtMAXMmO2XVgjEkP+Jmz3WYibXiEAKRh6Oy+rAlzK/dNdUIZ3OIAU2L1JHdeAZSLcot58kCmQeJZiy50MraxNulHjNUiMYVhkS61bvH64MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772454361; c=relaxed/relaxed;
	bh=rUatCUMGjSOAYdWwYL9kAf5S0UMPuz+Fx84eRD4pGU4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bL2/NSD+G74sqwXa10iLyUsvEfkfwpqMz/CJkFauc35KC1omw3lYPqllgV7X793EQqqBNUzCC84bJBhFSLNa7iKxLJIZcQmqVXbz3JIaMCUczS/cOhYoG3nWtCvbCOKnAiphRgfvzMFqE5LlQHUKwvk2AlWGJLmpJw15ZtXuKMWu5/0g62XkIDk9pGKAufgxSIXGU1zS7S4TTEWFgQOKmVB2gJ1ErUg0OEXQ3jR82/9Jfr+3wJZe60UgApwSIGR9xb6Zs/M37xQxnzwIb2EdLbSVD01SIULut86gwIlG80s01LFK/IzQTz72id+hE4YM+uidsCfNb6319gWlki6xDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=MW1bGCsS; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Glqb/iX5; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=MW1bGCsS;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Glqb/iX5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPdSl1JMZz3cLr
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Mar 2026 23:25:58 +1100 (AEDT)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772454352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rUatCUMGjSOAYdWwYL9kAf5S0UMPuz+Fx84eRD4pGU4=;
	b=MW1bGCsS9DfO9X+v0DSKadvLFn+SWmk1pn+rddicrRlb+25XuZl0eJt6iP0G+BXg34cvQ+
	1Ypq8dU9/4H9JLtsbNLwN5Op4E1bl+T4qCK3Q+t4+bjDkmJqqKq1cZulRp0Q5bjxyuTa47
	wiRCfLK8Jy/Zk+I2mf8sQaKTwx9mwTzg39fMPaeuYCeMY1g5BgCHN7iPogP3geq0eUFj3Z
	1espng2OIo24NrTFZzZJjZfVEZhat3bTP91FgzcChTJq/X8HDD3/SOOdkrO038gUGid1NP
	/TG9xAya313yScFDighxypdFYvV3s2al8OVDGX6NMfe71/7TtA36WV+yKWJIog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772454352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rUatCUMGjSOAYdWwYL9kAf5S0UMPuz+Fx84eRD4pGU4=;
	b=Glqb/iX58ImwLmydqxjJwzbHZqXKn5FJ/rKO/+KdO7fpIDILYZKeypk8G9y+WgL/AIWKQi
	8ZSn2D4OHrttUMCg==
Date: Mon, 02 Mar 2026 13:25:38 +0100
Subject: [PATCH 14/15] alpha: remove AT_VECTOR_SIZE_ARCH from UAPI
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
Message-Id: <20260302-at-vector-size-arch-v1-14-a11f03ba2ca8@linutronix.de>
References: <20260302-at-vector-size-arch-v1-0-a11f03ba2ca8@linutronix.de>
In-Reply-To: <20260302-at-vector-size-arch-v1-0-a11f03ba2ca8@linutronix.de>
To: Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
 linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-alpha@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772454343; l=1621;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=1k5fCTPjgHXmT1wIddDgmvVMNFYPCfoGbNYiBvOaniE=;
 b=+emcoOjpmCtOGbRKRilDXun4wh9rZo8IxjTkm9zYNPepV3X+fcHLumuZs3KaZBdDmhAbmZz3X
 Sar6SiZRFKiDIiijEXUFkxsbjuuwCItZ6i5gyRlwHoXVec8Fv7oUaT2
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

There is nothing userspace can do with this value. In the kernel is
always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
userspace and also changes from time to time.

Move the symbol to a kernel-internal header.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/alpha/include/asm/auxvec.h      | 7 +++++++
 arch/alpha/include/uapi/asm/auxvec.h | 8 +++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/alpha/include/asm/auxvec.h b/arch/alpha/include/asm/auxvec.h
new file mode 100644
index 000000000000..fa90ee4f899c
--- /dev/null
+++ b/arch/alpha/include/asm/auxvec.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_ALPHA_AUXVEC_H
+#define __ASM_ALPHA_AUXVEC_H
+
+#define AT_VECTOR_SIZE_ARCH 4 /* entries in ARCH_DLINFO */
+
+#endif /* __ASM_ALPHA_AUXVEC_H */
diff --git a/arch/alpha/include/uapi/asm/auxvec.h b/arch/alpha/include/uapi/asm/auxvec.h
index 57cae8780d81..d21b87b6730a 100644
--- a/arch/alpha/include/uapi/asm/auxvec.h
+++ b/arch/alpha/include/uapi/asm/auxvec.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __ASM_ALPHA_AUXVEC_H
-#define __ASM_ALPHA_AUXVEC_H
+#ifndef __UAPI_ASM_ALPHA_AUXVEC_H
+#define __UAPI_ASM_ALPHA_AUXVEC_H
 
 /* Reserve these numbers for any future use of a VDSO.  */
 #if 0
@@ -22,6 +22,4 @@
 #define AT_L2_CACHESHAPE	36
 #define AT_L3_CACHESHAPE	37
 
-#define AT_VECTOR_SIZE_ARCH 4 /* entries in ARCH_DLINFO */
-
-#endif /* __ASM_ALPHA_AUXVEC_H */
+#endif /* __UAPI_ASM_ALPHA_AUXVEC_H */

-- 
2.53.0


