Return-Path: <linuxppc-dev+bounces-17246-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E6AFC5933
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Feb 2026 11:33:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fM8VD0Jkcz3bn7;
	Thu, 26 Feb 2026 22:33:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.174
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772105619;
	cv=none; b=CAMNuhj1dNhrdgLZTzOK9bzeY8HEhKP/tgeflVnqTGpdk1UrM2Yn4J9mFby1HaS2Mccx6girJwWb+IRkQmh134/mQAbKr5TXNBIM+mMDW09vBuwAZpzC142RV+eZ4QnZiGoNw2NAVzpAGMDacyIXBtJVrawBzsKV9yOJW+U3uN4fSwIsJFaQx14X5ov7cOoKlxl+EJTYPfp9T+RxCIVJ73MoWHOC4grzYdCB1VIsik7+mGwKShxjG9//nAppUTP1q3mv6ox5VrqZoCDhDjS/JQ5IysHoZABFZ1tIgXJZ1zeNxa5oRh62BhWpZk3LI4sUHanF7+Dynv/eZ/gc6crcWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772105619; c=relaxed/relaxed;
	bh=oQlqNAg7YmGMtU2zToh4UykdOV+ZpXIvjbeNwJDuSLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ht1l+kRqJ6+M82qRB0p+ZSUVX3yxYLbipoVln9Tbd7EWGvJcngV8Fy4AVOypMgnycZhM9BnELDV2QjqGZa6ze86EnB67Rz0Ooblf0oLhCqq89289B9WWYRuVPBPfpgQqNvz9sLHVq/KgIuwKN8oDP+dNRZePI6NzmWoXgLRY7yl4z92dXKJOktCLG/kTN4rQWzbPHS8uUBj9QKX8B81GiZv9xPLtGTwQS4KWzqWW17j26AgjPlMa7DeWxusSHeBRnEJVfjiBlQAC6DwPVNe5BxC86oJjPsFaqEr1eNNHPZftOQMwC318pMX88Fe/cILOOnKC6UErvN2e0xBQPo1e+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GEvwlQop; dkim-atps=neutral; spf=pass (client-ip=95.215.58.174; helo=out-174.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GEvwlQop;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.174; helo=out-174.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fM8VC2ccCz2xMt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2026 22:33:39 +1100 (AEDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772105596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oQlqNAg7YmGMtU2zToh4UykdOV+ZpXIvjbeNwJDuSLQ=;
	b=GEvwlQopNT6g5r3qPFA3hw4hEH5lzxHgG6gobmbs2WMGHD+HZGnd7GNY/CkoXbEowidLAw
	tx81cT6J81Oodk5830V5/Eg35UClUBMuKripPGXqKWJTXSeijwrsHxbsky+sC0U5RvryLO
	fBDrl9SDTCk6keGVFJY654/48cN28Kg=
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
Subject: [RFC v2 03/21] mm: thp: handle split failure in copy_huge_pmd()
Date: Thu, 26 Feb 2026 03:23:32 -0800
Message-ID: <20260226113233.3987674-4-usama.arif@linux.dev>
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

copy_huge_pmd() splits the source PMD when a folio is pinned and can't
be COW-shared at PMD granularity.  It then returns -EAGAIN so
copy_pmd_range() falls through to copy_pte_range().

If the split fails, the PMD is still huge.  Returning -EAGAIN would cause
copy_pmd_range() to call copy_pte_range(), which would dereference the
huge PMD entry as if it were a pointer to a PTE page table.
Return -ENOMEM on split failure instead (which is already done in
copy_huge_pmd() if pte_alloc_one() fails), which causes copy_page_range()
to abort the fork with -ENOMEM, similar to how copy_pmd_range() would
be aborted if pmd_alloc() and copy_pte_range() fail.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 mm/huge_memory.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a979aa5bd2995..d9fb5875fa59e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1929,7 +1929,13 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		pte_free(dst_mm, pgtable);
 		spin_unlock(src_ptl);
 		spin_unlock(dst_ptl);
-		__split_huge_pmd(src_vma, src_pmd, addr, false);
+		/*
+		 * If split fails, the PMD is still huge so copy_pte_range
+		 * (via -EAGAIN) would misinterpret it as a page table
+		 * pointer.  Return -ENOMEM directly to copy_pmd_range.
+		 */
+		if (__split_huge_pmd(src_vma, src_pmd, addr, false))
+			return -ENOMEM;
 		return -EAGAIN;
 	}
 	add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
-- 
2.47.3


