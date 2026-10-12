Return-Path: <linuxppc-dev+bounces-29297-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC66ACC6B01
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 18:39:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3R7m1RMLz2xnQ;
	Tue, 13 Oct 2026 05:39:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791830340;
	cv=none; b=eoq5rneJZV5UEs9KRWYCW4UqbiNkaJ0pj/hb5bCTnbxCM7sm9Pd7ojJH9xjz9bHdBmLHPMoiNj/PsbhbEUgxCuNUJ+McjpoDdBl+/Omyc7yGxQrlk+cXIUfhpgf/n9o02mfdAsagDJIEMQzNhX2O9Y1sVSUKfnjg6Yuvwyp9RH/C51xLTBm45gKyeT0wwArPPgO7V262COKyoTgeWkrMlYTUq+CvGYWvjyQvUJLjqxEd18AqGBVpi1iZy0s+0AvD2ifN3IHi2iPc2fs5kjNKCtheT+JFatbtSoIVxyfUwYL1URxykRTQ8o39YAw9NrbeQfzUVUxVi8LgseOtjW9UiA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791830340; c=relaxed/relaxed;
	bh=fP03qOjNgvJcNFxilOwiajFRX7c9NaLWJPxXiXEaFwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6MbnqRMnoFvz/HYkOhE/PqoV7xLuvl9GBvvnijJ3bUhCOoY1KduUo9GoLWAbZMLev4GyqDFVgqO50xlxh9wIv2TUkZmAvcqDCR7H189smhuAcskcarh3n6CcDVrhZhLxu/P73iI7hMXfNTLsAb/Gtjv/TMOyOhoegh4hfu1QkMs8FeZppnEBnGSI8OSqy4Xw2fccyIEeA1bxnQ8xJiNFuNi60iddvBuWnFRtQCT3W0KR73l9lQDAfVJdxLmQJIA4Ott9AAL7JpYu6napb51WAeeX0Oai3EdPtbYsJC9qP6fEDkh6LDQ7skRoOmELuXo5VKNGTY48gFUOccrmqksKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FpTrSmMa; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FpTrSmMa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3R7l23V5z2xWt
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 05:38:59 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4AF0F4378B;
	Mon, 12 Oct 2026 18:38:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B16F1F0089B;
	Mon, 12 Oct 2026 18:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791830337;
	bh=fP03qOjNgvJcNFxilOwiajFRX7c9NaLWJPxXiXEaFwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FpTrSmMagijQ4s8+E1TqfKdKHrTHU0BFRjA/iCJzTavYCoIGrP+M/jA/kByrAy4dF
	 hg5+n9OJT0wTIiPuLZk3nQ4HlvQEC1Pt7lSKlbbnQhSLrANVy6PsCVdXT+ZqRFf+WV
	 GBi1IdoRtPBhhxaaK0OLjDeY5tcu18IyA0h0uTRG50/+GGfE+jKtZkG0HLfBGJiUWU
	 Hu8DdnHwjFwwYku6PhhIIj1fCcErlCDKnAGYjbWKOUSId3Gm+w+Lucn03/P2JAkYqI
	 yQmNHzkW+VZUHiTptwbi5AP53a4fnEFmQ+CHOiXo+2e7qaN83k4kAuhfxRivDIuAWs
	 d/avRkBSQydRA==
Date: Mon, 12 Oct 2026 19:38:21 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Doug Gilbert <dgilbert@interlog.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen" <mkp@kernel.org>, 
	Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>, Sebastian Reichel <sre@kernel.org>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, 
	Youngjun Park <youngjun.park@lge.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Xu Xin <xu.xin@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-rdma@vger.kernel.org, selinux@vger.kernel.org, linux-sound@vger.kernel.org, 
	bpf@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, fuse-devel@lists.linux.dev, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Bert Karwatzki <spasswolf@web.de>
Subject: Re: [PATCH v5 23/38] mm/mlock: eliminate weird VMA_IO_BIT abuse and
 simplify
Message-ID: <as0osndioe9xxoG1@gremlin>
References: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org>
 <20261009-b4-mmap-prepare-vma-flag-sanify-v5-23-923b70125b1e@kernel.org>
 <50c967fb-b6de-4189-9430-5455c26a5385@kernel.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50c967fb-b6de-4189-9430-5455c26a5385@kernel.org>

On Mon, Oct 12, 2026 at 08:23:15PM +0200, David Hildenbrand (Arm) wrote:
> On 10/9/26 20:04, Lorenzo Stoakes (ARM) wrote:
> > When performing mlock() or munlock() otherwise normal VMAs have VMA_IO_BIT
> > solely to fix a race with migration which might otherwise double-count
> > mlock VMAs.
> >
> > This is unnecessary - at the point of applying folio mlock state, whether
> > setting or clearing PG_mlocked, we know whether or not we are locking.
> >
> > Solve this in two ways - thread a boolean through the page table walk
> > indicating whether a lock or unlock is being performed, and run a locking
> > walk with VMA_LOCKONFAULT_BIT set and VMA_LOCKED_BIT cleared.
> >
> > This state never occurs otherwise, as VMA_LOCKONFAULT_BIT always implies
> > VMA_LOCKED_BIT. These are also always cleared together.
> >
> > Then, update folio_add_lru_vma() and mlock_folio() to check only for
> > VMA_LOCKED_BIT, and update try_to_unmap_one() to check for VMA_LOCKED_MASK
> > instead.
> >
> > Also remove the useless invocation of allow_mlock_munlock() which simply
> > returns true if unlocking and instead rename it to allow_mlock() and only
> > call it when locking.
> >
> > With the other mlock abuse of VMA_IO_BIT addressed, update
> > mlock_vma_folio() and folio_add_lru_vma() to simply test for
> > VMA_LOCKED_BIT.
> >
> > The munlock_vma_folio() function tests VMA_LOCKED_MASK instead, as an
> > unmap racing with the locking walk must still munlock folios the walk has
> > already counted.
> >
> > Additionally, in order to ensure a racing unmap/migration releases the
> > reference munlock_folio() took (whose put was batched), check
> > VMA_LOCKED_MASK before calling mlock_drain_local() in try_to_unmap_one()
> > and try_to_migrate_one().
> >
> > While here, also replace some deprecated VMA flag predicates.
> >
> > Reviewed-by: Zi Yan <ziy@nvidia.com>
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  mm/folio.c    |  2 +-
> >  mm/internal.h | 10 +++++++---
> >  mm/mlock.c    | 51 +++++++++++++++++++--------------------------------
> >  mm/rmap.c     |  8 +++++---
> >  4 files changed, 32 insertions(+), 39 deletions(-)
> >
> > diff --git a/mm/folio.c b/mm/folio.c
> > index 47a437e0f7fd..35e242b48870 100644
> > --- a/mm/folio.c
> > +++ b/mm/folio.c
> > @@ -505,7 +505,7 @@ void folio_add_lru_vma(struct folio *folio, struct vm_area_struct *vma)
> >  {
> >  	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
> >
> > -	if (unlikely((vma->vm_flags & (VM_LOCKED | VM_SPECIAL)) == VM_LOCKED))
> > +	if (vma_test(vma, VMA_LOCKED_BIT))
> >  		mlock_new_folio(folio);
> >  	else
> >  		folio_add_lru(folio);
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 4ae08fedffff..ea8fa94ebe1b 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -970,8 +970,7 @@ void mlock_folio(struct folio *folio);
> >  static inline void mlock_vma_folio(struct folio *folio,
> >  				struct vm_area_struct *vma)
> >  {
> > -	/* The VM_IO check prevents migration from double-counting during mlock. */
> > -	if (unlikely((vma->vm_flags & (VM_LOCKED|VM_SPECIAL)) == VM_LOCKED))
> > +	if (vma_test(vma, VMA_LOCKED_BIT))
> >  		mlock_folio(folio);
> >  }
> >
> > @@ -988,7 +987,12 @@ static inline void munlock_vma_folio(struct folio *folio,
> >  	 * always munlock the folio and page reclaim will correct it
> >  	 * if it's wrong.
> >  	 */
> > -	if (unlikely(vma->vm_flags & VM_LOCKED))
> > +	/*
> > +	 * VMA_LOCKONFAULT_BIT alone marks an mlock walk in progress, see
> > +	 * mlock_vma_pages_range(). An unmap racing with the walk must still
> > +	 * munlock folios the walk has already counted.
> > +	 */
> > +	if (unlikely(vma_test_any_mask(vma, VMA_LOCKED_MASK)))
> >  		munlock_folio(folio);
> >  }
> >
> > diff --git a/mm/mlock.c b/mm/mlock.c
> > index 39215a3eab1f..4235a1518fc9 100644
> > --- a/mm/mlock.c
> > +++ b/mm/mlock.c
> > @@ -316,22 +316,10 @@ static inline unsigned int folio_mlock_step(struct folio *folio,
> >  	return folio_pte_batch(folio, pte, ptent, count);
> >  }
> >
> > -static inline bool allow_mlock_munlock(struct folio *folio,
> > +static inline bool allow_mlock(struct folio *folio,
> >  		struct vm_area_struct *vma, unsigned long start,
> >  		unsigned long end, unsigned int step)
> >  {
> > -	/*
> > -	 * For unlock, allow munlock large folio which is partially
> > -	 * mapped to VMA. As it's possible that large folio is
> > -	 * mlocked and VMA is split later.
> > -	 *
> > -	 * During memory pressure, such kind of large folio can
> > -	 * be split. And the pages are not in VM_LOCKed VMA
> > -	 * can be reclaimed.
> > -	 */
> > -	if (!vma_test(vma, VMA_LOCKED_BIT))
> > -		return true;
> > -
> >  	/* folio_within_range() cannot take KSM, but any small folio is OK */
> >  	if (!folio_test_large(folio))
> >  		return true;
> > @@ -352,6 +340,7 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
> >
> >  {
> >  	struct vm_area_struct *vma = walk->vma;
> > +	const bool lock = walk->private;
> >  	spinlock_t *ptl;
> >  	pte_t *start_pte, *pte;
> >  	pte_t ptent;
> > @@ -368,7 +357,7 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
> >  		folio = pmd_folio(*pmd);
> >  		if (folio_is_zone_device(folio))
> >  			goto out;
> > -		if (vma_test(vma, VMA_LOCKED_BIT))
> > +		if (lock)
> >  			mlock_folio(folio);
> >  		else
> >  			munlock_folio(folio);
> > @@ -390,10 +379,10 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
> >  			continue;
> >
> >  		step = folio_mlock_step(folio, pte, addr, end);
> > -		if (!allow_mlock_munlock(folio, vma, start, end, step))
> > +		if (lock && !allow_mlock(folio, vma, start, end, step))
> >  			goto next_entry;
> >
> > -		if (vma_test(vma, VMA_LOCKED_BIT))
> > +		if (lock)
> >  			mlock_folio(folio);
> >  		else
> >  			munlock_folio(folio);
> > @@ -428,31 +417,29 @@ static void mlock_vma_pages_range(struct vm_area_struct *vma,
> >  		.pmd_entry = mlock_pte_range,
> >  		.walk_lock = PGWALK_WRLOCK_VERIFY,
> >  	};
> > +	const bool lock = vma_flags_test(new_vma_flags, VMA_LOCKED_BIT);
> > +	vma_flags_t walk_flags = *new_vma_flags;
> >
> >  	/*
> > -	 * There is a slight chance that concurrent page migration,
> > -	 * or page reclaim finding a page of this now-VMA_LOCKED_BIT vma,
> > -	 * will call mlock_vma_folio() and raise page's mlock_count:
> > -	 * double counting, leaving the page unevictable indefinitely.
> > -	 * Communicate this danger to mlock_vma_folio() with VMA_IO_BIT,
> > -	 * which is a VMA_SPECIAL_FLAGS flag not allowed on VMA_LOCKED_BIT vmas.
> > -	 * mmap_lock is held in write mode here, so this weird
> > -	 * combination should not be visible to other mmap_lock users;
> > -	 * but WRITE_ONCE so rmap walkers must see VMA_IO_BIT if VMA_LOCKED_BIT.
> > +	 * LOCKONFAULT without LOCKED never otherwise occurs: it marks a walk in
> > +	 * progress so that rmap-side callers, which test VMA_LOCKED_BIT, do not
> > +	 * count folios, while try_to_unmap_one(), which tests VMA_LOCKED_MASK,
> > +	 * still refuses to unmap them.
> >  	 */
> > -	if (vma_flags_test(new_vma_flags, VMA_LOCKED_BIT))
> > -		vma_flags_set(new_vma_flags, VMA_IO_BIT);
> > +	if (lock) {
> > +		vma_flags_clear(&walk_flags, VMA_LOCKED_BIT);
> > +		vma_flags_set(&walk_flags, VMA_LOCKONFAULT_BIT);
> > +	}
> > +
> >  	vma_start_write(vma);
> > -	vma_flags_reset_once(vma, new_vma_flags);
> > +	vma_flags_reset_once(vma, &walk_flags);
> >
> >  	lru_add_drain();
> > -	walk_page_range_vma(vma, start, end, &mlock_walk_ops, NULL);
> > +	walk_page_range_vma(vma, start, end, &mlock_walk_ops, (void *)lock);
> >  	lru_add_drain();
> >
> > -	if (vma_flags_test(new_vma_flags, VMA_IO_BIT)) {
> > -		vma_flags_clear(new_vma_flags, VMA_IO_BIT);
> > +	if (lock)
> >  		vma_flags_reset_once(vma, new_vma_flags);
> > -	}
> >  }
> >
> >  /*
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index 5332c52909be..b4a4b3929044 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -2239,9 +2239,11 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
> >
> >  		/*
> >  		 * If the folio is in an mlock()d vma, we must not swap it out.
> > +		 * VMA_LOCKONFAULT_BIT alone marks an mlock walk in progress, see
> > +		 * mlock_vma_pages_range().
> >  		 */
> >  		if (!(flags & TTU_IGNORE_MLOCK) &&
> > -		    (vma->vm_flags & VM_LOCKED)) {
> > +		    vma_test_any_mask(vma, VMA_LOCKED_MASK)) {
> >  			ptes++;
> >
> >  			/*
> > @@ -2395,7 +2397,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
> >  		}
> >  finish_unmap:
> >  		folio_remove_rmap_ptes(folio, page, nr_pages, vma);
> > -		if (vma->vm_flags & VM_LOCKED)
> > +		if (vma_test_any_mask(vma, VMA_LOCKED_MASK))
> >  			mlock_drain_local();
> >  		folio_put_refs(folio, nr_pages);
> >
> > @@ -2770,7 +2772,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
> >  			hugetlb_remove_rmap(folio);
> >  		else
> >  			folio_remove_rmap_pte(folio, subpage, vma);
> > -		if (vma->vm_flags & VM_LOCKED)
> > +		if (vma_test_any_mask(vma, VMA_LOCKED_MASK))
> >  			mlock_drain_local();
> >  		folio_put(folio);
> >  	}
> >
>
> The mlock.c changes are a bit over my head (mostly the old VM_IO handling ...),
> but it looks good from what I can tell (hoping Hugh could review ...)

If it helps, Lance tested thoroughly and found 1 place I forgot to update, now
addressed, and Zi has carefully gone through too.

Essentially it's doing the same thing VMA_IO_BIT did only with
VMA_LOCKONFAULT_BIT, which is still pretty gross but much much less so and makes
it all make a lot more sense (esp. with the locked mask).

(VMA_LOCKONFAULT_BIT when used for lock-on-fault is only ever set with
VMA_LOCKED_BIT set too, we track the folio operation by it being set alone so it
doesn't trigger lock-on-fault behaviour).

>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Thanks!

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo

