Return-Path: <linuxppc-dev+bounces-20743-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C59ECD4851
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2026 05:26:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gF4p31dzLz2ydn;
	Tue, 12 May 2026 15:26:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778563595;
	cv=none; b=ZiWgFXmdlKpr2tUfOKhLtq9RigmRiwBo9UmaGOM9ohoS+ZMwbW//BaDs9jiQ7JfOn6Rhc5IXi34yuywfNtxKVDf+xkXidllE9db5Ie6qu/WGBsRMwCWDXn5WxW83+vsAVEAYq9n6fUZInPQ8uPjiWwmzpck2VF4f0j3tl0rr7MBEHueBnxTlKSmmJP10akAORlJCgUHuTY/UFzPJHb6dNPXZsU8zo/D+SMasTGllYd4L8z0UIhAqRwOgYoRA1+aJWqrFm1nO6ZqpaNoo9+1pUG9SQZhyUyYLNmyyYZDXzYR/T2+GSHpTbQ77nyWvowki87JRjttOkvr9F2G6jo1UYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778563595; c=relaxed/relaxed;
	bh=BNJEm+BWUy4IcOMyMdOsApBihLLyr0NeOtDd249LUxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EcpEjU/9znETyQa+7g/2A+5bXUdWKiaT6lqJ2CA5h5QhGYJ+rOiZ9E6cAQFOKy1lo12tfUqyPaB0K9lIJHtt7Ir2HMi/NMffwGPPTeHVt5uawmzg6eh91I2sDs/mB4ofOynlaIivEApYa1vbKfk5542Glty54QKSf1wiHDKz1XyAxBOiSvvTHnNe3orD/Ztpu6O1co/+bWFEMWcSwQ1E/EWJi56pkHk2bZLmCDmH9wSWFiKnzP2hjnlqrudq+6854K8Fk2rshCTbPcCN+V2i030HwibTD0stK9KeQDHapYd29MkAqQ8VKAqOkRyJoSkxZoezhvdXjTWtc98s0X27Uw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WFUbvFnl; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+9f3c1ea353498f61ccd0+8297+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WFUbvFnl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+9f3c1ea353498f61ccd0+8297+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gF4p2545wz2ybQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 15:26:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=BNJEm+BWUy4IcOMyMdOsApBihLLyr0NeOtDd249LUxw=; b=WFUbvFnlIAd0p1zAFTPlyqzBjc
	fgw3V92oHkzT8uqbafgXaKnGKHw3/l3uSLvtbfpiZQA6mDUAf0qKt9D44riKTxvoo042Aw02T5aeU
	KAbHTV9QEhn3NTK2NQmFpmrfcRhmFQH85Oyaij4MVuO6rAVVkdn2/GKq+2WNT6vw4P/lzwdAyEb76
	5+e0nSz4nDhteBgdtlbbw/N/HNL9e/OUy/og9zj6mKvP9RM3piglSSSJ4RcV/+pAy23pXz/RUkZVR
	VmV7gebwjdE9fOtxyTJy5qR8VQL7tVOxz4ad07m0T5ii76fAhpKpGnp3hsZSuTBImWten2FwO6Sgo
	8lmLAqxg==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMfdK-0000000FdPB-1GFj;
	Tue, 12 May 2026 05:26:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
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
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-raid@vger.kernel.org
Subject: [PATCH 19/19] raid6_kunit: randomize buffer alignment
Date: Tue, 12 May 2026 07:20:59 +0200
Message-ID: <20260512052230.2947683-20-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512052230.2947683-1-hch@lst.de>
References: <20260512052230.2947683-1-hch@lst.de>
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

Add code to add random alignment to the buffers to test the case where
they are not page aligned, and to move the buffers to the end of the
allocation so that they are next to the vmalloc guard page.

This does not include the recovery buffers as the recovery requires
page alignment.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/raid/raid6/tests/raid6_kunit.c | 41 +++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/lib/raid/raid6/tests/raid6_kunit.c b/lib/raid/raid6/tests/raid6_kunit.c
index d6ac777dcaee..7b45c7be36fc 100644
--- a/lib/raid/raid6/tests/raid6_kunit.c
+++ b/lib/raid/raid6/tests/raid6_kunit.c
@@ -21,6 +21,7 @@ MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 
 static struct rnd_state rng;
 static void *test_buffers[RAID6_KUNIT_MAX_BUFFERS];
+static void *aligned_buffers[RAID6_KUNIT_MAX_BUFFERS];
 static void *test_recov_buffers[RAID6_KUNIT_MAX_FAILURES];
 static size_t test_buflen;
 
@@ -50,6 +51,14 @@ static unsigned int random_nr_buffers(void)
 			RAID6_MIN_DISKS;
 }
 
+/* Generate a random alignment that is a multiple of 64. */
+static unsigned int random_alignment(unsigned int max_alignment)
+{
+	if (max_alignment == 0)
+		return 0;
+	return (rand32() % (max_alignment + 1)) & ~63;
+}
+
 static void makedata(int start, int stop)
 {
 	int i;
@@ -80,7 +89,7 @@ static void test_recover_one(struct kunit *test, unsigned int nr_buffers,
 	for (i = 0; i < RAID6_KUNIT_MAX_FAILURES; i++)
 		memset(test_recov_buffers[i], 0xf0, test_buflen);
 
-	memcpy(dataptrs, test_buffers, sizeof(dataptrs));
+	memcpy(dataptrs, aligned_buffers, sizeof(dataptrs));
 	dataptrs[faila] = test_recov_buffers[0];
 	dataptrs[failb] = test_recov_buffers[1];
 
@@ -102,13 +111,13 @@ static void test_recover_one(struct kunit *test, unsigned int nr_buffers,
 		ta->recov->data2(nr_buffers, len, faila, failb, dataptrs);
 	}
 
-	KUNIT_EXPECT_MEMEQ_MSG(test, test_buffers[faila], test_recov_buffers[0],
+	KUNIT_EXPECT_MEMEQ_MSG(test, aligned_buffers[faila], dataptrs[faila],
 			len,
 			"faila miscompared: %3d[%c] buffers %u len %u (failb=%3d[%c])\n",
 			faila, member_type(nr_buffers, faila),
 			nr_buffers, len,
 			failb, member_type(nr_buffers, failb));
-	KUNIT_EXPECT_MEMEQ_MSG(test, test_buffers[failb], test_recov_buffers[1],
+	KUNIT_EXPECT_MEMEQ_MSG(test, aligned_buffers[failb], dataptrs[failb],
 			len,
 			"failb miscompared: %3d[%c] buffers %u len %u (faila=%3d[%c])\n",
 			failb, member_type(nr_buffers, failb),
@@ -152,9 +161,9 @@ static void test_rmw_one(struct kunit *test, unsigned int nr_buffers,
 {
 	const struct test_args *ta = test->param_value;
 
-	ta->gen->xor_syndrome(nr_buffers, p1, p2, len, test_buffers);
+	ta->gen->xor_syndrome(nr_buffers, p1, p2, len, aligned_buffers);
 	makedata(p1, p2);
-	ta->gen->xor_syndrome(nr_buffers, p1, p2, len, test_buffers);
+	ta->gen->xor_syndrome(nr_buffers, p1, p2, len, aligned_buffers);
 	test_recover(test, nr_buffers, len);
 }
 
@@ -178,13 +187,33 @@ static void raid6_test_one(struct kunit *test)
 	const struct test_args *ta = test->param_value;
 	unsigned int nr_buffers = random_nr_buffers();
 	unsigned int len = random_length(RAID6_KUNIT_MAX_BYTES);
+	unsigned int max_alignment;
+	int i;
 
 	/* Nuke syndromes */
 	memset(test_buffers[nr_buffers - 2], 0xee, test_buflen);
 	memset(test_buffers[nr_buffers - 1], 0xee, test_buflen);
 
+	/*
+	 * If we're not using the entire buffer size, inject randomize alignment
+	 * into the buffer.
+	 */
+	max_alignment = RAID6_KUNIT_MAX_BYTES - len;
+	if (rand32() % 2 == 0) {
+		/* Use random alignments mod 64 */
+		for (i = 0; i < nr_buffers; i++)
+			aligned_buffers[i] = test_buffers[i] +
+				random_alignment(max_alignment);
+	} else {
+		/* Go up to the guard page, to catch buffer overreads */
+		unsigned int align = test_buflen - len;
+
+		for (i = 0; i < nr_buffers; i++)
+			aligned_buffers[i] = test_buffers[i] + align;
+	}
+
 	/* Generate assumed good syndrome */
-	ta->gen->gen_syndrome(nr_buffers, len, test_buffers);
+	ta->gen->gen_syndrome(nr_buffers, len, aligned_buffers);
 
 	test_recover(test, nr_buffers, len);
 
-- 
2.53.0


