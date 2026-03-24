Return-Path: <linuxppc-dev+bounces-18679-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC33F532D4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 06:25:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fg0Qn3gCzz30TP;
	Tue, 24 Mar 2026 17:25:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774333537;
	cv=none; b=boXo8jKMvyi5FoKnE0++omDWBJVs3xQFTUwl6IG0o7Ouq+5GplQ93twIG7eGKQAWzhtTjZ9Uecl8JiE+UQ3f8BUkir71nUkFCg3qKVGAXq3piAkGU2KQvvwFcSLJ7egNZV100Fh6CQYZ9ylsBpgtSHi4FNpHUJXTesKMTYe4Pj0gIZiFFw+pcqNzaLmwtHDI2ZMp6en4IGAUuVxmxWw5NTGQ9qJol+f0adxGXQSYdVa6/Zna6jiGFr0qJYf611rWbYRzQfTc51V3d5D6WIvOp5SMJqPKrd6/7LEeOUJo4n4tOJgtKL9Ci2hMqULah63z1QX8cXUdP1wXVl1gQmyB2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774333537; c=relaxed/relaxed;
	bh=VU1JeGqI6k2uvXecj1efLpuQZv7vmGIDPw6I2na0LZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GTjX6Ln/NRFf9J9S8GSa6g7NIx8VEUf+1g7CnWrGN22ANRAK4sQZ+gd7R4aUlkrNq7LggVBmDdV8KBYe+K5SN2xk3gd+EUZsoqXBVG0uTFYGN0D0MkxvHDLmC1vBuYckfAVbF1qhHnraJENdsPyg/vk7r2Tx84xg+czJKzlrAHj7pf4uLJFqBqUs3LwtCh2Vjk63RkI/r1H4Hz3K35peNTQ+LPt8knsmJxT0dnPFuaTRIAjH4Jm/9ziyIMIn9DPAB7Q+Ni0pv7lBodCP27jlJpGIuolK93X9oyPVY79oUgMWIADuAdhkIfsfTbL2oIqkmfZHupro6X3LJYF/EanlWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LEPFFP3f; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+4a75e1166b7f241dd976+8248+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LEPFFP3f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+4a75e1166b7f241dd976+8248+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fg0Qm4gKLz2yrS
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2026 17:25:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=VU1JeGqI6k2uvXecj1efLpuQZv7vmGIDPw6I2na0LZU=; b=LEPFFP3fYdoQ8w3FZKWejbNL7a
	EWDnxdd9WOmGjYUsEb4xrhIIaNu4yuLOE3qx4Yi8yw3mMNY7aXFcFtO3dpwhgpNA+DMI1za9G6UCz
	V+rSYEeWsP9m3UHSDic1YNWALj8UR/gu5a/P8sYOj5cYNh4qH9OqAd5v3DO07eGur45cBKqmLrPLj
	UCHgewpQAa35B/fizbizbBvTNUyza/beSd2iCbibScmLYfdXK83QJ3TvbPrXh3HBuhEoy6blZF86O
	iBS0e9uIgbLnH21b7f8u9FSeiLC0F9HtnE65tClXpni4B1qpyRAYAZzA+fY+2mLfZBqDpzHk0HZRo
	zwWcjriQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4vCb-00000000iIN-131R;
	Tue, 24 Mar 2026 06:25:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
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
Subject: [PATCH 14/26] powerpc: move the XOR code to lib/raid/
Date: Tue, 24 Mar 2026 07:21:50 +0100
Message-ID: <20260324062211.3216301-15-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260324062211.3216301-1-hch@lst.de>
References: <20260324062211.3216301-1-hch@lst.de>
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
 arch/powerpc/include/asm/xor.h                | 17 +----
 arch/powerpc/include/asm/xor_altivec.h        | 22 ------
 arch/powerpc/lib/Makefile                     |  5 --
 arch/powerpc/lib/xor_vmx_glue.c               | 63 -----------------
 lib/raid/xor/Makefile                         |  5 ++
 .../lib => lib/raid/xor/powerpc}/xor_vmx.c    |  0
 .../lib => lib/raid/xor/powerpc}/xor_vmx.h    |  0
 lib/raid/xor/powerpc/xor_vmx_glue.c           | 67 +++++++++++++++++++
 8 files changed, 74 insertions(+), 105 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/xor_altivec.h
 delete mode 100644 arch/powerpc/lib/xor_vmx_glue.c
 rename {arch/powerpc/lib => lib/raid/xor/powerpc}/xor_vmx.c (100%)
 rename {arch/powerpc/lib => lib/raid/xor/powerpc}/xor_vmx.h (100%)
 create mode 100644 lib/raid/xor/powerpc/xor_vmx_glue.c

diff --git a/arch/powerpc/include/asm/xor.h b/arch/powerpc/include/asm/xor.h
index 30224c5279c4..3293ac87181c 100644
--- a/arch/powerpc/include/asm/xor.h
+++ b/arch/powerpc/include/asm/xor.h
@@ -8,24 +8,11 @@
 #ifndef _ASM_POWERPC_XOR_H
 #define _ASM_POWERPC_XOR_H
 
-#ifdef CONFIG_ALTIVEC
-
-#include <asm/cputable.h>
 #include <asm/cpu_has_feature.h>
-#include <asm/xor_altivec.h>
-
-static struct xor_block_template xor_block_altivec = {
-	.name = "altivec",
-	.do_2 = xor_altivec_2,
-	.do_3 = xor_altivec_3,
-	.do_4 = xor_altivec_4,
-	.do_5 = xor_altivec_5,
-};
-#endif /* CONFIG_ALTIVEC */
-
-/* Also try the generic routines. */
 #include <asm-generic/xor.h>
 
+extern struct xor_block_template xor_block_altivec;
+
 #define arch_xor_init arch_xor_init
 static __always_inline void __init arch_xor_init(void)
 {
diff --git a/arch/powerpc/include/asm/xor_altivec.h b/arch/powerpc/include/asm/xor_altivec.h
deleted file mode 100644
index 294620a25f80..000000000000
--- a/arch/powerpc/include/asm/xor_altivec.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_POWERPC_XOR_ALTIVEC_H
-#define _ASM_POWERPC_XOR_ALTIVEC_H
-
-#ifdef CONFIG_ALTIVEC
-void xor_altivec_2(unsigned long bytes, unsigned long * __restrict p1,
-		   const unsigned long * __restrict p2);
-void xor_altivec_3(unsigned long bytes, unsigned long * __restrict p1,
-		   const unsigned long * __restrict p2,
-		   const unsigned long * __restrict p3);
-void xor_altivec_4(unsigned long bytes, unsigned long * __restrict p1,
-		   const unsigned long * __restrict p2,
-		   const unsigned long * __restrict p3,
-		   const unsigned long * __restrict p4);
-void xor_altivec_5(unsigned long bytes, unsigned long * __restrict p1,
-		   const unsigned long * __restrict p2,
-		   const unsigned long * __restrict p3,
-		   const unsigned long * __restrict p4,
-		   const unsigned long * __restrict p5);
-
-#endif
-#endif /* _ASM_POWERPC_XOR_ALTIVEC_H */
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index f14ecab674a3..002edc3f01d5 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -73,9 +73,4 @@ obj-$(CONFIG_PPC_LIB_RHEAP) += rheap.o
 
 obj-$(CONFIG_FTR_FIXUP_SELFTEST) += feature-fixups-test.o
 
-obj-$(CONFIG_ALTIVEC)	+= xor_vmx.o xor_vmx_glue.o
-CFLAGS_xor_vmx.o += -mhard-float -maltivec $(call cc-option,-mabi=altivec)
-# Enable <altivec.h>
-CFLAGS_xor_vmx.o += -isystem $(shell $(CC) -print-file-name=include)
-
 obj-$(CONFIG_PPC64) += $(obj64-y)
diff --git a/arch/powerpc/lib/xor_vmx_glue.c b/arch/powerpc/lib/xor_vmx_glue.c
deleted file mode 100644
index 35d917ece4d1..000000000000
--- a/arch/powerpc/lib/xor_vmx_glue.c
+++ /dev/null
@@ -1,63 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Altivec XOR operations
- *
- * Copyright 2017 IBM Corp.
- */
-
-#include <linux/preempt.h>
-#include <linux/export.h>
-#include <linux/sched.h>
-#include <asm/switch_to.h>
-#include <asm/xor_altivec.h>
-#include "xor_vmx.h"
-
-void xor_altivec_2(unsigned long bytes, unsigned long * __restrict p1,
-		   const unsigned long * __restrict p2)
-{
-	preempt_disable();
-	enable_kernel_altivec();
-	__xor_altivec_2(bytes, p1, p2);
-	disable_kernel_altivec();
-	preempt_enable();
-}
-EXPORT_SYMBOL(xor_altivec_2);
-
-void xor_altivec_3(unsigned long bytes, unsigned long * __restrict p1,
-		   const unsigned long * __restrict p2,
-		   const unsigned long * __restrict p3)
-{
-	preempt_disable();
-	enable_kernel_altivec();
-	__xor_altivec_3(bytes, p1, p2, p3);
-	disable_kernel_altivec();
-	preempt_enable();
-}
-EXPORT_SYMBOL(xor_altivec_3);
-
-void xor_altivec_4(unsigned long bytes, unsigned long * __restrict p1,
-		   const unsigned long * __restrict p2,
-		   const unsigned long * __restrict p3,
-		   const unsigned long * __restrict p4)
-{
-	preempt_disable();
-	enable_kernel_altivec();
-	__xor_altivec_4(bytes, p1, p2, p3, p4);
-	disable_kernel_altivec();
-	preempt_enable();
-}
-EXPORT_SYMBOL(xor_altivec_4);
-
-void xor_altivec_5(unsigned long bytes, unsigned long * __restrict p1,
-		   const unsigned long * __restrict p2,
-		   const unsigned long * __restrict p3,
-		   const unsigned long * __restrict p4,
-		   const unsigned long * __restrict p5)
-{
-	preempt_disable();
-	enable_kernel_altivec();
-	__xor_altivec_5(bytes, p1, p2, p3, p4, p5);
-	disable_kernel_altivec();
-	preempt_enable();
-}
-EXPORT_SYMBOL(xor_altivec_5);
diff --git a/lib/raid/xor/Makefile b/lib/raid/xor/Makefile
index e8868f5fc396..006b44ce46bf 100644
--- a/lib/raid/xor/Makefile
+++ b/lib/raid/xor/Makefile
@@ -16,6 +16,7 @@ endif
 xor-$(CONFIG_ARM64)		+= arm64/xor-neon.o arm64/xor-neon-glue.o
 xor-$(CONFIG_CPU_HAS_LSX)	+= loongarch/xor_simd.o
 xor-$(CONFIG_CPU_HAS_LSX)	+= loongarch/xor_simd_glue.o
+xor-$(CONFIG_ALTIVEC)		+= powerpc/xor_vmx.o powerpc/xor_vmx_glue.o
 
 
 CFLAGS_arm/xor-neon.o		+= $(CC_FLAGS_FPU)
@@ -23,3 +24,7 @@ CFLAGS_REMOVE_arm/xor-neon.o	+= $(CC_FLAGS_NO_FPU)
 
 CFLAGS_arm64/xor-neon.o		+= $(CC_FLAGS_FPU)
 CFLAGS_REMOVE_arm64/xor-neon.o	+= $(CC_FLAGS_NO_FPU)
+
+CFLAGS_powerpc/xor_vmx.o	+= -mhard-float -maltivec \
+				   $(call cc-option,-mabi=altivec) \
+				   -isystem $(shell $(CC) -print-file-name=include)
diff --git a/arch/powerpc/lib/xor_vmx.c b/lib/raid/xor/powerpc/xor_vmx.c
similarity index 100%
rename from arch/powerpc/lib/xor_vmx.c
rename to lib/raid/xor/powerpc/xor_vmx.c
diff --git a/arch/powerpc/lib/xor_vmx.h b/lib/raid/xor/powerpc/xor_vmx.h
similarity index 100%
rename from arch/powerpc/lib/xor_vmx.h
rename to lib/raid/xor/powerpc/xor_vmx.h
diff --git a/lib/raid/xor/powerpc/xor_vmx_glue.c b/lib/raid/xor/powerpc/xor_vmx_glue.c
new file mode 100644
index 000000000000..c41e38340700
--- /dev/null
+++ b/lib/raid/xor/powerpc/xor_vmx_glue.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Altivec XOR operations
+ *
+ * Copyright 2017 IBM Corp.
+ */
+
+#include <linux/preempt.h>
+#include <linux/sched.h>
+#include <linux/raid/xor_impl.h>
+#include <asm/switch_to.h>
+#include <asm/xor.h>
+#include "xor_vmx.h"
+
+static void xor_altivec_2(unsigned long bytes, unsigned long * __restrict p1,
+		const unsigned long * __restrict p2)
+{
+	preempt_disable();
+	enable_kernel_altivec();
+	__xor_altivec_2(bytes, p1, p2);
+	disable_kernel_altivec();
+	preempt_enable();
+}
+
+static void xor_altivec_3(unsigned long bytes, unsigned long * __restrict p1,
+		const unsigned long * __restrict p2,
+		const unsigned long * __restrict p3)
+{
+	preempt_disable();
+	enable_kernel_altivec();
+	__xor_altivec_3(bytes, p1, p2, p3);
+	disable_kernel_altivec();
+	preempt_enable();
+}
+
+static void xor_altivec_4(unsigned long bytes, unsigned long * __restrict p1,
+		const unsigned long * __restrict p2,
+		const unsigned long * __restrict p3,
+		const unsigned long * __restrict p4)
+{
+	preempt_disable();
+	enable_kernel_altivec();
+	__xor_altivec_4(bytes, p1, p2, p3, p4);
+	disable_kernel_altivec();
+	preempt_enable();
+}
+
+static void xor_altivec_5(unsigned long bytes, unsigned long * __restrict p1,
+		const unsigned long * __restrict p2,
+		const unsigned long * __restrict p3,
+		const unsigned long * __restrict p4,
+		const unsigned long * __restrict p5)
+{
+	preempt_disable();
+	enable_kernel_altivec();
+	__xor_altivec_5(bytes, p1, p2, p3, p4, p5);
+	disable_kernel_altivec();
+	preempt_enable();
+}
+
+struct xor_block_template xor_block_altivec = {
+	.name = "altivec",
+	.do_2 = xor_altivec_2,
+	.do_3 = xor_altivec_3,
+	.do_4 = xor_altivec_4,
+	.do_5 = xor_altivec_5,
+};
-- 
2.47.3


