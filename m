Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C62606A31A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 09:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=zs2rFukl;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=PrBaN3N0
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jY1MM641Fz2y8F;
	Mon, 23 Nov 2026 20:47:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795427263;
	cv=none; b=Xj6v4OUSwkWoHha7x8eeufbgRCzAM46jouEtGo/s5dd86uoWST+dao5Os4DP1l2DCHeO/03FsSgsMvmwOkLTlqDItKpkdKBBSjOXhTjnzprSLRVy8IXTXA4D6Lf+c1dIX5dCEdLZoH+Esm7KRzMuyJHDhaLbP/+x8BQsXZvO/7yk6B9hefjSkppRvf54IVanlcGtpvzblek8tB6mr+sPXT98oY3MP+gB8W7jO5swOdZcY+F3gHuuA/tWGuKKQ78KfD8/r9xAY5pl72MAbAVZ+iaWZrQzpL1vdz5DG34uMwSL7oJbZaGjaQw1hW16gj1apYSwdzbWA4cvL1LALUbM3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795427263; c=relaxed/relaxed;
	bh=8XqI/ovDzkmrLY2+2cJN8n7p6UWRDilYHLPeAY+Yquw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jx6PeuNXr4Y7dJbsHg4V6qelcMo26Yt21JbtGR2u3s/0MvEz3AFqqS4T13nkDMi/Mo5hsdpTHXNAI1YqE38X5UDsV/bNF/ZivQU1hZBIMyf0hgC2w4UE7pWFgtJCwMg9s/qB0vlwkad//ISGTlUT0y1TgvddOg1QCHIvgUf8BufDY7EW/ibMObTWLV96jsMVhKBuycCs4xxbo7icekjKn/f7LdkZX4NQqgblN+YvNwO8Cr714wqyVnPlA6/vb9joUHhb0pEg1s43UyYu7Z/46r9hTlfPz1c3D1yULH6ClWa6GOT5xOQUhGXwm3tDGmzN/dR3geRRlLZev5w1SXGOyg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=zs2rFukl; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=PrBaN3N0; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=zs2rFukl;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=PrBaN3N0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jY1ML3dMHz3bWX
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 20:47:42 +1100 (AEDT)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795426648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8XqI/ovDzkmrLY2+2cJN8n7p6UWRDilYHLPeAY+Yquw=;
	b=zs2rFuklTxUZu5QUQvubGD+p6Pyzu9fQaaPPpeVicdMWD9WrOngHzV4/XzWZBGRHsdJ3cc
	quUxa+FO+MT7Qm/1zSlCXev5I2WGMZIh/fLeXdR2vba6jrhmd5wv+j2JDbGxOR8rDRUZTq
	BrS2u4u2bVtIG6e9i5XPQgNb5b0xiqfa7c6Hy/FALHoQLbQ4PissJnR0w7x8W5wTyO+xDz
	W93AeGkWa+PBh71o7o+hiHRXY5BimtaJ7OVjOnYimFgvPF1vB7Sw1JBQRyGxXt9skYIxqX
	1OCyPLXO09TENfB/JZxU1yGMr5vNBBFPKGZp4DoiSMxG8+jwAwxfZJtkcpfl7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795426648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8XqI/ovDzkmrLY2+2cJN8n7p6UWRDilYHLPeAY+Yquw=;
	b=PrBaN3N0mDSUo7jZ1zD0BdxjTZzR+Nlue0EyvgR0thKd8gbwBgsxQQULaCNGGe53D7j5Fj
	BqzY9hdcO8uUC/AQ==
Date: Mon, 23 Nov 2026 10:37:10 +0100
Subject: [PATCH v3 05/15] x86: Remove AT_VECTOR_SIZE_ARCH from UAPI
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
Message-Id: <20261123-at-vector-size-arch-v3-5-d342dae9e843@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795426640; l=1994;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=AMxMWB4XLAUF07GFQRf/ET9aUWKjGb7vCuCYUiBHLok=;
 b=zxx6vGGdxpYVQVUw2UCdVcTPBGb0aQyLdwuRLfgrOIr0g0B+Y9UEJYR4JcBJhIcNn1mnVle0L
 jMOLDNcao4zATn0M7hA6ZDAZUGDgHq+8r7fL+5MoLrHIByaxlnXij9k
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
 arch/x86/include/asm/auxvec.h      | 12 ++++++++++++
 arch/x86/include/uapi/asm/auxvec.h | 13 +++----------
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/auxvec.h b/arch/x86/include/asm/auxvec.h
new file mode 100644
index 000000000000..ed26ad09f3e3
--- /dev/null
+++ b/arch/x86/include/asm/auxvec.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_AUXVEC_H
+#define _ASM_X86_AUXVEC_H
+
+/* entries in ARCH_DLINFO: */
+#if defined(CONFIG_IA32_EMULATION) || !defined(CONFIG_X86_64)
+# define AT_VECTOR_SIZE_ARCH 3
+#else /* else it's non-compat x86-64 */
+# define AT_VECTOR_SIZE_ARCH 2
+#endif
+
+#endif /* _ASM_X86_AUXVEC_H */
diff --git a/arch/x86/include/uapi/asm/auxvec.h b/arch/x86/include/uapi/asm/auxvec.h
index bdde9e18f94e..6677c9ace117 100644
--- a/arch/x86/include/uapi/asm/auxvec.h
+++ b/arch/x86/include/uapi/asm/auxvec.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _ASM_X86_AUXVEC_H
-#define _ASM_X86_AUXVEC_H
+#ifndef _UAPI_ASM_X86_AUXVEC_H
+#define _UAPI_ASM_X86_AUXVEC_H
 /*
  * Architecture-neutral AT_ values in 0-17, leave some room
  * for more of them, start the x86-specific ones at 32.
@@ -10,11 +10,4 @@
 #endif
 #define AT_SYSINFO_EHDR		33
 
-/* entries in ARCH_DLINFO: */
-#if defined(__KERNEL__) && (defined(CONFIG_IA32_EMULATION) || !defined(CONFIG_X86_64))
-# define AT_VECTOR_SIZE_ARCH 3
-#else /* else it's non-compat x86-64 */
-# define AT_VECTOR_SIZE_ARCH 2
-#endif
-
-#endif /* _ASM_X86_AUXVEC_H */
+#endif /* _UAPI_ASM_X86_AUXVEC_H */

-- 
2.56.1


