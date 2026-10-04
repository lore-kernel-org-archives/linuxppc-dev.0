Return-Path: <linuxppc-dev+bounces-28892-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6623BCA5FE6
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Oct 2026 18:24:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hyWBl3ykTz30PJ;
	Mon, 05 Oct 2026 05:24:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::531" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791138271;
	cv=pass; b=QaHsbozVpbYoZRXqMMgfoewQKn60QeflEXgqfLX5el4oQnWu63+6lsII1MVJZEx0PTpEmvVFmu50d6lHNFAOGFMachOwlzpR19RxFsJrXGSSk2BdMEs+3e4an5z5BRUERwzuWMyq0rsxUP1DaDy2kJy8gJ1ruV77P4ILHgysJwNWxx48BWkKVC9pYr+2+IR1mWJjOApwwBMlrCsxygCcyX2ezsL4F4rM+e+GjlfN1LfpP9+kYdlOFhwyj1B5Pl8DwGttiX0AnD5Xl22AHpwLNkorXDFb0Wilkw6bwUAaJYkF13PUwB1Lm7nMGnyl1glPRiP9+P5gzGgXcXmOZhArFA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791138271; c=relaxed/relaxed;
	bh=COuPsBcUBk1eT8Q71dO8QdpqB3ZPgP0C77xCCCNJQiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A7QtVWVSX65o7XxKL6BeNEc7BBvbLhyClCBLBbnG1b7fWD9NN8IkH6Br+xboEhSDKcxIEap3vHIkx4pf8gDwuSWY/14zRysGD84QBmUQQ72NJb9NZMsO+0oFgck5qy9a+d8rk+D1rh72f0bVbQl4AA/aZZs1+xpAuT0tVO6BzKz3FSD38vXqA+TdWZnoe4XfIsHj2QMsIaySeaLqrUcLWzwcuQHCIV/Vt0g+a3zEg2v2jVrxmVoJuD5i6SGi+ZXsKHExE9q0t2Gt9HptxaQRuWESCSOA1ciUCZZhwMzPbkNiLexGbngqRw9M19/sQB9JXh6sGoDU2fhmnoSXRWZbag==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=lKnviLle; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=lKnviLle;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hyWBj2RSWz2y2K
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2026 05:24:28 +1100 (AEDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-6aae147ef9dso7798a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Oct 2026 11:24:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791138260; cv=none;
        d=google.com; s=arc-20260327;
        b=NfItkDKmbsJqqX3+RG7GD/z6vCK/i1yilPe2N+OP8G5moldqHXHMnGszyMKiwEOyLx
         iTSrFC4/cVuW0DyiEjd0boJrtmdm2rg3Dwh5XRZkHvd3fLR0H9rctNRJagHl+p9ZLk9S
         7iDR2Ofz06Qt6qzSOd++N8N+n35DmugzMuB05tGwtrS6o6tzEVsGx0AKxqxKa5f2ZYSK
         1iraeRAuaCPREwO8MUBA/HEInrFXwZcBOTu0XC0xC40SjyL5sNyLl81E44Y9CzStF2Tu
         dg93HAixxdYbYobu77vxgTRtXSUtE69OlSxQPyOeEmESSCakINJEJnSx9yRyQfxcrVyd
         UYAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=COuPsBcUBk1eT8Q71dO8QdpqB3ZPgP0C77xCCCNJQiA=;
        fh=i8em0rjSteAASGD/5CRMQKuDF+xwWXToD89xYzizGUM=;
        b=cWBjPnro6VW3Pflt7aFxuBWHVbwXO3cmCe4kqUvYwBsVKheMMTX9fpOXP6uYynAKzA
         FWMHKLVCkFXIR+H9hiF75sD+i7up/gdHYHgJtPVytE7ZlkQZia2J/va+U6MoB2xeTTY2
         3v+sbDDcya9aDOwBSjJ7A4tBfihltUf5WZJ6ZDMHEubugnmEodLph70Hyqxrt4INk/Bm
         6xKRMHQPVg+SEbnd7SRyl9ZfJwG5TKlC3oz5IJ6AyxubVmZMxVsVE4qNuYYGc1r0qRl+
         FrtuZJKhmkUVaVoet4p/iqXsVXsKw6pKm93t7RKe2zKljZKXlSZhhd2qDL8XpiNvPZ3i
         xDUg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791138260; x=1791743060; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=COuPsBcUBk1eT8Q71dO8QdpqB3ZPgP0C77xCCCNJQiA=;
        b=lKnviLleVSFMfomQ9GJyt9SS3RBUtbsMR1GJ5pXbvqnHsowrQovT+6NH7p+zwiSSCx
         IP5ul0Hx8H2qMyzkBZDpiNZ5HqfToE5bhZ1tfEXTEkf/D9rSm3LLOPxBcmdp9DrN0Gkc
         0s1NVA5vn2ASdaEPWQsg9W8+eCh/uK2hbMQeWDO073uKeg6ciPLj0QPqKzps0x4o6HX3
         Xc6zKwJnbMwzlaAzkjcXS1JHNPAjwEzMNw8kB4OACyIEvP4eEnF/FCsQ2YH2/F6wedUU
         4JnE9ce+f4jOfMFHK1DVOr+z2YnVmS69XIayFS+gxMa0hMvda2l6clcZGizJFfBand1O
         Yl9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791138260; x=1791743060;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=COuPsBcUBk1eT8Q71dO8QdpqB3ZPgP0C77xCCCNJQiA=;
        b=oWDvY6/NYbisfYvphMQ2vT5c/4y76ZIvOa1/lr9ZgZHSyoMhJqhadx09hWu7XmVHPb
         IfijtBqZuueqbtovZ+moYjNgNS9E5GTMJbBs+T4hVd8verH8dkuY2eCJyFeuxxt9LL/B
         MDC0Lgm6q3n1yjokiVFoMn3Hx3pNk3FgGDtBurTySADfH7fGu43MMK0DYukXK24e2aFy
         SmW5GQCQhTpoM4D7stEWP0OmOWdBxXNLmbHT5d6rOlbp/aSRin/CP7MAuFAemQwaUzW5
         rWeWkIBWHfkyyp0T567PIVGub+OTPYCjyiD7XhRGw3/cdzMmf5LyTd31tUjn5d4HmRz6
         4hbA==
X-Forwarded-Encrypted: i=1; AKwUvBweK0cStEi3iCjDKhgkcrEEF4nnbZNY1dTV7F5ppegI6ymogwkTfjh29iSIq/Ug9d633MZf8M7+bPMODeY=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJhVFs0q3iPK1a6mFpIvNSfSnkSGlI9jllq7HgwI/NlE7t/bcOt
	SJx6q2ISQcTeTjqO+yhSJiQ35SzagquZ6chdenPvh/LkvzFYFifZ8rEIAjpXUUXQjQDVQNwlHXu
	IGff2UslwzL7FQexacvSQiOujKGuACEVtbVOasyrR
X-Gm-Gg: AYBFou0aEWEIPRmbTgjyhGe8QyWT9JGpdbRIGcJ20uCOpQMWPc23xKOj9VYMGez9Hvc
	DQEFhkAXJXTfK9PBX7XIFr/l4FBC/9044940NmCdUsIIS8+5OUSaKJkcvtcpsKBYrg/9qdRaBE4
	etwarbv6QdZR0IEFNewA7PSmThRZlM9R8etBDFJtiu1BiQ8yanZk2Iqrkaxy7VOYtxbxBZa0yqf
	g3dhkuYzVzza6qbK6zHw/D7zuWO7uEV8RpUyZybUxsolKpM6ZODaAeJ0o8NEN0X5ai8qm0BAxfu
	NntjlGypoZFM1rbPaMQaLEjSg6vW0IVFenAUWevxbRzyyHsjHhTikO4oTt5KOYVIMxo=
X-Received: by 2002:a05:6402:a2cb:10b0:6af:7a5a:97e4 with SMTP id
 4fb4d7f45d1cf-6afaf6bf03amr34523a12.12.1791138257648; Sun, 04 Oct 2026
 11:24:17 -0700 (PDT)
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
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-20-a1f052500fd7@kernel.org>
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-20-a1f052500fd7@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 4 Oct 2026 11:24:03 -0700
X-Gm-Features: AclHuK9H1gPgFkK4n-5s4Gd8NQjwfuvbGlNRYoPrM6gC5ICSAC1H3Sf5qTdT1bA
Message-ID: <CAJuCfpHOo8UhAZMvO5A3dKbqxQGAWtKGMHXJ+Fc=qwH=Nm0b6w@mail.gmail.com>
Subject: Re: [PATCH v4 20/38] mm/gup: error out early on !VMA_MAYREAD_BIT VMAs
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
> When populating a VMA range via the aptly named populate_vma_page_range()
> an unreadable VMA will always eventually fail with -EFAULT.
>
> That a VMA is accessible is always checked, however VMA_MAYREAD_BIT is no=
t.
>
> All user mappings always have VMA_MAYREAD_BIT set, so this check only
> impacts kernel mappings.
>
> It is implemented specifically to disallow population of uprobes XOL
> mappings which are exec-only.
>
> A nasty interaction with these mappings may occur if they are mlocked, so
> actively disallow this early.
>
> This allows a subsequent commit to remove the VM_IO check in
> __mm_populate() which otherwise requires non-MMIO mappings to be wrongly
> flagged simply as a workaround.
>
> Acked-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>


> ---
>  mm/gup.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/mm/gup.c b/mm/gup.c
> index c2dfcb4744bc..e6310a7cc05b 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1836,6 +1836,10 @@ long populate_vma_page_range(struct vm_area_struct=
 *vma,
>         if (!vma_is_accessible(vma))
>                 return -EFAULT;
>
> +       /* Unreadable VMAs also cannot be faulted in. */
> +       if (!vma_test(vma, VMA_MAYREAD_BIT))
> +               return -EFAULT;
> +
>         gup_flags =3D FOLL_TOUCH;
>         /*
>          * We want to touch writable mappings with a write fault in order
>
> --
> 2.55.0
>

