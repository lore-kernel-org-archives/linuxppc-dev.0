Return-Path: <linuxppc-dev+bounces-17295-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA53FD8FC5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Feb 2026 15:13:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMFLD5Jyxz3cPl;
	Fri, 27 Feb 2026 02:12:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772118724;
	cv=none; b=c0SiTXUUFUye3V38NKLArhUsvY8yP+P1rpTEuIMELkwKYfpKD65lqrJBC5Xgv7xbp7U+ex/4H0d1RrE5wPXataUvYPZQ1DDlZx2D6DLHju/vZvQe8EOBu6QzRFQgkypJ3ogDGvzwyRZQe5nxNvgwdwaeV4KW4V1k6XTRW/WUgI8G6j88FcpIiR5SSfbY/4RuXrQNEPWvmTFXZOcbWh27dzH4RSVlyTdf13XYniytvBVINnvsjofkUQslFMpq6H/TeZaO/MpK6h2QtYtp1dOSkiyjll4MqkNS5ig9OyyYYQvgeXpYAlj7FRLmcnGFaIv3ri4mqtFimf+0b6NFA10R0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772118724; c=relaxed/relaxed;
	bh=Iojt6ABC36hZ6qPmKwT+Q9wyR57qrAUPmBlE40Pk7uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vk6a+N5yaW4IiH+A/gWWov8E9HcERLr03idwVhWjYM+sacW/8RoObru5qsJoWAsMMdAd+3nac0peO8epNsvcjIx7d9Jcw04qjGxDlHyzwcLJDalPuFB8Tk7z09FG6aY8g9ojSEDca6U5k2+fie0Obj5bkhQhMRvc4+7NqgLwGR2R4qbdvTBcHoWYl5imKfSp8pon1tAsOP1iWLaIgDXosURATGWndCKLlK7qtP5X7zYogJVCU7j186P9mJ6JshryB5OmREagRPqchjy8Aa+P8hG7s7zzV7ESGw39DsoraZ9kiZWvHcIyA5z3tMOTNH+HhYDHQn76JmiZEF7q3nRCDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ADOsznnf; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+c5cab09b19de097b6dd3+8222+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ADOsznnf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+c5cab09b19de097b6dd3+8222+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMFLC6QkHz3cPW
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2026 02:12:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Iojt6ABC36hZ6qPmKwT+Q9wyR57qrAUPmBlE40Pk7uo=; b=ADOsznnfeLg8gUPG4uWJ8Eb9FG
	7/NW8jGBssbJIjgixJZQse/JQYsr5+ax0sQ+uHscli5ldIdk2gCcwUmw9HI8zHs/2tggxZWapHmkX
	dA7r7oCwAldHQvpvsDPX+FQv6ZMZgOmUdzBS7EOK/pMng1Xc6OjvDou9zB+6S0nOJc/H3QWJpQZiH
	P7GPSuPWg79UqIc8mYZbWzyWUuvh/KZZcCHalz4CutJo3X7DwZvrhUtUXQpHoj9xBsbMziGeeP0Pn
	n90Bl3MC+0XWz606W1pRxT4GvaCGlT7GF9jipWmVURyzz92aOm5gRE75uTHl6Maz+e/t9SIgnIBwp
	EA3hQTtQ==;
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvd1Y-00000006QRG-1Ede;
	Thu, 26 Feb 2026 15:11:32 +0000
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
Subject: [PATCH 17/25] s390: move the XOR code to lib/raid/
Date: Thu, 26 Feb 2026 07:10:29 -0800
Message-ID: <20260226151106.144735-18-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226151106.144735-1-hch@lst.de>
References: <20260226151106.144735-1-hch@lst.de>
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
index eb7617b5c61b..15fd8797ae61 100644
--- a/lib/raid/xor/Makefile
+++ b/lib/raid/xor/Makefile
@@ -22,6 +22,7 @@ xor-$(CONFIG_RISCV_ISA_V)	+= riscv/xor.o riscv/xor-glue.o
 xor-$(CONFIG_SPARC32)		+= sparc/xor-sparc32.o
 xor-$(CONFIG_SPARC64)		+= sparc/xor-vis.o sparc/xor-vis-glue.o
 xor-$(CONFIG_SPARC64)		+= sparc/xor-niagara.o sparc/xor-niagara-glue.o
+xor-$(CONFIG_S390)		+= s390/xor.o
 
 
 CFLAGS_arm/xor-neon.o		+= $(CC_FLAGS_FPU)
diff --git a/arch/s390/lib/xor.c b/lib/raid/xor/s390/xor.c
similarity index 98%
rename from arch/s390/lib/xor.c
rename to lib/raid/xor/s390/xor.c
index 4d5ed638d850..2d5e33eca2a8 100644
--- a/arch/s390/lib/xor.c
+++ b/lib/raid/xor/s390/xor.c
@@ -7,7 +7,6 @@
  */
 
 #include <linux/types.h>
-#include <linux/export.h>
 #include <linux/raid/xor_impl.h>
 #include <asm/xor.h>
 
@@ -134,4 +133,3 @@ struct xor_block_template xor_block_xc = {
 	.do_4 = xor_xc_4,
 	.do_5 = xor_xc_5,
 };
-EXPORT_SYMBOL(xor_block_xc);
-- 
2.47.3


