Return-Path: <linuxppc-dev+bounces-28194-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF648C98324
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 09:35:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrltd2fVFz2ygX;
	Fri, 25 Sep 2026 19:35:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790328937;
	cv=none; b=ZKTUo1aoAb+fvxYhPTRHMe2QGEr6qXLLySXMxlStBCYQPngKBA2CO2BJ56rXJvvky6GpFakQPDTcKMo0J9piHEUxa915iI8VZRi15GyM1dCCWbAayw2KNbVAFZaAHfrXa90r6/LgowsrbA16kUrXus3XYAHTOBkBnzcE9bCH/OxrbtJvder31rWORpfApPkq9lxW6O65PuPWlSoPA1Gxda97F7ZOacBioqb30IHHEK/Yv8GoX6ru8V9atpHIaXdeWXmBzPWglkrLZXT771mvT/UqaUCuoRapYxWBbymavtvvGVlzRMEKXSca3YLecW8ax3XnOnHQJ/MgEIjqHuKlCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790328937; c=relaxed/relaxed;
	bh=uLG5lXHaGba/dPImy7unpJ5IThclo3TEAxLWPTrsKfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SApIADs4De8GRbCJD4QB6kOkztRw7DeMwziJjrl5z7CSSsYQ9Q2out/Osh9NFM2GsE/Lf3FOQtkTBRZ5pntbsNGx3G7xUa4HFhHkob8PvCLnm1nYvLe4sgDIFW2bDCGo23MbCd/SqqkgNJaMuOBt6A6G3EtJjNf7SO2jQxdlFTPowIVBOlv+vEMcJavSGrh0NkFBveQNupQ4K07R6pNOjI5F6LqT4jaQPY2ATwc6zDJ5rT2fdemGHDqO8L4CNnbCF8jHhdXTk05hewxyfH1bYrZPwo1jJh04gpRFmq7xzbfA9xz38BjwZZol9Ak8lNhBWRW3v8V0b/KHbhgCdU3ViQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bzZxhyhs; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bzZxhyhs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrltc2zHQz2xCC
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 19:35:36 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F1788417CA;
	Fri, 25 Sep 2026 09:35:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC6D1F000FF;
	Fri, 25 Sep 2026 09:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790328932;
	bh=uLG5lXHaGba/dPImy7unpJ5IThclo3TEAxLWPTrsKfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bzZxhyhsPfPrL97TbhC325gHjRpuHNOnRAtDnIf7+He5gMfkm4PSOaeLWWHbi8c+l
	 6gLN53Uwdjt1XIK0OfcSHtcQmumMJlRTA69LriLBQLJ0wlctJVs9Bq/WbFIYgezX2S
	 o7HKidp4dQ3owP9NtNKbVP6jhZCshUTUiQ66DK4nhMPv/dIHOX+rBfreTpiYW/Trbr
	 lwzJ176A2TJiIAwDANzHglZssZ2IwPz45AtPMn/Payp0HQBUyL8MtoMoRwY1oA7vIH
	 So1mhkj16h3+GX9qr62k4qaQbTa37MdNPZHhAdlXJfG4rCoV0gvFtIiYsigAgrqycF
	 Yh3V65CGNEVUA==
Date: Fri, 25 Sep 2026 10:35:02 +0100
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
Message-ID: <arZAC3fyGMDnxiFX@gremlin>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-24-4583d8a23bca@kernel.org>
 <93672B94-BB0C-4713-8F8A-3619D81DB7BB@nvidia.com>
 <arT3K71l86fUVldk@gremlin>
 <CBD619D6-8717-4C81-B5EA-D1D0771BDA3A@nvidia.com>
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
In-Reply-To: <CBD619D6-8717-4C81-B5EA-D1D0771BDA3A@nvidia.com>

On Thu, Sep 24, 2026 at 11:50:14AM -0400, Zi Yan wrote:
> On 24 Sep 2026, at 6:21, Lorenzo Stoakes (ARM) wrote:

> >>> diff --git a/mm/folio.c b/mm/folio.c
> >>> index 47a437e0f7fd..35e242b48870 100644
> >>> --- a/mm/folio.c
> >>> +++ b/mm/folio.c
> >>> @@ -505,7 +505,7 @@ void folio_add_lru_vma(struct folio *folio, struct vm_area_struct *vma)
> >>>  {
> >>>  	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
> >>>
> >>> -	if (unlikely((vma->vm_flags & (VM_LOCKED | VM_SPECIAL)) == VM_LOCKED))
> >>> +	if (vma_test(vma, VMA_LOCKED_BIT))
> >>
> >> I think it is worth documenting VMA_LOCKONFAULT_BIT alone means mlock in
> >> progress, like you did in munlock_vma_folio(). Just to keep the protocol
> >> explicit for all the readers.
> >
> > Well I'm not sure it's necessary here honestly, because this never checked
> > VMA_LOCKED_MASK anyway, and VMA_LOCKONFAULT_BIT never made a difference.
> >
> > So the meaning of VMA_LOCKED_BIT here is strictly 'is it locked' and it's
> > correctly handled.
> >
> > And I fear that it becomes whack-a-mole - the neat thing about this change is
> > that you no longer have to special case the stupid VM_SPECIAL thing, and can in
> > fact do the 'normal' thing of _just checking_ VMA_LOCKED_BIT :)
> >
> > So I think it's better not to.
>
> Your reasoning makes sense to me.

Thanks :)

> >> Why I am commenting in the middle of the series? Because I am taking
> >> a quiz given by LLM based on this series to get myself enough background
> >> knowledge to review this series. This mlock part came up at part E
> >> and I only have part F left before I can do the full review. :)
> >
> > Thanks! :) I really appreciate you taking the time to look at this! Sorry it's
> > so large.
>
> Sure. It is great learning material for me. Thank you for the patches.

No worries, and sorry for the size of this change...! :)

>
> >
> > I held this series back from last cycle to help with review load, then spent
> > some time fixing various AI-discovered things, and all the patches are necessary
> > (well for the most part) to get where the series needs to go.
> >
> > I think the change is worth it though!
>
> Of course, great to see hacky code being removed by this series.
>
> For this patch, feel free to add
>
> Reviewed-by: Zi Yan <ziy@nvidia.com>

Thanks :)

>
>
>
> Best Regards,
> Yan, Zi

--
Cheers, Lorenzo

