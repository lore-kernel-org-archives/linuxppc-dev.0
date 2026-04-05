Return-Path: <linuxppc-dev+bounces-19361-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C193DEEB577
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:57:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXXb1J8mz2yvK;
	Sun, 05 Apr 2026 22:56:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393807;
	cv=none; b=iJ3cqn0qZxXPeLHKHY7dqtQzmh+LOFM35oKHHkzI1xB2QLNg6JddITkkEk/zLzkoB1B7ZgMAsmCtQlssXRgr/yDd5rT42MJIMzyf/Yd3AepapnemAJwof3Vqb7/7Brn5aiGzT3IyZwhkYclbUbszpLjGkx67UcyvI5QSUc/WqtZ6mRlccGRRKAQ9nu5adiuWycJ194K5cuifZn6CIbn9Zx0REl7AlS8XUmJq4lE4i3ca7YtHhhlHgecvIU8u2o6/CSp4pVnHDJ3xcAPh+Gd3aoB4D41Zui70DShnkIzPSYM545guznZJeYs4SEftM1keamRRggdRchyqsqeVabwNvg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393807; c=relaxed/relaxed;
	bh=/Tl0DYENAt+V70Fu8vSLfAcsd763D1dzR7HZC3FaIa4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ka2EJnYSbrCxxVWZ8nU0wik2ilKkoFfj8+lv6aa/F7kbu79qnEPeepqgfMChhbyVPSt/a1Du6hoXb1J9Tyh9zz/+RdSj68i4jBnkZd1/chmp1XmXw0UWDRIKuSQ76ivv08Wc1rY2twzGzklseFlTVGlAYxLm5wTMhrUvE8g6gJCqxTtJSP3WRcMjiXsSSDnvJlEgKoRgGtAdt1GIyhXkaks/FDyNZOrSisOeqL7Dy5VHrASYWIUEIgf9+HGiPSdpj3SvNcH+BNeJWXtMRid7kppy/Cm7vCaqxQyHDLq8mBINEMG680jmVgPB+WCfLLbujkp7bcZtVOpIbx8qc40wjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=j5YbNmt4; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=j5YbNmt4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXXZ318mz2ynH
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:56:46 +1000 (AEST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso2191716a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393804; x=1775998604; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Tl0DYENAt+V70Fu8vSLfAcsd763D1dzR7HZC3FaIa4=;
        b=j5YbNmt4pwSR1Ddja1O29zijIAeh4e/GAR4Wt2xQR84ioGHThJMqZZ+67ZSsAj9dE8
         iV6QzjTHY9BQZYYKaRMGDFwDkTJ4MtahhNvY14yZIid0LXl3yOGE4IrDW5g12PNBzYO8
         RX/H2C7uFn53BUTyi2M6EvHDLOc4w6gCIHOs/u6jmdMEUu12D47fVAGzI31Ts7m584y1
         MAFBDAFpeK+AwfPJl23JBxPP8HR4K3eviNwHRywnoWojEMqyin9u6eRUQLooq1EVN2Pj
         6JNDPq7KFs3FqGvBUAqHzhkVMGRmKitwDgIt6Poi3L+LKYt81/swwu39Pf0k0qjw4OXO
         aWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393804; x=1775998604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/Tl0DYENAt+V70Fu8vSLfAcsd763D1dzR7HZC3FaIa4=;
        b=RKuIgmRtUimjcYNTbc9RYCLv4Xy4CSCiupQGPF6FWhFDWqGS/XoGgTHOJv0lRqF7sm
         ST9+7QEGrO/WcSzq0hbJn4LCpaYDca0OKiTjS/eGpQKHhqBxmsRyWkMHpmQdCbAlNQao
         VOCcHVZOfej0v9bF3wrWPbIQSJkZtTym04ycxaNn0y4eBcQDiWJrbvAoXyJ7QBuaWVqL
         WNI9SKm9MO7vRbDcyIdJ7jF3r+yEOq/XYSTypKpua5OIStXFZHbXlo/9TuCHYquLbigH
         /JqTIpA0MnduAjW9wQfNqDIspuB+0vlRKdYtH784eGa+CKNa4DkjzMmRAfE28pioh3+L
         ch8g==
X-Forwarded-Encrypted: i=1; AJvYcCUuJ7Hkmejjax6Va0Gf6ytPSg42Bzh9lmc891le6E4yb2zkBlKl0/UwbW1ciPvAOa0JQf9FAm+mEx/pnjY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwnFsLyms7so2NqQCmHLh/a8+LsU0MAShKK6qq74CkIvOgjdZSN
	ATTsEcSOBpd3njdrZvtIZFy++6kCZ7ktojpBvrhryhAaHKgOzCErR2KA4XN0Scvb7gw=
X-Gm-Gg: AeBDieu+1+T1ss3d7gXnFSIxK3GmtXLVKu9uz26Bac4wyw7WI8zj2v4wheG9D0wRzi8
	TWTiCdNjBUZ7ZBur3XhNP/lW6/BA5ZGnSXcj92n3M9JUIFJvE5OEzxXCHRcJfFedIlxNWq8MByt
	Yvd2IF9DL/ooo8gWTCNKuorX3g5n1c0vcluQuHQ6RapKBxCbT0HF9m0lYes5IQIsY/OjCDJXu/l
	DdxE3rRMpkliFt5YItR8q7KzkPD4KC7U0qbrSoXLlpE/y2QES2fD9MGPV96AEerl87XeneynZsG
	65hLu3Se42JkJPfSIG+tENZtx5oW4PvuD/cgBC3JelmiP89h+YMyQi0J3Kf9Ew9O67EL93SITwg
	c+vzIANJHSm53GhtN7lwdhMuvhWwMdUGOYQB81Q0XE86f9okLiQ4EDX6XLguzJHORCwUkS9xdBh
	jby2qYjgQAFe8cJ3z5Ac5+66q6Ma80BP4jrHCSAQTMskc=
X-Received: by 2002:a17:90b:1cd0:b0:35c:812:612a with SMTP id 98e67ed59e1d1-35de69cece4mr8333640a91.29.1775393804441;
        Sun, 05 Apr 2026 05:56:44 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:56:44 -0700 (PDT)
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
	aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 31/49] mm/hugetlb: remove HUGE_BOOTMEM_HVO flag and simplify pre-HVO logic
Date: Sun,  5 Apr 2026 20:52:22 +0800
Message-Id: <20260405125240.2558577-32-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260405125240.2558577-1-songmuchun@bytedance.com>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
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

The pre-HVO feature is used to optimize the vmemmap pages of HugeTLB
bootmem pages. Previously, the HUGE_BOOTMEM_HVO flag was used to
indicate whether a bootmem page has been pre-optimized.

However, we can directly determine if a huge page is pre-optimized by
checking its section's optimization status using
section_vmemmap_optimizable(). The pre-initialization mechanism of
vmemmap has been completely removed in previous patches, making the
HUGE_BOOTMEM_HVO flag and its related checks redundant.

By directly using section_vmemmap_optimizable(), we can safely remove
the HUGE_BOOTMEM_HVO flag, clean up the associated state maintenance in
struct huge_bootmem_page, and simplify the bootmem page optimization
checks in the hugetlb initialization path.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/hugetlb.h |  5 ++---
 mm/hugetlb.c            | 16 ++--------------
 mm/hugetlb_vmemmap.c    |  5 -----
 3 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 23d95ed6121f..6bedeaee9b79 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -695,9 +695,8 @@ struct huge_bootmem_page {
 	struct cma *cma;
 };
 
-#define HUGE_BOOTMEM_HVO		0x0001
-#define HUGE_BOOTMEM_ZONES_VALID	0x0002
-#define HUGE_BOOTMEM_CMA		0x0004
+#define HUGE_BOOTMEM_ZONES_VALID	BIT(0)
+#define HUGE_BOOTMEM_CMA		BIT(1)
 
 int isolate_or_dissolve_huge_folio(struct folio *folio, struct list_head *list);
 int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index dff94ab7040a..59728e942384 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3193,11 +3193,6 @@ static void __init hugetlb_folio_init_vmemmap(struct folio *folio,
 	prep_compound_head(&folio->page, huge_page_order(h));
 }
 
-static bool __init hugetlb_bootmem_page_prehvo(struct huge_bootmem_page *m)
-{
-	return m->flags & HUGE_BOOTMEM_HVO;
-}
-
 /*
  * memblock-allocated pageblocks might not have the migrate type set
  * if marked with the 'noinit' flag. Set it to the default (MIGRATE_MOVABLE)
@@ -3284,16 +3279,9 @@ static void __init gather_bootmem_prealloc_node(unsigned long nid)
 					   OPTIMIZED_FOLIO_VMEMMAP_PAGE_STRUCTS);
 		init_new_hugetlb_folio(folio);
 
-		if (hugetlb_bootmem_page_prehvo(m)) {
-			/*
-			 * If pre-HVO was done, just set the
-			 * flag, the HVO code will then skip
-			 * this folio.
-			 */
+		if (section_vmemmap_optimizable(__pfn_to_section(folio_pfn(folio))))
 			folio_set_hugetlb_vmemmap_optimized(folio);
-			section_set_order_pfn_range(folio_pfn(folio),
-						    pages_per_huge_page(h), 0);
-		}
+		section_set_order_pfn_range(folio_pfn(folio), folio_nr_pages(folio), 0);
 
 		if (hugetlb_bootmem_page_earlycma(m))
 			folio_set_hugetlb_cma(folio);
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 8c567b8c67cc..a190b9b94346 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -711,12 +711,7 @@ void __init hugetlb_vmemmap_optimize_bootmem_page(struct huge_bootmem_page *m)
 	if (!READ_ONCE(vmemmap_optimize_enabled))
 		return;
 
-	if (!hugetlb_vmemmap_optimizable(h))
-		return;
-
 	section_set_order_pfn_range(pfn, pages_per_huge_page(h), huge_page_order(h));
-	if (section_vmemmap_optimizable(__pfn_to_section(pfn)))
-		m->flags |= HUGE_BOOTMEM_HVO;
 }
 
 static const struct ctl_table hugetlb_vmemmap_sysctls[] = {
-- 
2.20.1


