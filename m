Return-Path: <linuxppc-dev+bounces-18852-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 227CD10A1E63
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 02:15:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhkkq60TSz2xR4;
	Fri, 27 Mar 2026 13:15:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.170
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774577731;
	cv=none; b=OzhyyU0+81MC/JGLRHAauOv8gqTlb7U9jK+FjnhCORwF8EPCAsWtky3cTbuHZK/duKz+dVRcJPlv6NJ2KJcxCXucY8eviFJV/eqb8ZaxpAeiwp1YPkvGpJVGpFbua0NDiKZ9v3uzO78r/ohWOe1oBvjDfwPTNo4RnBTlPxtjMlJWit6iyFS4Zjn6Bhcm1A03AlTGieYwvXqGQhshUqunwQbLmyo1G9Wcses9adKjDfD/fv+bANACu2bFxl+365VKTZI4M4qcnHyZ+TZKRgQ2gZraXBSzsouS85gdrcQ2QuYAxs8M8ZoEtOP4W/rwfoFZW05gzsySpM/BVYkePImOag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774577731; c=relaxed/relaxed;
	bh=dfNWz2MwM4ZY6bFGmoYrNTnpJRQZnNwj/uOrRkiYL5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ULWPVwLOTevObEflNAqpkSWaBHsqeNXVAXWkzhjam+7FAsvN00OVrFKWeeQQjqtDOFetowt3hwbzxv5SYUbT/QHAAUznKYUIemnLcYahJ2Y5NyNYzqCKuOroL4UrOq4DfMV+Z5miqs9Enc94kuPzGJgdnmv8fHGkr+HYYBXGP+woQLjBqx5nbnB+gLVOY5h3PqkTSHIj5uXBd0UrCs9ao20ZAXg9tmAK3K9cbHgIzyExlx1ykxUuB3aeOFxxiVWeOXudqFwSfhrFI9uBK7J2AKfV1byGZ4gA8mkHv8be+dTLwmGSe+fMDJAcKIwUZSMohcBR6j90rwJ5HQGHPnV5Ig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qUprQn+Y; dkim-atps=neutral; spf=pass (client-ip=95.215.58.170; helo=out-170.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qUprQn+Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.170; helo=out-170.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhkkp5jThz2yjV
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 13:15:30 +1100 (AEDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774577711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dfNWz2MwM4ZY6bFGmoYrNTnpJRQZnNwj/uOrRkiYL5M=;
	b=qUprQn+YADvN/9XX6sWYfNa/kg5jNuE3cirjiQ/YhUk5tRCUEKizV7YGDnhu+O6mL2/RmH
	oTF5aOueObHp18z9I+INhJ7C79JF930GoJirPSOE8DqOuuEiuDjMjZKFEcq6mi9dt+yWRn
	geRfame3sIEEpbw6/P4+nyJYGxERCHk=
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
Subject: [v3 09/24] mm: handle walk_page_range() failure from THP split
Date: Thu, 26 Mar 2026 19:08:51 -0700
Message-ID: <20260327021403.214713-10-usama.arif@linux.dev>
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

walk_pmd_range() splits a huge PMD when a page table walker with
pte_entry or install_pte callbacks needs PTE-level granularity. If
the split fails due to memory allocation failure in pte_alloc_one(),
walk_pte_range() would encounter a huge PMD instead of a PTE page
table.

Break out of the loop on split failure and return -ENOMEM to the
walker's caller. Callers that reach this path (those with pte_entry
or install_pte set) such as mincore, hmm_range_fault and
queue_pages_range already handle negative return values from
walk_page_range(). Similar approach is taken when __pte_alloc()
fails in walk_pmd_range().

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 mm/pagewalk.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 3ae2586ff45b4..c5850de71b8cb 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -165,9 +165,11 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 				continue;
 		}
 
-		if (walk->vma)
-			split_huge_pmd(walk->vma, pmd, addr);
-		else if (pmd_leaf(*pmd) || !pmd_present(*pmd))
+		if (walk->vma) {
+			err = split_huge_pmd(walk->vma, pmd, addr);
+			if (err)
+				break;
+		} else if (pmd_leaf(*pmd) || !pmd_present(*pmd))
 			continue; /* Nothing to do. */
 
 		err = walk_pte_range(pmd, addr, next, walk);
-- 
2.52.0


