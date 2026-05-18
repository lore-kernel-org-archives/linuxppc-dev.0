Return-Path: <linuxppc-dev+bounces-21103-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73AE4CD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 08:50:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJs2c00CRz3by8;
	Mon, 18 May 2026 18:50:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779094231;
	cv=none; b=hMv/EtUX+WAcdbGvt4snJpVWLq2oIvjF8NG24DzMpW85vl+sQEIdWYSOOkjstty/e7y/J+myeHQ1UjgKPMoUzTwO2Hc/3y97kaIf3dxrOyjOMwk8obFVikcDnLmfgXMUl9+w6VkMp/aqLkxBqCdKo9J4Z3Q7c3fnbq4WZ+1EFeHu6VGtB3a/hu3msaYDATABpwDeOAlrSCgSSXUMaTkGx6o4Acs/NJSlYkDQFNT3ta9m4iRjHXw3MXL9rSiQv4nN6nTytmF3ClHy6eSilRpbrce1GZCpIYOkJ7RaE/42qBOV8Jdy44S+UKIKIMQJtEoApY/WqgLMuAQcKNoN4xNhzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779094231; c=relaxed/relaxed;
	bh=4ZlFlL/ldqFxlJ/mCuoKEqDloBHgz/6+XLcrhP5/h8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCkjYqMQT918D9jf6yJKTlfMEKgmPIXZF9FJxq+GW8ik5QWyvJTjLXwqidOXVsTt02LIXBRoZ05ry3Z6E1kvV/dgF9FvKqfy9Dq/aQsa+7sxWHw4G/8X94ghn+xDlmRNjPcLhYabL0evOPO8ZVz7iG1NryX6CftCJO8zkB7nOPd4STOH3RgyIiKmjngkid+lJmKdCEX8LcgTJkN/Q3Tq1tareVnILbFJG87OCTLnRgIXsbp90gSSGTIn+L+w3gqVQxxuk54Sd7cSZaMZAEojRbMzyu5nGWIY8ne/HYm8ylCy/BLpMAIFpeDyX/+CECwWE1wflgNtUHCAkYRGoQVv7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=uJoZGfGR; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=tianruidong@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=uJoZGfGR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=tianruidong@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJs2b0znPz3bsy
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 18:50:30 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779094227; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=4ZlFlL/ldqFxlJ/mCuoKEqDloBHgz/6+XLcrhP5/h8w=;
	b=uJoZGfGR2uabJ0rfA3C8SFKfpGjjGGUQuFOZlnA8fZcspelZrbuRcVnJ3RI4zeamr2LYLH4AZPW9DSJxXcUoTjCtT4R+pCcSI0S/l1pcw2eJji3+Y9Tu5YbsprOcziR2kj0GcU6QxNoOz00AGfukC30ObrQeOy9GdvzLa4pctV8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X365dBE_1779094223;
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0X365dBE_1779094223 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 May 2026 16:50:25 +0800
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
Subject: [PATCH v14 8/8] lib/tests: memcpy_kunit: add memcpy_mc() and memcpy_mc_large() test
Date: Mon, 18 May 2026 16:49:52 +0800
Message-ID: <20260518084956.2538442-9-tianruidong@linux.alibaba.com>
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

memcpy_mc() is the Machine-Check safe memcpy variant that returns the
number of bytes NOT copied on a hardware memory error, or 0 on success.

Add two test cases modeled after the existing memcpy_test() and
memcpy_large_test() implementations:

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 lib/tests/memcpy_kunit.c | 113 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 112 insertions(+), 1 deletion(-)

diff --git a/lib/tests/memcpy_kunit.c b/lib/tests/memcpy_kunit.c
index 85df53ccfb0c..b4b2dafb50f1 100644
--- a/lib/tests/memcpy_kunit.c
+++ b/lib/tests/memcpy_kunit.c
@@ -552,6 +552,115 @@ static void copy_mc_page_test(struct kunit *test)
 		memcmp(page_dst + PAGE_SIZE, page_zero, PAGE_SIZE), 0,
 		"copy_mc_page overflow into adjacent page");
 }
+/*
+ * memcpy_mc() is a Machine-Check safe memcpy variant.
+ * Signature: int memcpy_mc(void *dst, const void *src, size_t len)
+ * Returns:   0 on success, or number of bytes NOT copied on MC error.
+ *
+ * In the normal (no-poison) path it must behave identically to memcpy()
+ * and always return 0.
+ */
+static void memcpy_mc_test(struct kunit *test)
+{
+#define TEST_OP "memcpy_mc"
+	struct some_bytes control = {
+		.data = { 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
+			  0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
+			  0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
+			  0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
+		},
+	};
+	struct some_bytes zero = { };
+	struct some_bytes middle = {
+		.data = { 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
+			  0x20, 0x20, 0x20, 0x20, 0x00, 0x00, 0x00, 0x00,
+			  0x00, 0x00, 0x00, 0x20, 0x20, 0x20, 0x20, 0x20,
+			  0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
+		},
+	};
+	struct some_bytes three = {
+		.data = { 0x00, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
+			  0x20, 0x00, 0x00, 0x20, 0x20, 0x20, 0x20, 0x20,
+			  0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
+			  0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
+			},
+	};
+	struct some_bytes dest = { };
+	int ret, count;
+	u8 *ptr;
+
+	/* Verify static initializers. */
+	check(control, 0x20);
+	check(zero, 0);
+	compare("static initializers", dest, zero);
+
+	/* Verify assignment. */
+	dest = control;
+	compare("direct assignment", dest, control);
+
+	/* Verify complete overwrite. */
+	ret = memcpy_mc(dest.data, control.data, sizeof(dest.data));
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	compare("complete overwrite", dest, control);
+
+	/* Verify middle overwrite: 7 bytes at offset 12. */
+	dest = control;
+	ret = memcpy_mc(dest.data + 12, zero.data, 7);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	compare("middle overwrite", dest, middle);
+
+	/* Verify zero-length copy is a no-op. */
+	dest = control;
+	ret = memcpy_mc(dest.data, zero.data, 0);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	compare("zero length", dest, control);
+
+	/* Verify argument side-effects aren't repeated. */
+	dest = control;
+	ptr = dest.data;
+	count = 1;
+	memcpy(ptr++, zero.data, count++);
+	ptr += 8;
+	memcpy(ptr++, zero.data, count++);
+	compare("argument side-effects", dest, three);
+#undef TEST_OP
+}
+
+static void memcpy_mc_large_test(struct kunit *test)
+{
+	init_large(test);
+
+	/* Sweep 1..1024 bytes x shifting offset to cover all template paths. */
+	for (int bytes = 1; bytes <= ARRAY_SIZE(large_src); bytes++) {
+		for (int offset = 0; offset < ARRAY_SIZE(large_src); offset++) {
+			int right_zero_pos = offset + bytes;
+			int right_zero_size = ARRAY_SIZE(large_dst) - right_zero_pos;
+			int ret;
+
+			ret = memcpy_mc(large_dst + offset, large_src, bytes);
+			KUNIT_ASSERT_EQ_MSG(test, ret, 0,
+				"memcpy_mc returned %d with size %d at offset %d",
+				ret, bytes, offset);
+
+			/* No write before copy area. */
+			KUNIT_ASSERT_EQ_MSG(test,
+				memcmp(large_dst, large_zero, offset), 0,
+				"with size %d at offset %d", bytes, offset);
+			/* No write after copy area. */
+			KUNIT_ASSERT_EQ_MSG(test,
+				memcmp(&large_dst[right_zero_pos], large_zero,
+				       right_zero_size), 0,
+				"with size %d at offset %d", bytes, offset);
+			/* Byte-for-byte exact. */
+			KUNIT_ASSERT_EQ_MSG(test,
+				memcmp(large_dst + offset, large_src, bytes), 0,
+				"with size %d at offset %d", bytes, offset);
+
+			memset(large_dst + offset, 0, bytes);
+		}
+		cond_resched();
+	}
+}
 #endif /* CONFIG_ARCH_HAS_COPY_MC */
 
 static struct kunit_case memcpy_test_cases[] = {
@@ -564,6 +673,8 @@ static struct kunit_case memcpy_test_cases[] = {
 	KUNIT_CASE(copy_page_test),
 #ifdef CONFIG_ARCH_HAS_COPY_MC
 	KUNIT_CASE(copy_mc_page_test),
+	KUNIT_CASE(memcpy_mc_test),
+	KUNIT_CASE_SLOW(memcpy_mc_large_test),
 #endif
 	{}
 };
@@ -575,5 +686,5 @@ static struct kunit_suite memcpy_test_suite = {
 
 kunit_test_suite(memcpy_test_suite);
 
-MODULE_DESCRIPTION("test cases for memcpy(), memmove(), memset() and copy_page()");
+MODULE_DESCRIPTION("test cases for memcpy(), memmove(), memset(), copy_page() and memcpy_mc()");
 MODULE_LICENSE("GPL");
-- 
2.39.3


