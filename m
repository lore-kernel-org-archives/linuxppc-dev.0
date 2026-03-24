Return-Path: <linuxppc-dev+bounces-18690-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED9CF532E6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 06:27:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fg0TK5vfHz3c9D;
	Tue, 24 Mar 2026 17:27:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774333669;
	cv=none; b=g3rsgmkuXH7CppPO4gO4PmemMKMX5OqGWRY7YnCzZnw0dPkwCqtlpRrRXB1OSsy9Ezs7HdEYWoMx0vWmlOblqt5rv1dNj5eu+DXlEc6+y5x0TWC1DuX1Bf4UG8J8E5COWead8p7MqOMTufqa1aggQHjJr7Mr5oFhbQKAG7RtgJr46hm2MjU28DKfMTzzxZgBT1Rc6GOn6RHSOdJXPCY24UyEJg5qNlXU+YOidy3pHVNVhavXnSTwAkdtR7BsmFlzBLCNKhyunjrmM783ktJZahY0aQNYMy4tbZOVYEmXhE+xvPDEAhi3/CeRR1PJ/7uei4T8M/yi34pOCSR/kodAZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774333669; c=relaxed/relaxed;
	bh=/75qa/vlk7JJ6eswM8p9qT3GXKRQ9LKNFn/zai2Egog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oELkrQEDZerCQDyUDichy+695OS1MAiHmSs2GrkIBcgUh60H114ForqbymZkmCVUjhE0UwQdMRdBHb+ouA7eeg6QIRzPMixjI5mQ74RwgJpQB7AzbPDt93NjPbXD9NBmusSuwJ1ipEslC59SCsXpEQsz3yCeXDMc9omTlrA2nrzRtJm/BHd7mdxtufwuak0ucKLUd2bKMY/rMNnX2hQP77RS+qjt2adPIZnmu/1F3ly1fuGKd8agPK+8lw6cPqzlYzi4rJpb0l0fEHtNIz2sySU5eQhp3du7Q5JpZNgvY70NFmqi9P02iD01pC94/MPn/S1+sorxn3wwdzw9GGEIlA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RsBZW20c; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+4a75e1166b7f241dd976+8248+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RsBZW20c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+4a75e1166b7f241dd976+8248+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fg0TK1Ypdz2ypY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2026 17:27:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/75qa/vlk7JJ6eswM8p9qT3GXKRQ9LKNFn/zai2Egog=; b=RsBZW20cMzzDnGoSgDGTEHzRmD
	hthAxUcMSKWlwMF3kpr9KFp7DgUBhm6CTBuRLqaX3dSvjmTrHagl5Iwa51gX3XFgpBQKU4O45eJlZ
	juMaAXppn4DfGk0fQUv8YdvNF/oLC5SYXSLirappWntPPgkpXi+TT5GVGLvVYF4oFf+G6l8nSUmc7
	ypFPpqZK7CRE446DQ0oBV1zLkGsvwbdufJK0gOMfGFTXgokHNWglh9QDxR/TEDi0NOCCl3EBtc8tP
	IaHX2LoUlPhdRp7xJt4XiJH0U6qKhjbWtr/x2YNJq1q504TF9SI+EeawZdv8pvtgpMl9Dg/5cNnKz
	GIrJF2zw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4vEk-00000000jqi-34GF;
	Tue, 24 Mar 2026 06:27:35 +0000
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
Subject: [PATCH 25/26] xor: use static_call for xor_gen
Date: Tue, 24 Mar 2026 07:22:01 +0100
Message-ID: <20260324062211.3216301-26-hch@lst.de>
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

Avoid the indirect call for xor_generation by using a static_call.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/raid/xor/xor-core.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/lib/raid/xor/xor-core.c b/lib/raid/xor/xor-core.c
index a9b984d47d8c..67dc8ade7f0b 100644
--- a/lib/raid/xor/xor-core.c
+++ b/lib/raid/xor/xor-core.c
@@ -11,10 +11,10 @@
 #include <linux/raid/xor.h>
 #include <linux/jiffies.h>
 #include <linux/preempt.h>
+#include <linux/static_call.h>
 #include "xor_impl.h"
 
-/* The xor routine to use.  */
-static struct xor_block_template *active_template;
+DEFINE_STATIC_CALL_NULL(xor_gen_impl, *xor_block_8regs.xor_gen);
 
 /**
  * xor_gen - generate RAID-style XOR information
@@ -36,13 +36,13 @@ void xor_gen(void *dest, void **srcs, unsigned int src_cnt, unsigned int bytes)
 	lockdep_assert_preemption_enabled();
 	WARN_ON_ONCE(bytes & 511);
 
-	active_template->xor_gen(dest, srcs, src_cnt, bytes);
+	static_call(xor_gen_impl)(dest, srcs, src_cnt, bytes);
 }
 EXPORT_SYMBOL(xor_gen);
 
 /* Set of all registered templates.  */
 static struct xor_block_template *__initdata template_list;
-static bool __initdata xor_forced = false;
+static struct xor_block_template *forced_template;
 
 /**
  * xor_register - register a XOR template
@@ -68,7 +68,7 @@ void __init xor_register(struct xor_block_template *tmpl)
  */
 void __init xor_force(struct xor_block_template *tmpl)
 {
-	active_template = tmpl;
+	forced_template = tmpl;
 }
 
 #define BENCH_SIZE	4096
@@ -110,7 +110,7 @@ static int __init calibrate_xor_blocks(void)
 	void *b1, *b2;
 	struct xor_block_template *f, *fastest;
 
-	if (xor_forced)
+	if (forced_template)
 		return 0;
 
 	b1 = (void *) __get_free_pages(GFP_KERNEL, 2);
@@ -127,7 +127,7 @@ static int __init calibrate_xor_blocks(void)
 		if (f->speed > fastest->speed)
 			fastest = f;
 	}
-	active_template = fastest;
+	static_call_update(xor_gen_impl, fastest->xor_gen);
 	pr_info("xor: using function: %s (%d MB/sec)\n",
 	       fastest->name, fastest->speed);
 
@@ -155,10 +155,10 @@ static int __init xor_init(void)
 	 * If this arch/cpu has a short-circuited selection, don't loop through
 	 * all the possible functions, just use the best one.
 	 */
-	if (active_template) {
+	if (forced_template) {
 		pr_info("xor: automatically using best checksumming function   %-10s\n",
-			active_template->name);
-		xor_forced = true;
+			forced_template->name);
+		static_call_update(xor_gen_impl, forced_template->xor_gen);
 		return 0;
 	}
 
@@ -169,7 +169,7 @@ static int __init xor_init(void)
 	 * Pick the first template as the temporary default until calibration
 	 * happens.
 	 */
-	active_template = template_list;
+	static_call_update(xor_gen_impl, template_list->xor_gen);
 	return 0;
 #endif
 }
-- 
2.47.3


