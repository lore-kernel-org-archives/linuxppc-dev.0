Return-Path: <linuxppc-dev+bounces-18865-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E11A010A1E63
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 02:17:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhkm44n0Hz2yr8;
	Fri, 27 Mar 2026 13:16:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.178
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774577796;
	cv=none; b=BSUIuFE1t0HaAq19LZVCBQR1DN4hmqBAe0Pi3/PQctscjdOFmnYCJvN+Y+TVhJSqJo7DRGWj/VsvpWYin2iTO6mSYu5nYr63zGVgCzB9Jnu18XqHSCEexEPtwz8azaplg+dFDvmGhkEPEQvn1CIMUM9a+04bSSiJYmtK+XkZl2elYx3g7MGhOwVxYBBIGCN8VpdopEw4WFVxrMGCPBfk6m3fTd9MiD0BRnJZNKPKpwhNSH/F+E4TIEVpNcXYtuTanFriKgqvNg+3GU2mAZE1gahah9hcRNHOao4PNc4fGyuET07XlZYyoxuhRuQGd9NcdemU4NG8lk8JZvQ8mQjQ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774577796; c=relaxed/relaxed;
	bh=+u28b+kGwOwWeo4iPTn5u1dAfo4aLeElFP2cFybYpB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=afOUEW7yR3AQZ7yvrGqojalLrfLT0QHzQ7z+ydBZrwaw3E4Mdd7Tvmk7SFxGsGxUjO0cCROK73oEKVmMU8Zd0Hnagu9q2hdiAPiNkhQfRCO4CkiGchsgkgHL+UpGCbuABXR+P1oL4kC8l2UB3WRionW+WWUBPpoqXoWewOY4G7y2nCQXbR50HsO7CQZYclr8Rozj4OqXKW3CRuGkl7Cm1OhetRgfDMVNF0Yzs6GBnvfWwwJCe+2bfcKp8wtwBRB/iLj9rDokeWJuoD3SXHpMlUAlvXALijWkNCll6sA4kIFpfhn9meDJV4s9WzV+XGkDQZlhZNlUaiLTU4sBS8Rk7w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nFrkNXxv; dkim-atps=neutral; spf=pass (client-ip=95.215.58.178; helo=out-178.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nFrkNXxv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.178; helo=out-178.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhkm370Hlz2yqt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 13:16:35 +1100 (AEDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774577777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+u28b+kGwOwWeo4iPTn5u1dAfo4aLeElFP2cFybYpB4=;
	b=nFrkNXxvndBSqppjWyV9ntkfxnDZ0DtuCQnUOY5sup4Cn3dvGfyt7wUKnT4xAdfcGQUu19
	prxL9x0QtRJ7eGgfh7QoH8qmgtTOcQ/tFTBltl+w+k5V6XIa5MkQdNn/z6ZBfUXndUQ60X
	oH4UtoxyWYliZvg4O6754ph/DAJrixE=
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
Subject: [v3 22/24] selftests/mm: add partial_mlock test
Date: Thu, 26 Mar 2026 19:09:04 -0700
Message-ID: <20260327021403.214713-23-usama.arif@linux.dev>
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

Add test for partial mlock on THP which exercises walk_page_range()
with a subset of the THP. This should trigger a PMD split since
mlock operates at page granularity.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 .../testing/selftests/mm/thp_pmd_split_test.c | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/mm/thp_pmd_split_test.c b/tools/testing/selftests/mm/thp_pmd_split_test.c
index 4944a5a516da9..3c9f05457efec 100644
--- a/tools/testing/selftests/mm/thp_pmd_split_test.c
+++ b/tools/testing/selftests/mm/thp_pmd_split_test.c
@@ -177,4 +177,30 @@ TEST_F(thp_pmd_split, partial_mprotect)
 		self->split_pmd_failed_before);
 }
 
+/*
+ * Partial mlock triggering split (walk_page_range)
+ *
+ * Tests mlock on a partial THP region which should trigger a PMD split.
+ */
+TEST_F(thp_pmd_split, partial_mlock)
+{
+	int ret;
+
+	ret = allocate_thp(self->aligned, self->pmdsize);
+	if (ret)
+		SKIP(return, "Failed to allocate THP");
+
+	/* Partial mlock - should trigger PMD split */
+	ret = mlock((char *)self->aligned + self->pagesize, self->pagesize);
+	if (ret && errno == ENOMEM)
+		SKIP(return, "mlock failed with ENOMEM (resource limit)");
+	ASSERT_EQ(ret, 0);
+
+	/* Cleanup */
+	munlock((char *)self->aligned + self->pagesize, self->pagesize);
+
+	log_and_check_pmd_split(_metadata, self->split_pmd_before,
+		self->split_pmd_failed_before);
+}
+
 TEST_HARNESS_MAIN
-- 
2.52.0


