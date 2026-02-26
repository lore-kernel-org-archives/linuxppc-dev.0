Return-Path: <linuxppc-dev+bounces-17261-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF91FC5930
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Feb 2026 11:35:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fM8X22Lvgz3bmR;
	Thu, 26 Feb 2026 22:35:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.171
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772105714;
	cv=none; b=SafIrUVmhWn5vKy3gInKwwORZrfiKzGWLiVJZYJGA68ZpjDt4I9GC50NkQAlGaGPZ8csHMeqGDsZ8myN9hlfx7yaCz+vqjWqwpdToIKm0SfRiTqBmuDW1oVuktzBm5htAB84o1yusLJuC68X/AeCYESbdEQUPmFea5l0PTeMy67zViLuQNVDP+HVEQs8dUfoH4QtDxmmu2yUbEPZHjj9+C1PHuHH7NnKsIjCNOJRuoyB1zgEdLE71JBS+0cYplpUJ+8UREnfTnv7sqnOFRNtw2srQxarNGh65gslaxUE2SDQRvGEFul2plt02Yd26USFMZz28Awm47oyzrRP2fA9aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772105714; c=relaxed/relaxed;
	bh=8OsjUNu05V/Xcz8HI7pnG5Up/ePNSaNnSj1ALtPKgps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHCax6Bh9IthYD5dGrU4znokLoXv5oq9iiqd8iMWfposTN5vZuM6S50aoYTT919imshqiNuIllhcz7eAdNX552ZfNLWtx34YKUlutnnxVqwD8GkEz5SFqw3nok8QQmMfDMW0q8NDwmB8aM/CzJgomsAB3orIT4Mw0f97QzwNCvx/yK48XLr6Okgrn52B1hyS0oXV5FPzwBgfQ539y1OXDAm4SVd4CGqQ3aIojyKKvTaXQX7l7U7DoZkYmgASml5bnJ1ym4JKeZkpCu5V2koRYZ/Ks9NkO2x5IeHpehyCa8ndQe+B6EtdoEJhrJzQemEcfFHYy+BmGSW7rv4NfHZnCg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QzYEVMog; dkim-atps=neutral; spf=pass (client-ip=91.218.175.171; helo=out-171.mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QzYEVMog;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.171; helo=out-171.mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fM8X14v39z3bkL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2026 22:35:13 +1100 (AEDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772105694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8OsjUNu05V/Xcz8HI7pnG5Up/ePNSaNnSj1ALtPKgps=;
	b=QzYEVMogdec0mY0J3RwU6Gr0HY5yw0g0PC/NnZW/DkMBCuL1u6KkUPmfl0LnrwBZt3mQvH
	6feN36V2Wav1NYWbEYKn+KdkhTLakwltwaJjj6dePky67MgNDAo4NhXA6gniUjonuoiq0T
	kN0P5eVVcfWnMjq8z+u3t6YjpBzNfhE=
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
Subject: [RFC v2 18/21] selftests/mm: add partial_mprotect test for change_pmd_range
Date: Thu, 26 Feb 2026 03:23:47 -0800
Message-ID: <20260226113233.3987674-19-usama.arif@linux.dev>
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
2.47.3


