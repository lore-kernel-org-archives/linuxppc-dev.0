Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EE0606A682
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 11:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dcA/LQZJ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZvDc4CbDz2ySV;
	Thu, 26 Nov 2026 22:18:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795691904;
	cv=none; b=jxfUQVojnslOXJLhmyEqBqYOJMvo/JRorrSeb3h+4G2ijqfy4a4W+VNJsyy6NH1lL7WkL3AWKd7rB0MUtOesTV1LgGu82WIuWXqRIsdHeiFwwM+eh1JHW9wiEBjlOaESv1QK3rIUJRoNWsaQ98tW5MUkhTgwSL+gk0hSVpfSK2vPHQNgySEupfZegJEV73T4Q9ttcTqkMTk1k4+4K2E69Ia9IjBoRcSvFIa7R3tLUSCR058nP0dPfmDARdup6xZZ+dpvCyDgSvidDpGercxe6Yv4F2VmmKTy3YZ4Kpie0t3owk/t7LMxqvjoFb647s/H+3bq7CSGGtHoDmL2sxsLLg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795691904; c=relaxed/relaxed;
	bh=ZILZfKisda6VydMd2eX+gp7jxSdYsZR8fHOcYz6Cqew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B+h9ckd7mQQkRX+Z1fRLBZt6j8Z19FyixvbPRuhyhh9qOlS+ZXhtxgMG6DsTJn7giKppV805u+5DVhVw22Ydq8bswCRQQSet5SbNzNM5JAC5s2T1YKFb/b+wxjBowchnAJ6W+9YlYaSV3SXlbe542MrpLxXZaHeNts8rQGRKQ8GdSsU5xlxfoEoGpxP7DlLSPqVdz1S1MeRLIByXnB0XEBtRldBiq22QbWz08IrbnOlHkOvEkF6VxYLk8prvblP3zRKNrujAFrOiXQ2QfsuTHibibfPFMRjvuRgRq9imuXnXC28r2IQg5PdpBIwZGSBi899kZNaWKC3EIwxgWJJADA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dcA/LQZJ; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dcA/LQZJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZvDb52Ylz2yS0
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 22:18:23 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2FB18433ED;
	Thu, 26 Nov 2026 11:18:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612A11F000EB;
	Thu, 26 Nov 2026 11:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691901;
	bh=ZILZfKisda6VydMd2eX+gp7jxSdYsZR8fHOcYz6Cqew=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dcA/LQZJNTRxAXYiSO3ecetRk8UeUJ6G6eowyblPb3SceghWJPlB47dy81dO3ekpo
	 8zDVpbCPPwxS+gP2aWUtngwOLnVGrkWp3lbRZc00nMGGvENyrC+LUZsSkDTGn2a/Df
	 Ykat0AJi7F5ysyrmoP735e9b3JtJOJkyBZb/r31kMWVXdrscOhgdsETzfdXnYLy3Oa
	 9MLDBL0FuPwbh5GLhPshgP2x2ZO3LV6BIDUNOwy6XdbqpNWoRFGlguk+SsxHNgl76s
	 ing/lUECgznOONlhV/K97ITTVUhM1RAQes1Mo/It0ScWnHTtRza5jJ7IGIDCXcwDNm
	 NDSCBoaFdVjlw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:37 +0200
Subject: [PATCH RFC v2 24/54] x86/mm/pat: detect unchanged mappings by
 comparing protections
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
Message-Id: <20261126-generic-set-memory-v0-1-v2-24-723f1e33c3d8@kernel.org>
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

CPA decides whether a mapping changes by encoding the new page table entry
and comparing it with the existing one.

It would be suboptimal to encode actual entries in the generic code for
every comparison of the existing, requested and new protections, as every
architecture would need one more out-of-line hook for it.

cpa_leaf by definition has the decoded protection which can be used in
comparisons.

Compare the new protection with the decoded one and encode only the page
table entries that are written, as the last step.

Encoding masks out the bits the CPU does not support and _PAGE_GLOBAL bit
of a non-present entry, comparing protections does not. set_memory_global()
on a CPU without PGE or on a non-present page now rewrites the PTEs with
the same value and flushes the TLB. Its only caller changes the kernel
text, which is always present, once at boot.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/mm/pat/set_memory.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 0a2d19064f23..f4d3e2d9c3c9 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1917,26 +1917,18 @@ static int __change_page_attr(struct cpa_data *cpa)
 		return __cpa_process_fault(cpa, address);
 
 	if (leaf.level == PGTABLE_LEVEL_PTE) {
-		pte_t old_pte = *leaf.kpte;
 		pgprot_t new_prot;
 		unsigned long pfn = leaf.pfn;
-		pte_t new_pte;
 
 		cpa_inc_pte_install();
 		new_prot = cpa_new_prot(cpa, &leaf);
-
-		/*
-		 * We need to keep the pfn from the existing PTE,
-		 * after all we're only going to change its attributes
-		 * not the memory it points to
-		 */
-		new_pte = cpa_pte(leaf.level, pfn, new_prot);
 		cpa->pfn = pfn;
 		/*
 		 * Do we really change anything ?
 		 */
-		if (pte_val(old_pte) != pte_val(new_pte)) {
-			set_pte_atomic(leaf.kpte, new_pte);
+		if (pgprot_val(new_prot) != pgprot_val(leaf.prot)) {
+			set_pte_atomic(leaf.kpte,
+				       cpa_pte(leaf.level, pfn, new_prot));
 			cpa->state |= CPA_ST_FLUSHTLB;
 		}
 		cpa->numpages = 1;

-- 
2.53.0


