Return-Path: <linuxppc-dev+bounces-18887-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5AA410BA432
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 06:21:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhrBw42MGz3bl5;
	Fri, 27 Mar 2026 17:21:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774592504;
	cv=none; b=D3Ea7aCFbPNLw2BEsGq2XC/2hd7u0khaTEbawCwvFKt5h9a/LttEC6zBEy55E/WqY9yYPb/0aNdL7c6CPxz+zE/UeXdychQKu8x2N3kRyx8FZxYxTc3wILqRggEnXhJBrA1PrJNvo2ddYMt7dGpihx3ZpN5/nhfRD2mMc5f8vr5BcBgJ5YqW92e9PBRrGUZsobnAXHsaimNW3f++BpPr1nxH7KbF/4vf1KyT9hVAG4bnWVBAaGyB/RyHwzqX3bzTZk0yhrwIRHoQPotPLjA3IviP1+COzoF6jiAMZEZgpj9oHGhCFLIA4ZLfW0WG20HlCUtNWhuZqJ1gk4+PmMjAxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774592504; c=relaxed/relaxed;
	bh=TEJqE0da2sBbiONNO3v6zKUvRiCT9+M3qH0kneUzSyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbKb/tlzSFcjfJ3+1GOgGqCi0BGghHmApU9cGiJyfMeiCpY1rCGsYE3ber+LvCwDii0qjnHmDEIIjkRW0j3yi9vwm0mq76Lhqhbzw7uWDfZwMHcHKfsPAbSFxFQgL5zT81J/Lj8tyYSCbI4y7QeE7OkqHmNA4lcTrl6QCgrdCu1qmcbXXG7cAGg61fH7FFSWjrSxJ130k1a3xzMOjr2lTd5QtYGDVjmxvasqwP5ODuuTCEBkx5a/fJfLst3pvEAlQ8lopCY0f5bdJncX8Vo325fAC60gjL76lWd8CFOYfbmVuttiIa/IY8TEmzzelASmcxsokNJCpbYIxCzaoLLxLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DtPuA1Bk; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+7b1de7ca9b09bfe890a7+8251+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DtPuA1Bk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+7b1de7ca9b09bfe890a7+8251+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhrBv75SDz3bl1
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 17:21:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=TEJqE0da2sBbiONNO3v6zKUvRiCT9+M3qH0kneUzSyM=; b=DtPuA1BkAVwRXGe+Pj26N9PA85
	+pRBTHkvDAgjUvlypy7ToqbgMEIS/ajNfQum6QU7A2FyaCxwX9TDElnC4sr8AJWDDVrTGvdqBU4GA
	arF+bI7n6E67DnhDPLjf6rNSaqTv1vu/ev9dT0PVytzn4Fu1naa7M/wYNhCdMaSmHEVIeFkNThZbE
	cdaNnBPFtSYGJHxU9IQ4sGSvJEkatGzwkwnvNA5wUDCyjtQ3geQST38YiGncsAxkVmbJvOypEobuz
	LckB0Of79cDRpm94lLB9oI9heWkXQj/FDWwpt3AwKJRG9Xh3eg13sJx6CE73D1c9k6a7sdTUlu/Bk
	E65grkew==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w60ZS-00000006mmn-2zgc;
	Fri, 27 Mar 2026 06:21:27 +0000
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
Subject: [PATCH 17/28] sparc: move the XOR code to lib/raid/
Date: Fri, 27 Mar 2026 07:16:49 +0100
Message-ID: <20260327061704.3707577-18-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327061704.3707577-1-hch@lst.de>
References: <20260327061704.3707577-1-hch@lst.de>
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

The code should probably be split into separate files for the two
implementations, but for now this just does the trivial move.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sparc/include/asm/asm-prototypes.h       |  1 -
 arch/sparc/include/asm/xor.h                  | 45 ++++++++++++++++---
 arch/sparc/lib/Makefile                       |  2 +-
 lib/raid/xor/Makefile                         |  2 +
 .../raid/xor/sparc/xor-sparc32.c              | 23 ++--------
 .../raid/xor/sparc/xor-sparc64-glue.c         | 26 +++--------
 .../xor.S => lib/raid/xor/sparc/xor-sparc64.S | 10 -----
 7 files changed, 52 insertions(+), 57 deletions(-)
 rename arch/sparc/include/asm/xor_32.h => lib/raid/xor/sparc/xor-sparc32.c (93%)
 rename arch/sparc/include/asm/xor_64.h => lib/raid/xor/sparc/xor-sparc64-glue.c (74%)
 rename arch/sparc/lib/xor.S => lib/raid/xor/sparc/xor-sparc64.S (98%)

diff --git a/arch/sparc/include/asm/asm-prototypes.h b/arch/sparc/include/asm/asm-prototypes.h
index 08810808ca6d..bbd1a8afaabf 100644
--- a/arch/sparc/include/asm/asm-prototypes.h
+++ b/arch/sparc/include/asm/asm-prototypes.h
@@ -14,7 +14,6 @@
 #include <asm/oplib.h>
 #include <asm/pgtable.h>
 #include <asm/trap_block.h>
-#include <asm/xor.h>
 
 void *__memscan_zero(void *, size_t);
 void *__memscan_generic(void *, int, size_t);
diff --git a/arch/sparc/include/asm/xor.h b/arch/sparc/include/asm/xor.h
index f4c651e203c4..f923b009fc24 100644
--- a/arch/sparc/include/asm/xor.h
+++ b/arch/sparc/include/asm/xor.h
@@ -1,9 +1,44 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 1997, 1999 Jakub Jelinek (jj@ultra.linux.cz)
+ * Copyright (C) 2006 David S. Miller <davem@davemloft.net>
+ */
 #ifndef ___ASM_SPARC_XOR_H
 #define ___ASM_SPARC_XOR_H
+
 #if defined(__sparc__) && defined(__arch64__)
-#include <asm/xor_64.h>
-#else
-#include <asm/xor_32.h>
-#endif
-#endif
+#include <asm/spitfire.h>
+
+extern struct xor_block_template xor_block_VIS;
+extern struct xor_block_template xor_block_niagara;
+
+#define arch_xor_init arch_xor_init
+static __always_inline void __init arch_xor_init(void)
+{
+	/* Force VIS for everything except Niagara.  */
+	if (tlb_type == hypervisor &&
+	    (sun4v_chip_type == SUN4V_CHIP_NIAGARA1 ||
+	     sun4v_chip_type == SUN4V_CHIP_NIAGARA2 ||
+	     sun4v_chip_type == SUN4V_CHIP_NIAGARA3 ||
+	     sun4v_chip_type == SUN4V_CHIP_NIAGARA4 ||
+	     sun4v_chip_type == SUN4V_CHIP_NIAGARA5))
+		xor_force(&xor_block_niagara);
+	else
+		xor_force(&xor_block_VIS);
+}
+#else /* sparc64 */
+
+/* For grins, also test the generic routines.  */
+#include <asm-generic/xor.h>
+
+extern struct xor_block_template xor_block_SPARC;
+
+#define arch_xor_init arch_xor_init
+static __always_inline void __init arch_xor_init(void)
+{
+	xor_register(&xor_block_8regs);
+	xor_register(&xor_block_32regs);
+	xor_register(&xor_block_SPARC);
+}
+#endif /* !sparc64 */
+#endif /* ___ASM_SPARC_XOR_H */
diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index 783bdec0d7be..dd10cdd6f062 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -48,7 +48,7 @@ lib-$(CONFIG_SPARC64) += GENmemcpy.o GENcopy_from_user.o GENcopy_to_user.o
 lib-$(CONFIG_SPARC64) += GENpatch.o GENpage.o GENbzero.o
 
 lib-$(CONFIG_SPARC64) += copy_in_user.o memmove.o
-lib-$(CONFIG_SPARC64) += mcount.o ipcsum.o xor.o hweight.o ffs.o
+lib-$(CONFIG_SPARC64) += mcount.o ipcsum.o hweight.o ffs.o
 
 obj-$(CONFIG_SPARC64) += iomap.o
 obj-$(CONFIG_SPARC32) += atomic32.o
diff --git a/lib/raid/xor/Makefile b/lib/raid/xor/Makefile
index 9e729b50e775..3a7c887d08ee 100644
--- a/lib/raid/xor/Makefile
+++ b/lib/raid/xor/Makefile
@@ -18,6 +18,8 @@ xor-$(CONFIG_CPU_HAS_LSX)	+= loongarch/xor_simd.o
 xor-$(CONFIG_CPU_HAS_LSX)	+= loongarch/xor_simd_glue.o
 xor-$(CONFIG_ALTIVEC)		+= powerpc/xor_vmx.o powerpc/xor_vmx_glue.o
 xor-$(CONFIG_RISCV_ISA_V)	+= riscv/xor.o riscv/xor-glue.o
+xor-$(CONFIG_SPARC32)		+= sparc/xor-sparc32.o
+xor-$(CONFIG_SPARC64)		+= sparc/xor-sparc64.o sparc/xor-sparc64-glue.o
 
 
 CFLAGS_arm/xor-neon.o		+= $(CC_FLAGS_FPU)
diff --git a/arch/sparc/include/asm/xor_32.h b/lib/raid/xor/sparc/xor-sparc32.c
similarity index 93%
rename from arch/sparc/include/asm/xor_32.h
rename to lib/raid/xor/sparc/xor-sparc32.c
index 8fbf0c07ec28..b65a75a6e59d 100644
--- a/arch/sparc/include/asm/xor_32.h
+++ b/lib/raid/xor/sparc/xor-sparc32.c
@@ -1,16 +1,12 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * include/asm/xor.h
- *
- * Optimized RAID-5 checksumming functions for 32-bit Sparc.
- */
-
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * High speed xor_block operation for RAID4/5 utilizing the
  * ldd/std SPARC instructions.
  *
  * Copyright (C) 1999 Jakub Jelinek (jj@ultra.linux.cz)
  */
+#include <linux/raid/xor_impl.h>
+#include <asm/xor.h>
 
 static void
 sparc_2(unsigned long bytes, unsigned long * __restrict p1,
@@ -248,21 +244,10 @@ sparc_5(unsigned long bytes, unsigned long * __restrict p1,
 	} while (--lines > 0);
 }
 
-static struct xor_block_template xor_block_SPARC = {
+struct xor_block_template xor_block_SPARC = {
 	.name	= "SPARC",
 	.do_2	= sparc_2,
 	.do_3	= sparc_3,
 	.do_4	= sparc_4,
 	.do_5	= sparc_5,
 };
-
-/* For grins, also test the generic routines.  */
-#include <asm-generic/xor.h>
-
-#define arch_xor_init arch_xor_init
-static __always_inline void __init arch_xor_init(void)
-{
-	xor_register(&xor_block_8regs);
-	xor_register(&xor_block_32regs);
-	xor_register(&xor_block_SPARC);
-}
diff --git a/arch/sparc/include/asm/xor_64.h b/lib/raid/xor/sparc/xor-sparc64-glue.c
similarity index 74%
rename from arch/sparc/include/asm/xor_64.h
rename to lib/raid/xor/sparc/xor-sparc64-glue.c
index e0482ecc0a68..3c67c8c3a0e8 100644
--- a/arch/sparc/include/asm/xor_64.h
+++ b/lib/raid/xor/sparc/xor-sparc64-glue.c
@@ -1,7 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * include/asm/xor.h
- *
  * High speed xor_block operation for RAID4/5 utilizing the
  * UltraSparc Visual Instruction Set and Niagara block-init
  * twin-load instructions.
@@ -10,7 +8,8 @@
  * Copyright (C) 2006 David S. Miller <davem@davemloft.net>
  */
 
-#include <asm/spitfire.h>
+#include <linux/raid/xor_impl.h>
+#include <asm/xor.h>
 
 void xor_vis_2(unsigned long bytes, unsigned long * __restrict p1,
 	       const unsigned long * __restrict p2);
@@ -29,7 +28,7 @@ void xor_vis_5(unsigned long bytes, unsigned long * __restrict p1,
 
 /* XXX Ugh, write cheetah versions... -DaveM */
 
-static struct xor_block_template xor_block_VIS = {
+struct xor_block_template xor_block_VIS = {
         .name	= "VIS",
         .do_2	= xor_vis_2,
         .do_3	= xor_vis_3,
@@ -52,25 +51,10 @@ void xor_niagara_5(unsigned long bytes, unsigned long * __restrict p1,
 		   const unsigned long * __restrict p4,
 		   const unsigned long * __restrict p5);
 
-static struct xor_block_template xor_block_niagara = {
+struct xor_block_template xor_block_niagara = {
         .name	= "Niagara",
         .do_2	= xor_niagara_2,
         .do_3	= xor_niagara_3,
         .do_4	= xor_niagara_4,
         .do_5	= xor_niagara_5,
 };
-
-#define arch_xor_init arch_xor_init
-static __always_inline void __init arch_xor_init(void)
-{
-	/* Force VIS for everything except Niagara.  */
-	if (tlb_type == hypervisor &&
-	    (sun4v_chip_type == SUN4V_CHIP_NIAGARA1 ||
-	     sun4v_chip_type == SUN4V_CHIP_NIAGARA2 ||
-	     sun4v_chip_type == SUN4V_CHIP_NIAGARA3 ||
-	     sun4v_chip_type == SUN4V_CHIP_NIAGARA4 ||
-	     sun4v_chip_type == SUN4V_CHIP_NIAGARA5))
-		xor_force(&xor_block_niagara);
-	else
-		xor_force(&xor_block_VIS);
-}
diff --git a/arch/sparc/lib/xor.S b/lib/raid/xor/sparc/xor-sparc64.S
similarity index 98%
rename from arch/sparc/lib/xor.S
rename to lib/raid/xor/sparc/xor-sparc64.S
index 35461e3b2a9b..a7b74d473bd4 100644
--- a/arch/sparc/lib/xor.S
+++ b/lib/raid/xor/sparc/xor-sparc64.S
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * arch/sparc64/lib/xor.S
- *
  * High speed xor_block operation for RAID4/5 utilizing the
  * UltraSparc Visual Instruction Set and Niagara store-init/twin-load.
  *
@@ -92,7 +90,6 @@ ENTRY(xor_vis_2)
 	retl
 	  wr	%g0, 0, %fprs
 ENDPROC(xor_vis_2)
-EXPORT_SYMBOL(xor_vis_2)
 
 ENTRY(xor_vis_3)
 	rd	%fprs, %o5
@@ -159,7 +156,6 @@ ENTRY(xor_vis_3)
 	retl
 	 wr	%g0, 0, %fprs
 ENDPROC(xor_vis_3)
-EXPORT_SYMBOL(xor_vis_3)
 
 ENTRY(xor_vis_4)
 	rd	%fprs, %o5
@@ -245,7 +241,6 @@ ENTRY(xor_vis_4)
 	retl
 	 wr	%g0, 0, %fprs
 ENDPROC(xor_vis_4)
-EXPORT_SYMBOL(xor_vis_4)
 
 ENTRY(xor_vis_5)
 	save	%sp, -192, %sp
@@ -352,7 +347,6 @@ ENTRY(xor_vis_5)
 	ret
 	 restore
 ENDPROC(xor_vis_5)
-EXPORT_SYMBOL(xor_vis_5)
 
 	/* Niagara versions. */
 ENTRY(xor_niagara_2) /* %o0=bytes, %o1=dest, %o2=src */
@@ -399,7 +393,6 @@ ENTRY(xor_niagara_2) /* %o0=bytes, %o1=dest, %o2=src */
 	ret
 	 restore
 ENDPROC(xor_niagara_2)
-EXPORT_SYMBOL(xor_niagara_2)
 
 ENTRY(xor_niagara_3) /* %o0=bytes, %o1=dest, %o2=src1, %o3=src2 */
 	save		%sp, -192, %sp
@@ -461,7 +454,6 @@ ENTRY(xor_niagara_3) /* %o0=bytes, %o1=dest, %o2=src1, %o3=src2 */
 	ret
 	 restore
 ENDPROC(xor_niagara_3)
-EXPORT_SYMBOL(xor_niagara_3)
 
 ENTRY(xor_niagara_4) /* %o0=bytes, %o1=dest, %o2=src1, %o3=src2, %o4=src3 */
 	save		%sp, -192, %sp
@@ -544,7 +536,6 @@ ENTRY(xor_niagara_4) /* %o0=bytes, %o1=dest, %o2=src1, %o3=src2, %o4=src3 */
 	ret
 	 restore
 ENDPROC(xor_niagara_4)
-EXPORT_SYMBOL(xor_niagara_4)
 
 ENTRY(xor_niagara_5) /* %o0=bytes, %o1=dest, %o2=src1, %o3=src2, %o4=src3, %o5=src4 */
 	save		%sp, -192, %sp
@@ -643,4 +634,3 @@ ENTRY(xor_niagara_5) /* %o0=bytes, %o1=dest, %o2=src1, %o3=src2, %o4=src3, %o5=s
 	ret
 	 restore
 ENDPROC(xor_niagara_5)
-EXPORT_SYMBOL(xor_niagara_5)
-- 
2.47.3


