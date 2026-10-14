Return-Path: <linuxppc-dev+bounces-29505-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F97DC3DA7A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2026 18:07:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4fLf5ywHz3080;
	Thu, 15 Oct 2026 05:07:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=130.117.225.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791992788;
	cv=none; b=SrLfpzjlzTjc0aRpeI/pCHIQJ0PcJGEm6bG1rpumFcG98jPHqE/TT3Vqcq0WC65lYJLnFz22OgHh8ispcFYAvPiGOemMZyaAZUkrF1u2a319AnMxI8y5lShOH0NkFb6nX2Z0vMrcQAsipWdFLmUQlp0p27mavhFFzmPtQESlowmFk1Bze3xSOOhlDf0yPQUMYcuesNXnqqCdoHtfuSUlrvu0mFzE7M37JcIdYDEwZKvOCMeMTyfHcnuqMr6IXbdqDlgNocaRS16TnFpIdEAMEqboextptCZpaTeB59s7NoNe0ShteL55q+E5SJGq/VowhYDT/PnIOqRUwmpqAwKVGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791992788; c=relaxed/relaxed;
	bh=7vC0C3sp4wt6zauR/zTBNv+UfY1Rq7XzZhYx35u+Pg0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mnwG2vNk9WJri2SnKGTYc9Ebz64aLVZ775uhQuwJ7fC2engT7PDZU6UkQ6cschv1VQ/bC2fMe0SH7/770VwKmavJ3gpuzVGVTzqMtDIh23oL0pdb6CtoKpcbpbHltJl95ml9/Q6VyduK8DI3w1m3aTvofiBp1tMmw269GiMwyy9cKlWrp/HNdLrxnC6/okkzWDK5Dc+7F1tyy7ibngzA3d0d/2qIlZDMZoHJF3urwET/g7HqlA5/2G3MiSfG21JYbeVGOvibsiHLe19J22F1LlU5sL/4hGALsnpTnYkSHA+wyVjPH/5b98GyjfIz5o6Glsm7y9rAfC7JmsdAYRpO0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; dkim=pass (2048-bit key; secure) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=relay header.b=pyMcdMZQ; dkim-atps=neutral; spf=pass (client-ip=130.117.225.111; helo=relay.virtuozzo.com; envelope-from=khorenko@virtuozzo.com; receiver=lists.ozlabs.org) smtp.mailfrom=virtuozzo.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=relay header.b=pyMcdMZQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=virtuozzo.com (client-ip=130.117.225.111; helo=relay.virtuozzo.com; envelope-from=khorenko@virtuozzo.com; receiver=lists.ozlabs.org)
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4bCl39Fxz2ynZ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 02:46:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=Message-Id:Content-Type:MIME-Version:Subject:Date
	:From; bh=7vC0C3sp4wt6zauR/zTBNv+UfY1Rq7XzZhYx35u+Pg0=; b=pyMcdMZQB5ZqvVLfY1c
	7rwJCGcTAyuR7AiTeZGd0MdA2aYDFZJzn58phDbodFcBKdGH7IN2YcOx3wdqcl5v26RPIOQRJk+9W
	wdmRJF/vyDaBrq3xJRM0EjzN0coRIHYANvzMBDssbnclJzBt4qh4LA9B8GdUKXYM6PFonfPMLYXdd
	wZZu00DxSxjZ9mCUYfoW3kg7GiCkivih1R3rIox90CkrPBOdH7kkAFvASow/eK1Jd0T76aGIHteb5
	XSnMa3S42jsDsfOC4EyCiu1su0r/rdLS4S/NgC22IbUqLTpbtr/ZPXCK5sTWpIdaEyU1lhmwn/6nK
	ETmdNvppmvsaPeQ==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=f0.sw.ru)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1xH17r-006OFq-1f;
	Wed, 14 Oct 2026 17:46:15 +0200
From: Konstantin Khorenko <khorenko@virtuozzo.com>
Date: Wed, 14 Oct 2026 17:46:10 +0200
Subject: [PATCH v3 2/2] mm/huge_memory: deposit a page table for a special
 PMD copied by fork
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v3-2-85eaec8417f6@virtuozzo.com>
References: <20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v3-0-85eaec8417f6@virtuozzo.com>
In-Reply-To: <20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v3-0-85eaec8417f6@virtuozzo.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, 
 =?utf-8?q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>, 
 dri-devel@lists.freedesktop.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Konstantin Khorenko <khorenko@virtuozzo.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Sashiko <sashiko-bot@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2295;
 i=khorenko@virtuozzo.com; h=from:subject:message-id;
 bh=ccKR6pewzp3zZMmycW2Bk4rHSSS9C7rwMGxwqRO0ZTE=;
 b=owEBbQKS/ZANAwAKAVGWCkf5YVwqAcsmYgBqz6PFClTyKPLrnnz2A76nCcPaPtA7BJ8STorQS
 2LGmEvfjtGJAjMEAAEKAB0WIQRWD23IPcXT0GO9CCxRlgpH+WFcKgUCas+jxQAKCRBRlgpH+WFc
 KiGVEACF48BxKLRtenct26B7UErEMP4cCXXKBBh2OQTdVQG/gTnTUQmsq/rRFofn4M3McyTNw82
 ySfEk1gWQrQAKYowENQdUkKwKyDbgkCZOtL5nnOp40ZO6LPu35KF7+CNCkxOzXX0ZK4KnCz1ZTl
 x8DcoUMCJPp2pneC9getMw4C6zGaSomDz7heiaT1Rjzl69SToQWP/YEjdBfkVqbepbWKDUkFdSf
 P3FiHQ+K9+uVwKO0rUM+RpUW4x6PoDxfAC9pYTYVGENU76vAHXbbQWjLLQ496MoINpTBeQ+icLy
 FodLaYFVmgD0y597BAwMwDAp/8OTUeMF46epEQ4Qg05XHsn1mWEm7qZEYY4u/vdLRdmwt6PiHRj
 TGZJnxg9ywOfkLjRQtnfTh7AQtXhed6tvMcaZ3dZqXIe9kWA3sy2puP1B/Gy8lmWRiXmYAVYY74
 9cmCRDVPu9RcTZZrkdjaDI6kLpuntZeN0JyPiFsJNTxVpkLjCj02cZLuQTGrFJMwQhF8DNCfL3H
 gxbA1Ha344ZOgRPMoKvyFErRvSqB59yIGmamAXa8eIVTo93ZTzYGEnj5fJs6FFsO/EdoTML9NuM
 hZSVV8SY3dYfeBR/monHq2Hq0CZszYYxdozeXI6Zr8RcwERZH/RGXyPJdHgD+df7ZHvxIcRlnD3
 9o96Qx7HyTFbI3g==
X-Developer-Key: i=khorenko@virtuozzo.com; a=openpgp;
 fpr=560F6DC83DC5D3D063BD082C51960A47F9615C2A

Where arch_needs_pgtable_deposit() is true, every huge PMD needs a
deposited page table. ppc64 in hash mode keeps the hash slot array of
the huge page in it, so vmf_insert_pfn_pmd() deposits one for each
special PMD it maps.

copy_huge_pmd() copies a special PMD into the child without a table.
The child then dereferences a NULL table:

- on the first hash fault on the PMD, in __hash_page_thp();
- on the zap at munmap() or exit, in hash__pmdp_huge_get_and_clear().

Allocate a table before taking the page table locks and deposit it
with the copy, as insert_pmd() does.

Fixes: d1503aa9ab805 ("powerpc/64s: Add support for huge pfnmaps")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v1-1-d225c60bc316@virtuozzo.com?part=1
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
 mm/huge_memory.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index bf788bb231691..2380e4e877f82 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1961,6 +1961,11 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	pmd = pmdp_get_lockless(src_pmd);
 	if (unlikely(pmd_present(pmd) && pmd_special(pmd) &&
 		     !is_huge_zero_pmd(pmd))) {
+		if (arch_needs_pgtable_deposit()) {
+			pgtable = pte_alloc_one(dst_mm);
+			if (unlikely(!pgtable))
+				goto out;
+		}
 		dst_ptl = pmd_lock(dst_mm, dst_pmd);
 		src_ptl = pmd_lockptr(src_mm, src_pmd);
 		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
@@ -1974,6 +1979,8 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		if (unlikely(pmd_none(pmd))) {
 			spin_unlock(src_ptl);
 			spin_unlock(dst_ptl);
+			if (pgtable)
+				pte_free(dst_mm, pgtable);
 			return -EAGAIN;
 		}
 		/*
@@ -1983,6 +1990,10 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		 * wrongly write to the backend MMIO.
 		 */
 		VM_WARN_ON_ONCE(vma_is_cow_mapping(src_vma) && pmd_write(pmd));
+		if (pgtable) {
+			mm_inc_nr_ptes(dst_mm);
+			pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
+		}
 		goto set_pmd;
 	}
 

-- 
2.43.0


