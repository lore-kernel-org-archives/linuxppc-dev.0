Return-Path: <linuxppc-dev+bounces-20893-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0EBCD4851
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:13:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFv486f7qz2yhP;
	Wed, 13 May 2026 23:11:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677896;
	cv=none; b=duD8sdsfX+EYQWoYGKXIj9O63lHapv7NVltihjGU3EDQz64pa3XzqBuwet1HM1V5XmgJYkSDkhcHGefs8DZMD0EXqg5et3F5HDRLsoCG/GhtmdcaCBsCYqQrmxeiWI3n2a/P/2Na/LCD1soRNvEVVPBlz/tic6ioDrEf/tS6993g+fQ/LLfE6nMCewWMTdV4mwXi0KlsYokq3TgOCKkuRpiZrdUHytq1YC8oyMSfdVryMgylDiPDhgIDo9fch3pJq9rEXY7LiDEpu0BWNLepx5gJqluFHchwu/TpYnigUyZZT3tvRwsLLhSylUhMd/MFrHcsXeHpv7DxrNj5ib803w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677896; c=relaxed/relaxed;
	bh=r3qZ6fKvu/W22OcYYEqHvfVb2RH2sc3ZeigSJrIXA9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=omzpQnhbToC6fx2t0q/6rKTQLa8lVz5WsYZy2eAaaOgwv/LL7gT+VyuSGbS2JNQ7VFoZNdhV3yCJnaq6KHOrRBXpgNQm9Y6puCr0adYJpl9uI0HL/JEpObmiuJxYZzyuoHgvOAyVUDOjVpOknc+Ano8dtLoZ+tDvqqRcumHqxEI5bAPYzVpojbvRhKy4W+pH3xGikBj2SPpWyEzrCeRyUFxtgeDsLDG2735JBrA2hvqSC6T7h40wwV05inhTjYAtiVmR9RCiFVJ14Hh0IKS8khLWQdPi+bzPEL0Fe9gedz2IyePE0C86+QixT6NKUIKupWM/zAxWiIbK2RbXlf+47w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=MDdUSoq/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=MDdUSoq/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFv482DCLz2ygX
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:11:36 +1000 (AEST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2bcd730e090so24830705ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677894; x=1779282694; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3qZ6fKvu/W22OcYYEqHvfVb2RH2sc3ZeigSJrIXA9w=;
        b=MDdUSoq/dOKfrzBTN7cAXXfD3tyFne6UEqLDZQUT+GS8cwOSsXYb/25DGYKzzFDNvp
         bpMYY8bPVPXGJQFC4TE0csg1tCEoLmpL7tiedZEdR90tIhWGCjUEli0lU0mCNRqdPjNO
         m9EUZsc4l56hoGXpullOGd14BjifDqiPRYj14JZhNpEpiU+/D9dko9Y4fj+oGVxRvins
         lLT9PtDkbzxxuqZkNepEFuQzuAfABBGLJhKqc6GatFw90F9e0Lry0O4TXKaLvDJRAGT/
         WU7sfRKj6Vc9+Z90f3QB7VsdRCc2qY3pd2ZcJa79mjuBRwm0W5ScrQIbMc71zTaT6kKL
         S0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677894; x=1779282694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r3qZ6fKvu/W22OcYYEqHvfVb2RH2sc3ZeigSJrIXA9w=;
        b=RfT/miRBpvhiRpFHv7MMeC4oe23oDamKSmOpTMnzqDboEEp09vOXBAe2p3VLN5ISur
         szjAXKJeB9F7zf3eeUO8VK5E3HcYz+fc6lEeU8HAbac7LeDLx/Xzm170ZZpgJH5d2JNl
         mB0Pg6+SQFFBD1RT5lQX3DnbTc8XONOldX0F0Iwr5VjDK5cgMGjroF0wfMcQdNbPll9k
         3NsaLkfSTgxjcEiQr9//bTEAI0gUOMLUlWPNfrCaqePoRZ8NBGbwGjSO/od0nZpf3dXm
         wlojUGXIr68zOYuU3oNJNhiBZspTI73LHhqoexoMyBSYsdAyk4QDhy3wUxxL9CPOLVIw
         seFA==
X-Forwarded-Encrypted: i=1; AFNElJ8JsWUMutqv3f/fBkNwhyeQvbRJpVum9NacSlALlNkV0dtENS25mIDqxUiJg3cwmAOkjfufFgCGCaatriE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx8dR1fKOwERKJw5rRLKbyS8hMx0rNmCFrST76FjxB/8JxO6zb1
	pUz0WAWVotmUwRsBrr7bZT/HhEfvQMl2EU6Csc7t+NQ/sDxO6/h+UC/Up3BW5Tg2gdw=
X-Gm-Gg: Acq92OGKpdC5plKMchhuIoxymls7SSwnzIzFwjW29rDW5lIzeqHVGiiifRwUBflr+x5
	lhhshHMbWOtmHdaCVuL3ryXW4tCgq6hmTv1wEiY84oBBrWCJWFtiCaZM5DjAswWWLkisufn8aT+
	4oJBDk0NcJDVf5M4zWFbWGROmg8c64f+7YsSosetGXeAQgjAaEklh4sCn+LbTSigPgr1ffPRk/s
	/vzEjJBC4EJ8qqTo+lZsqEBbqyRsmwRsISxdI6XU3v9EtQgEyaRaewFOig//gtPt6Y/7/VrjGo8
	KKwQ+s8Yi1wLA5xRQJ01TR4Y50gFWpPdTr8FO3XSWn1Gyv3C1If6/bmG55HrU8iKexz5EiZBUoK
	5nn5bff80YPxUIh9JbmTBi+E8C4ydaoZtRLK8an277x/tUQ7YvT0RvDtOeFGgTVOi8W6xH7wsc6
	zmjokZyRpetqUdM9WAP2Pj5jT3wmY9rO2FszJeoLFBR/oPn4ULufWt5kkyNRo=
X-Received: by 2002:a17:902:8648:b0:2b4:5dff:30fd with SMTP id d9443c01a7336-2bd2f4f734fmr21340805ad.4.1778677894343;
        Wed, 13 May 2026 06:11:34 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.11.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:11:34 -0700 (PDT)
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
Subject: [PATCH v2 44/69] mm/sparse-vmemmap: Remove the unused ptpfn argument
Date: Wed, 13 May 2026 21:05:12 +0800
Message-ID: <20260513130542.35604-45-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260513130542.35604-1-songmuchun@bytedance.com>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
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

vmemmap_pte_populate() no longer uses ptpfn as an input.  It computes
the PFN locally in both cases before building the PTE.

Drop the argument and inline the PFN computation at the PTE creation
sites.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/sparse-vmemmap.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 4833a2295abb..182d0c7dd1e7 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -124,8 +124,7 @@ void __meminit vmemmap_verify(pte_t *pte, int node,
 }
 
 static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
-					      struct vmem_altmap *altmap,
-					      unsigned long ptpfn)
+					      struct vmem_altmap *altmap)
 {
 	pte_t entry, *pte = pte_offset_kernel(pmd, addr);
 	struct page *page = (struct page *)addr;
@@ -158,15 +157,15 @@ static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, in
 		 */
 		if (slab_is_available())
 			get_page(page);
-		ptpfn = page_to_pfn(page);
+
+		entry = pfn_pte(page_to_pfn(page), PAGE_KERNEL);
 	} else {
 		void *vaddr = vmemmap_alloc_block_buf(PAGE_SIZE, node, altmap);
 
 		if (!vaddr)
 			return NULL;
-		ptpfn = PHYS_PFN(__pa(vaddr));
+		entry = pfn_pte(PHYS_PFN(__pa(vaddr)), PAGE_KERNEL);
 	}
-	entry = pfn_pte(ptpfn, PAGE_KERNEL);
 	set_pte_at(&init_mm, addr, pte, entry);
 
 	return pte;
@@ -235,8 +234,7 @@ static pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
 }
 
 static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
-					      struct vmem_altmap *altmap,
-					      unsigned long ptpfn)
+						  struct vmem_altmap *altmap)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -256,7 +254,7 @@ static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
 	pmd = vmemmap_pmd_populate(pud, addr, node);
 	if (!pmd)
 		return NULL;
-	pte = vmemmap_pte_populate(pmd, addr, node, altmap, ptpfn);
+	pte = vmemmap_pte_populate(pmd, addr, node, altmap);
 	if (!pte)
 		return NULL;
 	vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
@@ -268,7 +266,7 @@ int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
 					 int node, struct vmem_altmap *altmap)
 {
 	for (; start < end; start += PAGE_SIZE)
-		if (!vmemmap_populate_address(start, node, altmap, -1))
+		if (!vmemmap_populate_address(start, node, altmap))
 			return -ENOMEM;
 
 	return 0;
-- 
2.54.0


