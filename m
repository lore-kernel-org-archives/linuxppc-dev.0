Return-Path: <linuxppc-dev+bounces-18866-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A256010A62D1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 02:17:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhkmC3D6yz2yrK;
	Fri, 27 Mar 2026 13:16:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.183
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774577803;
	cv=none; b=Zv+DE3cPnTDlGvFLHdE/l11lQNwAvop1fFGVGFO4zpBnibP9d5YE/NQMvSbUkKldNKJ3+56XeMBDPk2xNh1oERtBJLoRNXACMK/mYKWqpiPKhaEOn7qkzOfHSdcWlubB4q0nWrGJNPLfLmGPtffgq1rte1vfQmLiVOR+zj2rtNrTqN65uWweQebh3k545pIRmukgkgZZ9jpiZF2x4riwqH4d/PPMW5PFy6Sqz9WcAq79DJMnAC+zePVqaU6rnT2mJMmqU4KIrYEZKAFOStFVuRcoshKyRlNZ6zuOpJ1CUdnIvA2bNnX7JRLwoK/rB4ozJoBL1nO5+HLetwfIlO9GUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774577803; c=relaxed/relaxed;
	bh=lE7v5lDGM/JWEaWuAACCuFGk8rRw4V1pzGfx+4tEAgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LF/AYkczjBTpUS54NZZ7xUwi33hxIsv+JZxP5Wptfw91zJkhAfIYErBQF2ipnCZDz/VbZbutBRj8lDnc1Zb+YYGm96i5qw65y2o0OTMne+HG+LQY2kvnG8Fc8JwSBnW48ZLj7wJHdbUVvYG2ttJ2BVkZlrbwjJmL8ByBNVfkELGH2xbmtfowTOCa5U6qHL9pGnNCENaJ4MMCcGKiAdWd4OFr1rNawqlZQA+UKRpz3BS522+QUoOMypoo43dyUUrH7l83h4UKp4+uI/ProEHE4JiQvhJV69CYclWeV+bheYP39XKdFx9JDP1KHhB2WxaSzSfeihJy6PZHDL+lRpylcw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XE9dZB9f; dkim-atps=neutral; spf=pass (client-ip=95.215.58.183; helo=out-183.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XE9dZB9f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.183; helo=out-183.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhkmB4tT7z2yqt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 13:16:42 +1100 (AEDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774577783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lE7v5lDGM/JWEaWuAACCuFGk8rRw4V1pzGfx+4tEAgA=;
	b=XE9dZB9fLZ/OArOngsedrObo//4dofSQ7egtq16n4UZmnM75/spWLYNbGNXdNBcCTBB+Fo
	cnGQD1gdIQDl3tgpRirkYMGiJR0/XwR2Cvg+8mZxq+a73pFDK7w6i+bpfpGytLEzfpmE/g
	n0aN0IQDsz7hR+A1FcsvHnMT47HCL70=
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
Subject: [v3 23/24] selftests/mm: add partial_mremap test for move_page_tables
Date: Thu, 26 Mar 2026 19:09:05 -0700
Message-ID: <20260327021403.214713-24-usama.arif@linux.dev>
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

Add test for partial mremap on THP which exercises move_page_tables().
This verifies that partial mremap correctly splits the PMD, moves
only the requested page, and preserves data integrity in both the
moved region and the original mapping.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 .../testing/selftests/mm/thp_pmd_split_test.c | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/testing/selftests/mm/thp_pmd_split_test.c b/tools/testing/selftests/mm/thp_pmd_split_test.c
index 3c9f05457efec..1f29296759a5b 100644
--- a/tools/testing/selftests/mm/thp_pmd_split_test.c
+++ b/tools/testing/selftests/mm/thp_pmd_split_test.c
@@ -203,4 +203,54 @@ TEST_F(thp_pmd_split, partial_mlock)
 		self->split_pmd_failed_before);
 }
 
+/*
+ * Partial mremap (move_page_tables)
+ *
+ * Tests that partial mremap of a THP correctly splits the PMD and
+ * moves only the requested portion. This exercises move_page_tables()
+ * which now handles split failures.
+ */
+TEST_F(thp_pmd_split, partial_mremap)
+{
+	void *new_addr;
+	unsigned long *ptr = (unsigned long *)self->aligned;
+	unsigned long *new_ptr;
+	unsigned long pattern = 0xABCDUL;
+	int ret;
+
+	ret = allocate_thp(self->aligned, self->pmdsize);
+	if (ret)
+		SKIP(return, "Failed to allocate THP");
+
+	/* Write pattern to the page we'll move */
+	ptr[self->pagesize / sizeof(unsigned long)] = pattern;
+
+	/* Also write to first and last page to verify they stay intact */
+	ptr[0] = 0x1234UL;
+	ptr[(self->pmdsize - self->pagesize) / sizeof(unsigned long)] = 0x4567UL;
+
+	/* Partial mremap - move one base page from the THP */
+	new_addr = mremap((char *)self->aligned + self->pagesize, self->pagesize,
+			  self->pagesize, MREMAP_MAYMOVE);
+	if (new_addr == MAP_FAILED) {
+		if (errno == ENOMEM)
+			SKIP(return, "mremap failed with ENOMEM");
+		ASSERT_NE(new_addr, MAP_FAILED);
+	}
+
+	/* Verify data was moved correctly */
+	new_ptr = (unsigned long *)new_addr;
+	ASSERT_EQ(new_ptr[0], pattern);
+
+	/* Verify surrounding data is intact */
+	ASSERT_EQ(ptr[0], 0x1234UL);
+	ASSERT_EQ(ptr[(self->pmdsize - self->pagesize) / sizeof(unsigned long)], 0x4567UL);
+
+	/* Cleanup the moved page */
+	munmap(new_addr, self->pagesize);
+
+	log_and_check_pmd_split(_metadata, self->split_pmd_before,
+		self->split_pmd_failed_before);
+}
+
 TEST_HARNESS_MAIN
-- 
2.52.0


