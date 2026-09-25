Return-Path: <linuxppc-dev+bounces-28182-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C55A6C9830D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 07:29:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrj4h0pPGz2yd7;
	Fri, 25 Sep 2026 17:29:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::830" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790321348;
	cv=pass; b=cOVkHBYXdM+jEHDZPmiD4L+U8ovmQfafCxyfeM+RAAs4s9x8bSDiMpKmto8raHkaN+9B3cr1uJosMawW1ANbpoZqILwJDiNOHYzb5PD0cuQcV5+hchTWaQiTiSfKldldxjfdmxmiQAzp64NWBBpPMxiL2Ps8EzqLQbpvUNluS1fg0q5vhtkHlFbQBQHJ43g2Dir/G4BK+9J6U5dJ3kIX2KSEe1GKmsaMiOKkCXBq7A2IMdlKiDzvoyKQTgSQ0vEntOvzKHxVrJVpvYo7eZUioetW657+lAXGSPBMbOej8CdZVEOW1lAcs1acvcaVueKaFaGVEt2LzzQZTiTOLb0+Bw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790321348; c=relaxed/relaxed;
	bh=QKlx39bvD+La1fyAAMePfYRq9L+0k8EzNqVplWKbJoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lqK8BjQY54XkFqJmGPz527Se7S98SblsZn1AnK5sVsrxbuLYUSCbAhIoSGjf24GPnaCdG3/90R3VYb50LC/Qb4BJITYTUX6DCMFlWRxaKH511fvlNSG6hx74uscji4mqV4h8c29QPc9QuudluDu3+8DHa5VoCUjU44I1tM/1IiqqxU2upc5hgpZlqzTa1O7eXYAhc+WYj5tRu9EdEdc+e3CzGjCfPAXV1ozKgQyxoaOmOGOERI4XGo99Iu3L6EOSkcsG3OVNJKquiToPpozLAYF3SeJGJIER7BKmLoxOD4tSXX03jYgk5V6nlsb9Hpk6wluDaOoMq5yaDcIJ+Lf3RA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=hOHMqvVt; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::830; helo=mail-qt1-x830.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=hOHMqvVt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::830; helo=mail-qt1-x830.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrj4d5tWMz2y2M
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 17:29:05 +1000 (AEST)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-53113d72966so133201cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 00:29:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790321342; cv=none;
        d=google.com; s=arc-20260327;
        b=A2LnGAAF4j4PrLpKTSkombYFvmZdu8PXuQFb3g0zYjBR67TQRhOkw5Oz5UqsWw/qvo
         vRffaslKadPSmcMkWkg0SIWuuII2vBjvwxJsK7VZkfPN4eT9YPCl/ev46KO1aBQdVAal
         sqgNfTKokqdsX615oxiJ/H5WQcVrGZ86HqUOtIggU0ijFLrHgKmL5exWVtC+eU/h+G7R
         xqJnGCjZFcXycgq+XyPPsiHlTJqPUP2F+5AITxYGhsY7fpb1L7iffr8W9UHuLNJ94nkZ
         qwD6AedRuBIWAolK8tkunuQaWYZKWzqbjewy45kceG9O4+si/1ACtoOvHDYNZG7ra7F5
         DTig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QKlx39bvD+La1fyAAMePfYRq9L+0k8EzNqVplWKbJoQ=;
        fh=+6vhX0SrCv1ey8r8BblAp0pEoSxLi/If//dgX9qZG10=;
        b=OZqCfx7clfDghR1vaT327RbQAh/nIAnGuinn4NHIFRv/vmTDCWT1YDqBdfixitEUJz
         QVdtGa0t5fpLY9rWq750OgWmednfigHqhL6cfSoB0pB48BiW2Im0uKbvhKfTImUz4oPA
         F8OABqjyZZFv1tOlXFyZj7EWSeXglAS1iC7IR6yRiVXvPpgwUnsCkMtkWiQknAe5NJAk
         uXeSbPfwpcPk1DO95mtLN4PxsOpa0sXSAJaWeZFU4R1iI4Ccc8mcQUl6IW7tZzNSndsC
         TZIGUDO1Y0c0cFiqQK2+qGM0zkziPnh8GkG7yFvZ4wNiPWAm/Y9jYopyY442iCvJI88l
         TiLQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790321342; x=1790926142; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QKlx39bvD+La1fyAAMePfYRq9L+0k8EzNqVplWKbJoQ=;
        b=hOHMqvVtB0bEOCF+HtdFdX2yUfBuWA8f0ENoBOcDf/PDJjSl8PmGOTcOhcevjuSwLY
         RjaRyt57LuvohRrFEVzenIzETHF1YX4YaEVY0kccBOxpJRt6mf97YQIDdsALRGGmYMx+
         W/pJBCpcs/QkQtmdW3MNDDccxu6b+AwxKCRH5yw4smrS6cve69BmY2/pMT/0vNOhWbIe
         xlu4CHjYE0CAgdP7vmOS7C5bqhfG3+QFC8Un2fHNqH2QLRCTPrIFxVZqAc77BRHVuB/Z
         4y8Ti/LyRhXfWWkKKOIhsZk51yqnnVyP6gaRlSHlSCjKj6XDgkJo7SFGzJLiisqFobTu
         SY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790321342; x=1790926142;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QKlx39bvD+La1fyAAMePfYRq9L+0k8EzNqVplWKbJoQ=;
        b=bBV50WVhohHYuEuHfYNqf42igaY7IK+CPQvQFyRzOcXVh+O8qoqeRzZWSGIJb/GW39
         f7DLCuMqwuhJWNYKoIrqyineD6UVkJFCrwjMunofN7t20f/o52PEnMDG2/Lv4yxPSgKo
         lYI5LDmZU4/r/LAHqcsTwY+wgSnjepAxLf+dOOEwO4COWRDs6bK3dg//luhxPyV4vMTI
         nSK/yxgcVt7karVJk4IJMAjwBzkjjN4aKShxI3vEDbSuaCgFmkkM9dpW5T04Aw4Ff/GS
         Vr/EuGzzDCoEOUtqHEozbqwwYKQ9JWnqR8bIanyAIaPniVYPBlIiGuN4sgkfAMI+FWou
         tGZw==
X-Forwarded-Encrypted: i=1; AKwUvBz/Al97iGVvFIKJ2gplaZWF1X3Jwxce9rIEga4UWFknvKZzeuiNNLHTrrQIFoJSefEa6unbxPb5odys0aU=@lists.ozlabs.org
X-Gm-Message-State: AFuF++k/OL+oucwqEEQDSNh/czr3FrmUVQPCNXtirgppZ3bz1+y3HRFM
	tpdnO8MAHEH8YURUpbKgpIFNsWjv0WUyxfy/9sFHIkZFyiW1bT+eLWV7yi3/EsBpGkD5vW7UPYy
	sYjJmFhrOMSyP/vHr/GOMmp2zgHvPRLAlbfcaKpGV
X-Gm-Gg: AYBFou1xxUC9EaMzCk92K+dgBEeFJlqsuHMJFvGaj9GCIJRe87k78f4m/F8N0PfBhf9
	82RUbBW1PJolZ+spwu2ccWn44vXc+9KCYy6rNRvpagZIYY505v2RS+UgW+27gBoRdl9Incl+icq
	Z9wg1vXL18siICQikXK46Yv9Y8AX5c4Zvxblr6FgeJHBM6JzvwMvzZ0P9M7rpQJ+YFKlIn7XRP3
	lUHj2ZthE0DcgmM+VQ97f/4wXY8tp+u5cEgFh1JBAyh3iR98TrGUDFSfEZSk18YF6UGN9UsI29W
	0/EGpddxkNHgW1J2oME7Yos5cNBm8ztXBdlzfRsgs1Dr6LlZ2ow1fw==
X-Received: by 2002:a05:622a:4c15:b0:531:d8:e437 with SMTP id
 d75a77b69052e-5330e1083a8mr8850471cf.7.1790321341004; Fri, 25 Sep 2026
 00:29:01 -0700 (PDT)
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
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-5-4583d8a23bca@kernel.org>
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-5-4583d8a23bca@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 25 Sep 2026 00:28:49 -0700
X-Gm-Features: AclHuK8wpU_boMBtoQ2BxSfl48UrjTg974xy2tCF5bv_vM_I_Kq5OyVf7aIl6LM
Message-ID: <CAJuCfpF2U9rgHmhaDoXX1hxsuuS=s-oWK9Nk19TDQ6CLpjhFVA@mail.gmail.com>
Subject: Re: [PATCH v3 05/40] mm/vma: ensure mmap_prepare doesn't set actions
 on a mergeable vma
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

On Thu, Sep 17, 2026 at 9:25=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> When a user requests an mmap_action be performed in mmap_prepare, this
> involves populating the VMA range with data.
>
> However, if the VMA is mergeable, it might then mistakenly be merged with
> another VMA without having populated the range.
>
> Every mmap action currently available sets VMA flags such that the VMA
> cannot be merged.
>
> However, to ensure that no future mmap action falls foul of this, assert
> that this is the case upon mmap_prepare validation.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/vma.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/mm/vma.c b/mm/vma.c
> index d6ed10cefc8f..62f2ce1ad5a1 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -2809,6 +2809,15 @@ static int mmap_validate(unsigned long prev_start,=
 unsigned long prev_end,
>  int mmap_prepare_validate(const struct vm_area_desc *prev_desc,
>                           const struct vm_area_desc *desc)
>  {
> +       /*
> +        * It is not valid to execute mmap actions for VMAs which can be =
merged,
> +        * as any such merge would leave portions of the mapping incorrec=
tly
> +        * unmapped.
> +        */
> +       if (vma_flags_can_merge(&desc->vma_flags) &&
> +           WARN_ON_ONCE(desc->action.type !=3D MMAP_NOTHING))

Any reason you chose this "if (A && WARN_ON_ONCE(B))" pattern instead
of a simpler "if (WARN_ON_ONCE(A && B))"? Unless there are races
between A and B updates, I think these would be equivalent, right?

> +               return -EINVAL;
> +
>         return mmap_validate(prev_desc->start, prev_desc->end,
>                              desc->start, desc->end,
>                              &prev_desc->vma_flags, &desc->vma_flags);
>
> --
> 2.55.0
>

