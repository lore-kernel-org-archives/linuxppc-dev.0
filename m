Return-Path: <linuxppc-dev+bounces-21106-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FC2CD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 08:55:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJs8X4vznz3bs5;
	Mon, 18 May 2026 18:55:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779094540;
	cv=none; b=lH3YaxoTiGfDKrUDtgRz1EJB981hwdgd71ofpG/Oq3hayCSBMIJTtWQcShmSjh6SCfWpRBWRue1zuWc6T7yNezrTti6zOMcs+0RHZ/X6aR1nOtku4W7u40DPPFbOkex/tgDw+3u70f88UphL15nXr2bN3OB/apv/za+uqL14XEhjmiB3iqdXpVYjlI8HfJwd39/9qEr2U5aMqb0smgG1pv9KrSIRbaaez2HzPKj9wp43Ixc1owCeD6LZmxrIjD771e4gXTUCccSyNhW2MyzEXWuNTeOPEUq5nRfOmIu3U4EKCENph/UM4YngNncSgftcJs+Olymx+TwGxHPExqL5bA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779094540; c=relaxed/relaxed;
	bh=JfppSwEbo8CVHsJ/3tFLMi3O9oZ5mHSNY9AbWVhXA+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9Hf5e5QbmPsuXmCxl5C/ZXJVoLlSm3OvSpYRXSFY/SfRT2OdwbviEwrNm8nLIxNMzeLxJWjFrer40EhHJ8oRg1EuCTO7R13gmRuo3bW8DG2E2kwqErHSbb/7FFNj/h5pTrG+XvVCA+jsYylEVMUwO8cfav4kwspgfNfQbli1pwwU3r7EpPJVqUYikk7jJzBkY6p4Kt4n9lZDsHf59PY5hmOmiWqj2g5FfOJoWuB8cYveADiUxrr+dLPHogzRat2JnJm5lniagfoxI6E9L1xVAsYaSb9CQ9eS0gS0wg1ef+R7nfxjwCDSUnFXitgfT5PC8DKExtC3FuWBhTDBi3/tQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hlJqx2mf; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=tianruidong@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hlJqx2mf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=tianruidong@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJs8W2dr8z3brR
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 18:55:38 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779094535; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=JfppSwEbo8CVHsJ/3tFLMi3O9oZ5mHSNY9AbWVhXA+M=;
	b=hlJqx2mfmwb9yw43Yi+fQ8Aftt0S6DG768cc4I8S2scE84nLHZzOURCsdgsKXv3vIWR6uLLfme5KpVhOb/UKY+QnXKxRfltiNMcbfWcwoCI83Rzx1AeXwZlQ7XoB1hVBT0IaXPXhFa4JbwGgPjL/H1WCJfiBcnM9DCxOzGzW6e0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X3647Nb_1779094217;
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0X3647Nb_1779094217 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 May 2026 16:50:19 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	rafael@kernel.org,
	tony.luck@intel.com,
	guohanjun@huawei.com,
	mchehab@kernel.org,
	xueshuai@linux.alibaba.com,
	tongtiangen@huawei.com,
	james.morse@arm.com,
	robin.murphy@arm.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	ryabinin.a.a@gmail.com,
	glider@google.com,
	christophe.leroy@csgroup.eu,
	aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com,
	tglx@linutronix.de,
	mingo@redhat.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	tianruidong@linux.alibaba.com
Subject: [PATCH v14 6/8] lib/test: memcpy_kunit: add copy_page() and copy_mc_page() tests
Date: Mon, 18 May 2026 16:49:50 +0800
Message-ID: <20260518084956.2538442-7-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260518084956.2538442-1-tianruidong@linux.alibaba.com>
References: <20260518084956.2538442-1-tianruidong@linux.alibaba.com>
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

Add KUnit tests for copy_page() and copy_mc_page(), modeled after
the existing memcpy_test() style: a static page-aligned src and a
two-page dst, filled with random bytes plus non-zero edges, then
verify byte-for-byte equality and that the adjacent page is
untouched. The copy_mc_page() case additionally checks the return
value is 0 on clean memory and is gated on CONFIG_ARCH_HAS_COPY_MC.

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 lib/tests/memcpy_kunit.c | 67 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/lib/tests/memcpy_kunit.c b/lib/tests/memcpy_kunit.c
index d36933554e46..85df53ccfb0c 100644
--- a/lib/tests/memcpy_kunit.c
+++ b/lib/tests/memcpy_kunit.c
@@ -493,6 +493,67 @@ static void memmove_overlap_test(struct kunit *test)
 	}
 }
 
+/* --- Page-sized copy tests --- */
+
+static u8 page_src[PAGE_SIZE] __aligned(PAGE_SIZE);
+static u8 page_dst[PAGE_SIZE * 2] __aligned(PAGE_SIZE);
+static const u8 page_zero[PAGE_SIZE] __aligned(PAGE_SIZE);
+
+static void init_page(struct kunit *test)
+{
+	/* Get many bit patterns. */
+	get_random_bytes(page_src, PAGE_SIZE);
+
+	/* Make sure we have non-zero edges. */
+	set_random_nonzero(test, &page_src[0]);
+	set_random_nonzero(test, &page_src[PAGE_SIZE - 1]);
+
+	/* Explicitly zero the entire destination. */
+	memset(page_dst, 0, ARRAY_SIZE(page_dst));
+}
+
+static void copy_page_test(struct kunit *test)
+{
+	init_page(test);
+
+	/* Copy. */
+	copy_page(page_dst, page_src);
+
+	/* Verify byte-for-byte exact. */
+	KUNIT_ASSERT_EQ_MSG(test,
+		memcmp(page_dst, page_src, PAGE_SIZE), 0,
+		"copy_page content mismatch with random data");
+
+	/* Verify no overflow into second page. */
+	KUNIT_ASSERT_EQ_MSG(test,
+		memcmp(page_dst + PAGE_SIZE, page_zero, PAGE_SIZE), 0,
+		"copy_page overflow into adjacent page");
+}
+
+#ifdef CONFIG_ARCH_HAS_COPY_MC
+static void copy_mc_page_test(struct kunit *test)
+{
+	int ret;
+
+	init_page(test);
+
+	/* Copy and check return value. */
+	ret = copy_mc_page(page_dst, page_src);
+	KUNIT_ASSERT_EQ_MSG(test, ret, 0,
+		"copy_mc_page returned %d on clean memory", ret);
+
+	/* Verify byte-for-byte exact. */
+	KUNIT_ASSERT_EQ_MSG(test,
+		memcmp(page_dst, page_src, PAGE_SIZE), 0,
+		"copy_mc_page content mismatch with random data");
+
+	/* Verify no overflow into second page. */
+	KUNIT_ASSERT_EQ_MSG(test,
+		memcmp(page_dst + PAGE_SIZE, page_zero, PAGE_SIZE), 0,
+		"copy_mc_page overflow into adjacent page");
+}
+#endif /* CONFIG_ARCH_HAS_COPY_MC */
+
 static struct kunit_case memcpy_test_cases[] = {
 	KUNIT_CASE(memset_test),
 	KUNIT_CASE(memcpy_test),
@@ -500,6 +561,10 @@ static struct kunit_case memcpy_test_cases[] = {
 	KUNIT_CASE_SLOW(memmove_test),
 	KUNIT_CASE_SLOW(memmove_large_test),
 	KUNIT_CASE_SLOW(memmove_overlap_test),
+	KUNIT_CASE(copy_page_test),
+#ifdef CONFIG_ARCH_HAS_COPY_MC
+	KUNIT_CASE(copy_mc_page_test),
+#endif
 	{}
 };
 
@@ -510,5 +575,5 @@ static struct kunit_suite memcpy_test_suite = {
 
 kunit_test_suite(memcpy_test_suite);
 
-MODULE_DESCRIPTION("test cases for memcpy(), memmove(), and memset()");
+MODULE_DESCRIPTION("test cases for memcpy(), memmove(), memset() and copy_page()");
 MODULE_LICENSE("GPL");
-- 
2.39.3


