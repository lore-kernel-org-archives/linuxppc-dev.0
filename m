Return-Path: <linuxppc-dev+bounces-18880-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF09D10BA432
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 06:20:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhr9K4C18z30TY;
	Fri, 27 Mar 2026 17:20:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774592421;
	cv=none; b=Kayxh5Y+XNEFa/F/Ee95GM+X6xHWa3Ng+GfK17TCbB3wJL9OWRBysSRf6dYdOfuMo+yjeQJh4lFdA/J1hOViFUo+3Y9REWRWvPRrqTr4PX0i9umnQ9fzsu8GeyAwUSevJqLDwc9zugErWlD4J/5+rUYyMGTS3J7tonTG0s0SKEJe7+S+9uFXYaXIOStYLbLxTkmpZB7FgsFlI4Zan+GvRN3eLb/ieDEp9myJ82hCzFYlTBdh/UMfph7Y8I7TCyzxX4HKX7hcKD1fDPTv5ls0hl97HFNQBwLFzc4wOSXYNH4tAH9CtRoIo+pmKS4s6/IFQPGLSKaOWrSsS4827brYHA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774592421; c=relaxed/relaxed;
	bh=AuswcUODFcjfkuCW6IvHw2LNaByAD11L1gbTzdzZTFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Alf94GaK76od5woQ3ZyOIn6C0aMFT3RhSSK0BgeZjkxAdS6AszwtyULGxqcSEivvojG58eetIF2bGe03VaWRn0peaEFJ3c1Lp06iT7+Ysl3+A80QjJojBtDC1XJ3SkvblIS0bWT2hCg4RLsxeMzMUQiEW19AR7YYjWdAnFPb3ebbd/fPKpv/KJFa39gyPVd4L63ENbhiEf0z+LLhtXx3HJgSPTv3PWucg9MRtl4WsskuW5v7wb5JCk8x/0H4CzOExXa0/Rx9whYYyj8e8cREsz5qPPV6cQb5th4yDZTNJ8o9x37mVtFIhXFwo+E+IHtqV3/Kdd6B07nj/1A94emALw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TKToHgEa; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+7b1de7ca9b09bfe890a7+8251+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TKToHgEa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+7b1de7ca9b09bfe890a7+8251+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhr9J1ZBCz309S
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 17:20:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=AuswcUODFcjfkuCW6IvHw2LNaByAD11L1gbTzdzZTFM=; b=TKToHgEaJk1ZXAIER646HkN/4M
	STC+XqfsXiZ9WKbYZxhRMdF1JS+8O2ihGMwVely3dAYzfQePGgfJyx1KVZ6YfVKTCq0Ixg30DUeLL
	9qmjw52U2sxBMMpr9tnR5aAAk1eBlZ4vAmqZ/vaZ5wo+8UJSyQp/kaH7RDj1gUuj4FkBLqaU3KdkO
	n9gZ8pU4jSX5ooMpQZjriSfWmD0oZyyebIxK7WdJM7q08tLOtjqrP00GwZu24LK0tZujZM8b73pmT
	B+6WF57l3IJ1vneU4+OEFrZYaMeKm3nfqeq/Ne9hPF/UuQftPF2JZ0VWkGWelqpHNY5dV7PGlBn7v
	7l1GM11Q==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w60Y3-00000006lgL-1dRL;
	Fri, 27 Mar 2026 06:19:59 +0000
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
Subject: [PATCH 10/28] xor: move generic implementations out of asm-generic/xor.h
Date: Fri, 27 Mar 2026 07:16:42 +0100
Message-ID: <20260327061704.3707577-11-hch@lst.de>
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

Move the generic implementations from asm-generic/xor.h to
per-implementaion .c files in lib/raid.  This will build them
unconditionally even when an architecture forces a specific
implementation, but as we'll need at least one generic version
for the static_call optimization later on we'll pay that price.

Note that this would cause the second xor_block_8regs instance created by
arch/arm/lib/xor-neon.c to be generated instead of discarded as dead
code, so add a NO_TEMPLATE symbol to disable it for this case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/lib/xor-neon.c            |   4 +-
 include/asm-generic/xor.h          | 727 +----------------------------
 lib/raid/xor/Makefile              |   4 +
 lib/raid/xor/xor-32regs-prefetch.c | 268 +++++++++++
 lib/raid/xor/xor-32regs.c          | 219 +++++++++
 lib/raid/xor/xor-8regs-prefetch.c  | 146 ++++++
 lib/raid/xor/xor-8regs.c           | 105 +++++
 7 files changed, 748 insertions(+), 725 deletions(-)
 create mode 100644 lib/raid/xor/xor-32regs-prefetch.c
 create mode 100644 lib/raid/xor/xor-32regs.c
 create mode 100644 lib/raid/xor/xor-8regs-prefetch.c
 create mode 100644 lib/raid/xor/xor-8regs.c

diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
index 282980b9bf2a..b5be50567991 100644
--- a/arch/arm/lib/xor-neon.c
+++ b/arch/arm/lib/xor-neon.c
@@ -26,8 +26,8 @@ MODULE_LICENSE("GPL");
 #pragma GCC optimize "tree-vectorize"
 #endif
 
-#pragma GCC diagnostic ignored "-Wunused-variable"
-#include <asm-generic/xor.h>
+#define NO_TEMPLATE
+#include "../../../lib/raid/xor/xor-8regs.c"
 
 struct xor_block_template const xor_block_neon_inner = {
 	.name	= "__inner_neon__",
diff --git a/include/asm-generic/xor.h b/include/asm-generic/xor.h
index 79c0096aa9d9..fc151fdc45ab 100644
--- a/include/asm-generic/xor.h
+++ b/include/asm-generic/xor.h
@@ -5,726 +5,7 @@
  * Generic optimized RAID-5 checksumming functions.
  */
 
-#include <linux/prefetch.h>
-
-static void
-xor_8regs_2(unsigned long bytes, unsigned long * __restrict p1,
-	    const unsigned long * __restrict p2)
-{
-	long lines = bytes / (sizeof (long)) / 8;
-
-	do {
-		p1[0] ^= p2[0];
-		p1[1] ^= p2[1];
-		p1[2] ^= p2[2];
-		p1[3] ^= p2[3];
-		p1[4] ^= p2[4];
-		p1[5] ^= p2[5];
-		p1[6] ^= p2[6];
-		p1[7] ^= p2[7];
-		p1 += 8;
-		p2 += 8;
-	} while (--lines > 0);
-}
-
-static void
-xor_8regs_3(unsigned long bytes, unsigned long * __restrict p1,
-	    const unsigned long * __restrict p2,
-	    const unsigned long * __restrict p3)
-{
-	long lines = bytes / (sizeof (long)) / 8;
-
-	do {
-		p1[0] ^= p2[0] ^ p3[0];
-		p1[1] ^= p2[1] ^ p3[1];
-		p1[2] ^= p2[2] ^ p3[2];
-		p1[3] ^= p2[3] ^ p3[3];
-		p1[4] ^= p2[4] ^ p3[4];
-		p1[5] ^= p2[5] ^ p3[5];
-		p1[6] ^= p2[6] ^ p3[6];
-		p1[7] ^= p2[7] ^ p3[7];
-		p1 += 8;
-		p2 += 8;
-		p3 += 8;
-	} while (--lines > 0);
-}
-
-static void
-xor_8regs_4(unsigned long bytes, unsigned long * __restrict p1,
-	    const unsigned long * __restrict p2,
-	    const unsigned long * __restrict p3,
-	    const unsigned long * __restrict p4)
-{
-	long lines = bytes / (sizeof (long)) / 8;
-
-	do {
-		p1[0] ^= p2[0] ^ p3[0] ^ p4[0];
-		p1[1] ^= p2[1] ^ p3[1] ^ p4[1];
-		p1[2] ^= p2[2] ^ p3[2] ^ p4[2];
-		p1[3] ^= p2[3] ^ p3[3] ^ p4[3];
-		p1[4] ^= p2[4] ^ p3[4] ^ p4[4];
-		p1[5] ^= p2[5] ^ p3[5] ^ p4[5];
-		p1[6] ^= p2[6] ^ p3[6] ^ p4[6];
-		p1[7] ^= p2[7] ^ p3[7] ^ p4[7];
-		p1 += 8;
-		p2 += 8;
-		p3 += 8;
-		p4 += 8;
-	} while (--lines > 0);
-}
-
-static void
-xor_8regs_5(unsigned long bytes, unsigned long * __restrict p1,
-	    const unsigned long * __restrict p2,
-	    const unsigned long * __restrict p3,
-	    const unsigned long * __restrict p4,
-	    const unsigned long * __restrict p5)
-{
-	long lines = bytes / (sizeof (long)) / 8;
-
-	do {
-		p1[0] ^= p2[0] ^ p3[0] ^ p4[0] ^ p5[0];
-		p1[1] ^= p2[1] ^ p3[1] ^ p4[1] ^ p5[1];
-		p1[2] ^= p2[2] ^ p3[2] ^ p4[2] ^ p5[2];
-		p1[3] ^= p2[3] ^ p3[3] ^ p4[3] ^ p5[3];
-		p1[4] ^= p2[4] ^ p3[4] ^ p4[4] ^ p5[4];
-		p1[5] ^= p2[5] ^ p3[5] ^ p4[5] ^ p5[5];
-		p1[6] ^= p2[6] ^ p3[6] ^ p4[6] ^ p5[6];
-		p1[7] ^= p2[7] ^ p3[7] ^ p4[7] ^ p5[7];
-		p1 += 8;
-		p2 += 8;
-		p3 += 8;
-		p4 += 8;
-		p5 += 8;
-	} while (--lines > 0);
-}
-
-static void
-xor_32regs_2(unsigned long bytes, unsigned long * __restrict p1,
-	     const unsigned long * __restrict p2)
-{
-	long lines = bytes / (sizeof (long)) / 8;
-
-	do {
-		register long d0, d1, d2, d3, d4, d5, d6, d7;
-		d0 = p1[0];	/* Pull the stuff into registers	*/
-		d1 = p1[1];	/*  ... in bursts, if possible.		*/
-		d2 = p1[2];
-		d3 = p1[3];
-		d4 = p1[4];
-		d5 = p1[5];
-		d6 = p1[6];
-		d7 = p1[7];
-		d0 ^= p2[0];
-		d1 ^= p2[1];
-		d2 ^= p2[2];
-		d3 ^= p2[3];
-		d4 ^= p2[4];
-		d5 ^= p2[5];
-		d6 ^= p2[6];
-		d7 ^= p2[7];
-		p1[0] = d0;	/* Store the result (in bursts)		*/
-		p1[1] = d1;
-		p1[2] = d2;
-		p1[3] = d3;
-		p1[4] = d4;
-		p1[5] = d5;
-		p1[6] = d6;
-		p1[7] = d7;
-		p1 += 8;
-		p2 += 8;
-	} while (--lines > 0);
-}
-
-static void
-xor_32regs_3(unsigned long bytes, unsigned long * __restrict p1,
-	     const unsigned long * __restrict p2,
-	     const unsigned long * __restrict p3)
-{
-	long lines = bytes / (sizeof (long)) / 8;
-
-	do {
-		register long d0, d1, d2, d3, d4, d5, d6, d7;
-		d0 = p1[0];	/* Pull the stuff into registers	*/
-		d1 = p1[1];	/*  ... in bursts, if possible.		*/
-		d2 = p1[2];
-		d3 = p1[3];
-		d4 = p1[4];
-		d5 = p1[5];
-		d6 = p1[6];
-		d7 = p1[7];
-		d0 ^= p2[0];
-		d1 ^= p2[1];
-		d2 ^= p2[2];
-		d3 ^= p2[3];
-		d4 ^= p2[4];
-		d5 ^= p2[5];
-		d6 ^= p2[6];
-		d7 ^= p2[7];
-		d0 ^= p3[0];
-		d1 ^= p3[1];
-		d2 ^= p3[2];
-		d3 ^= p3[3];
-		d4 ^= p3[4];
-		d5 ^= p3[5];
-		d6 ^= p3[6];
-		d7 ^= p3[7];
-		p1[0] = d0;	/* Store the result (in bursts)		*/
-		p1[1] = d1;
-		p1[2] = d2;
-		p1[3] = d3;
-		p1[4] = d4;
-		p1[5] = d5;
-		p1[6] = d6;
-		p1[7] = d7;
-		p1 += 8;
-		p2 += 8;
-		p3 += 8;
-	} while (--lines > 0);
-}
-
-static void
-xor_32regs_4(unsigned long bytes, unsigned long * __restrict p1,
-	     const unsigned long * __restrict p2,
-	     const unsigned long * __restrict p3,
-	     const unsigned long * __restrict p4)
-{
-	long lines = bytes / (sizeof (long)) / 8;
-
-	do {
-		register long d0, d1, d2, d3, d4, d5, d6, d7;
-		d0 = p1[0];	/* Pull the stuff into registers	*/
-		d1 = p1[1];	/*  ... in bursts, if possible.		*/
-		d2 = p1[2];
-		d3 = p1[3];
-		d4 = p1[4];
-		d5 = p1[5];
-		d6 = p1[6];
-		d7 = p1[7];
-		d0 ^= p2[0];
-		d1 ^= p2[1];
-		d2 ^= p2[2];
-		d3 ^= p2[3];
-		d4 ^= p2[4];
-		d5 ^= p2[5];
-		d6 ^= p2[6];
-		d7 ^= p2[7];
-		d0 ^= p3[0];
-		d1 ^= p3[1];
-		d2 ^= p3[2];
-		d3 ^= p3[3];
-		d4 ^= p3[4];
-		d5 ^= p3[5];
-		d6 ^= p3[6];
-		d7 ^= p3[7];
-		d0 ^= p4[0];
-		d1 ^= p4[1];
-		d2 ^= p4[2];
-		d3 ^= p4[3];
-		d4 ^= p4[4];
-		d5 ^= p4[5];
-		d6 ^= p4[6];
-		d7 ^= p4[7];
-		p1[0] = d0;	/* Store the result (in bursts)		*/
-		p1[1] = d1;
-		p1[2] = d2;
-		p1[3] = d3;
-		p1[4] = d4;
-		p1[5] = d5;
-		p1[6] = d6;
-		p1[7] = d7;
-		p1 += 8;
-		p2 += 8;
-		p3 += 8;
-		p4 += 8;
-	} while (--lines > 0);
-}
-
-static void
-xor_32regs_5(unsigned long bytes, unsigned long * __restrict p1,
-	     const unsigned long * __restrict p2,
-	     const unsigned long * __restrict p3,
-	     const unsigned long * __restrict p4,
-	     const unsigned long * __restrict p5)
-{
-	long lines = bytes / (sizeof (long)) / 8;
-
-	do {
-		register long d0, d1, d2, d3, d4, d5, d6, d7;
-		d0 = p1[0];	/* Pull the stuff into registers	*/
-		d1 = p1[1];	/*  ... in bursts, if possible.		*/
-		d2 = p1[2];
-		d3 = p1[3];
-		d4 = p1[4];
-		d5 = p1[5];
-		d6 = p1[6];
-		d7 = p1[7];
-		d0 ^= p2[0];
-		d1 ^= p2[1];
-		d2 ^= p2[2];
-		d3 ^= p2[3];
-		d4 ^= p2[4];
-		d5 ^= p2[5];
-		d6 ^= p2[6];
-		d7 ^= p2[7];
-		d0 ^= p3[0];
-		d1 ^= p3[1];
-		d2 ^= p3[2];
-		d3 ^= p3[3];
-		d4 ^= p3[4];
-		d5 ^= p3[5];
-		d6 ^= p3[6];
-		d7 ^= p3[7];
-		d0 ^= p4[0];
-		d1 ^= p4[1];
-		d2 ^= p4[2];
-		d3 ^= p4[3];
-		d4 ^= p4[4];
-		d5 ^= p4[5];
-		d6 ^= p4[6];
-		d7 ^= p4[7];
-		d0 ^= p5[0];
-		d1 ^= p5[1];
-		d2 ^= p5[2];
-		d3 ^= p5[3];
-		d4 ^= p5[4];
-		d5 ^= p5[5];
-		d6 ^= p5[6];
-		d7 ^= p5[7];
-		p1[0] = d0;	/* Store the result (in bursts)		*/
-		p1[1] = d1;
-		p1[2] = d2;
-		p1[3] = d3;
-		p1[4] = d4;
-		p1[5] = d5;
-		p1[6] = d6;
-		p1[7] = d7;
-		p1 += 8;
-		p2 += 8;
-		p3 += 8;
-		p4 += 8;
-		p5 += 8;
-	} while (--lines > 0);
-}
-
-static void
-xor_8regs_p_2(unsigned long bytes, unsigned long * __restrict p1,
-	      const unsigned long * __restrict p2)
-{
-	long lines = bytes / (sizeof (long)) / 8 - 1;
-	prefetchw(p1);
-	prefetch(p2);
-
-	do {
-		prefetchw(p1+8);
-		prefetch(p2+8);
- once_more:
-		p1[0] ^= p2[0];
-		p1[1] ^= p2[1];
-		p1[2] ^= p2[2];
-		p1[3] ^= p2[3];
-		p1[4] ^= p2[4];
-		p1[5] ^= p2[5];
-		p1[6] ^= p2[6];
-		p1[7] ^= p2[7];
-		p1 += 8;
-		p2 += 8;
-	} while (--lines > 0);
-	if (lines == 0)
-		goto once_more;
-}
-
-static void
-xor_8regs_p_3(unsigned long bytes, unsigned long * __restrict p1,
-	      const unsigned long * __restrict p2,
-	      const unsigned long * __restrict p3)
-{
-	long lines = bytes / (sizeof (long)) / 8 - 1;
-	prefetchw(p1);
-	prefetch(p2);
-	prefetch(p3);
-
-	do {
-		prefetchw(p1+8);
-		prefetch(p2+8);
-		prefetch(p3+8);
- once_more:
-		p1[0] ^= p2[0] ^ p3[0];
-		p1[1] ^= p2[1] ^ p3[1];
-		p1[2] ^= p2[2] ^ p3[2];
-		p1[3] ^= p2[3] ^ p3[3];
-		p1[4] ^= p2[4] ^ p3[4];
-		p1[5] ^= p2[5] ^ p3[5];
-		p1[6] ^= p2[6] ^ p3[6];
-		p1[7] ^= p2[7] ^ p3[7];
-		p1 += 8;
-		p2 += 8;
-		p3 += 8;
-	} while (--lines > 0);
-	if (lines == 0)
-		goto once_more;
-}
-
-static void
-xor_8regs_p_4(unsigned long bytes, unsigned long * __restrict p1,
-	      const unsigned long * __restrict p2,
-	      const unsigned long * __restrict p3,
-	      const unsigned long * __restrict p4)
-{
-	long lines = bytes / (sizeof (long)) / 8 - 1;
-
-	prefetchw(p1);
-	prefetch(p2);
-	prefetch(p3);
-	prefetch(p4);
-
-	do {
-		prefetchw(p1+8);
-		prefetch(p2+8);
-		prefetch(p3+8);
-		prefetch(p4+8);
- once_more:
-		p1[0] ^= p2[0] ^ p3[0] ^ p4[0];
-		p1[1] ^= p2[1] ^ p3[1] ^ p4[1];
-		p1[2] ^= p2[2] ^ p3[2] ^ p4[2];
-		p1[3] ^= p2[3] ^ p3[3] ^ p4[3];
-		p1[4] ^= p2[4] ^ p3[4] ^ p4[4];
-		p1[5] ^= p2[5] ^ p3[5] ^ p4[5];
-		p1[6] ^= p2[6] ^ p3[6] ^ p4[6];
-		p1[7] ^= p2[7] ^ p3[7] ^ p4[7];
-		p1 += 8;
-		p2 += 8;
-		p3 += 8;
-		p4 += 8;
-	} while (--lines > 0);
-	if (lines == 0)
-		goto once_more;
-}
-
-static void
-xor_8regs_p_5(unsigned long bytes, unsigned long * __restrict p1,
-	      const unsigned long * __restrict p2,
-	      const unsigned long * __restrict p3,
-	      const unsigned long * __restrict p4,
-	      const unsigned long * __restrict p5)
-{
-	long lines = bytes / (sizeof (long)) / 8 - 1;
-
-	prefetchw(p1);
-	prefetch(p2);
-	prefetch(p3);
-	prefetch(p4);
-	prefetch(p5);
-
-	do {
-		prefetchw(p1+8);
-		prefetch(p2+8);
-		prefetch(p3+8);
-		prefetch(p4+8);
-		prefetch(p5+8);
- once_more:
-		p1[0] ^= p2[0] ^ p3[0] ^ p4[0] ^ p5[0];
-		p1[1] ^= p2[1] ^ p3[1] ^ p4[1] ^ p5[1];
-		p1[2] ^= p2[2] ^ p3[2] ^ p4[2] ^ p5[2];
-		p1[3] ^= p2[3] ^ p3[3] ^ p4[3] ^ p5[3];
-		p1[4] ^= p2[4] ^ p3[4] ^ p4[4] ^ p5[4];
-		p1[5] ^= p2[5] ^ p3[5] ^ p4[5] ^ p5[5];
-		p1[6] ^= p2[6] ^ p3[6] ^ p4[6] ^ p5[6];
-		p1[7] ^= p2[7] ^ p3[7] ^ p4[7] ^ p5[7];
-		p1 += 8;
-		p2 += 8;
-		p3 += 8;
-		p4 += 8;
-		p5 += 8;
-	} while (--lines > 0);
-	if (lines == 0)
-		goto once_more;
-}
-
-static void
-xor_32regs_p_2(unsigned long bytes, unsigned long * __restrict p1,
-	       const unsigned long * __restrict p2)
-{
-	long lines = bytes / (sizeof (long)) / 8 - 1;
-
-	prefetchw(p1);
-	prefetch(p2);
-
-	do {
-		register long d0, d1, d2, d3, d4, d5, d6, d7;
-
-		prefetchw(p1+8);
-		prefetch(p2+8);
- once_more:
-		d0 = p1[0];	/* Pull the stuff into registers	*/
-		d1 = p1[1];	/*  ... in bursts, if possible.		*/
-		d2 = p1[2];
-		d3 = p1[3];
-		d4 = p1[4];
-		d5 = p1[5];
-		d6 = p1[6];
-		d7 = p1[7];
-		d0 ^= p2[0];
-		d1 ^= p2[1];
-		d2 ^= p2[2];
-		d3 ^= p2[3];
-		d4 ^= p2[4];
-		d5 ^= p2[5];
-		d6 ^= p2[6];
-		d7 ^= p2[7];
-		p1[0] = d0;	/* Store the result (in bursts)		*/
-		p1[1] = d1;
-		p1[2] = d2;
-		p1[3] = d3;
-		p1[4] = d4;
-		p1[5] = d5;
-		p1[6] = d6;
-		p1[7] = d7;
-		p1 += 8;
-		p2 += 8;
-	} while (--lines > 0);
-	if (lines == 0)
-		goto once_more;
-}
-
-static void
-xor_32regs_p_3(unsigned long bytes, unsigned long * __restrict p1,
-	       const unsigned long * __restrict p2,
-	       const unsigned long * __restrict p3)
-{
-	long lines = bytes / (sizeof (long)) / 8 - 1;
-
-	prefetchw(p1);
-	prefetch(p2);
-	prefetch(p3);
-
-	do {
-		register long d0, d1, d2, d3, d4, d5, d6, d7;
-
-		prefetchw(p1+8);
-		prefetch(p2+8);
-		prefetch(p3+8);
- once_more:
-		d0 = p1[0];	/* Pull the stuff into registers	*/
-		d1 = p1[1];	/*  ... in bursts, if possible.		*/
-		d2 = p1[2];
-		d3 = p1[3];
-		d4 = p1[4];
-		d5 = p1[5];
-		d6 = p1[6];
-		d7 = p1[7];
-		d0 ^= p2[0];
-		d1 ^= p2[1];
-		d2 ^= p2[2];
-		d3 ^= p2[3];
-		d4 ^= p2[4];
-		d5 ^= p2[5];
-		d6 ^= p2[6];
-		d7 ^= p2[7];
-		d0 ^= p3[0];
-		d1 ^= p3[1];
-		d2 ^= p3[2];
-		d3 ^= p3[3];
-		d4 ^= p3[4];
-		d5 ^= p3[5];
-		d6 ^= p3[6];
-		d7 ^= p3[7];
-		p1[0] = d0;	/* Store the result (in bursts)		*/
-		p1[1] = d1;
-		p1[2] = d2;
-		p1[3] = d3;
-		p1[4] = d4;
-		p1[5] = d5;
-		p1[6] = d6;
-		p1[7] = d7;
-		p1 += 8;
-		p2 += 8;
-		p3 += 8;
-	} while (--lines > 0);
-	if (lines == 0)
-		goto once_more;
-}
-
-static void
-xor_32regs_p_4(unsigned long bytes, unsigned long * __restrict p1,
-	       const unsigned long * __restrict p2,
-	       const unsigned long * __restrict p3,
-	       const unsigned long * __restrict p4)
-{
-	long lines = bytes / (sizeof (long)) / 8 - 1;
-
-	prefetchw(p1);
-	prefetch(p2);
-	prefetch(p3);
-	prefetch(p4);
-
-	do {
-		register long d0, d1, d2, d3, d4, d5, d6, d7;
-
-		prefetchw(p1+8);
-		prefetch(p2+8);
-		prefetch(p3+8);
-		prefetch(p4+8);
- once_more:
-		d0 = p1[0];	/* Pull the stuff into registers	*/
-		d1 = p1[1];	/*  ... in bursts, if possible.		*/
-		d2 = p1[2];
-		d3 = p1[3];
-		d4 = p1[4];
-		d5 = p1[5];
-		d6 = p1[6];
-		d7 = p1[7];
-		d0 ^= p2[0];
-		d1 ^= p2[1];
-		d2 ^= p2[2];
-		d3 ^= p2[3];
-		d4 ^= p2[4];
-		d5 ^= p2[5];
-		d6 ^= p2[6];
-		d7 ^= p2[7];
-		d0 ^= p3[0];
-		d1 ^= p3[1];
-		d2 ^= p3[2];
-		d3 ^= p3[3];
-		d4 ^= p3[4];
-		d5 ^= p3[5];
-		d6 ^= p3[6];
-		d7 ^= p3[7];
-		d0 ^= p4[0];
-		d1 ^= p4[1];
-		d2 ^= p4[2];
-		d3 ^= p4[3];
-		d4 ^= p4[4];
-		d5 ^= p4[5];
-		d6 ^= p4[6];
-		d7 ^= p4[7];
-		p1[0] = d0;	/* Store the result (in bursts)		*/
-		p1[1] = d1;
-		p1[2] = d2;
-		p1[3] = d3;
-		p1[4] = d4;
-		p1[5] = d5;
-		p1[6] = d6;
-		p1[7] = d7;
-		p1 += 8;
-		p2 += 8;
-		p3 += 8;
-		p4 += 8;
-	} while (--lines > 0);
-	if (lines == 0)
-		goto once_more;
-}
-
-static void
-xor_32regs_p_5(unsigned long bytes, unsigned long * __restrict p1,
-	       const unsigned long * __restrict p2,
-	       const unsigned long * __restrict p3,
-	       const unsigned long * __restrict p4,
-	       const unsigned long * __restrict p5)
-{
-	long lines = bytes / (sizeof (long)) / 8 - 1;
-
-	prefetchw(p1);
-	prefetch(p2);
-	prefetch(p3);
-	prefetch(p4);
-	prefetch(p5);
-
-	do {
-		register long d0, d1, d2, d3, d4, d5, d6, d7;
-
-		prefetchw(p1+8);
-		prefetch(p2+8);
-		prefetch(p3+8);
-		prefetch(p4+8);
-		prefetch(p5+8);
- once_more:
-		d0 = p1[0];	/* Pull the stuff into registers	*/
-		d1 = p1[1];	/*  ... in bursts, if possible.		*/
-		d2 = p1[2];
-		d3 = p1[3];
-		d4 = p1[4];
-		d5 = p1[5];
-		d6 = p1[6];
-		d7 = p1[7];
-		d0 ^= p2[0];
-		d1 ^= p2[1];
-		d2 ^= p2[2];
-		d3 ^= p2[3];
-		d4 ^= p2[4];
-		d5 ^= p2[5];
-		d6 ^= p2[6];
-		d7 ^= p2[7];
-		d0 ^= p3[0];
-		d1 ^= p3[1];
-		d2 ^= p3[2];
-		d3 ^= p3[3];
-		d4 ^= p3[4];
-		d5 ^= p3[5];
-		d6 ^= p3[6];
-		d7 ^= p3[7];
-		d0 ^= p4[0];
-		d1 ^= p4[1];
-		d2 ^= p4[2];
-		d3 ^= p4[3];
-		d4 ^= p4[4];
-		d5 ^= p4[5];
-		d6 ^= p4[6];
-		d7 ^= p4[7];
-		d0 ^= p5[0];
-		d1 ^= p5[1];
-		d2 ^= p5[2];
-		d3 ^= p5[3];
-		d4 ^= p5[4];
-		d5 ^= p5[5];
-		d6 ^= p5[6];
-		d7 ^= p5[7];
-		p1[0] = d0;	/* Store the result (in bursts)		*/
-		p1[1] = d1;
-		p1[2] = d2;
-		p1[3] = d3;
-		p1[4] = d4;
-		p1[5] = d5;
-		p1[6] = d6;
-		p1[7] = d7;
-		p1 += 8;
-		p2 += 8;
-		p3 += 8;
-		p4 += 8;
-		p5 += 8;
-	} while (--lines > 0);
-	if (lines == 0)
-		goto once_more;
-}
-
-static struct xor_block_template xor_block_8regs = {
-	.name = "8regs",
-	.do_2 = xor_8regs_2,
-	.do_3 = xor_8regs_3,
-	.do_4 = xor_8regs_4,
-	.do_5 = xor_8regs_5,
-};
-
-static struct xor_block_template xor_block_32regs = {
-	.name = "32regs",
-	.do_2 = xor_32regs_2,
-	.do_3 = xor_32regs_3,
-	.do_4 = xor_32regs_4,
-	.do_5 = xor_32regs_5,
-};
-
-static struct xor_block_template xor_block_8regs_p __maybe_unused = {
-	.name = "8regs_prefetch",
-	.do_2 = xor_8regs_p_2,
-	.do_3 = xor_8regs_p_3,
-	.do_4 = xor_8regs_p_4,
-	.do_5 = xor_8regs_p_5,
-};
-
-static struct xor_block_template xor_block_32regs_p __maybe_unused = {
-	.name = "32regs_prefetch",
-	.do_2 = xor_32regs_p_2,
-	.do_3 = xor_32regs_p_3,
-	.do_4 = xor_32regs_p_4,
-	.do_5 = xor_32regs_p_5,
-};
+extern struct xor_block_template xor_block_8regs;
+extern struct xor_block_template xor_block_32regs;
+extern struct xor_block_template xor_block_8regs_p;
+extern struct xor_block_template xor_block_32regs_p;
diff --git a/lib/raid/xor/Makefile b/lib/raid/xor/Makefile
index 7bca0ce8e90a..89a944c9f990 100644
--- a/lib/raid/xor/Makefile
+++ b/lib/raid/xor/Makefile
@@ -3,3 +3,7 @@
 obj-$(CONFIG_XOR_BLOCKS)	+= xor.o
 
 xor-y				+= xor-core.o
+xor-y				+= xor-8regs.o
+xor-y				+= xor-32regs.o
+xor-y				+= xor-8regs-prefetch.o
+xor-y				+= xor-32regs-prefetch.o
diff --git a/lib/raid/xor/xor-32regs-prefetch.c b/lib/raid/xor/xor-32regs-prefetch.c
new file mode 100644
index 000000000000..8666c287f777
--- /dev/null
+++ b/lib/raid/xor/xor-32regs-prefetch.c
@@ -0,0 +1,268 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/prefetch.h>
+#include <linux/raid/xor_impl.h>
+#include <asm-generic/xor.h>
+
+static void
+xor_32regs_p_2(unsigned long bytes, unsigned long * __restrict p1,
+	       const unsigned long * __restrict p2)
+{
+	long lines = bytes / (sizeof (long)) / 8 - 1;
+
+	prefetchw(p1);
+	prefetch(p2);
+
+	do {
+		register long d0, d1, d2, d3, d4, d5, d6, d7;
+
+		prefetchw(p1+8);
+		prefetch(p2+8);
+ once_more:
+		d0 = p1[0];	/* Pull the stuff into registers	*/
+		d1 = p1[1];	/*  ... in bursts, if possible.		*/
+		d2 = p1[2];
+		d3 = p1[3];
+		d4 = p1[4];
+		d5 = p1[5];
+		d6 = p1[6];
+		d7 = p1[7];
+		d0 ^= p2[0];
+		d1 ^= p2[1];
+		d2 ^= p2[2];
+		d3 ^= p2[3];
+		d4 ^= p2[4];
+		d5 ^= p2[5];
+		d6 ^= p2[6];
+		d7 ^= p2[7];
+		p1[0] = d0;	/* Store the result (in bursts)		*/
+		p1[1] = d1;
+		p1[2] = d2;
+		p1[3] = d3;
+		p1[4] = d4;
+		p1[5] = d5;
+		p1[6] = d6;
+		p1[7] = d7;
+		p1 += 8;
+		p2 += 8;
+	} while (--lines > 0);
+	if (lines == 0)
+		goto once_more;
+}
+
+static void
+xor_32regs_p_3(unsigned long bytes, unsigned long * __restrict p1,
+	       const unsigned long * __restrict p2,
+	       const unsigned long * __restrict p3)
+{
+	long lines = bytes / (sizeof (long)) / 8 - 1;
+
+	prefetchw(p1);
+	prefetch(p2);
+	prefetch(p3);
+
+	do {
+		register long d0, d1, d2, d3, d4, d5, d6, d7;
+
+		prefetchw(p1+8);
+		prefetch(p2+8);
+		prefetch(p3+8);
+ once_more:
+		d0 = p1[0];	/* Pull the stuff into registers	*/
+		d1 = p1[1];	/*  ... in bursts, if possible.		*/
+		d2 = p1[2];
+		d3 = p1[3];
+		d4 = p1[4];
+		d5 = p1[5];
+		d6 = p1[6];
+		d7 = p1[7];
+		d0 ^= p2[0];
+		d1 ^= p2[1];
+		d2 ^= p2[2];
+		d3 ^= p2[3];
+		d4 ^= p2[4];
+		d5 ^= p2[5];
+		d6 ^= p2[6];
+		d7 ^= p2[7];
+		d0 ^= p3[0];
+		d1 ^= p3[1];
+		d2 ^= p3[2];
+		d3 ^= p3[3];
+		d4 ^= p3[4];
+		d5 ^= p3[5];
+		d6 ^= p3[6];
+		d7 ^= p3[7];
+		p1[0] = d0;	/* Store the result (in bursts)		*/
+		p1[1] = d1;
+		p1[2] = d2;
+		p1[3] = d3;
+		p1[4] = d4;
+		p1[5] = d5;
+		p1[6] = d6;
+		p1[7] = d7;
+		p1 += 8;
+		p2 += 8;
+		p3 += 8;
+	} while (--lines > 0);
+	if (lines == 0)
+		goto once_more;
+}
+
+static void
+xor_32regs_p_4(unsigned long bytes, unsigned long * __restrict p1,
+	       const unsigned long * __restrict p2,
+	       const unsigned long * __restrict p3,
+	       const unsigned long * __restrict p4)
+{
+	long lines = bytes / (sizeof (long)) / 8 - 1;
+
+	prefetchw(p1);
+	prefetch(p2);
+	prefetch(p3);
+	prefetch(p4);
+
+	do {
+		register long d0, d1, d2, d3, d4, d5, d6, d7;
+
+		prefetchw(p1+8);
+		prefetch(p2+8);
+		prefetch(p3+8);
+		prefetch(p4+8);
+ once_more:
+		d0 = p1[0];	/* Pull the stuff into registers	*/
+		d1 = p1[1];	/*  ... in bursts, if possible.		*/
+		d2 = p1[2];
+		d3 = p1[3];
+		d4 = p1[4];
+		d5 = p1[5];
+		d6 = p1[6];
+		d7 = p1[7];
+		d0 ^= p2[0];
+		d1 ^= p2[1];
+		d2 ^= p2[2];
+		d3 ^= p2[3];
+		d4 ^= p2[4];
+		d5 ^= p2[5];
+		d6 ^= p2[6];
+		d7 ^= p2[7];
+		d0 ^= p3[0];
+		d1 ^= p3[1];
+		d2 ^= p3[2];
+		d3 ^= p3[3];
+		d4 ^= p3[4];
+		d5 ^= p3[5];
+		d6 ^= p3[6];
+		d7 ^= p3[7];
+		d0 ^= p4[0];
+		d1 ^= p4[1];
+		d2 ^= p4[2];
+		d3 ^= p4[3];
+		d4 ^= p4[4];
+		d5 ^= p4[5];
+		d6 ^= p4[6];
+		d7 ^= p4[7];
+		p1[0] = d0;	/* Store the result (in bursts)		*/
+		p1[1] = d1;
+		p1[2] = d2;
+		p1[3] = d3;
+		p1[4] = d4;
+		p1[5] = d5;
+		p1[6] = d6;
+		p1[7] = d7;
+		p1 += 8;
+		p2 += 8;
+		p3 += 8;
+		p4 += 8;
+	} while (--lines > 0);
+	if (lines == 0)
+		goto once_more;
+}
+
+static void
+xor_32regs_p_5(unsigned long bytes, unsigned long * __restrict p1,
+	       const unsigned long * __restrict p2,
+	       const unsigned long * __restrict p3,
+	       const unsigned long * __restrict p4,
+	       const unsigned long * __restrict p5)
+{
+	long lines = bytes / (sizeof (long)) / 8 - 1;
+
+	prefetchw(p1);
+	prefetch(p2);
+	prefetch(p3);
+	prefetch(p4);
+	prefetch(p5);
+
+	do {
+		register long d0, d1, d2, d3, d4, d5, d6, d7;
+
+		prefetchw(p1+8);
+		prefetch(p2+8);
+		prefetch(p3+8);
+		prefetch(p4+8);
+		prefetch(p5+8);
+ once_more:
+		d0 = p1[0];	/* Pull the stuff into registers	*/
+		d1 = p1[1];	/*  ... in bursts, if possible.		*/
+		d2 = p1[2];
+		d3 = p1[3];
+		d4 = p1[4];
+		d5 = p1[5];
+		d6 = p1[6];
+		d7 = p1[7];
+		d0 ^= p2[0];
+		d1 ^= p2[1];
+		d2 ^= p2[2];
+		d3 ^= p2[3];
+		d4 ^= p2[4];
+		d5 ^= p2[5];
+		d6 ^= p2[6];
+		d7 ^= p2[7];
+		d0 ^= p3[0];
+		d1 ^= p3[1];
+		d2 ^= p3[2];
+		d3 ^= p3[3];
+		d4 ^= p3[4];
+		d5 ^= p3[5];
+		d6 ^= p3[6];
+		d7 ^= p3[7];
+		d0 ^= p4[0];
+		d1 ^= p4[1];
+		d2 ^= p4[2];
+		d3 ^= p4[3];
+		d4 ^= p4[4];
+		d5 ^= p4[5];
+		d6 ^= p4[6];
+		d7 ^= p4[7];
+		d0 ^= p5[0];
+		d1 ^= p5[1];
+		d2 ^= p5[2];
+		d3 ^= p5[3];
+		d4 ^= p5[4];
+		d5 ^= p5[5];
+		d6 ^= p5[6];
+		d7 ^= p5[7];
+		p1[0] = d0;	/* Store the result (in bursts)		*/
+		p1[1] = d1;
+		p1[2] = d2;
+		p1[3] = d3;
+		p1[4] = d4;
+		p1[5] = d5;
+		p1[6] = d6;
+		p1[7] = d7;
+		p1 += 8;
+		p2 += 8;
+		p3 += 8;
+		p4 += 8;
+		p5 += 8;
+	} while (--lines > 0);
+	if (lines == 0)
+		goto once_more;
+}
+
+struct xor_block_template xor_block_32regs_p = {
+	.name = "32regs_prefetch",
+	.do_2 = xor_32regs_p_2,
+	.do_3 = xor_32regs_p_3,
+	.do_4 = xor_32regs_p_4,
+	.do_5 = xor_32regs_p_5,
+};
diff --git a/lib/raid/xor/xor-32regs.c b/lib/raid/xor/xor-32regs.c
new file mode 100644
index 000000000000..58d4fac43eb4
--- /dev/null
+++ b/lib/raid/xor/xor-32regs.c
@@ -0,0 +1,219 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/raid/xor_impl.h>
+#include <asm-generic/xor.h>
+
+static void
+xor_32regs_2(unsigned long bytes, unsigned long * __restrict p1,
+	     const unsigned long * __restrict p2)
+{
+	long lines = bytes / (sizeof (long)) / 8;
+
+	do {
+		register long d0, d1, d2, d3, d4, d5, d6, d7;
+		d0 = p1[0];	/* Pull the stuff into registers	*/
+		d1 = p1[1];	/*  ... in bursts, if possible.		*/
+		d2 = p1[2];
+		d3 = p1[3];
+		d4 = p1[4];
+		d5 = p1[5];
+		d6 = p1[6];
+		d7 = p1[7];
+		d0 ^= p2[0];
+		d1 ^= p2[1];
+		d2 ^= p2[2];
+		d3 ^= p2[3];
+		d4 ^= p2[4];
+		d5 ^= p2[5];
+		d6 ^= p2[6];
+		d7 ^= p2[7];
+		p1[0] = d0;	/* Store the result (in bursts)		*/
+		p1[1] = d1;
+		p1[2] = d2;
+		p1[3] = d3;
+		p1[4] = d4;
+		p1[5] = d5;
+		p1[6] = d6;
+		p1[7] = d7;
+		p1 += 8;
+		p2 += 8;
+	} while (--lines > 0);
+}
+
+static void
+xor_32regs_3(unsigned long bytes, unsigned long * __restrict p1,
+	     const unsigned long * __restrict p2,
+	     const unsigned long * __restrict p3)
+{
+	long lines = bytes / (sizeof (long)) / 8;
+
+	do {
+		register long d0, d1, d2, d3, d4, d5, d6, d7;
+		d0 = p1[0];	/* Pull the stuff into registers	*/
+		d1 = p1[1];	/*  ... in bursts, if possible.		*/
+		d2 = p1[2];
+		d3 = p1[3];
+		d4 = p1[4];
+		d5 = p1[5];
+		d6 = p1[6];
+		d7 = p1[7];
+		d0 ^= p2[0];
+		d1 ^= p2[1];
+		d2 ^= p2[2];
+		d3 ^= p2[3];
+		d4 ^= p2[4];
+		d5 ^= p2[5];
+		d6 ^= p2[6];
+		d7 ^= p2[7];
+		d0 ^= p3[0];
+		d1 ^= p3[1];
+		d2 ^= p3[2];
+		d3 ^= p3[3];
+		d4 ^= p3[4];
+		d5 ^= p3[5];
+		d6 ^= p3[6];
+		d7 ^= p3[7];
+		p1[0] = d0;	/* Store the result (in bursts)		*/
+		p1[1] = d1;
+		p1[2] = d2;
+		p1[3] = d3;
+		p1[4] = d4;
+		p1[5] = d5;
+		p1[6] = d6;
+		p1[7] = d7;
+		p1 += 8;
+		p2 += 8;
+		p3 += 8;
+	} while (--lines > 0);
+}
+
+static void
+xor_32regs_4(unsigned long bytes, unsigned long * __restrict p1,
+	     const unsigned long * __restrict p2,
+	     const unsigned long * __restrict p3,
+	     const unsigned long * __restrict p4)
+{
+	long lines = bytes / (sizeof (long)) / 8;
+
+	do {
+		register long d0, d1, d2, d3, d4, d5, d6, d7;
+		d0 = p1[0];	/* Pull the stuff into registers	*/
+		d1 = p1[1];	/*  ... in bursts, if possible.		*/
+		d2 = p1[2];
+		d3 = p1[3];
+		d4 = p1[4];
+		d5 = p1[5];
+		d6 = p1[6];
+		d7 = p1[7];
+		d0 ^= p2[0];
+		d1 ^= p2[1];
+		d2 ^= p2[2];
+		d3 ^= p2[3];
+		d4 ^= p2[4];
+		d5 ^= p2[5];
+		d6 ^= p2[6];
+		d7 ^= p2[7];
+		d0 ^= p3[0];
+		d1 ^= p3[1];
+		d2 ^= p3[2];
+		d3 ^= p3[3];
+		d4 ^= p3[4];
+		d5 ^= p3[5];
+		d6 ^= p3[6];
+		d7 ^= p3[7];
+		d0 ^= p4[0];
+		d1 ^= p4[1];
+		d2 ^= p4[2];
+		d3 ^= p4[3];
+		d4 ^= p4[4];
+		d5 ^= p4[5];
+		d6 ^= p4[6];
+		d7 ^= p4[7];
+		p1[0] = d0;	/* Store the result (in bursts)		*/
+		p1[1] = d1;
+		p1[2] = d2;
+		p1[3] = d3;
+		p1[4] = d4;
+		p1[5] = d5;
+		p1[6] = d6;
+		p1[7] = d7;
+		p1 += 8;
+		p2 += 8;
+		p3 += 8;
+		p4 += 8;
+	} while (--lines > 0);
+}
+
+static void
+xor_32regs_5(unsigned long bytes, unsigned long * __restrict p1,
+	     const unsigned long * __restrict p2,
+	     const unsigned long * __restrict p3,
+	     const unsigned long * __restrict p4,
+	     const unsigned long * __restrict p5)
+{
+	long lines = bytes / (sizeof (long)) / 8;
+
+	do {
+		register long d0, d1, d2, d3, d4, d5, d6, d7;
+		d0 = p1[0];	/* Pull the stuff into registers	*/
+		d1 = p1[1];	/*  ... in bursts, if possible.		*/
+		d2 = p1[2];
+		d3 = p1[3];
+		d4 = p1[4];
+		d5 = p1[5];
+		d6 = p1[6];
+		d7 = p1[7];
+		d0 ^= p2[0];
+		d1 ^= p2[1];
+		d2 ^= p2[2];
+		d3 ^= p2[3];
+		d4 ^= p2[4];
+		d5 ^= p2[5];
+		d6 ^= p2[6];
+		d7 ^= p2[7];
+		d0 ^= p3[0];
+		d1 ^= p3[1];
+		d2 ^= p3[2];
+		d3 ^= p3[3];
+		d4 ^= p3[4];
+		d5 ^= p3[5];
+		d6 ^= p3[6];
+		d7 ^= p3[7];
+		d0 ^= p4[0];
+		d1 ^= p4[1];
+		d2 ^= p4[2];
+		d3 ^= p4[3];
+		d4 ^= p4[4];
+		d5 ^= p4[5];
+		d6 ^= p4[6];
+		d7 ^= p4[7];
+		d0 ^= p5[0];
+		d1 ^= p5[1];
+		d2 ^= p5[2];
+		d3 ^= p5[3];
+		d4 ^= p5[4];
+		d5 ^= p5[5];
+		d6 ^= p5[6];
+		d7 ^= p5[7];
+		p1[0] = d0;	/* Store the result (in bursts)		*/
+		p1[1] = d1;
+		p1[2] = d2;
+		p1[3] = d3;
+		p1[4] = d4;
+		p1[5] = d5;
+		p1[6] = d6;
+		p1[7] = d7;
+		p1 += 8;
+		p2 += 8;
+		p3 += 8;
+		p4 += 8;
+		p5 += 8;
+	} while (--lines > 0);
+}
+
+struct xor_block_template xor_block_32regs = {
+	.name = "32regs",
+	.do_2 = xor_32regs_2,
+	.do_3 = xor_32regs_3,
+	.do_4 = xor_32regs_4,
+	.do_5 = xor_32regs_5,
+};
diff --git a/lib/raid/xor/xor-8regs-prefetch.c b/lib/raid/xor/xor-8regs-prefetch.c
new file mode 100644
index 000000000000..67061e35a0a6
--- /dev/null
+++ b/lib/raid/xor/xor-8regs-prefetch.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/prefetch.h>
+#include <linux/raid/xor_impl.h>
+#include <asm-generic/xor.h>
+
+static void
+xor_8regs_p_2(unsigned long bytes, unsigned long * __restrict p1,
+	      const unsigned long * __restrict p2)
+{
+	long lines = bytes / (sizeof (long)) / 8 - 1;
+	prefetchw(p1);
+	prefetch(p2);
+
+	do {
+		prefetchw(p1+8);
+		prefetch(p2+8);
+ once_more:
+		p1[0] ^= p2[0];
+		p1[1] ^= p2[1];
+		p1[2] ^= p2[2];
+		p1[3] ^= p2[3];
+		p1[4] ^= p2[4];
+		p1[5] ^= p2[5];
+		p1[6] ^= p2[6];
+		p1[7] ^= p2[7];
+		p1 += 8;
+		p2 += 8;
+	} while (--lines > 0);
+	if (lines == 0)
+		goto once_more;
+}
+
+static void
+xor_8regs_p_3(unsigned long bytes, unsigned long * __restrict p1,
+	      const unsigned long * __restrict p2,
+	      const unsigned long * __restrict p3)
+{
+	long lines = bytes / (sizeof (long)) / 8 - 1;
+	prefetchw(p1);
+	prefetch(p2);
+	prefetch(p3);
+
+	do {
+		prefetchw(p1+8);
+		prefetch(p2+8);
+		prefetch(p3+8);
+ once_more:
+		p1[0] ^= p2[0] ^ p3[0];
+		p1[1] ^= p2[1] ^ p3[1];
+		p1[2] ^= p2[2] ^ p3[2];
+		p1[3] ^= p2[3] ^ p3[3];
+		p1[4] ^= p2[4] ^ p3[4];
+		p1[5] ^= p2[5] ^ p3[5];
+		p1[6] ^= p2[6] ^ p3[6];
+		p1[7] ^= p2[7] ^ p3[7];
+		p1 += 8;
+		p2 += 8;
+		p3 += 8;
+	} while (--lines > 0);
+	if (lines == 0)
+		goto once_more;
+}
+
+static void
+xor_8regs_p_4(unsigned long bytes, unsigned long * __restrict p1,
+	      const unsigned long * __restrict p2,
+	      const unsigned long * __restrict p3,
+	      const unsigned long * __restrict p4)
+{
+	long lines = bytes / (sizeof (long)) / 8 - 1;
+
+	prefetchw(p1);
+	prefetch(p2);
+	prefetch(p3);
+	prefetch(p4);
+
+	do {
+		prefetchw(p1+8);
+		prefetch(p2+8);
+		prefetch(p3+8);
+		prefetch(p4+8);
+ once_more:
+		p1[0] ^= p2[0] ^ p3[0] ^ p4[0];
+		p1[1] ^= p2[1] ^ p3[1] ^ p4[1];
+		p1[2] ^= p2[2] ^ p3[2] ^ p4[2];
+		p1[3] ^= p2[3] ^ p3[3] ^ p4[3];
+		p1[4] ^= p2[4] ^ p3[4] ^ p4[4];
+		p1[5] ^= p2[5] ^ p3[5] ^ p4[5];
+		p1[6] ^= p2[6] ^ p3[6] ^ p4[6];
+		p1[7] ^= p2[7] ^ p3[7] ^ p4[7];
+		p1 += 8;
+		p2 += 8;
+		p3 += 8;
+		p4 += 8;
+	} while (--lines > 0);
+	if (lines == 0)
+		goto once_more;
+}
+
+static void
+xor_8regs_p_5(unsigned long bytes, unsigned long * __restrict p1,
+	      const unsigned long * __restrict p2,
+	      const unsigned long * __restrict p3,
+	      const unsigned long * __restrict p4,
+	      const unsigned long * __restrict p5)
+{
+	long lines = bytes / (sizeof (long)) / 8 - 1;
+
+	prefetchw(p1);
+	prefetch(p2);
+	prefetch(p3);
+	prefetch(p4);
+	prefetch(p5);
+
+	do {
+		prefetchw(p1+8);
+		prefetch(p2+8);
+		prefetch(p3+8);
+		prefetch(p4+8);
+		prefetch(p5+8);
+ once_more:
+		p1[0] ^= p2[0] ^ p3[0] ^ p4[0] ^ p5[0];
+		p1[1] ^= p2[1] ^ p3[1] ^ p4[1] ^ p5[1];
+		p1[2] ^= p2[2] ^ p3[2] ^ p4[2] ^ p5[2];
+		p1[3] ^= p2[3] ^ p3[3] ^ p4[3] ^ p5[3];
+		p1[4] ^= p2[4] ^ p3[4] ^ p4[4] ^ p5[4];
+		p1[5] ^= p2[5] ^ p3[5] ^ p4[5] ^ p5[5];
+		p1[6] ^= p2[6] ^ p3[6] ^ p4[6] ^ p5[6];
+		p1[7] ^= p2[7] ^ p3[7] ^ p4[7] ^ p5[7];
+		p1 += 8;
+		p2 += 8;
+		p3 += 8;
+		p4 += 8;
+		p5 += 8;
+	} while (--lines > 0);
+	if (lines == 0)
+		goto once_more;
+}
+
+struct xor_block_template xor_block_8regs_p = {
+	.name = "8regs_prefetch",
+	.do_2 = xor_8regs_p_2,
+	.do_3 = xor_8regs_p_3,
+	.do_4 = xor_8regs_p_4,
+	.do_5 = xor_8regs_p_5,
+};
diff --git a/lib/raid/xor/xor-8regs.c b/lib/raid/xor/xor-8regs.c
new file mode 100644
index 000000000000..769f796ab2cf
--- /dev/null
+++ b/lib/raid/xor/xor-8regs.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/raid/xor_impl.h>
+#include <asm-generic/xor.h>
+
+static void
+xor_8regs_2(unsigned long bytes, unsigned long * __restrict p1,
+	    const unsigned long * __restrict p2)
+{
+	long lines = bytes / (sizeof (long)) / 8;
+
+	do {
+		p1[0] ^= p2[0];
+		p1[1] ^= p2[1];
+		p1[2] ^= p2[2];
+		p1[3] ^= p2[3];
+		p1[4] ^= p2[4];
+		p1[5] ^= p2[5];
+		p1[6] ^= p2[6];
+		p1[7] ^= p2[7];
+		p1 += 8;
+		p2 += 8;
+	} while (--lines > 0);
+}
+
+static void
+xor_8regs_3(unsigned long bytes, unsigned long * __restrict p1,
+	    const unsigned long * __restrict p2,
+	    const unsigned long * __restrict p3)
+{
+	long lines = bytes / (sizeof (long)) / 8;
+
+	do {
+		p1[0] ^= p2[0] ^ p3[0];
+		p1[1] ^= p2[1] ^ p3[1];
+		p1[2] ^= p2[2] ^ p3[2];
+		p1[3] ^= p2[3] ^ p3[3];
+		p1[4] ^= p2[4] ^ p3[4];
+		p1[5] ^= p2[5] ^ p3[5];
+		p1[6] ^= p2[6] ^ p3[6];
+		p1[7] ^= p2[7] ^ p3[7];
+		p1 += 8;
+		p2 += 8;
+		p3 += 8;
+	} while (--lines > 0);
+}
+
+static void
+xor_8regs_4(unsigned long bytes, unsigned long * __restrict p1,
+	    const unsigned long * __restrict p2,
+	    const unsigned long * __restrict p3,
+	    const unsigned long * __restrict p4)
+{
+	long lines = bytes / (sizeof (long)) / 8;
+
+	do {
+		p1[0] ^= p2[0] ^ p3[0] ^ p4[0];
+		p1[1] ^= p2[1] ^ p3[1] ^ p4[1];
+		p1[2] ^= p2[2] ^ p3[2] ^ p4[2];
+		p1[3] ^= p2[3] ^ p3[3] ^ p4[3];
+		p1[4] ^= p2[4] ^ p3[4] ^ p4[4];
+		p1[5] ^= p2[5] ^ p3[5] ^ p4[5];
+		p1[6] ^= p2[6] ^ p3[6] ^ p4[6];
+		p1[7] ^= p2[7] ^ p3[7] ^ p4[7];
+		p1 += 8;
+		p2 += 8;
+		p3 += 8;
+		p4 += 8;
+	} while (--lines > 0);
+}
+
+static void
+xor_8regs_5(unsigned long bytes, unsigned long * __restrict p1,
+	    const unsigned long * __restrict p2,
+	    const unsigned long * __restrict p3,
+	    const unsigned long * __restrict p4,
+	    const unsigned long * __restrict p5)
+{
+	long lines = bytes / (sizeof (long)) / 8;
+
+	do {
+		p1[0] ^= p2[0] ^ p3[0] ^ p4[0] ^ p5[0];
+		p1[1] ^= p2[1] ^ p3[1] ^ p4[1] ^ p5[1];
+		p1[2] ^= p2[2] ^ p3[2] ^ p4[2] ^ p5[2];
+		p1[3] ^= p2[3] ^ p3[3] ^ p4[3] ^ p5[3];
+		p1[4] ^= p2[4] ^ p3[4] ^ p4[4] ^ p5[4];
+		p1[5] ^= p2[5] ^ p3[5] ^ p4[5] ^ p5[5];
+		p1[6] ^= p2[6] ^ p3[6] ^ p4[6] ^ p5[6];
+		p1[7] ^= p2[7] ^ p3[7] ^ p4[7] ^ p5[7];
+		p1 += 8;
+		p2 += 8;
+		p3 += 8;
+		p4 += 8;
+		p5 += 8;
+	} while (--lines > 0);
+}
+
+#ifndef NO_TEMPLATE
+struct xor_block_template xor_block_8regs = {
+	.name = "8regs",
+	.do_2 = xor_8regs_2,
+	.do_3 = xor_8regs_3,
+	.do_4 = xor_8regs_4,
+	.do_5 = xor_8regs_5,
+};
+#endif /* NO_TEMPLATE */
-- 
2.47.3


