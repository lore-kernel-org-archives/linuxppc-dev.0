Return-Path: <linuxppc-dev+bounces-28109-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4C8C98314
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 10:22:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hr8z42Jn0z2yD3;
	Thu, 24 Sep 2026 20:22:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790245344;
	cv=none; b=ROHcydjej8XIS4ZfuRQb6p4e7pF0XdjKA9H41ZQnuzTUHuY+THe6gnbvFass1eqOkXKDM2+Lui4g8pDDiaXejq2681elRITS4cux/tbxBiHx6iyXGRNYSR5DHpg83igDudO2qMwCr6OHIKEUBosgNz3fiak7SS0g2dbf9oOWnAeuWPMF1xPWAe2678257Sd73VC4+stCmmDgVt8FqnzsJLqaXZTAnZvMTG9bMhwxbVr0MMLYt1plnH7BlfTk5eo48YQ9hqXF0GtsikloKSX+gyBHL9YmL0nF6yt2hetQ3P1OtRFadwOtzK9uPjAYrF/PW8VrJsCXNAV5KpNCcPyOLg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790245344; c=relaxed/relaxed;
	bh=/kufuYs8c40R6+aOEF8XLRCigB/kXlHZjyeo0hfMBwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MX9n92Hyh+QkxfN7fNZw5BQf3rJM+AdKFeWjs33+usV8ZyW2Ryzu6Ikqi/odgNHqOOI66bnasHDzIlyoI25/DzcIuUq9U45xWCNRuQvVb/YdCDrGVYmNuu97NaTP5i2fnLNI2QvpxUdIcyLkyWmZLCOtf8ZEILWQ6tUrFGNtf+jqYEYMdn0amkwc+WXaf9+5Iy3LAusQSgsh0cYYUoedUFP9Az815zbNo/ah56pawutBF2NRjLwiv6vpsx9gj2Vu5HyHWr+rZDGkAbsNIssvtmkUCmBeCswXceIwhuo5/wSQwssGLJm5Q5FgddkUFPxi8EURCjnA1ZC/VqHFLtuV6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bK5oWCb3; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bK5oWCb3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hr8z328DKz2y7Y
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 20:22:23 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id ACE6560200;
	Thu, 24 Sep 2026 10:22:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75DC61F000FF;
	Thu, 24 Sep 2026 10:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790245340;
	bh=/kufuYs8c40R6+aOEF8XLRCigB/kXlHZjyeo0hfMBwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bK5oWCb3icJZsdzewTtJXUj2g8+OdPY584wvobmFjH9caA6XHPZPOxLC+ENgAYis7
	 FMWfW3kg0b1pKU0W7dpIcpkH9wgepYgd+Vs0xeodvPvhS2Z2eCR6zzIfxbc+F4vYn1
	 crr7Q7r6oewUJpom74jt6mX2gF6IAipPmH/f96jRZvGrtuVNztKClju5BP2uHo6kW6
	 734wktJAnH1jO9c7SkfE4BGx5XUqUo3nH1YffnP3W3u3mHAJ7/dU+/pRlEDaapTJOL
	 hEriCB9vp3MVrONwH7vOYcoqLNO15CHvH8FuBJLz8aDKeueJxc7YfwK4KfyNmRNl7E
	 8UCm0PUzGxdsg==
Date: Thu, 24 Sep 2026 11:21:49 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
	Doug Gilbert <dgilbert@interlog.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, Jaya Kumar <jayalk@intworks.biz>, 
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
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, fuse-devel@lists.linux.dev
Subject: Re: [PATCH v3 24/40] mm/mlock: eliminate weird VMA_IO_BIT abuse and
 simplify
Message-ID: <arT3K71l86fUVldk@gremlin>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-24-4583d8a23bca@kernel.org>
 <93672B94-BB0C-4713-8F8A-3619D81DB7BB@nvidia.com>
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
In-Reply-To: <93672B94-BB0C-4713-8F8A-3619D81DB7BB@nvidia.com>

On Wed, Sep 23, 2026 at 04:06:14PM -0400, Zi Yan wrote:
> On 17 Sep 2026, at 12:22, Lorenzo Stoakes (ARM) wrote:
>
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
> > Finally, with the other mlock abuse of VMA_IO_BIT addressed, update
> > mlock_vma_folio() and folio_add_lru_vma() to simply test for
> > VMA_LOCKED_BIT. munlock_vma_folio() tests VMA_LOCKED_MASK instead, as an
> > unmap racing with the locking walk must still munlock folios the walk has
> > already counted.
> >
> > While here, also replace some deprecated VMA flag predicates.
> >
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  mm/folio.c    |  2 +-
> >  mm/internal.h | 10 +++++++---
> >  mm/mlock.c    | 51 +++++++++++++++++++--------------------------------
> >  mm/rmap.c     |  4 +++-
> >  4 files changed, 30 insertions(+), 37 deletions(-)
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
>
> I think it is worth documenting VMA_LOCKONFAULT_BIT alone means mlock in
> progress, like you did in munlock_vma_folio(). Just to keep the protocol
> explicit for all the readers.

Well I'm not sure it's necessary here honestly, because this never checked
VMA_LOCKED_MASK anyway, and VMA_LOCKONFAULT_BIT never made a difference.

So the meaning of VMA_LOCKED_BIT here is strictly 'is it locked' and it's
correctly handled.

And I fear that it becomes whack-a-mole - the neat thing about this change is
that you no longer have to special case the stupid VM_SPECIAL thing, and can in
fact do the 'normal' thing of _just checking_ VMA_LOCKED_BIT :)

So I think it's better not to.

>
> >  		mlock_new_folio(folio);
> >  	else
> >  		folio_add_lru(folio);
> > diff --git a/mm/internal.h b/mm/internal.h
> > index b2c6c9435021..84aa3e6c8bac 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -971,8 +971,7 @@ void mlock_folio(struct folio *folio);
> >  static inline void mlock_vma_folio(struct folio *folio,
> >  				struct vm_area_struct *vma)
> >  {
> > -	/* The VM_IO check prevents migration from double-counting during mlock. */
> > -	if (unlikely((vma->vm_flags & (VM_LOCKED|VM_SPECIAL)) == VM_LOCKED))
> > +	if (vma_test(vma, VMA_LOCKED_BIT))
>
> Ditto.

Similar reasoning to above.

>
> >  		mlock_folio(folio);
> >  }
> >
> > @@ -989,7 +988,12 @@ static inline void munlock_vma_folio(struct folio *folio,
> >  	 * always munlock the folio and page reclaim will correct it
> >  	 * if it's wrong.
> >  	 */
> > -	if (unlikely(vma->vm_flags & VM_LOCKED))
> > +	/*
> > +	 * VMA_LOCKONFAULT_BIT alone marks an mlock walk in progress, see
> > +	 * mlock_vma_pages_range(). An unmap racing with the walk must still
> > +	 * munlock folios the walk has already counted.
> > +	 */

Here it's worth mentioning, as it's specifically relying on the new
behaviour. Although it's neatly using the VMA_LOCKED_MASK to handle both the
locked case and the 'being locked' case :)

> > +	if (unlikely(vma_test_any_mask(vma, VMA_LOCKED_MASK)))
> >  		munlock_folio(folio);
> >  }
> >
>
> Why I am commenting in the middle of the series? Because I am taking
> a quiz given by LLM based on this series to get myself enough background
> knowledge to review this series. This mlock part came up at part E
> and I only have part F left before I can do the full review. :)

Thanks! :) I really appreciate you taking the time to look at this! Sorry it's
so large.

I held this series back from last cycle to help with review load, then spent
some time fixing various AI-discovered things, and all the patches are necessary
(well for the most part) to get where the series needs to go.

I think the change is worth it though!

>
> Best Regards,
> Yan, Zi

--
Cheers, Lorenzo

