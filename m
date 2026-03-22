Return-Path: <linuxppc-dev+bounces-18556-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CEFCFC72AB
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Mar 2026 05:43:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fdlb046zTz2yqq;
	Sun, 22 Mar 2026 16:43:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1349"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774158204;
	cv=none; b=GVxtXpZseBVyt+ZKrmw3QOt48pvKASGn7ldxk4VIpUiRhH6tI5dNMcgsVdeQuTKOBEclBtjEl64iGr34tnvMQZI1vi1qjhrJDvxD2pTSxEIO/93camT48IeP9V7+5cb78dzYN0bBcCEmXsVDVJC9pFRYtl8rf0odGGZ+e80lk56hmTIyn6kyr15ZzducSF4HyNvZNw2owd6SZHYwDbfhBbYk/1tV1DJdGWITR0J9KcuAxdc4u6Fmb1JQLz2T275QIO7zSQgArWdhPEV+shNAji4HJwxnrOG40Sm+W8GHI0B/aPwm5nWZ6BJaB77VslUutetuDtZCKH6hSpPG4uzXIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774158204; c=relaxed/relaxed;
	bh=pyZbVSMoPQsW5Fww5l9TjItBhtVQ4rSW6pB2FXRdwC8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LniZ0Tt0WGAcKYOwKm2cGbeV6EbJ1Gpnv+BYLtxyi9of+CE+vwOtlmMZSDAO1+D8UIMt0ct6YMaTIeoOiAtRZHk2MqLWc7vD/C/LGjf7qJ4SONpzq6znEg+0M7/vq6rPKTMW9MnxCMgoO/LQaOMn0H8bLRV1GNplvsy2L2JPbIOUNcJf0No9bb0yxHstCBGte+EzRmnPL45DAfhjN7MT/0jD0jF+s4zJl51EUptZqq068RiiWvuBWmtiCzXZ5m+v9LzXGJAD5l/6IeA4vvyBMu6m8/SBYGblGgo5P5tV9LaHcJH7wriiDY9lwiLXAqmTYxFVctUxUVPkmqY9L3GN4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=IMS2DpuQ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1349; helo=mail-dy1-x1349.google.com; envelope-from=3eyg_aqykdm4ceby7v08805y.w86527eh99w-xyf52cdc.8j5uvc.8b0@flex--surenb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=IMS2DpuQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--surenb.bounces.google.com (client-ip=2607:f8b0:4864:20::1349; helo=mail-dy1-x1349.google.com; envelope-from=3eyg_aqykdm4ceby7v08805y.w86527eh99w-xyf52cdc.8j5uvc.8b0@flex--surenb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1349.google.com (mail-dy1-x1349.google.com [IPv6:2607:f8b0:4864:20::1349])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fdlZz5RNFz2xlr
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Mar 2026 16:43:23 +1100 (AEDT)
Received: by mail-dy1-x1349.google.com with SMTP id 5a478bee46e88-2bdf6fe90a9so3196657eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2026 22:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774158202; x=1774763002; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pyZbVSMoPQsW5Fww5l9TjItBhtVQ4rSW6pB2FXRdwC8=;
        b=IMS2DpuQL1sDZp/ECaEX62xVBCmy/hPU7NBlIfwg1j4g0TCWEaF//RfGaG+xtisWjv
         hAIiuch+ybM+zOe43F870sFbnkZ2XTi0Iik//5ro57evxv757KGoBOVhW4fSazq7lSie
         2+WHkHUCcJOmjLyTxTocJB/5KvWOPa6ZnEO1BCOYPWaDDZGFvzW/qLZHOvxkcvo0noTE
         WQ7B1RXuZyvllEM6EZXeUblWWC4KB3ex2DEfTMDHRfG7Dd6AuPeB8c/uBTWqyEqVVcwm
         QiUNJVd/Ln4Ph7EfeT1s7YLnd29xKCTDGpcevOstoTr5HownfIlIFVzhBWtyYSVWtaY3
         VnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774158202; x=1774763002;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pyZbVSMoPQsW5Fww5l9TjItBhtVQ4rSW6pB2FXRdwC8=;
        b=LeCz9ufWHyxSIi0N/H/p4hpYt+8rg8WSxqpNAlrfN+yU59ccvIwdSvX0nTEyWBBXwj
         J6qLqGxBPjOtmhGVOaae7Qi6YuPA7TsI20kWjCLFuN8Ptf8MZ9942NtF3HeSMgSmRtiv
         o0P9gupYz+QKfBcWQxpfIMaInxIoLHWI88X0TBs5nse/97vyG5G+j3fHwDJ9wiVDP7Ae
         JL57hi9Hm/VQeh+a9meKo1yO9SqZWOSFna5kNSpSLbQxcizdxbFC9axBvu260eYpPVBz
         5O755uW4HV0v9Dd0Pk5mub4Ig+6GpXvKn2oBJdpGL1CiMpOPoupDHXkTWkzMCMX5xxPN
         6CRw==
X-Forwarded-Encrypted: i=1; AJvYcCUp9EYD81tLBH4mwEgVtXMuL3f4lDPDFmJkedtju+UmSNdu//kE7AC6pnl8Zde0AqGQCxe6hWjAhjIJKgM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyncPIwWXCs8N1AVJSXIozVeZH5DZqRWkfMTZixTX2iCDhqXuwU
	1wbn/gsAm3iSKIJazYtnWNscLPObkkd4bpfwG6FhyrGoCVg7glwbMlo17w93qq+MNUK4OeHNN2/
	lw0coqg==
X-Received: from dyx25.prod.google.com ([2002:a05:693c:8219:b0:2c0:c743:7f67])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:220f:b0:119:e56b:98b9
 with SMTP id a92af1059eb24-12a726bb993mr3455319c88.32.1774158201439; Sat, 21
 Mar 2026 22:43:21 -0700 (PDT)
Date: Sat, 21 Mar 2026 22:43:08 -0700
In-Reply-To: <20260322054309.898214-1-surenb@google.com>
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
References: <20260322054309.898214-1-surenb@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260322054309.898214-5-surenb@google.com>
Subject: [PATCH v4 4/4] mm: use vma_start_write_killable() in process_vma_walk_lock()
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

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 fs/proc/task_mmu.c |  5 ++++-
 mm/mempolicy.c     |  1 +
 mm/pagewalk.c      | 20 ++++++++++++++------
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index e091931d7ca1..2fe3d11aad03 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1797,6 +1797,7 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 		struct clear_refs_private cp = {
 			.type = type,
 		};
+		int err;
 
 		if (mmap_write_lock_killable(mm)) {
 			count = -EINTR;
@@ -1824,7 +1825,9 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 						0, mm, 0, -1UL);
 			mmu_notifier_invalidate_range_start(&range);
 		}
-		walk_page_range(mm, 0, -1, &clear_refs_walk_ops, &cp);
+		err = walk_page_range(mm, 0, -1, &clear_refs_walk_ops, &cp);
+		if (err)
+			count = err;
 		if (type == CLEAR_REFS_SOFT_DIRTY) {
 			mmu_notifier_invalidate_range_end(&range);
 			flush_tlb_mm(mm);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 929e843543cf..bb5b0e83ce0f 100644
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
index eda74273c8ec..a42cd6a6d812 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -438,14 +438,13 @@ static inline void process_mm_walk_lock(struct mm_struct *mm,
 		mmap_assert_write_locked(mm);
 }
 
-static inline void process_vma_walk_lock(struct vm_area_struct *vma,
+static inline int process_vma_walk_lock(struct vm_area_struct *vma,
 					 enum page_walk_lock walk_lock)
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
@@ -457,6 +456,7 @@ static inline void process_vma_walk_lock(struct vm_area_struct *vma,
 		break;
 	}
 #endif
+	return 0;
 }
 
 /*
@@ -500,7 +500,9 @@ int walk_page_range_mm_unsafe(struct mm_struct *mm, unsigned long start,
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
@@ -717,6 +719,7 @@ int walk_page_range_vma_unsafe(struct vm_area_struct *vma, unsigned long start,
 		.vma		= vma,
 		.private	= private,
 	};
+	int err;
 
 	if (start >= end || !walk.mm)
 		return -EINVAL;
@@ -724,7 +727,9 @@ int walk_page_range_vma_unsafe(struct vm_area_struct *vma, unsigned long start,
 		return -EINVAL;
 
 	process_mm_walk_lock(walk.mm, ops->walk_lock);
-	process_vma_walk_lock(vma, ops->walk_lock);
+	err = process_vma_walk_lock(vma, ops->walk_lock);
+	if (err)
+		return err;
 	return __walk_page_range(start, end, &walk);
 }
 
@@ -747,6 +752,7 @@ int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
 		.vma		= vma,
 		.private	= private,
 	};
+	int err;
 
 	if (!walk.mm)
 		return -EINVAL;
@@ -754,7 +760,9 @@ int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
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


