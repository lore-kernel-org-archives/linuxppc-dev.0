Return-Path: <linuxppc-dev+bounces-21049-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6536DCD343F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 05:22:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJmQ71GB6z3cYB;
	Mon, 18 May 2026 15:22:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779081727;
	cv=none; b=dbbv92yvWssF5U3OSDIHM+yWlZIjxK9YRuG8O/SE9SsazjXTGAfxlpJ42lqCJEtnMsHDCyvijB+oJ13VYeeFVgrIZZXymWaRDOG/vSC+B687o9xSsFQV/yzOoAONNo8y4vBWyPeet1EtJELDS194o0FsNHzAb/kH64Qphr7yYQtb8nWeEdRL0Vq58+hi6yw6xWLk2F7v/Q4X2kPp5lJsui/w0NGo9+agcVl8nPQWg7Bp8iDwKVPCwEENs7yW8n9B2U+BszsRWHU3yv0HZVJ7qQXjCrLQHpAUsg2LuNb/isS7rvzZ4cUe/1fn0U3FsCfeHLgIHVMzAwBlUDP9x9KM5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779081727; c=relaxed/relaxed;
	bh=XTRx2haFr3gxCvClCsumwmEkEgqOkqmpyjR1DXta9wY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/Kh5lXB4fo1TfM/ue+qqa6YvGBCKAG3weJW0XEZl8UWDXWIG2xEiMPO8Dxkj3PSJKBHo7FsKlfMosQskM8HU0dwbWytkmTokkdPHHKCo4G4QU3ptNaXBJEuMouH3n7MF0KALSfV+tX0bOB9ixfV6/Jx0axwc9KHijYygxykLPe+LRP8Ps8pdAvfYlSlPAvWRz3WFiPgD4ouSWdgJ0Nzb0ktnvyLxGRgS5FoVu+2rMrlgmYhHpoiZW+gSHUt7k8gjfET56PvhfIC4wE+L1jU0yOORgT4L65nPTaClyEmCwA0wHzdYHo/9Wc+zNC9GhD5uTge6EZHwPOkH7na5g2Gug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HYCsmvKR; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+a5a5d3dd39d7e5270008+8303+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HYCsmvKR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+a5a5d3dd39d7e5270008+8303+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJmQ63nnZz3cY7
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 15:22:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=XTRx2haFr3gxCvClCsumwmEkEgqOkqmpyjR1DXta9wY=; b=HYCsmvKRDHCX3f9tpIOlGZYKJ2
	I39azwDVKxWTmC6wEJMZzk6wozM4YR0lS4jiyl53dktbMIK9kh7Ta2tjQXmx62ztuZ8iLVllGUqyL
	AX1yAtFQXqY0bTdRZ6wy0d20a9H/NAq/DnD9m/VwYsWLjrGAMVhxXFS5FQkU0GkR88ZixixAN0OmK
	GviPcOPqaV1KduHxDfYbIKZz6fRkYpGhLX+TXMdwowF1W1PWC9K1QFIJ8u7TR+YGG6QmsKZ2jdlbN
	l2nNVfEqiA61AlvKezflRfob8tr9mbdOxFawqlrc6jzRIMwViln+YU+fTURYOsaQgXH2rJ1aU9qix
	TBMsWHew==;
Received: from [2001:4bb8:2d1:6fdb:d67d:128c:34ba:85b8] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOqQH-0000000EHnr-1IS4;
	Mon, 18 May 2026 05:21:49 +0000
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
Subject: [PATCH 14/18] raid6_kunit: use KUNIT_CASE_PARAM
Date: Mon, 18 May 2026 07:17:57 +0200
Message-ID: <20260518051804.462141-15-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518051804.462141-1-hch@lst.de>
References: <20260518051804.462141-1-hch@lst.de>
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

The raid6 test combines various generation and recovery algorithms.  Use
KUNIT_CASE_PARAM and provide a generator that iterates over the possible
combinations instead of looping inside a single test instance.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Ard Biesheuvel <ardb@kernel.org> # kunit only on arm64
---
 lib/raid/raid6/tests/raid6_kunit.c | 120 ++++++++++++++++-------------
 1 file changed, 68 insertions(+), 52 deletions(-)

diff --git a/lib/raid/raid6/tests/raid6_kunit.c b/lib/raid/raid6/tests/raid6_kunit.c
index 4dea1c5acc96..9d06ed9b90e4 100644
--- a/lib/raid/raid6/tests/raid6_kunit.c
+++ b/lib/raid/raid6/tests/raid6_kunit.c
@@ -21,6 +21,15 @@ static char data[NDISKS][PAGE_SIZE] __attribute__((aligned(PAGE_SIZE)));
 static char recovi[PAGE_SIZE] __attribute__((aligned(PAGE_SIZE)));
 static char recovj[PAGE_SIZE] __attribute__((aligned(PAGE_SIZE)));
 
+struct test_args {
+	unsigned int recov_idx;
+	const struct raid6_recov_calls *recov;
+	unsigned int gen_idx;
+	const struct raid6_calls *gen;
+};
+
+static struct test_args args;
+
 static void makedata(int start, int stop)
 {
 	int i;
@@ -43,9 +52,10 @@ static char member_type(int d)
 	}
 }
 
-static void test_disks(struct kunit *test, const struct raid6_calls *calls,
-		const struct raid6_recov_calls *ra, int faila, int failb)
+static void test_recover(struct kunit *test, int faila, int failb)
 {
+	const struct test_args *ta = test->param_value;
+
 	memset(recovi, 0xf0, PAGE_SIZE);
 	memset(recovj, 0xba, PAGE_SIZE);
 
@@ -61,25 +71,23 @@ static void test_disks(struct kunit *test, const struct raid6_calls *calls,
 			goto skip;
 
 		/* P+Q failure.  Just rebuild the syndrome. */
-		calls->gen_syndrome(NDISKS, PAGE_SIZE, dataptrs);
+		ta->gen->gen_syndrome(NDISKS, PAGE_SIZE, dataptrs);
 	} else if (failb == NDISKS - 2) {
 		/* data+P failure. */
-		ra->datap(NDISKS, PAGE_SIZE, faila, dataptrs);
+		ta->recov->datap(NDISKS, PAGE_SIZE, faila, dataptrs);
 	} else {
 		/* data+data failure. */
-		ra->data2(NDISKS, PAGE_SIZE, faila, failb, dataptrs);
+		ta->recov->data2(NDISKS, PAGE_SIZE, faila, failb, dataptrs);
 	}
 
 	KUNIT_EXPECT_MEMEQ_MSG(test, data[faila], recovi, PAGE_SIZE,
-		"algo=%-8s/%-8s faila miscompared: %3d[%c] (failb=%3d[%c])\n",
-	       calls->name, ra->name,
-	       faila, member_type(faila),
-	       failb, member_type(failb));
+			"faila miscompared: %3d[%c] (failb=%3d[%c])\n",
+			faila, member_type(faila),
+			failb, member_type(failb));
 	KUNIT_EXPECT_MEMEQ_MSG(test, data[failb], recovj, PAGE_SIZE,
-		"algo=%-8s/%-8s failb miscompared: %3d[%c] (faila=%3d[%c])\n",
-	       calls->name, ra->name,
-	       failb, member_type(failb),
-	       faila, member_type(faila));
+			"failb miscompared: %3d[%c] (faila=%3d[%c])\n",
+			failb, member_type(failb),
+			faila, member_type(faila));
 
 skip:
 	dataptrs[faila] = data[faila];
@@ -88,58 +96,66 @@ static void test_disks(struct kunit *test, const struct raid6_calls *calls,
 
 static void raid6_test(struct kunit *test)
 {
+	const struct test_args *ta = test->param_value;
 	int i, j, p1, p2;
-	unsigned int r, g;
-
-	for (r = 0; ; r++) {
-		const struct raid6_recov_calls *ra = raid6_recov_algo_find(r);
-
-		if (!ra)
-			break;
-
-		for (g = 0; ; g++) {
-			const struct raid6_calls *calls = raid6_algo_find(g);
-
-			if (!calls)
-				break;
 
-			/* Nuke syndromes */
-			memset(data[NDISKS - 2], 0xee, PAGE_SIZE);
-			memset(data[NDISKS - 1], 0xee, PAGE_SIZE);
+	/* Nuke syndromes */
+	memset(data[NDISKS - 2], 0xee, PAGE_SIZE);
+	memset(data[NDISKS - 1], 0xee, PAGE_SIZE);
 
-			/* Generate assumed good syndrome */
-			calls->gen_syndrome(NDISKS, PAGE_SIZE,
-						(void **)&dataptrs);
+	/* Generate assumed good syndrome */
+	ta->gen->gen_syndrome(NDISKS, PAGE_SIZE, (void **)&dataptrs);
 
-			for (i = 0; i < NDISKS-1; i++)
-				for (j = i+1; j < NDISKS; j++)
-					test_disks(test, calls, ra, i, j);
+	for (i = 0; i < NDISKS - 1; i++)
+		for (j = i + 1; j < NDISKS; j++)
+			test_recover(test, i, j);
 
-			if (!calls->xor_syndrome)
-				continue;
+	if (!ta->gen->xor_syndrome)
+		return;
 
-			for (p1 = 0; p1 < NDISKS-2; p1++)
-				for (p2 = p1; p2 < NDISKS-2; p2++) {
+	for (p1 = 0; p1 < NDISKS - 2; p1++) {
+		for (p2 = p1; p2 < NDISKS - 2; p2++) {
+			/* Simulate rmw run */
+			ta->gen->xor_syndrome(NDISKS, p1, p2, PAGE_SIZE,
+					(void **)&dataptrs);
+			makedata(p1, p2);
+			ta->gen->xor_syndrome(NDISKS, p1, p2, PAGE_SIZE,
+					(void **)&dataptrs);
 
-					/* Simulate rmw run */
-					calls->xor_syndrome(NDISKS, p1, p2, PAGE_SIZE,
-								(void **)&dataptrs);
-					makedata(p1, p2);
-					calls->xor_syndrome(NDISKS, p1, p2, PAGE_SIZE,
-                                                                (void **)&dataptrs);
+			for (i = 0; i < NDISKS - 1; i++)
+				for (j = i + 1; j < NDISKS; j++)
+					test_recover(test, i, j);
+		}
+	}
+}
 
-					for (i = 0; i < NDISKS-1; i++)
-						for (j = i+1; j < NDISKS; j++)
-							test_disks(test, calls,
-									ra, i, j);
-				}
+static const void *raid6_gen_params(struct kunit *test, const void *prev,
+		char *desc)
+{
+	if (!prev) {
+		memset(&args, 0, sizeof(args));
+next_algo:
+		args.recov_idx = 0;
+		args.gen = raid6_algo_find(args.gen_idx);
+		if (!args.gen)
+			return NULL;
+	}
 
-		}
+	if (args.recov)
+		args.recov_idx++;
+	args.recov = raid6_recov_algo_find(args.recov_idx);
+	if (!args.recov) {
+		args.gen_idx++;
+		goto next_algo;
 	}
+
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "gen=%s recov=%s",
+			args.gen->name, args.recov->name);
+	return &args;
 }
 
 static struct kunit_case raid6_test_cases[] = {
-	KUNIT_CASE(raid6_test),
+	KUNIT_CASE_PARAM(raid6_test, raid6_gen_params),
 	{},
 };
 
-- 
2.53.0


