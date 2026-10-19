Return-Path: <linuxppc-dev+bounces-29687-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 336B8CCF2DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Oct 2026 09:09:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7V8s2S9bz2yfD;
	Mon, 19 Oct 2026 20:09:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792400941;
	cv=none; b=Et8bPHEIiUctWY/UB728KWJUVvs0xcyuvonYY/GWUWbwDb/HHXk3y56tw9IzMWvbXLTfxqZimu0mk7qjPWQ/bOA3jIeOAHWECf1vfpMuKwgcXXdxqtuhGdfUj7r8rUMArL4M6PKgnMCVmzzmFsitqbfidxnKY8nS9qFyf+lfBmlLWEaR9tDF7X/+tG6pupWC55swbR++6eyBI2RnEEKQJPQk6ROZa9rRyKND9XFfHN/JgyiH5LZGVrUZmLO99PoORlW9dEzxfb0VDAhY1UjJWD5uIt99TtZGladhMIyrQ465e58/cJxxshMk2F0hRMKjzqwkJRixcKaYc5Z/bjDgSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792400941; c=relaxed/relaxed;
	bh=P+7LPi5HRPOOcdUC/D4c64YzsREdoI+6xRf4WfL2Y6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aXUuoAM58g0RXFufGm2Wlg/XxlJiDjKEVTjLdm40YCF6cSU+v/jh6BbtXk65jbEIuzFUPTe/hIMcNph4e4yA6+bESOq4w9zTVnk8roqziva5BGHktwIWr107yN1YpWTfn6mwnVEdPGS4+C2ZS6iFD7dr2ldp9i2jmeQWebkSIYb811yVtjoYRVFeDRimfmtl20iiQ2yPlIr+V08SQqVE+DvP2Fo3r9XSI1hKOXzV1FMflynNSj7cpxpE4xYYylR4SQDlrid3R/plyV92aGYLzJRmbacBB2gEVdx+bXxCvJNaeFhI8RU9YVMbVVIvJbCKnzSFL6cjBLMWPIR0Zb3S+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=ViTuwT1s; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=ViTuwT1s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7V8r3q81z2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 20:09:00 +1100 (AEDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2e987b4a710so13106045ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 02:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1792400938; x=1793005738; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P+7LPi5HRPOOcdUC/D4c64YzsREdoI+6xRf4WfL2Y6c=;
        b=ViTuwT1s5knAlqxGp+xLcbQHg4Cc3aK9aV8E3hy/c7//wbOjfcuskwce/E5RIEhBXh
         38b8iZEooBHriV4mFFWt0m8QpHnFwCnZEwcXhdeRJDyWhgJgUb7D0+GCWn78hAq9/8zg
         zA07IY5Tj/Ndvh8JX9ltNkJZ01JUT9wvm7/Pgkz49W+MmoLsDOc1FQgVgBePWv0qsf8r
         RTT2W7rdWPsfrHKd3ajZsq9NOP/Ivob8IMiH/USmsHKXeB1lHONieJYonWaELWOygrSJ
         ZCgCpkNzU28Fm+aVKT6DZGXnS8zYGTfYC2aNFKVqetsr76qs0CwDll1C2GWZNl8pUBkz
         iUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792400938; x=1793005738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P+7LPi5HRPOOcdUC/D4c64YzsREdoI+6xRf4WfL2Y6c=;
        b=oQ0qg9RhmjjffPf2/LqlzbA2GovOXl0X3OeEj0ssl4udiyWYwkZjxJtjwx3nvvJwZG
         gpepac83n7Z1Vy/Mawxm3/3WknAWIm/rBfpoGiHUBjyuzqwHWqOT1Vsr7A2YMaFYQHRl
         uqO629nrqaUTVeTtpCsK2XhZMGhdr9x5kjLNALHWvtfvRAcYo4TQk3CCjh1SHLROiGPU
         Jjh/CNLz+oDFcbJ3j9eqQfZDfh/ZKLhPoNJQwfkxMzjfdmQA0kZB+EtrDe63tLCfQ1zk
         g9kv967Y6QZFUPzhKZmzcB6aQnq23Tg2VeG5mp9fvF65LMnn/fCvJ5y6PVZUlGQFZdQn
         1hbQ==
X-Forwarded-Encrypted: i=1; AKwUvBy+nxiUvNqV7x62689AuotwdunzMfQslBUs+WEwtydJ4VxsSfCWu9QMGRBcrX9SsuJUEgieoQwdxii+WMw=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYL1OvPv5QGXyr6+2Xvk4vlC+Hx+5YrSSCiF2PkVFaRDFTpT+2IS
	CpZqSgwTJo6tWt/R8aH8yyAF7NieGa9DRnkKHFZxPgsiX3V9VbLxDNg97npWjm/y3KU=
X-Gm-Gg: AYBFou2AbTyh3qNtRRa/PdEPVZzihg2zs60vi8kQaMaa5Zw7axx7ITZx9uu4V/OpNP4
	ClkjNUxJu9jx2b6HuVnejcixc0mkpNx7ngvOsvkhlyI/YT94Y1ATm+8J9RJEqDf+ge9/V9TIzIB
	EwPrYERFvXA2SSwFlDIJK2b0ubZSfBDb/sA/0p5yhQVLc4y6nsStaV19Pgtl4K7fqXInkGydrDX
	3PLWuQYluNEXkJ6K7Xg09YCeSyBbJFB6yad49eKop1pTvR8HA4lYnogMMPrplKeHW88J/+fkfBY
	KidU8Jw0fvuHNAYJdIKSk2a0LiM0e18L/+pqg0dUT9r66awmHPQ7FAcfAqwAc7M346lMXTKh2br
	gs1BaGOWNnDpJPRzSy6pQ3dGFQDO6HmhbruClDoHmXJxB+KKuYrD5LBVucO4iYICXV9XUnK4+XP
	gDJaEjgEl+dIjAANIGsoCvnxKbfKsTbv81PAm9vTa3F6ocJ+xOJPT9CwliEJr8UCCPhxx6VyCcQ
	EHtC3YJoj8LksmReN4=
X-Received: by 2002:a17:902:f603:b0:2e8:6540:11b6 with SMTP id d9443c01a7336-2e9a6e3c596mr43244805ad.37.1792400938093;
        Mon, 19 Oct 2026 02:08:58 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e305f1dsm36707595ad.0.2026.10.19.02.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 02:08:57 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Muchun Song <muchun.song@linux.dev>,
	Lance Yang <lance.yang@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 3/4] mm/hugetlb_vmemmap: remove vmemmap_wrprotect_hvo()
Date: Mon, 19 Oct 2026 17:08:29 +0800
Message-ID: <20261019090830.1917657-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261019090830.1917657-1-songmuchun@bytedance.com>
References: <20261019090830.1917657-1-songmuchun@bytedance.com>
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

Shared vmemmap tail pages are now mapped read-only during initial
population, so already optimized HugeTLB bootmem folios no longer need a
separate write-protection pass.

Remove vmemmap_wrprotect_hvo() and skip these folios during boot-time
optimization.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mm.h   |  2 --
 mm/hugetlb_vmemmap.c | 18 ++++++------------
 mm/sparse-vmemmap.c  | 23 -----------------------
 3 files changed, 6 insertions(+), 37 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 35f5fc43861a..6f5affe54946 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -5359,8 +5359,6 @@ int vmemmap_populate_hugepages(unsigned long start, unsigned long end,
 			       int node, struct vmem_altmap *altmap);
 int vmemmap_populate(unsigned long start, unsigned long end, int node,
 		struct vmem_altmap *altmap);
-void vmemmap_wrprotect_hvo(unsigned long start, unsigned long end, int node,
-			  unsigned long headsize);
 void vmemmap_populate_print_last(void);
 #ifdef CONFIG_MEMORY_HOTPLUG
 void vmemmap_free(unsigned long start, unsigned long end,
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 0057fa2a16a8..3d72346c2ca2 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -603,19 +603,13 @@ static void __hugetlb_vmemmap_optimize_folios(struct hstate *h,
 	nr_to_optimize = 0;
 	list_for_each_entry(folio, folio_list, lru) {
 		int ret;
-		unsigned long spfn, epfn;
-
-		if (boot && folio_test_hugetlb_vmemmap_optimized(folio)) {
-			/*
-			 * Already optimized by pre-HVO, just map the
-			 * mirrored tail page structs RO.
-			 */
-			spfn = (unsigned long)&folio->page;
-			epfn = spfn + hugetlb_vmemmap_size(h);
-			vmemmap_wrprotect_hvo(spfn, epfn, folio_nid(folio),
-					HUGETLB_VMEMMAP_RESERVE_SIZE);
+
+		/*
+		 * Bootmem gigantic folios may already be marked optimized when
+		 * their vmemmap layout was prepared earlier, so skip them here.
+		 */
+		if (boot && folio_test_hugetlb_vmemmap_optimized(folio))
 			continue;
-		}
 
 		nr_to_optimize++;
 
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index ba0496daf4de..0af4b9e791b2 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -386,29 +386,6 @@ int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
 	return 0;
 }
 
-/*
- * Write protect the mirrored tail page structs for HVO. This will be
- * called from the hugetlb code when gathering and initializing the
- * memblock allocated gigantic pages. The write protect can't be
- * done earlier, since it can't be guaranteed that the reserved
- * page structures will not be written to during initialization,
- * even if CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled.
- *
- * The PTEs are known to exist, and nothing else should be touching
- * these pages. The caller is responsible for any TLB flushing.
- */
-void vmemmap_wrprotect_hvo(unsigned long addr, unsigned long end,
-				    int node, unsigned long headsize)
-{
-	unsigned long maddr;
-	pte_t *pte;
-
-	for (maddr = addr + headsize; maddr < end; maddr += PAGE_SIZE) {
-		pte = virt_to_kpte(maddr);
-		ptep_set_wrprotect(&init_mm, maddr, pte);
-	}
-}
-
 void __weak __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
 				      unsigned long addr, unsigned long next)
 {
-- 
2.54.0


