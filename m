Return-Path: <linuxppc-dev+bounces-17264-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B5CFC5933
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Feb 2026 11:36:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fM8XL6w1Cz3bt1;
	Thu, 26 Feb 2026 22:35:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::b0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772105730;
	cv=none; b=Yp+XigVKWjmEwP4yboPbiF1v7BVXQh6S+aL7E8k/XrrDdCG/dLjYMAjWOASUB31nu522mx/zn1m0OqxU9z9Rx3a1HMFhulXv60G6KEZ1129vPpfnxbL2S/jee9Vu+38nnditLmKnJhI1j2L2q+ly9sJljBMUX3eGc/nTIxjrYHIYhVIECy11j9P/bgewR8wxzv5vl2tch9wzekXaTHCqT8/HdYWiZdmEd/HiYpjx3rM8rlxbWRq6yIL53TulMjnIdwlKKb7SxCmqt0j3O1bYYvU5QGKBJsixbTztifm/P+SFmR3zn1KCrCGsGp6Va+g0QvChjVMwkA3AyU+n3IR5jw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772105730; c=relaxed/relaxed;
	bh=NNFcsrTCJuN3pq1P0jDB1SWfqOIjrkZR0u7eCL/hrlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n0wxlgD939Bek4dxfZwmVr0T3iqlIhJqFa7iHOyGz38BpAgqIt6tRKtHqg5BnRSNN5Jo0tElB1bWiid+vh/fPRpmD0MCHeDCdR8LCJB07EQCkQGp1uc3gQgVLY7G48F2NjHvq5eKdMC2Phm9jdPYGtJxgAXirAebgO+OjfogBWONno2FjKp15+ehF1PVaiwlZ+4UnWgkRp5VHT+umQLNWFpj+ZX7DD79iyT+tiGyVs6p/Ea9JfO/ARZ7PZcm7VD82C0Yc7BTs7lUk9u5TafyADMDnDlxJLTF7KAN9fFmVHe92AzQGPGixV4j7pN6WLsQX9K6npqEVL3zjrBUCZYkTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KI9SLjRO; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::b0; helo=out-176.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KI9SLjRO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::b0; helo=out-176.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 118 seconds by postgrey-1.37 at boromir; Thu, 26 Feb 2026 22:35:30 AEDT
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [IPv6:2001:41d0:203:375::b0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fM8XL1xD5z3bsC
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2026 22:35:30 +1100 (AEDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772105711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NNFcsrTCJuN3pq1P0jDB1SWfqOIjrkZR0u7eCL/hrlc=;
	b=KI9SLjROFcSirL2mTS5OuZAfOP+ehi28WMw/ahTS4caHqgegRKvYlaWKxelk0oDyR0nsl5
	/QixN5IwhA0UcIZAWfR1y/OvtYWnl7Ph+KBswIu2u7tJvUJmFOgV/00DoRlyspgzic/ovd
	xV36dvYGWz99ZyLasi42ArQFEIfukOw=
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
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
Subject: [RFC v2 21/21] selftests/mm: add madv_dontneed_partial test
Date: Thu, 26 Feb 2026 03:23:50 -0800
Message-ID: <20260226113233.3987674-22-usama.arif@linux.dev>
In-Reply-To: <20260226113233.3987674-1-usama.arif@linux.dev>
References: <20260226113233.3987674-1-usama.arif@linux.dev>
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
2.47.3


