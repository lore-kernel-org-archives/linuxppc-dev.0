Return-Path: <linuxppc-dev+bounces-26466-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C081C624A4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2026 07:51:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbBcq4tHgz2yvh;
	Thu, 03 Sep 2026 17:51:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788421899;
	cv=none; b=Vebx/NLrrm24EDZnaoiwUxaE5Thm1S7SLdA7TyjrvU27XP+zsQUx0T9EBBY92J0wGUnVWkmMv76vCCBRY4uT1mNDguRcYkAdFCjZ5ZlHXqTqkGJ1zpbZk7WPuZo83L+W3P/kwJ/60IF4Km0FaXCO5l6DNYAf4Zj7S2FLUIzVuaYj8gFb8VaaUyUewuUZK0AmLAJCz/SNuFGD69UNLeMS10hcLoJk8YtaAl+aB4L/gg2CrDzUCup2ODJzgJGGPqcltAjbwF2sXdsHKICjWIZ8kY+qltjBI00N07IsM4ESycorA1zONGfsmWVLJV8YDVtRJYZ/Ml/NXQd9C5k0amTVVw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788421899; c=relaxed/relaxed;
	bh=YsqBa4DYT6UOJOiQLZcJsY0z2uNBnuWhMaLFwrPj+rM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lfvIi+xeIw4t1Mfi+PNtEjH3FP/7AZwe7CfD0IGmjwD4vgElLDYAl/C7/C5mjz3X65JULuKYM/rJmgxUauBPYYQkIC+9g6oPbZXqm+egD0+MDNmtPOdtkNC04XiE5DgTAnYaheWWZRbz8SSfNYoVc57N5kwaGUpQj2lG/3v9zkRppMKUDTqfa8WfryhRhgShrhjsFJs0v+L2ln1Cym/jfj20CwfAAbo8pNpup9M5FNLgbw/H1AA3taymuJxKe5pmmeWrYkeZ5A6Z6zWJ0dZ9D0J5TraX7hqHEFjZi4aoikZZZCihlmkhzYmcOq8TNVYbltjghH7kgX45va8zeM3+fw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=zh5925hV; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=p+sdR1ZO; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=zh5925hV;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=p+sdR1ZO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbBcm0mWqz2yrS
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 17:51:35 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788421295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YsqBa4DYT6UOJOiQLZcJsY0z2uNBnuWhMaLFwrPj+rM=;
	b=zh5925hVYaFB8ZqXkqngvUmrw9+a6ujcjssEZbyneFYSTtX2htRdyVd+bPbvOpRgBkbHKS
	UyYRl8bVC/aCmhDACl6PUsAGjL6qD6UrgJ6fMtX0XrK73AXH+bTIM0RQh9RqQBqTE7PfWd
	sy46BX+9UVIXQQ8gXYqvn4EW9yJvpFkVlqSZcEgQdubafxa5Ht10HI2PyF6YkErVIB8+Pz
	tTtz7udMuul61G9wZ8BcAdTTwiUXTNFB24x65Fdz0iHU4ieKAxzzI8OryCDb0/Sujiis8f
	xSWrzR7JgVoAUIc97d1Z76rvV+zJZLsOMPXpSeI9zqAUC1bi8nMdiAkqTFv3cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788421295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YsqBa4DYT6UOJOiQLZcJsY0z2uNBnuWhMaLFwrPj+rM=;
	b=p+sdR1ZOWyxm4iWpsvHvJ/zT475he8+gLNu/e+0exOHrUUoHvzRjT1tFhSKbw+QZymljTy
	5ABuxLobpVaHXeDQ==
Date: Thu, 03 Sep 2026 09:41:26 +0200
Subject: [PATCH v2 11/15] MIPS: Remove AT_VECTOR_SIZE_ARCH from UAPI
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
Message-Id: <20260903-at-vector-size-arch-v2-11-5bc32a71e3d8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788421286; l=1884;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=cs0IiOQ51smsz0pVBiUdFi4gN8rZXBN55vGK/+lYj0w=;
 b=fgMzeADRsHBHDhQ0aBCRMVdgaCDOyOHavpx7wa8hChxiqtcHW4YZOAtPgh6azTmpGG9KLODsH
 xiGj8+MIrP/CxqeNABlDpjpPVwhKierLeYQje+RQU0pz9pb8sg6KNDG
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

There is nothing userspace can do with this value. In the kernel is
always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
userspace and also changes from time to time.

Move the symbol to a kernel-internal header.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 arch/mips/include/asm/auxvec.h      | 17 +++++++++++++++++
 arch/mips/include/uapi/asm/auxvec.h |  8 +++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/auxvec.h b/arch/mips/include/asm/auxvec.h
new file mode 100644
index 000000000000..76c445e7890f
--- /dev/null
+++ b/arch/mips/include/asm/auxvec.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2015 Imagination Technologies
+ * Author: Alex Smith <alex.smith@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __ASM_AUXVEC_H
+#define __ASM_AUXVEC_H
+
+#define AT_VECTOR_SIZE_ARCH 1 /* entries in ARCH_DLINFO */
+
+#endif /* __ASM_AUXVEC_H */
diff --git a/arch/mips/include/uapi/asm/auxvec.h b/arch/mips/include/uapi/asm/auxvec.h
index 612c2c41f60b..1331ac4d935e 100644
--- a/arch/mips/include/uapi/asm/auxvec.h
+++ b/arch/mips/include/uapi/asm/auxvec.h
@@ -9,12 +9,10 @@
  * option) any later version.
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


