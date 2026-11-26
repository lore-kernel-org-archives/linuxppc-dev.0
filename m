Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC94606A32E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 11:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lsZvT1vj
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZvCW4wFfz2yQl;
	Thu, 26 Nov 2026 22:17:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795691847;
	cv=none; b=g9/o99rNHNOeA3L64BIFKSvinxj2CFcxb5IriWOuF0yWkUcM1n4rLIZ/jkmcnjoful/JgFpr6g+sx1kigtgHBkxysPGktAJ6f6ZLos6JxQoVIg/oGDGGcI23mFp5Wmn4V5rFEjU3j9eE8lPFQq8vnD4JtOFZvJ6uiU2vvljCTLHUsN4cXAWvjpaOlAs6CKuvEZrV6cu6VfDA/ioZxe+YckmMo9cqYwlIrGNWlThZwAsj0KZqYxmp4kxvMxRbZTzavT4iC0CUUI9Rum6j8bPyhz8zJEOmdPG00xZpbUCywy+VoiE6JcxGOISN06IoeSlwed6CAlJqV38hE/V5UBqfqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795691847; c=relaxed/relaxed;
	bh=5DoNm9BxMiCQEr+qNjgywS01tQK5uUyYap8n/VDfFq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C6uRbka3dVWPSnBiaNqzPZxj7xI4E1sJI4lzOFrkcgTA4wANW7WTd/PlEdtbooYT/oqs1gVXnzePEHtxd6MuYyFz2E3fQ+8vZssbeR0c0ugbIQbVnoQ2qpQcZgYbEf3y13t2UUy9NhQKAF0YHa6Q3RLOYNIlWNEZ2yLL1P8cP8zyF+NpbPZ12THH4snCMI+QntFnM+aXTVDp+xxjU77afV7Nk4Ck/luQ+rflvgp5pSrdHsFhFMjsu5wzYwmaMgE2eLM/nEJNO/cpR/ny56DcsIFFE2vSTc/CvXtTmk3R4MSd4aLdc+B/s7F7TO/NV+r/eDwgaIEtv9DWSeRX3nTHhw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lsZvT1vj; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lsZvT1vj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZvCV6Y9Dz2xWt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 22:17:26 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3A36544EC5;
	Thu, 26 Nov 2026 11:17:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8265A1F0093C;
	Thu, 26 Nov 2026 11:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691845;
	bh=5DoNm9BxMiCQEr+qNjgywS01tQK5uUyYap8n/VDfFq4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lsZvT1vjJ/BY9sTlQOvZYhVIq610w41r/GrWTSFBkc8Hn5MspOrOjbMVeN6Z5g9Ps
	 StHuwLpwVe1sqViKqK5rwJvNfsab4i10QpGgmoWRUpvZ0ZdHh5p1zC+DlzyDW7jJFh
	 ycSAiUPw9f4VQjltnizOeWzjcQXBt34T2JUF/n+LTCgxTcP0b675rE/QXn++VbbyjH
	 mEyk5cjy5y35X01PvcgUdscO++kGzHYNfut/I2oC/MOGODBPn4Q9CesZac+BwKrTdi
	 yWNv9RL/tL0sHZkybp6sfBNB3+3kHeVZI0f7IB75hUGO43/nFfIIyo5KtVdXHjoTT/
	 Gv8qIAENkH/7g==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:31 +0200
Subject: [PATCH RFC v2 18/54] x86/mm/pat: consolidate encoding of page
 table entries
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
Message-Id: <20261126-generic-set-memory-v0-1-v2-18-723f1e33c3d8@kernel.org>
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

CPA encodes page table entries in three places: when it writes a PTE, when
it updates a large page it keeps and when it splits a large page.

Each place converts between the PTE and the large page formats and fixes up
PSE and PROTNONE.

The split of a PUD does it differently from the split of a PMD.

Add cpa_pte() that encodes an entry for a page table level and use it
everywhere.

The check for an unchanged large page no longer clears _PAGE_GLOBAL when
_PAGE_PRESENT is clear, so set_memory_global() on a non-present large page
rewrites or splits it, although nothing changes. Its only caller changes
the kernel text, which is always present.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/mm/pat/set_memory.c | 48 +++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 9ccc08cf220f..068ab1e2bbc8 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -969,6 +969,24 @@ static pgprot_t pgprot_clear_protnone_bits(pgprot_t prot)
 	return prot;
 }
 
+/*
+ * The caching mode includes the PAT bit located at different bit positions
+ * in the 4K and large page formats, and _PAGE_PSE is only valid for present
+ * large pages.
+ */
+static pte_t cpa_pte(enum pg_level level, unsigned long pfn, pgprot_t prot)
+{
+	prot = pgprot_clear_protnone_bits(prot);
+
+	if (level != PG_LEVEL_4K) {
+		prot = pgprot_4k_2_large(prot);
+		if (pgprot_val(prot) & _PAGE_PRESENT)
+			pgprot_val(prot) |= _PAGE_PSE;
+	}
+
+	return pfn_pte(pfn, prot);
+}
+
 static int should_split_large_page(pte_t *kpte, unsigned long address,
 				   enum pg_level level, struct cpa_data *cpa)
 {
@@ -1018,16 +1036,6 @@ static int should_split_large_page(pte_t *kpte, unsigned long address,
 	pgprot_val(req_prot) &= ~pgprot_val(cpa->mask_clr);
 	pgprot_val(req_prot) |= pgprot_val(cpa->mask_set);
 
-	/*
-	 * req_prot is in format of 4k pages. It must be converted to large
-	 * page format: the caching mode includes the PAT bit located at
-	 * different bit positions in the two formats.
-	 */
-	req_prot = pgprot_4k_2_large(req_prot);
-	req_prot = pgprot_clear_protnone_bits(req_prot);
-	if (pgprot_val(req_prot) & _PAGE_PRESENT)
-		pgprot_val(req_prot) |= _PAGE_PSE;
-
 	/*
 	 * old_pfn points to the large page base pfn. So we need to add the
 	 * offset of the virtual address:
@@ -1048,7 +1056,7 @@ static int should_split_large_page(pte_t *kpte, unsigned long address,
 	 * required independent of alignment and length of the requested
 	 * range.
 	 */
-	if (pgprot_val(req_prot) == pgprot_val(old_prot)) {
+	if (pgprot_val(req_prot) == pgprot_val(pgprot_large_2_4k(old_prot))) {
 		cpa_inc_lp_sameprot(level);
 		return 0;
 	}
@@ -1082,7 +1090,7 @@ static int should_split_large_page(pte_t *kpte, unsigned long address,
 		return 1;
 
 	/* All checks passed. Update the large page mapping. */
-	new_pte = pfn_pte(old_pfn, new_prot);
+	new_pte = cpa_pte(level, old_pfn, new_prot);
 	__set_pmd_pte(kpte, address, new_pte);
 	cpa->state |= CPA_ST_FLUSHTLB;
 	cpa_inc_lp_preserved(level);
@@ -1115,27 +1123,19 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 		ref_prot = pud_pgprot(*(pud_t *)kpte);
 		ref_pfn = pud_pfn(*(pud_t *)kpte);
 		pfninc = PMD_SIZE >> PAGE_SHIFT;
-		/*
-		 * Clear the PSE flags if the PRESENT flag is not set
-		 * otherwise pmd_present() will return true even on a non
-		 * present pmd.
-		 */
-		if (!(pgprot_val(ref_prot) & _PAGE_PRESENT))
-			pgprot_val(ref_prot) &= ~_PAGE_PSE;
+		ref_prot = pgprot_large_2_4k(ref_prot);
 		break;
 
 	default:
 		return -EINVAL;
 	}
 
-	ref_prot = pgprot_clear_protnone_bits(ref_prot);
-
 	/*
 	 * Get the target pfn from the original entry:
 	 */
 	pfn = ref_pfn;
 	for (i = 0; i < PTRS_PER_PTE; i++, pfn += pfninc)
-		set_pte(pbase + i, pfn_pte(pfn, ref_prot));
+		set_pte(pbase + i, cpa_pte(level - 1, pfn, ref_prot));
 
 	if (within(address, PAGE_OFFSET,
 		   PAGE_OFFSET + (max_pfn_mapped << PAGE_SHIFT)))
@@ -1833,14 +1833,12 @@ static int __change_page_attr(struct cpa_data *cpa)
 
 		new_prot = verify_rwx(cpa, old_prot, new_prot, address, pfn, 1);
 
-		new_prot = pgprot_clear_protnone_bits(new_prot);
-
 		/*
 		 * We need to keep the pfn from the existing PTE,
 		 * after all we're only going to change its attributes
 		 * not the memory it points to
 		 */
-		new_pte = pfn_pte(pfn, new_prot);
+		new_pte = cpa_pte(level, pfn, new_prot);
 		cpa->pfn = pfn;
 		/*
 		 * Do we really change anything ?

-- 
2.53.0


