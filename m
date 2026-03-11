Return-Path: <linuxppc-dev+bounces-18033-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D78FD062F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 07:09:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fW21r39DTz3dW6;
	Wed, 11 Mar 2026 18:09:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773212992;
	cv=none; b=fAvvdHKACSoctIkkc9hC2JyXfWmR5W/jQ8HD2T8TYY8fCLFrNTJDNGe359oL2eELxU99soqsHhZ3u18RxiXEDHMB7dT1U7ysePKqdGw+hpbzbU98DHyR6Yi6MQ4R7qAw6IFNP7aQiU7wwnLOe/cj8rnqls8S5ypU1cOv8mCa9RVSOg0LTdQ3uR2Nn5LpGowYU3IndOSEzCbCyMmu2aqJHEyvqsnugstgysv04Tpj89hghzwmmu4uFgwaH6rYHvtdZRDAGRcIXJjSAKtLtXk/zrp6JADeXAFNwkpiPTvIWICPSgcGYHZrKdYHHRqL9rC68qJy7hQn6xqR1UjUlDayzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773212992; c=relaxed/relaxed;
	bh=LPpvndNjqPvjZburtt7bAObV12ltu7OwMomHBwz06KI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kID+Jkv4u1XoFQRb+mOqf49TKdpFu4lxQiTh7xNR8FwRtZfbkBg+hX3xTvu8aN46WjQtxuf/0J8Ucjrel7IQUs/acChlZJbekLowh4hn7IfhZLPu4bJqN74pw9YjMaIcpY3vdbIDVA8/HCUPR4RzdQn1se3zRUq8CoXqHul7Kt8S391WWZ+zBWSU1SWjP67E7HkaP850NP3+V9BSWYsumXfWBAc+Y4+wi/iCO9U0/JMwyxqFjd6CwlkW2MU5Xrj+JxGpo3Scay39oJHyt0hHaZmew4epzEQx4TsFlGx6DQ81ytO6MD3FnP7HXws3Buh1UnQRbjvfrD3RTwMVnYLgvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qKeCzr0S; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+bcc67bb7b2d0717eac20+8235+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qKeCzr0S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+bcc67bb7b2d0717eac20+8235+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fW21q6SKkz3dSV
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 18:09:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=LPpvndNjqPvjZburtt7bAObV12ltu7OwMomHBwz06KI=; b=qKeCzr0So3ysR+1cdg18iJh0KE
	0FGQ2DkfImNo904eeDW/QgWj9Kuawrfc9N+lQWnMqTjWvCt+wYHo4kxptZLKW1Hx1C/PFgCU1YEE4
	aaXMBvuanLQncnRZKiQ0ifJaKC8pDzcbH/FkPKPskaxL4VrpcVLCu5k8/13+Q2ihYQbcLjLsD+f3v
	azpECTy1t/wNaUr0F6xAM/Lr3Zczx+gplroNTaGO/x0Dpo0AaiOkkw8Z59zAy/GsDZHqjsOLFSdAk
	FALjzNk9t8WNLTaY5AoBdMzSwo3U5eQc1T7kFvGW1htFlNCMLLRHlirUFDEqPQ6thJBTOMBK9whM4
	nNsWqxMg==;
Received: from [212.243.42.10] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0DhI-0000000B0zT-2L9L;
	Wed, 11 Mar 2026 07:09:36 +0000
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
Subject: [PATCH 22/27] async_xor: use xor_gen
Date: Wed, 11 Mar 2026 08:03:54 +0100
Message-ID: <20260311070416.972667-23-hch@lst.de>
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

Replace use of the loop around xor_blocks with the easier to use xor_gen
API.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 crypto/async_tx/async_xor.c | 34 ++++++++++------------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/crypto/async_tx/async_xor.c b/crypto/async_tx/async_xor.c
index 2c499654a36c..84458375b202 100644
--- a/crypto/async_tx/async_xor.c
+++ b/crypto/async_tx/async_xor.c
@@ -103,7 +103,6 @@ do_sync_xor_offs(struct page *dest, unsigned int offset,
 {
 	int i;
 	int xor_src_cnt = 0;
-	int src_off = 0;
 	void *dest_buf;
 	void **srcs;
 
@@ -117,23 +116,12 @@ do_sync_xor_offs(struct page *dest, unsigned int offset,
 		if (src_list[i])
 			srcs[xor_src_cnt++] = page_address(src_list[i]) +
 				(src_offs ? src_offs[i] : offset);
-	src_cnt = xor_src_cnt;
+
 	/* set destination address */
 	dest_buf = page_address(dest) + offset;
-
 	if (submit->flags & ASYNC_TX_XOR_ZERO_DST)
 		memset(dest_buf, 0, len);
-
-	while (src_cnt > 0) {
-		/* process up to 'MAX_XOR_BLOCKS' sources */
-		xor_src_cnt = min(src_cnt, MAX_XOR_BLOCKS);
-		xor_blocks(xor_src_cnt, len, dest_buf, &srcs[src_off]);
-
-		/* drop completed sources */
-		src_cnt -= xor_src_cnt;
-		src_off += xor_src_cnt;
-	}
-
+	xor_gen(dest_buf, srcs, xor_src_cnt, len);
 	async_tx_sync_epilog(submit);
 }
 
@@ -168,11 +156,10 @@ dma_xor_aligned_offsets(struct dma_device *device, unsigned int offset,
  *
  * honored flags: ASYNC_TX_ACK, ASYNC_TX_XOR_ZERO_DST, ASYNC_TX_XOR_DROP_DST
  *
- * xor_blocks always uses the dest as a source so the
- * ASYNC_TX_XOR_ZERO_DST flag must be set to not include dest data in
- * the calculation.  The assumption with dma engines is that they only
- * use the destination buffer as a source when it is explicitly specified
- * in the source list.
+ * xor_gen always uses the dest as a source so the ASYNC_TX_XOR_ZERO_DST flag
+ * must be set to not include dest data in the calculation.  The assumption with
+ * dma engines is that they only use the destination buffer as a source when it
+ * is explicitly specified in the source list.
  *
  * src_list note: if the dest is also a source it must be at index zero.
  * The contents of this array will be overwritten if a scribble region
@@ -259,11 +246,10 @@ EXPORT_SYMBOL_GPL(async_xor_offs);
  *
  * honored flags: ASYNC_TX_ACK, ASYNC_TX_XOR_ZERO_DST, ASYNC_TX_XOR_DROP_DST
  *
- * xor_blocks always uses the dest as a source so the
- * ASYNC_TX_XOR_ZERO_DST flag must be set to not include dest data in
- * the calculation.  The assumption with dma engines is that they only
- * use the destination buffer as a source when it is explicitly specified
- * in the source list.
+ * xor_gen always uses the dest as a source so the ASYNC_TX_XOR_ZERO_DST flag
+ * must be set to not include dest data in the calculation.  The assumption with
+ * dma engines is that they only use the destination buffer as a source when it
+ * is explicitly specified in the source list.
  *
  * src_list note: if the dest is also a source it must be at index zero.
  * The contents of this array will be overwritten if a scribble region
-- 
2.47.3


