Return-Path: <linuxppc-dev+bounces-18682-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65FA0F532E6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 06:26:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fg0RV0v7Tz2yv8;
	Tue, 24 Mar 2026 17:26:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774333574;
	cv=none; b=jS8MqkXyGCOcDOHa6199xojWuArZ2cNf+UCHTNXnjjTjGC+MEbG5nYTgYg+HXF4vaGCOUp6TW8S9RSXxJBNEqe4h1g2eLFEIKKdDWl7WzgPvFNyaDsrFqRk868kLk+SCQNL8c83plHHy+PWNvxaMKMOxz2zsjoukrZ5qDAc5NPKyyXW9Flb0eJVxRdqaIrrP5YbmmC/gKIy3pPhoJlMj9pJNgS1CYh5MvJRfeDdDKZ+imZb14aNVM56ZqtgnoQws4rSVVWW5piMRmr/O8PUKHPTr49fcjl6oUc5hLdoe9HSwpKdWB2jIOn3Cwd6K63L/CrJwveqSwxYQdiURCfLwqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774333574; c=relaxed/relaxed;
	bh=BdVPVlwvvRbu6Ap4c1Yxra64LIHrZ5JEG5D01pyAOLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b2JZ4vMVPVa7pBjzDvM7vU3+2g9wD94wvvHa/7Y56hrOFdy1HvQgvizqvPOFgbK3X2juynKGqJemazFUOBTBSxy6m/S8OAQK6fY16b7KyQzjdbsNlYPb+vD8p9PqxYZqSU9SdojwqtU7XYYWKMKVuhIbSNPrqoHhN3+sITZqB5bO5QHkdHSRDN61gR1RrjxHZRiUvYydmaR/sUEJB2gg5yTL5eyFghAO2kWVXvevWM6jcpzqdY6hZ6Lk958w/6hUwX/qgDkl7u7H719xp8I5XZx82jZze731jb3WWAGtYIDKK7Bnj5q6bVKQv/bv4LeSTmJYU7BXi/7XZq1CIqtdoA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=x1qD4bxU; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+4a75e1166b7f241dd976+8248+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=x1qD4bxU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+4a75e1166b7f241dd976+8248+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fg0RT3LfPz2yv7
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2026 17:26:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=BdVPVlwvvRbu6Ap4c1Yxra64LIHrZ5JEG5D01pyAOLU=; b=x1qD4bxUPvOViPh8YowPp7pT8T
	e4CIIc0oZ1s+XVX3RtsaKlTOHM54s/atIL7YpLIQxJRW0OoNLY2gIi14h2tL+N+MlbnKMHdRsqO5V
	YcaXZ3YtAyI9pgdJTmLy7gOrpzQ4Vu0xXVSDY9Exag9x7RKaAJZP9vr8hHUblT6KCnqk/M6VdTBl+
	Z5ONUyhfrilJ7nKMVPLsFfqJ/w5iUUsf2/7Qe0Nl53uyx9Rk2je3E1Oh3wDvOGkKOSC0umDFiBrLr
	hlcbHEVQ7S8EHHhEszNSTwPI7pMc7/Mtr4LIfMWKLQPpWRoIy/qMPQ1RG5uNYWjGxEuqy78Y6S56s
	9A6NivcQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4vDA-00000000ijg-3XZo;
	Tue, 24 Mar 2026 06:25:57 +0000
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
Subject: [PATCH 17/26] s390: move the XOR code to lib/raid/
Date: Tue, 24 Mar 2026 07:21:53 +0100
Message-ID: <20260324062211.3216301-18-hch@lst.de>
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
instead of unconditionally building it into the main kernel image.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
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
index 3a7c887d08ee..3db6c2b2f26a 100644
--- a/lib/raid/xor/Makefile
+++ b/lib/raid/xor/Makefile
@@ -20,6 +20,7 @@ xor-$(CONFIG_ALTIVEC)		+= powerpc/xor_vmx.o powerpc/xor_vmx_glue.o
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


