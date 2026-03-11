Return-Path: <linuxppc-dev+bounces-18017-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B13FD0640
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 07:06:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fW1xh4tymz3cMF;
	Wed, 11 Mar 2026 18:06:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773212776;
	cv=none; b=IIuGcLanPE83bL3Niu0wzW0O2agOe3nYNS6ZZfSIw11E2qNwdF0jza1uh2pXJlnknkUYDcZO+zX3uaXpyTRW1jsu0djIMSH7A2oIzd3BppvvaEsASCYD7tXcUzdthnqKgLwTlcRfkxH97dWXORgG7SmsrJdcOrq85NhN0YdpkAgN8zpnH4cy6MXP9Xr4pzeT2roeFhVXzi6VNnbGQZLGpMHYT4o3hO3ERIpdmd0V+1iVHE8JahorBIsd11xtzM9bLurJ1vm84C32ikiOOXtFqdevP3WleC+Ys+kkKYzV2EmmqbESyztYHjyYOOkcP9UqkTWApOH1FB7y4C19rmsBtw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773212776; c=relaxed/relaxed;
	bh=QbQi9seKEsm9W+wwtDS9W14X853YUp3VVUmHZpJTJX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G42hKWiiizEwjycbDofm/ui/m6x+mBSGXT19Q0w+5UnoCUPK6rQJ3AhakOXVCyhHEarzxOHIg5weZ39y0TyB264axzg4n75CEX2W3nYzTc1dPoXjBOMqm7N4JVoAW7e4CzJZlR6+7Nk0aFNzzowqua9QEzJILvEAfTVaAwjIq+1ZUugTVvLew60FOUeumrCGtv/o/+7mQ4nNrnZcbfd02hhPad3gInYovaCfDHn05wkS6ZhzRE5VnafLb3fmiQuIiyI3TClAWgwObccpjOzbtXVD0a5KaUfGexm+5k29Bng6YmJt74pp6hG4JjtfoR/ic5K7qiQXNTqOhrZr05yFPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Wfb4w6N4; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+bcc67bb7b2d0717eac20+8235+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Wfb4w6N4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+bcc67bb7b2d0717eac20+8235+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fW1xh1CwKz3cMC
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 18:06:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=QbQi9seKEsm9W+wwtDS9W14X853YUp3VVUmHZpJTJX0=; b=Wfb4w6N4dWPYrbDRq88zxH1a7W
	VXK6RjNj6ZfQrAhd6kO2/g9Zz65x0jzQZhC1endy8oaoHjoRzbwXwfOqVHdWzL+XhpSRuJOPppSup
	+KUNgTaXcAfMZLwRkOHEAw9I5U6TFK5h+r5OC7UdFHKBi8GmzHDgTcxKEsWFGg+fmOEAuS2LyGf09
	Ox77jD9LiKe6pZ+qSYbYX94s4DaM+ubyLk6mj89nBTCXrHJnbJyoMxmqpHweMgYXHAcfSK1rkwLkY
	g0tvF6P+HXJU01+fK6ylw7aIRcmYNRBgpKn0MvIhTV9VoNWgEXhdE+qYLry83CjXyiaMstZlP0W8A
	G0PahqsQ==;
Received: from [212.243.42.10] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0Ddl-0000000Ayed-00Bb;
	Wed, 11 Mar 2026 07:05:57 +0000
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
Subject: [PATCH 06/27] xor: cleanup registration and probing
Date: Wed, 11 Mar 2026 08:03:38 +0100
Message-ID: <20260311070416.972667-7-hch@lst.de>
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

Originally, the XOR code benchmarked all algorithms at load time, but
it has since then been hacked multiple times to allow forcing an
algorithm, and then commit 524ccdbdfb52 ("crypto: xor - defer load time
benchmark to a later time") changed the logic to a two-step process
or registration and benchmarking, but only when built-in.

Rework this, so that the XOR_TRY_TEMPLATES macro magic now always just
deals with adding the templates to the list, and benchmarking is always
done in a second pass; for modular builds from module_init, and for the
built-in case using a separate init call level.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/raid/xor/xor-core.c | 98 ++++++++++++++++++++---------------------
 1 file changed, 48 insertions(+), 50 deletions(-)

diff --git a/lib/raid/xor/xor-core.c b/lib/raid/xor/xor-core.c
index edb4e498da60..88667a89b75b 100644
--- a/lib/raid/xor/xor-core.c
+++ b/lib/raid/xor/xor-core.c
@@ -52,29 +52,14 @@ EXPORT_SYMBOL(xor_blocks);
 
 /* Set of all registered templates.  */
 static struct xor_block_template *__initdata template_list;
+static bool __initdata xor_forced = false;
 
-#ifndef MODULE
 static void __init do_xor_register(struct xor_block_template *tmpl)
 {
 	tmpl->next = template_list;
 	template_list = tmpl;
 }
 
-static int __init register_xor_blocks(void)
-{
-	active_template = XOR_SELECT_TEMPLATE(NULL);
-
-	if (!active_template) {
-#define xor_speed	do_xor_register
-		// register all the templates and pick the first as the default
-		XOR_TRY_TEMPLATES;
-#undef xor_speed
-		active_template = template_list;
-	}
-	return 0;
-}
-#endif
-
 #define BENCH_SIZE	4096
 #define REPS		800U
 
@@ -85,9 +70,6 @@ do_xor_speed(struct xor_block_template *tmpl, void *b1, void *b2)
 	unsigned long reps;
 	ktime_t min, start, t0;
 
-	tmpl->next = template_list;
-	template_list = tmpl;
-
 	preempt_disable();
 
 	reps = 0;
@@ -111,63 +93,79 @@ do_xor_speed(struct xor_block_template *tmpl, void *b1, void *b2)
 	pr_info("   %-16s: %5d MB/sec\n", tmpl->name, speed);
 }
 
-static int __init
-calibrate_xor_blocks(void)
+static int __init calibrate_xor_blocks(void)
 {
 	void *b1, *b2;
 	struct xor_block_template *f, *fastest;
 
-	fastest = XOR_SELECT_TEMPLATE(NULL);
-
-	if (fastest) {
-		printk(KERN_INFO "xor: automatically using best "
-				 "checksumming function   %-10s\n",
-		       fastest->name);
-		goto out;
-	}
+	if (xor_forced)
+		return 0;
 
 	b1 = (void *) __get_free_pages(GFP_KERNEL, 2);
 	if (!b1) {
-		printk(KERN_WARNING "xor: Yikes!  No memory available.\n");
+		pr_warn("xor: Yikes!  No memory available.\n");
 		return -ENOMEM;
 	}
 	b2 = b1 + 2*PAGE_SIZE + BENCH_SIZE;
 
-	/*
-	 * If this arch/cpu has a short-circuited selection, don't loop through
-	 * all the possible functions, just test the best one
-	 */
-
-#define xor_speed(templ)	do_xor_speed((templ), b1, b2)
-
-	printk(KERN_INFO "xor: measuring software checksum speed\n");
-	template_list = NULL;
-	XOR_TRY_TEMPLATES;
+	pr_info("xor: measuring software checksum speed\n");
 	fastest = template_list;
-	for (f = fastest; f; f = f->next)
+	for (f = template_list; f; f = f->next) {
+		do_xor_speed(f, b1, b2);
 		if (f->speed > fastest->speed)
 			fastest = f;
-
+	}
+	active_template = fastest;
 	pr_info("xor: using function: %s (%d MB/sec)\n",
 	       fastest->name, fastest->speed);
 
+	free_pages((unsigned long)b1, 2);
+	return 0;
+}
+
+static int __init xor_init(void)
+{
+	/*
+	 * If this arch/cpu has a short-circuited selection, don't loop through
+	 * all the possible functions, just use the best one.
+	 */
+	active_template = XOR_SELECT_TEMPLATE(NULL);
+	if (active_template) {
+		pr_info("xor: automatically using best checksumming function   %-10s\n",
+			active_template->name);
+		xor_forced = true;
+		return 0;
+	}
+
+#define xor_speed	do_xor_register
+	XOR_TRY_TEMPLATES;
 #undef xor_speed
 
-	free_pages((unsigned long)b1, 2);
-out:
-	active_template = fastest;
+#ifdef MODULE
+	return calibrate_xor_blocks();
+#else
+	/*
+	 * Pick the first template as the temporary default until calibration
+	 * happens.
+	 */
+	active_template = template_list;
 	return 0;
+#endif
 }
 
-static __exit void xor_exit(void) { }
+static __exit void xor_exit(void)
+{
+}
 
 MODULE_DESCRIPTION("RAID-5 checksumming functions");
 MODULE_LICENSE("GPL");
 
+/*
+ * When built-in we must register the default template before md, but we don't
+ * want calibration to run that early as that would delay the boot process.
+ */
 #ifndef MODULE
-/* when built-in xor.o must initialize before drivers/md/md.o */
-core_initcall(register_xor_blocks);
+__initcall(calibrate_xor_blocks);
 #endif
-
-module_init(calibrate_xor_blocks);
+core_initcall(xor_init);
 module_exit(xor_exit);
-- 
2.47.3


