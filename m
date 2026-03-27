Return-Path: <linuxppc-dev+bounces-18947-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F9A10F2873
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 23:12:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fjGdC6WXmz2yfs;
	Sat, 28 Mar 2026 10:12:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774653151;
	cv=none; b=iwR5Pxdb+5Ovr83AdJ9zHHYgHx80FENCnvcyNUuhkardDGCJ1Mv0GLB23iU754ACCro9x4yzFaqZunUeOzYT1K5T4IhiSLlf4GCLm+4IvANZusEdQL/yqaq7jnRp3xyqMVOTIlupCZrCQtlOw2a51yol5SMAB/cMNfCBIfCaoSlgf2FYU7IBpYPikLaFVNXk76DhwbTi1TL8EnMzeenQo6RuKi4w1Kv/cauSAv0x2Lt1t/6F2uPX/QHW/3DNcPT8R2uNMNnOFtI1VzAEkOt+5tbqqS77UzuT6pFlOg5EiE4PFf4lLuCYZwMAXzJYlCl8AzbWLzfFtStUJp8u4woyqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774653151; c=relaxed/relaxed;
	bh=jEu5gE3EAcKlNIGUMVJ8q/E+axVpWQDakv9ZFMRW6pQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SEZ4cfqqjwNaRfk9ChEObmpZrd4qOhSP9vxKclzHUCWd3PBypEyGxQh9m09KMcHU/CRLt7AGb5mlKytk/9QGfvDPFiZuyDYNyxkbX/jQfluLJVjB2Y1A0QInwPFHw+9dSQWfB1gPfuDXCWpK/v//io7JAUewZfEMXZezltjRc8d3TeV22lB5ZqUkVcFL8Q7gPuZEXdfvfZwuwvdqChvq3BLZqOpzKk5qVcF3U5e2/kIjKO+OxUmF+saPksQHN6iIjtAHMpOBWoGfstDbnw/huSHEXLlvkNlREK355n4MAcJgqTFzv5tULf0J4DTDUtYnS0fNpsd733F3x54JZhz+jw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=hnjqldU8; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=hnjqldU8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fjGdC18Kmz2yWy
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2026 10:12:31 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9696943D91;
	Fri, 27 Mar 2026 23:12:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463A0C19423;
	Fri, 27 Mar 2026 23:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774653148;
	bh=w1fTuAjXMyl/GScY/+S+eWbLwpZUW4tJ0vj0923OX6M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hnjqldU8IwG/KospdgYRAHBNnkUY70IPRN2FdImpTUHY5Ipc1O2WoLzskt7pgTDyt
	 THO1IykYjgEmb0djrhgfZHA3RV8K0MCWuMZp85gPrkYlXwbZrSCb+wGAr4hk2Q4jbi
	 xWdCsYUN6aepYsEJtNWngi+6v7KeJPsg19ndsgPU=
Date: Fri, 27 Mar 2026 16:12:26 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: willy@infradead.org, david@kernel.org, ziy@nvidia.com,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com,
 apopple@nvidia.com, ljs@kernel.org, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz,
 jannh@google.com, rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de,
 kees@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com,
 mpe@ellerman.id.au, chleroy@kernel.org, borntraeger@linux.ibm.com,
 frankja@linux.ibm.com, imbrenda@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com,
 gerald.schaefer@linux.ibm.com, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v6 0/6] Use killable vma write locking in most places
Message-Id: <20260327161226.17e680fec33117d67dc8b5f9@linux-foundation.org>
In-Reply-To: <20260327205457.604224-1-surenb@google.com>
References: <20260327205457.604224-1-surenb@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Mar 2026 13:54:51 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> Now that we have vma_start_write_killable() we can replace most of the
> vma_start_write() calls with it, improving reaction time to the kill
> signal.
> 
> There are several places which are left untouched by this patchset:
> 
> 1. free_pgtables() because function should free page tables even if a
> fatal signal is pending.
> 
> 2. userfaultd code, where some paths calling vma_start_write() can
> handle EINTR and some can't without a deeper code refactoring.
> 
> 3. mpol_rebind_mm() which is used by cpusset controller for migrations
> and operates on a remote mm. Incomplete operations here would result
> in an inconsistent cgroup state.
> 
> 4. vm_flags_{set|mod|clear} require refactoring that involves moving
> vma_start_write() out of these functions and replacing it with
> vma_assert_write_locked(), then callers of these functions should
> lock the vma themselves using vma_start_write_killable() whenever
> possible.

Updated, thanks.

> Changes since v5 [1]:
> - Added Reviewed-by for unchanged patches, per Lorenzo Stoakes
> 
> Patch#2:
> - Fixed locked_vm counter if mlock_vma_pages_range() fails in
> mlock_fixup(), per Sashiko
> - Avoid VMA re-locking in madvise_update_vma(), mprotect_fixup() and
> mseal_apply() when vma_modify_XXX creates a new VMA as it will already be
> locked. This prevents the possibility of incomplete operation if signal
> happens after a successful vma_modify_XXX modified the vma tree,
> per Sashiko
> - Removed obsolete comment in madvise_update_vma() and mprotect_fixup()
> 
> Patch#4:
> - Added clarifying comment for vma_start_write_killable() when locking a
> detached VMA
> - Override VMA_MERGE_NOMERGE in vma_expand() to prevent callers from
> falling back to a new VMA allocation, per Sashiko
> - Added a note in the changelog about temporary workaround of using
> ENOMEM to propagate the error in vma_merge_existing_range() and
> vma_expand()
> 
> Patch#5:
> - Added fatal_signal_pending() check in do_mbind() to detect
> queue_pages_range() failures due to a pendig fatal signal, per Sashiko

Changes since v5:


 mm/madvise.c   |   15 ++++++++++-----
 mm/mempolicy.c |    9 ++++++++-
 mm/mlock.c     |    2 ++
 mm/mprotect.c  |   26 ++++++++++++++++----------
 mm/mseal.c     |   27 +++++++++++++++++++--------
 mm/vma.c       |   20 ++++++++++++++++++--
 6 files changed, 73 insertions(+), 26 deletions(-)

--- a/mm/madvise.c~b
+++ a/mm/madvise.c
@@ -172,11 +172,16 @@ static int madvise_update_vma(vm_flags_t
 	if (IS_ERR(vma))
 		return PTR_ERR(vma);
 
-	madv_behavior->vma = vma;
-
-	/* vm_flags is protected by the mmap_lock held in write mode. */
-	if (vma_start_write_killable(vma))
-		return -EINTR;
+	/*
+	 * If a new vma was created during vma_modify_XXX, the resulting
+	 * vma is already locked. Skip re-locking new vma in this case.
+	 */
+	if (vma == madv_behavior->vma) {
+		if (vma_start_write_killable(vma))
+			return -EINTR;
+	} else {
+		madv_behavior->vma = vma;
+	}
 
 	vma->flags = new_vma_flags;
 	if (set_new_anon_name)
--- a/mm/mempolicy.c~b
+++ a/mm/mempolicy.c
@@ -1546,7 +1546,14 @@ static long do_mbind(unsigned long start
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
--- a/mm/mlock.c~b
+++ a/mm/mlock.c
@@ -518,6 +518,8 @@ static int mlock_fixup(struct vma_iterat
 		vma->flags = new_vma_flags;
 	} else {
 		ret = mlock_vma_pages_range(vma, start, end, &new_vma_flags);
+		if (ret)
+			mm->locked_vm -= nr_pages;
 	}
 out:
 	*prev = vma;
--- a/mm/mprotect.c~b
+++ a/mm/mprotect.c
@@ -716,6 +716,7 @@ mprotect_fixup(struct vma_iterator *vmi,
 	const vma_flags_t old_vma_flags = READ_ONCE(vma->flags);
 	vma_flags_t new_vma_flags = legacy_to_vma_flags(newflags);
 	long nrpages = (end - start) >> PAGE_SHIFT;
+	struct vm_area_struct *new_vma;
 	unsigned int mm_cp_flags = 0;
 	unsigned long charged = 0;
 	int error;
@@ -772,21 +773,26 @@ mprotect_fixup(struct vma_iterator *vmi,
 		vma_flags_clear(&new_vma_flags, VMA_ACCOUNT_BIT);
 	}
 
-	vma = vma_modify_flags(vmi, *pprev, vma, start, end, &new_vma_flags);
-	if (IS_ERR(vma)) {
-		error = PTR_ERR(vma);
+	new_vma = vma_modify_flags(vmi, *pprev, vma, start, end,
+				   &new_vma_flags);
+	if (IS_ERR(new_vma)) {
+		error = PTR_ERR(new_vma);
 		goto fail;
 	}
 
-	*pprev = vma;
-
 	/*
-	 * vm_flags and vm_page_prot are protected by the mmap_lock
-	 * held in write mode.
+	 * If a new vma was created during vma_modify_flags, the resulting
+	 * vma is already locked. Skip re-locking new vma in this case.
 	 */
-	error = vma_start_write_killable(vma);
-	if (error)
-		goto fail;
+	if (new_vma == vma) {
+		error = vma_start_write_killable(vma);
+		if (error)
+			goto fail;
+	} else {
+		vma = new_vma;
+	}
+
+	*pprev = vma;
 
 	vma_flags_reset_once(vma, &new_vma_flags);
 	if (vma_wants_manual_pte_write_upgrade(vma))
--- a/mm/mseal.c~b
+++ a/mm/mseal.c
@@ -70,17 +70,28 @@ static int mseal_apply(struct mm_struct
 
 		if (!vma_test(vma, VMA_SEALED_BIT)) {
 			vma_flags_t vma_flags = vma->flags;
-			int err;
+			struct vm_area_struct *new_vma;
 
 			vma_flags_set(&vma_flags, VMA_SEALED_BIT);
 
-			vma = vma_modify_flags(&vmi, prev, vma, curr_start,
-					       curr_end, &vma_flags);
-			if (IS_ERR(vma))
-				return PTR_ERR(vma);
-			err = vma_start_write_killable(vma);
-			if (err)
-				return err;
+			new_vma = vma_modify_flags(&vmi, prev, vma, curr_start,
+						   curr_end, &vma_flags);
+			if (IS_ERR(new_vma))
+				return PTR_ERR(new_vma);
+
+			/*
+			 * If a new vma was created during vma_modify_flags,
+			 * the resulting vma is already locked.
+			 * Skip re-locking new vma in this case.
+			 */
+			if (new_vma == vma) {
+				int err = vma_start_write_killable(vma);
+				if (err)
+					return err;
+			} else {
+				vma = new_vma;
+			}
+
 			vma_set_flags(vma, VMA_SEALED_BIT);
 		}
 
--- a/mm/vma.c~b
+++ a/mm/vma.c
@@ -531,6 +531,10 @@ __split_vma(struct vma_iterator *vmi, st
 	err = vma_start_write_killable(vma);
 	if (err)
 		goto out_free_vma;
+	/*
+	 * Locking a new detached VMA will always succeed but it's just a
+	 * detail of the current implementation, so handle it all the same.
+	 */
 	err = vma_start_write_killable(new);
 	if (err)
 		goto out_free_vma;
@@ -1197,8 +1201,14 @@ int vma_expand(struct vma_merge_struct *
 
 	mmap_assert_write_locked(vmg->mm);
 	err = vma_start_write_killable(target);
-	if (err)
+	if (err) {
+		/*
+		 * Override VMA_MERGE_NOMERGE to prevent callers from
+		 * falling back to a new VMA allocation.
+		 */
+		vmg->state = VMA_MERGE_ERROR_NOMEM;
 		return err;
+	}
 
 	target_sticky = vma_flags_and_mask(&target->flags, VMA_STICKY_FLAGS);
 
@@ -1231,8 +1241,14 @@ int vma_expand(struct vma_merge_struct *
 		 * is pending.
 		 */
 		err = vma_start_write_killable(next);
-		if (err)
+		if (err) {
+			/*
+			 * Override VMA_MERGE_NOMERGE to prevent callers from
+			 * falling back to a new VMA allocation.
+			 */
+			vmg->state = VMA_MERGE_ERROR_NOMEM;
 			return err;
+		}
 		err = dup_anon_vma(target, next, &anon_dup);
 		if (err)
 			return err;
_


