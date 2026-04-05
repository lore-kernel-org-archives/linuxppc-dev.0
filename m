Return-Path: <linuxppc-dev+bounces-19369-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6735EEB577
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:57:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXYj55czz2yvy;
	Sun, 05 Apr 2026 22:57:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393865;
	cv=none; b=YkvRwV97AR4yTn9Zo1JcK1nvuXlKR32XkW/q0LmyrPNleFftC1RMAluMFM65YGJWqUAfgGKeQD+w91mqRBoJFFfobuqrRouBdyGEVzy4C+9+81O9bhdPeJjCu1aMf93Zm9fjA4NeK9141anF2/FVoY9n6mXupTLZwrNAwKl85a6snQN6uGN+lY/lC63Hm5+BbglIqkdkXm3mF4iitP+zxJOnTYY+CO+jDFEWLjLyalXdj8vfTVD3FaDc4CCF1s82t70S9sRosj9Pqtf31o7PmYpZE5GGn1f3XZCEzQEbJGn3hGFB/TF73j6dndUY7+wIYPhUUfiFFkVIZeDGtMdnEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393865; c=relaxed/relaxed;
	bh=FJ+KumqAX13hYqdLVZVTFF+dZIRX9xi7vByMiu7tcmo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DZuUE8T7dOGjIgyLotAXKQQ9ES55IDOoXWJO1SpG33f4UvTTA1w702Y78aU2b9osqzCPc/AHN9qeBdcDJExGG2T+Z3F9K1FFncvhR2PjeXLuZpsO7mZoETpFB3LL0pqF3xMrbd/pDg24Z4IfKILua1PzVswcmUuDiVOZlPkct1dvKmJbnhlvJ44NYc+T9P9C8bCymkKlUoSUqf1Bf5/VtZvWCGvcRn8/J1FmXpYToxF9o9+X8TQ8ArE5SfOMvH4I+YrN0x7dH61vsKpMMxBBDbnGcu6Wr69WdhEeXgtiVhovAavFC3JeuFS7e8QLivPCG3iBjRptQTnRL7bWw3+OBQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=cYQICsLT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=cYQICsLT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXYj0cXkz2ynn
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:57:44 +1000 (AEST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-35c1a131946so2405387a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393863; x=1775998663; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJ+KumqAX13hYqdLVZVTFF+dZIRX9xi7vByMiu7tcmo=;
        b=cYQICsLTw5HeTwN3tGCeFTQjbfN6j1hCN6cqOOATFhZHWgQWre2Z2ru6ODZkmeay2E
         nYODiFRKylsn7E/Z98m4Mq/UKf3FTTO2mA8o8/J9n2Y2PvVH0+IDIU9wHCl6u7swgqcs
         ilDWVwG98tdU6wDF1Z/72ZYuHtESvx82UAtzTqx74lwlfFohRd88jv3jRFICaxzUmN0q
         mVY0qqNhKTGXApd2jpeJ2xxreczKw/uaMNdgwbgnKWsWw03H8rM6YisLs9dpIBUUa1fL
         +QGPOwAioFC3lmUVOpdq2Ui/25U03TtDQMyN/4kIJI3/6AI0hFxg3MzVYub9ef5ccReT
         aBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393863; x=1775998663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FJ+KumqAX13hYqdLVZVTFF+dZIRX9xi7vByMiu7tcmo=;
        b=CUnH+TY0Ly4rE2UfJABQS8SCyTr68iPYgq0BNGuw9/VVsQ46N0R1BKH7XmKsXLrMH0
         4EHyn7O1Q3CPVRziuy1YPXMCVaWWhiItS+gSNRnAW6QrQp2VjW9udVhL7vzc9Z/yw/VE
         t3Qc7u/LEF3saAH6pvs76WfF6kch2iZ7jDrmo7Ag+AHWp9SKRoXUco5J5l12WDLtUZ9D
         H+NtPKDBe0cmFzGvl95RHztKRKmLwLfeLXVNCFAdB7+AP4LOozqWyfoAXEjrl0/vsV9x
         wyoAF6xYTdgkai1xm6ZM1KkQkSqSdZvP92qmP/zPcRUFypOjpywObmYdfylxrwUwjZYU
         /+bQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvNZhcPutIasjqTMc0PF2OulDPaAYPz1BAzaTDs4WLT/9tjSuqmkqQCkYe3QdGI7ABOmeRIPbZUC26GfE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywv2tDDbypCLg3Eg2CE7isGAq6Rp30mgF5tkMaMX9zyo1uKZ/l9
	tQUkPyPeHNrc3mRDTKuQXgSZ1XaDfwGheORJ54r1cTviDSDuZDaj43EFI9olTXF3Wx0=
X-Gm-Gg: AeBDiev8nHWMUgwk7HbMcKwkyh571WtW59klyOqHAmttCcI8swMYZElVxVSLVqn6nlC
	kMPYVEOSXonHu5VEoZRVANXSC3MHH8gJMGDZOKYM782fYZ6GsddQ6C8rws6rNBwlPoFbL0k8L42
	ry0VlURkgBB8BuI8tCiILIlkoFVDXzjxY2ruaack4MoNFrDrPb4vbRqf2cluW3JFpm+HQITPRnL
	Bh7YFZ1orj7Ce+kT6irgSVhmae1uuOjcrAnfLZrRaxdqlwKBrwx0v/DrvgaX2e671+ygECFr2ug
	IDIIwoi1DqIZHpO6nrhApOZ3PEUY+fIURM0eBW7/ZbKp1RSBI3oy7rw7k1HiVOfzPHXvM3Bm3QT
	dxBHpv1cnNBOJqVxFWuU+AOFfNwqbQY1fRhOkdkZRde++1N1mEMPdusP2dhf6v7rOeNsYkJJaWe
	d3DBu26PIS1aJwjYrnlTQ7619HPFEEu9U5g2Mza2Kd8kg=
X-Received: by 2002:a17:90b:3f50:b0:356:21e9:73ff with SMTP id 98e67ed59e1d1-35de5c3d5b5mr6803962a91.11.1775393862969;
        Sun, 05 Apr 2026 05:57:42 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:57:42 -0700 (PDT)
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
Subject: [PATCH 39/49] mm/sparse-vmemmap: remove unused ptpfn argument
Date: Sun,  5 Apr 2026 20:52:30 +0800
Message-Id: <20260405125240.2558577-40-songmuchun@bytedance.com>
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

The ptpfn argument is unused as it is assigned unconditionally before
being used in vmemmap_pte_populate(). Let's remove it.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/sparse-vmemmap.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index c70275717054..36e5bcb5ba9b 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -149,8 +149,7 @@ static inline struct zone *section_to_zone(const struct mem_section *ms, int nid
 }
 
 static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
-					      struct vmem_altmap *altmap,
-					      unsigned long ptpfn)
+					      struct vmem_altmap *altmap)
 {
 	pte_t entry, *pte = pte_offset_kernel(pmd, addr);
 
@@ -175,17 +174,15 @@ static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, in
 		 */
 		if (slab_is_available())
 			get_page(page);
-		ptpfn = page_to_pfn(page);
 
 		/* Remap shared tail page read-only to catch illegal writes. */
-		entry = pfn_pte(ptpfn, PAGE_KERNEL_RO);
+		entry = pfn_pte(page_to_pfn(page), PAGE_KERNEL_RO);
 	} else {
 		void *p = vmemmap_alloc_block_buf(PAGE_SIZE, node, altmap);
 
 		if (!p)
 			return NULL;
-		ptpfn = PHYS_PFN(__pa(p));
-		entry = pfn_pte(ptpfn, PAGE_KERNEL);
+		entry = pfn_pte(PHYS_PFN(__pa(p)), PAGE_KERNEL);
 	}
 	set_pte_at(&init_mm, addr, pte, entry);
 
@@ -255,8 +252,7 @@ static pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
 }
 
 static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
-					      struct vmem_altmap *altmap,
-					      unsigned long ptpfn)
+						  struct vmem_altmap *altmap)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -276,7 +272,7 @@ static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
 	pmd = vmemmap_pmd_populate(pud, addr, node);
 	if (!pmd)
 		return NULL;
-	pte = vmemmap_pte_populate(pmd, addr, node, altmap, ptpfn);
+	pte = vmemmap_pte_populate(pmd, addr, node, altmap);
 	if (!pte)
 		return NULL;
 	vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
@@ -292,7 +288,7 @@ int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
 	pte_t *pte;
 
 	for (; addr < end; addr += PAGE_SIZE) {
-		pte = vmemmap_populate_address(addr, node, altmap, -1);
+		pte = vmemmap_populate_address(addr, node, altmap);
 		if (!pte)
 			return -ENOMEM;
 	}
-- 
2.20.1


