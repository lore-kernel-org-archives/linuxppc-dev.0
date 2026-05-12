Return-Path: <linuxppc-dev+bounces-20731-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC70CD4851
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2026 05:24:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gF4lR6Rxpz2yRn;
	Tue, 12 May 2026 15:24:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778563459;
	cv=none; b=HP0KwRs2yYu2kpGdQZGRCMrEEGwTwXfVTEx0USYm3hJGtxOpbX6DknTMAO+D4wK7dLWlB6EmUxIyQEd0vgeyDLFL8bUaB9N4jwJ63E3RsIP4lV8P1RB6gs/oYw8I3o816pnQ1Y9Im0wyCN0eEsOAjY0z8IOJdDQwPkc63PZWOK5yIeNqbpssqTEy5IKRDHGMXEcJnDVvYHUFEvcaMvBcrhcR2HfI6Yz6yvsDctWHFc+VZNscjw3pNwhIRQfEYUy2JlHXIyVFAI6BGEiO1+hubf445taVaRyiesdG6+NymGq6LHjneQEtA4mLvjfE1L8rpvJzxR6dlMEmmaaTxt8msA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778563459; c=relaxed/relaxed;
	bh=B0y5iB0zJYAVg0o7yz7dHwA2kfgFWvGt07V234mQwsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WljVvwGksd2CG78DXJ9knYe/xq0q4rulC8jV+0ZpoYHNv+FalXrNHeOR5KYcsnE2fW+2bBLjj1y5jvBB2cQSDm3PRYeryvzzX0OBR2QfuHpzYOY1EqsUpC3fobkQnbsNyW0xS12Y5zYzEbe4VgBtM97jJl954llJN0MZVMLELg0JbiWgSEXlJVXKkCrJWrl0uQaI4Xzwfg1yEfsJa7vaFztIUwC2Ij0IrVjzoN6dcjp2aSrOlHwQ3MJ0y3vjfMMFu7cqOZE/cTMLAihA1i5EYDZluxFDCIsRutOYlHn9RR3clxFxSe5wqKtkfrutTcX9YTvgnBuCCyQl5/d4DcYZag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HIGdfjMi; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+9f3c1ea353498f61ccd0+8297+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HIGdfjMi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+9f3c1ea353498f61ccd0+8297+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gF4lQ6Ky5z2yQn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 15:24:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=B0y5iB0zJYAVg0o7yz7dHwA2kfgFWvGt07V234mQwsM=; b=HIGdfjMiq+/aah4lJgslQOJ5qK
	e3rkiaR+JAlResqdHDnqYkJPb/SzalqaDaxSog63q6g0x21ZJabvVKqUfmPG5+vEEfREcD9WSPHmd
	GJ0XM8KrmA13GrR0kUJd2IrzRvTh1KhNusk0I0UwOWvyO3zbOhnfuJe/cz1TWicVa0iH0AUUUf6GM
	wBOZ3wQr+qXnx8ei5+YjzcBqF93Tm/hbjPz9jMRW40BBMji0y5QpiYM7wbisKB7g81mh3XQnU0Y2L
	1q7FH/Lg/fGzYmL7uLyC908FlspW2Dfl8YGYTjfZf5cwbfAtAo+F6fhBrDO4TG6UPDxxwFmtWS//g
	YpfNUpUA==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMfb0-0000000FbLG-06HR;
	Tue, 12 May 2026 05:23:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
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
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-raid@vger.kernel.org
Subject: [PATCH 07/19] raid6: use named initializers for struct raid6_calls
Date: Tue, 12 May 2026 07:20:47 +0200
Message-ID: <20260512052230.2947683-8-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512052230.2947683-1-hch@lst.de>
References: <20260512052230.2947683-1-hch@lst.de>
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/raid/raid6/arm/neon.c                 |  9 +++----
 lib/raid/raid6/int.uc                     |  8 +++---
 lib/raid/raid6/loongarch/loongarch_simd.c | 18 ++++++-------
 lib/raid/raid6/powerpc/altivec.uc         |  8 +++---
 lib/raid/raid6/powerpc/vpermxor.uc        |  8 +++---
 lib/raid/raid6/riscv/rvv.h                |  9 +++----
 lib/raid/raid6/s390/s390vx.uc             | 10 +++----
 lib/raid/raid6/x86/avx2.c                 | 33 ++++++++++++-----------
 lib/raid/raid6/x86/avx512.c               | 33 ++++++++++++-----------
 lib/raid/raid6/x86/mmx.c                  | 16 +++++------
 lib/raid/raid6/x86/sse1.c                 | 18 ++++++-------
 lib/raid/raid6/x86/sse2.c                 | 30 ++++++++++-----------
 12 files changed, 95 insertions(+), 105 deletions(-)

diff --git a/lib/raid/raid6/arm/neon.c b/lib/raid/raid6/arm/neon.c
index 47b8bb0afc65..c21da59ab48f 100644
--- a/lib/raid/raid6/arm/neon.c
+++ b/lib/raid/raid6/arm/neon.c
@@ -40,11 +40,10 @@
 				start, stop, (unsigned long)bytes, ptrs);\
 	}								\
 	struct raid6_calls const raid6_neonx ## _n = {			\
-		raid6_neon ## _n ## _gen_syndrome,			\
-		raid6_neon ## _n ## _xor_syndrome,			\
-		raid6_have_neon,					\
-		"neonx" #_n,						\
-		0							\
+		.gen_syndrome	= raid6_neon ## _n ## _gen_syndrome,	\
+		.xor_syndrome	= raid6_neon ## _n ## _xor_syndrome,	\
+		.valid		= raid6_have_neon,			\
+		.name		= "neonx" #_n,				\
 	}
 
 static int raid6_have_neon(void)
diff --git a/lib/raid/raid6/int.uc b/lib/raid/raid6/int.uc
index 1ba56c3fa482..4f5f2869e21e 100644
--- a/lib/raid/raid6/int.uc
+++ b/lib/raid/raid6/int.uc
@@ -139,9 +139,7 @@ static void raid6_int$#_xor_syndrome(int disks, int start, int stop,
 }
 
 const struct raid6_calls raid6_intx$# = {
-	raid6_int$#_gen_syndrome,
-	raid6_int$#_xor_syndrome,
-	NULL,			/* always valid */
-	"int" NSTRING "x$#",
-	0
+	.gen_syndrome	= raid6_int$#_gen_syndrome,
+	.xor_syndrome	= raid6_int$#_xor_syndrome,
+	.name		= "int" NSTRING "x$#",
 };
diff --git a/lib/raid/raid6/loongarch/loongarch_simd.c b/lib/raid/raid6/loongarch/loongarch_simd.c
index 72f4d92d4876..1b4cd1512d05 100644
--- a/lib/raid/raid6/loongarch/loongarch_simd.c
+++ b/lib/raid/raid6/loongarch/loongarch_simd.c
@@ -244,11 +244,10 @@ static void raid6_lsx_xor_syndrome(int disks, int start, int stop,
 }
 
 const struct raid6_calls raid6_lsx = {
-	raid6_lsx_gen_syndrome,
-	raid6_lsx_xor_syndrome,
-	raid6_has_lsx,
-	"lsx",
-	.priority = 0 /* see the comment near the top of the file for reason */
+	.gen_syndrome	= raid6_lsx_gen_syndrome,
+	.xor_syndrome	= raid6_lsx_xor_syndrome,
+	.valid		= raid6_has_lsx,
+	.name		= "lsx",
 };
 
 #undef NSIZE
@@ -413,11 +412,10 @@ static void raid6_lasx_xor_syndrome(int disks, int start, int stop,
 }
 
 const struct raid6_calls raid6_lasx = {
-	raid6_lasx_gen_syndrome,
-	raid6_lasx_xor_syndrome,
-	raid6_has_lasx,
-	"lasx",
-	.priority = 0 /* see the comment near the top of the file for reason */
+	.gen_syndrome	= raid6_lasx_gen_syndrome,
+	.xor_syndrome	= raid6_lasx_xor_syndrome,
+	.valid		= raid6_has_lasx,
+	.name		= "lasx",
 };
 #undef NSIZE
 #endif /* CONFIG_CPU_HAS_LASX */
diff --git a/lib/raid/raid6/powerpc/altivec.uc b/lib/raid/raid6/powerpc/altivec.uc
index 130d3d3dd42c..084ead768ddb 100644
--- a/lib/raid/raid6/powerpc/altivec.uc
+++ b/lib/raid/raid6/powerpc/altivec.uc
@@ -114,9 +114,7 @@ int raid6_have_altivec(void)
 #endif
 
 const struct raid6_calls raid6_altivec$# = {
-	raid6_altivec$#_gen_syndrome,
-	NULL,			/* XOR not yet implemented */
-	raid6_have_altivec,
-	"altivecx$#",
-	0
+	.gen_syndrome	= raid6_altivec$#_gen_syndrome,
+	.valid		= raid6_have_altivec,
+	.name		= "altivecx$#",
 };
diff --git a/lib/raid/raid6/powerpc/vpermxor.uc b/lib/raid/raid6/powerpc/vpermxor.uc
index 595f20aaf4cf..bb2c3a316ae8 100644
--- a/lib/raid/raid6/powerpc/vpermxor.uc
+++ b/lib/raid/raid6/powerpc/vpermxor.uc
@@ -87,9 +87,7 @@ int raid6_have_altivec_vpermxor(void)
 #endif
 
 const struct raid6_calls raid6_vpermxor$# = {
-	raid6_vpermxor$#_gen_syndrome,
-	NULL,
-	raid6_have_altivec_vpermxor,
-	"vpermxor$#",
-	0
+	.gen_syndrome	= raid6_vpermxor$#_gen_syndrome,
+	.valid		= raid6_have_altivec_vpermxor,
+	.name		= "vpermxor$#",
 };
diff --git a/lib/raid/raid6/riscv/rvv.h b/lib/raid/raid6/riscv/rvv.h
index b0a71b375962..0d430a4c5f08 100644
--- a/lib/raid/raid6/riscv/rvv.h
+++ b/lib/raid/raid6/riscv/rvv.h
@@ -39,9 +39,8 @@ static int rvv_has_vector(void)
 		kernel_vector_end();					\
 	}								\
 	struct raid6_calls const raid6_rvvx ## _n = {			\
-		raid6_rvv ## _n ## _gen_syndrome,			\
-		raid6_rvv ## _n ## _xor_syndrome,			\
-		rvv_has_vector,						\
-		"rvvx" #_n,						\
-		0							\
+		.gen_syndrome	= raid6_rvv ## _n ## _gen_syndrome,	\
+		.xor_syndrome	= raid6_rvv ## _n ## _xor_syndrome,	\
+		.valid		= rvv_has_vector,			\
+		.name		= "rvvx" #_n,				\
 	}
diff --git a/lib/raid/raid6/s390/s390vx.uc b/lib/raid/raid6/s390/s390vx.uc
index 8aa53eb2f395..97c5d5d9dcf9 100644
--- a/lib/raid/raid6/s390/s390vx.uc
+++ b/lib/raid/raid6/s390/s390vx.uc
@@ -127,9 +127,9 @@ static int raid6_s390vx$#_valid(void)
 }
 
 const struct raid6_calls raid6_s390vx$# = {
-	raid6_s390vx$#_gen_syndrome,
-	raid6_s390vx$#_xor_syndrome,
-	raid6_s390vx$#_valid,
-	"vx128x$#",
-	1
+	.gen_syndrome	= raid6_s390vx$#_gen_syndrome,
+	.xor_syndrome	= raid6_s390vx$#_xor_syndrome,
+	.valid		= raid6_s390vx$#_valid,
+	.name		= "vx128x$#",
+	.priority	= 1,
 };
diff --git a/lib/raid/raid6/x86/avx2.c b/lib/raid/raid6/x86/avx2.c
index a1a5213918af..aab8b624c635 100644
--- a/lib/raid/raid6/x86/avx2.c
+++ b/lib/raid/raid6/x86/avx2.c
@@ -128,11 +128,12 @@ static void raid6_avx21_xor_syndrome(int disks, int start, int stop,
 }
 
 const struct raid6_calls raid6_avx2x1 = {
-	raid6_avx21_gen_syndrome,
-	raid6_avx21_xor_syndrome,
-	raid6_have_avx2,
-	"avx2x1",
-	.priority = 2		/* Prefer AVX2 over priority 1 (SSE2 and others) */
+	.gen_syndrome	= raid6_avx21_gen_syndrome,
+	.xor_syndrome	= raid6_avx21_xor_syndrome,
+	.valid		= raid6_have_avx2,
+	.name		= "avx2x1",
+	/* Prefer AVX2 over priority 1 (SSE2 and others) */
+	.priority	= 2,
 };
 
 /*
@@ -258,11 +259,12 @@ static void raid6_avx22_xor_syndrome(int disks, int start, int stop,
 }
 
 const struct raid6_calls raid6_avx2x2 = {
-	raid6_avx22_gen_syndrome,
-	raid6_avx22_xor_syndrome,
-	raid6_have_avx2,
-	"avx2x2",
-	.priority = 2		/* Prefer AVX2 over priority 1 (SSE2 and others) */
+	.gen_syndrome	= raid6_avx22_gen_syndrome,
+	.xor_syndrome	= raid6_avx22_xor_syndrome,
+	.valid		= raid6_have_avx2,
+	.name		= "avx2x2",
+	/* Prefer AVX2 over priority 1 (SSE2 and others) */
+	.priority	= 2,
 };
 
 #ifdef CONFIG_X86_64
@@ -461,10 +463,11 @@ static void raid6_avx24_xor_syndrome(int disks, int start, int stop,
 }
 
 const struct raid6_calls raid6_avx2x4 = {
-	raid6_avx24_gen_syndrome,
-	raid6_avx24_xor_syndrome,
-	raid6_have_avx2,
-	"avx2x4",
-	.priority = 2		/* Prefer AVX2 over priority 1 (SSE2 and others) */
+	.gen_syndrome	= raid6_avx24_gen_syndrome,
+	.xor_syndrome	= raid6_avx24_xor_syndrome,
+	.valid		= raid6_have_avx2,
+	.name		= "avx2x4",
+	/* Prefer AVX2 over priority 1 (SSE2 and others) */
+	.priority	= 2,
 };
 #endif /* CONFIG_X86_64 */
diff --git a/lib/raid/raid6/x86/avx512.c b/lib/raid/raid6/x86/avx512.c
index 874998bcd7d7..47636b16632f 100644
--- a/lib/raid/raid6/x86/avx512.c
+++ b/lib/raid/raid6/x86/avx512.c
@@ -156,11 +156,12 @@ static void raid6_avx5121_xor_syndrome(int disks, int start, int stop,
 }
 
 const struct raid6_calls raid6_avx512x1 = {
-	raid6_avx5121_gen_syndrome,
-	raid6_avx5121_xor_syndrome,
-	raid6_have_avx512,
-	"avx512x1",
-	.priority = 2		/* Prefer AVX512 over priority 1 (SSE2 and others) */
+	.gen_syndrome	= raid6_avx5121_gen_syndrome,
+	.xor_syndrome	= raid6_avx5121_xor_syndrome,
+	.valid		= raid6_have_avx512,
+	.name		= "avx512x1",
+	/* Prefer AVX512 over priority 1 (SSE2 and others) */
+	.priority	= 2,
 };
 
 /*
@@ -313,11 +314,12 @@ static void raid6_avx5122_xor_syndrome(int disks, int start, int stop,
 }
 
 const struct raid6_calls raid6_avx512x2 = {
-	raid6_avx5122_gen_syndrome,
-	raid6_avx5122_xor_syndrome,
-	raid6_have_avx512,
-	"avx512x2",
-	.priority = 2		/* Prefer AVX512 over priority 1 (SSE2 and others) */
+	.gen_syndrome	= raid6_avx5122_gen_syndrome,
+	.xor_syndrome	= raid6_avx5122_xor_syndrome,
+	.valid		= raid6_have_avx512,
+	.name		= "avx512x2",
+	/* Prefer AVX512 over priority 1 (SSE2 and others) */
+	.priority	= 2,
 };
 
 #ifdef CONFIG_X86_64
@@ -551,10 +553,11 @@ static void raid6_avx5124_xor_syndrome(int disks, int start, int stop,
 	kernel_fpu_end();
 }
 const struct raid6_calls raid6_avx512x4 = {
-	raid6_avx5124_gen_syndrome,
-	raid6_avx5124_xor_syndrome,
-	raid6_have_avx512,
-	"avx512x4",
-	.priority = 2		/* Prefer AVX512 over priority 1 (SSE2 and others) */
+	.gen_syndrome	= raid6_avx5124_gen_syndrome,
+	.xor_syndrome	= raid6_avx5124_xor_syndrome,
+	.valid		= raid6_have_avx512,
+	.name		= "avx512x4",
+	/* Prefer AVX512 over priority 1 (SSE2 and others) */
+	.priority	= 2,
 };
 #endif
diff --git a/lib/raid/raid6/x86/mmx.c b/lib/raid/raid6/x86/mmx.c
index 7e9810669347..22b9fdaa705f 100644
--- a/lib/raid/raid6/x86/mmx.c
+++ b/lib/raid/raid6/x86/mmx.c
@@ -68,11 +68,9 @@ static void raid6_mmx1_gen_syndrome(int disks, size_t bytes, void **ptrs)
 }
 
 const struct raid6_calls raid6_mmxx1 = {
-	raid6_mmx1_gen_syndrome,
-	NULL,			/* XOR not yet implemented */
-	raid6_have_mmx,
-	"mmxx1",
-	0
+	.gen_syndrome	= raid6_mmx1_gen_syndrome,
+	.valid		= raid6_have_mmx,
+	.name		= "mmxx1",
 };
 
 /*
@@ -127,9 +125,7 @@ static void raid6_mmx2_gen_syndrome(int disks, size_t bytes, void **ptrs)
 }
 
 const struct raid6_calls raid6_mmxx2 = {
-	raid6_mmx2_gen_syndrome,
-	NULL,			/* XOR not yet implemented */
-	raid6_have_mmx,
-	"mmxx2",
-	0
+	.gen_syndrome	= raid6_mmx2_gen_syndrome,
+	.valid		= raid6_have_mmx,
+	.name		= "mmxx2",
 };
diff --git a/lib/raid/raid6/x86/sse1.c b/lib/raid/raid6/x86/sse1.c
index deecdd72ceec..fad214a430d8 100644
--- a/lib/raid/raid6/x86/sse1.c
+++ b/lib/raid/raid6/x86/sse1.c
@@ -84,11 +84,10 @@ static void raid6_sse11_gen_syndrome(int disks, size_t bytes, void **ptrs)
 }
 
 const struct raid6_calls raid6_sse1x1 = {
-	raid6_sse11_gen_syndrome,
-	NULL,			/* XOR not yet implemented */
-	raid6_have_sse1_or_mmxext,
-	"sse1x1",
-	1			/* Has cache hints */
+	.gen_syndrome	= raid6_sse11_gen_syndrome,
+	.valid		= raid6_have_sse1_or_mmxext,
+	.name		= "sse1x1",
+	.priority	= 1,	/* Has cache hints */
 };
 
 /*
@@ -147,9 +146,8 @@ static void raid6_sse12_gen_syndrome(int disks, size_t bytes, void **ptrs)
 }
 
 const struct raid6_calls raid6_sse1x2 = {
-	raid6_sse12_gen_syndrome,
-	NULL,			/* XOR not yet implemented */
-	raid6_have_sse1_or_mmxext,
-	"sse1x2",
-	1			/* Has cache hints */
+	.gen_syndrome	= raid6_sse12_gen_syndrome,
+	.valid		= raid6_have_sse1_or_mmxext,
+	.name		= "sse1x2",
+	.priority	= 1,	/* Has cache hints */
 };
diff --git a/lib/raid/raid6/x86/sse2.c b/lib/raid/raid6/x86/sse2.c
index f9edf8a8d1c4..1b28e858a1d4 100644
--- a/lib/raid/raid6/x86/sse2.c
+++ b/lib/raid/raid6/x86/sse2.c
@@ -133,11 +133,11 @@ static void raid6_sse21_xor_syndrome(int disks, int start, int stop,
 }
 
 const struct raid6_calls raid6_sse2x1 = {
-	raid6_sse21_gen_syndrome,
-	raid6_sse21_xor_syndrome,
-	raid6_have_sse2,
-	"sse2x1",
-	1			/* Has cache hints */
+	.gen_syndrome	= raid6_sse21_gen_syndrome,
+	.xor_syndrome	= raid6_sse21_xor_syndrome,
+	.valid		= raid6_have_sse2,
+	.name		= "sse2x1",
+	.priority	= 1,	/* Has cache hints */
 };
 
 /*
@@ -263,11 +263,11 @@ static void raid6_sse22_xor_syndrome(int disks, int start, int stop,
 }
 
 const struct raid6_calls raid6_sse2x2 = {
-	raid6_sse22_gen_syndrome,
-	raid6_sse22_xor_syndrome,
-	raid6_have_sse2,
-	"sse2x2",
-	1			/* Has cache hints */
+	.gen_syndrome	= raid6_sse22_gen_syndrome,
+	.xor_syndrome	= raid6_sse22_xor_syndrome,
+	.valid		= raid6_have_sse2,
+	.name		= "sse2x2",
+	.priority	= 1,	/* Has cache hints */
 };
 
 #ifdef CONFIG_X86_64
@@ -470,11 +470,11 @@ static void raid6_sse24_xor_syndrome(int disks, int start, int stop,
 
 
 const struct raid6_calls raid6_sse2x4 = {
-	raid6_sse24_gen_syndrome,
-	raid6_sse24_xor_syndrome,
-	raid6_have_sse2,
-	"sse2x4",
-	1			/* Has cache hints */
+	.gen_syndrome	= raid6_sse24_gen_syndrome,
+	.xor_syndrome	= raid6_sse24_xor_syndrome,
+	.valid		= raid6_have_sse2,
+	.name		= "sse2x4",
+	.priority	= 1,	/* Has cache hints */
 };
 
 #endif /* CONFIG_X86_64 */
-- 
2.53.0


