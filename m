Return-Path: <linuxppc-dev+bounces-17262-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8544FC5933
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Feb 2026 11:35:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fM8X71pqCz3bn7;
	Thu, 26 Feb 2026 22:35:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.174
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772105719;
	cv=none; b=RA3dfjJNXGM2o+O9HN+4VX/LqJiN5g5cOkKbE0GvfF042vZ0OvqGO0ciDNjZUiQ3MN+aBptHSGSmJW8yhvkcYEQExbymQh8DypiXxQfe/lVvM3Nj5KGeeS6K8EMdqLptr0E0PqA3eVfxCkgkqgckKCMW0uqKpFXPNp1Rgk4YVya4EzQckVQjRs/j2Svv8QKMa55c0uQsddMl4dY9sTFKECenKcz4qJwn31U347RHDnR0RhuY9Z3dpfJXoeFvLhVd0JW54JS9+/RXmS9fje9CK642mCvSOJLXmONauIt1Qra88PINHhAnK2VDoJQPL5csBj/32gSGaw82LtALba1nCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772105719; c=relaxed/relaxed;
	bh=lZL1HqFM5fa36Uz0JOdbh5qV5iDmtrECipMEqRvI7/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZRPAVNhIPuJLIu/M6cgGbQVpsOTt5LrHwFlKPJ+KglUFmzE94O/UQWGq1BWD9gmzuYh++t6RgsVpXw7ZcaOqFzcBTiUfZACcIOP8c/oyfJLORNCeVfhYhMozavbBYlx1A5msYZVCkwO9Xwy/a1M+E5sy0uu3YuJAQJRuQgrKTs6EV0Gl+kqeuVTsdnUrfC0FGuutAAF6UbJWgt926AdXWjiOP779EyaAVuhA5fTnlqegIZjYMOrrYuR5W2wsR8CAh9akqHXGVrydqJSklowW6wuee0DlDpXVtWUfbT85zB1V2uB7S8+oAarfWQqryRbZfodaxpxMBxFV3nOMtY+gDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bQvZ3Bk9; dkim-atps=neutral; spf=pass (client-ip=95.215.58.174; helo=out-174.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bQvZ3Bk9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.174; helo=out-174.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fM8X63YG3z3bkL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2026 22:35:18 +1100 (AEDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772105700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lZL1HqFM5fa36Uz0JOdbh5qV5iDmtrECipMEqRvI7/A=;
	b=bQvZ3Bk9zABmR2QjQC7aS7RsAH/+WnY/o7rjw0sMM8KWnVjY1pM/mPaqV2KVkr7y1+1yqV
	D95OAuC1N714g5HBViSG7olcJX86gP0ns8b9QPlaHVVrOOimKpItd/woUJYp5+xK0IrmW4
	ebj/YYCu6frGA2CLRuuQD3QUhJIoTZs=
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
Subject: [RFC v2 19/21] selftests/mm: add partial_mlock test
Date: Thu, 26 Feb 2026 03:23:48 -0800
Message-ID: <20260226113233.3987674-20-usama.arif@linux.dev>
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
2.47.3


