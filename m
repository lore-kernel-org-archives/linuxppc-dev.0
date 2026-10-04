Return-Path: <linuxppc-dev+bounces-28881-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C726CA5FF0
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Oct 2026 17:11:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hyTZZ3Xpcz30RN;
	Mon, 05 Oct 2026 04:11:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::829" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791133894;
	cv=pass; b=E9LwL1AUA+gvqr50fgD1KElxHGgROUQ8fU0F82D0DhUGSwZB3+kai/SSG0uF0abv3upaCjdEmafQDdveAV6VtBCmQGYJSLrO6yhjWlhMijd1QAt48OZ9i6c5LXyJYtPQqeGtcwBLlN+XyZ8UHhgoGdWRT6XpdSewlzD0uuSIwl8axikHxx2g5G75kmTUzmbZTS7ogMtAzBh1/hMObo1MwL9PnWBbTcO7eZSL2OhM/k+2w7HUxeeOssvO6o2hyagv72WdldDyxWAadYY9YJ5dWCb/cZ8UOrHZnOdIGH2trQ8jSIubdrxT7alDpl0dZ3WkbAxc4wxDTOKzXVp7e+Y+pA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791133894; c=relaxed/relaxed;
	bh=bmSj2pbz19jJ0+zzNzWqBxyg3RuudMi16XrC71b61r4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PuNr8himTP/mDj4tHsg8zb1iLUH/FjOjBCgqyKCIHduCa0bCE08xSowWt3KrX/6B3qCqLrd2NXgEjA3O9AccvTOcJIywn18vQOzzWDvZ3aDP0jRVT1mYrrmwgdA34Wbg51IQpRc4Uri69+/2OY5kQiRWGfrbFnQMK18qxNOD/ss7w4XbKxpMvWqwxnuanivFHYmKa7Zkxf5fZtoV0tl2Ghd9Z0e3F9982+fZsqxD9B/1Gh9StUrNEUUqfL8/EmOyi2pXw+uHxCayXkIu42xm4VUdTTPQX7huH7gYE1GuEsGMt6dCE6mJeR7/eriyT5SL8v8QAOcN7mtz9UWQQpY/Mw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Z9E299JE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::829; helo=mail-qt1-x829.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Z9E299JE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::829; helo=mail-qt1-x829.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hyTZY2PHLz2yYd
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2026 04:11:33 +1100 (AEDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-5337c7b9937so257841cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Oct 2026 10:11:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791133891; cv=none;
        d=google.com; s=arc-20260327;
        b=LVYF1rZrcpp7S5ynS1cbNXJGZpuubE5KyxdpAqteW2oVSr+jo6Y7J4z9pOYLeYLdCt
         II1iI5GyL4PnCtawus6NReUA6HHnEQeYZ1wY2opV1vGJPJ9rFEAkr3XRDABk7iYDce8p
         lIdoOHj8t3Zo0kWzPl/Tr9Ao5y+jWEIhtEVZwqv1u1vh14DFB0tvJsk+CLNy3bJzFdtQ
         B7TqJs5gU3s/EYuMOXDKRBDdCm3zDmcY22F9TPa+sj9U9uN28hbQfNDr6qtOfF8ezsU9
         HdSxOvahi2M137i8/yN1MJAwJo0lFSH0TmBar1P2rRiSMQuKo8c61cubKSnobJpd2D8v
         Akrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bmSj2pbz19jJ0+zzNzWqBxyg3RuudMi16XrC71b61r4=;
        fh=BK5TqJRU+EtyLAnambdSb8/omoCqCkHsXK7AsziLyNs=;
        b=HH3Ngh4S2m3HBvJhWlamhzT/YwanyFVYCz7VEKBFtjXa0EfcvufStpHAYohwsxvPjS
         JekzcQpOkvBxDz4OVI+9YAc7MJf296Dd6yLvDZoncaUEaDcOSlngX66XPNNzRyhyO4nr
         L2dlrUNxeGvdDNDIGirxWbmodFQao8T/zp/8RKM8kJzY8KmqJTLCxYtdu6ukEDcRdJhc
         aK66zhrzjxUBzEURuPWLPswCVau3QVJqvPfsxto9uK5FIRJoOslFGBR7allS4E5bguXd
         3VgF7VfLBS5+z2rMMauP8GuKj7p+UO94t4L7C3rIHUkWbp1OKm7+3Oa0BGzNPb/gk1Aj
         PLRQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791133891; x=1791738691; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bmSj2pbz19jJ0+zzNzWqBxyg3RuudMi16XrC71b61r4=;
        b=Z9E299JEjSSfx10jK31D0uHGcLXj7WNHlITsBL1w86diSqkC5T60jnrfVoqsF8lYpN
         sa1qVXy2DAxHq0H43RhyOTisUb7M9svsrGWpTznh5vwcE/4HPNKwyL1F0HoIsixlZJSa
         QpQq1pgdX5BLjYN9+rjHb7rnDglQQWPS3o0mEADoGGatQkhGjcB/9H7yDixcPN5Lydh+
         olxiUoj4BpBheMvbWkuDRxVh+kJfzAsVc+04OIqBNJM5H09RrWqsZfDStqD1ma7nZCME
         0cMTEJc/ZA1rZHvW7NzttNbQSCgjJysp+85lZL9T1c3P/jrB0cN/XYjz2C7yjS9F1i8g
         ZHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791133891; x=1791738691;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bmSj2pbz19jJ0+zzNzWqBxyg3RuudMi16XrC71b61r4=;
        b=CNaybkhBi2pX6pEAf8b9OlgBOY7nIbE+MZA8hRd0HcxsEnKUZYE7bHvwHJwXuVXCE2
         Gq01q7Q1wctfdY3ebA67rJvPbFoanpf/bdbxJK/+4DgF4A8SHdzEk7ZHntK5FQ3j2sBo
         imQ02UVQhpdTgBQiDNcaO1gVCmZsqjfRTHtbj1E819bWXKrMDwIXphNdjWqTEHLq/KmU
         yU4vjrzIIM4udUyL+ebeM0j8No6C4NCuN4T2q+ZGpeW865xnK6iMaXXtYabtj9KYHhGA
         pCirFu8vlqeB9WulIgiGbSg/L6QwR6Sk503O5p2amD3y0DVS8Wo2zbrDnsprjpyiquLx
         sySA==
X-Forwarded-Encrypted: i=1; AKwUvBybo+SnyI1N/ZUCQuRcUp6LvyEgBYaMVihKYHff+AFrE76yoZbG+rWV5Nt6u4U+y9VQgO5OVSx1TaoxJH0=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nx50NEcO2r9COXNqYTEQ/QchPKF56kexKHox/U4Xi2M6mP64NM
	bnZx1HFxcfwv6LPSEzqNDCZYnqn84G0EjXTSfsy1tKvRZ8s+zDNfzJv1s8ssCOia4KgQk/kvlAj
	8SHSStcU6VyhGo+5Q7H6FDxxjmkjuPX+tJ2HbXf1y
X-Gm-Gg: AYBFou3cYjH7YJmZlbGHsiiULQGUVT+rWYKKW//u7aQOpkIbGXjTsUd+eGW9fe7AlXh
	XI1NX21vycURwsm2OwBY0Oncj/SAjlZC/zmEIRkhA1ARc2YtH0+Sunwat72gwc1HNk3Vq9NDlfj
	3wNhdNBVEUVU527eZsxaqtVzQaiqkX6eK7rr25sKzKzILCNzanP5V5//zRaQ8PCUSUMOvu44uCH
	zZUA4q1pMpl1cPVAdGAwPnVyRee+jgqug1FLKXqaRsqykDC82dMTpjIroTKUH7sKn4UGoNPovEa
	r8hkgKMcK/6bqhaouhzc0vwO5PC8LXNst5ywI+HrQBA/oIdhx/7UMWh9
X-Received: by 2002:ac8:574c:0:b0:531:475:4ce6 with SMTP id
 d75a77b69052e-535131b2b85mr16300781cf.9.1791133889758; Sun, 04 Oct 2026
 10:11:29 -0700 (PDT)
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
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-7-a1f052500fd7@kernel.org>
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-7-a1f052500fd7@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 4 Oct 2026 10:11:18 -0700
X-Gm-Features: AclHuK9_GrY2ggXkofswaxZKaaBMuFyw-E-IUlNaS-y9tUhYDwF4p-ziZRKm4Dc
Message-ID: <CAJuCfpGj2Q092+zB=Z-d1iAOD6n1_HXVZQAL+YM6x_CeUEMpcw@mail.gmail.com>
Subject: Re: [PATCH v4 07/38] mm: add mmap action for discontiguous kernel
 page mapping
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

On Sat, Oct 3, 2026 at 6:35=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> The existing kernel page mapping mmap actions allow for partial and full
> mapping of an array of struct page pointers.
>
> However some drivers require the mapping of discontiguous ranges. Permit
> this by providing discontig_kernel_page_ops which allows a driver to
> specify how the operation should begin and how batches of pages should be
> retrieved.
>
> It uses the minimum exposed interface to do so, providing address, page
> offset and both vm_private_data state and a local private state object.
>
> ops->init can establish state for the operation, and ops->get outputs the
> pages to map and their count. Should an error arise the core unmaps the
> VMA, invoking vm_ops->close, which is therefore where any state establish=
ed
> by ops->init is released.
>
> Also update the compatibility layer to do this too via
> compat_mmap_action_abort().
>
> Batches may not exceed the VMA, but may map less than its full range in
> case the driver wishes to allow the user to map an area larger than the
> available data.
>
> To use it, users invoke mmap_action_map_discontig_kernel_pages() with
> initial local private state and a set of operations.
>
> Users can then use one of the provided helper functions to perform an
> action:
>
> * discontig_kernel_map_abort() - Abort and leave the mapping as it has
>   been accumulated so far.
> * discontig_kernel_map_page() - Map a single page, or a compound page giv=
en
>   its head page.
> * discontig_kernel_map_page_range() - Maps a struct page ** array of a
>   specified count, mapping only those pages which fit in the VMA.
>
> The userland VMA tests are updated accordingly.
>
> Acked-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  include/linux/mm.h              |  45 +++++++++++++++++
>  include/linux/mm_types.h        |  44 +++++++++++++++-
>  mm/internal.h                   |   3 ++
>  mm/memory.c                     | 108 ++++++++++++++++++++++++++++++++++=
++++--
>  mm/util.c                       |  27 ++++++++--
>  tools/testing/vma/include/dup.h |  11 +++-
>  6 files changed, 224 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a1f2d375cf7d..97e1eb4fe3a4 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4647,10 +4647,55 @@ static inline void mmap_action_map_kernel_pages_f=
ull(struct vm_area_desc *desc,
>                                      vma_desc_pages(desc));
>  }
>
> +static inline
> +void mmap_action_map_discontig_kernel_pages(struct vm_area_desc *desc,
> +               void *init_private, const struct discontig_kernel_page_op=
s *ops)
> +{
> +       struct mmap_action *action =3D &desc->action;
> +
> +       action->type =3D MMAP_DISCONTIG_KERNEL_PAGES;
> +       action->map_kernel_discontig.init_private =3D init_private;
> +       action->map_kernel_discontig.ops =3D ops;
> +}
> +
>  int mmap_action_prepare(struct vm_area_desc *desc);
>  int mmap_action_complete(struct vm_area_struct *vma,
>                          struct mmap_action *action, bool is_compat);
>
> +static inline void
> +discontig_kernel_map_abort(struct discontig_kernel_page_state *state)
> +{
> +       state->action =3D DISCONTIG_KERNEL_PAGE_ABORT;
> +}
> +
> +static inline void
> +discontig_kernel_map_page(struct discontig_kernel_page_state *state,
> +                         struct page *page)
> +{
> +       struct folio *folio =3D page_folio(page);
> +
> +       if (folio_test_large(folio)) {
> +               VM_WARN_ON_ONCE(page !=3D folio_page(folio, 0));
> +               state->action =3D DISCONTIG_KERNEL_PAGE_MAP_COMPOUND_PAGE=
;
> +               state->__folio =3D folio;
> +               state->__nr_pages =3D min(state->nr_pages_remain,
> +                                       folio_nr_pages(folio));
> +       } else {
> +               state->action =3D DISCONTIG_KERNEL_PAGE_MAP_PAGE;
> +               state->__page =3D page;
> +               state->__nr_pages =3D 1;
> +       }
> +}
> +
> +static inline void
> +discontig_kernel_map_page_range(struct discontig_kernel_page_state *stat=
e,
> +                               struct page **page_arr, unsigned long nr_=
pages)
> +{
> +       state->action =3D DISCONTIG_KERNEL_PAGE_MAP_PAGE_RANGE;
> +       state->__page_arr =3D page_arr;
> +       state->__nr_pages =3D min(nr_pages, state->nr_pages_remain);
> +}
> +
>  /* Look up the first VMA which exactly match the interval vm_start ... v=
m_end */
>  static inline struct vm_area_struct *find_exact_vma(struct mm_struct *mm=
,
>                                 unsigned long vm_start, unsigned long vm_=
end)
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 9ca2ea3664bc..0cb4f9603956 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -818,8 +818,44 @@ enum mmap_action_type {
>         MMAP_NOTHING,
>         MMAP_REMAP_PFN,
>         MMAP_IO_REMAP_PFN,
> -       MMAP_SIMPLE_IO_REMAP,   /* I/O remap with guardrails. */
> -       MMAP_KERNEL_PAGES,      /* Map kernel page range from array. */
> +       MMAP_SIMPLE_IO_REMAP,           /* I/O remap with guardrails. */
> +       MMAP_KERNEL_PAGES,              /* Map kernel page range from arr=
ay. */
> +       MMAP_DISCONTIG_KERNEL_PAGES,    /* Map kernel discontig page rang=
e. */
> +};
> +
> +enum discontig_kernel_page_action {
> +       DISCONTIG_KERNEL_PAGE_ABORT,
> +       DISCONTIG_KERNEL_PAGE_MAP_PAGE,
> +       DISCONTIG_KERNEL_PAGE_MAP_COMPOUND_PAGE,
> +       DISCONTIG_KERNEL_PAGE_MAP_PAGE_RANGE,
> +};
> +
> +struct discontig_kernel_page_state {
> +       /* Map state. */
> +       const unsigned long start;      /* Start address of VMA. */
> +       const unsigned long end;        /* End address of VMA. */
> +       unsigned long addr;             /* The current address to be mapp=
ed. */
> +       pgoff_t pgoff;                  /* The current pgoff to be mapped=
. */
> +       unsigned long nr_pages_mapped;  /* The number of pages mapped. */
> +       unsigned long nr_pages_remain;  /* The number of pages remaining.=
 */
> +
> +       /* User-defined state. */
> +       void *vm_private_data;          /* VMA private data. */
> +       void *private;                  /* Mapping private data. */
> +
> +       /* Users should not touch these, use discontig_kernel_map_*() hel=
pers. */
> +       enum discontig_kernel_page_action action;
> +       union {
> +               struct page *__page;
> +               struct folio *__folio;
> +               struct page **__page_arr;
> +       };
> +       unsigned long __nr_pages;
> +};
> +
> +struct discontig_kernel_page_ops {
> +       int (*init)(void *vm_private_data, void **private);
> +       int (*get)(struct discontig_kernel_page_state *state);
>  };
>
>  /*
> @@ -844,6 +880,10 @@ struct mmap_action {
>                         unsigned long nr_pages;
>                         pgoff_t pgoff;
>                 } map_kernel;
> +               struct {
> +                       void *init_private;
> +                       const struct discontig_kernel_page_ops *ops;
> +               } map_kernel_discontig;
>         };
>         enum mmap_action_type type;
>
> diff --git a/mm/internal.h b/mm/internal.h
> index fc4e249e2343..557e629db8c5 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1515,6 +1515,9 @@ int simple_ioremap_prepare(struct vm_area_desc *des=
c);
>  int map_kernel_pages_prepare(struct vm_area_desc *desc);
>  int map_kernel_pages_complete(struct vm_area_struct *vma,
>                               struct mmap_action *action);
> +int map_discontig_kernel_pages_prepare(struct vm_area_desc *desc);
> +int map_discontig_kernel_pages_complete(struct vm_area_struct *vma,
> +                                       struct mmap_action *action);
>
>  static inline int io_remap_pfn_range_prepare(struct vm_area_desc *desc)
>  {
> diff --git a/mm/memory.c b/mm/memory.c
> index 448342883e9d..45b21bb04a18 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2609,17 +2609,23 @@ int vm_insert_pages(struct vm_area_struct *vma, u=
nsigned long addr,
>  }
>  EXPORT_SYMBOL(vm_insert_pages);
>
> +static void __map_kernel_pages_prepare(struct vm_area_desc *desc)
> +{
> +       if (vma_desc_test(desc, VMA_MIXEDMAP_BIT))
> +               return;
> +
> +       VM_WARN_ON_ONCE(mmap_read_trylock(desc->mm));

Sorry I missed this before and it is pre-existing code but is this a
weird way of asserting that mmap_lock is write-locked? If so, why not
just use mmap_assert_write_locked()?



> +       VM_WARN_ON_ONCE(vma_desc_test(desc, VMA_PFNMAP_BIT));
> +       vma_desc_set_flags(desc, VMA_MIXEDMAP_BIT);
> +}
> +
>  int map_kernel_pages_prepare(struct vm_area_desc *desc)
>  {
>         const struct mmap_action *action =3D &desc->action;
>         const unsigned long addr =3D action->map_kernel.start;
>         unsigned long nr_pages, end;
>
> -       if (!vma_desc_test(desc, VMA_MIXEDMAP_BIT)) {
> -               VM_WARN_ON_ONCE(mmap_read_trylock(desc->mm));
> -               VM_WARN_ON_ONCE(vma_desc_test(desc, VMA_PFNMAP_BIT));
> -               vma_desc_set_flags(desc, VMA_MIXEDMAP_BIT);
> -       }
> +       __map_kernel_pages_prepare(desc);
>
>         nr_pages =3D action->map_kernel.nr_pages;
>         end =3D addr + PAGE_SIZE * nr_pages;
> @@ -2640,6 +2646,98 @@ int map_kernel_pages_complete(struct vm_area_struc=
t *vma,
>                             &nr_pages, vma->vm_page_prot);
>  }
>
> +int map_discontig_kernel_pages_prepare(struct vm_area_desc *desc)
> +{
> +       const struct mmap_action *action =3D &desc->action;
> +       const struct discontig_kernel_page_ops *ops =3D
> +               action->map_kernel_discontig.ops;
> +
> +       /* At minimum need to be able to get pages. */
> +       if (WARN_ON_ONCE(!ops || !ops->get))
> +               return -EINVAL;
> +
> +       __map_kernel_pages_prepare(desc);
> +       return 0;
> +}
> +
> +static int apply_discontig_action(struct vm_area_struct *vma,
> +                                 struct discontig_kernel_page_state *sta=
te)
> +{
> +       unsigned long nr_pages =3D state->__nr_pages;
> +       unsigned long addr =3D state->addr;
> +       unsigned long i;
> +
> +       if (state->action =3D=3D DISCONTIG_KERNEL_PAGE_MAP_PAGE)
> +               return insert_page(vma, addr, state->__page,
> +                                  vma->vm_page_prot, /*mkwrite=3D*/false=
);
> +       if (state->action =3D=3D DISCONTIG_KERNEL_PAGE_MAP_PAGE_RANGE)
> +               return insert_pages(vma, addr, state->__page_arr,
> +                                   &nr_pages, vma->vm_page_prot);
> +
> +       /* Compound folio - have to iterate through each page. */
> +       for (i =3D 0; i < nr_pages; i++, addr +=3D PAGE_SIZE) {
> +               struct page *page =3D folio_page(state->__folio, i);
> +               int err;
> +
> +               err =3D insert_page(vma, addr, page, vma->vm_page_prot,
> +                                 /*mkwrite=3D*/false);
> +               if (err)
> +                       return err;
> +       }
> +       return 0;
> +}
> +
> +int map_discontig_kernel_pages_complete(struct vm_area_struct *vma,
> +                                       struct mmap_action *action)
> +{
> +       const struct discontig_kernel_page_ops *ops =3D
> +               action->map_kernel_discontig.ops;
> +       struct discontig_kernel_page_state state =3D {
> +               .start =3D vma->vm_start,
> +               .end =3D vma->vm_end,
> +               .addr =3D vma->vm_start,
> +               .pgoff =3D vma->vm_pgoff,
> +               .nr_pages_mapped =3D 0,
> +               .nr_pages_remain =3D vma_pages(vma),
> +               .vm_private_data =3D vma->vm_private_data,
> +               .private =3D action->map_kernel_discontig.init_private,
> +       };
> +       int err =3D 0;
> +
> +       if (ops->init)
> +               err =3D ops->init(vma->vm_private_data, &state.private);
> +       if (err)
> +               return err;
> +
> +       do {
> +               unsigned long end, pgoff_end;
> +               unsigned long nr_pages;
> +
> +               /* Default to abort. */
> +               state.action =3D DISCONTIG_KERNEL_PAGE_ABORT;
> +               err =3D ops->get(&state);
> +               if (err || state.action =3D=3D DISCONTIG_KERNEL_PAGE_ABOR=
T)
> +                       return err;
> +               nr_pages =3D state.__nr_pages;
> +
> +               if (!nr_pages || nr_pages > state.nr_pages_remain)
> +                       return -EINVAL;
> +               end =3D state.addr + PAGE_SIZE * nr_pages;
> +               pgoff_end =3D state.pgoff + nr_pages;
> +
> +               err =3D apply_discontig_action(vma, &state);
> +               if (err)
> +                       return err;
> +
> +               state.addr =3D end;
> +               state.pgoff =3D pgoff_end;
> +               state.nr_pages_mapped +=3D nr_pages;
> +               state.nr_pages_remain -=3D nr_pages;
> +       } while (state.addr < vma->vm_end);
> +
> +       return 0;
> +}
> +
>  /**
>   * vm_insert_page - insert single page into user vma
>   * @vma: user vma to map to
> diff --git a/mm/util.c b/mm/util.c
> index 1660910e2a22..5b2e1ab4aeba 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -1401,6 +1401,15 @@ static int call_vma_mapped(struct vm_area_struct *=
vma)
>         return 0;
>  }
>
> +/* An mmap action failed under the compatibility layer - unmap and close=
. */
> +static void compat_mmap_action_abort(struct vm_area_struct *vma)
> +{
> +#ifdef CONFIG_MMU
> +       zap_vma_range(vma, vma->vm_start, vma_pages(vma) << PAGE_SHIFT);
> +#endif
> +       vma_close(vma);
> +}
> +
>  static int mmap_action_finish(struct vm_area_struct *vma,
>                               struct mmap_action *action, int err,
>                               bool is_compat)
> @@ -1412,12 +1421,13 @@ static int mmap_action_finish(struct vm_area_stru=
ct *vma,
>
>         /* do_munmap() might take rmap lock, so release if held. */
>         maybe_rmap_unlock_action(vma, action);
> -       /*
> -        * If this is invoked from the compatibility layer, post-mmap() h=
ook
> -        * logic will handle cleanup for us.
> -        */
> -       if (!err || is_compat)
> +       if (!err)
> +               return 0;
> +
> +       if (is_compat) {
> +               compat_mmap_action_abort(vma);
>                 return err;
> +       }
>
>         /*
>          * If an error occurs, unmap the VMA altogether and return an err=
or. We
> @@ -1469,6 +1479,8 @@ int mmap_action_prepare(struct vm_area_desc *desc)
>                 return simple_ioremap_prepare(desc);
>         case MMAP_KERNEL_PAGES:
>                 return map_kernel_pages_prepare(desc);
> +       case MMAP_DISCONTIG_KERNEL_PAGES:
> +               return map_discontig_kernel_pages_prepare(desc);
>         }
>
>         WARN_ON_ONCE(1);
> @@ -1501,6 +1513,9 @@ int mmap_action_complete(struct vm_area_struct *vma=
,
>         case MMAP_KERNEL_PAGES:
>                 err =3D map_kernel_pages_complete(vma, action);
>                 break;
> +       case MMAP_DISCONTIG_KERNEL_PAGES:
> +               err =3D map_discontig_kernel_pages_complete(vma, action);
> +               break;
>         case MMAP_IO_REMAP_PFN:
>         case MMAP_SIMPLE_IO_REMAP:
>                 /* Should have been delegated. */
> @@ -1522,6 +1537,7 @@ int mmap_action_prepare(struct vm_area_desc *desc)
>         case MMAP_IO_REMAP_PFN:
>         case MMAP_SIMPLE_IO_REMAP:
>         case MMAP_KERNEL_PAGES:
> +       case MMAP_DISCONTIG_KERNEL_PAGES:
>                 WARN_ON_ONCE(1); /* nommu cannot handle these. */
>                 break;
>         }
> @@ -1543,6 +1559,7 @@ int mmap_action_complete(struct vm_area_struct *vma=
,
>         case MMAP_IO_REMAP_PFN:
>         case MMAP_SIMPLE_IO_REMAP:
>         case MMAP_KERNEL_PAGES:
> +       case MMAP_DISCONTIG_KERNEL_PAGES:
>                 WARN_ON_ONCE(1); /* nommu cannot handle this. */
>
>                 err =3D -EINVAL;
> diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/=
dup.h
> index 023ad6092e9c..a6a8e53c4b38 100644
> --- a/tools/testing/vma/include/dup.h
> +++ b/tools/testing/vma/include/dup.h
> @@ -457,14 +457,17 @@ enum mmap_action_type {
>         MMAP_NOTHING,
>         MMAP_REMAP_PFN,
>         MMAP_IO_REMAP_PFN,
> -       MMAP_SIMPLE_IO_REMAP,   /* I/O remap with guardrails. */
> -       MMAP_KERNEL_PAGES,      /* Map kernel page range from array. */
> +       MMAP_SIMPLE_IO_REMAP,           /* I/O remap with guardrails. */
> +       MMAP_KERNEL_PAGES,              /* Map kernel page range from arr=
ay. */
> +       MMAP_DISCONTIG_KERNEL_PAGES,    /* Map kernel discontig page rang=
e. */
>  };
>
>  /*
>   * Describes an action an mmap_prepare hook can instruct to be taken to =
complete
>   * the mapping of a VMA. Specified in vm_area_desc.
>   */
> +struct discontig_kernel_page_ops;
> +
>  struct mmap_action {
>         union {
>                 struct {
> @@ -483,6 +486,10 @@ struct mmap_action {
>                         unsigned long nr_pages;
>                         pgoff_t pgoff;
>                 } map_kernel;
> +               struct {
> +                       void *init_private;
> +                       const struct discontig_kernel_page_ops *ops;
> +               } map_kernel_discontig;
>         };
>         enum mmap_action_type type;
>
>
> --
> 2.55.0
>

