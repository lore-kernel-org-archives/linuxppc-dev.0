Return-Path: <linuxppc-dev+bounces-18853-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4752E10A1E63
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 02:15:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhkkw2jTWz2yks;
	Fri, 27 Mar 2026 13:15:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.186
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774577736;
	cv=none; b=l+Ny/B/B/wwR7eyMQaVnnxX2LrkWe5SUtl3eMhlFiO6jg6LTjRgQNW+KUpnOIIicpQiXUQjnU9P0CY2uqsq1q3PCczuoZ0aMpKUoW1c3CKmZWyqLaLldJk612TBhO7VuGVcKpzZneH9yWZ+8s7sGSFCa1FUsTkzz1oQaTU3XseQaL8FVvqtzYWkz/AjJXw2ABE9/qeTTf7dNXMoPo3nvggcm9XhQeA4G1O27y/bfKcr9fWVi/xmgyNZcuNz/a+ypjAFB8fgXS/5lw7Uw4HVT72ibuE+YWYlUFxseGkLLFI+9I7b9hic/eqaoG+n/yqFAvQ0oAqkOb5nD1EqZaFbAgw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774577736; c=relaxed/relaxed;
	bh=5OmEvrhLT+taWsJJPLmmWMkCHrhCtqMj0PAwSXwnE8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOVCFKtPOGAneHd/9cHwG/yd4uNXwR27zq/LvdqwAgqpl8xAzIKu1jfkbA7OsP2r4IckJ8I4I3e+rO6078MQDYBIiO9rcobIQnB0dD7eDUNWeVGi5azwHZorZfEEzSfQVEIV0BidDAS/b95E0OVxx1Iqitpa2mGsBJetJ0Degaku7Kc6NX+0jTzbgiQfVex4G+80UA6GTY8XP/0MNMMZ76U/M56lSC4pk/uC8XNeXLRTvgWR3Mx/BrBlBjaCId5YYGScAh3G/s9JpJl/SeVTaR8LMTPuaGuUljY/wKDRY7M3wOYEQXQNyKrIOkRfUZFauk4gcRCuC+kwp43qTqTbtA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NTJcN7VC; dkim-atps=neutral; spf=pass (client-ip=95.215.58.186; helo=out-186.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NTJcN7VC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.186; helo=out-186.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhkkv57MRz2yjV
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 13:15:35 +1100 (AEDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774577717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5OmEvrhLT+taWsJJPLmmWMkCHrhCtqMj0PAwSXwnE8E=;
	b=NTJcN7VCFrbbYw8QV6DmQtslK9s9YNMNuM3BLeJdPk9ev+oaHPxhCblvvx8mF+jryQcQ/A
	wg7YpJu4lEnBQjk0VtVknCzS7c33o5merk9llHuNz4qXtYAm5HOn3BSwWdYd/7vyZ/q4XM
	aKuuq0sNgUbjhFWLQf7XvGWk7bo3EeE=
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
Subject: [v3 10/24] mm: thp: handle split failure in mremap move_page_tables()
Date: Thu, 26 Mar 2026 19:08:52 -0700
Message-ID: <20260327021403.214713-11-usama.arif@linux.dev>
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

move_page_tables() splits a huge PMD when the extent is smaller than
HPAGE_PMD_SIZE and the PMD can't be moved at PMD granularity.

If the split fails, the PMD stays huge and move_ptes() can't operate on
individual PTEs.

Break out of the loop on split failure, which causes mremap() to return
however much was moved so far (partial move).  This is consistent with
other allocation failures in the same loop (e.g., alloc_new_pmd(),
pte_alloc()).

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 mm/mremap.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index e9c8b1d05832b..2f70cb48f6061 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -855,7 +855,13 @@ unsigned long move_page_tables(struct pagetable_move_control *pmc)
 			if (extent == HPAGE_PMD_SIZE &&
 			    move_pgt_entry(pmc, HPAGE_PMD, old_pmd, new_pmd))
 				continue;
-			split_huge_pmd(pmc->old, old_pmd, pmc->old_addr);
+			/*
+			 * If split fails, the PMD stays huge and move_ptes
+			 * can't operate on it.  Break out so the caller
+			 * can handle the partial move.
+			 */
+			if (split_huge_pmd(pmc->old, old_pmd, pmc->old_addr))
+				break;
 		} else if (IS_ENABLED(CONFIG_HAVE_MOVE_PMD) &&
 			   extent == PMD_SIZE) {
 			/*
-- 
2.52.0


