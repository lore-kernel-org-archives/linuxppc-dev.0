Return-Path: <linuxppc-dev+bounces-18864-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A61110A62D1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 02:17:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhkm01GGfz2yr6;
	Fri, 27 Mar 2026 13:16:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.189
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774577792;
	cv=none; b=Hb31EfnffRTVwJGUPKl/Oi/CEdW/RKtzn7i3lOw4d5NP8GPA3wcRXD3+F7j8wYxYsSQ0wK3+Yxwtp9F8y6K6wR6mQzMqcID2iDA9+32DDlHUWL44+i5fu++qvwPaOlKByfNCrsKpvV0yGAFQVAc+0jeMVrX88ujvqJmczXQnQqPa+b7h0F/N+A9nn/eALKB82vXCAloK/vLfBmMMk5v+6Dm+R53MJbLIRU+ecAWLBKXUlRWP1DAY0y7kWQjzS6TqhCHtDQrO4tJiHK1bc/vOXE+1DkHO/H2KYX0rDlU8S0iJuOrVHh8HM9clwuaWBq4yNmaVpZBArDhhAPPYSKofBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774577792; c=relaxed/relaxed;
	bh=KBHgpp/Hlt3gblMxOihtIUK/6fHGYOfso38xhE/8i5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H//3FJMPvJD6t1kvwRy7t55upX4rbvsmtfgvqjKRA+zWulSvqTaPmG37AeDim5VJjP54mCzvaNGm0eWhDJ7ImsYiiwR2YMBK3ohwCa7LwcEgWDUAWgL6TJG18PBVApYReLz+UVGf0D5l4WblXGAm6X+DCzRaGLN/7+HsCrsExtLW+gGp8blViqCKTBFiEZ0qKGSefjslE2f4X/ixe8BCT63+jjUy7cENTU7n0Xz7Gb80op95AQ/UsJYt6rEaQXEalDVnGeN9h2LC+1Go0tm3rZQyDjr+hhbgdUyKxSKJ+TWU963Di2tj7whdxiFaZpd2LPIbbBEgeVf/PjihH9SGHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YkBnJlAA; dkim-atps=neutral; spf=pass (client-ip=91.218.175.189; helo=out-189.mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YkBnJlAA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.189; helo=out-189.mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhklz3dHdz2yqt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 13:16:31 +1100 (AEDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774577772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KBHgpp/Hlt3gblMxOihtIUK/6fHGYOfso38xhE/8i5Y=;
	b=YkBnJlAAFSpKbHZ97+87mwwuiOpaKGfMki0IODGcWo+ltRqHD5dxWBr38RHva/Za8up5uN
	sjKP0IWJ4LKydgafIE8LafBBavHbtcDNVR0+2IRtgtbgOEykPv1ek68+Pcb9SQy5kozeBm
	TXn8jzFa4saniUkUmgk+kYIpggBjy8U=
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
Subject: [v3 21/24] selftests/mm: add partial_mprotect test for change_pmd_range
Date: Thu, 26 Mar 2026 19:09:03 -0700
Message-ID: <20260327021403.214713-22-usama.arif@linux.dev>
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

Add test for partial mprotect on THP which exercises change_pmd_range().
This verifies that partial mprotect correctly splits the PMD, applies
protection only to the requested portion, and leaves the rest of the
mapping writable.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 .../testing/selftests/mm/thp_pmd_split_test.c | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/mm/thp_pmd_split_test.c b/tools/testing/selftests/mm/thp_pmd_split_test.c
index 0f54ac04760d5..4944a5a516da9 100644
--- a/tools/testing/selftests/mm/thp_pmd_split_test.c
+++ b/tools/testing/selftests/mm/thp_pmd_split_test.c
@@ -146,4 +146,35 @@ TEST_F(thp_pmd_split, partial_munmap)
 		self->split_pmd_failed_before);
 }
 
+/*
+ * Partial mprotect on THP (change_pmd_range)
+ *
+ * Tests that partial mprotect of a THP correctly splits the PMD and
+ * applies protection only to the requested portion. This exercises
+ * the mprotect path which now handles split failures.
+ */
+TEST_F(thp_pmd_split, partial_mprotect)
+{
+	volatile unsigned char *ptr = (volatile unsigned char *)self->aligned;
+	int ret;
+
+	ret = allocate_thp(self->aligned, self->pmdsize);
+	if (ret)
+		SKIP(return, "Failed to allocate THP");
+
+	/* Partial mprotect - make middle page read-only */
+	ret = mprotect((char *)self->aligned + self->pagesize, self->pagesize, PROT_READ);
+	ASSERT_EQ(ret, 0);
+
+	/* Verify we can still write to non-protected pages */
+	ptr[0] = 0xDD;
+	ptr[self->pmdsize - 1] = 0xEE;
+
+	ASSERT_EQ(ptr[0], (unsigned char)0xDD);
+	ASSERT_EQ(ptr[self->pmdsize - 1], (unsigned char)0xEE);
+
+	log_and_check_pmd_split(_metadata, self->split_pmd_before,
+		self->split_pmd_failed_before);
+}
+
 TEST_HARNESS_MAIN
-- 
2.52.0


