Return-Path: <linuxppc-dev+bounces-18867-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1A210A62D1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 02:17:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhkmJ4ndLz3bll;
	Fri, 27 Mar 2026 13:16:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.179
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774577808;
	cv=none; b=iStAfePK6p2ZU4lBbs+87T4zcj+evGtG1AzZ7/rHXEoPg05RfgityOtbTExcMiX0Pn6iP/B0hzFGIm+B5W60fHAhYId0mYZ5DqFOZ4dVsWTIU1g+0zY13IO/bbr5lWW72WUpFYeU0SxlEI7xNTobxEKFW6VxikhUYkYf8ncxdLxsr1XumlOHEcAKD8bEmteW5y45Ih8WiHqntNS1is0QF0S1RwvZonLN4oDgDmE37Fw8txYPC8SkuRFr0WWm7ZbBdhLJhDbAZ4ibvNQsSK7O/8jnYT7/tl07ZS+FCZocuHB3gttACB3SqDCf49VzH29mDaftw6fJglbKn5zYc0dbMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774577808; c=relaxed/relaxed;
	bh=6/HdPBhl1cpZOUmiZuBTWaeHIDSWjs3qo4yxLZnBGpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6k/bthJJwOtJmvfztIUIxzuxT2mbA8Qx0W+OMkwR8K1IoDz+eaTZXSMmUl7+zNaBRuMtzrs4a/jPHZiZ3L1Ey+yhRfWUh/Uz1Pp/qiYnDLGwXXYDSWrgVuirNz447ho1pVu7Ow699ZeTSfzahKcPcM+bHJ/XINDvhUc3++tUtBZgymUlDTwCnB89NYZJaNDshNjIsJ5sKYMSYvIIlQL8aUwPNkKaqtI5xT4e7eijJl/LuR9OElz8K9DU+4dJt/yzcCjks/MVIVAhyrtoOtR5UpyBvCUZdyvfKa18Z4IsnSf8b3OiQVeHa7qX1SCbncU9BIGFuWt2E/bz2GX9hyMwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LBA+DGA7; dkim-atps=neutral; spf=pass (client-ip=95.215.58.179; helo=out-179.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LBA+DGA7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.179; helo=out-179.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhkmJ06JXz2yrQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 13:16:48 +1100 (AEDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774577789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6/HdPBhl1cpZOUmiZuBTWaeHIDSWjs3qo4yxLZnBGpA=;
	b=LBA+DGA7C1hpEc4UK/USzbeWl9ofYAB9golUoHkRx3arz+0f+tCFBPShuiq8sFBcmjRcuj
	BkqIUVWSZWrzlncJMS6q2HSKiSIKaHundpnJFyYH9WZp0Dq8jBzWfRFloYOIU6zqnN8+4q
	hwvlj8SU2eHG55dpFcr7cLa/cO3P9xE=
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	david@kernel.org,
	Lorenzo Stoakes <ljs@kernel.org>,
	willy@infradead.org,
	linux-mm@kvack.org
Cc: fvdl@google.com,
	hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kas@kernel.org,
	baohua@kernel.org,
	dev.jain@arm.com,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	Liam.Howlett@oracle.com,
	ryan.roberts@arm.com,
	Vlastimil Babka <vbabka@kernel.org>,
	lance.yang@linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	linux-s390@vger.kernel.org,
	Usama Arif <usama.arif@linux.dev>
Subject: [v3 24/24] selftests/mm: add madv_dontneed_partial test
Date: Thu, 26 Mar 2026 19:09:06 -0700
Message-ID: <20260327021403.214713-25-usama.arif@linux.dev>
In-Reply-To: <20260327021403.214713-1-usama.arif@linux.dev>
References: <20260327021403.214713-1-usama.arif@linux.dev>
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
X-Migadu-Flow: FLOW_OUT

Add test for partial MADV_DONTNEED on THP. This verifies that
MADV_DONTNEED correctly triggers a PMD split, discards only the
requested page (which becomes zero-filled), and preserves data
in the surrounding pages.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 .../testing/selftests/mm/thp_pmd_split_test.c | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/mm/thp_pmd_split_test.c b/tools/testing/selftests/mm/thp_pmd_split_test.c
index 1f29296759a5b..060ca1e341b75 100644
--- a/tools/testing/selftests/mm/thp_pmd_split_test.c
+++ b/tools/testing/selftests/mm/thp_pmd_split_test.c
@@ -253,4 +253,38 @@ TEST_F(thp_pmd_split, partial_mremap)
 		self->split_pmd_failed_before);
 }
 
+/*
+ * MADV_DONTNEED on THP
+ *
+ * Tests that MADV_DONTNEED on a partial THP correctly handles
+ * the PMD split and discards only the requested pages.
+ */
+TEST_F(thp_pmd_split, partial_madv_dontneed)
+{
+	volatile unsigned char *ptr = (volatile unsigned char *)self->aligned;
+	int ret;
+
+	ret = allocate_thp(self->aligned, self->pmdsize);
+	if (ret)
+		SKIP(return, "Failed to allocate THP");
+
+	/* Write pattern */
+	memset(self->aligned, 0xDD, self->pmdsize);
+
+	/* Partial MADV_DONTNEED - discard middle page */
+	ret = madvise((char *)self->aligned + self->pagesize, self->pagesize, MADV_DONTNEED);
+	ASSERT_EQ(ret, 0);
+
+	/* Verify non-discarded pages still have data */
+	ASSERT_EQ(ptr[0], (unsigned char)0xDD);
+	ASSERT_EQ(ptr[2 * self->pagesize], (unsigned char)0xDD);
+	ASSERT_EQ(ptr[self->pmdsize - 1], (unsigned char)0xDD);
+
+	/* Discarded page should be zero */
+	ASSERT_EQ(ptr[self->pagesize], (unsigned char)0x00);
+
+	log_and_check_pmd_split(_metadata, self->split_pmd_before,
+		self->split_pmd_failed_before);
+}
+
 TEST_HARNESS_MAIN
-- 
2.52.0


