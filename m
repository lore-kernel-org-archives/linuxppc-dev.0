Return-Path: <linuxppc-dev+bounces-26469-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E7A8C61DD3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2026 07:52:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbBct33Wzz306N;
	Thu, 03 Sep 2026 17:51:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788421902;
	cv=none; b=CAB+xmUvXSuv8IRRHfa6jWgQ+Smg0gaSCFgyrhB5ADYKRpuL0tK6rpdBxojP/YYQWS0VVvLdfjrS1ahWqHQLSznBnIURwZ73uvvIqEEb9Pi5CAEFf+3OMaRTIj/ik1810U3zHNl9VF+18DqZpGuUpjtJzj0PlSx/rTyIjCcNJwq4WG68M7LAx6qO2O+vHZOCx1AWvlodRO48t69Havju7RerSpVcRhRzW4Wn3ggGP2Q5qAD4VtqnKDODzZxYE27a5yXdiEluqcxrYZ5+ZOV/ngn03zTOUB15Ldar8//HSW57GGDfsuJqFtWyK/5Kn9/qer9V7qP6rPaupm6NxmyRsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788421902; c=relaxed/relaxed;
	bh=+rrF5e3YgB+atcHD5Gfa4JDkXTz+7YXoVXv9oxsgM/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GlcPi9Q07BcUEEz5RWY3GgQ6+6IuX4yfE2cu5dQ+mrY0++NsTv92gu7FP9Jl+gzok4PnNIS6v1sOiuyGnvxlG0/zO2//p3JjugNehrHT+mZK2iv9X2tOja/wXXiM9KJjoT6K2FlnbQ8pzxMA5VfMohZgvyVI0HlHLoRBvfbh4qBr5S7AUgXHe7OZ0+VQMKwvN6wa8IJHJp22iPRDdC+bsl2P6bc+kRNYVKyF0Me8Twk4Nlj3AhHHR90CqubM9ZXlqOmtLBWtyYcjW8r1BfDGCk6hDiwJz92CiGsGSLauxb6KbmCiRy8W0eaEX6CDg4tepKbbboFDWHV4jrofROE5uw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=XvaTjzYV; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=uYmG0xv0; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=XvaTjzYV;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=uYmG0xv0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbBcs06Wvz303K
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 17:51:41 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788421297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+rrF5e3YgB+atcHD5Gfa4JDkXTz+7YXoVXv9oxsgM/c=;
	b=XvaTjzYVh0HucbGPiPARvWRn6wVYgsx+Csp2bfua/QOqfVCXtGr02dq9QV/NIgKdrmQttN
	FruSzRbjGV2ltb8/SOj7JTLix/fJZVbI+j5Ihb3ZDpTm9XgO+CVNAi1KGHNu8modprd4sx
	vkfb4UP1bfOYEiO25nbrMDeHeIFboyfqD/hgadHhg6C9qPWzibZS6r8QLE9hRF1PQ//5se
	ouoFxnd7ZLe4sa78VjkPB4220N3XCrJT5IaQiUF3lV/yfjq+0w2UO+nVMsmD0xDcfEP6cw
	d8JWdATeYQ0teA0PFMluj9KnXp8rrJpvWvmGfu+qMoJuGF9YZd9f/btvsvTkJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788421297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+rrF5e3YgB+atcHD5Gfa4JDkXTz+7YXoVXv9oxsgM/c=;
	b=uYmG0xv0qojWcb+hNeKMxC7/rqCyITMqfBa/1k5/2s66l8mXzXZhdsVPFBCJGgk8R1nWYV
	/D031BwFTFBTL0Bg==
Date: Thu, 03 Sep 2026 09:41:29 +0200
Subject: [PATCH v2 14/15] alpha: remove AT_VECTOR_SIZE_ARCH from UAPI
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
Message-Id: <20260903-at-vector-size-arch-v2-14-5bc32a71e3d8@linutronix.de>
References: <20260903-at-vector-size-arch-v2-0-5bc32a71e3d8@linutronix.de>
In-Reply-To: <20260903-at-vector-size-arch-v2-0-5bc32a71e3d8@linutronix.de>
To: Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
 linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-alpha@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Magnus Lindholm <linmag7@gmail.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788421286; l=1710;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=mT6IunlNmVAACIv/qOnfprsS76yyb9kAy/7Jf1UY23I=;
 b=yYjljrbgHd9g0YvBGpHX18OgBAHjsDzVbGwiInZAXSnDdTlr6s+0cRT5wpLbzZrAcLw7t0bCW
 UZTIpaJMtZoDO1+CQ6vAol3PKC5JWA+jRIyABLT06nkmg8XMLKxb5lc
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

There is nothing userspace can do with this value. In the kernel is
always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
userspace and also changes from time to time.

Move the symbol to a kernel-internal header.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Magnus Lindholm <linmag7@gmail.com>
Reviewed-by: Kees Cook <kees@kernel.org>
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
2.55.0


