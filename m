Return-Path: <linuxppc-dev+bounces-18023-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 632C8FD0636
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 07:07:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fW1zG6FN8z3cYr;
	Wed, 11 Mar 2026 18:07:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773212858;
	cv=none; b=eKAs7Z5PkSK3Pz1Elfh9pJmS2dmtSScAi4vOCV8t4bNolwqsoswTwfqHfnk9q0d5NH2bE4taWigPulmz0faHAuAwffX6zpk4/hOiI3VL6Z6cDh0dnhQ3lRVzaNCDakiiqO2oNFjuFn3yhBFjQI3BvVO0KB5VNcVDWD7y2I8yT/KS9kx3O2lQoPfT9KwHfg4NDbvG3msLOkMGiaJt7prRay71evBf9OjBTW13zDX6d+XEfR9Coli6Kw1nrdnBWYdFkUSY9ORqdfSu7VtFWBw9JSA60HhGbTgHExXq0FWBJyhAILllTOIaGnFY50tefDPFY8/CdEorwl2dlcJb9GhTAw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773212858; c=relaxed/relaxed;
	bh=I1Ub7Hte/Np1q182yrLgNqluUCECn8bi2CkuD6XTYeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ipfhyFJP8YuKflTSCJTSQHqFAldLV2xkCr12Zbq9prkLLDiUXQF++Xq/NEvoYVNEypaZGNgO9URhGRo2aZsTOpRGxoLV+V3sVtGYhFKGoi5RLktY1Jqv9qUMEPqky77g3k9F8jEXFEV+iegYNkpmqzDREgoNGCJvWfv0lhGyTBwJNeZWrGpxHpc9PtyCi5OzR+3ovyjODNt+mntrDqc5UQGSR/aCjbMGvtcfhjNTaMntlocJTMmhflfEOdbktyEP95hr3vusJ47v08fc4y6GRkRFZLSw3FSpYLVpjFUB2DanMHE5JKt6wwqc5my9YBnG5KPc7KtJj2ALUTAXOHhqOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YKvfn8+L; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+bcc67bb7b2d0717eac20+8235+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YKvfn8+L;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+bcc67bb7b2d0717eac20+8235+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fW1zG2TbXz3cYq
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 18:07:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=I1Ub7Hte/Np1q182yrLgNqluUCECn8bi2CkuD6XTYeI=; b=YKvfn8+LLvUXwGM+RZl+iO3Rpm
	430masEBely5FvOzdMkxvq25TOEXWDoYOiwPrOTuRv36XHt3DgZgwmmbBe58ylySpQI4Nf07H7N7v
	tDgZmK9jPkFkusrzv7Ko3aOjrg9q3susTvrIgonntOn3HJWFpLfwt1PV5E45X3EWVU505XvqaaVLy
	qnxxO+VrRxeNUEe/6jW6bwh+FvL7gLn7BESgmY9RSWUU5bSbOF3JOuaSu/lf7xJDMGXyNcZMCC8wN
	mR0SSPqGHZDimUqv99GLW/g3ew1e2txFV9vgoos9LGHiobhJHoiUAKi8mPmeeSGmwi9uilENIbIvD
	3oXY9+Bg==;
Received: from [212.243.42.10] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0Df6-0000000AzUM-17C3;
	Wed, 11 Mar 2026 07:07:20 +0000
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
Subject: [PATCH 12/27] arm64: move the XOR code to lib/raid/
Date: Wed, 11 Mar 2026 08:03:44 +0100
Message-ID: <20260311070416.972667-13-hch@lst.de>
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
 arch/arm64/include/asm/xor.h                  | 58 +------------------
 arch/arm64/lib/Makefile                       |  6 --
 lib/raid/xor/Makefile                         |  5 ++
 lib/raid/xor/arm64/xor-neon-glue.c            | 57 ++++++++++++++++++
 .../lib => lib/raid/xor/arm64}/xor-neon.c     | 20 +------
 5 files changed, 68 insertions(+), 78 deletions(-)
 create mode 100644 lib/raid/xor/arm64/xor-neon-glue.c
 rename {arch/arm64/lib => lib/raid/xor/arm64}/xor-neon.c (95%)

diff --git a/arch/arm64/include/asm/xor.h b/arch/arm64/include/asm/xor.h
index bfa6122f55ce..81718f010761 100644
--- a/arch/arm64/include/asm/xor.h
+++ b/arch/arm64/include/asm/xor.h
@@ -1,73 +1,21 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * arch/arm64/include/asm/xor.h
- *
  * Authors: Jackie Liu <liuyun01@kylinos.cn>
  * Copyright (C) 2018,Tianjin KYLIN Information Technology Co., Ltd.
  */
 
-#include <linux/hardirq.h>
 #include <asm-generic/xor.h>
-#include <asm/hwcap.h>
 #include <asm/simd.h>
 
-#ifdef CONFIG_KERNEL_MODE_NEON
-
-extern struct xor_block_template const xor_block_inner_neon;
-
-static void
-xor_neon_2(unsigned long bytes, unsigned long * __restrict p1,
-	   const unsigned long * __restrict p2)
-{
-	scoped_ksimd()
-		xor_block_inner_neon.do_2(bytes, p1, p2);
-}
-
-static void
-xor_neon_3(unsigned long bytes, unsigned long * __restrict p1,
-	   const unsigned long * __restrict p2,
-	   const unsigned long * __restrict p3)
-{
-	scoped_ksimd()
-		xor_block_inner_neon.do_3(bytes, p1, p2, p3);
-}
-
-static void
-xor_neon_4(unsigned long bytes, unsigned long * __restrict p1,
-	   const unsigned long * __restrict p2,
-	   const unsigned long * __restrict p3,
-	   const unsigned long * __restrict p4)
-{
-	scoped_ksimd()
-		xor_block_inner_neon.do_4(bytes, p1, p2, p3, p4);
-}
-
-static void
-xor_neon_5(unsigned long bytes, unsigned long * __restrict p1,
-	   const unsigned long * __restrict p2,
-	   const unsigned long * __restrict p3,
-	   const unsigned long * __restrict p4,
-	   const unsigned long * __restrict p5)
-{
-	scoped_ksimd()
-		xor_block_inner_neon.do_5(bytes, p1, p2, p3, p4, p5);
-}
-
-static struct xor_block_template xor_block_arm64 = {
-	.name   = "arm64_neon",
-	.do_2   = xor_neon_2,
-	.do_3   = xor_neon_3,
-	.do_4   = xor_neon_4,
-	.do_5	= xor_neon_5
-};
+extern struct xor_block_template xor_block_arm64;
+void __init xor_neon_init(void);
 
 #define arch_xor_init arch_xor_init
 static __always_inline void __init arch_xor_init(void)
 {
+	xor_neon_init();
 	xor_register(&xor_block_8regs);
 	xor_register(&xor_block_32regs);
 	if (cpu_has_neon())
 		xor_register(&xor_block_arm64);
 }
-
-#endif /* ! CONFIG_KERNEL_MODE_NEON */
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index 633e5223d944..448c917494f3 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -5,12 +5,6 @@ lib-y		:= clear_user.o delay.o copy_from_user.o		\
 		   memset.o memcmp.o strcmp.o strncmp.o strlen.o	\
 		   strnlen.o strchr.o strrchr.o tishift.o
 
-ifeq ($(CONFIG_KERNEL_MODE_NEON), y)
-obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
-CFLAGS_xor-neon.o		+= $(CC_FLAGS_FPU)
-CFLAGS_REMOVE_xor-neon.o	+= $(CC_FLAGS_NO_FPU)
-endif
-
 lib-$(CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE) += uaccess_flushcache.o
 
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
diff --git a/lib/raid/xor/Makefile b/lib/raid/xor/Makefile
index fb760edae54b..3c13851219e5 100644
--- a/lib/raid/xor/Makefile
+++ b/lib/raid/xor/Makefile
@@ -12,8 +12,13 @@ xor-$(CONFIG_ALPHA)		+= alpha/xor.o
 xor-$(CONFIG_ARM)		+= arm/xor.o
 ifeq ($(CONFIG_ARM),y)
 xor-$(CONFIG_KERNEL_MODE_NEON)	+= arm/xor-neon.o arm/xor-neon-glue.o
+else
+xor-$(CONFIG_KERNEL_MODE_NEON)	+= arm64/xor-neon.o arm64/xor-neon-glue.o
 endif
 
 
 CFLAGS_arm/xor-neon.o		+= $(CC_FLAGS_FPU)
 CFLAGS_REMOVE_arm/xor-neon.o	+= $(CC_FLAGS_NO_FPU)
+
+CFLAGS_arm64/xor-neon.o		+= $(CC_FLAGS_FPU)
+CFLAGS_REMOVE_arm64/xor-neon.o	+= $(CC_FLAGS_NO_FPU)
diff --git a/lib/raid/xor/arm64/xor-neon-glue.c b/lib/raid/xor/arm64/xor-neon-glue.c
new file mode 100644
index 000000000000..067a2095659a
--- /dev/null
+++ b/lib/raid/xor/arm64/xor-neon-glue.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Authors: Jackie Liu <liuyun01@kylinos.cn>
+ * Copyright (C) 2018,Tianjin KYLIN Information Technology Co., Ltd.
+ */
+
+#include <linux/raid/xor_impl.h>
+#include <asm/simd.h>
+#include <asm/xor.h>
+
+extern struct xor_block_template const xor_block_inner_neon;
+
+static void
+xor_neon_2(unsigned long bytes, unsigned long * __restrict p1,
+	   const unsigned long * __restrict p2)
+{
+	scoped_ksimd()
+		xor_block_inner_neon.do_2(bytes, p1, p2);
+}
+
+static void
+xor_neon_3(unsigned long bytes, unsigned long * __restrict p1,
+	   const unsigned long * __restrict p2,
+	   const unsigned long * __restrict p3)
+{
+	scoped_ksimd()
+		xor_block_inner_neon.do_3(bytes, p1, p2, p3);
+}
+
+static void
+xor_neon_4(unsigned long bytes, unsigned long * __restrict p1,
+	   const unsigned long * __restrict p2,
+	   const unsigned long * __restrict p3,
+	   const unsigned long * __restrict p4)
+{
+	scoped_ksimd()
+		xor_block_inner_neon.do_4(bytes, p1, p2, p3, p4);
+}
+
+static void
+xor_neon_5(unsigned long bytes, unsigned long * __restrict p1,
+	   const unsigned long * __restrict p2,
+	   const unsigned long * __restrict p3,
+	   const unsigned long * __restrict p4,
+	   const unsigned long * __restrict p5)
+{
+	scoped_ksimd()
+		xor_block_inner_neon.do_5(bytes, p1, p2, p3, p4, p5);
+}
+
+struct xor_block_template xor_block_arm64 = {
+	.name   = "arm64_neon",
+	.do_2   = xor_neon_2,
+	.do_3   = xor_neon_3,
+	.do_4   = xor_neon_4,
+	.do_5	= xor_neon_5
+};
diff --git a/arch/arm64/lib/xor-neon.c b/lib/raid/xor/arm64/xor-neon.c
similarity index 95%
rename from arch/arm64/lib/xor-neon.c
rename to lib/raid/xor/arm64/xor-neon.c
index 351aba92d932..8d2d185090db 100644
--- a/arch/arm64/lib/xor-neon.c
+++ b/lib/raid/xor/arm64/xor-neon.c
@@ -1,15 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * arch/arm64/lib/xor-neon.c
- *
  * Authors: Jackie Liu <liuyun01@kylinos.cn>
  * Copyright (C) 2018,Tianjin KYLIN Information Technology Co., Ltd.
  */
 
-#include <linux/raid/xor.h>
 #include <linux/raid/xor_impl.h>
-#include <linux/module.h>
+#include <linux/cache.h>
 #include <asm/neon-intrinsics.h>
+#include <asm/xor.h>
 
 static void xor_arm64_neon_2(unsigned long bytes, unsigned long * __restrict p1,
 	const unsigned long * __restrict p2)
@@ -180,7 +178,6 @@ struct xor_block_template xor_block_inner_neon __ro_after_init = {
 	.do_4	= xor_arm64_neon_4,
 	.do_5	= xor_arm64_neon_5,
 };
-EXPORT_SYMBOL(xor_block_inner_neon);
 
 static inline uint64x2_t eor3(uint64x2_t p, uint64x2_t q, uint64x2_t r)
 {
@@ -318,22 +315,11 @@ static void xor_arm64_eor3_5(unsigned long bytes,
 	} while (--lines > 0);
 }
 
-static int __init xor_neon_init(void)
+void __init xor_neon_init(void)
 {
 	if (cpu_have_named_feature(SHA3)) {
 		xor_block_inner_neon.do_3 = xor_arm64_eor3_3;
 		xor_block_inner_neon.do_4 = xor_arm64_eor3_4;
 		xor_block_inner_neon.do_5 = xor_arm64_eor3_5;
 	}
-	return 0;
 }
-module_init(xor_neon_init);
-
-static void __exit xor_neon_exit(void)
-{
-}
-module_exit(xor_neon_exit);
-
-MODULE_AUTHOR("Jackie Liu <liuyun01@kylinos.cn>");
-MODULE_DESCRIPTION("ARMv8 XOR Extensions");
-MODULE_LICENSE("GPL");
-- 
2.47.3


