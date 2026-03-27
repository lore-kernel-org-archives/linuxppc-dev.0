Return-Path: <linuxppc-dev+bounces-18870-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A0FF10BA431
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 06:18:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhr6m22Pwz2yVt;
	Fri, 27 Mar 2026 17:18:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774592288;
	cv=none; b=PS/LsmXb7teq3xxO0j5YLFxSK2kBCTSBrwFE6c/Ec7TZiHY/uiViIeQ6514xydzyE6PWsYK3uPN8iwiN1PEPlN99L4f47pQFMZaLLlPgjDbvbxHBNl0edJeWV6+R2r10GmCJdyRKbx94yDOAqV5vk9Jnk60yf/PzbZfZ8ldPz+St+W1Uf9h6yNIsTPJJVo4XQfF5y3iM8Yf3Nye+ftbjE7kbjKDdy027ZW8TjviaBRjeDTPa3wt5W27ldanjJbzsY1Un1V2kZilSkhxu4RUVnx0zvwfVaIAo8XccvBvOmk7ArnTNF11X0PF+aQk64YjYpfaHWVd4BIqiW9KytcV1vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774592288; c=relaxed/relaxed;
	bh=/2j39ho5HZfwE3eOGk3paFEvb/lh5G+wpe3o3TJUYA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJH481fdaBazydeNc0xjTNRT2VPesHAok1ajn5DvHLGw6Vlbe2NVHF+4oB+UDMXn5yqweLxgxDIpxvbjBuKbL/noHS8FxYtvnafc+ltkgcUpmvbqa5jnXow6Il38YiupZGXyxrltMHYQfZNw0iOvkVzPtFHJmHsrLWh4yCCRLFWGGG/hLb5AXiuC9FngPtGYP/BU7yCWQP6jVZMzaoHMO+otiNSC72KNhNALUwwQjXtCiY5JgGzw8j+rnY/7q04mJJlduHFF2UgenOID5R3+hqRySUcOlpPdoLCCVP/1QSQljpI3MzctvwkDZ1jCJGStDPHlPKFCjWQmI08ops9CHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Dm8ySlYB; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+7b1de7ca9b09bfe890a7+8251+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Dm8ySlYB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+7b1de7ca9b09bfe890a7+8251+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhr6g3bLvz2xmX
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 17:18:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/2j39ho5HZfwE3eOGk3paFEvb/lh5G+wpe3o3TJUYA0=; b=Dm8ySlYB19geB6N1wp4cse2BnE
	JN2T8m+Zw90dMyCB90leObMyg3f4eKCLoYf44HQSKs1iFsfQyNNlAyXTmC2YyC9cg+WVNAhvviD6y
	cyy4GwLB3/FH0loAebaI/l5+33lUAr833HyJEsycRuACwnjRw7sr6ZGJORwCbYpE9ukblH6jNRFYr
	PIcgis0ScZqfjsoRawazIw0xyrtdJF0UqnFjUlJCPOpkKy++zmpNABgi1etUgdX0e6yBRfyYJIMiN
	k0orD2TF6mVpcpXxUpVqKytJV7w1K10rawQKtxOmAa/9DVRbS95hfYSWAMKA4zwJHjX3yP5ZviO/F
	hWwaa7Hw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w60Vd-00000006kai-3ezG;
	Fri, 27 Mar 2026 06:17:30 +0000
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
Subject: [PATCH 01/28] xor: assert that xor_blocks is not call from interrupt context
Date: Fri, 27 Mar 2026 07:16:33 +0100
Message-ID: <20260327061704.3707577-2-hch@lst.de>
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

Most of the optimized xor_blocks versions require FPU/vector registers,
which generally are not supported in interrupt context.

Both callers already are in user context, so enforce this at the highest
level.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 crypto/xor.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/crypto/xor.c b/crypto/xor.c
index f39621a57bb3..df530ddc9f06 100644
--- a/crypto/xor.c
+++ b/crypto/xor.c
@@ -28,6 +28,8 @@ xor_blocks(unsigned int src_count, unsigned int bytes, void *dest, void **srcs)
 {
 	unsigned long *p1, *p2, *p3, *p4;
 
+	WARN_ON_ONCE(!in_task() || irqs_disabled() || softirq_count());
+
 	p1 = (unsigned long *) srcs[0];
 	if (src_count == 1) {
 		active_template->do_2(bytes, dest, p1);
-- 
2.47.3


