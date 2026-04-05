Return-Path: <linuxppc-dev+bounces-19338-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C375EEB577
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:54:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXTj4T3fz2ynC;
	Sun, 05 Apr 2026 22:54:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393657;
	cv=none; b=aCO0PVaKONVkAqRC/79LLxluBzvuIvblyy0kj/LCJN8vw8bg78cx/LcfJ07K+CHLZwUt5n1JezyXsFQ5UX9CUL/vWnpg3BbyUyXxzSEeRQreETtIc6bnaYlqgIFjx1qBuKQZSwL316B8ZlKIZooubcJHkYTwfn00LYLBJQvBxjVFiVXT04kAjQXP7zuoXuc6eUvdkTVqu3ibgrFz4PqPOm8JfC85iRzMfZNQP9jBu8p2nQq9Aj4HZ46Q44W5q7OUvx15eoY/GtNaYa5EV64lanBAdAWcN5wDClLFCYLgcGYfih68/6Baez1F++ymvfoJpeaLfcSKVYPKPRD3YivNrA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393657; c=relaxed/relaxed;
	bh=oG1BlwIWBanSrBSTwRxoxLhn0mTG5YlmPdthc1egVX8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G7i6v7Pzi7CseDI6kCWdlQjlNIXY2csh1KuJXTg+qzg0lXoErpv+3h/rLlAx+yKzjuq7lQ9lL2K1E7WPJw+jcwOcyClIKU1vG+yc+KwFSQxD6y72ziwAiYvH/uf+iysYFfSN1GfIC7+IhFMhJlh1CKXXA1cm0ZnWvq7X6CrQHUXS0trcgFFRxHCyyR1RdXfSc3xqgOu6FwkadA6D72J1hEzuBsZbYFze81+Rr2SqpJfQ4Q2aBO4CpyVYC8qkxVym+qRB9BLBP2uXatQT7so9TcZP9KAzzTs6lzyqieebb9tQxLxXzbHyMQd2NChyAZH00+cisbVwCeOec84EB/WU0A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=SpZO+Lc/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=SpZO+Lc/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXTh6xwVz2xMY
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:54:16 +1000 (AEST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-35d96be7c13so1889622a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393655; x=1775998455; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oG1BlwIWBanSrBSTwRxoxLhn0mTG5YlmPdthc1egVX8=;
        b=SpZO+Lc/W/xSB4AWOd2I13GgJVLeS1pXvT2OxhUTROcaU3+Ob/mZl3n66fiMZ/j5u/
         mI7vO+ST4LxNVVAFmRF4SVoxiDXEa6LABq8Ys/LtExpA2Xf2m5SkORwFSeqjRfSM6+DA
         uj3L2IUIBRg49XgqI7Z0A0F24soUHrp/Ch2QIuSy8C1LXskLJI9A9dCmf1p7eXVlUNH6
         ENR6wUPREf8cdyh1zGZ1y27ecSPMmgwyP+e5R/7hQUlUhypGYD2pf6w1Y+eikgQx9MAW
         BEMeDpTpyFNSkkqZoselAqavkcEW28tT3XfxOgs3CJ8hbdpeW7kKCBxDt0giF5nQcjTp
         YBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393655; x=1775998455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oG1BlwIWBanSrBSTwRxoxLhn0mTG5YlmPdthc1egVX8=;
        b=YSZsI/cgF+NfhCy9yhB3VzDwQAku/3ANiCXtohBWXIW/itgJK1b0SSxmA49QgqD32R
         XM13kFAjyKKi7PIPIckCNeEMY8FLG2L/IIYxweMRCn9w5qdQ+xun1w2xAi/t9RvJab2u
         fqAuTtEX4uxY799TJ6PAxrkn41MSOufBWSrLYXscwqGNfplJZSWX4kmRGQrGWTtFe6oT
         ENnOgqFZBLjIZhTsamV7lq0x+6MnlMhPpXPfnhemv4Hxr3Ha6wbmLoR1TqTJitTS13A9
         n2CWQBLCU69pdPw4ZC/hbjevdirbSFoMUSbHrvo6RccF/7AeWMjwPmxphGjBgOVhOvc6
         SFVw==
X-Forwarded-Encrypted: i=1; AJvYcCUmnZiqDgtr3sQMLjLdg5ZcOlCT+Pn0p8cv+eigzFEKgzv4iRcJ5eFJb721WTU71sQv5szAhJfrkF+sHmw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyet2YxTJ6Tg1Mo/kLcyR4I6JDS6dU8qNOTuFFCejTJ1s8bwxCp
	ufMv0KXP9BPf5ICWOK4PVA9o8OekwyazsI0d4edIIhVy7D8BI81HRDkF7+CyS+5yU4c=
X-Gm-Gg: AeBDieu0k23eaUrLtPQx9ae3BDYjI2n22af/izEwi73cM8nRkEyY6zUPMbnagD0LTcS
	41/M/JwDFNICFsG4S17VFNUsLt4CISrWQk+UzhkU0Y4fuWnQF3ScNDBejynkbZTg3QNWG37njo1
	m3qZvObePKwfpDVwU5RICDiTOIZxBlCDZHDK0/8oFaj3viP4oRS6g4bC8WW9Wpt+i+QoRHJ4esn
	PM+y5AtOAyZ8V2wORWdhH5rPOlvuDQLZ8aFZK0nKDGLo3tDNggXDCt7GgwPOLFhxo9Cu5G2azA+
	u0Gqwg6zD7w772hVpB5LiiD/rKC7XHf7yI8SICDUXMVZi8k/CddegcEXghwQmSey2sgzTLjuOO0
	tVrCxhOSuPLJrVvl8kkYpzGTiWUIpi3CZphUdNXLTTyYFNoCUPzHYTVT3H3fz2yR4FT4obVC2ME
	6PnBEAZso2y5cHi1htgLHOsDsGlhBKHpImwCycc50GXws=
X-Received: by 2002:a17:90b:52c7:b0:35b:a44f:b80 with SMTP id 98e67ed59e1d1-35de591e934mr6077709a91.1.1775393654892;
        Sun, 05 Apr 2026 05:54:14 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:54:14 -0700 (PDT)
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
	Chengkaitao <chengkaitao@kylinos.cn>
Subject: [PATCH 08/49] mm: Convert vmemmap_p?d_populate() to static functions
Date: Sun,  5 Apr 2026 20:51:59 +0800
Message-Id: <20260405125240.2558577-9-songmuchun@bytedance.com>
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

From: Chengkaitao <chengkaitao@kylinos.cn>

Since the vmemmap_p?d_populate functions are unused outside the mm
subsystem, we can remove their external declarations and convert
them to static functions.

Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>
---
 include/linux/mm.h  |  7 -------
 mm/sparse-vmemmap.c | 10 +++++-----
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index bebc5f892f81..aa8c05de7585 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4860,13 +4860,6 @@ unsigned long section_map_size(void);
 struct page * __populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
 		struct dev_pagemap *pgmap);
-pgd_t *vmemmap_pgd_populate(unsigned long addr, int node);
-p4d_t *vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node);
-pud_t *vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node);
-pmd_t *vmemmap_pmd_populate(pud_t *pud, unsigned long addr, int node);
-pte_t *vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
-			    struct vmem_altmap *altmap, unsigned long ptpfn,
-			    unsigned long flags);
 void *vmemmap_alloc_block(unsigned long size, int node);
 struct vmem_altmap;
 void *vmemmap_alloc_block_buf(unsigned long size, int node,
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index d3096de04cc6..0ee03db0b22f 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -151,7 +151,7 @@ void __meminit vmemmap_verify(pte_t *pte, int node,
 			start, end - 1);
 }
 
-pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
+static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
 				       struct vmem_altmap *altmap,
 				       unsigned long ptpfn, unsigned long flags)
 {
@@ -195,7 +195,7 @@ static void * __meminit vmemmap_alloc_block_zero(unsigned long size, int node)
 	return p;
 }
 
-pmd_t * __meminit vmemmap_pmd_populate(pud_t *pud, unsigned long addr, int node)
+static pmd_t * __meminit vmemmap_pmd_populate(pud_t *pud, unsigned long addr, int node)
 {
 	pmd_t *pmd = pmd_offset(pud, addr);
 	if (pmd_none(*pmd)) {
@@ -208,7 +208,7 @@ pmd_t * __meminit vmemmap_pmd_populate(pud_t *pud, unsigned long addr, int node)
 	return pmd;
 }
 
-pud_t * __meminit vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node)
+static pud_t * __meminit vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node)
 {
 	pud_t *pud = pud_offset(p4d, addr);
 	if (pud_none(*pud)) {
@@ -221,7 +221,7 @@ pud_t * __meminit vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node)
 	return pud;
 }
 
-p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node)
+static p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node)
 {
 	p4d_t *p4d = p4d_offset(pgd, addr);
 	if (p4d_none(*p4d)) {
@@ -234,7 +234,7 @@ p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node)
 	return p4d;
 }
 
-pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
+static pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
 {
 	pgd_t *pgd = pgd_offset_k(addr);
 	if (pgd_none(*pgd)) {
-- 
2.20.1


