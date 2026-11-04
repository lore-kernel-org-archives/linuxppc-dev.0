Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445C0606AC09
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 20:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=relay header.b=DDBzKqAJ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKcmY3kDHz2yQn;
	Thu, 05 Nov 2026 07:41:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=130.117.225.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793824893;
	cv=none; b=AZx4ml6fVXfTb9wnFvJeyBf4V4brSXxeELTDTBkB7dnnEEGYBBlzO1vBMDWcbVT1044qEn7E6iIb85Qc0MZhq2xIA4TOzCwfiffhVL7X6z+sWuiGuRAtTklTQoCw83Ni4g3c2D+/TwsvBBHBd9KlkTgigUCeyGoZTW/UcjHlba7q7cmyw7cSjM3ggYnW0m/xxLWMynQesb1IEFDx36ovGFDqeqBa6D1lzH/XXPSX+9uPiiHSO/mVjCeUo1+924EjN8WFLl/CcYvpc0QRWHt15cBJ+h44lCUoke9BSYFgqnNtTSwuB0Fnh5VWMwi9LMkDppZ/MCE+HwCLGdVbvS4B0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793824893; c=relaxed/relaxed;
	bh=m3piSQtfQuOg8u1CZlEVUJlwdFZ/horJKCFdnF6JPx4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I7GZaS6/2uzMWfJustESUuF6CUkt2lDR+4MQp6ZEjo7MeTMBwUYa0PKOrRm07Cl6lU4lJEMNS4Vu1TfXbFr8CaoFLoaW2m2xLLOUgEus4fX6bNKo+t4qWzVNYhC8bhFJne3Dg6NMvxSVK3/cWpp+ln3no2TkMs4gVVhb2eJ5h3pG/bIfdSApkBQAre5r8oXCTh5Zeko0vuluVzbYvxhPfCekioH0ehLVJMlu3Nid/R1nzOTZVCgUmOmqEEQCBc99PlmKGmEN7+jtRJXMCyTSC3mjHWiAgNmC0OTVeSdR18mPUpw5GcbimgnwlToglmNUrnxPXs1wzA+kvrqnd6OxSg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; dkim=pass (2048-bit key; secure) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=relay header.b=DDBzKqAJ; dkim-atps=neutral; spf=pass (client-ip=130.117.225.111; helo=relay.virtuozzo.com; envelope-from=khorenko@virtuozzo.com; receiver=lists.ozlabs.org) smtp.mailfrom=virtuozzo.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=relay header.b=DDBzKqAJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=virtuozzo.com (client-ip=130.117.225.111; helo=relay.virtuozzo.com; envelope-from=khorenko@virtuozzo.com; receiver=lists.ozlabs.org)
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKcmS6Q23z2yb9
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 07:41:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=Message-Id:Content-Type:MIME-Version:Subject:Date
	:From; bh=m3piSQtfQuOg8u1CZlEVUJlwdFZ/horJKCFdnF6JPx4=; b=DDBzKqAJss7bD2+bm2s
	P43Ux94h7IIe1ucOVYhz/ySnXcvWnMh9XoWdZm8KeW6DY/q73P2mKFhh6N+Ccv3TpXk4XShi5yDgz
	Y2er5iXun3HEJnILlYYWT4SenaR37N99ZrIjsn8ykdiwlkJqVcJ+VXfchpxwcvdia6CkmXLnujaV6
	B+Af3uGmljDQGYvGH0oG5c45wQz4wt4xmiAtWmGa8vAbHVnAXzTH+dVbQuU/uh5L9G2sGPvdI86F7
	6JlWBQi3OTBZk/QzdJ8AnEfyKzyyRCprkGF2Hh5dfyIPXGRyRGiNvV1rtR3vz7dwp272P6Dr1w3o3
	GrfBqrrkkMO03Ow==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=f0.sw.ru)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1xOhjA-0018X2-2O;
	Wed, 04 Nov 2026 21:41:04 +0100
From: Konstantin Khorenko <khorenko@virtuozzo.com>
Date: Wed, 04 Nov 2026 21:40:57 +0100
Subject: [PATCH v5 3/4] mm/huge_memory: read a special PMD under the lock
 in copy_huge_pmd()
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
Message-Id: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-3-c56d0d26f970@virtuozzo.com>
References: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-0-c56d0d26f970@virtuozzo.com>
In-Reply-To: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-0-c56d0d26f970@virtuozzo.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, 
 =?utf-8?q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Konstantin Khorenko <khorenko@virtuozzo.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, stable@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4033;
 i=khorenko@virtuozzo.com; h=from:subject:message-id;
 bh=py+hRT0j2W1iu9s6HX+poqDtbv0blfBMcY8NUrWKcd0=;
 b=owEBbQKS/ZANAwAKAVGWCkf5YVwqAcsmYgBq65hdLggzNygo5KJ93r3G6e7Ax8It/B3P0I8J4
 2DyVb7vwnGJAjMEAAEKAB0WIQRWD23IPcXT0GO9CCxRlgpH+WFcKgUCauuYXQAKCRBRlgpH+WFc
 KkO7D/4nfFyvxkBgfdLQmB0YnnwJdSop86K3UxtoZgUM1vbtX2DXJsNtW9nEvRYTiUdPpkyfJWJ
 Zuin+uFVhJ0JVYdpt/UstEVsUeqs5VJ63zT0SQXGJJelixu8VtBEhRFxxT8nJX/R7b5NMeM6aCi
 cr9/Dve6+gKqvSS2TVDW3Kd98uh+MwKAHHGqzTRMhurwnUsxj9/xCtpnOIw3BrGpC1yB321PF2r
 zsr7MCVyUmc4O+P77YDDuNc6jZOh2+YPtkqgMaGdIsvQfX+u8h67SH+1g4h1jPCkTdNfGYJQBGZ
 GKtfplP4Igaoak5QdpyIdg7te9QrD+ddbX6BagGJakPfmFcQrAvOJjktlbByiAVoFVXOVuvg9Z0
 eY3AdCvvjWdB/VDGnWjyFWL9JfDsD2MIfXkSh7TxdKxMBlZLmyPXQVGfHHElY66LoEYIiXG1ztM
 2bYdW8FjQQ0zCDuMPw3VB8Sh5xGCQ8u5wiPexpNfPzbo+z0QcpMgf0BLXrzc9R0rs8ec4+Gh+tl
 aOm12Jl6cTC/aiva3Sqmd1a+VPusSoUssugj4shG6uiHmKd7GelE+oTcNckkN55nZvJqbBpgelB
 kyu23cA32rlq9Biyz9BnUUNhWUbRADxuXjNBqs+nekl1wlbY+0pdrF2Hfuzu6rt+F0IPt1heSL+
 3gvOLpNZWs7rJBg==
X-Developer-Key: i=khorenko@virtuozzo.com; a=openpgp;
 fpr=560F6DC83DC5D3D063BD082C51960A47F9615C2A
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

copy_huge_pmd() reads a special PMD without the page table lock and
copies that value to the child. The mmap write lock held by fork does
not stop unmap_mapping_range(): it zaps under i_mmap_rwsem and the PMD
lock.

The zap visits the parent VMA before the child's, as dup_mmap() links
the child right after the parent in i_mmap. If it clears the parent PMD
after fork has read it, and passes the child before fork copies it, the
child keeps a mapping the driver has revoked, for example:

- vfio-pci: the child reaches the BAR after the device memory was
  disabled or the device was reset, instead of getting SIGBUS;
- panthor: the child maps the pages of an evicted buffer object after
  the driver has released them.

The same branch deposits no page table under the copy. ppc64 in hash
mode keeps the hash slot array of every huge PMD in that table, so the
child dereferences a NULL table on the first hash fault, in
__hash_page_thp(), and on the zap, in hash__pmdp_huge_get_and_clear().

Take the locks first and let vm_normal_page_pmd() tell a PFN mapping
from a folio under them, as copy_present_ptes() does with
vm_normal_page(). The zap clears the parent PMD under the same lock, so
either fork finds it none and skips it, or the copy is in place before
the zap reaches the child.

The copy of a PFN mapping then goes through the same tail as a folio:

- it gets a page table where the architecture needs one;
- in a shared mapping it is marked clean in the child, as a PTE is;
- in a CoW mapping, which only VM_MIXEDMAP allows, both sides are write
  protected instead of a warning being printed.

Fixes: bc02afbd4d73 ("mm/fork: accept huge pfnmap entries")
Fixes: d1503aa9ab80 ("powerpc/64s: Add support for huge pfnmaps")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v1-1-d225c60bc316@virtuozzo.com?part=1
Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
 mm/huge_memory.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e00632edb3856..9cb5f99aba87f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1961,25 +1961,6 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	int ret = -ENOMEM;
 	bool writable;
 
-	pmd = pmdp_get_lockless(src_pmd);
-	if (unlikely(pmd_present(pmd) && pmd_special(pmd) &&
-		     !is_huge_zero_pmd(pmd))) {
-		dst_ptl = pmd_lock(dst_mm, dst_pmd);
-		src_ptl = pmd_lockptr(src_mm, src_pmd);
-		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
-		/*
-		 * No need to recheck the pmd, it can't change with write
-		 * mmap lock held here.
-		 *
-		 * Meanwhile, making sure it's not a CoW VMA with writable
-		 * mapping, otherwise it means either the anon page wrongly
-		 * applied special bit, or we made the PRIVATE mapping be
-		 * able to wrongly write to the backend MMIO.
-		 */
-		VM_WARN_ON_ONCE(vma_is_cow_mapping(src_vma) && pmd_write(pmd));
-		goto set_pmd;
-	}
-
 	if (vma_is_anonymous(dst_vma) || arch_needs_pgtable_deposit()) {
 		pgtable = pte_alloc_one(dst_mm);
 		if (unlikely(!pgtable))
@@ -2021,7 +2002,9 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		goto copy_pmd;
 	}
 
-	src_page = pmd_page(pmd);
+	src_page = vm_normal_page_pmd(src_vma, addr, pmd);
+	if (!src_page)
+		goto copy_pmd;
 	VM_BUG_ON_PAGE(!PageHead(src_page), src_page);
 	src_folio = page_folio(src_page);
 
@@ -2061,7 +2044,6 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	}
 	if (src_vma->vm_flags & VM_SHARED)
 		pmd = pmd_mkclean(pmd);
-set_pmd:
 	pmd = pmd_mkold(pmd);
 	set_pmd_at(dst_mm, addr, dst_pmd, pmd);
 

-- 
2.43.0


