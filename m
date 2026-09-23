Return-Path: <linuxppc-dev+bounces-28037-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1345C98304
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 15:33:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqgvw2pQ6z2xs1;
	Thu, 24 Sep 2026 01:33:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::82d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790177580;
	cv=pass; b=ZN88vjm79Qrm0m/B9YpZwiiRGx7gjfxMnYPAJ0O1Tjm/AI8jrDk0Di0L8zzlrZIqV7RjulH5/d/GfbcfLaYJIE+51cG26LFHD5JtftI2gQn8MGTSLPsMWdOodaruiv2tbQvQGUWed6CJP8L+29dhmDwEyyNhy5MrRh4qbgNYI64ung5220df89gL9cW6cMzVnaH41L/x78mpkT1mB8yW3Q7JyflpT9fSEb8HG/TnZAzkIDn0+LTvimovSicHhEn5kfUUnx0/GfYmy0s2yycJ0HohroUbT4B9E7j7ktoBiYq4J5AVLxENi7tFOL4/2bkOoWiCfYNFtYj8Dz/21UOAIA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790177580; c=relaxed/relaxed;
	bh=hKtcWNVFda3wl86zaKIN0hpMLzWuZcmeXVfEC0xSzRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wy079aHdrfKv8A+r38Q3s6rtuZ7qWBwJHZ5OF2ehhwvYuMYvyRiNZeJgqNXSNvsG2tDaz1mbSDFdEUINtO2UEnppqa1PPw4/TthYACXCHlgq9bTmSyf8Ky3oPOUg5NxPouuRWffSySUmydZTl4PMPOuNsjlYysVo4VNcpD0M20lP52smiM0XkDf3w0XFB0kEV1M47Uut9HaNAkMUJgGBDpNNjnKhU1pDeKegSsEUPd4qVkS9/HO/NFJE4JqvbisqQ1e0wKryVUe0Dw1gGg2ftVAgfB1dGRYdrie7mlibZYTPku1wrrJTrBDJ9g5xXXF7GBNT/4HoqpUgXBVax2RDug==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=HPcn+57Z; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82d; helo=mail-qt1-x82d.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=HPcn+57Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::82d; helo=mail-qt1-x82d.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqgvt67y2z2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 01:32:58 +1000 (AEST)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-52faa58bff5so263861cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 08:32:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790177576; cv=none;
        d=google.com; s=arc-20260327;
        b=kR22f2WDi6rGrixmVnavPHdUXMOlO50JFBL6hIhcClAFwmF25899Xx9+Ks/c1Vpb3z
         OB0b1TnUHw8JLuWh7gJFd9ddZV4x/4dJJV7PMzNYfxMyHlpBypc2SnwyyvSwdJj1J08Q
         XW5pRDEpR0h+Bk86hBe7wB7Q1+BBOSuekaMEC4tFoS3Yby0oK9Btq9BTM7Y9emXtJk5w
         Q9v69zT1EVnuJnwWp6Z47WO6izU+ho/ueI696YBpWgRYS+TVYuqgSpDVhKDVvk8+pUw5
         7J/ds54Lyy6Nkztr6rn4mPn3f6EdQahscSAIXlnFCkHeMyK7pr5wky5UI25UG7JL8Dfi
         ETXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hKtcWNVFda3wl86zaKIN0hpMLzWuZcmeXVfEC0xSzRI=;
        fh=EjOnHjCDamAJgxXa6PbqLeYiJd/UwYqFfahZFjeBEwM=;
        b=JyeXV63hbziY1wmMVWeY/3UHAnw55bS7qqOYhARhYCmFfvh9sKH9dLVFMwj9/GXq3T
         Vf1ykpGQTGtC65OwsdgEbVnMMq77yc4zBr6xyZu8mQ2Ym6Uvst8COVch1W1JoHIPIKqA
         GFNoaCUQuCnIaO8LDQpOenxk55IZGKhKWHBbYQBrYLIpCWJUYX9Zcnw52B1k9uwMl42t
         kDANPKsVnkSjdnIlnKKXwsT5j3VVk2acgoiZ88MuaVQA3lODiiZZfyDK3CdreXNh9IR/
         efnJfD6FzUbWpRrVLe3SLtIGlkK5QbQ4Av+sG3GRfrw/7EeJ0c+x92FD0vP3jftdpEMu
         md/A==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790177576; x=1790782376; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hKtcWNVFda3wl86zaKIN0hpMLzWuZcmeXVfEC0xSzRI=;
        b=HPcn+57ZLAAVNhs3whaIiKAmLotajmeipbB4kMEjaKKtb63dHtVjWa7EGqFslvCK8F
         uzOaO/JXH8lO3K+xZsgC+YnNOF85+yKbwIrqsnLVOV594Ii5kwO7hA4LDiv0MbhDteU7
         xh/RAzED46ziwHcoGlwrFhjqxXLfG0GkSbn4CO33fZu5hhBIiTpTQJxpn13/m1SU0ryV
         BwiatLb/FglfKsvDs0TSukiUCTR9GAYAZliGxKRF+K+/0WNdEJmvcUthNNr2HFhZrott
         UdiyDVDQ3vg6ryl7KUPEEJGYymtggNPD45ZvVHbjAZp7h2P469o3DrnY5E17oQXjXsX5
         VwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790177576; x=1790782376;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hKtcWNVFda3wl86zaKIN0hpMLzWuZcmeXVfEC0xSzRI=;
        b=EsnP4NHSOq/h05xDAMDlncZI6dAJwUhwGOogwKzKIx8RrNS7Nc+JoduUlRMpu3pHOX
         MVZG+GwBzjImvq7dUgLjYnnIjU8cJNNalOXy+nO88yW7NKZbXIU1fBCNYYCb5LywAw4H
         i34FIKnpIHCQA2SWDgZ2AmGOaR4Q2oBE39cni8wre11O+48pgZgOpo/smN1//ZwDzwkB
         2yTHNltIlCfPX00bGbcrZT86xPerF0PaqULltCc7cA7Eb7xHAR9hSsFVCKDVjXCFMdG8
         FLquYkJrGZ2WF0JsUyKbtWABifBeGkNpZNCKDYLDPx6cfjWawHN1ZIwuH50xY3SBJt0r
         /TIw==
X-Forwarded-Encrypted: i=1; AKwUvBy0T0Hxc+VDJ0ogCKZ/YmNiRoQ6jD7bzPkF/bAPOlcb4KgNG3jS7jgA10dY8yEPC/1DzbQvnNSTo8BoksM=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nI+jZFopIfBO99rWSZyrSaSy+Cv4kvO6flyBPvMd2e/mIW3CWf
	0FEK8Ja609zm0od5adjVq4OVwK7Hzb2FUtNny/1A8VC/dLZmOW1KGCBQXTLuK/uIG3ptWoirlLG
	XIOJXA63gJnbS7IHAVKZTOjs3w3pTTfxlJgeMMT2E
X-Gm-Gg: AYBFou0BKWe4KXHRL+pzuVLiHcmkOxFXIv4Rs4a5J08PMswigpmHuWoaWT5bwPS22Sk
	MVxje8+AAzVsR8OtNS08e4fNY1S7C3QFsYBaz9xpTWsxBRmaPli88lZe9CU/0R+qVJMUmNrND4p
	xNpbII46+B40R4UZfOpS8Yj8NvEGT901ZeD6xf1iz5iSD1NuBNsfYQIN9eQ24q1YyNnjKuIFvD6
	TCZW21W+dODcg46YWxq4dpIqwIeVsiIY67lSVj4KDYTa6UMgYGIX6Pmdd9AoMCk6+MLL7rUiF7p
	kqoULeVOgIDkpct5WnuBIZ0t9FooTLoHfkNd48v7/rRsys9KS93KEMrA3YM+aguCrMe+xksv+Oo
	xHljrnDnzZg==
X-Received: by 2002:ac8:5f13:0:b0:532:8423:1e78 with SMTP id
 d75a77b69052e-532f8eef5afmr573491cf.10.1790177574693; Wed, 23 Sep 2026
 08:32:54 -0700 (PDT)
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
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-2-4583d8a23bca@kernel.org>
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-2-4583d8a23bca@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 23 Sep 2026 08:32:43 -0700
X-Gm-Features: AclHuK8Inh8u6lJouEWaJf_8_dOxdEc__Ja8ROlufrRS70N8N3MQ9iMsAEM4G5I
Message-ID: <CAJuCfpEa8tUmYJBjx-cRdAE8y-jcKY0C81kAOa1QZS7F6tKdfQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/40] mm/vma: predicate setting mmap_prepare VMA
 fields on new vma alloc
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
	"Martin K. Petersen" <mkp@kernel.org>, Jaya Kumar <jayalk@intworks.biz>, Simona Vetter <simona@ffwll.ch>, 
	Helge Deller <deller@gmx.de>, Sebastian Reichel <sre@kernel.org>, John Hubbard <jhubbard@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
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

On Thu, Sep 17, 2026 at 9:24=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> It only makes sense to manipulate VMA fields if we allocated a new VMA,
> rather than merged it.
>
> VMA merging does not compare vm_ops or vm_private_data, so a merged VMA
> keeps its own, which is also what the legacy f_op->mmap path does since i=
t
> never touches an existing VMA. Previously set_vma_user_defined_fields()
> overwrote the merged VMA's fields with those set for the new mapping. In
> practice these are the same values, with rare exceptions such as shmem
> selecting vm_ops based on whether the file has been unlinked, so no
> user-visible change is expected.
>
> Make this dependency explicit, and additionally constify have_mmap_prepar=
e
> while we're here.

The fact that we might be overriding attributes of an existing VMA
that we merged with is technically a bug even if we never hit it,
right? If so, should we have:

Fixes: c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file callback")

>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/vma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/vma.c b/mm/vma.c
> index fa784f069da4..4b74b48c29b7 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -2894,7 +2894,7 @@ static unsigned long __mmap_region(struct file *fil=
e, unsigned long addr,
>  {
>         struct mm_struct *mm =3D current->mm;
>         struct vm_area_struct *vma =3D NULL;
> -       bool have_mmap_prepare =3D file && file->f_op->mmap_prepare;
> +       const bool have_mmap_prepare =3D file && file->f_op->mmap_prepare=
;
>         VMA_ITERATOR(vmi, mm, addr);
>         const pgoff_t anon_pgoff =3D addr >> PAGE_SHIFT;
>         MMAP_STATE(map, mm, &vmi, addr, len, pgoff, anon_pgoff, vma_flags=
, file);
> @@ -2937,7 +2937,7 @@ static unsigned long __mmap_region(struct file *fil=
e, unsigned long addr,
>                 allocated_new =3D true;
>         }
>
> -       if (have_mmap_prepare && !map_is_anon(&map))
> +       if (have_mmap_prepare && allocated_new && !map_is_anon(&map))
>                 set_vma_user_defined_fields(vma, &map);
>
>         __mmap_complete(&map, vma);
>
> --
> 2.55.0
>

