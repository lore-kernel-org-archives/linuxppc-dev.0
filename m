Return-Path: <linuxppc-dev+bounces-24383-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EBB5C4451B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 19:05:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h1zrn5zxSz3c2t;
	Sat, 18 Jul 2026 05:05:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::52d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784315145;
	cv=pass; b=J/KuaECXrDLwauN8dIKlHuAhCVIUoKD7YAnBK9ZPUEy1xr54KVjHZLc2sdxVhH6JeVJXCpkMD6C5Fx4TG758iS5dSMklOB0+XyPh6bmPhzAYqj2hezeNQLOv0XgQDnpb2y7elAgMM1Lw+GRa5qZrpUNen5/kvtnJiHo6JL/hriT5ZjgXcSiv859abLve8cZGy3ZWpkGjKDln9GmLHOKZVi1NRSlqwqHgxIUIRMypZyJBIJBIIrLnGSkeaCywSGhJaUe0c64HVK63GxWurY99oeNwBgrOf1ZYrbySZKK+8Edyh6Hp+8iUoV3QFjqfpO3FMkbmTKuRWYbwRCfv1aSdsg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784315145; c=relaxed/relaxed;
	bh=XEvDXQmWMeu8eEveSi1MmpQMOZM/nj4kZe9ixSXLOf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQAb6fvMN+p3tpYYSqv1RX6tQrKR8Ld82abl/j4vTv/YVkjPG7ELJasKYaUpxq2sdFQDl0ig8QPbv0OsmDglgwTklGnTTKc7UnFtOGJB0TT1GKivLiYqJF2PW4yS9yTPNIrI3YK2TBsgwLQpyNPgbsgY+Sju783jKTMVVpfs3xZ3PTgqxDrbfkjJRgM2/7QlpIIdsu0s5SfMGVT0xRkHhMCEZmFp7sxcXXCaPVhxO1tsf5vrME7pOfIGl4xb+e3/5591WvUOnOInyGAsUk4df2mCC6X4tVGIW/O8YGhb9JwvHh0LpWHqs6QEvT6lcpyZguSkHW67DVEDgXsvF5rNRg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=llVBTYwX; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=llVBTYwX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h1zrl4xYlz3c2h
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2026 05:05:42 +1000 (AEST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-698aa7ba3e6so5568133a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2026 12:05:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784315138; cv=none;
        d=google.com; s=arc-20260327;
        b=rvu9pShsOI0dUdyFw0U8e32+bGN6TRu/sW6Plsxf9fq8BxJD56fesJRr7uCeLtsE2O
         UQxqPC4BvqWjcGextJ8jZQkcn5oYH1RXQojiXAKXo16flBjJg6wDMd6T56/JYBGr0ubq
         nZsAb+LXyBexIzld8fjISbVBptir3jOseEUkZdjKrV/oKqKwO7HkUsDme2UEmCZHStlr
         XFqd1kEx+psLqBkp9hK81iyv0NVI70Y8LOLnArBg8SjQK2x0gp6D4LXbcandQDb+pzMp
         Vy//Rj6s3HT+WdfKgZh31QKg9k9e3Oi+OU0vO1zoGazyxI/z0+GkX8Lslfw2jfW3jb8b
         z2KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XEvDXQmWMeu8eEveSi1MmpQMOZM/nj4kZe9ixSXLOf8=;
        fh=sne/nriscIOXwGOCKZDbnMYMfm5DROcVgcFEh+IIL/w=;
        b=DG0BSB30JpcfNikQzifR1D6VmMRm/WlOtDo6QU1wR9Nnz1b2iZpWGQxXiwfhrZi/n4
         DUd7xeLxN40443bsKxfwqccg5tFW+SD4PSP+CsqnlzbdMBgAGdFvTy+lPy+fJ15NNLPd
         8lCavejtHK/juQdE7eren+fpOMdaGZNjQWShqjckF9QnPvbs380D2wkNvHh6tNdsUoSe
         +049zk/bsip9FgGmwg0y5QS6m6e3zbEuc54UqbdPhqfVxEH88bLPZL5kI/6sybM7oSfZ
         xox2P/EZcTOOzFLF75xtkK92fyIyI6pqd31O3uYN78JwE/XbFaCYuOi+Krea2O+pL3V+
         hNUw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784315138; x=1784919938; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XEvDXQmWMeu8eEveSi1MmpQMOZM/nj4kZe9ixSXLOf8=;
        b=llVBTYwXNi9Lg/OZp9KsUW05M6sdyeHSfyJv9uYA2jCFf1P/ZQJwsZxli4uj/KOHjY
         glqo4m3RhjKzva58rVu7pCtZCYnI46MoYUc6nMBcBbM3bUr0fqepRXhlheqsawQEUg0M
         D6SLo6V/r/Z6lE8t+LjL1jlcz3RfQR2uRLEvNQmtpDsdqrqq4Ww7MBKKIyI3aS+NKaIG
         nv+Z1i+ZXSRPni8uHKX77OhVnS17KRhgraK63xeHjZy1ABLdVcGj8Oi7V5HZtkiADmxP
         igsyNWxs2TiB6Pw252kEvTrGTzxTqtaDvTeOJZOZ2danOwtAvHtq1ScwceHDZT8TF54F
         DRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784315138; x=1784919938;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XEvDXQmWMeu8eEveSi1MmpQMOZM/nj4kZe9ixSXLOf8=;
        b=oM6HAaGDCgKgdE3d6XCSADS6HU6Yo2fdEtB6a2yMa9JKvK6KzJ0Pd3R7lf/BhdKf3t
         ax6cn0pNkTSSfLb+c202muUDI4AQM3VzyXXohS0KdWzX1dAL/AGLpZi/bBcwxzVSguUH
         OHJ103mKQ5IORiXDkVZM/GP0P40l7sq8D0D5w0+VfVF6WfQ/p0wg5b/VeTJjgTpvBLK9
         RQkIQgJMKM+dtIrkm4eN3CtIf/i5JuUAepVx2RPTtc4Hcnktg3n2zb5viWncec6AfA7t
         WokJzM8b4sV0n0xh1j6MAG4uBOOi+A3JQ/Mc7+Bm0M4zGvdlEvILYljT9kXPUEbq+d6F
         67Ng==
X-Gm-Message-State: AOJu0YzPjfglImd+UgiGoL674Mt7HgIYlz4DLxbZhdRWB5H9Awst7cLJ
	kk/ccYDEBVQOfC1IkEuPb+GgFvExz5AoTEKDXKZiHut3PdBCE6VU7uagaaUdMIGHQsbzfiXEad1
	HQezVO5UwyRBSl1OWktqMsDOr3DotE4sriA==
X-Gm-Gg: AfdE7cmhQ1t3HImzIdJ7rwU/3UnRBH8ZboI6yZruQd9eeXP1Gx+F8U3T2FHjQJQIaS4
	60Gjt1kTiH//+Hgg/l6TnGyPLXWnhZAggjOgEh2cHj66A42I3LCM9ToiZsJoyvDkp5CAflg9LHc
	ADaRbJ4YcssG8+c30eF/DxMvry6AoyVglt6+O82/gDsmFyyBE6JK1YpS7GjCTkwx9lern0Ork8x
	zUdlGh6MMdsghB1YUAstqD1f+CtHkLfPLLY8Jl9E5eYOYMMKzglzJHYTnKAsD0HSPhOV9fcet7C
	KCFGF/lcwaWdEuK2RK05Uhs8ymrG4cq5Skm8R2jTm2lvCU0e1+Xa/dDnhSpis/zTYy456kGfSX9
	AD5fYP4wsUP78WA/iXY3bk521KHygACQDaaXdgshE4hOAShq9oP81wXE02dqVwrjXhIeuCZY8
X-Received: by 2002:a17:907:709:b0:c16:5a9b:5966 with SMTP id
 a640c23a62f3a-c16b47c50damr185711466b.33.1784315137582; Fri, 17 Jul 2026
 12:05:37 -0700 (PDT)
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
References: <20260517063754.21819-1-rosenp@gmail.com>
In-Reply-To: <20260517063754.21819-1-rosenp@gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 17 Jul 2026 12:05:26 -0700
X-Gm-Features: AUfX_mzHXoMRimM0dIFD_rOhRFAs1JFx_JzthRFqxkg6psmyuSh9tsgt9FdRJLk
Message-ID: <CAKxU2N-i02g0jJaiJ+GzX1iQ8_W=uX0iMpmeNw=0=u-xU7tkLg@mail.gmail.com>
Subject: Re: [PATCHv2] powerpc/44x: Set GPIO chip parent
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 16, 2026 at 11:38=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wro=
te:
>
> The PPC4xx GPIO driver stopped assigning an explicit parent
> to the gpio_chip when it moved away from of_mm_gpiochip_add_data().
>
> Restore that association from the platform device so OF GPIO lookup
> can match phandles to the registered gpiochip.
>
> Tested on: Cisco MX60W. No more probe deferral.
>
> Assisted-by: Codex:GPT-5.5
> Fixes: 1044dbaf2a77 ("powerpc/44x: Change GPIO driver to a proper platfor=
m driver")
Did I forget to ping someone?
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  arch/powerpc/platforms/44x/gpio.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/platforms/44x/gpio.c b/arch/powerpc/platforms/4=
4x/gpio.c
> index aea0d913b59d..4413a94cf7a6 100644
> --- a/arch/powerpc/platforms/44x/gpio.c
> +++ b/arch/powerpc/platforms/44x/gpio.c
> @@ -169,6 +169,7 @@ static int ppc4xx_gpio_probe(struct platform_device *=
ofdev)
>
>         gc =3D &chip->gc;
>
> +       gc->parent =3D dev;
>         gc->base =3D -1;
>         gc->ngpio =3D 32;
>         gc->direction_input =3D ppc4xx_gpio_dir_in;
> --
> 2.54.0
>

