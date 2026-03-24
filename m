Return-Path: <linuxppc-dev+bounces-18699-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5661AF532D4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 06:43:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fg0ps0CFJz3f7t;
	Tue, 24 Mar 2026 17:43:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774334580;
	cv=none; b=fzq1/X3Eq5yEEzlO/DgXVva7Rthe5SilJhCDTVTXLOpGTyTmvXBIfnNrZKp8DLlhKjk/j6mLf0US9/NnJzp9fjn2Do2YFDr44W9kS2g5g1ER5ZbK0FjTXEl5GTSZMj+c93TvQXf5LERD/IYrs6DOy+qTgdsut7RxdD0KaBkihTN1rj8/Az8m6SMT5Qqp3+gNN57kSO0c2+W4ih31RfVRfpmn7W9P+gpWlJLqn57OnpORyQ1q84ZaWsrZ8LjxyOJVOanrcjK227RHVRc+U/shg05aZSFBxp15umuW9nmx2WCjqa0VqiVoqZZ+IcfAHqaKF6J0CH0gxsCtD9pCsslX1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774334580; c=relaxed/relaxed;
	bh=qDfYxtJRwrD7pb+auYAq5YB9M+XkcLbuYGuHmrpiy+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e7WllOjdqE/RGa3GWg1GbWW3fJP79KICzmz91ZYEIfG01cMFNI8m4EdD9pHRZYMXFOYMUfP3kvaAfp/MCOztza5K6FbCoE8emrlnb7t3A5hVzKi0Ee9uQOUFZatjPiPfYCrJey6CUfJQIbruV8R7mPnBxaR8OziXTJh9pjm+edaqx4LiH7quAEaZJ385PVrSTnfG8f8awIGqaKlK8x8iekQkarkaff6SMwI+YyazmK/QuGnSJa7rTpxxgmg+r6B6pz+y5bMgf8VZxvOiBAKPdV4g3HIgrbWVU9UqaHSm+S9fRgwYYVri1vqPK3uEd2Vqc6JuOZkoxWFeVytMww79Mw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=A+uB16Sm; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+4a75e1166b7f241dd976+8248+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=A+uB16Sm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+4a75e1166b7f241dd976+8248+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fg0pr1lL9z2ytw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2026 17:43:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=qDfYxtJRwrD7pb+auYAq5YB9M+XkcLbuYGuHmrpiy+Y=; b=A+uB16Smh+H8LFgcVgigSa7YY3
	4tcUvByEPCYnEAQcdO+JgI77w45ENhtEAllgufJwB43DqVnw7Xy6staNc4FmDl5Rg/vhVqQlgZV+E
	nHj5e4lI3YdJVyjKyHXvfV3piApyv6q39fQwoXq3rxM1OKHJOxC2/mi0QgVNGcjwt2ZfM+BwoBqJV
	o1I/5e4oQEG3BfllHRN4bMpxMO3gYC/YnTAG84gKgYyHfxCZfro2ROymuqGwZLDvuI9wzDc88wrka
	kjqTnESSr1Q6fBoC8kvLGePnkQ5WviiXflTf2k88a/G286IQpuB0Scs55Tlk0s+AJiPNd+mS4tbKG
	1z5cyKSg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4vTT-00000000me2-1RrB;
	Tue, 24 Mar 2026 06:42:47 +0000
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
Subject: [PATCH 06/17] raid6: use named initializers for struct raid6_calls
Date: Tue, 24 Mar 2026 07:40:41 +0100
Message-ID: <20260324064115.3217136-7-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260324064115.3217136-1-hch@lst.de>
References: <20260324064115.3217136-1-hch@lst.de>
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
2.47.3


