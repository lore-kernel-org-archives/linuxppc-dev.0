Return-Path: <linuxppc-dev+bounces-26687-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8C9C79F89
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 14:05:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdpkl1Mkfz2yvX;
	Tue, 08 Sep 2026 00:05:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788789951;
	cv=none; b=J5SJYPOLe6Wl7F6Jb7UXH69mcow7PGsSGT/Zz7jCoBMYLeUdYZRUo0jxcXRUwzPa2jdxwrtEl3Np7Je9p9inH3PPFR54dkA226Rd5OumftZ9DqbYWUCuTw7szw0lwQ+GgOjouSjpzgDkENbSLJLg0U3bkvkjzoNWoLQxTdy5Qy12Ql8dwqnQr+mh/nwQk/1ZWIVpBmJaGTs1LzQeYBrRzGXqKvuf1QT5de/wHHNn164bXROlhqA5xDDU8mKNpTyiPY4BOpktLx1QIjSwjwMkp5xfBFmtGr4NbSOruOMMbzUIalBEeLDYwmdKLimFgQltBSl4HZ4TsF2mMPhEPjoSbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788789951; c=relaxed/relaxed;
	bh=J8wgTvZrkyOjbsQqIGG8z/GcZBW64PcNCuag9I7xU18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+gt9DBXi36xBtOMBD9XXjELZKPr4YE4dTAHJ3J9Mr1BweoT4xtRhIGAC7YKHsRqpkDBRCDQ/rGtjooSJ+7CWHsjHFleStVZYXkd+5ox8fa4MgxXgThOof6tW5I5BsmPggx24yPuTIEdcFQrrfFwnGs2o+xtiASVje5HWisO810n2+AFOuWawH3h/wtvGnM473JGHnNmUMwQCkIylDbU1FcM55GAI1dgUtqhpcqZpBjNKYd+gs+1R53LXqJF455vulgx6bBCCb6SmZKHexoW0bIjBGIZkACJsrwJDjHw9ly9nvOQfpi5uE8Lorv5hf/Vw3UCxdyiBkeiqbJrvTF8fQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jyoR6vUa; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chenhuacai@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jyoR6vUa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chenhuacai@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdpkf1rMnz2ygK
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 00:05:46 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B0D1A4458B
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Sep 2026 14:05:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9803E1F01559
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Sep 2026 14:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788789942;
	bh=J8wgTvZrkyOjbsQqIGG8z/GcZBW64PcNCuag9I7xU18=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=jyoR6vUapKR5jhLivfmjBARU8B+F+OcyChINsEiyQcmcncqmoFh4nR/WY1xMB4qbW
	 SZ6/c1u/JlA4H5CX7f7mlQ5R5r6FFJHSnxuNy68TOL7Exjt9L/8POCTmlIZek5NDf/
	 vSQEPBTauZHGg2dpZN0RAsf8QHru/GLRGxXYBNPhH557FULtQLKshtNyFaJ1TLf/FR
	 VGO2DtvomYcv02EDInTSZEUOULBvYtXC+eZfgGqXpn1gPpLf/be4t5h3x0JZUmfEJH
	 j+M5kMyrlnOjjNbLDdri8qTidxOrlcEQQvkPs8w7ifuMeVCQ/Hmb/aPT2UlzUZZvC8
	 CXYUXx3AtE5dA==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a682579c72so4524330a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 07:05:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzc6YNCoXZvXSgrfAvQKD53iZGiazhofrCgC12ujd7/eN+vYmpPxcSarZOWrSa/kWmXaEL3TZ/cn2HI1tA=@lists.ozlabs.org
X-Gm-Message-State: AFuF++m98ZBesgLfDp/IsCow4KvP+z0xy5xaBGSRyGWp7/blcaZhWToY
	rcVoqhS8ZBIt7qABreso4Q0ZmIsJF5TX8bDIw/Zv9Z5pOdJIl+a4LBpAivbaakjtfBlwSt9BbD1
	/8yXFuAw+lSp/2DLurQlkHJeURiTERfU=
X-Received: by 2002:a05:6402:44db:b0:6a6:7fa6:f0ac with SMTP id
 4fb4d7f45d1cf-6a7e8f9e843mr12416286a12.22.1788789941040; Mon, 07 Sep 2026
 07:05:41 -0700 (PDT)
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
References: <20260907125404.922123-1-ruanjinjie@huawei.com> <20260907125404.922123-6-ruanjinjie@huawei.com>
In-Reply-To: <20260907125404.922123-6-ruanjinjie@huawei.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 7 Sep 2026 22:05:34 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7qjJ7BPnJ2KoQZSyMUvX_6i9H=EfdadXnmXtNiiB4ROA@mail.gmail.com>
X-Gm-Features: AcwNN1WbqzVfALnNIkIUg_l9MiYgRfsYFTxDDEyu_aV6t47lWMUK_7ZDBokn7zg
Message-ID: <CAAhV-H7qjJ7BPnJ2KoQZSyMUvX_6i9H=EfdadXnmXtNiiB4ROA@mail.gmail.com>
Subject: Re: [PATCH v4 05/12] LoongArch: kexec_file: Fix CMA page leaks in
 segment placement retry loops
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, 
	kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org, 
	baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, 
	pratyush@kernel.org, ruirui.yang@linux.dev, kees@kernel.org, thuth@redhat.com, 
	jic23@kernel.org, tan.shaopeng@jp.fujitsu.com, zengheng4@huawei.com, 
	james.morse@arm.com, ardb@kernel.org, leitao@debian.org, yeoreum.yun@arm.com, 
	sourabhjain@linux.ibm.com, robh@kernel.org, coxu@redhat.com, 
	tangyouling@kylinos.cn, hbathini@linux.ibm.com, adityag@linux.ibm.com, 
	djbw@kernel.org, seanjc@google.com, liaoyuanhong@vivo.com, 
	vishal.l.verma@intel.com, fuqiang.wang@easystack.cn, makb@juniper.net, 
	piliu@redhat.com, ebiggers@kernel.org, jbouron@amazon.com, 
	mclapinski@google.com, me@linux.beauty, graf@amazon.com, bgwin@google.com, 
	takahiro.akashi@linaro.org, palmer@rivosinc.com, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jinjie,

On Mon, Sep 7, 2026 at 8:53=E2=80=AFPM Jinjie Ruan <ruanjinjie@huawei.com> =
wrote:
>
> During kexec image placement retry loops, any midway failure causes
> the loader to truncate `image->nr_segments` back to its initial state
> to purge the failed segments.
>
> However, this truncation introduces a memory leak. The CMA pages
> allocated via kexec_add_buffer() during the failed attempt are tracked
> in the `image->segment_cma` array. Because the subsequent cleanup paths
> only iterate up to the truncated `nr_segments` boundary, these allocated
> CMA pages outside the new boundary are permanently leaked.
>
> Fix this by explicitly releasing the associated CMA buffers in
> the failure paths before `image->nr_segments` is reduced.
I'm not sure but does the elf version have similar problems as the efi vers=
ion?

Huacai

>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> Cc: Youling Tang <tangyouling@kylinos.cn>
> Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: stable@vger.kernel.org
> Link: https://sashiko.dev/#/patchset/20260729031235.2840255-1-ruanjinjie%=
40huawei.com
> Fixes: 55d990f0084c ("LoongArch: Add EFI binary support for kexec_file")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/loongarch/kernel/kexec_efi.c          | 1 +
>  arch/loongarch/kernel/machine_kexec_file.c | 6 +++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/kernel/kexec_efi.c b/arch/loongarch/kernel/ke=
xec_efi.c
> index 5ee78ebb1546..15fd797ff3de 100644
> --- a/arch/loongarch/kernel/kexec_efi.c
> +++ b/arch/loongarch/kernel/kexec_efi.c
> @@ -86,6 +86,7 @@ static void *efi_kexec_load(struct kimage *image,
>                  * We couldn't find space for the other segments; erase t=
he
>                  * kernel segment and try the next available hole.
>                  */
> +               kexec_free_segment_cma(image, kernel_segment_number);
>                 image->nr_segments -=3D 1;
>                 kbuf.buf_min =3D kernel_segment->mem + kernel_segment->me=
msz;
>                 kbuf.mem =3D KEXEC_BUF_MEM_UNKNOWN;
> diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/=
kernel/machine_kexec_file.c
> index 5412aa9f3568..62a5be102065 100644
> --- a/arch/loongarch/kernel/machine_kexec_file.c
> +++ b/arch/loongarch/kernel/machine_kexec_file.c
> @@ -217,7 +217,11 @@ int load_other_segments(struct kimage *image,
>         return 0;
>
>  out_err:
> -       image->nr_segments =3D orig_segments;
> +       while (image->nr_segments > orig_segments) {
> +               kexec_free_segment_cma(image, image->nr_segments - 1);
> +               image->nr_segments--;
> +       }
> +
>         kfree(modified_cmdline);
>         return ret;
>  }
> --
> 2.34.1
>

