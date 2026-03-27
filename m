Return-Path: <linuxppc-dev+bounces-18859-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D121310AB83C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 02:16:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhklX5KpNz2yqT;
	Fri, 27 Mar 2026 13:16:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::b2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774577768;
	cv=none; b=Ai8TYjCjGlU2Z3yFo8/93Oi1ntHX3lk3vB81G5OGAbWtmFvUT52ut9OOefD9EBaikzwLQkNrbxTo9l8m7bv2VtDVPHq3/1eG3ctDsZIaKGO/sFTENsu6Omw9gMGoSED07Zn8ufY5i1ie9DKNVzNvdwltTOXmCtGNElYPmZnASlHFv69t+pDP+QMGgpLi5Sd19vlJ4qOEk6qHdy4u0Sw8aGV4KF6rJNvpzoSKEveahGibzgJWZ+1hg1V0fFzCIvBcYTTO0elYOU0ZCsswyVqXpC4JRqJXXojMgeRj7zGA465YBcQc8DwbSIGfYtxKvno15cIdhWOGMlqCGf1daBQ5uA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774577768; c=relaxed/relaxed;
	bh=Y5PgiQrcwbn9XAgL4cRYPHYRVIr8zaspEnc9S8fZNtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjlrV0spKD74t1f2IfmnqtE4W5viQBRxw2P8dLxUES4Ji+YjlIvJLJmyOuImqInALUuDUmNi3Hck610vV7Ox1KgWhvMmMU5cORp0o0KRnrYNi+NVX65ihzp5LbqNXdSwR9tOhfHS5RskDziT03ZY81RwF13lCI4wKEmagscbQAGGVAWhdaDtW9+O8WJjig8UYk61eX2dNHQXFewzZPYuC/H9BVH93zsCcnzjIdyY2I45zZnW4c3k9YalWZX1zgiw59EwjZBIBvbzy189wUKQTpgzcXGmBwyv+IEIzG6d+9Q1qHFkLHA6fdpS7kvBZ8OOW7EcnTREIk8uIAbem9obYQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PBqsuNks; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::b2; helo=out-178.mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PBqsuNks;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::b2; helo=out-178.mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhklX0PgBz2xmX
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 13:16:07 +1100 (AEDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774577748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y5PgiQrcwbn9XAgL4cRYPHYRVIr8zaspEnc9S8fZNtw=;
	b=PBqsuNksqiYxLcyifzHiiquL6Zzzi+Q6QhZKvMqsl6Ywk8e+CwDNj9TY+ZBrYzU5TX4YZX
	tN7zZsn84kggt2lWPGZqKW8iUu8t1aNBnigvnGagmSkB+xzT/lcMTAqVdArQiFTX42gjln
	p/GMbq4RVKzlqVsGNHcXNmutrl2WTFQ=
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
Subject: [v3 16/24] mm: huge_mm: Make sure all split_huge_pmd calls are checked
Date: Thu, 26 Mar 2026 19:08:58 -0700
Message-ID: <20260327021403.214713-17-usama.arif@linux.dev>
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

Mark __split_huge_pmd(), split_huge_pmd() and split_huge_pmd_address()
with __must_check so the compiler warns if any caller ignores the return
value. Not checking return value and operating on the basis that the pmd
is split could result in a kernel bug. The possibility of an order-0
allocation failing for page table allocation is very low, but it should
be handled correctly.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 include/linux/huge_mm.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 224965fce4e66..c4d0badc4ce27 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -418,7 +418,7 @@ static inline int split_huge_page(struct page *page)
 extern struct list_lru deferred_split_lru;
 void deferred_split_folio(struct folio *folio, bool partially_mapped);
 
-int __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
+int __must_check __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long address, bool freeze);
 
 /**
@@ -447,7 +447,7 @@ static inline bool pmd_is_huge(pmd_t pmd)
 	return false;
 }
 
-static inline int split_huge_pmd(struct vm_area_struct *vma,
+static inline int __must_check split_huge_pmd(struct vm_area_struct *vma,
 					     pmd_t *pmd, unsigned long address)
 {
 	if (pmd_is_huge(*pmd))
@@ -455,7 +455,7 @@ static inline int split_huge_pmd(struct vm_area_struct *vma,
 	return 0;
 }
 
-int split_huge_pmd_address(struct vm_area_struct *vma, unsigned long address,
+int __must_check split_huge_pmd_address(struct vm_area_struct *vma, unsigned long address,
 		bool freeze);
 
 void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
-- 
2.52.0


