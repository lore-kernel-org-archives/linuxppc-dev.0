Return-Path: <linuxppc-dev+bounces-17303-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C81AFD8FC3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Feb 2026 15:15:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMFLT6tf7z3dHj;
	Fri, 27 Feb 2026 02:12:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772118737;
	cv=none; b=IYGk3XxPI4f0EQ8APumnfet3MPYtMkCitLHNUgf0OydgUOOLPQnKIrVJuGo6hAfAZCpUcjUvjX+qe+EQ+CiEuK1y0iEKnfkB+Rt2R9cBvQrL8KIecUmeOfkvpSTRfex/bg2523UdWKa2T9EsogYFNHDm9jDDrOyDXX9Cp7TxX7gU99gjmXtsxUyGnDynXxoMZzZOlBwlNgFSvxf3OncswifkwrKh7TSS8X9DtxinIS+gi2BewvA2/N9rvaWYUri8xxAfC5xlLMXptpMdJQxtT5ETzUfsQVSwndipNL1faL7ssPIIRlfQSu/gLOwMCHG5AAHTdVgikfNcxjxtA6Zubg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772118737; c=relaxed/relaxed;
	bh=dnAqm1mQgBL7YCaDnwjea9MVbvJi6fB59bRdgxzHRfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J7K8eqBsIYvr5j1a6j+TIw5tcFimSMg8l11PdWHOcdTMWgxFP7AQa0LA6YQeo4nuNoEMq90UufuqZqbYbJw85mcREAVsNpWQJBm6XfczeN5idCN0JNySrNq7KkGQ80Y3FC6mQZwtZ7WbgwewHF+3EgMIrNRdu9NK7sy1AEUBKRs/viyBjUA6RPJF5ZhX4kHA4nPAcGdG+lmB+YFtBerMAMCjkiwHCA659L16nMDMrPEME0O+7dTngOJ5a00To9nh2d0C9HCMx5fp46W853bLuS3I2oBsL0kQoPBCTr1CuBtsnoiGk5/HBwPzlRyN3DzqI40fMFsiRnfQ9HL+dbjIiQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0lLke88Z; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+c5cab09b19de097b6dd3+8222+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0lLke88Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+c5cab09b19de097b6dd3+8222+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMFLT31Jmz2yvy
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2026 02:12:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=dnAqm1mQgBL7YCaDnwjea9MVbvJi6fB59bRdgxzHRfQ=; b=0lLke88ZORd7FsP4CXpACuAHde
	G+oGLjzsBhaZHraeqqDivfxfZWCm4ROZxEFdgYr1SqqrHyaZMGKmnU0TC9tNkr4CT420xJEzxh9Lx
	K/RLoOseLaA94JEjz/WZ9ATki+rNhCPZRBNOnEn8lXDJCqZOClP5EWYyzrJC9gyWYIy3CnZitFvtH
	k3HWnv0fDpBhz5YMPmXsLWiQQkOdYZWJnJ8CX2ukw7Pg8kW8rslvn913bFW6BP4sSazhwrve1Ld2Q
	EOgMxPX5svvrd6cMQB6Uov1O9PUtVxtVdVUoj9XmVxFNfJaXZemUFGVQSO215kU+ZiD9757bDT/dH
	BXSJUfgQ==;
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvd1q-00000006Qsd-3Nhg;
	Thu, 26 Feb 2026 15:11:50 +0000
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
Subject: [PATCH 25/25] xor: use static_call for xor_gen
Date: Thu, 26 Feb 2026 07:10:37 -0800
Message-ID: <20260226151106.144735-26-hch@lst.de>
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

Avoid the indirect call for xor_generation by using a static_call.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/raid/xor/xor-32regs.c |  2 +-
 lib/raid/xor/xor-core.c   | 29 ++++++++++++++---------------
 lib/raid/xor/xor_impl.h   |  4 ++++
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/lib/raid/xor/xor-32regs.c b/lib/raid/xor/xor-32regs.c
index acb4a10d1e95..759a31f76414 100644
--- a/lib/raid/xor/xor-32regs.c
+++ b/lib/raid/xor/xor-32regs.c
@@ -209,7 +209,7 @@ xor_32regs_5(unsigned long bytes, unsigned long * __restrict p1,
 	} while (--lines > 0);
 }
 
-DO_XOR_BLOCKS(32regs, xor_32regs_2, xor_32regs_3, xor_32regs_4, xor_32regs_5);
+__DO_XOR_BLOCKS(32regs, xor_32regs_2, xor_32regs_3, xor_32regs_4, xor_32regs_5);
 
 struct xor_block_template xor_block_32regs = {
 	.name		= "32regs",
diff --git a/lib/raid/xor/xor-core.c b/lib/raid/xor/xor-core.c
index f18dcc57004b..2ab03dd294bf 100644
--- a/lib/raid/xor/xor-core.c
+++ b/lib/raid/xor/xor-core.c
@@ -11,10 +11,14 @@
 #include <linux/raid/xor.h>
 #include <linux/jiffies.h>
 #include <linux/preempt.h>
+#include <linux/static_call.h>
 #include "xor_impl.h"
 
-/* The xor routine to use.  */
-static struct xor_block_template *active_template;
+/*
+ * Provide a temporary default until the fastest or forced implementation is
+ * picked.
+ */
+DEFINE_STATIC_CALL(xor_gen_impl, xor_gen_32regs);
 
 /**
  * xor_gen - generate RAID-style XOR information
@@ -32,13 +36,13 @@ static struct xor_block_template *active_template;
 void xor_gen(void *dest, void **srcs, unsigned int src_cnt, unsigned int bytes)
 {
 	WARN_ON_ONCE(in_interrupt());
-	active_template->xor_gen(dest, srcs, src_cnt, bytes);
+	static_call(xor_gen_impl)(dest, srcs, src_cnt, bytes);
 }
 EXPORT_SYMBOL(xor_gen);
 
 /* Set of all registered templates.  */
 static struct xor_block_template *__initdata template_list;
-static int __initdata xor_forced = false;
+static struct xor_block_template *forced_template;
 
 /**
  * xor_register - register a XOR template
@@ -64,7 +68,7 @@ void __init xor_register(struct xor_block_template *tmpl)
  */
 void __init xor_force(struct xor_block_template *tmpl)
 {
-	active_template = tmpl;
+	forced_template = tmpl;
 }
 
 #define BENCH_SIZE	4096
@@ -106,7 +110,7 @@ static int __init calibrate_xor_blocks(void)
 	void *b1, *b2;
 	struct xor_block_template *f, *fastest;
 
-	if (xor_forced)
+	if (forced_template)
 		return 0;
 
 	b1 = (void *) __get_free_pages(GFP_KERNEL, 2);
@@ -123,7 +127,7 @@ static int __init calibrate_xor_blocks(void)
 		if (f->speed > fastest->speed)
 			fastest = f;
 	}
-	active_template = fastest;
+	static_call_update(xor_gen_impl, fastest->xor_gen);
 	pr_info("xor: using function: %s (%d MB/sec)\n",
 	       fastest->name, fastest->speed);
 
@@ -151,21 +155,16 @@ static int __init xor_init(void)
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
 
 #ifdef MODULE
 	return calibrate_xor_blocks();
 #else
-	/*
-	 * Pick the first template as the temporary default until calibration
-	 * happens.
-	 */
-	active_template = template_list;
 	return 0;
 #endif
 }
diff --git a/lib/raid/xor/xor_impl.h b/lib/raid/xor/xor_impl.h
index 968dd07df627..f11910162b08 100644
--- a/lib/raid/xor/xor_impl.h
+++ b/lib/raid/xor/xor_impl.h
@@ -50,6 +50,10 @@ extern struct xor_block_template xor_block_32regs;
 extern struct xor_block_template xor_block_8regs_p;
 extern struct xor_block_template xor_block_32regs_p;
 
+/* default call until updated */
+void xor_gen_32regs(void *dest, void **srcs, unsigned int src_cnt,
+		unsigned int bytes);
+
 void __init xor_register(struct xor_block_template *tmpl);
 void __init xor_force(struct xor_block_template *tmpl);
 
-- 
2.47.3


