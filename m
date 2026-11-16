Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEF0606A334
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 07:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hhJ1SUT0
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSfHs4vmTz2yGT;
	Mon, 16 Nov 2026 18:14:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.33
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794813273;
	cv=none; b=XaiVHwTTxLutAFTOS8hRQDwEBqxw0LpdB5iXsQbYatwpeltExcHn9dgB77FzHuku5lQaz7UlcwjRKumz5CFZke/vsgXglVM+dzHfk8xA1BshkrdZYFBrsk222KCPZSXNJviZOMIzfmBTnfXK0lCnm9AlKNHTd+m+CwJsvj8u3oT1Y7Tt+HYtwqlTZgX5f5ett1OHZRom5JJvtXmuIC2PwTL34GpiG/hdDPUCGza6Jg1HQEvJCiA2EQ41iRKAaflsf9Yq+OkkkK2DY4NZphzfJfj8wLvKDTh8FWESdLz3i8bgdfJ7D+Frt/FITMVa2cYUX0RCPhLQ2yGKnUWmI4iUUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794813273; c=relaxed/relaxed;
	bh=RBfGRIbJnN+qNQ3rPfXmwqxNtkbzv2IUhJ3GYvE0c6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hjnXMHNt4a2dKmhlUFn0kO41U/EXLKkNSAP/DeBx+AV+NMsfySSMV4SGEponcIL0fi+3dzfrehOiLgQTtQlIxnm5QFj7Wh/Ul7ShB8qCwEUEVLINN0iNbZ3ny4+uLohonvZ1xFcMzsjtBZt8qnll0dWwH47vdAH5T4KAfxfAbAUO6KwaQzdRfJaFNgnLEDR83RvYdipdts5BSemmvJ9dK4b7Lcj8BjeIsO3wFnZrIETN0YMRNHJz54A0lsYrQKtzRXr1PEUxPszA45KejK8V8Gq1e/gZ0ultmm4Vva4wJ2DfhdXQH6Tvxv6WFA/IT69lnynG/3lkMyqqZgcbHP0Sog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hhJ1SUT0; dkim-atps=neutral; spf=pass (client-ip=95.215.58.33; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hhJ1SUT0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.33; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-33.mta1.migadu.com [95.215.58.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSfHr5LSsz2y71
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 18:14:32 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=7IZMUSgTM4Km0OlppI5vIjCEjnCgOgbFSMjmVmeVMCE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794813253; v=1; x=1795418053;
 b=hhJ1SUT0Za3cYW+90PS25IHgLc8NIZ4WlHXM71wBtY4w41tB2VgSnclEklOGz+cyL8277/hc
 ME4F/Okn7X+yWeW094U5nbhjRvZtgCHTu7JDKpUaSWJJybBAUiZhGD3I7mbbEsELmM2i1nsYqTb
 wMzd3nh68jLRH5BGg/iZpNeU=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 3ab19dba70fd5e75;
	Mon, 16 Nov 2026 07:14:13 +0000
X-Mizu-Trace-ID: 3ab19dba70fd5e75
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Dev Jain <dev.jain@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	Hao Ge <hao.ge@linux.dev>
Subject: [PATCH v5 06/11] mm/vmalloc: undo what vmap_page_range() mapped on failure
Date: Mon, 16 Nov 2026 15:13:20 +0800
Message-Id: <20261116071325.263682-7-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261116071325.263682-1-hao.ge@linux.dev>
References: <20261116071325.263682-1-hao.ge@linux.dev>
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ioremap and arch setup code map their ranges with vmap_page_range().
When the walk fails half way, or the KMSAN metadata fails after the
walk, the ptes installed so far stay behind. The caller frees the
vm_area on the error path, so the next mapping that lands on the same
range trips the BUG() in vmap_pte_range().

vmap_range_noflush() now takes a mapped_end argument that the walk
levels advance as they install, and vmap_pte_range() BUG()s before
it installs over a pte that is already set. The ptes below mapped_end
are therefore all ours, while a pte above it can only have been put
there by somebody else, for example when the caller's range overlaps
an existing mapping. On a walk failure the undo is limited to
[addr, mapped_end), going further would clear ptes that are not
ours. If the walk completed and only the KMSAN metadata failed, the
whole range was installed by this call and all of it is undone.

All callers are sleepable, the teardown passes can_resched = true.

Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 mm/vmalloc.c | 52 +++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 13 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d99d7710e1ba..5c1eacc2a0ac 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -117,7 +117,8 @@ static __always_inline unsigned long vmap_set_ptes(pte_t *ptep,
 
 static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 			phys_addr_t phys_addr, pgprot_t prot,
-			unsigned int max_page_shift, pgtbl_mod_mask *mask)
+			unsigned int max_page_shift, pgtbl_mod_mask *mask,
+			unsigned long *mapped_end)
 {
 	pte_t *pte;
 	u64 pfn;
@@ -143,6 +144,7 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 
 		size = vmap_set_ptes(pte, addr, end, pfn, prot, max_page_shift);
 		nr_pages = PFN_DOWN(size);
+		*mapped_end = addr + size;
 	} while (pte += nr_pages, pfn += nr_pages, addr += size, addr != end);
 
 	lazy_mmu_mode_disable();
@@ -188,7 +190,8 @@ static int vmap_try_huge_pmd(pmd_t *pmd, unsigned long addr, unsigned long end,
 
 static int vmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 			phys_addr_t phys_addr, pgprot_t prot,
-			unsigned int max_page_shift, pgtbl_mod_mask *mask)
+			unsigned int max_page_shift, pgtbl_mod_mask *mask,
+			unsigned long *mapped_end)
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -203,10 +206,12 @@ static int vmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 		if (vmap_try_huge_pmd(pmd, addr, next, phys_addr, prot,
 					max_page_shift)) {
 			*mask |= PGTBL_PMD_MODIFIED;
+			*mapped_end = next;
 			continue;
 		}
 
-		err = vmap_pte_range(pmd, addr, next, phys_addr, prot, max_page_shift, mask);
+		err = vmap_pte_range(pmd, addr, next, phys_addr, prot,
+				     max_page_shift, mask, mapped_end);
 		if (err)
 			break;
 	} while (pmd++, phys_addr += (next - addr), addr = next, addr != end);
@@ -245,7 +250,8 @@ static int vmap_try_huge_pud(pud_t *pud, unsigned long addr, unsigned long end,
 
 static int vmap_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 			phys_addr_t phys_addr, pgprot_t prot,
-			unsigned int max_page_shift, pgtbl_mod_mask *mask)
+			unsigned int max_page_shift, pgtbl_mod_mask *mask,
+			unsigned long *mapped_end)
 {
 	pud_t *pud;
 	unsigned long next;
@@ -260,10 +266,12 @@ static int vmap_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 		if (vmap_try_huge_pud(pud, addr, next, phys_addr, prot,
 					max_page_shift)) {
 			*mask |= PGTBL_PUD_MODIFIED;
+			*mapped_end = next;
 			continue;
 		}
 
-		err = vmap_pmd_range(pud, addr, next, phys_addr, prot, max_page_shift, mask);
+		err = vmap_pmd_range(pud, addr, next, phys_addr, prot,
+				     max_page_shift, mask, mapped_end);
 		if (err)
 			break;
 	} while (pud++, phys_addr += (next - addr), addr = next, addr != end);
@@ -302,7 +310,8 @@ static int vmap_try_huge_p4d(p4d_t *p4d, unsigned long addr, unsigned long end,
 
 static int vmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
 			phys_addr_t phys_addr, pgprot_t prot,
-			unsigned int max_page_shift, pgtbl_mod_mask *mask)
+			unsigned int max_page_shift, pgtbl_mod_mask *mask,
+			unsigned long *mapped_end)
 {
 	p4d_t *p4d;
 	unsigned long next;
@@ -317,10 +326,12 @@ static int vmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
 		if (vmap_try_huge_p4d(p4d, addr, next, phys_addr, prot,
 					max_page_shift)) {
 			*mask |= PGTBL_P4D_MODIFIED;
+			*mapped_end = next;
 			continue;
 		}
 
-		err = vmap_pud_range(p4d, addr, next, phys_addr, prot, max_page_shift, mask);
+		err = vmap_pud_range(p4d, addr, next, phys_addr, prot,
+				     max_page_shift, mask, mapped_end);
 		if (err)
 			break;
 	} while (p4d++, phys_addr += (next - addr), addr = next, addr != end);
@@ -329,7 +340,7 @@ static int vmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
 
 static int vmap_range_noflush(unsigned long addr, unsigned long end,
 			phys_addr_t phys_addr, pgprot_t prot,
-			unsigned int max_page_shift)
+			unsigned int max_page_shift, unsigned long *mapped_end)
 {
 	pgd_t *pgd;
 	unsigned long start;
@@ -346,11 +357,12 @@ static int vmap_range_noflush(unsigned long addr, unsigned long end,
 	BUG_ON(addr >= end);
 
 	start = addr;
+	*mapped_end = addr;
 	pgd = pgd_offset_k(addr);
 	do {
 		next = pgd_addr_end(addr, end);
 		err = vmap_p4d_range(pgd, addr, next, phys_addr, prot,
-					max_page_shift, &mask);
+					max_page_shift, &mask, mapped_end);
 		if (err)
 			break;
 	} while (pgd++, phys_addr += (next - addr), addr = next, addr != end);
@@ -364,18 +376,32 @@ static int vmap_range_noflush(unsigned long addr, unsigned long end,
 int vmap_page_range(unsigned long addr, unsigned long end,
 		    phys_addr_t phys_addr, pgprot_t prot)
 {
+	unsigned long mapped_end = addr;
 	int err;
 
 	if (WARN_ON_ONCE(!PAGE_ALIGNED(addr) || !PAGE_ALIGNED(end)))
 		return -EINVAL;
 
 	err = vmap_range_noflush(addr, end, phys_addr, pgprot_nx(prot),
-				 ioremap_max_page_shift);
-	if (!err)
+				 ioremap_max_page_shift, &mapped_end);
+	if (err) {
+		/* Undo the part the walk installed before it failed. */
+		if (mapped_end > addr)
+			__vunmap_range_noflush(addr, mapped_end, true);
+	} else {
 		err = kmsan_ioremap_page_range(addr, end, phys_addr, prot,
 					       ioremap_max_page_shift);
-	if (!err)
-		flush_cache_vmap(addr, end);
+		if (err) {
+			/*
+			 * Only the KMSAN metadata failed, the walk mapped
+			 * the whole range. Undo it all. The callers are
+			 * ioremap and arch setup code, always sleepable.
+			 */
+			__vunmap_range_noflush(addr, end, true);
+		} else {
+			flush_cache_vmap(addr, end);
+		}
+	}
 
 	return err;
 }
-- 
2.25.1


