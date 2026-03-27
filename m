Return-Path: <linuxppc-dev+bounces-18893-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F19010BA426
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 06:23:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhrDL5LNtz3cRN;
	Fri, 27 Mar 2026 17:22:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774592578;
	cv=none; b=TMid5ZVvnoEff7gv370FBBF521Zw/+PUcgFYBY5nTzmVRvncBNoZEe+W2vOx6qW+CINJw4wq5pqEpPb1MQjKh1UrX5prDFx6pnbTSKliwd5mhWVA0SIftrhq3/sprPnhFIbHtyIQuSSa2E3H2gNY79vAjCMQY40h8eh1qtJg+p4bvYZJ5icJkX+wMjeCFmNntkDV89J6RnKWJ5iGdZOdUck10J0vPUKPx8FSA1uSGe3TEwiYPNtaFJXeO7dSPHnaI8QiSOtMsRRdO/C0vGBZnUdpi82oJN79DPZ51748+xj8M9r25Z7IDfyaH8KuV5g3F15m/f/YmRquKBCMa47iUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774592578; c=relaxed/relaxed;
	bh=P3w+KEj1wa0C4hNOnOEnd9y3/Pxg+KbzaMJG30EKK70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bmnX9CaMRpTfOed4m2kbN3JMhNZo7VQLlg2dwZqduxQ70EZh+5ob3CbCkK7N96TX8fKxRXkeZ83Yb2xyxHvGR4EvI88FrhxFZZW/LuMBrgDc0VfOGSy+kykJiQn/qni/pjWZKK4o3im3EAzuOdN1Z9HQQOyLGymTu3SqyN/odPGYfnY2dWR/WbIxelqpx397Sy4SbajR7UEtqCi6HXYZlei/2JWhIacdFmA7AgsCgyAyMZJcSwOoH+666JxTygODdGzUsV/kq7wLpkjDLLs0+M0Xitq2rjHs60xbXxwzIoEYjndccDq9sfXckF6yyvr4Jz7egX91wEeY4PGb+3lioQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=l+ttE0MC; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+7b1de7ca9b09bfe890a7+8251+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=l+ttE0MC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+7b1de7ca9b09bfe890a7+8251+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhrDL1W0Xz3cF4
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 17:22:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=P3w+KEj1wa0C4hNOnOEnd9y3/Pxg+KbzaMJG30EKK70=; b=l+ttE0MC9G6ho9IaPAv/LIkOX+
	g3+5OazTD19hbTLF39MLoWzdY77vsGvc2FA6pd50aBzvYpAO6dliJJ/YdOK7ynRWK1lcpr8++cdFa
	V5ZtJn2svmamskVdnsGQiqmQxcJHtkWMOkQcgf9IbbLjQ4Xls4FH6r2xZx9aUzlDD9FOkUYidsIBk
	o4SiJdQEbLx1rDvjQ5karHVhmE9p7lbhI/AdVeFUBiftHk8thubRUUhZqpkslu2aVvqPVEXAaJPbL
	QmU14duTT+VlfrbDGdOqzp7K8+pn7vyLbYocFJCcD3DochkacdX6W/tRtgSApkFaP7lTYTADhoH/R
	Skkmi1Gg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w60af-00000006nfW-1TdP;
	Fri, 27 Mar 2026 06:22:41 +0000
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
Subject: [PATCH 23/28] xor: add a better public API
Date: Fri, 27 Mar 2026 07:16:55 +0100
Message-ID: <20260327061704.3707577-24-hch@lst.de>
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

xor_blocks is very annoying to use, because it is limited to 4 + 1
sources / destinations, has an odd argument order and is completely
undocumented.

Lift the code that loops around it from btrfs and async_tx/async_xor into
common code under the name xor_gen and properly document it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/raid/xor/xor-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/raid/xor/xor-core.c b/lib/raid/xor/xor-core.c
index 07e06db32731..2e46b6b83b0a 100644
--- a/lib/raid/xor/xor-core.c
+++ b/lib/raid/xor/xor-core.c
@@ -65,6 +65,8 @@ void xor_gen(void *dest, void **srcs, unsigned int src_cnt, unsigned int bytes)
 {
 	unsigned int src_off = 0;
 
+	WARN_ON_ONCE(in_interrupt());
+	WARN_ON_ONCE(bytes == 0);
 	WARN_ON_ONCE(bytes & 511);
 
 	while (src_cnt > 0) {
-- 
2.47.3


