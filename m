Return-Path: <linuxppc-dev+bounces-18815-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9FDA106F2F3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2026 08:09:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhGd30bJkz2yv1;
	Thu, 26 Mar 2026 19:08:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1349"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774512535;
	cv=none; b=kvd4++9OlI/vsPPk25kQK+KGSbzkXFrKxEltrdbEc/u+w6Ex4SH+k1TJqR/3fi3fty8wuQ16zJQ/xaUAQakW/YLgJz3a4ELVgOwE3/hjNXVYv5u9u+9B16zaCWnfF8RGw890P+tMMzcX2SFMW7ggxdjfTaKeCvJmsN2vkmajCKlyxxPWRQzau/OmMW2w9Yu43E6RNd9NFsAvpnb7jwfTYFpmSXSH/EV4Az7UbBg220YFukyAyw7JjyQYS83qILZp4MBLDndI3WQ3Rlm/6Mrfh9eMv0b4H7U9V8t6MNz8zY1CgwrJEHGIYpVemWl/UFgNc+HqU6RxZQ1GLTyK++MRjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774512535; c=relaxed/relaxed;
	bh=A2FZ0j4JsuEtXH0QE0EGuqUW1/fY5oq45gPlzlHIXGA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EX02jgiFDn6SNljDdR49jvNgoOvws6GiE/XZ3GFIMMMIoQ4I+fRYV6kFpd8qYOG3sYfrbsUpt7xiLn5jb6kFuhXWT7EB/qEvstgHjxTt3pjzelHMmahRYfXphDdWTS1XkU4NzRT/RLO4WZTZyfHkvwOU5cpsLvTmVANcdpo8CBbkYYouERIncpSCQ+ABVFY1CnM+2fWmMnzKFGoafm4XNDGvBvh/tL1vkqP9XMEdUkUfapNN0c0DEejTbABUOM2VPhaKUAL7jtPBmjRuu1ExaZdZyOf4kxo8YvCv6WllNiTlwJwTw6ecTpId+8rV/WqiFxMJhqKnTXlvn8qBwX/tkQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=weKux7oI; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1349; helo=mail-dy1-x1349.google.com; envelope-from=3k-neaqykdm4ceby7v08805y.w86527eh99w-xyf52cdc.8j5uvc.8b0@flex--surenb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=weKux7oI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--surenb.bounces.google.com (client-ip=2607:f8b0:4864:20::1349; helo=mail-dy1-x1349.google.com; envelope-from=3k-neaqykdm4ceby7v08805y.w86527eh99w-xyf52cdc.8j5uvc.8b0@flex--surenb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1349.google.com (mail-dy1-x1349.google.com [IPv6:2607:f8b0:4864:20::1349])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhGd22yN3z2yrb
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 19:08:54 +1100 (AEDT)
Received: by mail-dy1-x1349.google.com with SMTP id 5a478bee46e88-2c16233ee11so726346eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 01:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774512533; x=1775117333; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A2FZ0j4JsuEtXH0QE0EGuqUW1/fY5oq45gPlzlHIXGA=;
        b=weKux7oINzBukacM8eJOJkrkMbGtCAFuIwh8OOEwbvGxFMLKK4I2zwGxcQZn0oqXuU
         IuuRYK2uxWyY+B3kX7l578tnq4dJCNoVeU83gAIIxKKbuSZ6Ia4PRljvEk5cj3R2j9E6
         QarqxM294hFf+zioJzEAhPApqAo4oLeV6P2Uh/WbXes2LP6UelZF6YjrcCDdQJs8VhIV
         VgfvKQtHPs9crY1xFGx14Pi7UdxF1/iLX4Fnv3oeVX8tA4snNkR86IZ16lFOjLR2jGOL
         6s36nBbjU21tO6dUlSm1wutGB7yXjNY9YbeyacM2ux36MGqKa6hm89ofwgj8z9+bEwUB
         aevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774512533; x=1775117333;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A2FZ0j4JsuEtXH0QE0EGuqUW1/fY5oq45gPlzlHIXGA=;
        b=leZarYpSKIUDnxZYcfERz0lH0GXUw+ybKcoei/L/jjqAX8/u5BUl84WXMOqU7tBp2c
         eXIskmOe9ZInbhfGRfu8gcsZ2MpRMURL3w1UufclqVIh56nRgacf3HB7JZf81i/qQ3xc
         7jpMEnXEWQCgL5NazvOBrkEd8PmlBvfQ3O0eD4Mb6OOqBmVcCTAe22QWUpdAcXHGVBAt
         t6JJJ5brJt5McKh92m3iSoGHEGoc30gYyXy6jICi+gKoOB6HCM8Rf+6LUoauqj+jPzao
         2XHYV5Y4Xjp+KaPMfRMsTM/mnzhTuYOntvTf6FMJoB+1lIlLL6hskXESZnny4/6O/4x6
         0few==
X-Forwarded-Encrypted: i=1; AJvYcCW5N91TkyhyIZPo4XNwVZJfpreb9TfmsIT0yvTUfmoF5xRAHmw+pmZDIqi4DELRyY91qrJRTXu4/j7uYew=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxMZq7fAO2F6v/R7bPZU91ftt+wg41gjZlNO2SidK/depAgodit
	oDakBdMlgdjskjMAHDvG2s1PQJ8QaSj2DhXt78Dgr+kpvPjX+7dODW1EMSbSmJkXQZ0IGM0X7cO
	Xeu9C3A==
X-Received: from dycrm24.prod.google.com ([2002:a05:693c:2a18:b0:2c1:4f1:c859])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:8b05:b0:2c1:161f:ac39
 with SMTP id 5a478bee46e88-2c15d3e3b8cmr3740873eec.26.1774512531898; Thu, 26
 Mar 2026 01:08:51 -0700 (PDT)
Date: Thu, 26 Mar 2026 01:08:35 -0700
In-Reply-To: <20260326080836.695207-1-surenb@google.com>
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
References: <20260326080836.695207-1-surenb@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260326080836.695207-6-surenb@google.com>
Subject: [PATCH v5 5/6] mm: use vma_start_write_killable() in process_vma_walk_lock()
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, david@kernel.org, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com, 
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
it.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 fs/proc/task_mmu.c | 12 ++++++------
 mm/mempolicy.c     |  1 +
 mm/pagewalk.c      | 22 +++++++++++++++-------
 3 files changed, 22 insertions(+), 13 deletions(-)

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
index c38a90487531..336753a4b2b2 100644
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


