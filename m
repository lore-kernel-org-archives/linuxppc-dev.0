Return-Path: <linuxppc-dev+bounces-18032-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD41DFD0640
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 07:09:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fW21b2bVjz3dVH;
	Wed, 11 Mar 2026 18:09:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773212979;
	cv=none; b=G5UMagMNuQ00wQwtb6K+MpIc/c+ldzYGIb9w/OUkVAz6c/yMGwgMtUzDl+wIaFzMKeV3i6SdrF8Z11ybqK6l3jza9UM5eDWoZmMGhbJoyh85yy5Kafkz2iihOxyUkuuTHLTo8fTVGl6971ORQ8JIAJDfitTGnN2NldrYsIJsEPk09ZljFGfxyILm9JGVWAu7wJOMxutVVfkLRe5+6o2OLiXkGU1c8VPrLxQnuWW6iz17FzyB6VBrIMpZr0STo2SYvpZYK4lcov0qQPppE6MriN+Quao3rt5mT3wU6xRVIFnlzknuAuUue9cHcyJSbGSSb5xEoF2pyeJuVwVEzVeLOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773212979; c=relaxed/relaxed;
	bh=9fvnUIU7nYzp+spbrgNcfNOp4SrOTES6+fJpo+CBdYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GR7pPz0Po0ajrEqlGV+IRqg/uw8xHCwq44ERUnaVgYFwMWDlsMaB53GQBBoYJZcCUvFoMgOldfeOy4LOiVgmMwtqOMd0Ez1INqqYJG7+3ArAPqbsqTQG8jRdGwpjk8y3z0oTXOzDo/rq8kGiEb0BP4JZCgW9NcoqBxQoFwjFsXIMW608GJ4ZEgxidz1n4Wr/SU+PtLMApF47ZxVPa35V7laTHeVsw4WlORl+M0U5p6dw9ZBdNpT4fdDmSNCuyF+xE25ZrWpp6h+xFjOukEniWV3E8txlKEQnuO+LKFGdOMkby/BFKVuOn/Wxn8U4K3tG5x9NvSS42kjEw2HSMurNCg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2AOHWBeq; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+bcc67bb7b2d0717eac20+8235+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2AOHWBeq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+bcc67bb7b2d0717eac20+8235+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fW21Z5kpKz3dTw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 18:09:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=9fvnUIU7nYzp+spbrgNcfNOp4SrOTES6+fJpo+CBdYA=; b=2AOHWBeqnBOKCbCqQD/Dv51tWP
	FhXGZ7dxnT3Wb6tan/33z+XTuAVt1CAJLx+4IN6HHcPtmoOx4pYyP0mh3LR9IrzRSx3j6c6nB0SxF
	cBJudpV23GMI+nuXXVdwlKcZgUT0EDn3aZEJqgK9ZesGu7KAmeIf3I21n9iWPal2aO4IcWTRa+IT/
	Gw2kISYfXpS+3+SUjl0qj4IeLF07yy5VGCVBHD/r36qMuKLtNhJhxsZHQEZw5dOZd3LGKslQhB0Fr
	ofzOddPTw5xuXpto3KmykY0xyei2og7OtC5N5t/EsgYOx/Lc0LyY1xjeTQyqx05o9bCHORVE9Jepj
	a5Luyefw==;
Received: from [212.243.42.10] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0Dh3-0000000B0qJ-3xXB;
	Wed, 11 Mar 2026 07:09:22 +0000
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
Subject: [PATCH 21/27] xor: add a better public API
Date: Wed, 11 Mar 2026 08:03:53 +0100
Message-ID: <20260311070416.972667-22-hch@lst.de>
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

xor_blocks is very annoying to use, because it is limited to 4 + 1
sources / destinations, has an odd argument order and is completely
undocumented.

Lift the code that loops around it from btrfs and async_tx/async_xor into
common code under the name xor_gen and properly document it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/raid/xor.h |  2 ++
 lib/raid/xor/xor-core.c  | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/linux/raid/xor.h b/include/linux/raid/xor.h
index 02bda8d99534..6d9a39fd85dd 100644
--- a/include/linux/raid/xor.h
+++ b/include/linux/raid/xor.h
@@ -7,4 +7,6 @@
 extern void xor_blocks(unsigned int count, unsigned int bytes,
 	void *dest, void **srcs);
 
+void xor_gen(void *dest, void **srcs, unsigned int src_cnt, unsigned int bytes);
+
 #endif /* _XOR_H */
diff --git a/lib/raid/xor/xor-core.c b/lib/raid/xor/xor-core.c
index 47e09ae954b2..64f12f579e96 100644
--- a/lib/raid/xor/xor-core.c
+++ b/lib/raid/xor/xor-core.c
@@ -46,6 +46,38 @@ xor_blocks(unsigned int src_count, unsigned int bytes, void *dest, void **srcs)
 }
 EXPORT_SYMBOL(xor_blocks);
 
+/**
+ * xor_gen - generate RAID-style XOR information
+ * @dest:	destination vector
+ * @srcs:	source vectors
+ * @src_cnt:	number of source vectors
+ * @bytes:	length in bytes of each vector
+ *
+ * Performs bit-wise XOR operation into @dest for each of the @src_cnt vectors
+ * in @srcs for a length of @bytes bytes.  @src_count must be non-zero, and the
+ * memory pointed to by @dest and each member of @srcs must be at least 32-byte
+ * aligned.  @bytes must be non-zero and a multiple of 512.
+ *
+ * Note: for typical RAID uses, @dest either needs to be zeroed, or filled with
+ * the first disk, which then needs to be removed from @srcs.
+ */
+void xor_gen(void *dest, void **srcs, unsigned int src_cnt, unsigned int bytes)
+{
+	unsigned int src_off = 0;
+
+	WARN_ON_ONCE(bytes & 511);
+
+	while (src_cnt > 0) {
+		unsigned int this_cnt = min(src_cnt, MAX_XOR_BLOCKS);
+
+		xor_blocks(this_cnt, bytes, dest, srcs + src_off);
+
+		src_cnt -= this_cnt;
+		src_off += this_cnt;
+	}
+}
+EXPORT_SYMBOL(xor_gen);
+
 /* Set of all registered templates.  */
 static struct xor_block_template *__initdata template_list;
 static bool __initdata xor_forced = false;
-- 
2.47.3


