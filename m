Return-Path: <linuxppc-dev+bounces-28893-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71290CA5FE6
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Oct 2026 18:39:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hyWWw5Nd1z2yYd;
	Mon, 05 Oct 2026 05:39:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::82f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791139164;
	cv=pass; b=AXv8DjSvanfODq5SuB49sUPnis3eeXBfWFBFuMXjdFkwNwZiOYOYvt9VYb+lQJZ2GK4k1brAOWUN1EqOpvhjpC4IfpyivyLAUhz73Ttb3xGUSn4fsXuwGJ0SXnSrb68KUUOLiNFhqk/GPITwVyf8YTqaMY2P9+KLNJUfRzJfkpKf5cdnEJuvlhEyKtnWMbKcEkATcioMr2/41NEpaXuTqWy7qDRGf8TD9MuU0EyKrC71Mn1oabI+qy1krcd7/5TlGin4uApb7+nOU48x4v5rJkx5EshlxBGjUlSkPurRsVDFCwWO40GPXrZQzoX2tnFVpiELveZrExtb+gvJ2RIJKg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791139164; c=relaxed/relaxed;
	bh=ZSC0w1neootLkbih9TUxoXkKPCkBI7t1n5ZaTzyKsnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HkxQoUTRwMyhVZCbAFMEyXBcLSmweCXarLvUKnR9TRolugc0tL7Xp+irAQgnfEA7NHdgKAhPOZ88sQOzXMQnbDTIxC8Yiep6T+q5BMFlc8r16vevYo2lCWP00XpV8KtHPveuhZyDpuCzmeobvpng8RlXJpDkiLB1ULgInJJ4rfMccWlETERbjiMx76KJpu/TNgoangIo712UNrEbf6XZDISpnnSlZtBhkiNds5K8K3I33PuJIlWw2XyYk2g63EbOpIg5nrPBSiTv/PcsM62klslWfXjWWJpt7YGqLpjOvtmqTgKfKTSxZAkkmvR/1N9KgDqQ1waEidTKbDLqP46PAw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=UTqu6AJ/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82f; helo=mail-qt1-x82f.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=UTqu6AJ/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::82f; helo=mail-qt1-x82f.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hyWWv5lpHz2xfq
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2026 05:39:23 +1100 (AEDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-5337fa12431so186821cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Oct 2026 11:39:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791139161; cv=none;
        d=google.com; s=arc-20260327;
        b=oul5FCSMwHWGGp5Y1u/G+aS5qmty3Hv7lfFzonEBTfIpLttzBw6hXSe0TjuulJ4TeU
         RY9uyzkhsQNStr/km36eDRgrDyRghWtNYKbTvxST0RvEfuWD1Pxlh2esRI9BCTRY0Bdz
         3hKhQAVsqeLpFdBy5IdvZ2uetnPXjtA6wx+ch7+ywDDilvzjVsLmqrPbsuJix+Fh/IzS
         PAmZ6b3bms75PCmtw9bv3NA8+EAqUOgn2mwHH45OZxwAO9lBj1r+Iywfod6rZY4c//ZQ
         Chp4PfLLXOKh9gVoG9OkXeA2zn5l7INjiSv6OlPNyI7P0UUe+LWwvWubojHRDMCYJmvs
         jbeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZSC0w1neootLkbih9TUxoXkKPCkBI7t1n5ZaTzyKsnU=;
        fh=YIEspMztjm/uk3eD9oDY9e5Dx8fTQq5xB1uTKJT16GI=;
        b=J+g3dXxzM0Ixw2A0wB7cXgseTSCFHIuYJbOoJbBmMZg3Yws0QUBewibWFPa7TKIutl
         O0zVoTxN/fuGVB5nLfCaa9yc3SkfRmCUSSjL8ykKK5l3DQ+3lBZjgFiWMeBUfXtgdx67
         TbfNV/+M7nZP47pgbvlJ7YI3MN/kSGDs1uMR1Up6T4EIUMjFPXwNnqaZlbMCRjxeAIhB
         p4iY/arwMehxzd1vTJ7wIPE00SjAYmBnPzqJajj1HuYBTHWtKD3zluBf6uWhJL9z53a3
         nuZ6y0qcgWWUSuCzjDBxVKeyGod/yLnrzweNNmW0arbIXWYWDKSzol+A6awwUNW042f2
         tUdA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791139161; x=1791743961; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZSC0w1neootLkbih9TUxoXkKPCkBI7t1n5ZaTzyKsnU=;
        b=UTqu6AJ/E03DCEl3UqK2rrKx/ZUWRWvnW7vgult1guRUGh39H1y7u35ViUAgFAvW7b
         0KdHtTCTYHyC9Bh8lH53xOEo4pv1QXfDUmc0a4nU0Db66QTL4uHdoyxLBi9J7Okve7Fl
         1MXK3BJQkIQRikf5RSyHrEXQXOfvNf16mKKQuagxyAkMZD51K00VJMpSWQjq6RRAsKmN
         YrdpqSy/ReW+O/0fZu7evWi3sp6d75ceI/vAnNqzWEAwFCkOmKnRmk9zTWEchLeALPW6
         5tsLvlEN2EFDxwwNsgFMtSrmGt+LMluLgQgwORM4vQGODHfB/15k0iQScLjSVTIlWM0O
         nEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791139161; x=1791743961;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZSC0w1neootLkbih9TUxoXkKPCkBI7t1n5ZaTzyKsnU=;
        b=cHodfaDjXTsKI932B7ZANRn0C+qEdh4liHGZRkB7NVV+4DS8DcvNpdDsvLPOHqWL++
         2KoE/t7bdPHIQtjvuVsnKPbIjLmhJbnsuQDUEaYunIwinSNRo3lzGp7ELrfIJpPjLCSW
         wPGGQcM9SqrKC66Vtlp1QcutjDoH/yWeW2IkINCTe/uDaNq6/h54FLSDhpISPG4qUhO8
         Yd5wvZXiX4oPq1JA94g1k6sEloJlzSVKj+yPjnbxQggHD/t1Bx6nekKhIa01W0UcPwDP
         2oBwkawGrNSG3/dYovzVI3Xj2DrkzHKOirXWQuFsLyUHKOUZwLpbVfH1W0y0p6idH/E8
         JYGw==
X-Forwarded-Encrypted: i=1; AKwUvBy0j8HDUOd+bzDazTZhbhzwFrtvIq8rRNe+7C4zwbc/Ujy9dGVPGZnEI5SK4jIfzG0mw7mo6waqoI47mH4=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kKOxLWmUie9yBQ7ePcdVNUUAUA5TEAfW8HH2srg74/X/0VK4Ol
	0f3GDwYI+xOt6R4LOucHWd/JuR8i8maP7F3tFDYQQEBYanR+gtqrWLcJ5vkjCpAnzx52/AZGrTd
	NoDCR0xKFdjkK75HPiW91oBSyz2JaCRBdvINtduuQ
X-Gm-Gg: AYBFou3hwSChnxKC86tT0BzlHmpsJCMf5cRcB+KtYscp1bnJUsQ1hYHHm85Oh4HI0GL
	VrMzp6J693cE0WqNSEUIwSKOrtpBj/CmyqK5R/kJWbNKdq6zD6R/1hwqjKEaiQsta8b6kypdpqI
	yEmSrr4YXbPW1bg+b9pGdUOUR+yLf/2uRUo4LDrRWIvCu6dU57BOEndKpBhv+1iN+hA2UeWvYci
	RCQmzhoYYzXCz07yHVEeYY4bFoIQ1xhDaSdXCFN3o09TxDnEGPArudkqWZRODJMLaQLjokS5VJL
	3LpbpxXlgbxpGncOkNK4yy/poUfjRJpKWJEbqgpFo/EaFwn3fvJoIFMP
X-Received: by 2002:a05:622a:a16:b0:531:282:6560 with SMTP id
 d75a77b69052e-5351322e1b3mr19806961cf.15.1791139160071; Sun, 04 Oct 2026
 11:39:20 -0700 (PDT)
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
References: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org>
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-21-a1f052500fd7@kernel.org>
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-21-a1f052500fd7@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 4 Oct 2026 20:39:04 +0200
X-Gm-Features: AclHuK-BFFMO7RL_23L1uoIyefqTPzoxo4liaojYggefG4PLZrnFo0OrrSwhSqQ
Message-ID: <CAJuCfpGtyaqwi__OXcB=iy2+LUVzFnLo-Q=Rdxz728_EHdTaWA@mail.gmail.com>
Subject: Re: [PATCH v4 21/38] uprobes: remove VM_IO, set VM_MIXEDMAP for
 mapped kernel pages
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Doug Gilbert <dgilbert@interlog.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>, 
	Sebastian Reichel <sre@kernel.org>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <baoquan.he@linux.dev>, Youngjun Park <youngjun.park@lge.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Xu Xin <xu.xin@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-rdma@vger.kernel.org, 
	selinux@vger.kernel.org, linux-sound@vger.kernel.org, bpf@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 3, 2026 at 6:40=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> These are not MMIO pages so VMA_IO_BIT is an inappropriate flag to set.
>
> Instead, set them VMA_MIXEDMAP_BIT as they are kernel mappings and this i=
s
> the appropriate flag to set for those.
>
> This provides the semantics required - no VMA merging is permitted, but
> does not prevent GUP.
>
> However this has no meaningful impact as these are refcounted and thus ca=
n
> be GUPed.
>
> A previous commit already prevented __mm_populate() from being invoked on
> XOL areas, which VMA_IO_BIT was previously relied upon to do, so that is =
no
> longer required.
>
> Both VMAs set a VMA name, so always_dump_vma() returns true before
> vma_dump_size() reaches its VMA_IO_BIT check, and thus there is no change
> in core dump behaviour.
>
> Change this for both the core xol_add_vma() function and the x86-specific
> get_uprobe_trampoline() function.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>


> ---
>  arch/x86/kernel/uprobes.c | 2 +-
>  kernel/events/uprobes.c   | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 65a2de82ecd2..0f60c0d076b6 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -715,7 +715,7 @@ static struct vm_area_struct *get_uprobe_trampoline(s=
truct mm_struct *mm, unsign
>
>         *new_mapping =3D true;
>         return _install_special_mapping(mm, vaddr, PAGE_SIZE,
> -                               VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_=
IO,
> +                               VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_=
MIXEDMAP,
>                                 &tramp_mapping);
>  }
>
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 7709ea882477..b89cc5cee002 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1726,8 +1726,8 @@ static int xol_add_vma(struct mm_struct *mm, struct=
 xol_area *area)
>         }
>
>         vma =3D _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
> -                               VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO|
> -                               VM_SEALED_SYSMAP,
> +                               VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|
> +                               VM_MIXEDMAP|VM_SEALED_SYSMAP,
>                                 &xol_mapping);
>         if (IS_ERR(vma)) {
>                 ret =3D PTR_ERR(vma);
>
> --
> 2.55.0
>

