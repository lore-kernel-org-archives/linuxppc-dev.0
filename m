Return-Path: <linuxppc-dev+bounces-28102-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DEAC98314
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 07:58:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hr5n271cwz3bYf;
	Thu, 24 Sep 2026 17:58:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790236710;
	cv=none; b=ItXnysQWsfvbw70NDMLbaOF3lGlPoexYtfWzDoPs8Y9fiNA9X9P5pTLCi5RXVbcMuoOmLLTOxznmkXipLVjIrrRmDjNbcvEHUF+uVgkvHK9yUsgyKvuj0rOQQM8JVfTR5MnMrVugid+jGTakY9F8+Nd+2H8FCN2Nbnk5drhp7X8TB0nLn5+LFdXahJeZ9gxNLdgwTi9Gg8z94ZTmwJZjb47HUJzF1BqdQ0diiFVID4gNqqjY4VhiA0sd+iBsmIBc87lH4U2/aRezF0ORhf2c1P6QrGNHJdDAO/JKvAZiWizuvo685Tsr5TWzfYpJw3gt8QqT7Aubnu49zbc69BwPIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790236710; c=relaxed/relaxed;
	bh=olGfWlX6xVbhFK+fX2D0BitKwIFHB7YuSmffyiYh0rE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mx2w6/juAYpsAY+jVQhEV0d/gt9rDZ5t2lfvRpOMfrkkU7HicbYyI7tcOEIvDIBbAf3+DWfpSKXHfAD7tMmgLNJddsYWM9SKNQq5ztancvyMZyp0vPsKfh46QPIaupgCzOstPqd06/IQkFbjY5LBcyc5JBLip7DEQYSztIsW9+0PuUWanyQSL9FQXRvb3YUoHZ4ytpXPjOHSAxjbDj5hgC+bS7m1kkaU22FZEYLFJqv1TMnNdUlnkl//cn69P6FYNfjTWcYL842rYnDxSxqhllllR/bRMoMp7ZVvepnz9X4aA8v91gM0fSjSfE6xOUYh8aHef5Ovrn6KhmavxFtapg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=T4ZBLP1M; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=T4ZBLP1M;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x11.google.com (mail-pj2-x11.google.com [IPv6:2607:f8b0:4864:39::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hr5n21rKYz30Tf
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 17:58:30 +1000 (AEST)
Received: by mail-pj2-x11.google.com with SMTP id 98e67ed59e1d1-396ccafb752so942533a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 00:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790236708; x=1790841508; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=olGfWlX6xVbhFK+fX2D0BitKwIFHB7YuSmffyiYh0rE=;
        b=T4ZBLP1MVaTvUYlXD042AB25FY1nTd2c2Z/jWbGt3staMfHBdbMnyC9UwvQ+S1BNwC
         pgVKjRvJgzmmP57JGoldS/+8qw59sdMf/nkFb1tvifouOd5iiWVbOe24jhzDNbPVrsXO
         VeQ1NTyeO4NPQxMIS8+bj/QJW7kubg+p88Dr8uzI0FNAg4MzsHxL8QLf19HQo/xBU2qQ
         0a/uCUXSKMLKzoDL+xyf0EfnBm3K3s6YqPoZPD59nsNS6qUQbOtVFrIBVPN2NWyC0nR6
         usLd+75bcmlENR4BdHUnEDxmo3E+a5HO9wJSii0biFf19RRKuDKUuNgUjxuW0Bj4gnic
         k0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790236708; x=1790841508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=olGfWlX6xVbhFK+fX2D0BitKwIFHB7YuSmffyiYh0rE=;
        b=J6E294wIkZAnpCU4jlj4BTq6/fDZTz+phw2KMYEdvHchDLvLSErLNxsOp6Est2TZ4b
         EQfVLqoNpqBycegfJzJWYOUrDEB79gN1jeSpJa2y1Wwcl1hg2aK+ES+SAUMtwGqZAtCM
         5nnz+jJA2da1bSrqn7985R36U7nKEi1ff4mOOF8kMu87vNb2H011Z/NxwLrUnyqXp8rY
         kj2bEu9eEqJPFN6QlBQi54/G1AO7XQii0OEOfFomJvGFRn8p8EKNWpMbmBHelh+g4Xoc
         jgXMH0SJfwEWOpO38fudgeKctG2KyoFyuewdmvvE36PvAmHyuZ+pr5NASEQhzKeYjOhh
         x83Q==
X-Forwarded-Encrypted: i=1; AKwUvBx18MtD1zME0p7l1YCilio/LGGIk8VbBENPTuYMpk3D+1tHKaTo12FRAV9wN24vT8nKBK/7uSCsD9ZJMIg=@lists.ozlabs.org
X-Gm-Message-State: AFuF++muFFprMQGZTD0LQIJS4Rr17fX03A1YbiDwsXFBfb6RvXfpV+id
	ZIqVqf+H8RY3Ai85tEeG7Kb/YjntjnYXpcVtlPOQWDe/LAgSGROwcbWcsxyDrDkSe0c=
X-Gm-Gg: AYBFou3G1gD0u/Z4jjqcL/q3Lh/PV0kF18M3XDVw3DRmYLWYKRSSKR2BuqWjfEWMAJ0
	4CTn4vFgX3C4hI8MbHg5VR9nK2b4Q6WWZ/LWIqIhEzsFpkt0vBtEFuF7r6u24kprRC1Mh0YVBYh
	Gi/aCSxoL8jjHsfrbq2qzjydOke8MSh92mOvxF+gb6cVmjeEcJ5wtqiQeFvUnfdFbU2o5N+pH4j
	5mFn2Woyii7UkL5J3uP93Go4qcR7JxjVpMdAL2orD3UuUM1K77NJl8TrLsWWSUSJKT3BtzgcfCb
	aDWH76Ui2ih989JXsv592KbCWN38e074Bc39+xqQKPZM+2a/3ZVQygFq+cfcONSFv0kdpKZHgXf
	C16MiR0o21pkO7eXodXvS+sOAkaua8UrNzch7eAp4okoySJq+66iK5YOEyeuJ3bG2dWJxwPYkfr
	l2iSGc58huJDwmiCVDO04pc+IGF6i1QtlJ8bSz/5KuvjpDcwHw1MBgrAwDrVWoOSC72rRk9zMPp
	pQErWSFAPjErbpsLqU=
X-Received: by 2002:a17:90a:2ce6:b0:3a0:a055:1741 with SMTP id 98e67ed59e1d1-3a0a0552127mr324523a91.27.1790236708461;
        Thu, 24 Sep 2026 00:58:28 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0972eec92sm3575622a91.7.2026.09.24.00.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:58:28 -0700 (PDT)
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
Subject: [PATCH v2 5/6] mm/sparse-vmemmap: open-code vmemmap_populate_address()
Date: Thu, 24 Sep 2026 15:52:58 +0800
Message-ID: <20260924075259.2013039-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260924075259.2013039-1-songmuchun@bytedance.com>
References: <20260924075259.2013039-1-songmuchun@bytedance.com>
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
Acked-by: Qi Zheng <qi.zheng@linux.dev>
---
v2:
- Collect Acked-by from Qi Zheng
---
 mm/sparse-vmemmap.c | 54 ++++++++++++++-------------------------------
 1 file changed, 17 insertions(+), 37 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index a5b47e496322..f5364c1cafe5 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -315,8 +315,8 @@ static pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
 	return pgd;
 }
 
-static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
-						  struct vmem_altmap *altmap)
+int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
+					 int node, struct vmem_altmap *altmap)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -324,48 +324,28 @@ static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
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


