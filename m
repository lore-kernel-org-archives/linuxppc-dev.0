Return-Path: <linuxppc-dev+bounces-29289-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925C8CC6B02
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 18:21:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3QlC0Tqnz30TP;
	Tue, 13 Oct 2026 05:21:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791829271;
	cv=none; b=jmzIWQBBV/sJELsFnu32Ij/TUSnZm6HWO7QJToOcGe1p48dwDesjxdze01P2BegahishmHkDys7S9ryn8KcAiKOq7Oq0PJ0wZkm7qjoHfEh9FFtYpAJn0VLxucUeMnnMgWBHJwAXOa+WJ+92rOhjjCbUa+LFFuPFuaRWOSgDT5Hkz92fliiqYuzWfIEia/5Kh+wk8OxddP7qn2iQFimVD2b9UANUY8y0j0HFt9Kprke4zTga4V+Y7QhdXcW6mvdnMzTvL0o9JdF6oyMIasoi/E7owWbHk2TgYUuZnMEPgWEe2lclz+I8bS0Bugc1iepzPkGeO8lGDzjAg90/TXaYIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791829271; c=relaxed/relaxed;
	bh=hHBESK2KlCwsi7XB84TfEpjCQoYTSyYlt8B230e+MvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIjdH01F49inuKwJkH7USZUmb7KmHaUTyhq8n7dYpwAj/Hx4tEpM2Qi6HjfXMJKuhQWZHDpjp9RX/Mr1ACeCHSWTO8X0EwSB301zgovzXRd3wSYKZMuL1hT+ZD7DRY76KtC9ZsR5N4K+kh/9kDZvSj9ZhmQpX7WvyqwYzNcsS7wfT4rYC4Avi31T1zyJOR5dv34brCyRYRyDqv6uknMQuT8qvrlC7jilZhnDdXADxlmrFHXdyVXoByYqcxGD6dD+oSt+puKnoh6DLype0LCt1cz6A0H7L5hS/EyqBqZIcJnIeBXPZcW6K8U4mYxpyPy/UTdIbVC4KL1KyDqfxAhD/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VPUP1ptH; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VPUP1ptH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3QlB1CFsz304Q
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 05:21:10 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2F2056025A;
	Mon, 12 Oct 2026 18:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A8A1F0089B;
	Mon, 12 Oct 2026 18:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791829267;
	bh=hHBESK2KlCwsi7XB84TfEpjCQoYTSyYlt8B230e+MvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VPUP1ptHnUHORU4MhilrkP5qlYiqZl6uWQDj+FeTap+RZDGyNIOHJBlPuJoyubu2U
	 27BPhvzI7hrw6tlV9qGYW3Bu9xbjOCwoT5tfsKgj5lDpP8wdrsja/bAdDi+YFjySu3
	 IwgvUFFeGgP9UR9jS6daeytrBIIe3ZFrXI1wyOg7/TFojKCyKzv+Adfn2hE4k+wDKl
	 DI3jZ/atSDaAEZmzlmGBncR5yOZWy4taUp3tMoOLjqzqlsy8Z4Gxz7TnELqPvPiA84
	 Sc3daMmrLe9Fxn0SFCfRQ4uacS+2HvI80EDpBY4PxvpLH9W2BkEm1myXJR31ClMRGb
	 4yngVYRbe8aYg==
Date: Mon, 12 Oct 2026 19:20:17 +0100
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
Subject: Re: [PATCH v5 21/38] uprobes: remove VM_IO, set VM_MIXEDMAP for
 mapped kernel pages
Message-ID: <as0k0F_td3WzR8wh@gremlin>
References: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org>
 <20261009-b4-mmap-prepare-vma-flag-sanify-v5-21-923b70125b1e@kernel.org>
 <6f71b1b0-8988-4e19-9d4a-ce8a2de8fc63@kernel.org>
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
In-Reply-To: <6f71b1b0-8988-4e19-9d4a-ce8a2de8fc63@kernel.org>

On Mon, Oct 12, 2026 at 08:16:56PM +0200, David Hildenbrand (Arm) wrote:
> On 10/9/26 20:04, Lorenzo Stoakes (ARM) wrote:
> > These are not MMIO pages so VMA_IO_BIT is an inappropriate flag to set.
> >
> > Instead, set them VMA_MIXEDMAP_BIT as they are kernel mappings and this is
> > the appropriate flag to set for those.
> >
> > This provides the semantics required - no VMA merging is permitted, but
> > does not prevent GUP.
> >
> > However this has no meaningful impact as these are refcounted and thus can
> > be GUPed.
> >
> > A previous commit already prevented __mm_populate() from being invoked on
> > XOL areas, which VMA_IO_BIT was previously relied upon to do, so that is no
> > longer required.
> >
> > Both VMAs set a VMA name, so always_dump_vma() returns true before
> > vma_dump_size() reaches its VMA_IO_BIT check, and thus there is no change
> > in core dump behaviour.
> >
> > Change this for both the core xol_add_vma() function and the x86-specific
> > get_uprobe_trampoline() function.
> >
> > Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  arch/x86/kernel/uprobes.c | 2 +-
> >  kernel/events/uprobes.c   | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > index 65a2de82ecd2..0f60c0d076b6 100644
> > --- a/arch/x86/kernel/uprobes.c
> > +++ b/arch/x86/kernel/uprobes.c
> > @@ -715,7 +715,7 @@ static struct vm_area_struct *get_uprobe_trampoline(struct mm_struct *mm, unsign
> >
> >  	*new_mapping = true;
> >  	return _install_special_mapping(mm, vaddr, PAGE_SIZE,
> > -				VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_IO,
> > +				VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_MIXEDMAP,
> >  				&tramp_mapping);
>
> So these can now be GUP'ed. Let's hope that's fine ;)

Yeah the commit message mentions that. Since they're refcounted I don't think
there's any problem.

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

