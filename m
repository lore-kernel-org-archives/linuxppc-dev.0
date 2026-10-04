Return-Path: <linuxppc-dev+bounces-28888-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D641CA5FF1
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Oct 2026 17:52:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hyVVB0pY5z2y2K;
	Mon, 05 Oct 2026 04:52:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::836" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791136370;
	cv=pass; b=JO4mvGea0SQG7zudcvvx75Vrfeg0nXD0d3z4GuoBm7+7MOw9jhbNve94Arb/odd6YECEqH13EUD2JlXS9DXEajipJ2ogvSAeIxBcHrc0Y7vlcWeQZGzRlJA+Eu5fhGgn9ZGDC0WizTAB8RyZHQ9X9zFFGnhM21SzCarR67DvqwmBS6OLl7dna4NuyvbR85nJyRL+8ncwxWRLHUPJEo8t7IgNBjSjIjfvlelbmsNaSXnb++gY1x3f/XN5Gy4Mg9oUDd+AkiU2gB0DMuuXpKJFQU4ZXElJWmHylwccmJO29/OA09gOT8PcxMXNgoK7yI5RIhnTrIYxl2a3/cnM0Sw+hg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791136370; c=relaxed/relaxed;
	bh=hGuGLrOvm4LeUyfXJ5B4JaitM98XinzaQN/wjAvVcwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WOWZcxO313v73TvS5eEttvZTMbMY5+tPj+vkAzz80HruQcg1OzSFQITdD/oHQE8o82fJyuRrBMoAgfIddLqDi7TAVamQrJTrk+Mua850+lh1LsyXnpkmutbbsnJhLJuaceWfqxNLW1VfDVp4ClxVERY2j8OGHOjxzfjVKRK62vg1l631zqUlnvOZrg5hHPjw+D1KZKV0LlcnBA4cAlsXLwB+p6ZQApuE97726NvS4jQymGNxsM1WCuFi+NDB2R83a88vlW6byNKJNOseMhokPA1Ynz/ZtAJVD83PABz+OvusnQoqcpgJ7e7b2l0irij6msOsODBmY7MZPqbA4uOs2Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=PxIx9rum; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::836; helo=mail-qt1-x836.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=PxIx9rum;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::836; helo=mail-qt1-x836.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hyVV90wqMz2xM9
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2026 04:52:48 +1100 (AEDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-533202fe429so248801cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Oct 2026 10:52:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791136366; cv=none;
        d=google.com; s=arc-20260327;
        b=F6GUzaMJdm5RLGiwSoF3izWwgyY4xv4VfRhaAusJZ5Ob1b4BgkVWEhCGDUadbAsjOC
         R8eYmBTndr1TcXdyiE7zlvR5iiVgr3Yu+hk9K7SHdcrfYQy/cMvlI/Xb9zY5L5HG+/0k
         hLr2siLJ0lKODNH326VwOe+RFYjY7trLZuY9wO71KriNLr+c8tx9OinaRQ8IiTQcBITA
         cTKMoNZf1tc7ZEjQzR2s987aTInJdT7/cnHfliwas2g89g4CSgy7h4INcQHqMvnFxfU/
         6zox/JGW2udziyec7/2JgAxnks3zun2ROMORZi8ZVSdUjIH73H5bJ+TgRm5VMpJ7hyl8
         bLEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hGuGLrOvm4LeUyfXJ5B4JaitM98XinzaQN/wjAvVcwQ=;
        fh=Hiz4BnOWg89XXW+Uy7dZQ5OGmJgTKsa4SzqG9CeL2yc=;
        b=hoAuAV2qs0+ELrKN+WrOa6owipmmfFNrGtKdwSLymhIPF6mReP9dksmY2LHLc1oWjV
         0C5HSEktcC7F5Ih7Q8yzkewmLsXGR/d/Pk+1Fgq0VTtxeClvSwKe1O7yBevAnvG9hq9d
         fervURtmQcbfQCQq/tTT10KnoObCd1N0T7516pHVyPvxim3swWUtOtT7se3KvnSXtBOL
         ZaEOuY+A6q7EmnXyNcM0PdfnhaxZGJCTWNrJ6tOxhq8V9yuzsmeyzLSfX8iEPNXAIgwR
         X57XdAbWqXxRLXUbkN0k/SSMbE/oM4I2COOl9TpJJqjxEijZmFpI5q4gAG4EWAWR4WLu
         cgbA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791136366; x=1791741166; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hGuGLrOvm4LeUyfXJ5B4JaitM98XinzaQN/wjAvVcwQ=;
        b=PxIx9rums7FaOf7LcwmT6HVffPo8tEvVPwX231OqzDPF6omj4vZYU+rBRLRJ0gNNk7
         P+T2fItJbExJ1PGt3TO+tnujDv0rEMMNOz+qfpivV4ej0qYl/LuRDDtJV/8/30QjtVGK
         uVOdzqUv552pBig/+pCS50geZfYbtrcZV6MRUu9kXlwajEH7DPo7YOtr8/hl8U8MvFNI
         2Q7fnd+a/NmPqAenwTi9hjp/PIstvjpOsJtTZbNot3thsiMJT/CTHmqkS2bksF80C3oG
         cZ6awI0rqIAH4dEcrZUUEzHarqldEnP3JVbir9lZF/Y5DU1+E9NCHCj8Km5p2z2vQmCC
         Zhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791136366; x=1791741166;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hGuGLrOvm4LeUyfXJ5B4JaitM98XinzaQN/wjAvVcwQ=;
        b=WIq9SQwWIdCBQTZeDJXV61img5MqxgQ6LJafbKg3o8arm57CsmRFkTM3idhuGQjh1X
         3gSz1BQQqSwewwgcAa0S17rF6XoQVAqSCF+lvaPTn52LSvyIZ8r0YHzUv9p94j5uugUy
         GB8Kn0TJ4a3/lUpWsV9MP8/IXWFOm8HcKx63EQ3pJUJ2ard6Av/ewi4J87ugvwlDqzvs
         TGKQK3wU5jQiE8jfwM8Y47T0tKDYrt2NQzpBGOjKqPD6Sk1cbOJ1WAdswDcLxu9jkwZn
         2A6yBqT/Pv1ydFijI/HUkjwNzRQKgCvpN7RleaHrRS3seSuKG11TyILxXFHkE1pENruJ
         1Z/Q==
X-Forwarded-Encrypted: i=1; AKwUvBw/R99caExSu+Rtx1r0tum/NyO2wfd6bfamOPuxW0LVzEbPh1yHcC/QWPnZ/a57jSYEAPYhPRDzPLu9Voo=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kJ9FkkVqJv4M1hlA2EStDPBPcHasMrVbslCQmAeRBx0XgP53wS
	cwGw0Fk/GD/TDrTUuZrJ1HqnctWetFLAGShDI7baiS129w6YdMgE2Qji8zaxcd/dcDoIEy3oL7r
	fKyF7Yf5OVA/PyBvXuaYxNcQA9vq+a/PeVHzaN9bG
X-Gm-Gg: AYBFou2/rF2dqdEJ/pUfmbtKnWDYEKsWNotrlVEUfZcSnlKgKsmSa23Nq1AV3KaEu+V
	jqK4zrxrnQQzDDOugGRqyDB8b4Rv/yjRj2bASMrn+K+8MpEajJJ3NGG67hvtIMAA+WFfDSwn010
	Kds+qRCoAAar3YJAxLycyGy4HfEtBEh6YroSFzKwOd0QPcImlYAL/ezmPEe7HCqm5VQLtVRP5tH
	698UmRipe8Hi8r+hqwgAXgrhTEaB2PN7OrOmTnfaEWwNWue3VGS20zs+c87EUaknoROpph2E8rR
	7xO7YC+AGxZEWnZqwoGLePjtJspjVtp5w1mWBB1jNwfoiw1c6FLqf59U8A==
X-Received: by 2002:ac8:7fd1:0:b0:530:e00f:7768 with SMTP id
 d75a77b69052e-535143a7ee5mr16757211cf.0.1791136364655; Sun, 04 Oct 2026
 10:52:44 -0700 (PDT)
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
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-16-a1f052500fd7@kernel.org>
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-16-a1f052500fd7@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 4 Oct 2026 10:52:33 -0700
X-Gm-Features: AclHuK97kMRDYoB6lQW3TrcrLHtwyxFXHppfod8Uz1hqyRH7vKfp8a9EoRVxxRQ
Message-ID: <CAJuCfpHQwLZiXqsC2BsC6tUACJOMFfyLp9KC2w22NnzM5Ncrmg@mail.gmail.com>
Subject: Re: [PATCH v4 16/38] mm/vma: add and use vma_[flags]_is_fixed_mapping
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
> This determines whether a VMA cannot be expanded or merged because what
> they mapped was determined to be a set size at mmap time.
>
> This typically refers to mappings not managed by core mm, however
> VMA_DONTEXPAND_BIT
> is not reliably set alongside VMA_PFNMAP_BIT or VMA_MIXEDMAP_BIT, so we
> must explicitly test for this for now.
>
> We also explicitly test for VMA_PFNMAP_BIT as VMA_DONTEXPAND_BIT may not =
be
> set for VMA_PFNMAP_BIT's despite the one implying the other.
>
> Use this predicate in vma_flags_can_merge() and in check_prep_vma() in th=
e
> mremap logic testing to see if mremap() can expand the VMA. The criteria
> for khugepaged and MADV_COLLAPSE eligibility in
> __thp_vma_allowable_orders() are precisely those for mergeability, so use
> vma_can_merge() there (with an expanded comment).
>
> This obviates the need for the VM_NO_KHUGEPAGED mask, so remove it.
>
> Hugetlb VMAs remain excluded from khugepaged as hugetlbfs always sets
> VMA_DONTEXPAND_BIT.
>
> Also update the userland VMA tests to reflect the change.
>
> No functional change intended.
>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>


> ---
>  include/linux/mm.h              | 39 +++++++++++++++++++++++++++++++++++=
----
>  mm/huge_memory.c                | 11 +++++++----
>  mm/mremap.c                     |  5 ++---
>  tools/testing/vma/include/dup.h | 16 +++++++++++++++-
>  4 files changed, 59 insertions(+), 12 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 83953757735a..6b5f06cd174a 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -600,9 +600,6 @@ enum {
>  #define VMA_REMAP_FLAGS mk_vma_flags(VMA_IO_BIT, VMA_PFNMAP_BIT,       \
>                                      VMA_DONTEXPAND_BIT, VMA_DONTDUMP_BIT=
)
>
> -/* This mask prevents VMA from being scanned with khugepaged */
> -#define VM_NO_KHUGEPAGED (VM_SPECIAL | VM_HUGETLB)
> -
>  /* This mask defines which mm->def_flags a process can inherit its paren=
t */
>  #define VM_INIT_DEF_MASK       VM_NOHUGEPAGE
>
> @@ -1647,6 +1644,40 @@ static inline bool vma_is_mm_managed(const struct =
vm_area_struct *vma)
>         return vma_flags_is_mm_managed(&vma->flags);
>  }
>
> +/**
> + * vma_flags_is_fixed_mapping() - Do the specified VMA flags indicate th=
at this
> + * is a fixed mapping that cannot be expanded or merged?
> + * @flags: The VMA flags to test.
> + *
> + * Fixed mappings are those whose size is set at the point of mmap (for
> + * instance, a mapping of a fixed range of memory established by a drive=
r),
> + * and thus cannot be expanded or merged.
> + *
> + * Returns: true if the flags indicate a fixed mapping.
> + */
> +static inline bool vma_flags_is_fixed_mapping(const vma_flags_t *flags)
> +{
> +       /*
> +        * VMA_PFNMAP_BIT should imply VMA_DONTEXPAND_BIT, but some calle=
rs set
> +        * only the former.
> +        */
> +       return vma_flags_test_any(flags, VMA_PFNMAP_BIT, VMA_DONTEXPAND_B=
IT);
> +}
> +
> +/**
> + * vma_is_fixed_mapping() - Is this VMA a fixed mapping that cannot be
> + * expanded or merged?
> + * @vma: The VMA to test.
> + *
> + * See vma_flags_is_fixed_mapping() for a description of this property.
> + *
> + * Returns: true if the VMA maps a fixed mapping.
> + */
> +static inline bool vma_is_fixed_mapping(const struct vm_area_struct *vma=
)
> +{
> +       return vma_flags_is_fixed_mapping(&vma->flags);
> +}
> +
>  /**
>   * vma_flags_can_merge() - Do the specified VMA flags permit the VMA to =
be
>   * merged with another?
> @@ -1668,7 +1699,7 @@ static inline bool vma_flags_can_merge(const vma_fl=
ags_t *flags)
>         if (!vma_flags_is_mm_managed(flags))
>                 return false;
>         /* VMA explicitly marked as being unmergeable. */
> -       if (vma_flags_test(flags, VMA_DONTEXPAND_BIT))
> +       if (vma_flags_is_fixed_mapping(flags))
>                 return false;
>
>         return true;
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 4cd917f77f3f..87e8bf8029ab 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -212,11 +212,14 @@ unsigned long __thp_vma_allowable_orders(struct vm_=
area_struct *vma,
>                 return in_pf ? orders : 0;
>
>         /*
> -        * khugepaged special VMA and hugetlb VMA.
> -        * Must be checked after dax since some dax mappings may have
> -        * VM_MIXEDMAP set.
> +        * khugepaged moves data from VMAs once collapsed, after they hav=
e been
> +        * faulted in, relying on refaulting for file-backed memory.
> +        *
> +        * Mappings not managed by core mm cannot be reliably reconstruct=
ed from
> +        * page faults, and fixed mappings (including hugetlb) may well b=
e
> +        * mm-managed - precisely the mappings which cannot be merged.
>          */
> -       if (!in_pf && !smaps && (vm_flags & VM_NO_KHUGEPAGED))
> +       if (!in_pf && !smaps && !vma_can_merge(vma))
>                 return 0;
>
>         /*
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 7c368440fafe..ed19b47c2caf 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -1788,8 +1788,7 @@ static int check_prep_vma(struct vma_remap_struct *=
vrm)
>                 return -EINVAL;
>         }
>
> -       if ((vrm->flags & MREMAP_DONTUNMAP) &&
> -           vma_test_any(vma, VMA_DONTEXPAND_BIT, VMA_PFNMAP_BIT))
> +       if ((vrm->flags & MREMAP_DONTUNMAP) && vma_is_fixed_mapping(vma))
>                 return -EINVAL;
>
>         /*
> @@ -1827,7 +1826,7 @@ static int check_prep_vma(struct vma_remap_struct *=
vrm)
>         if (pgoff + (new_len >> PAGE_SHIFT) < pgoff)
>                 return -EINVAL;
>
> -       if (vma_test_any(vma, VMA_DONTEXPAND_BIT, VMA_PFNMAP_BIT))
> +       if (vma_is_fixed_mapping(vma))
>                 return -EFAULT;
>
>         if (!mlock_future_ok(mm, vma_test(vma, VMA_LOCKED_BIT), vrm->delt=
a))
> diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/=
dup.h
> index 89c645a6ad60..442ea9eb098d 100644
> --- a/tools/testing/vma/include/dup.h
> +++ b/tools/testing/vma/include/dup.h
> @@ -1676,6 +1676,20 @@ static inline bool vma_is_mm_managed(const struct =
vm_area_struct *vma)
>         return vma_flags_is_mm_managed(&vma->flags);
>  }
>
> +static inline bool vma_flags_is_fixed_mapping(const vma_flags_t *flags)
> +{
> +       /*
> +        * VMA_PFNMAP_BIT should imply VMA_DONTEXPAND_BIT, but some calle=
rs set
> +        * only the former.
> +        */
> +       return vma_flags_test_any(flags, VMA_PFNMAP_BIT, VMA_DONTEXPAND_B=
IT);
> +}
> +
> +static inline bool vma_is_fixed_mapping(const struct vm_area_struct *vma=
)
> +{
> +       return vma_flags_is_fixed_mapping(&vma->flags);
> +}
> +
>  static inline bool vma_flags_can_merge(const vma_flags_t *flags)
>  {
>         /*
> @@ -1691,7 +1705,7 @@ static inline bool vma_flags_can_merge(const vma_fl=
ags_t *flags)
>         if (!vma_flags_is_mm_managed(flags))
>                 return false;
>         /* VMA explicitly marked as being unmergeable. */
> -       if (vma_flags_test(flags, VMA_DONTEXPAND_BIT))
> +       if (vma_flags_is_fixed_mapping(flags))
>                 return false;
>
>         return true;
>
> --
> 2.55.0
>

