Return-Path: <linuxppc-dev+bounces-18851-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AAC510AB83C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 02:15:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhkkg0gtrz2yjp;
	Fri, 27 Mar 2026 13:15:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::b9"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774577723;
	cv=none; b=g3o9B3+pcU8cbccerEZU24IBzfjEgIydlBrzAI76qYVf35piy/SSN/AKS+XPKeTwK0GyZWu3hGuzIPHvHR659D3otLzK4CT6KvOwfYStkH+1MPrgFtjaw0hHfBdd8mIMrtI0za9+Aj+YFEItEnuUq2g+rFnXakuO8RDUtpEYRM7llfvG34JPlO3Lv1cg7+TsnRyCZKRl6qhKz2tnx2q/8ESJRp/ejhOFcKXxov+/+uFbBBinBsNRhPqRcBuaySo+Rn6it725VnkA633fMtlUqUIBom2wKniIR34g6SPukQZMk9YJzPhJ4hx2kNVZJ2IvB1AiOje7c3xDqLCeujMUrA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774577723; c=relaxed/relaxed;
	bh=giSfT9S4Y3Fs6MBCHHOkpgsjb4flU8mTLfNnlsB/wxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B5U3w1Cs4XprZlXQ8JjXfDxPMJ8eT0y9AhqDaotvdph+zPKJ+pl8rKRrPJJv2vmJ9KDKRUGDJrIxl+yiHAKEzL1qfqjcycUQF+7UKbVtqFgE5BqRK97p9IDPCleUtsKKeka8fROPRd6YgU8vTbwarX1cb58agi71D9RDOx8Z269u2poLuKxE3TDIuaYL5mA+rL90mbrPPs0BSXx/RhpaXDqeCzJ8LX9WiB5FssdY1123lRyyen9Jy8KsY5E9XR3AQQedqr1bTWT1NNxq8rQGLtUnsOg6UoHYtarwRmJ0twmPXvHbhjUz5jaoGq+by8qAzQ37YchVDPi3TwUvREMCPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=c+UwEtgW; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::b9; helo=out-185.mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=c+UwEtgW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::b9; helo=out-185.mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhkkf2s0Vz2xR4
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 13:15:22 +1100 (AEDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774577702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=giSfT9S4Y3Fs6MBCHHOkpgsjb4flU8mTLfNnlsB/wxU=;
	b=c+UwEtgWwyc5ExZqiso+pcfyt+iKbZ1QmoTTRB8NhGDZKpUwyzQzLx5Oi6hXFvtdq5ago3
	ODRA0nas4eR1mjjEDHyY5MY9At3yhrqG1QJr6rpr5PRO3un578DMuu2R03YOspCxOxZ+jD
	EPix5NId6vnIBtCHcU6MJtVrfHvraLA=
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
Subject: [v3 08/24] mm: thp: handle split failure in follow_pmd_mask()
Date: Thu, 26 Mar 2026 19:08:50 -0700
Message-ID: <20260327021403.214713-9-usama.arif@linux.dev>
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

follow_pmd_mask() splits a huge PMD when FOLL_SPLIT_PMD is set, so GUP
can pin individual pages at PTE granularity.

If the split fails, the PMD is still huge and follow_page_pte() cannot
process it. Return ERR_PTR(-ENOMEM) on split failure, which causes the
GUP caller to get -ENOMEM. -ENOMEM is already returned in follow_pmd_mask
if pte_alloc_one fails (which is the reason why split_huge_pmd could
fail), hence this is a safe change.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 mm/gup.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index ad9ded39609cb..07c6b0483c322 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -928,8 +928,16 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 		return follow_page_pte(vma, address, pmd, flags);
 	}
 	if (pmd_trans_huge(pmdval) && (flags & FOLL_SPLIT_PMD)) {
+		int ret;
+
 		spin_unlock(ptl);
-		split_huge_pmd(vma, pmd, address);
+		/*
+		 * If split fails, the PMD is still huge and
+		 * we cannot proceed to follow_page_pte.
+		 */
+		ret = split_huge_pmd(vma, pmd, address);
+		if (ret)
+			return ERR_PTR(ret);
 		/* If pmd was left empty, stuff a page table in there quickly */
 		return pte_alloc(mm, pmd) ? ERR_PTR(-ENOMEM) :
 			follow_page_pte(vma, address, pmd, flags);
-- 
2.52.0


