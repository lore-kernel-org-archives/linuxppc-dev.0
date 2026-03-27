Return-Path: <linuxppc-dev+bounces-18943-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B31C10F286F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 20:55:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fjCZq3JwFz2yv7;
	Sat, 28 Mar 2026 07:55:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1249"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774644915;
	cv=none; b=c7Dv9WYjMpCwhjHO3b64uFs/ArEMOc98GhVRkAsgrZjDLLDTHncd8TuxkXjBKU/13Q1YdAM+yRVhTW0vAXAZL5cDyWkFlc1gNTK0hAcDKltdENqQzMRlgSWCcbalC36U8Qic1KkPLVzLPCug8B3HvP2aDHURseM2MC9WVKuIe9f/GEm/ES49J+FfXdQrFv/vfZG0aJKQyXNi5idQ683jgrSLCNqFlpOY/UWcLWk1OMvXBAeUxQReKxi9C4KWM3/3HrrJ1WUQ8f9zrab7g1jXW5meBHS1tmrWzcXyOtkjUGwKZ5WCWmQNSLb6T3PC4FMiztSJEtORxGKXs1+61bRGtw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774644915; c=relaxed/relaxed;
	bh=gEJVuDKnjdgqU8zwIL3/sLmobVk+HSWnDM5ddTiDQu8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Lw4l/LPFymbvm/KuJQob9E9qkTnGyseFoRF/BfxJL3MFViMRyil/Z7Rf/WCmtsQGSFta9GshWH/xnrnxg/DuqimGj3MwjgoFvFo7lNoxZuHk/mTRV3iJhsRrta9+ivfKh+dHLK4d/L0vZS0HqeLb8H+Z0p9ugYIIi2XcPoYwiJWU4ubDGTQZIO9bEn3XCgSM8tOadLAwwjQWo+1NtjuYFqx+GIFhtYDR0cuxghzYlqEAMfDStfdmQWFxytYbjaPZRRw3MKYqx6DEFoTQWzxkD91/HP/fiejLNrAp9qU5+J9nn7jGCok16uXsjO2lYPfJuduoomgk7KOnWIQkBAlM/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=b4qcdKoa; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1249; helo=mail-dl1-x1249.google.com; envelope-from=3so7gaqykdp0xzwjsglttlqj.htrqnsz2uuh-ij0qnxyx.t4qfgx.twl@flex--surenb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=b4qcdKoa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--surenb.bounces.google.com (client-ip=2607:f8b0:4864:20::1249; helo=mail-dl1-x1249.google.com; envelope-from=3so7gaqykdp0xzwjsglttlqj.htrqnsz2uuh-ij0qnxyx.t4qfgx.twl@flex--surenb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1249.google.com (mail-dl1-x1249.google.com [IPv6:2607:f8b0:4864:20::1249])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fjCZp4yxtz2ysZ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2026 07:55:14 +1100 (AEDT)
Received: by mail-dl1-x1249.google.com with SMTP id a92af1059eb24-127876be621so1606524c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 13:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774644913; x=1775249713; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gEJVuDKnjdgqU8zwIL3/sLmobVk+HSWnDM5ddTiDQu8=;
        b=b4qcdKoaWEaTYpD5LOEJ1I8D/Oa0oHXW7QI5XUeLT68b0/CUFzmZ612GAiQriX3e05
         CDJEwRGfEBYXFKV2XzB7vZgmVstVlL+mv+/VbyEyElBvG3XAjLGSV7StOan++g5SRX87
         lniq258tVZPPaF3hTi7SS4+kbMSTCDuhESahlB+Bga+2wrwM7tAHEHoUVQJ/hX7zmwFi
         TLFlLVprR0eqZINHevAlB1AbGTCU6S1BrbWIHClzD5xi6/m5DEF3sjLPgHGAyYAow3pa
         UqRiUxM4Am352SelNoRlY8umRZGFGtsbBJlWXe8ksuEvJQtnnDN2mUiM9GeQ4WkmmtCg
         YiuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774644913; x=1775249713;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gEJVuDKnjdgqU8zwIL3/sLmobVk+HSWnDM5ddTiDQu8=;
        b=VQGun9WUWBaqJBOVuPnaoREr/xlgmbp5A6WRSoZ4eOls71Rq9HBBkjiMnSqEGkWnAm
         xrTXU2TECXSqYL+RHSFNPQn0DTLGZf0GynJi8R8P7pxmC4uSd6yCluec6w+S5BBfDnWb
         DEWOMwndIEnl+8GRBHYywiYi5du23/9uNY/TH1uT65ldV0qz4GVUxVk1ELVH+4ER2Dqy
         R0JrNkOJ7+Qx+fqBxvBx4lXM7CU8yGRqvAhHQO3PQiURYOpFzghvh/v0JNMD65XZYrN/
         PWRT+fgRCbA4ciNN+fPXbX9z4Ku66eElnTRrNeV4JaBhmHe/77CRD7r2HzQB+Q+r8Xiz
         pjQw==
X-Forwarded-Encrypted: i=1; AJvYcCVA68NJQ+BrzfCIjTwJYXo1vNoydFdkwu4Fy34iSAUP4wp+Dt/kGSUGWnn1cnLW5rRlDuEZ6T66H8+R0/Y=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw/6qykuPT0CPqB3W/NIdt2cSNR0jqiUUBvZyzcqxqNiKQUryp8
	/vwF/TEShCqk+ThCKcQ7FBonG5ear5+39aOZCuXtO/S4N2xRWAIhTAmMdUeb6KNaccYECQtFk7m
	UQIGx+A==
X-Received: from dly16-n1.prod.google.com ([2002:a05:701b:2050:10b0:12a:7f27:56f7])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6099:b0:119:e569:f874
 with SMTP id a92af1059eb24-12ab3045876mr1405563c88.17.1774644912438; Fri, 27
 Mar 2026 13:55:12 -0700 (PDT)
Date: Fri, 27 Mar 2026 13:54:56 -0700
In-Reply-To: <20260327205457.604224-1-surenb@google.com>
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
Mime-Version: 1.0
References: <20260327205457.604224-1-surenb@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260327205457.604224-6-surenb@google.com>
Subject: [PATCH v6 5/6] mm: use vma_start_write_killable() in process_vma_walk_lock()
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, david@kernel.org, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, ljs@kernel.org, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, 
	jannh@google.com, rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, 
	kees@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Replace vma_start_write() with vma_start_write_killable() when
process_vma_walk_lock() is used with PGWALK_WRLOCK option.
Adjust its direct and indirect users to check for a possible error
and handle it. Ensure users handle EINTR correctly and do not ignore
it. When queue_pages_range() fails, check whether it failed due to
a fatal signal or some other reason and return appropriate error.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 fs/proc/task_mmu.c | 12 ++++++------
 mm/mempolicy.c     | 10 +++++++++-
 mm/pagewalk.c      | 22 +++++++++++++++-------
 3 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index e091931d7ca1..33e5094a7842 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1774,15 +1774,15 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 	struct vm_area_struct *vma;
 	enum clear_refs_types type;
 	int itype;
-	int rv;
+	int err;
 
 	if (count > sizeof(buffer) - 1)
 		count = sizeof(buffer) - 1;
 	if (copy_from_user(buffer, buf, count))
 		return -EFAULT;
-	rv = kstrtoint(strstrip(buffer), 10, &itype);
-	if (rv < 0)
-		return rv;
+	err = kstrtoint(strstrip(buffer), 10, &itype);
+	if (err)
+		return err;
 	type = (enum clear_refs_types)itype;
 	if (type < CLEAR_REFS_ALL || type >= CLEAR_REFS_LAST)
 		return -EINVAL;
@@ -1824,7 +1824,7 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 						0, mm, 0, -1UL);
 			mmu_notifier_invalidate_range_start(&range);
 		}
-		walk_page_range(mm, 0, -1, &clear_refs_walk_ops, &cp);
+		err = walk_page_range(mm, 0, -1, &clear_refs_walk_ops, &cp);
 		if (type == CLEAR_REFS_SOFT_DIRTY) {
 			mmu_notifier_invalidate_range_end(&range);
 			flush_tlb_mm(mm);
@@ -1837,7 +1837,7 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 	}
 	put_task_struct(task);
 
-	return count;
+	return err ? : count;
 }
 
 const struct file_operations proc_clear_refs_operations = {
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index c38a90487531..51f298cfc33b 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -969,6 +969,7 @@ static const struct mm_walk_ops queue_pages_lock_vma_walk_ops = {
  *      (a hugetlbfs page or a transparent huge page being counted as 1).
  * -EIO - a misplaced page found, when MPOL_MF_STRICT specified without MOVEs.
  * -EFAULT - a hole in the memory range, when MPOL_MF_DISCONTIG_OK unspecified.
+ * -EINTR - walk got terminated due to pending fatal signal.
  */
 static long
 queue_pages_range(struct mm_struct *mm, unsigned long start, unsigned long end,
@@ -1545,7 +1546,14 @@ static long do_mbind(unsigned long start, unsigned long len,
 			flags | MPOL_MF_INVERT | MPOL_MF_WRLOCK, &pagelist);
 
 	if (nr_failed < 0) {
-		err = nr_failed;
+		/*
+		 * queue_pages_range() might override the original error with -EFAULT.
+		 * Confirm that fatal signals are still treated correctly.
+		 */
+		if (fatal_signal_pending(current))
+			err = -EINTR;
+		else
+			err = nr_failed;
 		nr_failed = 0;
 	} else {
 		vma_iter_init(&vmi, mm, start);
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 3ae2586ff45b..eca7bc711617 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -443,14 +443,13 @@ static inline void process_mm_walk_lock(struct mm_struct *mm,
 		mmap_assert_write_locked(mm);
 }
 
-static inline void process_vma_walk_lock(struct vm_area_struct *vma,
-					 enum page_walk_lock walk_lock)
+static int process_vma_walk_lock(struct vm_area_struct *vma,
+				 enum page_walk_lock walk_lock)
 {
 #ifdef CONFIG_PER_VMA_LOCK
 	switch (walk_lock) {
 	case PGWALK_WRLOCK:
-		vma_start_write(vma);
-		break;
+		return vma_start_write_killable(vma);
 	case PGWALK_WRLOCK_VERIFY:
 		vma_assert_write_locked(vma);
 		break;
@@ -462,6 +461,7 @@ static inline void process_vma_walk_lock(struct vm_area_struct *vma,
 		break;
 	}
 #endif
+	return 0;
 }
 
 /*
@@ -505,7 +505,9 @@ int walk_page_range_mm_unsafe(struct mm_struct *mm, unsigned long start,
 			if (ops->pte_hole)
 				err = ops->pte_hole(start, next, -1, &walk);
 		} else { /* inside vma */
-			process_vma_walk_lock(vma, ops->walk_lock);
+			err = process_vma_walk_lock(vma, ops->walk_lock);
+			if (err)
+				break;
 			walk.vma = vma;
 			next = min(end, vma->vm_end);
 			vma = find_vma(mm, vma->vm_end);
@@ -722,6 +724,7 @@ int walk_page_range_vma_unsafe(struct vm_area_struct *vma, unsigned long start,
 		.vma		= vma,
 		.private	= private,
 	};
+	int err;
 
 	if (start >= end || !walk.mm)
 		return -EINVAL;
@@ -729,7 +732,9 @@ int walk_page_range_vma_unsafe(struct vm_area_struct *vma, unsigned long start,
 		return -EINVAL;
 
 	process_mm_walk_lock(walk.mm, ops->walk_lock);
-	process_vma_walk_lock(vma, ops->walk_lock);
+	err = process_vma_walk_lock(vma, ops->walk_lock);
+	if (err)
+		return err;
 	return __walk_page_range(start, end, &walk);
 }
 
@@ -752,6 +757,7 @@ int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
 		.vma		= vma,
 		.private	= private,
 	};
+	int err;
 
 	if (!walk.mm)
 		return -EINVAL;
@@ -759,7 +765,9 @@ int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
 		return -EINVAL;
 
 	process_mm_walk_lock(walk.mm, ops->walk_lock);
-	process_vma_walk_lock(vma, ops->walk_lock);
+	err = process_vma_walk_lock(vma, ops->walk_lock);
+	if (err)
+		return err;
 	return __walk_page_range(vma->vm_start, vma->vm_end, &walk);
 }
 
-- 
2.53.0.1018.g2bb0e51243-goog


