Return-Path: <linuxppc-dev+bounces-28752-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC199CA5FD6
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 12:09:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hx6yS648hz2ygK;
	Fri, 02 Oct 2026 22:09:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790942944;
	cv=none; b=MT7HIyC0hWC2DxD3W+9x81cP7AkAYJ7AZRnK1MeBWu69JTDIfCdSGqpsnxtFgwfZg5c2cadMrRcGnDNXUbpoeuu3Yh3ma2bhDqI4UQwVOJj2p4QXu46s1JBvneyLIQbytTzwUcFV7odGdOsQedv9telWbGWtLen/CmPBXPakSmaBaDjRSyNXyu2FCos5bht3hIR4O4mPqPZ+9DuXkOzu8xsMRveKX22+X5NE9XddZCM/OaE/HBZN8/aQFDLXDQIHGW2avkJHf1EAhWGeugbpEDStopsGmaf9KhmP4mvO+r1Q/VHBjMbx3jxUc58WP2CYyE4qMUVw+KoCYWN2n3QYUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790942944; c=relaxed/relaxed;
	bh=8XFpzUVlPtubZNxGByXwzZH4ApuR2nkpwtpFdh8/JOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCpOzJPwl3t0lp/ejMHaefAV2nvOXLcFbtByHtLSUPIZDM+A3LfOO2ok12b37b/Xjulq2sFWH2jr5zlssFYIOw8SEGxJ/m1sdzR2Pfa4n04almo5onwrzzyjN2sBo0gHIOE8KDPEh8e3P4iPvlaWx7Jp37MMfIKkT00u5nTk+G/gVlVC8RPhvL/MWqrTS/EU7WfE5JQDIJ7xUFIyowJj9lnGZQ0f15FM1mTdVlhKjQBK23f4v/4rntltorCJunLrb9qOaPKELahzMpFyiHWT6Y9hzOLp5iPkemeCkiLWBTYMD7o10/HfoKWtt4uk4p6CGJECAZ+9CDJjcY9k6KeOlg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uy5taaAC; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uy5taaAC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hx6yR6Nsvz2yNj
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 22:09:03 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4341A42DAA;
	Fri,  2 Oct 2026 12:09:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14641F000FF;
	Fri,  2 Oct 2026 12:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790942941;
	bh=8XFpzUVlPtubZNxGByXwzZH4ApuR2nkpwtpFdh8/JOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Uy5taaACkmw4lszKyU7Yeuv+r4seDzQWxkXBg+0TVdf8xxURZsAxbErhYfWWrxxpc
	 ioGRh0AkeUlNaM0O/76kHyq/jNHajZ49qlp7kzTK/y9hmtsTG1lIh8zALpUqCprNPh
	 blExfXgLSv3QlLino90K+6/VPwq5Sd4fz4m+VygMzwLykCThr26SJaC6bhFxWHUwuU
	 RW3dRxgv9qthrHmsQVLnchIEH1GFQYCaQedJVw2qJ7fKb4CeudG3fK6a/HZ/Cbqk5l
	 1HvNfpJUOxI5LDkvyRmFGaGRuDENXBtw49ZrKzFNSoza42QyfDgjqhIdIeOYrklqzK
	 NX8pFIwFQbflg==
Date: Fri, 2 Oct 2026 13:08:31 +0100
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
Message-ID: <ar-b_Ug__TBzIZsb@gremlin>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-31-4583d8a23bca@kernel.org>
 <9bbdf4e8-6984-4477-a183-f0b236047381@kernel.org>
 <3557015d-23dd-41ef-9832-78b58587f3f4@kernel.org>
 <81e1e5ae-0aab-4584-81e6-3fc9c2634d07@kernel.org>
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
In-Reply-To: <81e1e5ae-0aab-4584-81e6-3fc9c2634d07@kernel.org>

On Fri, Oct 02, 2026 at 09:05:15AM +0200, David Hildenbrand (Arm) wrote:
> On 10/2/26 09:02, David Hildenbrand (Arm) wrote:
> > On 10/2/26 08:59, David Hildenbrand (Arm) wrote:
> >> On 9/17/26 18:22, Lorenzo Stoakes (ARM) wrote:
> >>> Introduce vma[_flags]_is_persistent() for the purposes of identifying
> >>> mappings that are persistent in the sense that bytes to the mapping stay
> >>> there, and bytes read from the mapping are the same unless changed by
> >>> actions taken by userland.
> >>
> >> That's extremely confusing, sorry. We have to find a better name for that.
> >>
> >> Is this really all about user pages (pagecache, anon) that we would find through
> >> the rmap?

No, see below.

> >>
> >
> > It's also about droppable mappings AFAIKs. How many more users will we have for
> > that function?

Anything that requires stuff not to be dropped behind the user's back, which is
at least 4 cases!

That being open-coded all over the place is a problem I think, and I think stuff
like the PMD device private are a reminder that open-coding all over can cause
problems.

> >
> > If it's "no others" then please don't add a helper function with misleading
> > names for it and just keep the special "dumpable" check in the new form in
> > madvise_vma_behavior().
>
> Talking to myself ... the more usage I see of the vma_is_persistent() the more I
> think this shouldn't be a helper at all. Especially not one with such a
> confusing name :P

There are 4 open-coded checks that test four ad-hoc flag combinations checking
for the same thing - 'can the kernel or a driver change things or discard stuff
behind my back?'

So abstracting that to a helper, alongside the other 'let's ask based on
semantics' helpers, seems sensible.

Maybe invert the meaning to make it clearer?

	vma_kernel_may_change_contents()?

vma_contents_may_change() is shorter but easily confused with something being
writable by userland etc.

Or maybe:

	vma_is_volatile()

?

Which is analogous to the meaning of the volatile keyword.

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo

