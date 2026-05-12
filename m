Return-Path: <linuxppc-dev+bounces-20739-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C83CD4851
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2026 05:25:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gF4n63ZP5z2yQL;
	Tue, 12 May 2026 15:25:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778563546;
	cv=none; b=I0SIn4JCR1sipCzWaNSwzjk+Hn5DBuA3Hvpy1K6rmQ/85GVRCwO0EexQf/6kPvlhB4f1IOBbCQNzDz3OM6eFGoQPMGTKZyyghyTpYSY88JYhItYXfDVLLHDJuaS1fMXppOKxvXh2O0QBlSZk41WaiNVS0wKmKoYfzIt1XDA/ST/K6PigDxtJJt3EIHHPkaH4cHX+WvZ/60nEp+cVED2nn5uBI3jdGJFyzQEHwvylTinL15AKCDqVtKF18NiIGaD18kA7jLnAQwJZHmw18HYypjHRkCKHr73AkyovdYHoSaRk8F/h4qECaPwhapwQMLExqWNuYWo1idm7cEX8fFoS6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778563546; c=relaxed/relaxed;
	bh=vl+5mowQ+IWT1EcswY0gHPiW2UKDQbjNZxRcxx/c7vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O+jyYtupjFJTmKxFQ+mrcfnWbB7tGj6bNlEmihRLcBY3DLLde5zojdsoHbkV1KoDfTS9m0P9bUphoPE65D8dbH6Ro+6myaVJpErjiyXDvWyakuAee/568hPAcog8rC/Q9tdxfwSLKS7Do4UGZx7nmWHibGs3boZgtUOJSDkb7rWizKZ1SayHvbXRajR1rUot2nt5fpVBrOsTUsQ/ESU/2LUHMcmZpAR1ZVFXEjKTu3eQGHQKSxO1qfxPKg+SaWRCKUQPkpN7e+APehvX+zPQ5dhfqfLd6muoiaJovgZP+SkmBGncgpylYjoVw0v9n99qcyALSnwmvuWhitATYv4K8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=P4eoRFDX; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+9f3c1ea353498f61ccd0+8297+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=P4eoRFDX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+9f3c1ea353498f61ccd0+8297+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gF4n56sgmz302b
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 15:25:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vl+5mowQ+IWT1EcswY0gHPiW2UKDQbjNZxRcxx/c7vs=; b=P4eoRFDXfUg+guOXW5a420ZkIg
	HzEjY12fqFbJjg7rIYbq/1j4rI5j5QjXDg7wwjvZuktffMZq0+hD4Y9Yd7rmywZsSNq1VV+ZCkaFH
	11aLh1v6lnQLp4FDt6uaX00LDKmz9BgoZOFt8KaZc38j/vGT6HsKTS1MbpeKbEkY/bWSZxmwnsiMj
	2M2lLDNgXcJFfZxl9hrXLRORIdbnF0U3arYUIUMCHOHmlgNbLGWhIMQxUTDW0EHMFh+KYYqOPNz4b
	NXiDz2fRGbZDLZb0X/zbTW5TK3QyWIYbrqZPB8RLRdvu+BqMVLIjaGVGwilnzUN+rHZ8C5oY9ULr+
	m4lzLRWg==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMfca-0000000FckH-298U;
	Tue, 12 May 2026 05:25:32 +0000
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
Subject: [PATCH 15/19] raid6_kunit: dynamically allocate data buffers using vmalloc
Date: Tue, 12 May 2026 07:20:55 +0200
Message-ID: <20260512052230.2947683-16-hch@lst.de>
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

Use vmalloc for the data buffers instead of using static .data allocations.
This provides for better out of bounds checking and avoids wasting kernel
memory after the test has run.  vmalloc is used instead of kmalloc to
provide for better out of bounds access checking as in other kunit tests.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/raid/raid6/tests/raid6_kunit.c | 77 ++++++++++++++++++++++++------
 1 file changed, 62 insertions(+), 15 deletions(-)

diff --git a/lib/raid/raid6/tests/raid6_kunit.c b/lib/raid/raid6/tests/raid6_kunit.c
index f55b081b6b13..a4b65ccc9d20 100644
--- a/lib/raid/raid6/tests/raid6_kunit.c
+++ b/lib/raid/raid6/tests/raid6_kunit.c
@@ -7,19 +7,20 @@
 
 #include <kunit/test.h>
 #include <linux/prandom.h>
+#include <linux/vmalloc.h>
 #include "../algos.h"
 
 MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 
 #define RAID6_KUNIT_SEED		42
+#define RAID6_KUNIT_MAX_FAILURES	2
 
 #define NDISKS		16	/* Including P and Q */
 
 static struct rnd_state rng;
 static void *dataptrs[NDISKS];
-static char data[NDISKS][PAGE_SIZE] __attribute__((aligned(PAGE_SIZE)));
-static char recovi[PAGE_SIZE] __attribute__((aligned(PAGE_SIZE)));
-static char recovj[PAGE_SIZE] __attribute__((aligned(PAGE_SIZE)));
+static void *test_buffers[NDISKS];
+static void *test_recov_buffers[RAID6_KUNIT_MAX_FAILURES];
 
 struct test_args {
 	unsigned int recov_idx;
@@ -35,8 +36,8 @@ static void makedata(int start, int stop)
 	int i;
 
 	for (i = start; i <= stop; i++) {
-		prandom_bytes_state(&rng, data[i], PAGE_SIZE);
-		dataptrs[i] = data[i];
+		prandom_bytes_state(&rng, test_buffers[i], PAGE_SIZE);
+		dataptrs[i] = test_buffers[i];
 	}
 }
 
@@ -55,12 +56,13 @@ static char member_type(int d)
 static void test_recover(struct kunit *test, int faila, int failb)
 {
 	const struct test_args *ta = test->param_value;
+	int i;
 
-	memset(recovi, 0xf0, PAGE_SIZE);
-	memset(recovj, 0xba, PAGE_SIZE);
+	for (i = 0; i < RAID6_KUNIT_MAX_FAILURES; i++)
+		memset(test_recov_buffers[i], 0xf0, PAGE_SIZE);
 
-	dataptrs[faila] = recovi;
-	dataptrs[failb] = recovj;
+	dataptrs[faila] = test_recov_buffers[0];
+	dataptrs[failb] = test_recov_buffers[1];
 
 	if (failb == NDISKS - 1) {
 		/*
@@ -80,18 +82,20 @@ static void test_recover(struct kunit *test, int faila, int failb)
 		ta->recov->data2(NDISKS, PAGE_SIZE, faila, failb, dataptrs);
 	}
 
-	KUNIT_EXPECT_MEMEQ_MSG(test, data[faila], recovi, PAGE_SIZE,
+	KUNIT_EXPECT_MEMEQ_MSG(test, test_buffers[faila], test_recov_buffers[0],
+			PAGE_SIZE,
 			"faila miscompared: %3d[%c] (failb=%3d[%c])\n",
 			faila, member_type(faila),
 			failb, member_type(failb));
-	KUNIT_EXPECT_MEMEQ_MSG(test, data[failb], recovj, PAGE_SIZE,
+	KUNIT_EXPECT_MEMEQ_MSG(test, test_buffers[failb], test_recov_buffers[1],
+			PAGE_SIZE,
 			"failb miscompared: %3d[%c] (faila=%3d[%c])\n",
 			failb, member_type(failb),
 			faila, member_type(faila));
 
 skip:
-	dataptrs[faila] = data[faila];
-	dataptrs[failb] = data[failb];
+	dataptrs[faila] = test_buffers[faila];
+	dataptrs[failb] = test_buffers[failb];
 }
 
 static void raid6_test(struct kunit *test)
@@ -100,8 +104,8 @@ static void raid6_test(struct kunit *test)
 	int i, j, p1, p2;
 
 	/* Nuke syndromes */
-	memset(data[NDISKS - 2], 0xee, PAGE_SIZE);
-	memset(data[NDISKS - 1], 0xee, PAGE_SIZE);
+	memset(test_buffers[NDISKS - 2], 0xee, PAGE_SIZE);
+	memset(test_buffers[NDISKS - 1], 0xee, PAGE_SIZE);
 
 	/* Generate assumed good syndrome */
 	ta->gen->gen_syndrome(NDISKS, PAGE_SIZE, (void **)&dataptrs);
@@ -161,15 +165,58 @@ static struct kunit_case raid6_test_cases[] = {
 
 static int raid6_suite_init(struct kunit_suite *suite)
 {
+	int i;
+
 	prandom_seed_state(&rng, RAID6_KUNIT_SEED);
+
+	/*
+	 * Allocate the test buffer using vmalloc() with a page-aligned length
+	 * so that it is immediately followed by a guard page.  This allows
+	 * buffer overreads to be detected, even in assembly code.
+	 */
+	for (i = 0; i < RAID6_KUNIT_MAX_FAILURES; i++) {
+		test_recov_buffers[i] = vmalloc(PAGE_SIZE);
+		if (!test_recov_buffers[i])
+			goto out_free_recov_buffers;
+	}
+	for (i = 0; i < NDISKS; i++) {
+		test_buffers[i] = vmalloc(PAGE_SIZE);
+		if (!test_buffers[i])
+			goto out_free_buffers;
+	}
+
 	makedata(0, NDISKS - 1);
+
 	return 0;
+
+out_free_buffers:
+	for (i = 0; i < NDISKS; i++)
+		vfree(test_buffers[i]);
+	memset(test_buffers, 0, sizeof(test_buffers));
+out_free_recov_buffers:
+	for (i = 0; i < RAID6_KUNIT_MAX_FAILURES; i++)
+		vfree(test_recov_buffers[i]);
+	memset(test_recov_buffers, 0, sizeof(test_recov_buffers));
+	return -ENOMEM;
+}
+
+static void raid6_suite_exit(struct kunit_suite *suite)
+{
+	int i;
+
+	for (i = 0; i < NDISKS; i++)
+		vfree(test_buffers[i]);
+	memset(test_buffers, 0, sizeof(test_buffers));
+	for (i = 0; i < RAID6_KUNIT_MAX_FAILURES; i++)
+		vfree(test_recov_buffers[i]);
+	memset(test_recov_buffers, 0, sizeof(test_recov_buffers));
 }
 
 static struct kunit_suite raid6_test_suite = {
 	.name		= "raid6",
 	.test_cases	= raid6_test_cases,
 	.suite_init	= raid6_suite_init,
+	.suite_exit	= raid6_suite_exit,
 };
 kunit_test_suite(raid6_test_suite);
 
-- 
2.53.0


