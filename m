Return-Path: <linuxppc-dev+bounces-27191-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE79C88E56
	for <linuxppc-dev@archiver.kernel.org>; Sun, 13 Sep 2026 08:41:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hjMFS0VnFz30Pp;
	Sun, 13 Sep 2026 18:41:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789288876;
	cv=none; b=kPqJUMQuGYXdhsh+rYWXakHBtR8AW9FgjaH1yK/d/prjpR9vKjg2jJD/0zGHQaGGVX5B89h4P9srOk2+8teKtlUsoQcNcPqXt8gQOb+VZsSvupZ385NjXuVdWVEm1PojCEX8LA25bwFzxay0kVkMkKMbWA47qbFkJnOTwDRWKeJ/DKpc99qk0HbYntyesN7qAJDsCAOJqTb7+Q1i3ERoTXkjgZ+xlH48PhX7h76jOucF5e7wHP/9oRHzwzym7+mvlyosB7eU8XGLZqvkJD96aBpERnHh0CZ/BuCZWaZc9gEgpsRiMm+dV1BP52lTMbjz7KfkKGdWFpslMJPHdh0/ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789288876; c=relaxed/relaxed;
	bh=jabfOFZH7nclzlLV4JN+2R4So1RYw+NkC6onyGlhulM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QvQyNu4/phqjiwIRNOj7NuqBqR/eABJMMUeqOtMyW0hz60wZBGXvNZiyf6nAz+GCbKDzt2haVmd1Z6XQiY5vtwXVwiD1NoA0DZs3/AqopeYIfWk9cE21o05FjfxmivIF7Wun6EKxZUjc7B8eA7kGyMrRiRDd3i8f93cYbRYbjZhX671bYh/m4AxwPmmgrevJ8WLLgLp4ehWsD6FsSD9tkpGMmrK2h5sYVqeVbrqV7lG9+ub6pk06TyDwtTGQj663pSUq3Xt7ltL4rO0NhxDHablrGwvrf3eKDiWQeqjEuyqg+oUfmfBHRdGiUZ40EqU8CKQ1s7JbpGKS1IVwBsAd3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=LbcWBRUS; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::f; helo=mail-pz2-x0f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=LbcWBRUS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:3b::f; helo=mail-pz2-x0f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x0f.google.com (mail-pz2-x0f.google.com [IPv6:2607:f8b0:4864:3b::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hjMFR27Fmz2xkr
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Sep 2026 18:41:15 +1000 (AEST)
Received: by mail-pz2-x0f.google.com with SMTP id d2e1a72fcca58-86b90133ae8so851498b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Sep 2026 01:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789288873; x=1789893673; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jabfOFZH7nclzlLV4JN+2R4So1RYw+NkC6onyGlhulM=;
        b=LbcWBRUSE+lqefKMgiNXaiIye5wKIIEbRUtyfT/IA72A+N+o5ChOqobYuWZUZyO+zg
         4rB7LgogmHP8JSRlz/pyCtt0ASuCGLcMytEXlWhtn4hlaqBBOkC0psVvz3WJMBAR0ez+
         2uvapnfKu0TqSPWwQthaMcqE46hKqJsPOSqQvp5agTJTkXANRvC0NNQPih6exDad/6Ed
         cI1qf1aTmcTF0wRjfYwCKLVbrswDqgepunQelwSDGvJBvwrFkA40cyANe0HzxbUP35Y5
         gw0aWLERfvRDi+EUViG+c46+yX4/32FLfUGje8thIdd9O0/RkI3Yk8MdwqG7hkZRX8HC
         XLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789288873; x=1789893673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jabfOFZH7nclzlLV4JN+2R4So1RYw+NkC6onyGlhulM=;
        b=Ia32SsDFd68B9J/6hKUtJ6K9ksMo8JCMxWIqLjKY4ebn+XYwXO99oTWHTh+3nGlQEm
         VeYbPH5gt1hukGN1IrmkHlUl5gbhrFPzkpaNSo+TPzyaJEBArJGMrw/bJ6lPG4wZmz1s
         jhfK9w7vkA/lcU2Vra18xGzcoiqu7IFgnq9bvRRzxfpFe7zwD6uRWvk8YpOd52g9mzqd
         YtfIDGGeXbdY8B2+XL2wLHP5CTpiYFrJsPFPSk1tA55Bq7US7obhnyBV2X8TysKnX3on
         CVdYj7NAR2dlSzPwKQxXahkhP82MDIlEVgwAsHt8qRp11XinjU9RqwJdu/PBMlhiW7pu
         SwZQ==
X-Forwarded-Encrypted: i=1; AKwUvBy+D1ZBsb94L4iMwn68R6kmCR3R62ZRiWTa+A4KA2lSBvOOJoW3C3tCmC5MWDOVhalPRL7VaOxi8Qe9ojc=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kRPdZPqP8v/VxQk0l/+un6Mgsq/BCmjhNbs+OPLitW9h3g7eC0
	hBI8gx3rwGCh2GtZfhjdsarUPM0py/LcQO1k8kVH8FkicftN3OCjq130Uhl7+a852a4=
X-Gm-Gg: AYBFou03d0nxb2z40N+CCWTPyEY/Pfui2QaC+T5tj7wG1x2NAYPD/w1S9yW7IaVADhW
	IL42KaLYAtVD4aAc+2WhJjELcw5MIvvlNXKzuc20vP5uB2lG1iGf7od9hTnLyCypT/mmNG3b5KI
	O4anJMI/m9vUIKntHaB+ZQc+ZSesuO5s00QK4xyzuLdb3PBv6qFlkeZGACs2thHPx7RhR8nleDR
	A5EBdTJmRTU4d+VMajU0ku8nW1BRD3j1ICCJDYi7H0dGtmgjClT8y3deJZtoCJwyVsCYLmQFi8f
	dj6oeEyHgSR9hucfD1liYKmryHUjzpK3L5hsPxESbuI0zgPEFu3Ju33XYooDio16MpoGyqA9pvu
	hII1K2cDTAXMiNUHdQqi9Qo1AI0O3MiDKrPgduxXdu56gb0ZH3vxl326OV7/3Imeb/NquG6ONsb
	v8nv5eAqgsvq5kFySjaPCy4M2Ey+nsMN8xgh5iL2qm45+rXo22RP3P81GXZSc9acQ+7FHxK+dZe
	0952wa+66IXm1/BEU0MkA262oU=
X-Received: by 2002:a05:6a00:c1c6:20b0:86c:52fd:fbdf with SMTP id d2e1a72fcca58-86c52fe0a64mr9440575b3a.20.1789288873401;
        Sun, 13 Sep 2026 01:41:13 -0700 (PDT)
Received: from G6L4RL2QG9 ([2409:8a00:1832:cf0:5137:990:100e:cc7e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b29cbb0d3sm3070531b3a.42.2026.09.13.01.41.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 13 Sep 2026 01:41:12 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Muchun Song <songmuchun@bytedance.com>,
	muchun.song@linux.dev
Subject: [PATCH 6/6] mm/sparse-vmemmap: open-code vmemmap_populate_address()
Date: Sun, 13 Sep 2026 16:37:34 +0800
Message-ID: <20260913083734.86802-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260913083734.86802-1-songmuchun@bytedance.com>
References: <20260913083734.86802-1-songmuchun@bytedance.com>
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

vmemmap_populate_address() no longer has any callers that need the
returned PTE.  Its only remaining user, vmemmap_populate_range(), only
checks whether population succeeded.

Open-code vmemmap_populate_address() directly in
vmemmap_populate_basepages(), remove the now-redundant range helper,
and return -ENOMEM directly on failure.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/sparse-vmemmap.c | 54 ++++++++++++++-------------------------------
 1 file changed, 17 insertions(+), 37 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 8b4904d9c65e..5e0e30c77431 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -303,8 +303,8 @@ static pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
 	return pgd;
 }
 
-static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
-						  struct vmem_altmap *altmap)
+int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
+					 int node, struct vmem_altmap *altmap)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -312,48 +312,28 @@ static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
 	pmd_t *pmd;
 	pte_t *pte;
 
-	pgd = vmemmap_pgd_populate(addr, node);
-	if (!pgd)
-		return NULL;
-	p4d = vmemmap_p4d_populate(pgd, addr, node);
-	if (!p4d)
-		return NULL;
-	pud = vmemmap_pud_populate(p4d, addr, node);
-	if (!pud)
-		return NULL;
-	pmd = vmemmap_pmd_populate(pud, addr, node);
-	if (!pmd)
-		return NULL;
-	pte = vmemmap_pte_populate(pmd, addr, node, altmap);
-	if (!pte)
-		return NULL;
-	vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
-
-	return pte;
-}
-
-static int __meminit vmemmap_populate_range(unsigned long start,
-					    unsigned long end, int node,
-					    struct vmem_altmap *altmap)
-{
-	unsigned long addr = start;
-	pte_t *pte;
-
-	for (; addr < end; addr += PAGE_SIZE) {
-		pte = vmemmap_populate_address(addr, node, altmap);
+	for (unsigned long addr = start; addr < end; addr += PAGE_SIZE) {
+		pgd = vmemmap_pgd_populate(addr, node);
+		if (!pgd)
+			return -ENOMEM;
+		p4d = vmemmap_p4d_populate(pgd, addr, node);
+		if (!p4d)
+			return -ENOMEM;
+		pud = vmemmap_pud_populate(p4d, addr, node);
+		if (!pud)
+			return -ENOMEM;
+		pmd = vmemmap_pmd_populate(pud, addr, node);
+		if (!pmd)
+			return -ENOMEM;
+		pte = vmemmap_pte_populate(pmd, addr, node, altmap);
 		if (!pte)
 			return -ENOMEM;
+		vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
 	}
 
 	return 0;
 }
 
-int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
-					 int node, struct vmem_altmap *altmap)
-{
-	return vmemmap_populate_range(start, end, node, altmap);
-}
-
 /*
  * Write protect the mirrored tail page structs for HVO. This will be
  * called from the hugetlb code when gathering and initializing the
-- 
2.54.0


