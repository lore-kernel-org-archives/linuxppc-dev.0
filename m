Return-Path: <linuxppc-dev+bounces-26475-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13BFCC61DD3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2026 07:53:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbBcz1HZ8z3bkp;
	Thu, 03 Sep 2026 17:51:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788421906;
	cv=none; b=CORTLZeLyF7Wmy4acrjzfWb7pIZfZXF8efeps6H8jgPEvFmj415Uj+kHIXRE9MYnmA5xU1yjApbJ0/RnCXHCEJPDuKqApxbO4Ey0VlYvRnjHLJpvBV2NqoEC8UPXHEUX394j5NYFNVjyjyb+Gu95QoCy+incac7cST0U3nM7yhnPqYDRPGeAAcdj2L8TATPndgKBUZxNk2HkTY5NROzx5iRWWENhOwR0e3PRUVlXLow0bNbEt5EyEjScUHJIFzU2C0xYnMQMz1o809KBab7fbwBuzDfN4Sf5cQPkDHYHb0yKddOHDEV3S6/hDHiUpF/3u5IRiWFqMa4mk2YfDyz8Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788421906; c=relaxed/relaxed;
	bh=6ctVC8jdqr6QFYd4YOzfCl075dK66bWX+194Sx7TuH4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iEeE0aeaV+2l2Qf1YAIxcGSueMBEq0t51d3rn+4BEVAlRH3c0NicW5gYrgnnYl5goJEoAUF72rh+yo6BrDd17+5OXWeoJMRgR0dkNNX+DQaovWM0p55APsY5myIyNsSFfukvODW+cJn0jYjCEeg5yhyTvJ8BvEv+JIS44fDHS+hU1SpN7emnwTsPvcG7Ij8re1cRLWk1Vs1E8WnMPBkA55ex+QAnvitruGEbQrBbLA/OtiK85jGijnVz0byasAVu4l1enonRIvGKgAT0PkyCXNmmtd37WHQeTNMm3mXq2V6R1aEkxr8qGkLsV6VrVSSdJ6DHsspJ6i2YmIeNbH52Ww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=RmnpqQcH; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=MutDSXtV; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=RmnpqQcH;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=MutDSXtV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbBcw1MSdz30dM
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 17:51:43 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788421293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ctVC8jdqr6QFYd4YOzfCl075dK66bWX+194Sx7TuH4=;
	b=RmnpqQcHoiAbhcGu+Ye9voJADRcNlHd7//7UZSZpuweS6/azB8kBGlfXNGpZdw+zJFDhmb
	wVqfd/ReM/yvTEBcp2m8agJJbkA7AncmPKWHrzmhKzuSH1IVXory7WFsKLsmSfU+nfF4Fh
	hxpf6Zo0AWb/8lzdQ/XqwzDTqjMN/ZftsjIshCrqha3MqBXvjPJqrmx40U9dtdNY8urMWx
	+B2P0HKRbsRjXaKsVte8egNJzNOx0RSzNnBwbUTf/deLjmYm4421Lw0Q95xES95qHbtIp7
	OG0nZ4yrrLdrUs28+h/3y0b4ZZnyaG3bYORKfR7uKBROl70iqzLJhbBNyDZQmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788421293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ctVC8jdqr6QFYd4YOzfCl075dK66bWX+194Sx7TuH4=;
	b=MutDSXtVdZvrjMqfAE/yNMGtPAGK3IDThXDBVUv0sCpVzDTmiCqIuYuqvvtvE2gzScp5oD
	8MjD0OPK1RDnqHBQ==
Date: Thu, 03 Sep 2026 09:41:23 +0200
Subject: [PATCH v2 08/15] LoongArch: Remove AT_VECTOR_SIZE_ARCH from UAPI
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
Message-Id: <20260903-at-vector-size-arch-v2-8-5bc32a71e3d8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788421286; l=1767;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=jZmwpcTvA2lKNhTJtgt0mA5Nuuta8CO6fadzS1+09Lc=;
 b=g6xbNGIMHGTFBPIVi/M+7w3xhJb6s8qCkfAEkcXz7LglyUP7ReGfFvVG9ZkdpA32UwGSvrRmY
 cx+niZaAeaKAcK6Qn9T2uEinyA/55qjVdDuG6KFn3ehAIJWX1I+ofN+
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

There is nothing userspace can do with this value. In the kernel is
always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
userspace and also changes from time to time.

Move the symbol to a kernel-internal header.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 arch/loongarch/include/asm/auxvec.h      | 14 ++++++++++++++
 arch/loongarch/include/uapi/asm/auxvec.h |  8 +++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/loongarch/include/asm/auxvec.h b/arch/loongarch/include/asm/auxvec.h
new file mode 100644
index 000000000000..37dd717a3a22
--- /dev/null
+++ b/arch/loongarch/include/asm/auxvec.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Author: Hanlu Li <lihanlu@loongson.cn>
+ *         Huacai Chen <chenhuacai@loongson.cn>
+ *
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+
+#ifndef __ASM_AUXVEC_H
+#define __ASM_AUXVEC_H
+
+#define AT_VECTOR_SIZE_ARCH 1 /* entries in ARCH_DLINFO */
+
+#endif /* __ASM_AUXVEC_H */
diff --git a/arch/loongarch/include/uapi/asm/auxvec.h b/arch/loongarch/include/uapi/asm/auxvec.h
index 922d9e6b5058..79691c422c7e 100644
--- a/arch/loongarch/include/uapi/asm/auxvec.h
+++ b/arch/loongarch/include/uapi/asm/auxvec.h
@@ -6,12 +6,10 @@
  * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
  */
 
-#ifndef __ASM_AUXVEC_H
-#define __ASM_AUXVEC_H
+#ifndef __UAPI_ASM_AUXVEC_H
+#define __UAPI_ASM_AUXVEC_H
 
 /* Location of VDSO image. */
 #define AT_SYSINFO_EHDR		33
 
-#define AT_VECTOR_SIZE_ARCH 1 /* entries in ARCH_DLINFO */
-
-#endif /* __ASM_AUXVEC_H */
+#endif /* __UAPI_ASM_AUXVEC_H */

-- 
2.55.0


