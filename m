Return-Path: <linuxppc-dev+bounces-18034-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD7CFFD062F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 07:10:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fW2280K2dz3dWh;
	Wed, 11 Mar 2026 18:10:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773213008;
	cv=none; b=YOhClV8Vcmyk6hTjqo+flyRLLATtPs9bqk78LE1R95JbRaFBrIcuZGiKBA1VCaNWFI1yOkupN6aCOC3TGCk2uO+tYGXl7WGHu69I1aD9OSnaKjN14fchrOAGq/3s7JGseK0mGXd9Cqu24Qz/yiXzxM8iYciEKs3tO+2aG4zg9DGoLdImB95FOJldkF96z4XSP26xXtxsis+pf16r0xEvT4jmWcs6ZAiUDYQrHOckkIyKGivIw7phGnVHARGKjWVMynERFTJuLPv0KPJKdiQXgiE3qNgv36UQjWG6imcGdu9TWpP0K8cbeIki8ZRNbrSEAKPvUQlx8+y6U8U7YrJ0Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773213008; c=relaxed/relaxed;
	bh=H2vQZ0n6ApADqlHQBkKJl8JvR6Rc+huPC8RGmru6TyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hPfKlJhsKh5TfYTTTk4wGaAguMGn2k+8YM6284lLm+jST7kKoxPrD/ss+wEwRnshtZfQc8OvS/p4hV3LbR4jBYWMFZ1g0/03Yq5miS8LVTNlaZiVcZP9xpFQvK4ATPAdTAdXsVhqK1iPAsPcrnTXSiNxZ0uzgHyJwyrc8hNXeqp1IUmuHHd5lLkgnJ6gXQzGKBkrj1RmfLqW9juooc2Pv+fBOn0vE1PmNRG9yT2nsIRsfcKXHqBhMx+DQvHuyPep+8qTjmAkRBVa+sH8bUAx1oIU3r22SLeOfyeo7geLmziCVATpzqShSbcjyrNbfcfSajspe/nZgAZFxqDh/HPc+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=VtpwBikM; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+bcc67bb7b2d0717eac20+8235+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=VtpwBikM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+bcc67bb7b2d0717eac20+8235+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fW2273wtjz3dWg
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 18:10:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=H2vQZ0n6ApADqlHQBkKJl8JvR6Rc+huPC8RGmru6TyA=; b=VtpwBikMqQGisKoDGXKD2IrKce
	1Zte+VyQ8+sPZptq911j4DEv1+3ch1eb/V6P5SB7gcJ3xQCVtfJaNSLe8O7XTcQf/NDfPvGVO8sR/
	JwWr5lXsm2fVVVpQ9AgjcOkLguzI3nIKP/GpHa6bq4pvP7puPvBNQ2JMSWHp8mZOVoZIjTsFbbNyD
	Ofwet/qSDwFBD1RCeb7l/AzO0G9d067lMRRXwfK8lrvgCcQF8dryCqtXmqQUz9+QbCaXPPuRPgJ8M
	QtHf4nOvqsXu8AR7qyeIMxA+ihh+/z5/7fzeCIve/fOAA8pOMLYi2160cyMAM6Ujx3kdltX6SR7VP
	6l3vi/dg==;
Received: from [212.243.42.10] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0DhW-0000000B1Ad-0csB;
	Wed, 11 Mar 2026 07:09:50 +0000
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
Subject: [PATCH 23/27] btrfs: use xor_gen
Date: Wed, 11 Mar 2026 08:03:55 +0100
Message-ID: <20260311070416.972667-24-hch@lst.de>
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

Use the new xor_gen helper instead of open coding the loop around
xor_blocks.  This helper is very similar to the existing run_xor helper
in btrfs, except that the destination buffer is passed explicitly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/raid56.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index b4511f560e92..dab07442f634 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -617,26 +617,6 @@ static void cache_rbio(struct btrfs_raid_bio *rbio)
 	spin_unlock(&table->cache_lock);
 }
 
-/*
- * helper function to run the xor_blocks api.  It is only
- * able to do MAX_XOR_BLOCKS at a time, so we need to
- * loop through.
- */
-static void run_xor(void **pages, int src_cnt, ssize_t len)
-{
-	int src_off = 0;
-	int xor_src_cnt = 0;
-	void *dest = pages[src_cnt];
-
-	while(src_cnt > 0) {
-		xor_src_cnt = min(src_cnt, MAX_XOR_BLOCKS);
-		xor_blocks(xor_src_cnt, len, dest, pages + src_off);
-
-		src_cnt -= xor_src_cnt;
-		src_off += xor_src_cnt;
-	}
-}
-
 /*
  * Returns true if the bio list inside this rbio covers an entire stripe (no
  * rmw required).
@@ -1434,7 +1414,8 @@ static void generate_pq_vertical_step(struct btrfs_raid_bio *rbio, unsigned int
 	} else {
 		/* raid5 */
 		memcpy(pointers[rbio->nr_data], pointers[0], step);
-		run_xor(pointers + 1, rbio->nr_data - 1, step);
+		xor_gen(pointers[rbio->nr_data], pointers + 1, rbio->nr_data - 1,
+				step);
 	}
 	for (stripe = stripe - 1; stripe >= 0; stripe--)
 		kunmap_local(pointers[stripe]);
@@ -2034,7 +2015,7 @@ static void recover_vertical_step(struct btrfs_raid_bio *rbio,
 		pointers[rbio->nr_data - 1] = p;
 
 		/* Xor in the rest */
-		run_xor(pointers, rbio->nr_data - 1, step);
+		xor_gen(p, pointers, rbio->nr_data - 1, step);
 	}
 
 cleanup:
@@ -2664,7 +2645,7 @@ static bool verify_one_parity_step(struct btrfs_raid_bio *rbio,
 	} else {
 		/* RAID5. */
 		memcpy(pointers[nr_data], pointers[0], step);
-		run_xor(pointers + 1, nr_data - 1, step);
+		xor_gen(pointers[nr_data], pointers + 1, nr_data - 1, step);
 	}
 
 	/* Check scrubbing parity and repair it. */
-- 
2.47.3


