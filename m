Return-Path: <linuxppc-dev+bounces-29477-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E423ACC6B1A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2026 11:29:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4TVx2mTRz2y8p;
	Wed, 14 Oct 2026 22:29:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::132c" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791977353;
	cv=pass; b=NqXrtGPMBe97MwEZUoNUBPgATzGgir79kfIVm53f7+KP+qpmLsyXkr9zjCAZ0LGN4BdKqmcwQU+EbezfIgA4OqbPuB8yehonokjHzrJFllFdtbPfPYHkjAZ33ABu9PEmgW8Xbwjpj+qg5D1WfcsPw0DhE9nrD7+1nq0qHz1Th9jOApSg6qWLbY6p7hQPC8Ry3hD+lIwJnPALNE71HNiY5SWsyxuBZlAEDHHFTOybYB5yJY2Y5VUCPBfSwHyu4JQ3wyV/mqbs2dYy3FSv+IQQtHeVYgvOhE56GWtZ1QhcpBBo8g1DnboVDrREEunWpkkOXIBTmCq/o3pGlqz5AZkPfQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791977353; c=relaxed/relaxed;
	bh=xWJCwZOmpC49YtbA7QzlowrBvokYI4WD90uvALsrwIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bTnQwvuXLSJxso9bZ+XgYtFV9k5Ba8sVLkkRFWSGRuZfFYibD2F3LLUBNC/H346dH5PaYly0jl771G5x4BcTvarUhX2WNdprwPJQxPRj8aHkLxJ9EwtHIByOVLoHIy8Iiai6BxPbjm30CoLhf8OkVi2codKC1WXUZ83NrNWKVFKTB/kpdayLe8li6APkM8gNn9SwVtRpRhCsyt/60OFJLVxLtAbCNKVW/4nmO5fV4eWbGNqDZuKoytiv0q47n4nebzfppe9453oTWmTMl6W+fGT5K2SS4SiovP8Yv054q9eS8qkp0hrg3gT37fCXgnqZJElm1FewSx61nMuEQSxthw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GK1FIm0b; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GK1FIm0b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132c.google.com (mail-dy1-x132c.google.com [IPv6:2607:f8b0:4864:20::132c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4TVv2wC7z2y1Y
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 22:29:10 +1100 (AEDT)
Received: by mail-dy1-x132c.google.com with SMTP id 5a478bee46e88-35179d0747fso306966eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 04:29:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791977348; cv=none;
        d=google.com; s=arc-20260327;
        b=VNtWhBipkR8LcEr7V5hU0WkiRmgdaKjTxM+7rhaIhtqE4ZWcA6g16/9wx8wnneyZQx
         LRyYmEpGuJGKuEO7eV5Akbi8gbQ9/QU+OdA7flvt1+0j0n3dZZWFV5rEXG7GdrOi21Sv
         aib7xNGNkL9i88tQgr/SR+QRbu47OzjlupADbWe4UQw811DT49/Om8IxIKS7rY4G04kT
         7mT02a6qXHao2tnL3atDzmsTO5pP80Uf25up29IkRAMsPA87lPerLqx6rn6wOnXST2gE
         daY8KT3SttxNsZfI5NGU/HaA1F04QBvenaSheTSSr9gR4TAfitEaz3nqQ0BorjPc6EHk
         DKxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xWJCwZOmpC49YtbA7QzlowrBvokYI4WD90uvALsrwIA=;
        fh=xO2L0U3IUj4IFUEIW2aNNR92dENHab/M83vANfC+BZs=;
        b=i/v4uJhyz1hEyNSpxy4Z86ulyOJXC0ch1swvnx+V84DsE2c7ODMJUF/Xp4MxyssSYG
         +gbX4Rt0zY8sSiCUxSLPggwonmP9wR7uw7oyaLdWIQsvFNjvz8Gf8VIrOmaABgPDPrhY
         eQ9CE3/QxEznDuRKq+1lzx2m5KB5xJUnvOv18KoTl+dfUfpDvdC+b/gR5TZkq7vGIfjl
         o/fGsGMO6hu0DZyKbnfuT26He0V6hK799KQL+sVK0q/LDUu6jfGtSo2CmS5A2/t/6+Ks
         2jdW7QjGo1KzOtuFLlii6OfSnVuvBhu0tYxFaq0tLTOMC0BXQKTDaOZh28UPCm24sjDF
         Bkpg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791977348; x=1792582148; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xWJCwZOmpC49YtbA7QzlowrBvokYI4WD90uvALsrwIA=;
        b=GK1FIm0boeeNUMMMgIaJUhXwsjiSfxIgGBS0rBMl3ZYYwl5h6BMoqaV0BgqrNJ4QDm
         lyuxIxX9/bmFwb2j50tl7WaMeAR4d2jmu1Jk6BWLXjRqY+psFZufKirNT7LZkuEux6rK
         efw5p/CWNCYrtx6r/rgnR+U06d41AP7Qoh49Zb/IoiP5pk1o8+/UnRCxaF6TXhNp/cot
         Jxq0MMIezZFRvVurTkSK79yTcCAh2XntD8SqtHW6U2oJ0a7lOAHOGqIyqyhhAcjqoOQn
         uoz1PfKfn0QfG46gadI8kLY5supY7Uj3sSYCqhnw/MFHD3g38qz7qsRQeOToXBp9NOaV
         vVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791977348; x=1792582148;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xWJCwZOmpC49YtbA7QzlowrBvokYI4WD90uvALsrwIA=;
        b=NFy6RAJr7Hu4GrRXcfdB9sOm2l5TnFsvwCoU0ITr9LFbLFa/+UF9u+MDlErUdhAPc8
         jDTbz5qBf3NQAdzarjo5Z8puDnI6z7mamNerLnhYU8KgPSnSVZpC2U+38ygLWAwbSHIU
         eIaTn2DZ9XX1GRo4G/1iSuM1wZ5ilDjq6fuZDQpe+A+tTsEoihfLftsq42bSLsW91IsA
         qAKQQDU4evfh46q9L1fEliaD8cUp4yM36yKKEavGG/im4gTd4axp17Idxwyx5KoGfSfd
         WdUBK1MYrz6BYDfOaSf8MsDBvyOugJ4ds4fo449E3dMMqLy7Tx1XDRi/Ym1cYMOC7lTE
         8Vgg==
X-Forwarded-Encrypted: i=1; AKwUvBy98IOuvba0Bwr+MuAJQwfL8JxpUJpkZZuQrnTItKVSDkxpy4Jd5f1Gzasqmhe4hFrCc59xvxAGkwoKzq0=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLXI3Y5A+TkxIn0YJF+PIx37phPF9Z3JZz4TCdSmwazE9j7aH8J
	hZ3cpufMGy7baqbnC/rkKqgt4FvOV+bfNltiFcsMkN4ZAttuRX51Cg/TDkWeaK5W5atdrJtyZf8
	h5doZxheAguqpXYtapSc/hcOZ1QH8Cds=
X-Gm-Gg: AYBFou2c1XLnrK4t9wrc+6Wfn5d6Dd0LAam15p+paiNspNtb/3guwdfA/cd0J4qDIKW
	HawJq8oce9OdFEL+01Hr2KL8GqdlKY/Kn5nvhDZoKK1n5GwcHYLdObAC/pnLHeJH9aRk/ZF2f2J
	WBMSGzChbPZpzYC+x2i7WPH+8WbrIivN/cQ8V+qPslNBY8kF626BDz1oi4a7AjlwmNqmuuZ3qnK
	rSq6ZOIHKbrV3ZGfrVZVdEPAtKBa+Pzb/dT0RwiWpNEY79SkfLe9FiKY5d57sQOukbeu3r7Mx41
	mKHMKQ0OegR9yvZQQ8NHV1s2rN8qetsgaKaJDGenQnz9PbAvlO+2MT/dMbqZkOdmAZqA667xr5h
	JvJ1CAhlD7nU/ExxCApFmAjEd+MOSrX5onJVsBtLFBOUr9781h0f6DMQiKfyWYBq3r7l1qsPxVZ
	o3erVM8fM3kmCZsXGJXZNsn8tjsxzIUInpot0gVqySGneQCexkSZQ=
X-Received: by 2002:a05:693c:6215:b0:35b:cb8a:8ce7 with SMTP id
 5a478bee46e88-35bcb8a919dmr14326600eec.1.1791977347656; Wed, 14 Oct 2026
 04:29:07 -0700 (PDT)
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
References: <20261013223946.1836757-1-irogers@google.com> <20261013223946.1836757-2-irogers@google.com>
In-Reply-To: <20261013223946.1836757-2-irogers@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 14 Oct 2026 13:28:55 +0200
X-Gm-Features: AclHuK8qVHO7HVQy6LgzcUgjYcQf3EimC6SJcN58PVqcWVdOf6T45eXZNeTLsEY
Message-ID: <CANiq72mLUh1JB=9e=tqStuL_H3=Ormx5v-uFkCDp-0zZm7tBrQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] Compiler Attributes: Add __require_explicit_initialization
 macro
To: Ian Rogers <irogers@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Viresh Kumar <viresh.kumar@linaro.org>, 
	David Teigland <teigland@redhat.com>, Alexander Aring <aahringo@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-s390@vger.kernel.org, 
	linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 12:40=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> +/*
> + * Optional: not supported by gcc
> + *
> + * clang: https://clang.llvm.org/docs/AttributeReference.html#require-ex=
plicit-initialization
> + */
> +#if __has_attribute(__require_explicit_initialization__)
> +# define __require_explicit_initialization __attribute__((__require_expl=
icit_initialization__))
> +#else
> +# define __require_explicit_initialization
> +#endif

The LPC slides mention Clang 14+, but from a quick test in Compiler
Explorer and a `git log --grep` on the LLVM repository to confirm, it
seems the attribute was introduced in Clang 20+, no?

If that is correct, then it is not available in all LLVM versions we
support (LLVM 17+), so we should add:

     * Optional: only supported since clang >=3D 20.0

With that:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

