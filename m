Return-Path: <linuxppc-dev+bounces-18855-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9EBC10A62E8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 02:16:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhkl82BSYz2ynn;
	Fri, 27 Mar 2026 13:15:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::b8"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774577748;
	cv=none; b=ZhQREieipuvmtL/pCtp+6b4bveif8rfJgeZo921BS9b08GPQmOgZsDFi5Ep4QIDjlvE6GbodIAuH2SL03xqWLH/QWZLtHfebFbKGq+lJVxFeVTv+9g3cpwvLInT0AvFwwt1hZV0Vb+ejp2hR/pnILk6ZAz2DecJXs5YjbFW1kgsZo19jTacfz4TCh9pOglNIoU/ecmtrEcxilPbSsubepYwDvabG+rypVHVPJm0bfEzBNZ24znipUtgIVbOrKJoeqgAYg+0txa3aR7UXETyAdNBBftNgskss8CfPHs37X92tZ5qeOjmk63g4vhZGq03N5g001pjtkOROqdvND/mdQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774577748; c=relaxed/relaxed;
	bh=WTevK4s9bqcsyF5dGhWo4MENNp9vZlr+uy9xAQG2jfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jdBY8Pc4Kv+BQNWhAF8ow+nW3GLgx4No8CYFq3Vissa2iKgmCy68Hb0218i7LMUzhZlwA/Ojbt4pjUcGbojCkzpuwuG4Qebb8Clda9YiqrLYiX5VYwT0etHmqqIgL+9e23c+9wC829RPA8Q3ZVRyf2XUZ+Az0ZAyJVLAd8FQbr+Vik++GpztznsToj50XrZIdli2buT5GM7ABK1le6LvDF5UPzNuFBBaq+ZT7bivlADWSr1Ew+7xNcnmbhhMFJY8ulMw6VhfKLH0TKYTmGqky0XdkohFA48KlxQBueHWYTuXJgrQuwXRFgv9mgL9TUCk1fPqpfE9YcuXE8+IbT0TBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=eUmbqBO7; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::b8; helo=out-184.mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=eUmbqBO7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::b8; helo=out-184.mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhkl74Q0Rz2yjV
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 13:15:47 +1100 (AEDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774577728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WTevK4s9bqcsyF5dGhWo4MENNp9vZlr+uy9xAQG2jfo=;
	b=eUmbqBO72zX2904RPuTC7NJzAIMHlr5gcD4RVYygo1GU1dDyzany1Q2T9JuiXvkcB8DQd9
	aunpkimHYmudKZq6kRshELjRaFFsIkn5wCDv9o4AVpLZf/bmSb/rct1ebqgCoY+qovcSBc
	l6ygYvG/M7DXmErg92nyDDfRdBDaJ3A=
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
Subject: [v3 12/24] mm: thp: handle split failure in device migration
Date: Thu, 26 Mar 2026 19:08:54 -0700
Message-ID: <20260327021403.214713-13-usama.arif@linux.dev>
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

Device memory migration has two call sites that split huge PMDs:

migrate_vma_split_unmapped_folio():
  Called from migrate_vma_pages() when migrating a PMD-mapped THP to a
  destination that doesn't support compound pages.  It splits the PMD
  then splits the folio via folio_split_unmapped().

  If the PMD split fails, folio_split_unmapped() would operate on an
  unsplit folio with inconsistent page table state.  Propagate -ENOMEM
  to skip this page's migration. This is safe as folio_split_unmapped
  failure would be propagated in a similar way.

migrate_vma_insert_page():
  Called from migrate_vma_pages() when inserting a page into a VMA
  during migration back from device memory.  If a huge zero PMD exists
  at the target address, it must be split before PTE insertion.

  If the split fails, the subsequent pte_alloc() and set_pte_at() would
  operate on a PMD slot still occupied by the huge zero entry.  Use
  goto abort, consistent with other allocation failures in this function.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 mm/migrate_device.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 2912eba575d5e..00003fbe803df 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -919,7 +919,19 @@ static int migrate_vma_split_unmapped_folio(struct migrate_vma *migrate,
 	 * drops a reference at the end.
 	 */
 	folio_get(folio);
-	split_huge_pmd_address(migrate->vma, addr, true);
+	/*
+	 * If PMD split fails, folio_split_unmapped would operate on an
+	 * unsplit folio with inconsistent page table state.
+	 */
+	ret = split_huge_pmd_address(migrate->vma, addr, true);
+	if (ret) {
+		/*
+		 * folio_get above was not consumed by split_huge_pmd_address.
+		 * put back that reference.
+		 */
+		folio_put(folio);
+		return ret;
+	}
 	ret = folio_split_unmapped(folio, 0);
 	if (ret)
 		return ret;
@@ -1015,7 +1027,13 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 		if (pmd_trans_huge(*pmdp)) {
 			if (!is_huge_zero_pmd(*pmdp))
 				goto abort;
-			split_huge_pmd(vma, pmdp, addr);
+			/*
+			 * If split fails, the huge zero PMD remains and
+			 * pte_alloc/PTE insertion that follows would be
+			 * incorrect.
+			 */
+			if (split_huge_pmd(vma, pmdp, addr))
+				goto abort;
 		} else if (pmd_leaf(*pmdp))
 			goto abort;
 	}
-- 
2.52.0


