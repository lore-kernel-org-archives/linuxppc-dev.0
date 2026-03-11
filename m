Return-Path: <linuxppc-dev+bounces-18030-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D30FD063E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 07:09:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fW2142nDdz3dLQ;
	Wed, 11 Mar 2026 18:09:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773212952;
	cv=none; b=nzWhXDdzmvVzV277F6nJJMqMTpJ5FAFG0snx6VVzLpLj6Ou5CSMYj10vyaSfj5z3ufeevUOddjWRL83f3r/uEMzNQ2wuSxP97fdMg08lFp1X2eni5JWGDDJDZaQ7ONLqE8Jpx9qkrTfTXraKK3LD+hgh4xXsV30EWjurorxjdAPDOKK2p0GA3Xaq3tSFs8sk+sQPe9ySK4ORMuFng9t2DLo8nmye2Vsi+exKF33t/vZBnRXgmkc0qqc/hdzGrd7bfLD915B/hx8yuiuDY2WSyBZHqDmjf64DRxIpUcirL4BnqOwYXJKOFUdW/4qlDS5XKFNgSfeGkUTwgnaGbog9qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773212952; c=relaxed/relaxed;
	bh=vfRQfd6HX2UIy1GEtF4WxXFvmD5740u62PQfhFgAIN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHpc4wDbgkdX5e+3HfsczTVgAzJGKvPh4qyfPZ64y8A9p1X3jJ+xTVvzpEo5RHF3axOIvJCPbFL7LsW9ERJmWMbNi6GXN/epL5xG9XQIUa8w6zSoe9JcTSwcgSIH0IaIhgHiFiuJkWenkwEHc9zty/p4DBicvq540/F6m9QA7Lv771Gu+mvm6TcOhGtrleN1eHuLoI00R/VwDF6s9tWaf+DZtDwgP+m1dpoUhs9y7WpcCfvCc12dQGYVTAE7447iHiz4Sd7MdbQlMpIQoiEEM6eMvpk4hB/bC7ut6hW7w8KyPwj3btlSLK+X/R4NoOBvYPgtLWv+SslgAArmptW0Vg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qZG3pa5z; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+bcc67bb7b2d0717eac20+8235+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qZG3pa5z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+bcc67bb7b2d0717eac20+8235+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fW2135KP0z3dL8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 18:09:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vfRQfd6HX2UIy1GEtF4WxXFvmD5740u62PQfhFgAIN8=; b=qZG3pa5znlrtEqDJ38boVWI6SA
	9aViWB7bNyY6Kvo0AMUM0JKjP5E5CIzz7hczR3bZ+3x2UnVg3hEy9YznVR89DZ0jHpKJStNdbXJIw
	qxaxhBxY1RIdUGKWR4RPaaws3rnVYT5GwiXEOh1kl97nD/gm/clZmbxI85MadfaTdql4mVK7HMnVe
	w73Q3I9OoIJaDH1X2sgiDjgVpaeIf1zl0qHnm/1YnWNlz++Syx2K9L2b60eqgjLoHmWLa5UIxQzz/
	t+S5gdUd7bRUJHfsSTjot9s0PzdCq0mvJeYQ5xB2AqmR220AAhfGEfnOwXPO0BfaNxzbm0nEGFTR3
	jHk35tpw==;
Received: from [212.243.42.10] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0Dgd-0000000B0Yu-3nTO;
	Wed, 11 Mar 2026 07:08:56 +0000
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
Subject: [PATCH 19/27] xor: avoid indirect calls for arm64-optimized ops
Date: Wed, 11 Mar 2026 08:03:51 +0100
Message-ID: <20260311070416.972667-20-hch@lst.de>
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

Remove the inner xor_block_templates, and instead have two separate
actual template that call into the neon-enabled compilation unit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm64/include/asm/xor.h       | 13 ++--
 lib/raid/xor/arm64/xor-neon-glue.c | 95 +++++++++++++++---------------
 lib/raid/xor/arm64/xor-neon.c      | 73 +++++++++--------------
 lib/raid/xor/arm64/xor-neon.h      | 30 ++++++++++
 4 files changed, 114 insertions(+), 97 deletions(-)
 create mode 100644 lib/raid/xor/arm64/xor-neon.h

diff --git a/arch/arm64/include/asm/xor.h b/arch/arm64/include/asm/xor.h
index 81718f010761..4782c760bcac 100644
--- a/arch/arm64/include/asm/xor.h
+++ b/arch/arm64/include/asm/xor.h
@@ -7,15 +7,18 @@
 #include <asm-generic/xor.h>
 #include <asm/simd.h>
 
-extern struct xor_block_template xor_block_arm64;
-void __init xor_neon_init(void);
+extern struct xor_block_template xor_block_neon;
+extern struct xor_block_template xor_block_eor3;
 
 #define arch_xor_init arch_xor_init
 static __always_inline void __init arch_xor_init(void)
 {
-	xor_neon_init();
 	xor_register(&xor_block_8regs);
 	xor_register(&xor_block_32regs);
-	if (cpu_has_neon())
-		xor_register(&xor_block_arm64);
+	if (cpu_has_neon()) {
+		if (cpu_have_named_feature(SHA3))
+			xor_register(&xor_block_eor3);
+		else
+			xor_register(&xor_block_neon);
+	}
 }
diff --git a/lib/raid/xor/arm64/xor-neon-glue.c b/lib/raid/xor/arm64/xor-neon-glue.c
index 067a2095659a..08c3e3573388 100644
--- a/lib/raid/xor/arm64/xor-neon-glue.c
+++ b/lib/raid/xor/arm64/xor-neon-glue.c
@@ -7,51 +7,54 @@
 #include <linux/raid/xor_impl.h>
 #include <asm/simd.h>
 #include <asm/xor.h>
+#include "xor-neon.h"
 
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
-struct xor_block_template xor_block_arm64 = {
-	.name   = "arm64_neon",
-	.do_2   = xor_neon_2,
-	.do_3   = xor_neon_3,
-	.do_4   = xor_neon_4,
-	.do_5	= xor_neon_5
+#define XOR_TEMPLATE(_name)						\
+static void								\
+xor_##_name##_2(unsigned long bytes, unsigned long * __restrict p1,	\
+	   const unsigned long * __restrict p2)				\
+{									\
+	scoped_ksimd()							\
+		__xor_##_name##_2(bytes, p1, p2);			\
+}									\
+									\
+static void								\
+xor_##_name##_3(unsigned long bytes, unsigned long * __restrict p1,	\
+	   const unsigned long * __restrict p2,				\
+	   const unsigned long * __restrict p3)				\
+{									\
+	scoped_ksimd()							\
+		__xor_##_name##_3(bytes, p1, p2, p3);			\
+}									\
+									\
+static void								\
+xor_##_name##_4(unsigned long bytes, unsigned long * __restrict p1,	\
+	   const unsigned long * __restrict p2,				\
+	   const unsigned long * __restrict p3,				\
+	   const unsigned long * __restrict p4)				\
+{									\
+	scoped_ksimd()							\
+		__xor_##_name##_4(bytes, p1, p2, p3, p4);		\
+}									\
+									\
+static void								\
+xor_##_name##_5(unsigned long bytes, unsigned long * __restrict p1,	\
+	   const unsigned long * __restrict p2,				\
+	   const unsigned long * __restrict p3,				\
+	   const unsigned long * __restrict p4,				\
+	   const unsigned long * __restrict p5)				\
+{									\
+	scoped_ksimd()							\
+		__xor_##_name##_5(bytes, p1, p2, p3, p4, p5);		\
+}									\
+									\
+struct xor_block_template xor_block_##_name = {				\
+	.name   = __stringify(_name),					\
+	.do_2   = xor_##_name##_2,					\
+	.do_3   = xor_##_name##_3,					\
+	.do_4   = xor_##_name##_4,					\
+	.do_5	= xor_##_name##_5					\
 };
+
+XOR_TEMPLATE(neon);
+XOR_TEMPLATE(eor3);
diff --git a/lib/raid/xor/arm64/xor-neon.c b/lib/raid/xor/arm64/xor-neon.c
index 8d2d185090db..61194c292917 100644
--- a/lib/raid/xor/arm64/xor-neon.c
+++ b/lib/raid/xor/arm64/xor-neon.c
@@ -8,9 +8,10 @@
 #include <linux/cache.h>
 #include <asm/neon-intrinsics.h>
 #include <asm/xor.h>
+#include "xor-neon.h"
 
-static void xor_arm64_neon_2(unsigned long bytes, unsigned long * __restrict p1,
-	const unsigned long * __restrict p2)
+void __xor_neon_2(unsigned long bytes, unsigned long * __restrict p1,
+		const unsigned long * __restrict p2)
 {
 	uint64_t *dp1 = (uint64_t *)p1;
 	uint64_t *dp2 = (uint64_t *)p2;
@@ -36,9 +37,9 @@ static void xor_arm64_neon_2(unsigned long bytes, unsigned long * __restrict p1,
 	} while (--lines > 0);
 }
 
-static void xor_arm64_neon_3(unsigned long bytes, unsigned long * __restrict p1,
-	const unsigned long * __restrict p2,
-	const unsigned long * __restrict p3)
+void __xor_neon_3(unsigned long bytes, unsigned long * __restrict p1,
+		const unsigned long * __restrict p2,
+		const unsigned long * __restrict p3)
 {
 	uint64_t *dp1 = (uint64_t *)p1;
 	uint64_t *dp2 = (uint64_t *)p2;
@@ -72,10 +73,10 @@ static void xor_arm64_neon_3(unsigned long bytes, unsigned long * __restrict p1,
 	} while (--lines > 0);
 }
 
-static void xor_arm64_neon_4(unsigned long bytes, unsigned long * __restrict p1,
-	const unsigned long * __restrict p2,
-	const unsigned long * __restrict p3,
-	const unsigned long * __restrict p4)
+void __xor_neon_4(unsigned long bytes, unsigned long * __restrict p1,
+		const unsigned long * __restrict p2,
+		const unsigned long * __restrict p3,
+		const unsigned long * __restrict p4)
 {
 	uint64_t *dp1 = (uint64_t *)p1;
 	uint64_t *dp2 = (uint64_t *)p2;
@@ -117,11 +118,11 @@ static void xor_arm64_neon_4(unsigned long bytes, unsigned long * __restrict p1,
 	} while (--lines > 0);
 }
 
-static void xor_arm64_neon_5(unsigned long bytes, unsigned long * __restrict p1,
-	const unsigned long * __restrict p2,
-	const unsigned long * __restrict p3,
-	const unsigned long * __restrict p4,
-	const unsigned long * __restrict p5)
+void __xor_neon_5(unsigned long bytes, unsigned long * __restrict p1,
+		const unsigned long * __restrict p2,
+		const unsigned long * __restrict p3,
+		const unsigned long * __restrict p4,
+		const unsigned long * __restrict p5)
 {
 	uint64_t *dp1 = (uint64_t *)p1;
 	uint64_t *dp2 = (uint64_t *)p2;
@@ -171,14 +172,6 @@ static void xor_arm64_neon_5(unsigned long bytes, unsigned long * __restrict p1,
 	} while (--lines > 0);
 }
 
-struct xor_block_template xor_block_inner_neon __ro_after_init = {
-	.name	= "__inner_neon__",
-	.do_2	= xor_arm64_neon_2,
-	.do_3	= xor_arm64_neon_3,
-	.do_4	= xor_arm64_neon_4,
-	.do_5	= xor_arm64_neon_5,
-};
-
 static inline uint64x2_t eor3(uint64x2_t p, uint64x2_t q, uint64x2_t r)
 {
 	uint64x2_t res;
@@ -189,10 +182,9 @@ static inline uint64x2_t eor3(uint64x2_t p, uint64x2_t q, uint64x2_t r)
 	return res;
 }
 
-static void xor_arm64_eor3_3(unsigned long bytes,
-	unsigned long * __restrict p1,
-	const unsigned long * __restrict p2,
-	const unsigned long * __restrict p3)
+void __xor_eor3_3(unsigned long bytes, unsigned long * __restrict p1,
+		const unsigned long * __restrict p2,
+		const unsigned long * __restrict p3)
 {
 	uint64_t *dp1 = (uint64_t *)p1;
 	uint64_t *dp2 = (uint64_t *)p2;
@@ -224,11 +216,10 @@ static void xor_arm64_eor3_3(unsigned long bytes,
 	} while (--lines > 0);
 }
 
-static void xor_arm64_eor3_4(unsigned long bytes,
-	unsigned long * __restrict p1,
-	const unsigned long * __restrict p2,
-	const unsigned long * __restrict p3,
-	const unsigned long * __restrict p4)
+void __xor_eor3_4(unsigned long bytes, unsigned long * __restrict p1,
+		const unsigned long * __restrict p2,
+		const unsigned long * __restrict p3,
+		const unsigned long * __restrict p4)
 {
 	uint64_t *dp1 = (uint64_t *)p1;
 	uint64_t *dp2 = (uint64_t *)p2;
@@ -268,12 +259,11 @@ static void xor_arm64_eor3_4(unsigned long bytes,
 	} while (--lines > 0);
 }
 
-static void xor_arm64_eor3_5(unsigned long bytes,
-	unsigned long * __restrict p1,
-	const unsigned long * __restrict p2,
-	const unsigned long * __restrict p3,
-	const unsigned long * __restrict p4,
-	const unsigned long * __restrict p5)
+void __xor_eor3_5(unsigned long bytes, unsigned long * __restrict p1,
+		const unsigned long * __restrict p2,
+		const unsigned long * __restrict p3,
+		const unsigned long * __restrict p4,
+		const unsigned long * __restrict p5)
 {
 	uint64_t *dp1 = (uint64_t *)p1;
 	uint64_t *dp2 = (uint64_t *)p2;
@@ -314,12 +304,3 @@ static void xor_arm64_eor3_5(unsigned long bytes,
 		dp5 += 8;
 	} while (--lines > 0);
 }
-
-void __init xor_neon_init(void)
-{
-	if (cpu_have_named_feature(SHA3)) {
-		xor_block_inner_neon.do_3 = xor_arm64_eor3_3;
-		xor_block_inner_neon.do_4 = xor_arm64_eor3_4;
-		xor_block_inner_neon.do_5 = xor_arm64_eor3_5;
-	}
-}
diff --git a/lib/raid/xor/arm64/xor-neon.h b/lib/raid/xor/arm64/xor-neon.h
new file mode 100644
index 000000000000..cec0ac846fea
--- /dev/null
+++ b/lib/raid/xor/arm64/xor-neon.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+void __xor_neon_2(unsigned long bytes, unsigned long * __restrict p1,
+		const unsigned long * __restrict p2);
+void __xor_neon_3(unsigned long bytes, unsigned long * __restrict p1,
+		const unsigned long * __restrict p2,
+		const unsigned long * __restrict p3);
+void __xor_neon_4(unsigned long bytes, unsigned long * __restrict p1,
+		const unsigned long * __restrict p2,
+		const unsigned long * __restrict p3,
+		const unsigned long * __restrict p4);
+void __xor_neon_5(unsigned long bytes, unsigned long * __restrict p1,
+		const unsigned long * __restrict p2,
+		const unsigned long * __restrict p3,
+		const unsigned long * __restrict p4,
+		const unsigned long * __restrict p5);
+
+#define __xor_eor3_2	__xor_neon_2
+void __xor_eor3_3(unsigned long bytes, unsigned long * __restrict p1,
+		const unsigned long * __restrict p2,
+		const unsigned long * __restrict p3);
+void __xor_eor3_4(unsigned long bytes, unsigned long * __restrict p1,
+		const unsigned long * __restrict p2,
+		const unsigned long * __restrict p3,
+		const unsigned long * __restrict p4);
+void __xor_eor3_5(unsigned long bytes, unsigned long * __restrict p1,
+		const unsigned long * __restrict p2,
+		const unsigned long * __restrict p3,
+		const unsigned long * __restrict p4,
+		const unsigned long * __restrict p5);
-- 
2.47.3


