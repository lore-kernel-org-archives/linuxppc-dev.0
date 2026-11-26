Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6078A606A686
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 11:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U1VVpJka
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZvDp0qzMz3bf8;
	Thu, 26 Nov 2026 22:18:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795691914;
	cv=none; b=N/cug2oTP/MBugrF7ejBp8ToEkh+WZtrUYFatm2+Aw1MLQLm5R4BPi3dxhfy/eXOY+z7kF+7tVlQWntY9EOeqR56ezTXqaZVXOtMuZ0tSTmAz1+3K1GI2H+NpGCfOkGgvuYk9qK0HXDLjVDVSJzNtl2UjpvusV/1nVuHN+HOsCNQf2x1ngOf7TyEIzFW6otl0ydV3Nx1zSQwLQUA8zFIQYzyt0Ef5Wnx/cO6mtHhD26QpTaJxIf6vHSOGkrKJ/GhUp6MiJ2oA2gBLoqfOASjeV5N8sA81cmG6O/L4ATl36KYiJSVu0mFIa42TjlRTipQ4q4eFXcZtObLhhYUOO1omw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795691914; c=relaxed/relaxed;
	bh=kg22a2UjYNlx3KcEJrs5W+VCDk/0O6wvkANb+XJaCbg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aVaS8EGZwT0to9Shq4lOYMBDEQOEDNIm15Z/ZhyEmQp0X2MwRx9BTXo9/l4cXygv1LStIoD+XLpkaFJrx4bkGHb/iglSOTL8q2C9Q/Qn8kIZw1mFuWrLGdPwUfJpHAukevASLCyqmLuse7qXEioTGVOnBQMWi9+/lP6NoQVBzS2y1dO/ifEsrgcjy73RaqIDPtqXpYjZrX/ub6qR7xx9IRvlwo0dHAm7YBOBifa3wENe+nbH7fkc0a3ra0SNkyezdzhD7vl9B2grPuY2362BNAtU5f3e9Pb7TxnZITZoq0aAx0bq2ZSnEUxuEXzRGlg6YYgDu6Hmx4H/Rh8G04iOcQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U1VVpJka; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U1VVpJka;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZvDn2MZ0z3bf3
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 22:18:33 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 65EF760D55;
	Thu, 26 Nov 2026 11:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91CEE1F000C6;
	Thu, 26 Nov 2026 11:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691911;
	bh=kg22a2UjYNlx3KcEJrs5W+VCDk/0O6wvkANb+XJaCbg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=U1VVpJka7QLxUE4YaYREp3+OZWOG8ko4HiNqynewu4AeFyUfHQhn7brmfvorU4jMj
	 o0uUS0QKMHz7GfMKQUvJ//XlEAtzumhJGgjIerOXA4rAWfrjf94Lowsrzo2OyspNRk
	 DVyvxbUGMXY0K3/SOKAXMB1cBBC2Z/1CexvNi+4DB8g4a3/OjW2gS8R85cVmvy+69O
	 qZUhYEGVTvL2AxEnooJqUb6ERwdNe/eEjnNDxMWp5QYBqFBgbBXumoo1jNxHCpRuXl
	 WfdpzZtlXFLcqOaW/kvqMfWLQkJEJileeskY9GGqfARZEurJKKDSbEPqrmKJnQ8b4h
	 uPm1ZG1WRQisA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:38 +0200
Subject: [PATCH RFC v2 25/54] x86/mm/pat: add cpa_is_direct_map()
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
Message-Id: <20261126-generic-set-memory-v0-1-v2-25-723f1e33c3d8@kernel.org>
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

CPA open codes the direct map range check in five places, and the generic
CPA core will need the same check.

Move the check to cpa_is_direct_map().

No functional change.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/mm/pat/set_memory.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index f4d3e2d9c3c9..cbbc51be4de7 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -245,6 +245,12 @@ within(unsigned long addr, unsigned long start, unsigned long end)
 	return addr >= start && addr < end;
 }
 
+static inline bool cpa_is_direct_map(unsigned long addr)
+{
+	return within(addr, PAGE_OFFSET,
+		      PAGE_OFFSET + (max_pfn_mapped << PAGE_SHIFT));
+}
+
 #ifdef CONFIG_X86_64
 
 static inline int
@@ -1224,8 +1230,7 @@ __split_large_page(struct cpa_data *cpa, struct cpa_leaf *leaf, pte_t *pbase)
 	for (i = 0; i < PTRS_PER_PTE; i++, pfn += pfninc)
 		set_pte(pbase + i, cpa_pte(level - 1, pfn, prot));
 
-	if (within(address, PAGE_OFFSET,
-		   PAGE_OFFSET + (max_pfn_mapped << PAGE_SHIFT)))
+	if (cpa_is_direct_map(address))
 		split_page_count(level);
 
 	/*
@@ -1375,8 +1380,7 @@ static int collapse_pmd_page(pmd_t *pmd, unsigned long addr,
 		}
 	}
 
-	if (within(addr, PAGE_OFFSET,
-		   PAGE_OFFSET + (max_pfn_mapped << PAGE_SHIFT)))
+	if (cpa_is_direct_map(addr))
 		collapse_page_count(PGTABLE_LEVEL_PMD);
 
 	return 1;
@@ -1423,8 +1427,7 @@ static int collapse_pud_page(pud_t *pud, unsigned long addr,
 	list_add(&page_ptdesc(pud_page(*pud))->pt_list, pgtables);
 	set_pud(pud, pfn_pud(pfn, pmd_pgprot(first)));
 
-	if (within(addr, PAGE_OFFSET,
-		   PAGE_OFFSET + (max_pfn_mapped << PAGE_SHIFT)))
+	if (cpa_is_direct_map(addr))
 		collapse_page_count(PGTABLE_LEVEL_PUD);
 
 	return 1;
@@ -1887,8 +1890,7 @@ static int __cpa_process_fault(struct cpa_data *cpa, unsigned long vaddr)
 	 * one virtual address page and its pfn. TBD: numpages can be set based
 	 * on the initial value and the level returned by lookup_address().
 	 */
-	if (within(vaddr, PAGE_OFFSET,
-		   PAGE_OFFSET + (max_pfn_mapped << PAGE_SHIFT))) {
+	if (cpa_is_direct_map(vaddr)) {
 		cpa->numpages = 1;
 		cpa->pfn = __pa(vaddr) >> PAGE_SHIFT;
 		return 0;
@@ -1977,8 +1979,7 @@ static int cpa_process_alias(struct cpa_data *cpa)
 	 * mapping already:
 	 */
 	vaddr = __cpa_addr(cpa, cpa->curpage);
-	if (!(within(vaddr, PAGE_OFFSET,
-		    PAGE_OFFSET + (max_pfn_mapped << PAGE_SHIFT)))) {
+	if (!cpa_is_direct_map(vaddr)) {
 
 		alias_cpa = *cpa;
 		alias_cpa.addr = (unsigned long)__va(cpa->pfn << PAGE_SHIFT);

-- 
2.53.0


