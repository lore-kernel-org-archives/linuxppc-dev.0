Return-Path: <linuxppc-dev+bounces-28044-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBABDC9830B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 16:24:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqj2n5TnNz2y2L;
	Thu, 24 Sep 2026 02:24:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::82e" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790180641;
	cv=pass; b=Pmwe9DR+09ny51vxgjDlToebM8Y3VAgDD2wutdBNqomY7w4un9joh+D1RS25YQ0YJ+yTxi/sYJCmrSRGZJ2ubrQnRZUaDeiLqCdN5tXB3baE6N3E+HEtaO56JVfE9xAMjoqUG4+C1s6tdp2YKV0g3ub8jxLqFqZDDkh3wZlGIu+c+HpzghYzsEgyQotJt7eW6l9lOJdwGM506h0fFb16dUcEQ/ymTotffGZNkJTCbgj1zKTTmaeoCpZ1rTquLMw0KsDwZbkAYfMMhs4dE8eScoSh00PjH2dxKugwcQCdIRwE8jK/THu27vxcxL9B8mLQsb7WCOIe5Ow3YxxQDeLG6g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790180641; c=relaxed/relaxed;
	bh=3FzOqkymgnKp+HaLHwhofGZjaEcw2lbzuDYsddlgiEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hzCjQFRrp3OjO95aa1kD35a39uHf96h7vFyFnHdUn8dTXrsW42ZIBchqimrO/e9SeRUZScpBDIL/aJ7RURUX+3b8S5j47rtxRGlIM6TJvHQ6FSvutHLwoBxwumtKPWai/weD2pEXwrxsyT/0Y8oLaEkWvX2Om15MeGFwG2coiOpQMpGTkZlVkPXNIgcQFioZglzagg6zcLcztzCfDHyIiWKSpfYcCxtTjCc1x8Ifr34RATGF4vk45Lflh7rsFsQDRz4LnQJGsEpGk2dBEDsT7kXCceZpVNpGUHZj5R173fr7uRnhGpz8qozUzekOSenMzXFBMK3n31rtQOk708Ih/g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=QXRKosS6; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82e; helo=mail-qt1-x82e.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=QXRKosS6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::82e; helo=mail-qt1-x82e.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqj2m0j1pz2xmh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 02:23:59 +1000 (AEST)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-530e8c6fb80so276811cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 09:23:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790180637; cv=none;
        d=google.com; s=arc-20260327;
        b=s59EZ6RGHG+z9/CvqrykjwlimOcQ3iMg/PoU8Rk2H7QgOlHKVPxFVhSTfcgxdJAJtJ
         v+Kramg6Hdt0OzdDVJ+f9UvO8DL84Wfqmg1wWSRoEj46vvOoEhXYIFG/qJYZYtF5pxjD
         74YhnoduoAB3p4mSDlukD38yjWlKxgLakEQEmmjRUEU6GDyMCaOKG4Sf6V1oVgGkU2Y8
         ZKBRKTBGH9xdCcmN4akdvYO8Ebm4N+jaE91Wyf4bagjuQWUrLZk3VSyIY75mSWzztAPk
         XfN4ZCzEwQtrX/PzrWs+SLwP0GtGg2XEKeQ0e7hNBtoci0UGpG403b2EKFbpxvOEP7EU
         T8Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3FzOqkymgnKp+HaLHwhofGZjaEcw2lbzuDYsddlgiEM=;
        fh=yWKRD0sWx253S0Bdh6kWCGRwHhoVVuW24tSnfZAv8C0=;
        b=VIiHj8f9kjp094hdElRqcYNy0BvwDuotnNbj+zEQvOj4QbIPYgXwGtMe8sUXLjOm6y
         SUAuO8Ab9QsIvglfNgg/qR/QZGfrS4tJ0a2HT/A3D/INJc5pWj8bTnDJonKK+Waw+I2z
         QSKvXYhHa+Ml2y60PeGlAOlZotIh4wrBPHUIm2bnLr0p2pnWG7Dt+L+1ydpasyeqkXZB
         OwxwFby1kaxhkX+lKNDwvccWoEH7BkKL/RMduwPXzc0ozfYBSrsddJbkkbePzweWsiu0
         0fCx6lYsXTQgJRQ36piuWw2kEsbe5guFPofUeV/thEfOo+iQ7WavcGxtzZmoE/eeXxig
         Qz+A==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790180637; x=1790785437; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3FzOqkymgnKp+HaLHwhofGZjaEcw2lbzuDYsddlgiEM=;
        b=QXRKosS60nNmn2oFn5JPuixhj7JnXRyw+GejqnkhXVjutCbg4ffni/jHcUgVDdMrSR
         BMWuBPyYRE9bq//h3tW+UQLYDAOr6bSQXMIgwUi80JcR2RESNDiCLPfo8d7APAiJldcE
         NG/HuyySlSrX+ibeXXLBoNua3QPgZMleUz1VxajS6z8pOLNhSXaI+eAZ8Vcrdj1Stfgu
         aq3DNwvjFDEeEwIIv/9WK4FyIW+kxkd3+Jq8U6B6OtaAwvgm4u4cvOZaMZ7E7Tm5sCkD
         2ykNL+OHOBs+BNy5D69zkeEtMkwiq/VsV2ZpEYhcoMxTkt3ux1h/XjisPjGcDejvqBoq
         51bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790180637; x=1790785437;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3FzOqkymgnKp+HaLHwhofGZjaEcw2lbzuDYsddlgiEM=;
        b=VdN7s+shZhJcSfWBJzVuYNI19wN5H7zEUzxuzntqDmQFJxeGL9XcWfz6ZHghqP1Zpj
         3aluJ16il1Z5DhlK1Mk25MTpkojEON97n9pTLVGbkGK2ItpQbhqNcGwXbG+QHPk2bH0F
         GWDeU9ePIzFhpkGdaKLiW7vEisvD/YPszPO7aadqs6S5XKQD7ZMHi8HjLDBFWktYzRU9
         J0kF7g+sDQJFduiBhrIqkZtjqeh1pBz+9wAAmqoy1dKry5EFUo3tje7DF+znI4q0YUwz
         rDz5/6U1wYa9yYmVAD5W6gcikU7jIHh/WlEJJa5e/SXl4belb2kkLa8TVd0NlLNzwHPY
         PuOA==
X-Forwarded-Encrypted: i=1; AKwUvBxd+H8hZ1At6UToXIep78JMQ+jjU0G0brCZljZQqez3xiWZrNRzwHpC0tndJ0j1NzvQoOf3mIl+wrcgM6g=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lQsMhppaDPsn4zd0yHpYmTZG9VmvFwIFCbYPm+TbqIWvOeyeqY
	i0AoyUeVUzyf4aDzwAinHjCmCE2LQml9WYz+6DXyEfc15RJ1OFlQxvYN0ZBFhct8QcorI2cqW5a
	7gpj1t2SEdDUQE6vQTaNvNNG1P0DYMD+nzhMgzo8d
X-Gm-Gg: AYBFou0pa4IucAQV5HQ7MqrFBNB8QAhaQwkqdk9LNJfnjubBwqm+AyGUISiAo5L6LDq
	JUsU5x7AXYTEyu652C72U9V1i469cS7w3d0mmTXjb2lmqB4zCMM22skdqS9fQWUvXGo+ToMKRVV
	rZmYDHmQCgPWTKOFcwPQpFomVNNDC8t7YHb5ilyMBD8pu8F0f6aBQCp3RmNKlFSRh0mFvQRUK/9
	qh4C1u6FG4WgrRLdWMFK/z9ZBoIA733i51LXDL+cw+ET1GJdlcSlESYa5Yhh1TKqhKktm8Km3hm
	+cfrBcHxxaw/sUmWDzXVzK6YKnQy3d1YyjB6fLLXE3yUVUZZQfN0R8tdlJJluLThFpBdf2JjkxS
	88FgZpUY8vw==
X-Received: by 2002:a05:622a:609:b0:531:282:6560 with SMTP id
 d75a77b69052e-532f9d4a86emr439391cf.15.1790180636277; Wed, 23 Sep 2026
 09:23:56 -0700 (PDT)
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
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-3-4583d8a23bca@kernel.org>
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-3-4583d8a23bca@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 23 Sep 2026 09:23:45 -0700
X-Gm-Features: AcwNN1U-1rGp6GFHFrF0qqhOHTzivX5krrdmfBch0hMHABT_yaCwm6D93D-Dyz8
Message-ID: <CAJuCfpE0WCr1Kp=+4EVJB7UdbH22HuCouOEtGMNCL+a8TnCQPQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/40] mm/vma: introduce and use vma_[flags_]can_merge()
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
> Replace the open-coded VMA_SPECIAL_FLAGS check in the VMA merge logic wit=
h
> two new functions vma_flags_can_merge() and vma_can_merge() and update th=
e
> merge logic to use the former.
>
> This abstracts the check and expresses it in terms of the desired behavio=
ur
> rather than an arbitrary and confusing VMA flag.
>
> This also lays the groundwork for making further improvements in VMA flag
> usage.
>
> Also update the userland VMA tests to reflect the change.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  include/linux/mm.h              | 21 +++++++++++++++++++++
>  mm/vma.c                        | 19 +++++++++++--------
>  tools/testing/vma/include/dup.h |  5 +++++
>  3 files changed, 37 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 969594074fd2..68250ece4219 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1612,6 +1612,27 @@ static inline bool vma_is_shared_maywrite(const st=
ruct vm_area_struct *vma)
>         return is_shared_maywrite(&vma->flags);
>  }
>
> +/**
> + * vma_flags_can_merge() - Do the specified VMA flags permit the VMA to =
be
> + * merged with another?
> + * @flags: The VMA flags to test.
> + * Returns: true if the flags permit merging, false otherwise.
> + */
> +static inline bool vma_flags_can_merge(const vma_flags_t *flags)
> +{
> +       return !vma_flags_test_any_mask(flags, VMA_SPECIAL_FLAGS);
> +}
> +
> +/**
> + * vma_can_merge() - Do @vma's flags permit it to be merged with another=
 VMA?
> + * @vma: The VMA to test.
> + * Returns: true if the flags permit merging, otherwise false.
> + */
> +static inline bool vma_can_merge(const struct vm_area_struct *vma)
> +{
> +       return vma_flags_can_merge(&vma->flags);
> +}
> +
>  /**
>   * vma_kernel_pagesize - Default page size granularity for this VMA.
>   * @vma: The user mapping.
> diff --git a/mm/vma.c b/mm/vma.c
> index 4b74b48c29b7..05d2c676672e 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -924,13 +924,14 @@ static __must_check struct vm_area_struct *vma_merg=
e_existing_range(
>
>         vmg->state =3D VMA_MERGE_NOMERGE;
>
> +       if (!vma_flags_can_merge(&vmg->vma_flags))
> +               return NULL;
>         /*
> -        * If a special mapping or if the range being modified is neither=
 at the
> -        * furthermost left or right side of the VMA, then we have no cha=
nce of
> -        * merging and should abort.
> +        * If the range being modified is neither at the furthermost left=
 or
> +        * right side of the VMA, then we have no chance of merging and s=
hould
> +        * abort.
>          */
> -       if (vma_flags_test_any_mask(&vmg->vma_flags, VMA_SPECIAL_FLAGS) |=
|
> -           (!left_side && !right_side))
> +       if (!left_side && !right_side)
>                 return NULL;
>
>         if (left_side)
> @@ -1152,9 +1153,11 @@ struct vm_area_struct *vma_merge_new_range(struct =
vma_merge_struct *vmg)
>
>         vmg->state =3D VMA_MERGE_NOMERGE;
>
> -       /* Special VMAs are unmergeable, also if no prev/next. */
> -       if (vma_flags_test_any_mask(&vmg->vma_flags, VMA_SPECIAL_FLAGS) |=
|
> -           (!prev && !next))
> +       if (!vma_flags_can_merge(&vmg->vma_flags))
> +               return NULL;
> +
> +       /* VMAs with no prev/next are unmergeable. */
> +       if (!prev && !next)
>                 return NULL;
>
>         can_merge_left =3D can_vma_merge_left(vmg);
> diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/=
dup.h
> index 16c09dac59d9..2fd422789717 100644
> --- a/tools/testing/vma/include/dup.h
> +++ b/tools/testing/vma/include/dup.h
> @@ -1647,3 +1647,8 @@ static inline bool file_is_dev_zero(const struct fi=
le *file)
>  {
>         return file && file->f_op =3D=3D &zero_fops;
>  }
> +
> +static inline bool vma_flags_can_merge(const vma_flags_t *flags)
> +{
> +       return !vma_flags_test_any_mask(flags, VMA_SPECIAL_FLAGS);
> +}
>
> --
> 2.55.0
>

