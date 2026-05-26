Return-Path: <linuxppc-dev+bounces-21529-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B75CD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 22:40:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQ74V5sfLz2xld;
	Wed, 27 May 2026 08:40:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779807387;
	cv=none; b=IyTQV67tj4f5AI0kRl/vFrwvcg0K9pY+lO+hvsr58n2JuZbxnNfyYmrkHGhVQbWQy9CbaOm5yTxQju0pQKON771nb6TA8cyeeg+hAeHYTwK/zE8F1YvPlgbMaEgzXvTX85eeJac53xHHwRrnBebd+vJoiYx1HEuC8tLaFNR17hcecKNQdY7QF3DCGxxe75/rAmlaE8VXJ3AiJCVnS31ZaQHPLe45s5zTZHBFraau1XcQjUuaX8MzKB7YM4o9G6u4xlemzGFpVUpVR9NqVKOIJPXOnQK34qwLvXRaPGcny1fHaf9qV9v3wKtyuQp1Vr5VyTrcioWKrc+BAtyYvgHo9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779807387; c=relaxed/relaxed;
	bh=YAntgOTYzemzPb0EO7sTFQO6BvGc9iJeZEmRTSuIcHs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XimKu8+fRLeQY6v682DRsTQYH9+d0olAcUNpRxG+GxikqJNPwbMv26Gfqe0Nu1r9nMXSwJP7tfrrUUXytikJOJPcW3Iw3Iz7LGx1xIPiKiEAYeWyAQeVGE9rTEbdzPRLM7KxG7Uv2CP6gQxjKg2icob3DjSPA7Ic6mn+ur5rNc3129aQLsXhM9r1TwvN89+kS2CR4ccoR2lYER9/ZlffZlxbSXi+LW8ewuDqmrAptpuBNUn/dprX2eLo3BD+2qHiMWlL73auwwlp5C0ZetK0L44r9tZXc7Ke8ohGuXiNIqosjJPSHMqRGwqGA5/2M1O6m3JOuYj4q+BF8XoQuh0LFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=aaxZKJZg; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=aaxZKJZg; dkim-atps=neutral; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=yintirui@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=aaxZKJZg;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=aaxZKJZg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=yintirui@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPwn65b2bz2xtC
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 00:56:26 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=YAntgOTYzemzPb0EO7sTFQO6BvGc9iJeZEmRTSuIcHs=;
	b=aaxZKJZgaMiO97CRNKgdXbF9a+WdupCXAZJH6aCLKDE/QcIFvdDpw7trUN2xXzftoS/ljUZIs
	WbPF/+qBEysJMYcTplm5KjDlnSJ7bmDUsBo/PycdedUouph+stsmJVQaALSHyW+Vmh24Jj8Wp+M
	kjD6iiq6tNQulyrkLP5yR98=
Received: from canpmsgout05.his.huawei.com (unknown [172.19.92.145])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4gPwm20RM5z1BGX6
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 22:55:30 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=YAntgOTYzemzPb0EO7sTFQO6BvGc9iJeZEmRTSuIcHs=;
	b=aaxZKJZgaMiO97CRNKgdXbF9a+WdupCXAZJH6aCLKDE/QcIFvdDpw7trUN2xXzftoS/ljUZIs
	WbPF/+qBEysJMYcTplm5KjDlnSJ7bmDUsBo/PycdedUouph+stsmJVQaALSHyW+Vmh24Jj8Wp+M
	kjD6iiq6tNQulyrkLP5yR98=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gPwbk08Bnz12LdK;
	Tue, 26 May 2026 22:48:18 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 2CE5140561;
	Tue, 26 May 2026 22:56:18 +0800 (CST)
Received: from huawei.com (10.50.87.63) by kwepemr500001.china.huawei.com
 (7.202.194.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 26 May
 2026 22:56:16 +0800
From: Yin Tirui <yintirui@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox
	<willy@infradead.org>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes
	<ljs@kernel.org>, Juergen Gross <jgross@suse.com>, Jonathan Cameron
	<jic23@kernel.org>, Will Deacon <will@kernel.org>
CC: Catalin Marinas <catalin.marinas@arm.com>, Peter Xu <peterx@redhat.com>,
	Luiz Capitulino <luizcap@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Andy
 Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>, Zi Yan <ziy@nvidia.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, Ryan Roberts
	<ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
	<baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, Vlastimil Babka
	<vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
	<surenb@google.com>, Michal Hocko <mhocko@suse.com>, Anshuman Khandual
	<anshuman.khandual@arm.com>, Rohan McLure <rmclure@linux.ibm.com>, Kevin
 Brodsky <kevin.brodsky@arm.com>, Alistair Popple <apopple@nvidia.com>, Andrew
 Donnellan <andrew+kernel@donnellan.id.au>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, Baoquan He <bhe@redhat.com>, Thomas Huth
	<thuth@redhat.com>, Coiby Xu <coxu@redhat.com>, Dan Williams
	<djbw@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Lu Baolu
	<baolu.lu@linux.intel.com>, Conor Dooley <conor.dooley@microchip.com>, Rik
 van Riel <riel@surriel.com>, <wangkefeng.wang@huawei.com>,
	<chenjun102@huawei.com>, <yintirui@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-pm@vger.kernel.org>
Subject: [PATCH mm-unstable RFC v4 6/7] mm/huge_memory: make move_huge_pmd() use has_deposited_pgtable()
Date: Tue, 26 May 2026 22:50:02 +0800
Message-ID: <20260526145003.88445-7-yintirui@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526145003.88445-1-yintirui@huawei.com>
References: <20260526145003.88445-1-yintirui@huawei.com>
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
Content-Type: text/plain
X-Originating-IP: [10.50.87.63]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr500001.china.huawei.com (7.202.194.229)

Use has_deposited_pgtable() in move_huge_pmd() to decide whether
pmd_move_must_withdraw() should move a deposited pgtable instead of
using the VMA type.

PowerPC radix follows the generic rule.  PowerPC hash keeps returning
true.

Signed-off-by: Yin Tirui <yintirui@huawei.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h |  5 ++---
 arch/powerpc/mm/book3s64/pgtable.c           | 11 +++++------
 mm/huge_memory.c                             | 20 ++++++++++++--------
 3 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index b6629c041e75..a0042cacac8d 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1424,9 +1424,8 @@ extern pud_t pudp_invalidate(struct vm_area_struct *vma, unsigned long address,
 
 #define pmd_move_must_withdraw pmd_move_must_withdraw
 struct spinlock;
-extern int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
-				  struct spinlock *old_pmd_ptl,
-				  struct vm_area_struct *vma);
+extern bool pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
+		struct spinlock *old_pmd_ptl, bool has_deposit);
 /*
  * Hash translation mode use the deposited table to store hash pte
  * slot information.
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index 85ab6723c8f2..4c45b5762d57 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -548,15 +548,14 @@ void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr,
  * pmd page. Hence if we have different pmd page we need to withdraw during pmd
  * move.
  *
- * With hash we use deposited table always irrespective of anon or not.
- * With radix we use deposited table only for anonymous mapping.
+ * With hash we use deposited table always irrespective of has_deposit or not.
+ * With radix we use the same rule as the generic implementation.
  */
-int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
-			   struct spinlock *old_pmd_ptl,
-			   struct vm_area_struct *vma)
+bool pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
+		struct spinlock *old_pmd_ptl, bool has_deposit)
 {
 	if (radix_enabled())
-		return (new_pmd_ptl != old_pmd_ptl) && vma_is_anonymous(vma);
+		return (new_pmd_ptl != old_pmd_ptl) && has_deposit;
 
 	return true;
 }
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 8cd77389d52f..be9b637c813b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2552,17 +2552,14 @@ bool zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 }
 
 #ifndef pmd_move_must_withdraw
-static inline int pmd_move_must_withdraw(spinlock_t *new_pmd_ptl,
-					 spinlock_t *old_pmd_ptl,
-					 struct vm_area_struct *vma)
+static inline bool pmd_move_must_withdraw(spinlock_t *new_pmd_ptl,
+		spinlock_t *old_pmd_ptl, bool has_deposit)
 {
 	/*
 	 * With split pmd lock we also need to move preallocated
 	 * PTE page table if new_pmd is on different PMD page table.
-	 *
-	 * We also don't deposit and withdraw tables for file pages.
 	 */
-	return (new_pmd_ptl != old_pmd_ptl) && vma_is_anonymous(vma);
+	return (new_pmd_ptl != old_pmd_ptl) && has_deposit;
 }
 #endif
 
@@ -2595,8 +2592,11 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 {
 	spinlock_t *old_ptl, *new_ptl;
 	pmd_t pmd;
+	struct folio *folio = NULL;
 	struct mm_struct *mm = vma->vm_mm;
 	bool force_flush = false;
+	bool has_deposit;
+	bool is_present;
 
 	/*
 	 * The destination pmd shouldn't be established, free_pgtables()
@@ -2618,11 +2618,15 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 		if (new_ptl != old_ptl)
 			spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
 		pmd = pmdp_huge_get_and_clear(mm, old_addr, old_pmd);
-		if (pmd_present(pmd))
+		is_present = pmd_present(pmd);
+		if (is_present)
 			force_flush = true;
 		VM_BUG_ON(!pmd_none(*new_pmd));
 
-		if (pmd_move_must_withdraw(new_ptl, old_ptl, vma)) {
+		folio = normal_or_softleaf_folio_pmd(vma, old_addr, pmd, is_present);
+		has_deposit = has_deposited_pgtable(vma, pmd, folio);
+
+		if (pmd_move_must_withdraw(new_ptl, old_ptl, has_deposit)) {
 			pgtable_t pgtable;
 			pgtable = pgtable_trans_huge_withdraw(mm, old_pmd);
 			pgtable_trans_huge_deposit(mm, new_pmd, pgtable);
-- 
2.43.0


