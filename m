Return-Path: <linuxppc-dev+bounces-28756-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25CDECA5FE3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 12:49:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hx7s81h4Jz308H;
	Fri, 02 Oct 2026 22:49:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790945372;
	cv=none; b=I0uM139LBepNCC1JVFf/Jy5jQCF7bWy++tPnQvhj5l6foXPBvHgQsfk8HtjmBafpJ24/KqUQVQjP7+W6CHHM4SFKqUyge4uHs0nVci/i/4qisoLJ6IwbHNqb9ddiECqy9+rHwJAjiVO/6Q2yeVsAeH/UbtbMXNE4hrbry1WlFlNiq39fgcT4eayfoxFUB7YyrcnTPfqQXFlPZPD47KowrZsZVq32Et2nJYfYIQP7U3Xv4+r7L+vBbRsWxtrKBS3rYi++oRU9GIXXlyb35/9NS65YfJ9PFTsxN4EPdEjJSIJ0pf86dJRoxRfNTIiv/gFBbCqROKIRLYL9g3QHvowK0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790945372; c=relaxed/relaxed;
	bh=BkQazKW1ZD8hcOD8s+NbH3X4ZCcNodhXr3IgrsR/4z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gt1hl2M5WqqZoMMfd7Am639a/n67dviNbg9EIivlHQo5lPjTyD0dGojERvuobpGAzJQ92ImZhTvbqjf2H0zZSknvQJb9EZpgiBeUU7RyDjqTHge9uYe/LJR6SUQ40rvlSkjHBNnPoc/AcFHCUSjA/hhxxhOBjNhK+5m8VuXzPvwNl3dOYbk4QNBWbzlmlylg/u3f1uCQpQsc78tDkpWICn7GYn+vkWCyLuiIiUne8E2xxQNfBUjW/HCpypdaNzCWhC0GeyPBlC1+EZDaggNnSSC+nccH+aZlWojb8Uac/zMidlra9xHL16l4u+AN1ijwh5gbhT+mwhOB2nhb/1KTAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RQ03jCXZ; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RQ03jCXZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hx7s721xRz2yTQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 22:49:31 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0F35C60A70;
	Fri,  2 Oct 2026 12:49:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CA71F000FF;
	Fri,  2 Oct 2026 12:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790945368;
	bh=BkQazKW1ZD8hcOD8s+NbH3X4ZCcNodhXr3IgrsR/4z0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RQ03jCXZYJPMzUfwgkPjSnYeSfWRE+hKbPn+8rkamI8qG7R1fxf43HiOZd6kFuIJy
	 1Q1/vovHEFzMWBQukSDjS6/ACthFKyoUcooGbiiNSfYZJxJIqZBTI5avyKLysEVi34
	 bvj7/Jokm0b5rPDekfi1Uv9nfjY+kLXc6xMBzktMjau81XS48FkDeIcOTACsvovdYS
	 /5gS/YY8jKYnOLwgtkB/lsxtDx40VtY2ukXYM4o1zgOuWygg6vYxWGNLxDUQfJMmVB
	 UKlb1HDchPmZh/ZpA7DbpJScH43Y9QyYAzN/wa9cpCxCZrPbCno8taaTUZTibI9aJS
	 +N8s56+aAgg5Q==
Date: Fri, 2 Oct 2026 13:48:59 +0100
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
	Jaya Kumar <jayalk@intworks.biz>, Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>, 
	Sebastian Reichel <sre@kernel.org>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
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
Subject: Re: [PATCH v3 31/40] mm/vma: introduce vma[_flags]_is_persistent()
Message-ID: <ar-luB9QVCRshtIw@gremlin>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-31-4583d8a23bca@kernel.org>
 <9bbdf4e8-6984-4477-a183-f0b236047381@kernel.org>
 <3557015d-23dd-41ef-9832-78b58587f3f4@kernel.org>
 <81e1e5ae-0aab-4584-81e6-3fc9c2634d07@kernel.org>
 <ar-b_Ug__TBzIZsb@gremlin>
 <2e5a4e6c-8f9c-4050-8998-454b83f4823b@kernel.org>
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
In-Reply-To: <2e5a4e6c-8f9c-4050-8998-454b83f4823b@kernel.org>

On Fri, Oct 02, 2026 at 02:35:06PM +0200, David Hildenbrand (Arm) wrote:
> On 10/2/26 14:08, Lorenzo Stoakes (ARM) wrote:
> > On Fri, Oct 02, 2026 at 09:05:15AM +0200, David Hildenbrand (Arm) wrote:
> >> On 10/2/26 09:02, David Hildenbrand (Arm) wrote:
> >
> > No, see below.
> >
> >>>
> >>> It's also about droppable mappings AFAIKs. How many more users will we have for
> >>> that function?
> >
> > Anything that requires stuff not to be dropped behind the user's back, which is
> > at least 4 cases!
> >
> > That being open-coded all over the place is a problem I think, and I think stuff
> > like the PMD device private are a reminder that open-coding all over can cause
> > problems.
> >
> >>>
> >>> If it's "no others" then please don't add a helper function with misleading
> >>> names for it and just keep the special "dumpable" check in the new form in
> >>> madvise_vma_behavior().
> >>
> >> Talking to myself ... the more usage I see of the vma_is_persistent() the more I
> >> think this shouldn't be a helper at all. Especially not one with such a
> >> confusing name :P
> >
> > There are 4 open-coded checks that test four ad-hoc flag combinations checking
> > for the same thing - 'can the kernel or a driver change things or discard stuff
> > behind my back?'
> >
> > So abstracting that to a helper, alongside the other 'let's ask based on
> > semantics' helpers, seems sensible.
> >
> > Maybe invert the meaning to make it clearer?
> >
> > 	vma_kernel_may_change_contents()?
> >
>
> This is all super confusing and I don't think we should try to describe the
> semantics that way.
>
> Just imagine having udmabuf use a PFNMAP of folios obtained from shmem. For sure
> the kernel could now change the shmem pages that are mapped in some ordinary VMA.

There's always edge cases like this.

In each of these conditionals that this helper replaces, that's exactly what's
being checked for.

A driver could GUP anything and access the page raw and do things like that
too...

Without this we lose all that and are back to arbitrary flag checks again. It
seems unwise.

>
>
> Likely we don't have to squeeze everything into a single helper that is hard to
> describe.

I'm not trying to do that :)

There are plenty of edge cases I left alone.

This one explicitly is one that can end up very easily broken in the future.

Already there's been issues as I recall with people forgetting about droppable.

>
> Maybe we can pull parts of it into a separate helper with semantics that are
> easier to describe?

But then you lose the whole purpose of this, which is to not miss things.

>
>
> vma_is_user_memory() && !vma_is_droppable_memory()

I find vma_is_user_memory() _very_ confusing :) I have no idea what that means.

And vma_is_droppable_memory() is a semi-pointless wrapper for checking the
droppable flag no?

>
> Although I am not sure user_memory is exactly precise (pagecache+anon) and what
> we want? It's all super confusing (thanks for deciphering it).

That name isn't great, as userland memory is defined as that which can be mapped
in the userland portion of the virtual memory address map, and all VMAs describe
that :)

And then you can go on from there as to pedantic issues, the very same shmem
stuff you mention above can be put forward as an argument, etc. etc.
>
>
> > vma_contents_may_change() is shorter but easily confused with something being
> > writable by userland etc.
> >
> > Or maybe:
> >
> > 	vma_is_volatile()
> >
> > ?
> >
> > Which is analogous to the meaning of the volatile keyword.
> This is all confusing because persistent and volatile are established concept
> when talking about memory. And see my example above, it's not even clear what it
> means that "the kernel can modify something".

Yep I guess volatile vs. non-volatile.

But a VMA describes a mapping not backing and 'volatile' in C is pretty clear -
something can be touched by something else so don't make assumptions.

I mean if people are confused they can look at the comment. We argue about
details meanwhile the code is full of terrible naming that's duplicated 100
times :)

And you can come up with edge cases to a lot of things. That doesn't invalidate
the intent.

Right now the code is duplicative and I found multiple instances of e.g. drivers
doing completely the wrong thing.

In any case, you seem to feel very strongly about this - so maybe best I drop
this patch from the series to be revisited later?

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo

