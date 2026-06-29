Return-Path: <linuxppc-dev+bounces-23137-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD13C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 19:27:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gpx93167Nz301Y;
	Tue, 30 Jun 2026 05:26:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782761191;
	cv=none; b=ZHTAw8lmqUSDI8PJzKkTmvHZB8G2CxgAk9VCkoY0s1rQyOgvt9NBWYIWCraXfLfcYyjeADCKe12wY5tashcqofQSEnCnkK7y/sOVu9OGCPAieCJHNgd5YbZ3/noYqHeW5xTWrFwjlmP5ZwAQpSeB24PwR9hVEf7RlZzreocXvdBLsoFw90lZcm9acxw7xcOJCwkKMdyLuDDlzsdNjoL6X8XiTKdnIOPDikpyTr36vuqogGuSu3IKIEQzto3SmUhK085zGMFGUznmaq0r9KLrxq5oLGVSjx3ONIZtPsJn/i8jSpE0ekb2sVGWwaj0PG2vIPjbLBOy3jMUvvE1NZo0UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782761191; c=relaxed/relaxed;
	bh=rJBKJgm9VGYkLKxlBKZ5aOjhCtASp65CFyjLBQGRzvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lFbXSXt6Ufp9ajF1NJQ1Xo/W9LsnSdyQ/bQ4K6cDeXsaFNhkoEKk0GL5iDSLbGkDRWTDak6OPS+ovnCD2RYmjZdBbTi1hPe52NcADGESq0/0uYBHmQ4PE4lA0HWM8KGFQHc9WCxoZGy5gqqWOxeEQhQnqAxtUSpRgv/3i+qHB6pSzROFi2GwZZnZrXrSL9gARbRMshqbDbOs77O1EuftAaoac5RyTjvkH2o8Pvdz08n9s97L/xFIEryYADHlCoFaZdneMfpIi0TOOJ3TWDMCW6ymz24fwv6YeDvdsWDBIO0dimu/TYFPs4Pe3LFL3/5eFaP+D8jyEHpgIz6jfcpmIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IIJQxKhw; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IIJQxKhw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpx9228M6z2yd7
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 05:26:30 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 23AF440569;
	Mon, 29 Jun 2026 19:26:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7DF1F000E9;
	Mon, 29 Jun 2026 19:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782761188;
	bh=rJBKJgm9VGYkLKxlBKZ5aOjhCtASp65CFyjLBQGRzvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IIJQxKhweg39/BMqoHOH7kb0/Al+cJWTEI1hioVBPZaDB4qhB2Vb6gTAE5EgKd8i+
	 vKfSoPurTO8PIuLjyUs5WNhfD4gqH5sManMjAeS2pFtPAomy2K2tA9iwWFCCLRozBe
	 80WBl+G+ksIR6HWSGPbvhb/38MdZ9vYyRBKIyMWVOS+AOWbhSlmW8yn0VL2dXg9Cqy
	 yP/BQIl71tGgb5bQL/hpBuwobEq79GN6SA2SmGSur13Y5GsCCLpCQRvCYn4h2DY6RM
	 2uQTclqrErpsIcrjBfB0b+ymG/UVaPwZEumIFLlrW7N/vGNJmRnvO33VIBdwlXHg/1
	 9OKljIZr4sLrA==
From: Lorenzo Stoakes <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Lucas Stach <l.stach@pengutronix.de>,
	Inki Dae <inki.dae@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Zack Rusin <zack.rusin@broadcom.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
	Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
	Helge Deller <deller@gmx.de>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Hugh Dickins <hughd@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Kees Cook <kees@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org,
	etnaviv@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	virtualization@lists.linux.dev,
	intel-xe@lists.freedesktop.org,
	xen-devel@lists.xenproject.org,
	linux-fbdev@vger.kernel.org,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-sound@vger.kernel.org
Subject: [PATCH 11/13] mm/mlock: convert mlock code to use vma_flags_t
Date: Mon, 29 Jun 2026 20:25:34 +0100
Message-ID: <2db16db81538355ca65f778c246d2381c673cad4.1782760670.git.ljs@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1782760670.git.ljs@kernel.org>
References: <cover.1782760670.git.ljs@kernel.org>
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

Replace use of the legacy vm_flags_t flags with vma_flags_t values
throughout the mlock logic.

Additionally update comments to reflect the changes to be consistent.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
---
 mm/mlock.c | 86 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 46 insertions(+), 40 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 9c87b3ced65f..1634b125a519 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -329,7 +329,7 @@ static inline bool allow_mlock_munlock(struct folio *folio,
 	 * be split. And the pages are not in VM_LOCKed VMA
 	 * can be reclaimed.
 	 */
-	if (!(vma->vm_flags & VM_LOCKED))
+	if (!vma_test(vma, VMA_LOCKED_BIT))
 		return true;
 
 	/* folio_within_range() cannot take KSM, but any small folio is OK */
@@ -368,7 +368,7 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 		folio = pmd_folio(*pmd);
 		if (folio_is_zone_device(folio))
 			goto out;
-		if (vma->vm_flags & VM_LOCKED)
+		if (vma_test(vma, VMA_LOCKED_BIT))
 			mlock_folio(folio);
 		else
 			munlock_folio(folio);
@@ -393,7 +393,7 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 		if (!allow_mlock_munlock(folio, vma, start, end, step))
 			goto next_entry;
 
-		if (vma->vm_flags & VM_LOCKED)
+		if (vma_test(vma, VMA_LOCKED_BIT))
 			mlock_folio(folio);
 		else
 			munlock_folio(folio);
@@ -417,8 +417,8 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
  * @end - end of range in @vma
  * @new_vma_flags - the new set of flags for @vma.
  *
- * Called for mlock(), mlock2() and mlockall(), to set @vma VM_LOCKED;
- * called for munlock() and munlockall(), to clear VM_LOCKED from @vma.
+ * Called for mlock(), mlock2() and mlockall(), to set @vma VMA_LOCKED_BIT;
+ * called for munlock() and munlockall(), to clear VMA_LOCKED_BIT from @vma.
  */
 static void mlock_vma_pages_range(struct vm_area_struct *vma,
 	unsigned long start, unsigned long end,
@@ -431,14 +431,14 @@ static void mlock_vma_pages_range(struct vm_area_struct *vma,
 
 	/*
 	 * There is a slight chance that concurrent page migration,
-	 * or page reclaim finding a page of this now-VM_LOCKED vma,
+	 * or page reclaim finding a page of this now-VMA_LOCKED_BIT vma,
 	 * will call mlock_vma_folio() and raise page's mlock_count:
 	 * double counting, leaving the page unevictable indefinitely.
-	 * Communicate this danger to mlock_vma_folio() with VM_IO,
-	 * which is a VM_SPECIAL flag not allowed on VM_LOCKED vmas.
+	 * Communicate this danger to mlock_vma_folio() with VMA_IO_BIT,
+	 * which is a VMA_SPECIAL_FLAGS flag not allowed on VMA_LOCKED_BIT vmas.
 	 * mmap_lock is held in write mode here, so this weird
 	 * combination should not be visible to other mmap_lock users;
-	 * but WRITE_ONCE so rmap walkers must see VM_IO if VM_LOCKED.
+	 * but WRITE_ONCE so rmap walkers must see VMA_IO_BIT if VMA_LOCKED_BIT.
 	 */
 	if (vma_flags_test(new_vma_flags, VMA_LOCKED_BIT))
 		vma_flags_set(new_vma_flags, VMA_IO_BIT);
@@ -458,7 +458,7 @@ static void mlock_vma_pages_range(struct vm_area_struct *vma,
 /*
  * mlock_fixup  - handle mlock[all]/munlock[all] requests.
  *
- * Filters out "special" vmas -- VM_LOCKED never gets set for these, and
+ * Filters out "special" vmas -- VMA_LOCKED_BIT never gets set for these, and
  * munlock is a no-op.  However, for some special vmas, we go ahead and
  * populate the ptes.
  *
@@ -466,24 +466,23 @@ static void mlock_vma_pages_range(struct vm_area_struct *vma,
  */
 static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	       struct vm_area_struct **prev, unsigned long start,
-	       unsigned long end, vm_flags_t newflags)
+	       unsigned long end, vma_flags_t *new_vma_flags)
 {
-	vma_flags_t new_vma_flags = legacy_to_vma_flags(newflags);
 	const vma_flags_t old_vma_flags = vma->flags;
 	struct mm_struct *mm = vma->vm_mm;
 	int nr_pages;
 	int ret = 0;
 
-	if (vma_flags_same_pair(&old_vma_flags, &new_vma_flags) ||
+	if (vma_flags_same_pair(&old_vma_flags, new_vma_flags) ||
 	    vma_is_secretmem(vma) || !vma_supports_mlock(vma)) {
 		/*
-		 * Don't set VM_LOCKED or VM_LOCKONFAULT and don't count.
+		 * Don't set VMA_LOCKED_BIT or VM_LOCKONFAULT and don't count.
 		 * For secretmem, don't allow the memory to be unlocked.
 		 */
 		goto out;
 	}
 
-	vma = vma_modify_flags(vmi, *prev, vma, start, end, &new_vma_flags);
+	vma = vma_modify_flags(vmi, *prev, vma, start, end, new_vma_flags);
 	if (IS_ERR(vma)) {
 		ret = PTR_ERR(vma);
 		goto out;
@@ -493,7 +492,7 @@ static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 * Keep track of amount of locked VM.
 	 */
 	nr_pages = (end - start) >> PAGE_SHIFT;
-	if (!vma_flags_test(&new_vma_flags, VMA_LOCKED_BIT))
+	if (!vma_flags_test(new_vma_flags, VMA_LOCKED_BIT))
 		nr_pages = -nr_pages;
 	else if (vma_flags_test(&old_vma_flags, VMA_LOCKED_BIT))
 		nr_pages = 0;
@@ -502,15 +501,15 @@ static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	/*
 	 * vm_flags is protected by the mmap_lock held in write mode.
 	 * It's okay if try_to_unmap_one unmaps a page just after we
-	 * set VM_LOCKED, populate_vma_page_range will bring it back.
+	 * set VMA_LOCKED_BIT, populate_vma_page_range will bring it back.
 	 */
-	if (vma_flags_test(&new_vma_flags, VMA_LOCKED_BIT) &&
+	if (vma_flags_test(new_vma_flags, VMA_LOCKED_BIT) &&
 	    vma_flags_test(&old_vma_flags, VMA_LOCKED_BIT)) {
 		/* No work to do, and mlocking twice would be wrong */
 		vma_start_write(vma);
-		vma->flags = new_vma_flags;
+		vma->flags = *new_vma_flags;
 	} else {
-		mlock_vma_pages_range(vma, start, end, &new_vma_flags);
+		mlock_vma_pages_range(vma, start, end, new_vma_flags);
 	}
 out:
 	*prev = vma;
@@ -518,7 +517,7 @@ static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 }
 
 static int apply_vma_lock_flags(unsigned long start, size_t len,
-				vm_flags_t flags)
+				const vma_flags_t *flags)
 {
 	unsigned long nstart, end, tmp;
 	struct vm_area_struct *vma, *prev;
@@ -543,18 +542,20 @@ static int apply_vma_lock_flags(unsigned long start, size_t len,
 	tmp = vma->vm_start;
 	for_each_vma_range(vmi, vma, end) {
 		int error;
-		vm_flags_t newflags;
+		vma_flags_t newflags;
 
 		if (vma->vm_start != tmp)
 			return -ENOMEM;
 
-		newflags = vma->vm_flags & ~VM_LOCKED_MASK;
-		newflags |= flags;
+		newflags = vma->flags;
+		vma_flags_clear_mask(&newflags, VMA_LOCKED_MASK);
+		vma_flags_set_mask(&newflags, *flags);
+
 		/* Here we know that  vma->vm_start <= nstart < vma->vm_end. */
 		tmp = vma->vm_end;
 		if (tmp > end)
 			tmp = end;
-		error = mlock_fixup(&vmi, vma, &prev, nstart, tmp, newflags);
+		error = mlock_fixup(&vmi, vma, &prev, nstart, tmp, &newflags);
 		if (error)
 			return error;
 		tmp = vma_iter_end(&vmi);
@@ -589,7 +590,7 @@ static unsigned long count_mm_mlocked_page_nr(struct mm_struct *mm,
 		end = start + len;
 
 	for_each_vma_range(vmi, vma, end) {
-		if (vma->vm_flags & VM_LOCKED) {
+		if (vma_test(vma, VMA_LOCKED_BIT)) {
 			if (start > vma->vm_start)
 				count -= (start - vma->vm_start);
 			if (end < vma->vm_end) {
@@ -615,7 +616,8 @@ static int __mlock_posix_error_return(long retval)
 	return retval;
 }
 
-static __must_check int do_mlock(unsigned long start, size_t len, vm_flags_t flags)
+static __must_check int do_mlock(unsigned long start, size_t len,
+				 vma_flags_t *flags)
 {
 	unsigned long locked;
 	unsigned long lock_limit;
@@ -664,24 +666,27 @@ static __must_check int do_mlock(unsigned long start, size_t len, vm_flags_t fla
 
 SYSCALL_DEFINE2(mlock, unsigned long, start, size_t, len)
 {
-	return do_mlock(start, len, VM_LOCKED);
+	vma_flags_t flags = mk_vma_flags(VMA_LOCKED_BIT);
+
+	return do_mlock(start, len, &flags);
 }
 
 SYSCALL_DEFINE3(mlock2, unsigned long, start, size_t, len, int, flags)
 {
-	vm_flags_t vm_flags = VM_LOCKED;
+	vma_flags_t vma_flags = mk_vma_flags(VMA_LOCKED_BIT);
 
 	if (flags & ~MLOCK_ONFAULT)
 		return -EINVAL;
 
 	if (flags & MLOCK_ONFAULT)
-		vm_flags |= VM_LOCKONFAULT;
+		vma_flags_set(&vma_flags, VMA_LOCKONFAULT_BIT);
 
-	return do_mlock(start, len, vm_flags);
+	return do_mlock(start, len, &vma_flags);
 }
 
 SYSCALL_DEFINE2(munlock, unsigned long, start, size_t, len)
 {
+	vma_flags_t flags = EMPTY_VMA_FLAGS;
 	int ret;
 
 	start = untagged_addr(start);
@@ -691,7 +696,7 @@ SYSCALL_DEFINE2(munlock, unsigned long, start, size_t, len)
 
 	if (mmap_write_lock_killable(current->mm))
 		return -EINTR;
-	ret = apply_vma_lock_flags(start, len, 0);
+	ret = apply_vma_lock_flags(start, len, &flags);
 	mmap_write_unlock(current->mm);
 
 	return ret;
@@ -705,14 +710,15 @@ SYSCALL_DEFINE2(munlock, unsigned long, start, size_t, len)
  * There are a couple of subtleties with this.  If mlockall() is called multiple
  * times with different flags, the values do not necessarily stack.  If mlockall
  * is called once including the MCL_FUTURE flag and then a second time without
- * it, VM_LOCKED and VM_LOCKONFAULT will be cleared from mm->def_vma_flags.
+ * it, VMA_LOCKED_BIT and VMA_LOCKONFAULT_BIT will be cleared from
+ * mm->def_vma_flags.
  */
 static int apply_mlockall_flags(int flags)
 {
 	VMA_ITERATOR(vmi, current->mm, 0);
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma, *prev = NULL;
-	vm_flags_t to_add = 0;
+	vma_flags_t to_add = EMPTY_VMA_FLAGS;
 
 	vma_flags_clear_mask(&mm->def_vma_flags, VMA_LOCKED_MASK);
 	if (flags & MCL_FUTURE) {
@@ -726,20 +732,20 @@ static int apply_mlockall_flags(int flags)
 	}
 
 	if (flags & MCL_CURRENT) {
-		to_add |= VM_LOCKED;
+		vma_flags_set(&to_add, VMA_LOCKED_BIT);
 		if (flags & MCL_ONFAULT)
-			to_add |= VM_LOCKONFAULT;
+			vma_flags_set(&to_add, VMA_LOCKONFAULT_BIT);
 	}
 
 	for_each_vma(vmi, vma) {
 		int error;
-		vm_flags_t newflags;
+		vma_flags_t newflags = vma->flags;
 
-		newflags = vma->vm_flags & ~VM_LOCKED_MASK;
-		newflags |= to_add;
+		vma_flags_clear_mask(&newflags, VMA_LOCKED_MASK);
+		vma_flags_set_mask(&newflags, to_add);
 
 		error = mlock_fixup(&vmi, vma, &prev, vma->vm_start, vma->vm_end,
-				    newflags);
+				    &newflags);
 		/* Ignore errors, but prev needs fixing up. */
 		if (error)
 			prev = vma;
-- 
2.54.0


