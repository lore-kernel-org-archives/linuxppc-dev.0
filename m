Return-Path: <linuxppc-dev+bounces-26472-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FFBC61DD3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2026 07:52:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbBcw4cj5z30dW;
	Thu, 03 Sep 2026 17:51:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788421904;
	cv=none; b=O0ABLi80jrUySTqOGwmNWd+jA6JE81Nu8u4+KZO95dEu0QcAw4UsyLXmc7BoU5OMCxuQ2nQnURZ8pYjD3CYit7haXV6JfW8Xb0YjfxfGCx8+ZW5S8kIq/NzX+PqFSptNXCXTY270AilEFt9uKL52jVTLNdz8+UpfBVoghc4bQBPi9pkoWItpCZo0voZ71TQLNQYQRQTy8MFRqnxe1TT+bjh7hbntO08at7N4TGa5who+oPC24jpdiauWyXMuwU7weGATm5i7S1SCoWZSnLSci8J6Ubk7vTyfbGqg3PwhEZpnBPmM+aOHWrFg9T1RbSpEmeVqOFta4IxE9vXpJUMFfg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788421904; c=relaxed/relaxed;
	bh=tzk8S7GGq/mqM3W6SmaZkZnDg7V0wPqYFRG/WWfPRl8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gspcm4FtugwVsvMA8M+Bg+oInjZCNq8WSs7pXesZ5aDm3IUnAhwNZrDYg9OXc0Tu5p5B0l+VO9vm7t7f2Xg62VzTL+VkptiRo3yt0b5Ou6V3aXk3TCZL6Uj80eIEx4vPiu3WtjNfyqJV/8lyd8B4hCNJGplvetKklnOxghGbL0v+OCk/5Cc8og1i0AzxZcZ8YsFhaaSy6G3UsEw5zkw2SlEGsp6ntU33Dpa3nplU9YlXziDa7QnPfsTJfDQTuXPGb8vSfau3+j6Z126JPJNn8T7MfoZEJT0S9Am0EQ75jI5xwUDIrzEV+6vY4pWYnuJ4qLL/JqL1FMB//5mzaimfTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=wnd6QEH5; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=3zO6Gdlo; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=wnd6QEH5;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=3zO6Gdlo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbBct2d60z3064
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 17:51:42 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788421288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tzk8S7GGq/mqM3W6SmaZkZnDg7V0wPqYFRG/WWfPRl8=;
	b=wnd6QEH54/BjH3IqL+NmsSLdPMkIm3Ol4UY/fevb8PsoirNu25dRIf9FyoBeO21n7ryuiB
	4q8W5smEU5SP2xUhtsmAPB8t1AyD7BOnfk9PMF61YydeJW57H9S+LagF4bPuQfR4881WRX
	/4oCAgEv/Lb/GUwIYUiN9M5C/Nq2KJrUZLyuYIxmNF/rXmTaHpNExOd8dL/nTrYG1A8nqS
	1IJmvplNWiUa6b0Q2weqH1mz/Kn4SalyfB2YijMQ8/Vpp2jtuXuQxHZdB3BjakEgFTGG1+
	IzqqSnX5CGvvZly/aH0pQFeEH4/dWYMPZ/63MP3uHm5VaD0VlSxBYQTUsX1SgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788421288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tzk8S7GGq/mqM3W6SmaZkZnDg7V0wPqYFRG/WWfPRl8=;
	b=3zO6GdloI0RIRQIUARPzBVJ6Z2WmANTijL9R9i7Ce0cPzMjNreKcy1VLDJ/BIWuW6HH1xn
	nh/lWOAWzbhNpfDQ==
Date: Thu, 03 Sep 2026 09:41:17 +0200
Subject: [PATCH v2 02/15] auxvec.h: Move AT_VECTOR_SIZE definitions to
 linux/auxvec.h
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
Message-Id: <20260903-at-vector-size-arch-v2-2-5bc32a71e3d8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788421286; l=1309;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=HWrppGtlxN68+J1EvLurdbOmIVycSJ5y0ost40gYay0=;
 b=QtuUd8ndQfte3MxNSIPeA1ceK7WkBDpTjXLL5fb4pzWRDNSz/qxqD4exzasiSFQC/0O6qJggd
 TikOW26FC/0DEludcoZTMbhvBJm/noFxtE6Oqd7XYz5ZG5OybqRL4sw
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The auxvec.h header is a more fitting place for these definitions.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 include/linux/auxvec.h   | 7 +++++++
 include/linux/mm_types.h | 6 ------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/auxvec.h b/include/linux/auxvec.h
index 8bcb9b726262..4b364e639f08 100644
--- a/include/linux/auxvec.h
+++ b/include/linux/auxvec.h
@@ -6,4 +6,11 @@
 
 #define AT_VECTOR_SIZE_BASE 24 /* NEW_AUX_ENT entries in auxiliary table */
   /* number of "#define AT_.*" above, minus {AT_NULL, AT_IGNORE, AT_NOTELF} */
+
+#ifndef AT_VECTOR_SIZE_ARCH
+#define AT_VECTOR_SIZE_ARCH 0
+#endif
+
+#define AT_VECTOR_SIZE (2*(AT_VECTOR_SIZE_ARCH + AT_VECTOR_SIZE_BASE + 1))
+
 #endif /* _LINUX_AUXVEC_H */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6d815f6440c9..08a06b26375b 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -26,12 +26,6 @@
 
 #include <asm/mmu.h>
 
-#ifndef AT_VECTOR_SIZE_ARCH
-#define AT_VECTOR_SIZE_ARCH 0
-#endif
-#define AT_VECTOR_SIZE (2*(AT_VECTOR_SIZE_ARCH + AT_VECTOR_SIZE_BASE + 1))
-
-
 struct address_space;
 struct futex_private_hash;
 struct mem_cgroup;

-- 
2.55.0


