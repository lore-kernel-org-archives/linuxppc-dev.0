Return-Path: <linuxppc-dev+bounces-28887-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D47ACA5FF5
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Oct 2026 17:43:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hyVHX2jZDz2y2K;
	Mon, 05 Oct 2026 04:43:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::834" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791135816;
	cv=pass; b=LyFYJv+qsqcgFTa1+93mwZ0Mvbkcpge+FQHDIknbyTyT03JFIhg9HFjIGqK+OA8DCoRH7LXyyVY9Pt3gCOOkzL4CQ259TuFS9SqcO3iU6UO9T46eKUK53QyP+1BU0wzBynxrtcPHl57ta6KFj3xp8qZXm+qj21jDZXihAGJ4gpt4LLZhU2CH4NuOjgFGgRoRSjulSVb0oi94VI2cdFqYO8p2yHBxSx+0kKsNQRfuhk7jfF+3KmmyfLPTTJ13tXqUJhWIiAABtZN25h208lh4cOffK6mu7JIo0Ty25aaTOyMQEECEwbwz46uN2TiZOBq0Nc9EoYXd7rtZOGe0KFwCIQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791135816; c=relaxed/relaxed;
	bh=vMNQ59LV7QrrLF0PW8JXbsDZwLj1dza/KEaeRbY4SzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MEzfPvQYo4gmRETxQhAoq1cIrbdgFCwWU7rOc5eQBPbCI7lqFRmTMMWmNsqSCrdHrzkOvYwcEDIExkAziq0SC15xTJWcu1lPjXz1fNjIgIna+VHz1iS2wEnFnlZCE636U2gG2yrMtg4XLoo/Inr3TR3KTAkn8y58/eFFAIvCuoViGoe9SfqWpN9p3PvFIQWxVGaEIC12L028h8UxdLj5Gvgi8uMERhJdC4pPvID0PcdqWaH1pOtACYuB9yeDp18i1FRFQfH9TdtQCle7YgRvRCkNwMl/sCrA8Zlie9mzVLLTCTaSUqSlcG/c5CboCft2EDy1mmCtdGQ8/y61azGt3Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fK6Mt3vc; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::834; helo=mail-qt1-x834.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fK6Mt3vc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::834; helo=mail-qt1-x834.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hyVHV3bhJz2xSg
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2026 04:43:33 +1100 (AEDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-5351f9dbfe0so95731cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Oct 2026 10:43:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791135811; cv=none;
        d=google.com; s=arc-20260327;
        b=lOxGxq8Z3nl0h17J1RRjRVfw5r5vvpG3u+/18GW6OZaDhfgRXf9xf/PuqU+2quhOW/
         UY59H0ZHhYepFkDCEuF6WMalevO6sQQgDF/OHZ1qU3iMUvkvjHVPXGQ5rrQcjDIiZUkm
         FmQ7yuni6nwXsKK4D21xNnpRU9AeKEGw3LRzA/25z1v+B7kez2/5HsFza5suzB2ymFGT
         VC2y9l+jvzUbs+iAhsSILzZVYHn4POHV3tvgCW74xijA5YfMfk7iVjRpHEjHIyFGHp2E
         7USj2VgckFxU8IVsjvreV7qDGsu1eLgBIvwB/JdN4xYHnZNk8uQaOKfhaJoFPTOCyq6d
         gCgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vMNQ59LV7QrrLF0PW8JXbsDZwLj1dza/KEaeRbY4SzE=;
        fh=Yt8z04iDG0bkYvRNmPcF3YWOJ1cQLNsvHYr9nnGEi9I=;
        b=dWWcoM3oIIvjHrDSO7AWBOalTx97t5ldIT1+FvBAYCnDRQz0S5cAZq7pFjwXmTdwSl
         aEKSdSeaVJ+bW/zUIo18/Jr8G5jLqPX+kxQqkj8Ru+5vinGIiXz7BFCMEAbJA4WJL7zv
         0fJt9Xwl/SkCz7HzZYdk1b/uZYQSNp4EX/6mwUfTLe1hxE+Vb3+wiqkNlN1w8gIiMvD6
         4ylCsxQA1sNx5vHctAf8wR1ZuoBAcFc0QwUi/Qpi7OMxL1qxq49VadqsePGnhqY2FrVp
         T1MMYYv2pJYBUmf6YZjihMHwYSAZk0CuoDrL9Fqi7W4ARoVN2zkpPwKOZGSRRttMC4dP
         8Dag==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791135811; x=1791740611; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vMNQ59LV7QrrLF0PW8JXbsDZwLj1dza/KEaeRbY4SzE=;
        b=fK6Mt3vcMHqzY5hDFHUzokqIKOEpVRsumRalEnRnWeLbI0eVi7usS6Viv1oz17qMjl
         CYdrEZ4nCjOSTfdCEdyQW7oG+Mc5OjBvCwzg/eekW0t1KipDAdjFfKDXRHKS6e6u60SV
         BS7pXq/kDDz6Nm+6EUAf4P3qugKRQjSa1oISbNemBj97Kj+krhkrc6T/qBWTFjdr+Rr4
         RsMbgDrTJ+tlEbryHUrasiWCj5ahpEdnJi96+5Y0SjsrjPEInJ2IHMih6m2lgSAlWAbt
         lmsJhwyxpW38KAIGuv4vjszWmj5Dv34NYjs8Ln4rAU669A9bVbh+XJ0ptbKAItLBOAr4
         rqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791135811; x=1791740611;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vMNQ59LV7QrrLF0PW8JXbsDZwLj1dza/KEaeRbY4SzE=;
        b=kTGHlznI0JU4dEju+g1QEhkgnyUOeQgu+sZr0tqFx3iZVpFp+uxrF+JWAq9gn3xjA2
         hc2D82JiRtvHjfDltXL4sWBSCGL+O7cMlK3vG4aRqjISEIVNE71GHw7r85RXjGrQ/Wl5
         T32ZYxyuX7k1J/YhWTeJLhI3xwOeNCmvvC7d/6yrVvD7IE8bX+lIGnVSGrWuBFrOacUN
         GLUEIJ7q+bLkiRqdQnZDrZsP/jhsPHqS6+pLXzd9Wi6Dyar8YSwZOx9fPyh7OQwWCzHZ
         wsabOXiImV5L29W1ODzJVdf/ckicu16jtgNETVafGjFL2sQqywcWRiwMsA1xYdRtJE8U
         eVxg==
X-Forwarded-Encrypted: i=1; AKwUvBxG9Ye+4aUBM6GNcYZQY3txkRBw7otpoja28koOVez9qv0A1nRBvIGeJY75qjLTXTts4/bwL5o0NLJVv3Y=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mJxKejF7qula7H/FFGLyZ85Y2loHBtKtGLs39B5INFWig84Zbt
	zfdZ6NJoqzBCJokXW0N7mJW8hkXKw5Cnn5DnrLkl/mdFaDTjUyCob9eyYwVWogHbFjAd8my0O5y
	oQ8bqg69XOAGTDi09OQxiRCwxndBn45JyhOYogv1u
X-Gm-Gg: AYBFou3zxwpIVx0Zs+LXNJi54cTRQZopaQzrk12MoptYNOCWgLUPUMpaDmgYL9UYbYf
	3hlDxXPzTrDajF90evZuUewAOtouPl5lrEK7RtU0V73U6e13/d7YSsQpkctIrav1OeW9KqACVms
	D6VV+xzNf9P2tyeibv5LXEGagVD2T5g9fDmDgmCXpU8IU4x+QLmrtnylgvtLNAbW/NabDSMGFrB
	jJAHSUdDGAQPYAqjt/+LsENXbPdoSml9SO6eKdYcDCKmPglca8nv1nNPOWNR1xx/aRnLUJUjEYF
	+PlrjgMYA/WwBO4GcA6atc1HU8/Ev/dTULr1X1eDUIEa0m4FkRI49ord
X-Received: by 2002:a05:622a:5c09:b0:532:eff8:3491 with SMTP id
 d75a77b69052e-5351497bae9mr16844861cf.14.1791135809929; Sun, 04 Oct 2026
 10:43:29 -0700 (PDT)
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
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-14-a1f052500fd7@kernel.org>
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-14-a1f052500fd7@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 4 Oct 2026 10:43:17 -0700
X-Gm-Features: AclHuK-Z2ieyqrFQLh5f1D20FCqfsVRqEWMyJIzhNXdOxd9iUhJDwyyLAY8lrcs
Message-ID: <CAJuCfpFounkD97p9iJ8zUunAMoOv+h8Tnxf2NOkp7qs3cfqs7w@mail.gmail.com>
Subject: Re: [PATCH v4 14/38] mm/vma: add vma[_flags]_is_mm_managed() predicates
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

On Sat, Oct 3, 2026 at 6:38=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Rather than referring to VMA flags with uncertain meaning, add a new
> predicate that explicitly describes what absence of the VMA_PFNMAP_BIT an=
d
> VMA_MIXEDMAP_BIT flags means, and then refer to that function for
> determining VMA mergeability.
>
> If neither of these flags are set, that means the contents of the mapping
> are managed by core mm.
>
> Otherwise they are instead owned by some other kernel component, usually =
a
> driver: the memory may be MMIO, kernel-allocated pages or even ordinary
> pages the driver maps itself, but core mm must not populate, reclaim,
> migrate, copy-on-write or merge the range itself.
>
> We initially also treat VMA_IO_BIT as implying a mapping is not mm-manage=
d,
> as by implication it cannot be. (mlock() also sets VMA_IO_BIT transiently
> on ordinary VMAs while locking them, which is addressed later in this
> series.)
>
> However the intent is to in future remove this, as no mapping should be
> marked as an I/O mapping without also being marked with VMA_PFNMAP_BIT.
>
> This forms the basis of further work intended to improve how we express V=
MA
> properties such as this.
>
> Also update the VMA userland tests to reflect the change.
>
> No functional change intended.
>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>


> ---
>  include/linux/mm.h              | 53 +++++++++++++++++++++++++++++++++++=
+++++-
>  tools/testing/vma/include/dup.h | 29 +++++++++++++++++++++-
>  2 files changed, 80 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 97e1eb4fe3a4..83953757735a 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1612,6 +1612,41 @@ static inline bool vma_is_shared_maywrite(const st=
ruct vm_area_struct *vma)
>         return is_shared_maywrite(&vma->flags);
>  }
>
> +/**
> + * vma_flags_is_mm_managed() - Do the specified VMA flags indicate that =
the
> + * contents of the VMA are managed by core mm?
> + * @flags: The VMA flags to test.
> + *
> + * Such a mapping is one established by a simple mmap() or brk() with no=
 driver
> + * or other kernel component involved.
> + *
> + * They are rmappable, and core mm services rmap operations including re=
claim,
> + * as well as population, CoW and merge/split (if eligible).
> + *
> + * Mappings which fail this test are those where this is not the case -
> + * e.g. MMIO, user-mapped kernel pages, udmabuf (pfnmap shmem), etc.
> + *
> + * Returns: true if the flags indicate an mm-managed mapping.
> + */
> +static inline bool vma_flags_is_mm_managed(const vma_flags_t *flags)
> +{
> +       return !vma_flags_test_any(flags, VMA_PFNMAP_BIT, VMA_MIXEDMAP_BI=
T,
> +                                  VMA_IO_BIT);
> +}
> +
> +/**
> + * vma_is_mm_managed() - Are the contents of @vma managed by core mm?
> + * @vma: The VMA to test.
> + *
> + * See vma_flags_is_mm_managed() for a description of this property.
> + *
> + * Returns: true if the VMA is mm-managed.
> + */
> +static inline bool vma_is_mm_managed(const struct vm_area_struct *vma)
> +{
> +       return vma_flags_is_mm_managed(&vma->flags);
> +}
> +
>  /**
>   * vma_flags_can_merge() - Do the specified VMA flags permit the VMA to =
be
>   * merged with another?
> @@ -1620,7 +1655,23 @@ static inline bool vma_is_shared_maywrite(const st=
ruct vm_area_struct *vma)
>   */
>  static inline bool vma_flags_can_merge(const vma_flags_t *flags)
>  {
> -       return !vma_flags_test_any_mask(flags, VMA_SPECIAL_FLAGS);
> +       /*
> +        * VMA merging assumes that a VMA's flags and fields completely d=
escribe
> +        * its state.
> +        *
> +        * However, mappings which are not mm-managed may have establishe=
d state
> +        * upon mapping not embodied in any attribute of the VMA.
> +        *
> +        * Additionally, private (CoW) PFN maps encode the source PFN of =
the
> +        * range in vma->vm_pgoff, which may otherwise cause spurious mer=
ges.
> +        */
> +       if (!vma_flags_is_mm_managed(flags))
> +               return false;
> +       /* VMA explicitly marked as being unmergeable. */
> +       if (vma_flags_test(flags, VMA_DONTEXPAND_BIT))
> +               return false;
> +
> +       return true;
>  }
>
>  /**
> diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/=
dup.h
> index a6a8e53c4b38..89c645a6ad60 100644
> --- a/tools/testing/vma/include/dup.h
> +++ b/tools/testing/vma/include/dup.h
> @@ -1665,7 +1665,34 @@ static inline bool file_is_dev_zero(const struct f=
ile *file)
>         return file && file->f_op =3D=3D &zero_fops;
>  }
>
> +static inline bool vma_flags_is_mm_managed(const vma_flags_t *flags)
> +{
> +       return !vma_flags_test_any(flags, VMA_PFNMAP_BIT, VMA_MIXEDMAP_BI=
T,
> +                                  VMA_IO_BIT);
> +}
> +
> +static inline bool vma_is_mm_managed(const struct vm_area_struct *vma)
> +{
> +       return vma_flags_is_mm_managed(&vma->flags);
> +}
> +
>  static inline bool vma_flags_can_merge(const vma_flags_t *flags)
>  {
> -       return !vma_flags_test_any_mask(flags, VMA_SPECIAL_FLAGS);
> +       /*
> +        * VMA merging assumes that a VMA's flags and fields completely d=
escribe
> +        * its state.
> +        *
> +        * However, mappings which are not mm-managed may have establishe=
d state
> +        * upon mapping not embodied in any attribute of the VMA.
> +        *
> +        * Additionally, private (CoW) PFN maps encode the source PFN of =
the
> +        * range in vma->vm_pgoff, which may otherwise cause spurious mer=
ges.
> +        */
> +       if (!vma_flags_is_mm_managed(flags))
> +               return false;
> +       /* VMA explicitly marked as being unmergeable. */
> +       if (vma_flags_test(flags, VMA_DONTEXPAND_BIT))
> +               return false;
> +
> +       return true;
>  }
>
> --
> 2.55.0
>

