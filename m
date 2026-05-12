Return-Path: <linuxppc-dev+bounces-20740-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE445CD4851
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2026 05:26:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gF4nM3ZPKz2yZZ;
	Tue, 12 May 2026 15:25:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778563559;
	cv=none; b=leNpj8Aa0rCSXB4FcBfL41Ox7b4RQ5OCzvOSZ76QaYY3e1RsS5FnK9qybEHmXWiGzxZ8DrY2SCofRG6is9nVr9fdJg225kLnyfkz5QPBlHomiJWtmYGj62sZLGqFSh1l9mypqzNX2l1G10gW6etw9Ft3INeQoeu7EDKkmVCGUPEw5OAhpkeURMknqE0MPVnb3sTzxmAPet/oW9QYHwPrlAwhfCXFxbdGSSMqT32gM7gMOChN9Ijji/IVpB+ATi6sTTdVisttKkzIQ4vSzngl9i1kFaiJf4XWXZXa803HjFQllrrBn8w9SHrYysrEOavH+dyHuyK3K67aMa2EPBXGyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778563559; c=relaxed/relaxed;
	bh=cqy6EJ+DAAyM/VnpEUPz3z/s1EsfdtWJN6hwAdKq4KU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AKbB56o+b3qKRIbUShkRKvKEm64+JGjwElhGAT+SKhmXP9dtH4A1eAMU8LNzP/P3lHAwOVi/y2vEXhgHw1fDW9Le5YIVm9Uf7c7bvGXQNyk87dHOXuNHLd+18/KDyMAtRK6G+AO3cNG5gArMAKQha67HMNaSbOrqHGNOfrJATHACh4VlZdToruXfFwH38fKQcSOU6i3Gy8pUaoyZRyq1ND9uh9MPhlbj45U83Iw7W+/xGg8dzzvOAWLqqYyKRVvRtBRhyh002krqxzjsS2T16BoLKrjbK6vFJKFkv0o+pEIbz1sG9hwenGIu7Zg9ci/vyFXhBFZGNZ2sLGA7W+u0ig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FAzpgGMo; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+9f3c1ea353498f61ccd0+8297+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FAzpgGMo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+9f3c1ea353498f61ccd0+8297+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gF4nL6vsnz2yZ8
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 15:25:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=cqy6EJ+DAAyM/VnpEUPz3z/s1EsfdtWJN6hwAdKq4KU=; b=FAzpgGMo+/bXtbIv10YgLtglz6
	v7utTmKRkypCgOQui9UK0csGEHVvxi7OtDswowNps6ZSuO9O55SKsuXaETugfQ8EUBqHc/NKvOljH
	HTkPlRc0x3lHM0U2ZRF/g9AhybwjVJTly0HEcIRgDd/0IFOr2MTAEFZUajlg+AKXjYQ30cH21Dffj
	L5FLx6Sx+p7x+Uf9IlY6xLQ5lTXm9T14ArX38pOLkgMqOMr3rvzdoVQ5BLW2onRtsZRfHFwop36fA
	/Ny8P84nyZI4NGnSC1pnhRJw4YJWl7PLLl04s9spdvePzA5oBNU/AujZNdfd6lzUOa0yvuG1UF6T/
	F4xBG7wQ==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMfcl-0000000Fcw6-1H8r;
	Tue, 12 May 2026 05:25:43 +0000
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
Subject: [PATCH 16/19] raid6_kunit: cleanup dataptr handling
Date: Tue, 12 May 2026 07:20:56 +0200
Message-ID: <20260512052230.2947683-17-hch@lst.de>
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

Move the global dataptr array into test_recover() as all sites that fill
data or parity can use test_buffers directly, and this localized the
override for the failed slots to the recovery testing routine.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/raid/raid6/tests/raid6_kunit.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/lib/raid/raid6/tests/raid6_kunit.c b/lib/raid/raid6/tests/raid6_kunit.c
index a4b65ccc9d20..28b4467977c5 100644
--- a/lib/raid/raid6/tests/raid6_kunit.c
+++ b/lib/raid/raid6/tests/raid6_kunit.c
@@ -18,7 +18,6 @@ MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 #define NDISKS		16	/* Including P and Q */
 
 static struct rnd_state rng;
-static void *dataptrs[NDISKS];
 static void *test_buffers[NDISKS];
 static void *test_recov_buffers[RAID6_KUNIT_MAX_FAILURES];
 
@@ -35,10 +34,8 @@ static void makedata(int start, int stop)
 {
 	int i;
 
-	for (i = start; i <= stop; i++) {
+	for (i = start; i <= stop; i++)
 		prandom_bytes_state(&rng, test_buffers[i], PAGE_SIZE);
-		dataptrs[i] = test_buffers[i];
-	}
 }
 
 static char member_type(int d)
@@ -56,11 +53,13 @@ static char member_type(int d)
 static void test_recover(struct kunit *test, int faila, int failb)
 {
 	const struct test_args *ta = test->param_value;
+	void *dataptrs[NDISKS];
 	int i;
 
 	for (i = 0; i < RAID6_KUNIT_MAX_FAILURES; i++)
 		memset(test_recov_buffers[i], 0xf0, PAGE_SIZE);
 
+	memcpy(dataptrs, test_buffers, sizeof(dataptrs));
 	dataptrs[faila] = test_recov_buffers[0];
 	dataptrs[failb] = test_recov_buffers[1];
 
@@ -70,7 +69,7 @@ static void test_recover(struct kunit *test, int faila, int failb)
 		 * is equivalent to a RAID-5 failure (XOR, then recompute Q).
 		 */
 		if (faila != NDISKS - 2)
-			goto skip;
+			return;
 
 		/* P+Q failure.  Just rebuild the syndrome. */
 		ta->gen->gen_syndrome(NDISKS, PAGE_SIZE, dataptrs);
@@ -92,10 +91,6 @@ static void test_recover(struct kunit *test, int faila, int failb)
 			"failb miscompared: %3d[%c] (faila=%3d[%c])\n",
 			failb, member_type(failb),
 			faila, member_type(faila));
-
-skip:
-	dataptrs[faila] = test_buffers[faila];
-	dataptrs[failb] = test_buffers[failb];
 }
 
 static void raid6_test(struct kunit *test)
@@ -108,7 +103,7 @@ static void raid6_test(struct kunit *test)
 	memset(test_buffers[NDISKS - 1], 0xee, PAGE_SIZE);
 
 	/* Generate assumed good syndrome */
-	ta->gen->gen_syndrome(NDISKS, PAGE_SIZE, (void **)&dataptrs);
+	ta->gen->gen_syndrome(NDISKS, PAGE_SIZE, test_buffers);
 
 	for (i = 0; i < NDISKS - 1; i++)
 		for (j = i + 1; j < NDISKS; j++)
@@ -121,10 +116,10 @@ static void raid6_test(struct kunit *test)
 		for (p2 = p1; p2 < NDISKS - 2; p2++) {
 			/* Simulate rmw run */
 			ta->gen->xor_syndrome(NDISKS, p1, p2, PAGE_SIZE,
-					(void **)&dataptrs);
+					test_buffers);
 			makedata(p1, p2);
 			ta->gen->xor_syndrome(NDISKS, p1, p2, PAGE_SIZE,
-					(void **)&dataptrs);
+					test_buffers);
 
 			for (i = 0; i < NDISKS - 1; i++)
 				for (j = i + 1; j < NDISKS; j++)
-- 
2.53.0


