Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC9F606A327
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 11:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QJo5w1j0
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZvDR5dfhz3bdD;
	Thu, 26 Nov 2026 22:18:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795691895;
	cv=none; b=VqRpUfbEVwVKiPQ0gt0hh+Ib2Cvr6OhgbgKTRCC9tRkgAzz4hkW/T7LxKngC9qoCua4o9ChhDYSUbxzS7lXQnLJw5VzyVm6V+tF1x8MnxfrFxTkZ0/LyxLBPxpM13USJQBdowyKftBYe1eosx0SO6S65CrDutom4vJ4MQJRD3QUX7v5E5+INzZ8LPGfGsftfl73wdscegtHxCQ0ZqEZG6RHENj4PVikCRQ7WJr3nONaz+ogJXP4ueu0IZf7yG86tzrsU3yy/4tT3KczI3kMelusIWdyptJAkd1kN8dZ4vjm6W4TB2tLqAqbXneOpEl/XUzo9aQ9DlbUxEbw349q22w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795691895; c=relaxed/relaxed;
	bh=nfYyn85pUjMYKHSpG7Nmwds+Fo4pM3ejdYfJznX5ccQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gNyzRhj/qewiYuLYN4hfzizQxud3dfqdsUN3sF5oKEzVPrdnDeEwLjOchykwmb2LmJXUwj9GYbKbeZo/4TkhQsDphSKBlq6rzXH/M5MjNH6kFPLvrn+k8Wx2NiYYAvOvQdS/KA0afEnTFRMTMbZGsfxWSDC2EfSdWHu01MQEw7rL+Pw/sLko5+yqS+ZDMrnOBM6hz6oOYiocNdzva08Jo6BoCkw6+jOtvmWYdXPqPSQ4L3sYajXrRUz7wpfyQwqnaMGNt1nojh2zCNg+L6THJubc0Ei5BrquN3/yaSfWxR3YGGW9K1IsQw332366zpyJVlMvi32xbF4WXyfCm7Dn9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QJo5w1j0; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QJo5w1j0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZvDQ6rFTz3bcj
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 22:18:14 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F26CB419AF;
	Thu, 26 Nov 2026 11:18:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42AE21F000EB;
	Thu, 26 Nov 2026 11:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691892;
	bh=nfYyn85pUjMYKHSpG7Nmwds+Fo4pM3ejdYfJznX5ccQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QJo5w1j0YNGG/MVA+7N155ZqRi61HNhq+idbAR7dzgepcTaSSSN+xAPQr/B4U+LMp
	 BLLyXQGrlkuNmkAqtR7dz8Vof5IMsXtBsjhDvz09x6vkSHb44KisyiT2zc91b6fKiF
	 epVtUi6raw9GLDuK3tUSzLuNl8A3gKsBJnlMXAnCd5iSLbGjpGFwIfl2Mdc53Fho3V
	 0IC1AcfgPDA4Pw6cojyD+hOhrBG/fRcdxuqntusHbWpnhLYrajjU5tuNGDAfZv1Wgl
	 TYwLJc1rd7vxclPEfcAiKd46fTu/XAJzcoKbGilWnJ5MpVt4qvcl71XSrrSDsRt/Rs
	 5JDZxjrcdb/1g==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:36 +0200
Subject: [PATCH RFC v2 23/54] x86/mm/pat: allocate the page tables for a
 split by level
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-generic-set-memory-v0-1-v2-23-723f1e33c3d8@kernel.org>
References: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
In-Reply-To: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
To: linux-mm@kvack.org
Cc: =?utf-8?q?Adrian_Barna=C5=9B?= <abarnas@google.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Borislav Petkov <bp@alien8.de>, Brendan Jackman <brendan.jackman@linux.dev>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 David Hildenbrand <david@kernel.org>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Ingo Molnar <mingo@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, Michal Hocko <mhocko@suse.com>, 
 Mike Rapoport <rppt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Paul Walmsley <pjw@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Russell King <linux@armlinux.org.uk>, 
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, x86@kernel.org
X-Mailer: b4 0.16.1-dev
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

split_large_page() allocates the page table for a split with
pte_alloc_one_kernel() regardless of the level it splits. A PMD table that
replaces a PUD is allocated and announced to paravirt as a PTE table.

While in practice this only matters for the accounting of page table pages,
having proper allocation helpers not only makes that accounting right but
will allow architectures to override page table allocation methods when
core CPA logic moves to the generic code.

Add helpers to allocate and free page tables with the appropriate function:
pte_alloc_one_kernel() for a table that replaces PMD and pmd_alloc_one()
for a table that replaces PUD.

Use paravirt_alloc_pmd() to notify PV guests about the new page table that
replaces a PUD.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/mm/pat/set_memory.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index cb503e41340b..0a2d19064f23 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1215,7 +1215,10 @@ __split_large_page(struct cpa_data *cpa, struct cpa_leaf *leaf, pte_t *pbase)
 	if (level != PGTABLE_LEVEL_PMD && level != PGTABLE_LEVEL_PUD)
 		return -EINVAL;
 
-	paravirt_alloc_pte(&init_mm, page_to_pfn(base));
+	if (level == PGTABLE_LEVEL_PMD)
+		paravirt_alloc_pte(&init_mm, page_to_pfn(base));
+	else
+		paravirt_alloc_pmd(&init_mm, page_to_pfn(base));
 
 	pfninc = pgtable_level_size(level - 1) >> PAGE_SHIFT;
 	for (i = 0; i < PTRS_PER_PTE; i++, pfn += pfninc)
@@ -1257,18 +1260,34 @@ __split_large_page(struct cpa_data *cpa, struct cpa_leaf *leaf, pte_t *pbase)
 	return 0;
 }
 
+static void *cpa_alloc_pgtable(struct cpa_leaf *leaf)
+{
+	if (leaf->level == PGTABLE_LEVEL_PMD)
+		return pte_alloc_one_kernel(&init_mm);
+
+	return pmd_alloc_one(&init_mm, leaf->addr);
+}
+
+static void cpa_free_pgtable(struct cpa_leaf *leaf, void *table)
+{
+	if (leaf->level == PGTABLE_LEVEL_PMD)
+		pte_free_kernel(&init_mm, table);
+	else
+		pmd_free(&init_mm, table);
+}
+
 static int split_large_page(struct cpa_data *cpa, struct cpa_leaf *leaf)
 {
 	unsigned long address = __cpa_addr(cpa, cpa->curpage);
 	pte_t *kpte = leaf->kpte;
 	struct cpa_leaf tmp;
-	pte_t *pte;
+	void *table;
 	int ret = 0;
 
 	spin_unlock(&cpa_lock);
-	pte = pte_alloc_one_kernel(&init_mm);
+	table = cpa_alloc_pgtable(leaf);
 	spin_lock(&cpa_lock);
-	if (!pte)
+	if (!table)
 		return -ENOMEM;
 
 	/*
@@ -1279,14 +1298,14 @@ static int split_large_page(struct cpa_data *cpa, struct cpa_leaf *leaf)
 		goto out;
 	*leaf = tmp;
 
-	ret = __split_large_page(cpa, leaf, pte);
+	ret = __split_large_page(cpa, leaf, table);
 	if (ret)
 		goto out;
 
 	return 0;
 
 out:
-	pte_free_kernel(&init_mm, pte);
+	cpa_free_pgtable(leaf, table);
 	return ret;
 }
 

-- 
2.53.0


