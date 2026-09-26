Return-Path: <linuxppc-dev+bounces-28267-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEBF6C98328
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Sep 2026 09:41:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hsMys2Fqmz2yd7;
	Sat, 26 Sep 2026 19:41:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790415685;
	cv=none; b=g7e6JjZb+dZf5u35DxdkziCpPldo7hk73X8FkJZet9DuXnVGUBEfCYXi+214UkwqcbtoMLrkqYeJf4Fr9aawKbe/RIt1AdyaPrTicaKdl5/RC+zSNsnKYg1RzM7KOMY+ooIs3yqc2PSh3EzpqKMshDqJwdF/RIRhQIPTSl8nUePJH/FWJD+OIE69vn7bF1St5zjLmtNwM5i+ZaOTkPM6iHE8nKhhdPD4QCibxQXweH22GYCGgiq+j8rydP7pi+REhjykQi75A1bt46ZkZt/l0tVqy/Y8xlPCmuhpFJdWKajR+6W1LznwzsC17SMpaM+m5c1jtfD3rD88sVKUp8Eirw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790415685; c=relaxed/relaxed;
	bh=0u13dbBevDvvrKeztStjJV2PV5yx6LiZibgW9CGmgFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbUyM5Hw1G//sSpNHbuWEzbPCHQxYmMyQJ9ciIP+6kzYUQq0VYx9WvHDDdtDBISUkKgRsuyeETbYjKnxvhYttLgAsyX9nBOidpIOEbDgoUPtW8XopCP7f7B2fpgSkbQe8znbS2x0p1vDGIBEvpG3BUu848pPhimgR22J2wCZGqCxXMCEFkmjzGLhAk5jda0PBml/FR/sMUDLEorfUbYrHRrTOA8wCwtVYaYtXWaqHTjCNEOu22JZrYrMrUCiRuNAhhY5vNK7mfgC+uR+ix4Oc8v6K8g9ziK2eioA5SGP0l9g3a1/7sBXWwQM/5zow39cSoqs45Hed8YDIMoc3nP1RQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jp0AvcBc; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jp0AvcBc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hsMyq74xdz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 19:41:23 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1C08043E2E;
	Sat, 26 Sep 2026 09:41:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8C81F000FF;
	Sat, 26 Sep 2026 09:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790415681;
	bh=0u13dbBevDvvrKeztStjJV2PV5yx6LiZibgW9CGmgFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Jp0AvcBc2qFPX1KUyqat5xOo7kolWDkC6C0w6P6DaUvXm5iSIG2CZI03JVCmdPvQ2
	 vFXKg46qQ6h6qbDwt9b4xtSV8aaaHLKGAB793g+poJ3xMYhkIZo7xqXL5RLvULfLUx
	 vltnCfE9F9DOd8HFLd4r2r4Sg0lUuE/yF336VcdgoJJtQs97NrE8ayt+3eU4eDKxGI
	 oItyuRRw3Cj0jyhydyYqR3Mm1CDYrci/+rQrHCVid7DDrx80EwRj+MiAUgyhESJ7FS
	 iOAhXbJnk5J5uDUKfyr1oX15QJ3wMcCu5lNOsTEzc+QVqHwaov8/ApQZu8GqGu9l4+
	 gmVl8+MdCcOZA==
Date: Sat, 26 Sep 2026 10:40:50 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	"David Hildenbrand (Red Hat)" <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
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
	"Kirill A. Shutemov" <kas@kernel.org>, Doug Gilbert <dgilbert@interlog.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen" <mkp@kernel.org>, 
	Jaya Kumar <jayalk@intworks.biz>, Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>, 
	Sebastian Reichel <sre@kernel.org>, John Hubbard <jhubbard@nvidia.com>, peterx <peterx@redhat.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Dave Airlie <airlied@gmail.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, "David S . Miller" <davem@davemloft.net>, 
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
	linux-perf-users@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	fuse-devel@lists.linux.dev, Takashi Iwai <tiwai@suse.de>, 
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH v3 00/40] mm: make VMA flag semantics explicit, eliminate
 VM_SPECIAL
Message-ID: <areSEI5pWBadkqIe@gremlin>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <d4d7d4c2-a1d5-41d0-b1c8-8ea0cc5a0397@app.fastmail.com>
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
In-Reply-To: <d4d7d4c2-a1d5-41d0-b1c8-8ea0cc5a0397@app.fastmail.com>

On Sat, Sep 26, 2026 at 12:06:22AM +0200, Arnd Bergmann wrote:
> On Thu, Sep 17, 2026, at 18:22, Lorenzo Stoakes (ARM) wrote:
> >
> >  mm/vma.c                                   | 246 +++++++++++++++++++-------
>
> Hi Lorenzo,
>
> I see that in linux-next there is a new build failure in some
> configurations in code that you are changing here:

Thanks for the report!

>
> mm/vma.c: In function '__mmap_region':
> mm/vma.c:3083:1: error: the frame size of 1552 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]
>
> I don't immediately see anything that you did that would have introduced
> something bad that wasn't already there, so it's likely just gone from
> just below the limit I was using for my testing to just above. The 1536
> byte limit is what I use on 64-bit builds with KASAN and otherwise
> still has a clean build (with a small number of local fixup patches).

Hmm are you specifying this limit manually somehow?

>
> What I see is that this function has multiple structures on the
> stack that have nontrivial sizes:
>
>         VMA_ITERATOR(vmi, mm, addr); /* 104 bytes */
>         MMAP_STATE(map, mm, &vmi, addr, len,...); /* 384 bytes */
>         struct vm_area_desc desc; /* 128 bytes */
>
> The config that caused this is https://pastebin.com/raw/5M95qHy5,
> which is an x86-64 build with CONFIG_KASAN_STACK enabled, and likely
> a few other configuration options that made it a little worse.
> KASAN_STACK tends to double the stack size used by structures
> in order to catch out-of-bounds accesses.

Yeah, there is a lot on the stack admittedly but there is also a lot of state
being used. I'm sure we can reduce it.

>
> If I sprinkle some 'noinline_for_stack' annotations on functions
> called by __mmap_region(), I can get the size down to 1144 in this
> config, but that doesn't sound like a great workaround.
>
> The large stack usage is potentially harmful if this ends up
> in call chains that have additional large stack usage (e.g.
> kmalloc() leading to reclaim). Any ideas for how to reduce it here?

That can never happen :) this call chain is _only_ for an mmap() call.

>
>      Arnd

In general I am absolutely taking this seriously and will find a way to
reduce this, but my only question is whether this is actually something
that needs to be done in this series?

Because it's already huge and I would rather avoid adding yet another patch
to it if possible.

If I can do it as a follow-up that'd be ideal!

Thanks!

--
Cheers, Lorenzo

