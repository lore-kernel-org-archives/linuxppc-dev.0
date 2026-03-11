Return-Path: <linuxppc-dev+bounces-18028-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDABEFD0640
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 07:08:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fW20X2vCwz3dHc;
	Wed, 11 Mar 2026 18:08:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773212924;
	cv=none; b=bZhalL9nmOcNaOwvKnAGZhTHupufeVc7rFZlzQ+RDHDMufqgNEzesgmMuywgIcl1Q5VMYnvB6JIvfNYjKsBmpMEevg2Vj2kuTsS66d1ZN+4nO+7NELnYJAwK/GCjvDqnswcwzXE6LLnlQagoNonocB38b4qHuFjI2SA8a3WIck384oWZdLq0bapy87jSxLPEsVaN6M9yA6LAzcIMo7a2ZySIDrEVa/oPmQZ58+x21S28GOIeQBMJHqeGHU7FlrtKq/683fJC2IvT9VGUNZZpM4/f8d1FCXYkx4nLRaShlK79T5yxv9kSlU7cCd42paGdQYTEmW2d8HgrIi04dcud6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773212924; c=relaxed/relaxed;
	bh=OozIivWV1OVf85Q4SQObewHqt7fxdmyYRjv0+C9ii+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mAqyT5KP97Y/z3RyutGqfK0e7/w/wOdCD6sBYY/KG/qjP9WFYlbdTiw2wXlRUpxhz8hDEora7cS5MDo4NOh89tZl2JqfwF73UwHvFFr25F6hF2GJUgZ2tjNjAub+fYIcTWuqHOqEu9q4F3KpnDjiLtVRnICo956MNbuPhVSu/KS7oqb5x6mf4B/cSBE9MnoezqkzV4wNqrcZD9XYr1XxZsWbkrAAGB0EOYgeHVcUo5dX4LMOgR0TKYpCVFnTXrsork8MJ6VDNQhPCQOGoWRwjbq4+AH2KOKrivEoGKgG+M9rfAwCrB29WIhtIrmpG8UtHrn1X7BWeWttocKVoWjGmg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Szpf4tJi; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+bcc67bb7b2d0717eac20+8235+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Szpf4tJi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+bcc67bb7b2d0717eac20+8235+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fW20W0Xmyz3dHR
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 18:08:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=OozIivWV1OVf85Q4SQObewHqt7fxdmyYRjv0+C9ii+w=; b=Szpf4tJi1JojPXE3lEbt/s4OS1
	t7YKi6SFYv461pHJ6/JEIMTmjpBt1sl6UJlAACjizWbCq6cn44JUtkzaPxQ4fmNY0ftoK91SwVsv8
	kxurhUaHKfd1SMwzRs+ZNC6xBCTHTt/35OTtbywe1thBngnmCY5i5YoIzxqqwpzkOe1Eek7gIg5h9
	O4lqTWJteZwb1RBljEhRo3Bxj2sTCUXEhpfTEiqPSG/5gYsEj6jRojlxs8pbHS/Fd011BeNtCOheF
	R3L1LBbauMD6a1kBH33sqLO79WgtYnTHj3HrWMi0lGlAl2EW4hphrv1x7z2z2b+qa0UwOOOhxXXMW
	ue+9IMmA==;
Received: from [212.243.42.10] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0DgA-0000000B0HC-45Tc;
	Wed, 11 Mar 2026 07:08:27 +0000
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
Subject: [PATCH 17/27] s390: move the XOR code to lib/raid/
Date: Wed, 11 Mar 2026 08:03:49 +0100
Message-ID: <20260311070416.972667-18-hch@lst.de>
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
instead of unconditionally building it into the main kernel image.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/s390/lib/Makefile                     | 2 +-
 lib/raid/xor/Makefile                      | 1 +
 {arch/s390/lib => lib/raid/xor/s390}/xor.c | 2 --
 3 files changed, 2 insertions(+), 3 deletions(-)
 rename {arch/s390/lib => lib/raid/xor/s390}/xor.c (98%)

diff --git a/arch/s390/lib/Makefile b/arch/s390/lib/Makefile
index f43f897d3fc0..2bf47204f6ab 100644
--- a/arch/s390/lib/Makefile
+++ b/arch/s390/lib/Makefile
@@ -5,7 +5,7 @@
 
 lib-y += delay.o string.o uaccess.o find.o spinlock.o tishift.o
 lib-y += csum-partial.o
-obj-y += mem.o xor.o
+obj-y += mem.o
 lib-$(CONFIG_KPROBES) += probes.o
 lib-$(CONFIG_UPROBES) += probes.o
 obj-$(CONFIG_S390_KPROBES_SANITY_TEST) += test_kprobes_s390.o
diff --git a/lib/raid/xor/Makefile b/lib/raid/xor/Makefile
index ddcd78ca55c5..66c62f418696 100644
--- a/lib/raid/xor/Makefile
+++ b/lib/raid/xor/Makefile
@@ -21,6 +21,7 @@ xor-$(CONFIG_ALTIVEC)		+= powerpc/xor_vmx.o powerpc/xor_vmx_glue.o
 xor-$(CONFIG_RISCV_ISA_V)	+= riscv/xor.o riscv/xor-glue.o
 xor-$(CONFIG_SPARC32)		+= sparc/xor-sparc32.o
 xor-$(CONFIG_SPARC64)		+= sparc/xor-sparc64.o sparc/xor-sparc64-glue.o
+xor-$(CONFIG_S390)		+= s390/xor.o
 
 
 CFLAGS_arm/xor-neon.o		+= $(CC_FLAGS_FPU)
diff --git a/arch/s390/lib/xor.c b/lib/raid/xor/s390/xor.c
similarity index 98%
rename from arch/s390/lib/xor.c
rename to lib/raid/xor/s390/xor.c
index 3bbe21b40e66..acbd268adfc8 100644
--- a/arch/s390/lib/xor.c
+++ b/lib/raid/xor/s390/xor.c
@@ -7,7 +7,6 @@
  */
 
 #include <linux/types.h>
-#include <linux/export.h>
 #include <linux/raid/xor_impl.h>
 #include <asm/xor.h>
 
@@ -133,4 +132,3 @@ struct xor_block_template xor_block_xc = {
 	.do_4 = xor_xc_4,
 	.do_5 = xor_xc_5,
 };
-EXPORT_SYMBOL(xor_block_xc);
-- 
2.47.3


