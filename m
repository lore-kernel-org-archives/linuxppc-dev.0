Return-Path: <linuxppc-dev+bounces-20907-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29ABFCD4F3D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:22:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFvJL1kDJz300g;
	Wed, 13 May 2026 23:22:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778678530;
	cv=none; b=R5DNJayKojRz8q8wCX4siVlvlaOTTHIln3/h0OofEDoE4l6n4paFCd7nrPYtEP809G5fZIRymZWrQyOZAYvD7jJakNsymHOD/e4cO+OC8/SQZ5eEOguol1BIBxQgKCEgJr9aEeHAoVx1gwiPX6mhh8DnrWL63jGOC429s+zkmdtPcU0lqhkf3q5GGZDsF6VZpPvf2it5TR9YPvNzdrQgsZhtXKcKwvgfN1YxP9Eymxkgt0x67CMPNsHQdAgozv5JT8dAqblhMMY8/A2ex5XQ8YumE8hpIIplRUqr6mpzxPE0lYasNWgz/yrF5OuPKOrG03J7BWcZZv1QWUsBvNMCkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778678530; c=relaxed/relaxed;
	bh=gyY9SCyAZIGNdueTrW/y87O7+cp/ViobtWpZedyU1UI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RB4P6sT708REcN8QmV7NbXbpohnEKBtS0a4hpnL98rCzZyRT4+1ReQqycKL3VlWsYi5ZY6f/KRI5OH9CzsoPP4od1TBjfXTuPuXioq/Bv7kp+pCMuTiBsAOEpAhN7EjlsyDJ7Y2b9jpresfLDn0vOQ4iv1B4K0i45Nanxd21Xz9BowCg8DKFPg3Ixb5ddeN/kVxUTUyBAanLOe3qYCeWzZq/lWN+AKARdNeszOo2UldgNXpDsxWIQh4323zu9pjFBs9fw8qsd3kc3JwYxbMSNTOGSqQLlakzg/1sEuwptvqnDdhOa8g5Jew+FXlcuEUsPXiGutK6/Xum+7hewitIbg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=SlhE6UVY; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=SlhE6UVY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFvJK4Slpz2yVP
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:22:09 +1000 (AEST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-3653cb9c6f8so5431536a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778678528; x=1779283328; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyY9SCyAZIGNdueTrW/y87O7+cp/ViobtWpZedyU1UI=;
        b=SlhE6UVYLE7iiIygKqRDr//e4SXrxMwnvOP51psB9vhe5uZdi5Plvu2LYtsdvTcw51
         iNSTVcD9Yn37pF4ZslwSMb/Pnw8fYGG+szrcWl/FlkIEKYBCsgHH9r/7rFmu8VEMuz8L
         7DpJUn3feFZS6UKXJh8dXPpdlcsHhJ98cQ38ZPWYXTQ5/g4BBtyUtohAzPAox4Q3YeX2
         XwGZMbEaD6rFnvT+ltp4U8l60oDzGnnb7jHLibkUteCUFlj2JEr0nVnUhhSPfuGz/akX
         SAz7xOoeAD/xbTSfFVlRwQ1e2+CXhDUQSKqUPptyWH5rP9c/z+8sNFPL8KcItOQrPg61
         cdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778678528; x=1779283328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gyY9SCyAZIGNdueTrW/y87O7+cp/ViobtWpZedyU1UI=;
        b=IuWGglv26Wnlx2i9WOkTbI949ovpp4U9jlz0/o9P2OUXhPkD+X7tcSODdkSQj38Q/G
         pke4JYfVY9RyNovZbz+t6wYcy1/tuXpyEphbnpKyDBHMZqvxXTm6b7f8fxqt6O6VKkBT
         DII79pUIL23aXRAqrW00mMqgwsF31oGRlvQFsiBLpBy68A253A9sZ4q9XY1lH5jeRKvr
         2G0P6bOW1VTJ+wUEYVjpBPK2xhHr7aEMauseQg7qdfTbt3bB5Wnv3U6+o2u8ah4Mek4m
         y9PcusNC7f1oWtYj5uIw/IuWpQh9bJgAl2H1qX8+0P+2RSCFd0I0A5HAI4hGLma+tCni
         gytA==
X-Forwarded-Encrypted: i=1; AFNElJ/YsUFlHm0b978zHjdAPqKhlMfb+9j1YbEprh2NL7FRbQ9EVk3xoOk2V/9vyGf5D44QFJuh9ahupilSj1I=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxTUXJUx2q8rA+iZ3QeYGF+2qpzXYIW210aJukvlSB3lnsdc0a7
	L1+HHmNH1VCx3EzICmiS1BinR9de/Mak0ooJOQPyEuGg+L0QA+MfpFgebS+usy/oBbk=
X-Gm-Gg: Acq92OFTPStnEL1ysir9EnX2pTUgQ+nzRaDi9whFKO7kNYvaX5wODkCc0zRwNHqASeM
	Ket7MPgKLjjdDO0W6gc9+UHuO12dQKFCWuJTWD2JxOX6JTpPC2qdrAM5l34VGk92bUOp+vR8QzZ
	YHBfa/YzsfjYquXVEyi4ZUVntkviNXuWnaSxScp7XUCoU2DeIfE8LmAiysQqXN+yciSpx6nqy6N
	qmVkWFShKx76LwXo1Lqu8zHuR9JOyd5RZGa5osQE1xIUjvEX9mOKxh5wEM7us/E3kbtdzBNOm9/
	IgnPaoGlHhO6Q0wdj9TLJj/Av0qDZea4TEGgsxC7DFafWBnM0AA1jI6nMEkFoh32Y9NK7hJDBam
	AzETtEAusEp/akIZ1iB2OrTN13WtKbKwGLlvRg3kiB10LxIcp+CsbX5QkzVb852wcoX02c4BSG2
	5a/mX68mrTkZ+8WAchuuJmkO5/mGQykMaWdnlj+e+gs7o/05Ii0Wb7Flqn7Ngs
X-Received: by 2002:a17:90b:3bce:b0:35e:3b08:8fc4 with SMTP id 98e67ed59e1d1-368f398c9d1mr3681030a91.5.1778678527413;
        Wed, 13 May 2026 06:22:07 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368edf7cbc2sm3098406a91.14.2026.05.13.06.22.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:22:06 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ackerley Tng <ackerleytng@google.com>,
	Frank van der Linden <fvdl@google.com>,
	aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 58/69] mm/hugetlb: Make HVO optimizable checks depend on generic logic
Date: Wed, 13 May 2026 21:20:23 +0800
Message-ID: <20260513132044.41690-12-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260513132044.41690-1-songmuchun@bytedance.com>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
 <20260513132044.41690-1-songmuchun@bytedance.com>
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

Make hugetlb_vmemmap_optimizable() reuse the generic
order_vmemmap_optimizable() logic, and switch hugetlb boolean call sites
to use the dedicated helper directly.

This keeps HugeTLB-specific optimizable checks aligned with the generic
vmemmap optimization rules and avoids open-coding the size-based test.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/hugetlb.h |  2 +-
 mm/hugetlb.c            |  4 ++--
 mm/hugetlb_vmemmap.h    | 43 ++++++++++++++++++++---------------------
 3 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 82dbb9ebead8..2383adb22ce1 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -778,7 +778,7 @@ static inline unsigned long huge_page_mask(struct hstate *h)
 	return h->mask;
 }
 
-static inline unsigned int huge_page_order(struct hstate *h)
+static inline unsigned int huge_page_order(const struct hstate *h)
 {
 	return h->order;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 54ef7d12c585..bd136fc6aec0 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3351,7 +3351,7 @@ static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
 			folio = only_alloc_fresh_hugetlb_folio(h, gfp_mask, nid,
 					&node_states[N_MEMORY], NULL);
 			if (!folio && !list_empty(&folio_list) &&
-			    hugetlb_vmemmap_optimizable_size(h)) {
+			    hugetlb_vmemmap_optimizable(h)) {
 				prep_and_add_allocated_folios(h, &folio_list);
 				INIT_LIST_HEAD(&folio_list);
 				folio = only_alloc_fresh_hugetlb_folio(h, gfp_mask, nid,
@@ -3420,7 +3420,7 @@ static void __init hugetlb_pages_alloc_boot_node(unsigned long start, unsigned l
 	for (i = 0; i < num; ++i) {
 		struct folio *folio;
 
-		if (hugetlb_vmemmap_optimizable_size(h) &&
+		if (hugetlb_vmemmap_optimizable(h) &&
 		    (si_mem_available() == 0) && !list_empty(&folio_list)) {
 			prep_and_add_allocated_folios(h, &folio_list);
 			INIT_LIST_HEAD(&folio_list);
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index dfd48be6b231..1765f8274220 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -18,22 +18,6 @@ long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 void hugetlb_vmemmap_optimize_folio(const struct hstate *h, struct folio *folio);
 void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list);
 void hugetlb_vmemmap_optimize_bootmem_page(struct huge_bootmem_page *m);
-
-static inline unsigned int hugetlb_vmemmap_size(const struct hstate *h)
-{
-	return pages_per_huge_page(h) * sizeof(struct page);
-}
-
-/*
- * Return how many vmemmap size associated with a HugeTLB page that can be
- * optimized and can be freed to the buddy allocator.
- */
-static inline unsigned int hugetlb_vmemmap_optimizable_size(const struct hstate *h)
-{
-	int size = hugetlb_vmemmap_size(h) - OPTIMIZED_FOLIO_VMEMMAP_SIZE;
-
-	return size > 0 ? size : 0;
-}
 #else
 static inline int hugetlb_vmemmap_restore_folio(const struct hstate *h, struct folio *folio)
 {
@@ -56,11 +40,6 @@ static inline void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list
 {
 }
 
-static inline unsigned int hugetlb_vmemmap_optimizable_size(const struct hstate *h)
-{
-	return 0;
-}
-
 static inline void hugetlb_vmemmap_optimize_bootmem_page(struct huge_bootmem_page *m)
 {
 }
@@ -68,6 +47,26 @@ static inline void hugetlb_vmemmap_optimize_bootmem_page(struct huge_bootmem_pag
 
 static inline bool hugetlb_vmemmap_optimizable(const struct hstate *h)
 {
-	return hugetlb_vmemmap_optimizable_size(h) != 0;
+	if (!IS_ENABLED(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP))
+		return false;
+
+	return order_vmemmap_optimizable(huge_page_order(h));
+}
+
+static inline unsigned int hugetlb_vmemmap_size(const struct hstate *h)
+{
+	return pages_per_huge_page(h) * sizeof(struct page);
+}
+
+/*
+ * Return the size of the vmemmap area associated with a HugeTLB page
+ * that can be optimized.
+ */
+static inline unsigned int hugetlb_vmemmap_optimizable_size(const struct hstate *h)
+{
+	if (!hugetlb_vmemmap_optimizable(h))
+		return 0;
+
+	return hugetlb_vmemmap_size(h) - OPTIMIZED_FOLIO_VMEMMAP_SIZE;
 }
 #endif /* _LINUX_HUGETLB_VMEMMAP_H */
-- 
2.54.0


