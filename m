Return-Path: <linuxppc-dev+bounces-18543-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B1301099B54
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Mar 2026 06:44:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fd8yh54YXz2yth;
	Sat, 21 Mar 2026 17:43:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774075404;
	cv=none; b=ec0LHMV3pxlpkpmuzdXJhQjmF0cwYJKJ3u9Klcwz0qQxDSS/y4ZqBx00majz7lDZPyIaACTURqrb5wN1soUVrM9Dlc8dWdPzfk3s5I2HSBIHi38MEWYEHYxX39fF5g+bXxS/BUcSaZ+F2eDvTLcIORPZi8l30mvu8nfRgZ1jmoLCwmF4av1Ly/MN7WERaxfTAfzZPyCghX489xJybNqM5251/8kYVnigphBiPUdUsYwqscrq26k282UhTr1svAn48gup/eiyMTSZI/fJHH9PUVPaHidDdJXgn7BFSy8ZuwJoAIShpxTMHWJ++x7+vOAk3MhP1Kbr/cSDwctUhbxF5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774075404; c=relaxed/relaxed;
	bh=TmudzNicNUiCl0daaMXprBQaBaWvZIMFkUgBsUIOa+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vhh4bbwdtO470XwbBAICJnJdEP4iCY1cNwjYNPFMsfXRKuxYLMUcGhz/hFXRZ8L93FKYKj+pTal9y5Y/vloNLW2zvzT3P46FbPEm1L37px0Vx0jBD3XBSaRF3cWYWZThPeEuJ4OZ2iXjGx/XFWEmATpJAGNWcRJV3Ki8h1wrLW9D+rHnFCyiwHDuuGOIakQ7tc7I3kF0AvWl9O3jkZldxN4P17qyyn/neJ7L2D8k2DDNhjMIqynk8bDDeoxo4xTeFTQhp11QoOBHpQHgk22knElG0QODAoTUzDNsCRlEKYo2h/RXQ2ew3zdwu9aQuvhykTtsgIEsKD5QcjZEtVfHsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xmnOnySo; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=baolin.wang@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xmnOnySo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=baolin.wang@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fd8yf3PVMz2yWy
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2026 17:43:21 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774075396; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=TmudzNicNUiCl0daaMXprBQaBaWvZIMFkUgBsUIOa+M=;
	b=xmnOnySojUaXnDbRJBFQd4ROvaHwGIYlbzlYGMzP9+UOj0glPquP2TXpNcvXjXxgASVgXU2YvYaW533TdYKR9netOf0PQ/JIGZo3YI5jSX1iNGZiY9X1lK0rgU/AhydKe7b18Upg+j/nEcUuHczZVtmWo6UzKchvnENgHNM7MP8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X.ODaLu_1774075394;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X.ODaLu_1774075394 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 21 Mar 2026 14:43:15 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	david@kernel.org
Cc: ljs@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	baolin.wang@linux.alibaba.com,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org (open),
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] mm: change to return bool for the MMU notifier's young flag check
Date: Sat, 21 Mar 2026 14:42:54 +0800
Message-ID: <a9ad3fe938002d87358e7bfca264f753ab602561.1774075004.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1774075004.git.baolin.wang@linux.alibaba.com>
References: <cover.1774075004.git.baolin.wang@linux.alibaba.com>
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

The MMU notifier young flag check related functions only return whether
the young flag was set. Change the return type to bool to make the
intention clearer.

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 include/linux/mmu_notifier.h | 76 +++++++++++++++++-------------------
 mm/internal.h                | 16 ++++----
 mm/mmu_notifier.c            | 23 +++++------
 virt/kvm/kvm_main.c          | 31 ++++++---------
 4 files changed, 66 insertions(+), 80 deletions(-)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index 3705d350c863..17f2cdc77dd5 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -97,20 +97,20 @@ struct mmu_notifier_ops {
 	 * Start-end is necessary in case the secondary MMU is mapping the page
 	 * at a smaller granularity than the primary MMU.
 	 */
-	int (*clear_flush_young)(struct mmu_notifier *subscription,
-				 struct mm_struct *mm,
-				 unsigned long start,
-				 unsigned long end);
+	bool (*clear_flush_young)(struct mmu_notifier *subscription,
+				  struct mm_struct *mm,
+				  unsigned long start,
+				  unsigned long end);
 
 	/*
 	 * clear_young is a lightweight version of clear_flush_young. Like the
 	 * latter, it is supposed to test-and-clear the young/accessed bitflag
 	 * in the secondary pte, but it may omit flushing the secondary tlb.
 	 */
-	int (*clear_young)(struct mmu_notifier *subscription,
-			   struct mm_struct *mm,
-			   unsigned long start,
-			   unsigned long end);
+	bool (*clear_young)(struct mmu_notifier *subscription,
+			    struct mm_struct *mm,
+			    unsigned long start,
+			    unsigned long end);
 
 	/*
 	 * test_young is called to check the young/accessed bitflag in
@@ -118,9 +118,9 @@ struct mmu_notifier_ops {
 	 * frequently used without actually clearing the flag or tearing
 	 * down the secondary mapping on the page.
 	 */
-	int (*test_young)(struct mmu_notifier *subscription,
-			  struct mm_struct *mm,
-			  unsigned long address);
+	bool (*test_young)(struct mmu_notifier *subscription,
+			   struct mm_struct *mm,
+			   unsigned long address);
 
 	/*
 	 * invalidate_range_start() and invalidate_range_end() must be
@@ -376,14 +376,12 @@ mmu_interval_check_retry(struct mmu_interval_notifier *interval_sub,
 
 extern void __mmu_notifier_subscriptions_destroy(struct mm_struct *mm);
 extern void __mmu_notifier_release(struct mm_struct *mm);
-extern int __mmu_notifier_clear_flush_young(struct mm_struct *mm,
-					  unsigned long start,
-					  unsigned long end);
-extern int __mmu_notifier_clear_young(struct mm_struct *mm,
-				      unsigned long start,
-				      unsigned long end);
-extern int __mmu_notifier_test_young(struct mm_struct *mm,
-				     unsigned long address);
+bool __mmu_notifier_clear_flush_young(struct mm_struct *mm,
+		unsigned long start, unsigned long end);
+bool __mmu_notifier_clear_young(struct mm_struct *mm,
+		unsigned long start, unsigned long end);
+bool __mmu_notifier_test_young(struct mm_struct *mm,
+		unsigned long address);
 extern int __mmu_notifier_invalidate_range_start(struct mmu_notifier_range *r);
 extern void __mmu_notifier_invalidate_range_end(struct mmu_notifier_range *r);
 extern void __mmu_notifier_arch_invalidate_secondary_tlbs(struct mm_struct *mm,
@@ -403,30 +401,28 @@ static inline void mmu_notifier_release(struct mm_struct *mm)
 		__mmu_notifier_release(mm);
 }
 
-static inline int mmu_notifier_clear_flush_young(struct mm_struct *mm,
-					  unsigned long start,
-					  unsigned long end)
+static inline bool mmu_notifier_clear_flush_young(struct mm_struct *mm,
+		unsigned long start, unsigned long end)
 {
 	if (mm_has_notifiers(mm))
 		return __mmu_notifier_clear_flush_young(mm, start, end);
-	return 0;
+	return false;
 }
 
-static inline int mmu_notifier_clear_young(struct mm_struct *mm,
-					   unsigned long start,
-					   unsigned long end)
+static inline bool mmu_notifier_clear_young(struct mm_struct *mm,
+		unsigned long start, unsigned long end)
 {
 	if (mm_has_notifiers(mm))
 		return __mmu_notifier_clear_young(mm, start, end);
-	return 0;
+	return false;
 }
 
-static inline int mmu_notifier_test_young(struct mm_struct *mm,
-					  unsigned long address)
+static inline bool mmu_notifier_test_young(struct mm_struct *mm,
+		unsigned long address)
 {
 	if (mm_has_notifiers(mm))
 		return __mmu_notifier_test_young(mm, address);
-	return 0;
+	return false;
 }
 
 static inline void
@@ -552,24 +548,22 @@ static inline void mmu_notifier_release(struct mm_struct *mm)
 {
 }
 
-static inline int mmu_notifier_clear_flush_young(struct mm_struct *mm,
-					  unsigned long start,
-					  unsigned long end)
+static inline bool mmu_notifier_clear_flush_young(struct mm_struct *mm,
+		unsigned long start, unsigned long end)
 {
-	return 0;
+	return false;
 }
 
-static inline int mmu_notifier_clear_young(struct mm_struct *mm,
-					   unsigned long start,
-					   unsigned long end)
+static inline bool mmu_notifier_clear_young(struct mm_struct *mm,
+		unsigned long start, unsigned long end)
 {
-	return 0;
+	return false;
 }
 
-static inline int mmu_notifier_test_young(struct mm_struct *mm,
-					  unsigned long address)
+static inline bool mmu_notifier_test_young(struct mm_struct *mm,
+		unsigned long address)
 {
-	return 0;
+	return false;
 }
 
 static inline void
diff --git a/mm/internal.h b/mm/internal.h
index 0eaca2f0eb6a..3d6eba216364 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1831,10 +1831,10 @@ static inline int io_remap_pfn_range_complete(struct vm_area_struct *vma,
 }
 
 #ifdef CONFIG_MMU_NOTIFIER
-static inline int clear_flush_young_ptes_notify(struct vm_area_struct *vma,
+static inline bool clear_flush_young_ptes_notify(struct vm_area_struct *vma,
 		unsigned long addr, pte_t *ptep, unsigned int nr)
 {
-	int young;
+	bool young;
 
 	young = clear_flush_young_ptes(vma, addr, ptep, nr);
 	young |= mmu_notifier_clear_flush_young(vma->vm_mm, addr,
@@ -1842,30 +1842,30 @@ static inline int clear_flush_young_ptes_notify(struct vm_area_struct *vma,
 	return young;
 }
 
-static inline int pmdp_clear_flush_young_notify(struct vm_area_struct *vma,
+static inline bool pmdp_clear_flush_young_notify(struct vm_area_struct *vma,
 		unsigned long addr, pmd_t *pmdp)
 {
-	int young;
+	bool young;
 
 	young = pmdp_clear_flush_young(vma, addr, pmdp);
 	young |= mmu_notifier_clear_flush_young(vma->vm_mm, addr, addr + PMD_SIZE);
 	return young;
 }
 
-static inline int test_and_clear_young_ptes_notify(struct vm_area_struct *vma,
+static inline bool test_and_clear_young_ptes_notify(struct vm_area_struct *vma,
 		unsigned long addr, pte_t *ptep, unsigned int nr)
 {
-	int young;
+	bool young;
 
 	young = test_and_clear_young_ptes(vma, addr, ptep, nr);
 	young |= mmu_notifier_clear_young(vma->vm_mm, addr, addr + nr * PAGE_SIZE);
 	return young;
 }
 
-static inline int pmdp_test_and_clear_young_notify(struct vm_area_struct *vma,
+static inline bool pmdp_test_and_clear_young_notify(struct vm_area_struct *vma,
 		unsigned long addr, pmd_t *pmdp)
 {
-	int young;
+	bool young;
 
 	young = pmdp_test_and_clear_young(vma, addr, pmdp);
 	young |= mmu_notifier_clear_young(vma->vm_mm, addr, addr + PMD_SIZE);
diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 2502474b83b6..dc6f78d559f7 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -364,12 +364,12 @@ void __mmu_notifier_release(struct mm_struct *mm)
  * unmap the address and return 1 or 0 depending if the mapping previously
  * existed or not.
  */
-int __mmu_notifier_clear_flush_young(struct mm_struct *mm,
-					unsigned long start,
-					unsigned long end)
+bool __mmu_notifier_clear_flush_young(struct mm_struct *mm,
+		unsigned long start, unsigned long end)
 {
 	struct mmu_notifier *subscription;
-	int young = 0, id;
+	bool young = false;
+	int id;
 
 	id = srcu_read_lock(&srcu);
 	hlist_for_each_entry_srcu(subscription,
@@ -384,12 +384,12 @@ int __mmu_notifier_clear_flush_young(struct mm_struct *mm,
 	return young;
 }
 
-int __mmu_notifier_clear_young(struct mm_struct *mm,
-			       unsigned long start,
-			       unsigned long end)
+bool __mmu_notifier_clear_young(struct mm_struct *mm,
+		unsigned long start, unsigned long end)
 {
 	struct mmu_notifier *subscription;
-	int young = 0, id;
+	bool young = false;
+	int id;
 
 	id = srcu_read_lock(&srcu);
 	hlist_for_each_entry_srcu(subscription,
@@ -404,11 +404,12 @@ int __mmu_notifier_clear_young(struct mm_struct *mm,
 	return young;
 }
 
-int __mmu_notifier_test_young(struct mm_struct *mm,
-			      unsigned long address)
+bool __mmu_notifier_test_young(struct mm_struct *mm,
+		unsigned long address)
 {
 	struct mmu_notifier *subscription;
-	int young = 0, id;
+	bool young = false;
+	int id;
 
 	id = srcu_read_lock(&srcu);
 	hlist_for_each_entry_srcu(subscription,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index d0ab29672c71..82433f46c438 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -646,11 +646,9 @@ static __always_inline kvm_mn_ret_t kvm_handle_hva_range(struct kvm *kvm,
 	return r;
 }
 
-static __always_inline int kvm_age_hva_range(struct mmu_notifier *mn,
-						unsigned long start,
-						unsigned long end,
-						gfn_handler_t handler,
-						bool flush_on_ret)
+static __always_inline bool kvm_age_hva_range(struct mmu_notifier *mn,
+		unsigned long start, unsigned long end, gfn_handler_t handler,
+		bool flush_on_ret)
 {
 	struct kvm *kvm = mmu_notifier_to_kvm(mn);
 	const struct kvm_mmu_notifier_range range = {
@@ -666,10 +664,8 @@ static __always_inline int kvm_age_hva_range(struct mmu_notifier *mn,
 	return kvm_handle_hva_range(kvm, &range).ret;
 }
 
-static __always_inline int kvm_age_hva_range_no_flush(struct mmu_notifier *mn,
-						      unsigned long start,
-						      unsigned long end,
-						      gfn_handler_t handler)
+static __always_inline bool kvm_age_hva_range_no_flush(struct mmu_notifier *mn,
+		unsigned long start, unsigned long end, gfn_handler_t handler)
 {
 	return kvm_age_hva_range(mn, start, end, handler, false);
 }
@@ -829,10 +825,8 @@ static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
 		rcuwait_wake_up(&kvm->mn_memslots_update_rcuwait);
 }
 
-static int kvm_mmu_notifier_clear_flush_young(struct mmu_notifier *mn,
-					      struct mm_struct *mm,
-					      unsigned long start,
-					      unsigned long end)
+static bool kvm_mmu_notifier_clear_flush_young(struct mmu_notifier *mn,
+		struct mm_struct *mm, unsigned long start, unsigned long end)
 {
 	trace_kvm_age_hva(start, end);
 
@@ -840,10 +834,8 @@ static int kvm_mmu_notifier_clear_flush_young(struct mmu_notifier *mn,
 				 !IS_ENABLED(CONFIG_KVM_ELIDE_TLB_FLUSH_IF_YOUNG));
 }
 
-static int kvm_mmu_notifier_clear_young(struct mmu_notifier *mn,
-					struct mm_struct *mm,
-					unsigned long start,
-					unsigned long end)
+static bool kvm_mmu_notifier_clear_young(struct mmu_notifier *mn,
+		struct mm_struct *mm, unsigned long start, unsigned long end)
 {
 	trace_kvm_age_hva(start, end);
 
@@ -863,9 +855,8 @@ static int kvm_mmu_notifier_clear_young(struct mmu_notifier *mn,
 	return kvm_age_hva_range_no_flush(mn, start, end, kvm_age_gfn);
 }
 
-static int kvm_mmu_notifier_test_young(struct mmu_notifier *mn,
-				       struct mm_struct *mm,
-				       unsigned long address)
+static bool kvm_mmu_notifier_test_young(struct mmu_notifier *mn,
+		struct mm_struct *mm, unsigned long address)
 {
 	trace_kvm_test_age_hva(address);
 
-- 
2.47.3


