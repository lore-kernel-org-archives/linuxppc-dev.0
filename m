Return-Path: <linuxppc-dev+bounces-18036-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE658FD062F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 07:10:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fW22Y63L5z3dXc;
	Wed, 11 Mar 2026 18:10:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773213029;
	cv=none; b=WZgPkRQrWVUXGUl4MyyZDWu8z6VcCaBOKUzLKcuIPqctK7/AEFCu2zDUPHcS886mEaitz3ZN5jY/jQ6epIFEonLHAwgKcLdFvryACiE04YjHXKrPVItO4smCQm2kAMYZRjOUyk2VF+QvSW3ZUwerW9llVR5Bx57n6W13ksY1wL99qlgsYc+FTCqd7PwONLMSndcCNp5SdO5fDy8ZOj37W/YXzgO+53yp7oMoRZQSCWlwDEhwdVlx04KmQlhOi6EI/77mI1NNSzpQF0zuK2WbZb9OLqJ513juINIevNCernBc6fDTUo36fKvAQtsXOWLuC0B7tgqSKWAlPhXZwFdXPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773213029; c=relaxed/relaxed;
	bh=1VXN+qrgKMOjOg8SbRK828N8SoZ2yyHUM4r1hhkUxmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F34acA4O1Bv/9exf/KdMlghkNNLw2dkEH4t43E7Gqh7owMYkq7OBMaGojMLCMQrs7pqzHxlaxCDxh156GPZmojB+9Cp5CEAOoDy75zx0OBEOP5K66YBDMG04xpCaUcJmvo6PmhsB20C35GZC4xqV1rDrTgXkmMlbJlGL/uyagTLb6BjRMn1oNjD2W5mtg1tKx/OANqIBU1/8HX2QG21sLGVqe9myhGxNr0lcvoEyBQ2M8zh0RmK+AwbOfI+1ESTXY/EvfAgkpO6dNnO2vAoDLodf0jKDqlF9TNiQ8rwrOsdWbrIkXvU+qePEML3NaoqsJnjMVBChlTgVeAzvdCpMEg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GlYZhzEb; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+bcc67bb7b2d0717eac20+8235+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GlYZhzEb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+bcc67bb7b2d0717eac20+8235+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fW22Y2NX9z3dXg
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 18:10:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=1VXN+qrgKMOjOg8SbRK828N8SoZ2yyHUM4r1hhkUxmw=; b=GlYZhzEbh6LhHJVnrDhH96xjAy
	4ZbURJQV5gyiDjoJ833W9n71QkN3q82nKNZlhhX+fwEQFTlqR/YFNmdgtN1Cqu2qllrl5OVdNWnaE
	wcxJr7OSjntuAaZKF1dYihjmO0HQ84iylqfO02VW90TfNC5Pj7zLmGAhaucVGZmAP1srCkYZZ16Nr
	idp2vnmNstxr9XsmjCbTmUpd9CB5wiE3UnQ2ZroAFAwBE9wrhwEFd1tCeK8e9HztqVb2oEjNLal/Y
	RO3QXr+3uISlAnzcs6+hXrtrsr6TGmHhe3DiEYlkLCrqHKl+bxuNSbAzRoSvRlDcPGrGQ3UhTN/xF
	bvTygKDA==;
Received: from [212.243.42.10] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0Dht-0000000B1RQ-2myS;
	Wed, 11 Mar 2026 07:10:14 +0000
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
Subject: [PATCH 25/27] xor: use static_call for xor_gen
Date: Wed, 11 Mar 2026 08:03:57 +0100
Message-ID: <20260311070416.972667-26-hch@lst.de>
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
index c3523f92ab83..331da1afc0e4 100644
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
@@ -36,13 +40,13 @@ void xor_gen(void *dest, void **srcs, unsigned int src_cnt, unsigned int bytes)
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
@@ -68,7 +72,7 @@ void __init xor_register(struct xor_block_template *tmpl)
  */
 void __init xor_force(struct xor_block_template *tmpl)
 {
-	active_template = tmpl;
+	forced_template = tmpl;
 }
 
 #define BENCH_SIZE	4096
@@ -110,7 +114,7 @@ static int __init calibrate_xor_blocks(void)
 	void *b1, *b2;
 	struct xor_block_template *f, *fastest;
 
-	if (xor_forced)
+	if (forced_template)
 		return 0;
 
 	b1 = (void *) __get_free_pages(GFP_KERNEL, 2);
@@ -127,7 +131,7 @@ static int __init calibrate_xor_blocks(void)
 		if (f->speed > fastest->speed)
 			fastest = f;
 	}
-	active_template = fastest;
+	static_call_update(xor_gen_impl, fastest->xor_gen);
 	pr_info("xor: using function: %s (%d MB/sec)\n",
 	       fastest->name, fastest->speed);
 
@@ -155,21 +159,16 @@ static int __init xor_init(void)
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
index 09ae2916f71e..59c801777219 100644
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


