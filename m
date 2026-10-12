Return-Path: <linuxppc-dev+bounces-29320-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07999CA9EDE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 18:58:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3RZ93x76z2xbQ;
	Tue, 13 Oct 2026 05:58:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791831505;
	cv=none; b=Wbk6GuhCo8SPKf57QysJVpvg3mjlSy8bb+NYS6Aw+lcJGuXv4IF+ThwnwjgS09FUdsZlYgePfezSOexPqWKS6OboS2aqLHk3NtcuzjA+3ks87lb/D+7HAUI8aFxx0fcgYxwOBNh6RvecJb+eR8EE4KO2RGAfwP2EVOZIC/yFDIsxBR2aI0i/bYG2IYu35xvJl3ragtJqWb0ny+vmOgqixr78A95rjT57NBO83zOTEY4metKcLIHBW7rhq9RGL9x/Cksfi/+kNesf3BGMObppPnBVKopPPR1z1xrZp8/DERst6XY6dXKau5Lc4Kec5xUGqSWR1jyPSGk8fh4K26J49A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791831505; c=relaxed/relaxed;
	bh=qH+yTBGHMx4kskcBpBDKONKQ96Db6V1NplbT44nRvZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBTiJvPnq3SSfxu7eywrql3ybWHX1NPbx+dnLgl79CW7r8/Rxxokv1PRPlHBlzcU4AWs69f2IzpZrt991km4Iw6Ly8qT0K2A7DDh0oBSN6V9U69FAgaMhbYDIVHJ2qm/5sC4h7MZDy8Wiz0qkpGR9ee1rYrZeBcAS79qfHBhzM5tFNmlCtjEU5HWGFZxfkUMyuN/bQSS0kkPTvqFxhDKXNZkm9P6x5fbSRI26HKqI5nhJ3OOYJkn/teSGOv5Fu4gbt8fpsZ2b+vUg+7t+cy4OsKJTxBelWat0wUj/3QcPxZvwUGifhA5IWtyNN0/oGVfahS4UZ6Vzd/GfDGgXoHO/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=looXlA6f; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=looXlA6f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3RZ84gz6z2xSV
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 05:58:24 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2980C42E9B;
	Mon, 12 Oct 2026 18:58:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5EB01F0089B;
	Mon, 12 Oct 2026 18:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791831502;
	bh=qH+yTBGHMx4kskcBpBDKONKQ96Db6V1NplbT44nRvZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=looXlA6fTwVHV01oPQjKIsaLN7qg4gOfpfxfIKT2JYCP5qc6mtNOfKXzipcBrh5Ot
	 PwTlWcUh8iMGaWDsLLerJWirxQS11zQ+uNPPZD56vjlnfd4Xt8Ty0QR2gLNZRLAVmZ
	 XB2AV4YuqJ2oKkV2g5m/6Icmp243c7oQwlXcOgSGhet9aPBJl7BLHiRyQaIFfTFg5f
	 R5mIs3NuvgJeGZzERtd7pZ/l5Ywtb7I+I+N5/X1JMKypG8+SLTaEsyrMX/W1aLWQJP
	 x0/ar3g7y36ElH0BWNMVIYJBfaYlLx77JuLREXrJFvmLlG+LDzzGKzUyJUzEJO7zAF
	 41OpXgdKh9hhA==
Date: Mon, 12 Oct 2026 19:57:46 +0100
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
Subject: Re: [PATCH v5 24/38] mm/vma: enforce that mm-managed mappings may
 not set VMA_IO_BIT
Message-ID: <as0tfn85BbcLs-Kn@gremlin>
References: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org>
 <20261009-b4-mmap-prepare-vma-flag-sanify-v5-24-923b70125b1e@kernel.org>
 <5d51b6b3-ad58-4827-bedf-f1a79ebd5c86@kernel.org>
 <as0nF53W7dug-Fem@gremlin>
 <5ba7305f-0ad1-44ee-be0b-36752684cdb9@kernel.org>
 <as0qUOfS-FQgRnm4@gremlin>
 <c0b212bb-da62-476b-a16d-2ce78e1e2639@kernel.org>
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
In-Reply-To: <c0b212bb-da62-476b-a16d-2ce78e1e2639@kernel.org>

On Mon, Oct 12, 2026 at 08:51:10PM +0200, David Hildenbrand (Arm) wrote:
> On 10/12/26 20:48, Lorenzo Stoakes (ARM) wrote:
> > On Mon, Oct 12, 2026 at 08:39:35PM +0200, David Hildenbrand (Arm) wrote:
> >> On 10/12/26 20:35, Lorenzo Stoakes (ARM) wrote:
> >>>
> >>> That gets removed.
> >>>
> >>>
> >>> I mean we do that in a subsequent commit, I think even the next one?
> >>>
> >>>
> >>>
> >>> Yeah, but to do that the code would now be something like:
> >>>
> >>> 	vma_flags_t masked = flags;
> >>>
> >>> 	/*
> >>> 	  * vma_flags_is_mm_managed() tests VMA_IO_BIT, which will be removed
> >>> 	 * in the next commit.
> >>> 	 */
> >>> 	vma_flags_clear(&flags, VMA_IO_BIT);
> >>> 	if (!vma_flags_is_mm_managed(masked)) {
> >>> 		...
> >>> 	}
> >>>
> >>> Is that really worth it?
> >>>
> >>> I don't think there's really too much confusion intra-patch about that is there?
> >>
> >> I would do it as above (- the comment, as that is the next patch indeed) and
> >> only remove the vma_flags_clear() in the next patch.
> >>
> >> But in any case, you should spell out that this is only temporary in the patch
> >> description :)
> >
> > And then there's a 'masked' variable that is unused?
> >
> > You need to have two vma_flags_t variables to be able both clear VMA_IO_BIT
> > and use vma_flags_is_mm_managed().
> >
> > So the change would have to be
> >
> > + 	vma_flags_t masked = *flags;
> > +
> > + 	vma_flags_clear(&flags, VMA_IO_BIT);
> > + 	if (!vma_flags_is_mm_managed(&masked)) {
> > + 		...
> > + 	}
> >
> > Then:
> >
> > - 	vma_flags_t masked = *flags;
> > -
> > - 	vma_flags_clear(&flags, VMA_IO_BIT);
> > - 	if (!vma_flags_is_mm_managed(&masked)) {
> > + 	if (!vma_flags_is_mm_managed(flags)) {
> >  		...
> >  	}
> >
> > Which doesn't really seem worth it for somebody who is confused between two
> > patches mid-series.
> >
> > But if you feel strongly I can make the change like that?
>
> Whatever you prefer. Most important thing for me was finding it in the next
> patch and being pleasantly surprised ;)

I'd rather not then!

It was always intended that way, this was all part of a careful dance to ensure
correct behaviour right up until the point where we enforce that VMA_IO_BIT is only set when appropriate.

I can update the commit message to reflect it.

--
Cheers, Lorenzo

