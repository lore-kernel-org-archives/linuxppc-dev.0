Return-Path: <linuxppc-dev+bounces-18024-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8E3FD063E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 07:07:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fW1zZ1XjZz3cZd;
	Wed, 11 Mar 2026 18:07:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773212874;
	cv=none; b=ZY9gqu+VfRN5q5sSAlbsE3MUOdQGP27wZlfIu8ZiLPM5Hm22oMn2XtupsIIMMK1CAeWWeqNTZKu4hxUAJSUgYk7lOT3z1NO+Bmu2GgVJ96zM+mHyV4EmgCdgKvLsNvKtO/l9XJa3Y40F3PTo17q7j5TGdOT8toJG80NkxoF8o4Vw4/NHq2zF1q/wUICXCBW7p4sXGyreifCEl2kEgQnBTx6AuhS2IIaT4emIgRcbAt3Ya3utN6TYxLG4ro7tjhWuvEUf7eeexCwzD6HvJXHqPQv2hKCKZgydci+lAgvAgKHYCjMmYHlQDCG+0k69+9J3Ip0VZxidqagl6wrIfRowfw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773212874; c=relaxed/relaxed;
	bh=1N/WiUgWMSpYjlopJG9AbWnsi38DwWQVuDQYplZc2H8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YEGBaKDfVBZEXviKfZN/Q+j2yA7yQVUv/d4EhnW+ar/2PEBODVUC3EzgL0tjecJOw8f1vQUrug2kRKQJ9iWk/lX5BwEr+3lcaDcoye1CoRIMpQLVmb2ymFCMPJ+R6STSgQs66+//FcuV7Y5jt6ddgChm+YLI6/eVhONbPjhHNwfokFle20v8sYuo82jsuEaO0jUd5jjHb9kU6/yt9Fgj8ui7RGbCIzoPe7FYIlyILH5/KmChsQnN6NrwhcNPVRKdB6jk2JC0JFmQ5HjcYT8IJkRlFCKbf92UtM9cOgsMJ4/ZuvionEg6aEWOyjKJ3Dsr/2BsT7AukeJFgDFMPyeojQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=M7Cf8VQ9; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+bcc67bb7b2d0717eac20+8235+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=M7Cf8VQ9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+bcc67bb7b2d0717eac20+8235+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fW1zY4p5Qz3cZY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 18:07:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=1N/WiUgWMSpYjlopJG9AbWnsi38DwWQVuDQYplZc2H8=; b=M7Cf8VQ9mRDsmyZl1HeG3cfMGf
	DQV2D40U1E+JtCEHKAiIWQ6p3Ddwv3M6rg+WbZuxSnpFm1ixYM8kIehFlEd9xTRGEqu4hcolRXnbl
	skeFtM0uWMVnUXQnc7bsrxpkaLiQRzLVgmjeEFF5SL4mzOIqJIizDOiYuWfr6zdjuMjvJ9KxkbQI8
	lJ6n7e+WIzD3AG8dPX0/z4tuWittDsbnPvyuEz2puaxefayFsnhaB/TSdKzBy5mUdDH0frS/aWBTL
	fU016BS2CKLDsSp4hDkFzzdTLt/cJ/NLckGIkmctyiDA03E3Ff8QLoK5hIrHufClBmMCIgnNeSBor
	rKq7FOFg==;
Received: from [212.243.42.10] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0DfL-0000000AzeY-30Fy;
	Wed, 11 Mar 2026 07:07:36 +0000
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
Subject: [PATCH 13/27] loongarch: move the XOR code to lib/raid/
Date: Wed, 11 Mar 2026 08:03:45 +0100
Message-ID: <20260311070416.972667-14-hch@lst.de>
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

Move the optimized XOR into lib/raid and include it it in xor.ko
instead of always building it into the main kernel image.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/loongarch/include/asm/xor.h              | 24 ++----------
 arch/loongarch/include/asm/xor_simd.h         | 34 ----------------
 arch/loongarch/lib/Makefile                   |  2 -
 lib/raid/xor/Makefile                         |  2 +
 .../lib => lib/raid/xor/loongarch}/xor_simd.c |  0
 .../lib => lib/raid/xor/loongarch}/xor_simd.h |  0
 .../raid/xor/loongarch}/xor_simd_glue.c       | 39 +++++++++++--------
 .../raid/xor/loongarch}/xor_template.c        |  0
 8 files changed, 27 insertions(+), 74 deletions(-)
 delete mode 100644 arch/loongarch/include/asm/xor_simd.h
 rename {arch/loongarch/lib => lib/raid/xor/loongarch}/xor_simd.c (100%)
 rename {arch/loongarch/lib => lib/raid/xor/loongarch}/xor_simd.h (100%)
 rename {arch/loongarch/lib => lib/raid/xor/loongarch}/xor_simd_glue.c (64%)
 rename {arch/loongarch/lib => lib/raid/xor/loongarch}/xor_template.c (100%)

diff --git a/arch/loongarch/include/asm/xor.h b/arch/loongarch/include/asm/xor.h
index d17c0e3b047f..7e32f72f8b03 100644
--- a/arch/loongarch/include/asm/xor.h
+++ b/arch/loongarch/include/asm/xor.h
@@ -6,27 +6,6 @@
 #define _ASM_LOONGARCH_XOR_H
 
 #include <asm/cpu-features.h>
-#include <asm/xor_simd.h>
-
-#ifdef CONFIG_CPU_HAS_LSX
-static struct xor_block_template xor_block_lsx = {
-	.name = "lsx",
-	.do_2 = xor_lsx_2,
-	.do_3 = xor_lsx_3,
-	.do_4 = xor_lsx_4,
-	.do_5 = xor_lsx_5,
-};
-#endif /* CONFIG_CPU_HAS_LSX */
-
-#ifdef CONFIG_CPU_HAS_LASX
-static struct xor_block_template xor_block_lasx = {
-	.name = "lasx",
-	.do_2 = xor_lasx_2,
-	.do_3 = xor_lasx_3,
-	.do_4 = xor_lasx_4,
-	.do_5 = xor_lasx_5,
-};
-#endif /* CONFIG_CPU_HAS_LASX */
 
 /*
  * For grins, also test the generic routines.
@@ -38,6 +17,9 @@ static struct xor_block_template xor_block_lasx = {
  */
 #include <asm-generic/xor.h>
 
+extern struct xor_block_template xor_block_lsx;
+extern struct xor_block_template xor_block_lasx;
+
 #define arch_xor_init arch_xor_init
 static __always_inline void __init arch_xor_init(void)
 {
diff --git a/arch/loongarch/include/asm/xor_simd.h b/arch/loongarch/include/asm/xor_simd.h
deleted file mode 100644
index 471b96332f38..000000000000
--- a/arch/loongarch/include/asm/xor_simd.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2023 WANG Xuerui <git@xen0n.name>
- */
-#ifndef _ASM_LOONGARCH_XOR_SIMD_H
-#define _ASM_LOONGARCH_XOR_SIMD_H
-
-#ifdef CONFIG_CPU_HAS_LSX
-void xor_lsx_2(unsigned long bytes, unsigned long * __restrict p1,
-	       const unsigned long * __restrict p2);
-void xor_lsx_3(unsigned long bytes, unsigned long * __restrict p1,
-	       const unsigned long * __restrict p2, const unsigned long * __restrict p3);
-void xor_lsx_4(unsigned long bytes, unsigned long * __restrict p1,
-	       const unsigned long * __restrict p2, const unsigned long * __restrict p3,
-	       const unsigned long * __restrict p4);
-void xor_lsx_5(unsigned long bytes, unsigned long * __restrict p1,
-	       const unsigned long * __restrict p2, const unsigned long * __restrict p3,
-	       const unsigned long * __restrict p4, const unsigned long * __restrict p5);
-#endif /* CONFIG_CPU_HAS_LSX */
-
-#ifdef CONFIG_CPU_HAS_LASX
-void xor_lasx_2(unsigned long bytes, unsigned long * __restrict p1,
-	        const unsigned long * __restrict p2);
-void xor_lasx_3(unsigned long bytes, unsigned long * __restrict p1,
-	        const unsigned long * __restrict p2, const unsigned long * __restrict p3);
-void xor_lasx_4(unsigned long bytes, unsigned long * __restrict p1,
-	        const unsigned long * __restrict p2, const unsigned long * __restrict p3,
-	        const unsigned long * __restrict p4);
-void xor_lasx_5(unsigned long bytes, unsigned long * __restrict p1,
-	        const unsigned long * __restrict p2, const unsigned long * __restrict p3,
-	        const unsigned long * __restrict p4, const unsigned long * __restrict p5);
-#endif /* CONFIG_CPU_HAS_LASX */
-
-#endif /* _ASM_LOONGARCH_XOR_SIMD_H */
diff --git a/arch/loongarch/lib/Makefile b/arch/loongarch/lib/Makefile
index ccea3bbd4353..827a88529a42 100644
--- a/arch/loongarch/lib/Makefile
+++ b/arch/loongarch/lib/Makefile
@@ -8,6 +8,4 @@ lib-y	+= delay.o memset.o memcpy.o memmove.o \
 
 obj-$(CONFIG_ARCH_SUPPORTS_INT128) += tishift.o
 
-obj-$(CONFIG_CPU_HAS_LSX) += xor_simd.o xor_simd_glue.o
-
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
diff --git a/lib/raid/xor/Makefile b/lib/raid/xor/Makefile
index 3c13851219e5..fafd131cef27 100644
--- a/lib/raid/xor/Makefile
+++ b/lib/raid/xor/Makefile
@@ -15,6 +15,8 @@ xor-$(CONFIG_KERNEL_MODE_NEON)	+= arm/xor-neon.o arm/xor-neon-glue.o
 else
 xor-$(CONFIG_KERNEL_MODE_NEON)	+= arm64/xor-neon.o arm64/xor-neon-glue.o
 endif
+xor-$(CONFIG_CPU_HAS_LSX)	+= loongarch/xor_simd.o
+xor-$(CONFIG_CPU_HAS_LSX)	+= loongarch/xor_simd_glue.o
 
 
 CFLAGS_arm/xor-neon.o		+= $(CC_FLAGS_FPU)
diff --git a/arch/loongarch/lib/xor_simd.c b/lib/raid/xor/loongarch/xor_simd.c
similarity index 100%
rename from arch/loongarch/lib/xor_simd.c
rename to lib/raid/xor/loongarch/xor_simd.c
diff --git a/arch/loongarch/lib/xor_simd.h b/lib/raid/xor/loongarch/xor_simd.h
similarity index 100%
rename from arch/loongarch/lib/xor_simd.h
rename to lib/raid/xor/loongarch/xor_simd.h
diff --git a/arch/loongarch/lib/xor_simd_glue.c b/lib/raid/xor/loongarch/xor_simd_glue.c
similarity index 64%
rename from arch/loongarch/lib/xor_simd_glue.c
rename to lib/raid/xor/loongarch/xor_simd_glue.c
index 393f689dbcf6..11fa3b47ba83 100644
--- a/arch/loongarch/lib/xor_simd_glue.c
+++ b/lib/raid/xor/loongarch/xor_simd_glue.c
@@ -5,24 +5,23 @@
  * Copyright (C) 2023 WANG Xuerui <git@xen0n.name>
  */
 
-#include <linux/export.h>
 #include <linux/sched.h>
+#include <linux/raid/xor_impl.h>
 #include <asm/fpu.h>
-#include <asm/xor_simd.h>
+#include <asm/xor.h>
 #include "xor_simd.h"
 
 #define MAKE_XOR_GLUE_2(flavor)							\
-void xor_##flavor##_2(unsigned long bytes, unsigned long * __restrict p1,	\
+static void xor_##flavor##_2(unsigned long bytes, unsigned long * __restrict p1,\
 		      const unsigned long * __restrict p2)			\
 {										\
 	kernel_fpu_begin();							\
 	__xor_##flavor##_2(bytes, p1, p2);					\
 	kernel_fpu_end();							\
 }										\
-EXPORT_SYMBOL_GPL(xor_##flavor##_2)
 
 #define MAKE_XOR_GLUE_3(flavor)							\
-void xor_##flavor##_3(unsigned long bytes, unsigned long * __restrict p1,	\
+static void xor_##flavor##_3(unsigned long bytes, unsigned long * __restrict p1,\
 		      const unsigned long * __restrict p2,			\
 		      const unsigned long * __restrict p3)			\
 {										\
@@ -30,10 +29,9 @@ void xor_##flavor##_3(unsigned long bytes, unsigned long * __restrict p1,	\
 	__xor_##flavor##_3(bytes, p1, p2, p3);					\
 	kernel_fpu_end();							\
 }										\
-EXPORT_SYMBOL_GPL(xor_##flavor##_3)
 
 #define MAKE_XOR_GLUE_4(flavor)							\
-void xor_##flavor##_4(unsigned long bytes, unsigned long * __restrict p1,	\
+static void xor_##flavor##_4(unsigned long bytes, unsigned long * __restrict p1,\
 		      const unsigned long * __restrict p2,			\
 		      const unsigned long * __restrict p3,			\
 		      const unsigned long * __restrict p4)			\
@@ -42,10 +40,9 @@ void xor_##flavor##_4(unsigned long bytes, unsigned long * __restrict p1,	\
 	__xor_##flavor##_4(bytes, p1, p2, p3, p4);				\
 	kernel_fpu_end();							\
 }										\
-EXPORT_SYMBOL_GPL(xor_##flavor##_4)
 
 #define MAKE_XOR_GLUE_5(flavor)							\
-void xor_##flavor##_5(unsigned long bytes, unsigned long * __restrict p1,	\
+static void xor_##flavor##_5(unsigned long bytes, unsigned long * __restrict p1,\
 		      const unsigned long * __restrict p2,			\
 		      const unsigned long * __restrict p3,			\
 		      const unsigned long * __restrict p4,			\
@@ -55,18 +52,26 @@ void xor_##flavor##_5(unsigned long bytes, unsigned long * __restrict p1,	\
 	__xor_##flavor##_5(bytes, p1, p2, p3, p4, p5);				\
 	kernel_fpu_end();							\
 }										\
-EXPORT_SYMBOL_GPL(xor_##flavor##_5)
 
-#define MAKE_XOR_GLUES(flavor)		\
-	MAKE_XOR_GLUE_2(flavor);	\
-	MAKE_XOR_GLUE_3(flavor);	\
-	MAKE_XOR_GLUE_4(flavor);	\
-	MAKE_XOR_GLUE_5(flavor)
+#define MAKE_XOR_GLUES(flavor)				\
+	MAKE_XOR_GLUE_2(flavor);			\
+	MAKE_XOR_GLUE_3(flavor);			\
+	MAKE_XOR_GLUE_4(flavor);			\
+	MAKE_XOR_GLUE_5(flavor);			\
+							\
+struct xor_block_template xor_block_##flavor = {	\
+	.name = __stringify(flavor),			\
+	.do_2 = xor_##flavor##_2,			\
+	.do_3 = xor_##flavor##_3,			\
+	.do_4 = xor_##flavor##_4,			\
+	.do_5 = xor_##flavor##_5,			\
+}
+
 
 #ifdef CONFIG_CPU_HAS_LSX
 MAKE_XOR_GLUES(lsx);
-#endif
+#endif /* CONFIG_CPU_HAS_LSX */
 
 #ifdef CONFIG_CPU_HAS_LASX
 MAKE_XOR_GLUES(lasx);
-#endif
+#endif /* CONFIG_CPU_HAS_LASX */
diff --git a/arch/loongarch/lib/xor_template.c b/lib/raid/xor/loongarch/xor_template.c
similarity index 100%
rename from arch/loongarch/lib/xor_template.c
rename to lib/raid/xor/loongarch/xor_template.c
-- 
2.47.3


