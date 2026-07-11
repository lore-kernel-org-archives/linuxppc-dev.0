Return-Path: <linuxppc-dev+bounces-24064-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4558CC43458
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Jul 2026 18:49:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gyHmv699yz30Cj;
	Sun, 12 Jul 2026 04:49:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783795775;
	cv=none; b=g9I0F+hNIDYe48YXp8H097ztPvV5tQQvGqV0BtFWrSPKz74W4dGyFWAqABZ1rmBiFK01UVfyJS4DtFCZsCAUEDIMCd0Toz+/yzlgkpB+amx4boLYxYeaa68E50Ft+UslBDe5yowXIfKKnn9eg0g5oIKW4IatGzHGb5MIbygBi0LzHuPiDQ3ZIX7Sf7HIyWtMTdwqODXWZDouQDwNu82QO6zM7jMhLTTiHAWiI452lu9W2Q4iMAES23aAM/q5BZ3WTLB9etbefR4SCXlwRC3UD4LRZ0KVnF6sJxMo4NQ7F5HfeMG2AkMGbQrqyUMAdg/WbQDlQ4ym82JesR+omEfGgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783795775; c=relaxed/relaxed;
	bh=F7JbYfoR0cBo3rK9+sjl2GjH5zAlrFeYJDLZN+6KwQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HBkhPgS34CkeMcqdmB/2F8iAaKrQy2Ns8GMUxfo1Yt8FRDehRV9Pj0v7VGsu3NjB9hpSeLWH64Mr5U+c8EHRX1zentNsdbBb+0CZ0FdLUGCr2/XIJC2juBowgjUjMZV+1A79qtVu31ijx7Ze2Knz+W3ehnKV4TFrSLq8cJXHRXwJniQB94pJQXyAgnSV13WfPSxuks82/pe23lQWVVGze9/YshVlJ6c0Hd7ehzpb2iPxITI8CAlKeR3BcXQQi+8eAnfVxZdoYGRIjdzT2tU0mIQsbUp/aCOdKqog8rSIdqAXuZZFthWFqXkV4QoQWx+Mq+IQfcaWFRnU87VOenMHgw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YgX1w/cj; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YgX1w/cj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gyHmt6yyjz308k
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Jul 2026 04:49:34 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0EA7B60052;
	Sat, 11 Jul 2026 18:49:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ABD01F00A3A;
	Sat, 11 Jul 2026 18:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783795772;
	bh=F7JbYfoR0cBo3rK9+sjl2GjH5zAlrFeYJDLZN+6KwQc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YgX1w/cjR8WW7yAZK54+rQ0d90kWJBtvSsotwFoOsbT1jEjUv+GBeJk+emgMy+T1b
	 4NmtgJa3KAaWfNdlVas+DLRld0NYlKD608QgNo3ayghduF02ZaZspWu7cFAVIEwmQT
	 i/QMae1t1yCToyOSygT8AGwDD8ih5WV9TxgWALUrWKoKSlJDM32b/4wZb56F/MNqwa
	 ibM6KyzyLmz+I9eMGK75CzcO/6KXshFhD90r8Nyp0a3VNBMw8MLH6TTnhDIiICXDCE
	 qX519KpT+qQjZgiMubdoDozDvMvaNHUGSTjH3oTfJO/3AqH3CmZEAioli+P7/Fd/Gr
	 Zw3fCwHDxMEWQ==
From: Lorenzo Stoakes <ljs@kernel.org>
Date: Sat, 11 Jul 2026 19:45:08 +0100
Subject: [PATCH v2 11/13] mm/mlock: convert mlock code to use vma_flags_t
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
Message-Id: <20260711-b4-vma-flags-mm-v2-11-0fa2357d5431@kernel.org>
References: <20260711-b4-vma-flags-mm-v2-0-0fa2357d5431@kernel.org>
In-Reply-To: <20260711-b4-vma-flags-mm-v2-0-0fa2357d5431@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Benjamin LaHaise <bcrl@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>, 
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Russell King <linux+etnaviv@armlinux.org.uk>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, 
 Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, Zack Rusin <zack.rusin@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, 
 Helge Deller <deller@gmx.de>, Kees Cook <kees@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
 linux-aio@kvack.org, linux-fsdevel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org, 
 etnaviv@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 linux-tegra@vger.kernel.org, virtualization@lists.linux.dev, 
 intel-xe@lists.freedesktop.org, xen-devel@lists.xenproject.org, 
 linux-fbdev@vger.kernel.org, linux-sound@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10659; i=ljs@kernel.org;
 h=from:subject:message-id; bh=12NkDtkZsgv4tumIZ1Li1kdvxPQKo0e0f0d/e5C85HE=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLKC+q2U/t/Zc52rw7NtrciSmor9vhun7bDe9HnRAg7Ja
 cyqWbnrOkpZGMS4GGTFFFmefxHfHyQSNq/zgr8bzBxWJpAhDFycAjCRpRwM/52KL+dGd2U+vcZ6
 5VvA0uleV8Mu5Ck9uXaQ8eBm7fZnmj2MDN2eM1TPyd28I+kbcNei+mhv94Tzv59s1gvJ8+BYoHC
 ZkR0A
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Replace use of the legacy vm_flags_t flags with vma_flags_t values
throughout the mlock logic.

Additionally update comments to reflect the changes to be consistent.

No functional change intended.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
---
 mm/mlock.c | 88 +++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 47 insertions(+), 41 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 34ffa954006f..efa6716e4dfb 100644
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
-		 * For secretmem, don't allow the memory to be unlocked.
+		 * Don't set VMA_LOCKED_BIT or VMA_LOCKONFAULT_BIT and don't
+		 * count.  For secretmem, don't allow the memory to be unlocked.
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
2.55.0


