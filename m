Return-Path: <linuxppc-dev+bounces-18022-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B742FD063E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 07:07:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fW1yw4fDCz3cX4;
	Wed, 11 Mar 2026 18:07:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773212840;
	cv=none; b=ilXf+HrcVOiWpE9D3LXrrJbwiFB/Iq60XXyBQcJgUWh+Fu3NhaPIDSAZthZHJQHtjffdpyklcjgAG9apkyDA+wipxRxliDvBbAmOasbaCODe+sb0CgRhZf0lTJ7WeQcCUwGCzAjY9nmMK3mSfc6EFiLCpBU5x2e1m8fcVUOgne6BtoUJA2X2Ke0GfyqAcBGJ5J8EkicbKpksRtA3fjWLG+RD4Gc7dJAx8Ovx70euk7ml2eF4ySX7Hd0wbd4njhmjBG8Seg2Ve95iQu0N90Uu3cI64g+SKCdkpPQyrPq/x4fxfSC4QkNqOxAcPEYkWqHH8+piiPydT3ogqm98/P+fuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773212840; c=relaxed/relaxed;
	bh=ry2shtzl2BSBD299Iewxm9iaU+3NWMfzJH2Uml5DqNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kh7X35kXqFWaE3MW2F4ZUJ5oKbjIqt9E9OjRYke2mKeZ+cI5LBqBAG+SMMwS/srcacd31YwQ1jScvUFR3c5Wtz50jaWsQeZ9TLHv5sfZgY44in4lV9JVlvk+3LYNlFhVY7omB6miqDLeaJKaC80FVoudbrYmY95E2WLP8I7vIP4Itwkes4/v+42eHwxLPgsYw86Ie/zqKW2SbyNWFvPOcOHO1Rx3oQGiJ4P8Wm5S+7qjMxqvy33r1WzoPgyyzE4Oau8RPBys+j77NsoqcV3yTh3IiBq2zVMgCpCl6tjaZnIvUU4D6UcLzOygzd1VJ9vdn/mm3B5BmcC+aDgIBSAtdg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zviOKS3y; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+bcc67bb7b2d0717eac20+8235+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zviOKS3y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+bcc67bb7b2d0717eac20+8235+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fW1yv6fHZz3cX3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 18:07:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ry2shtzl2BSBD299Iewxm9iaU+3NWMfzJH2Uml5DqNo=; b=zviOKS3y0oZ9eKnSGUuSYk148r
	/kep7HIP5U/A5QJXW6Yzl+A84e/Y13J7z9KetOPd4uRbr0piLHg3xb5BN4gZCPqWT/1v0Tdm6KVCA
	WsVIGz097uNJR7fj/zqS58gQbuN8Lq8W7PDVEctIcvF4fd4zSoJpsWABnsgdXp9vX20sSj14sSHfQ
	tHbxzC0IiwBULjKLXsHs8re11/iLM3TA18fzbBJTkCVATnxq/vRqDweNmcpQK+3vTzt1EgKdBN5Vq
	LJ7p8w5n4l+z6ZbFwEuwOvPMSd/Q5Um7GN0GaFwbXSGq9a99ahezPPRUu2LC5oz1ZRN3zj8Z5ZPnA
	vaohGI8Q==;
Received: from [212.243.42.10] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0Dep-0000000AzIS-2auW;
	Wed, 11 Mar 2026 07:07:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Dan Williams <dan.j.williams@intel.com>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fnnas.com>,
	Li Nan <linan122@huawei.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-raid@vger.kernel.org
Subject: [PATCH 11/27] arm: move the XOR code to lib/raid/
Date: Wed, 11 Mar 2026 08:03:43 +0100
Message-ID: <20260311070416.972667-12-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260311070416.972667-1-hch@lst.de>
References: <20260311070416.972667-1-hch@lst.de>
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
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Move the optimized XOR into lib/raid and include it it in the main
xor.ko instead of building a separate module for it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/include/asm/xor.h                    | 190 +-----------------
 arch/arm/lib/Makefile                         |   5 -
 lib/raid/xor/Makefile                         |   8 +
 lib/raid/xor/arm/xor-neon-glue.c              |  58 ++++++
 {arch/arm/lib => lib/raid/xor/arm}/xor-neon.c |  10 +-
 lib/raid/xor/arm/xor.c                        | 136 +++++++++++++
 6 files changed, 205 insertions(+), 202 deletions(-)
 create mode 100644 lib/raid/xor/arm/xor-neon-glue.c
 rename {arch/arm/lib => lib/raid/xor/arm}/xor-neon.c (74%)
 create mode 100644 lib/raid/xor/arm/xor.c

diff --git a/arch/arm/include/asm/xor.h b/arch/arm/include/asm/xor.h
index b2dcd49186e2..989c55872ef6 100644
--- a/arch/arm/include/asm/xor.h
+++ b/arch/arm/include/asm/xor.h
@@ -1,198 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- *  arch/arm/include/asm/xor.h
- *
  *  Copyright (C) 2001 Russell King
  */
 #include <asm-generic/xor.h>
-#include <asm/hwcap.h>
 #include <asm/neon.h>
 
-#define __XOR(a1, a2) a1 ^= a2
-
-#define GET_BLOCK_2(dst) \
-	__asm__("ldmia	%0, {%1, %2}" \
-		: "=r" (dst), "=r" (a1), "=r" (a2) \
-		: "0" (dst))
-
-#define GET_BLOCK_4(dst) \
-	__asm__("ldmia	%0, {%1, %2, %3, %4}" \
-		: "=r" (dst), "=r" (a1), "=r" (a2), "=r" (a3), "=r" (a4) \
-		: "0" (dst))
-
-#define XOR_BLOCK_2(src) \
-	__asm__("ldmia	%0!, {%1, %2}" \
-		: "=r" (src), "=r" (b1), "=r" (b2) \
-		: "0" (src)); \
-	__XOR(a1, b1); __XOR(a2, b2);
-
-#define XOR_BLOCK_4(src) \
-	__asm__("ldmia	%0!, {%1, %2, %3, %4}" \
-		: "=r" (src), "=r" (b1), "=r" (b2), "=r" (b3), "=r" (b4) \
-		: "0" (src)); \
-	__XOR(a1, b1); __XOR(a2, b2); __XOR(a3, b3); __XOR(a4, b4)
-
-#define PUT_BLOCK_2(dst) \
-	__asm__ __volatile__("stmia	%0!, {%2, %3}" \
-		: "=r" (dst) \
-		: "0" (dst), "r" (a1), "r" (a2))
-
-#define PUT_BLOCK_4(dst) \
-	__asm__ __volatile__("stmia	%0!, {%2, %3, %4, %5}" \
-		: "=r" (dst) \
-		: "0" (dst), "r" (a1), "r" (a2), "r" (a3), "r" (a4))
-
-static void
-xor_arm4regs_2(unsigned long bytes, unsigned long * __restrict p1,
-	       const unsigned long * __restrict p2)
-{
-	unsigned int lines = bytes / sizeof(unsigned long) / 4;
-	register unsigned int a1 __asm__("r4");
-	register unsigned int a2 __asm__("r5");
-	register unsigned int a3 __asm__("r6");
-	register unsigned int a4 __asm__("r10");
-	register unsigned int b1 __asm__("r8");
-	register unsigned int b2 __asm__("r9");
-	register unsigned int b3 __asm__("ip");
-	register unsigned int b4 __asm__("lr");
-
-	do {
-		GET_BLOCK_4(p1);
-		XOR_BLOCK_4(p2);
-		PUT_BLOCK_4(p1);
-	} while (--lines);
-}
-
-static void
-xor_arm4regs_3(unsigned long bytes, unsigned long * __restrict p1,
-	       const unsigned long * __restrict p2,
-	       const unsigned long * __restrict p3)
-{
-	unsigned int lines = bytes / sizeof(unsigned long) / 4;
-	register unsigned int a1 __asm__("r4");
-	register unsigned int a2 __asm__("r5");
-	register unsigned int a3 __asm__("r6");
-	register unsigned int a4 __asm__("r10");
-	register unsigned int b1 __asm__("r8");
-	register unsigned int b2 __asm__("r9");
-	register unsigned int b3 __asm__("ip");
-	register unsigned int b4 __asm__("lr");
-
-	do {
-		GET_BLOCK_4(p1);
-		XOR_BLOCK_4(p2);
-		XOR_BLOCK_4(p3);
-		PUT_BLOCK_4(p1);
-	} while (--lines);
-}
-
-static void
-xor_arm4regs_4(unsigned long bytes, unsigned long * __restrict p1,
-	       const unsigned long * __restrict p2,
-	       const unsigned long * __restrict p3,
-	       const unsigned long * __restrict p4)
-{
-	unsigned int lines = bytes / sizeof(unsigned long) / 2;
-	register unsigned int a1 __asm__("r8");
-	register unsigned int a2 __asm__("r9");
-	register unsigned int b1 __asm__("ip");
-	register unsigned int b2 __asm__("lr");
-
-	do {
-		GET_BLOCK_2(p1);
-		XOR_BLOCK_2(p2);
-		XOR_BLOCK_2(p3);
-		XOR_BLOCK_2(p4);
-		PUT_BLOCK_2(p1);
-	} while (--lines);
-}
-
-static void
-xor_arm4regs_5(unsigned long bytes, unsigned long * __restrict p1,
-	       const unsigned long * __restrict p2,
-	       const unsigned long * __restrict p3,
-	       const unsigned long * __restrict p4,
-	       const unsigned long * __restrict p5)
-{
-	unsigned int lines = bytes / sizeof(unsigned long) / 2;
-	register unsigned int a1 __asm__("r8");
-	register unsigned int a2 __asm__("r9");
-	register unsigned int b1 __asm__("ip");
-	register unsigned int b2 __asm__("lr");
-
-	do {
-		GET_BLOCK_2(p1);
-		XOR_BLOCK_2(p2);
-		XOR_BLOCK_2(p3);
-		XOR_BLOCK_2(p4);
-		XOR_BLOCK_2(p5);
-		PUT_BLOCK_2(p1);
-	} while (--lines);
-}
-
-static struct xor_block_template xor_block_arm4regs = {
-	.name	= "arm4regs",
-	.do_2	= xor_arm4regs_2,
-	.do_3	= xor_arm4regs_3,
-	.do_4	= xor_arm4regs_4,
-	.do_5	= xor_arm4regs_5,
-};
-
-#ifdef CONFIG_KERNEL_MODE_NEON
-
-extern struct xor_block_template const xor_block_neon_inner;
-
-static void
-xor_neon_2(unsigned long bytes, unsigned long * __restrict p1,
-	   const unsigned long * __restrict p2)
-{
-	kernel_neon_begin();
-	xor_block_neon_inner.do_2(bytes, p1, p2);
-	kernel_neon_end();
-}
-
-static void
-xor_neon_3(unsigned long bytes, unsigned long * __restrict p1,
-	   const unsigned long * __restrict p2,
-	   const unsigned long * __restrict p3)
-{
-	kernel_neon_begin();
-	xor_block_neon_inner.do_3(bytes, p1, p2, p3);
-	kernel_neon_end();
-}
-
-static void
-xor_neon_4(unsigned long bytes, unsigned long * __restrict p1,
-	   const unsigned long * __restrict p2,
-	   const unsigned long * __restrict p3,
-	   const unsigned long * __restrict p4)
-{
-	kernel_neon_begin();
-	xor_block_neon_inner.do_4(bytes, p1, p2, p3, p4);
-	kernel_neon_end();
-}
-
-static void
-xor_neon_5(unsigned long bytes, unsigned long * __restrict p1,
-	   const unsigned long * __restrict p2,
-	   const unsigned long * __restrict p3,
-	   const unsigned long * __restrict p4,
-	   const unsigned long * __restrict p5)
-{
-	kernel_neon_begin();
-	xor_block_neon_inner.do_5(bytes, p1, p2, p3, p4, p5);
-	kernel_neon_end();
-}
-
-static struct xor_block_template xor_block_neon = {
-	.name	= "neon",
-	.do_2	= xor_neon_2,
-	.do_3	= xor_neon_3,
-	.do_4	= xor_neon_4,
-	.do_5	= xor_neon_5
-};
-
-#endif /* CONFIG_KERNEL_MODE_NEON */
+extern struct xor_block_template xor_block_arm4regs;
+extern struct xor_block_template xor_block_neon;
 
 #define arch_xor_init arch_xor_init
 static __always_inline void __init arch_xor_init(void)
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 0ca5aae1bcc3..9295055cdfc9 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -39,9 +39,4 @@ endif
 $(obj)/csumpartialcopy.o:	$(obj)/csumpartialcopygeneric.S
 $(obj)/csumpartialcopyuser.o:	$(obj)/csumpartialcopygeneric.S
 
-ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
-  CFLAGS_xor-neon.o		+= $(CC_FLAGS_FPU)
-  obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
-endif
-
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
diff --git a/lib/raid/xor/Makefile b/lib/raid/xor/Makefile
index 6d03c27c37c7..fb760edae54b 100644
--- a/lib/raid/xor/Makefile
+++ b/lib/raid/xor/Makefile
@@ -9,3 +9,11 @@ xor-y				+= xor-8regs-prefetch.o
 xor-y				+= xor-32regs-prefetch.o
 
 xor-$(CONFIG_ALPHA)		+= alpha/xor.o
+xor-$(CONFIG_ARM)		+= arm/xor.o
+ifeq ($(CONFIG_ARM),y)
+xor-$(CONFIG_KERNEL_MODE_NEON)	+= arm/xor-neon.o arm/xor-neon-glue.o
+endif
+
+
+CFLAGS_arm/xor-neon.o		+= $(CC_FLAGS_FPU)
+CFLAGS_REMOVE_arm/xor-neon.o	+= $(CC_FLAGS_NO_FPU)
diff --git a/lib/raid/xor/arm/xor-neon-glue.c b/lib/raid/xor/arm/xor-neon-glue.c
new file mode 100644
index 000000000000..c7b162b383a2
--- /dev/null
+++ b/lib/raid/xor/arm/xor-neon-glue.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Copyright (C) 2001 Russell King
+ */
+#include <linux/raid/xor_impl.h>
+#include <asm/xor.h>
+
+extern struct xor_block_template const xor_block_neon_inner;
+
+static void
+xor_neon_2(unsigned long bytes, unsigned long * __restrict p1,
+	   const unsigned long * __restrict p2)
+{
+	kernel_neon_begin();
+	xor_block_neon_inner.do_2(bytes, p1, p2);
+	kernel_neon_end();
+}
+
+static void
+xor_neon_3(unsigned long bytes, unsigned long * __restrict p1,
+	   const unsigned long * __restrict p2,
+	   const unsigned long * __restrict p3)
+{
+	kernel_neon_begin();
+	xor_block_neon_inner.do_3(bytes, p1, p2, p3);
+	kernel_neon_end();
+}
+
+static void
+xor_neon_4(unsigned long bytes, unsigned long * __restrict p1,
+	   const unsigned long * __restrict p2,
+	   const unsigned long * __restrict p3,
+	   const unsigned long * __restrict p4)
+{
+	kernel_neon_begin();
+	xor_block_neon_inner.do_4(bytes, p1, p2, p3, p4);
+	kernel_neon_end();
+}
+
+static void
+xor_neon_5(unsigned long bytes, unsigned long * __restrict p1,
+	   const unsigned long * __restrict p2,
+	   const unsigned long * __restrict p3,
+	   const unsigned long * __restrict p4,
+	   const unsigned long * __restrict p5)
+{
+	kernel_neon_begin();
+	xor_block_neon_inner.do_5(bytes, p1, p2, p3, p4, p5);
+	kernel_neon_end();
+}
+
+struct xor_block_template xor_block_neon = {
+	.name	= "neon",
+	.do_2	= xor_neon_2,
+	.do_3	= xor_neon_3,
+	.do_4	= xor_neon_4,
+	.do_5	= xor_neon_5
+};
diff --git a/arch/arm/lib/xor-neon.c b/lib/raid/xor/arm/xor-neon.c
similarity index 74%
rename from arch/arm/lib/xor-neon.c
rename to lib/raid/xor/arm/xor-neon.c
index b5be50567991..c9d4378b0f0e 100644
--- a/arch/arm/lib/xor-neon.c
+++ b/lib/raid/xor/arm/xor-neon.c
@@ -1,16 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * linux/arch/arm/lib/xor-neon.c
- *
  * Copyright (C) 2013 Linaro Ltd <ard.biesheuvel@linaro.org>
  */
 
-#include <linux/raid/xor.h>
 #include <linux/raid/xor_impl.h>
-#include <linux/module.h>
-
-MODULE_DESCRIPTION("NEON accelerated XOR implementation");
-MODULE_LICENSE("GPL");
 
 #ifndef __ARM_NEON__
 #error You should compile this file with '-march=armv7-a -mfloat-abi=softfp -mfpu=neon'
@@ -27,7 +20,7 @@ MODULE_LICENSE("GPL");
 #endif
 
 #define NO_TEMPLATE
-#include "../../../lib/raid/xor/xor-8regs.c"
+#include "../xor-8regs.c"
 
 struct xor_block_template const xor_block_neon_inner = {
 	.name	= "__inner_neon__",
@@ -36,4 +29,3 @@ struct xor_block_template const xor_block_neon_inner = {
 	.do_4	= xor_8regs_4,
 	.do_5	= xor_8regs_5,
 };
-EXPORT_SYMBOL(xor_block_neon_inner);
diff --git a/lib/raid/xor/arm/xor.c b/lib/raid/xor/arm/xor.c
new file mode 100644
index 000000000000..2263341dbbcd
--- /dev/null
+++ b/lib/raid/xor/arm/xor.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Copyright (C) 2001 Russell King
+ */
+#include <linux/raid/xor_impl.h>
+#include <asm/xor.h>
+
+#define __XOR(a1, a2) a1 ^= a2
+
+#define GET_BLOCK_2(dst) \
+	__asm__("ldmia	%0, {%1, %2}" \
+		: "=r" (dst), "=r" (a1), "=r" (a2) \
+		: "0" (dst))
+
+#define GET_BLOCK_4(dst) \
+	__asm__("ldmia	%0, {%1, %2, %3, %4}" \
+		: "=r" (dst), "=r" (a1), "=r" (a2), "=r" (a3), "=r" (a4) \
+		: "0" (dst))
+
+#define XOR_BLOCK_2(src) \
+	__asm__("ldmia	%0!, {%1, %2}" \
+		: "=r" (src), "=r" (b1), "=r" (b2) \
+		: "0" (src)); \
+	__XOR(a1, b1); __XOR(a2, b2);
+
+#define XOR_BLOCK_4(src) \
+	__asm__("ldmia	%0!, {%1, %2, %3, %4}" \
+		: "=r" (src), "=r" (b1), "=r" (b2), "=r" (b3), "=r" (b4) \
+		: "0" (src)); \
+	__XOR(a1, b1); __XOR(a2, b2); __XOR(a3, b3); __XOR(a4, b4)
+
+#define PUT_BLOCK_2(dst) \
+	__asm__ __volatile__("stmia	%0!, {%2, %3}" \
+		: "=r" (dst) \
+		: "0" (dst), "r" (a1), "r" (a2))
+
+#define PUT_BLOCK_4(dst) \
+	__asm__ __volatile__("stmia	%0!, {%2, %3, %4, %5}" \
+		: "=r" (dst) \
+		: "0" (dst), "r" (a1), "r" (a2), "r" (a3), "r" (a4))
+
+static void
+xor_arm4regs_2(unsigned long bytes, unsigned long * __restrict p1,
+	       const unsigned long * __restrict p2)
+{
+	unsigned int lines = bytes / sizeof(unsigned long) / 4;
+	register unsigned int a1 __asm__("r4");
+	register unsigned int a2 __asm__("r5");
+	register unsigned int a3 __asm__("r6");
+	register unsigned int a4 __asm__("r10");
+	register unsigned int b1 __asm__("r8");
+	register unsigned int b2 __asm__("r9");
+	register unsigned int b3 __asm__("ip");
+	register unsigned int b4 __asm__("lr");
+
+	do {
+		GET_BLOCK_4(p1);
+		XOR_BLOCK_4(p2);
+		PUT_BLOCK_4(p1);
+	} while (--lines);
+}
+
+static void
+xor_arm4regs_3(unsigned long bytes, unsigned long * __restrict p1,
+	       const unsigned long * __restrict p2,
+	       const unsigned long * __restrict p3)
+{
+	unsigned int lines = bytes / sizeof(unsigned long) / 4;
+	register unsigned int a1 __asm__("r4");
+	register unsigned int a2 __asm__("r5");
+	register unsigned int a3 __asm__("r6");
+	register unsigned int a4 __asm__("r10");
+	register unsigned int b1 __asm__("r8");
+	register unsigned int b2 __asm__("r9");
+	register unsigned int b3 __asm__("ip");
+	register unsigned int b4 __asm__("lr");
+
+	do {
+		GET_BLOCK_4(p1);
+		XOR_BLOCK_4(p2);
+		XOR_BLOCK_4(p3);
+		PUT_BLOCK_4(p1);
+	} while (--lines);
+}
+
+static void
+xor_arm4regs_4(unsigned long bytes, unsigned long * __restrict p1,
+	       const unsigned long * __restrict p2,
+	       const unsigned long * __restrict p3,
+	       const unsigned long * __restrict p4)
+{
+	unsigned int lines = bytes / sizeof(unsigned long) / 2;
+	register unsigned int a1 __asm__("r8");
+	register unsigned int a2 __asm__("r9");
+	register unsigned int b1 __asm__("ip");
+	register unsigned int b2 __asm__("lr");
+
+	do {
+		GET_BLOCK_2(p1);
+		XOR_BLOCK_2(p2);
+		XOR_BLOCK_2(p3);
+		XOR_BLOCK_2(p4);
+		PUT_BLOCK_2(p1);
+	} while (--lines);
+}
+
+static void
+xor_arm4regs_5(unsigned long bytes, unsigned long * __restrict p1,
+	       const unsigned long * __restrict p2,
+	       const unsigned long * __restrict p3,
+	       const unsigned long * __restrict p4,
+	       const unsigned long * __restrict p5)
+{
+	unsigned int lines = bytes / sizeof(unsigned long) / 2;
+	register unsigned int a1 __asm__("r8");
+	register unsigned int a2 __asm__("r9");
+	register unsigned int b1 __asm__("ip");
+	register unsigned int b2 __asm__("lr");
+
+	do {
+		GET_BLOCK_2(p1);
+		XOR_BLOCK_2(p2);
+		XOR_BLOCK_2(p3);
+		XOR_BLOCK_2(p4);
+		XOR_BLOCK_2(p5);
+		PUT_BLOCK_2(p1);
+	} while (--lines);
+}
+
+struct xor_block_template xor_block_arm4regs = {
+	.name	= "arm4regs",
+	.do_2	= xor_arm4regs_2,
+	.do_3	= xor_arm4regs_3,
+	.do_4	= xor_arm4regs_4,
+	.do_5	= xor_arm4regs_5,
+};
-- 
2.47.3


