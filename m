Return-Path: <linuxppc-dev+bounces-20056-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB16FE51EE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 09:14:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g26jV44Gwz2xwH;
	Fri, 24 Apr 2026 19:14:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::434"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777022078;
	cv=none; b=fN8K1/CHYGsqrij8MEQxJFYyvqAQyuGL2mKbGTBEh0OHzBo8o2sZ05SqwCzClgJVrBftrEnQHwfntR661dEny08d4u76Pmrwj7octCnPliwVG1qHrG2MDEPy0gblHbbZT3y8vqCLsWcPFLdM1eJMLq6fiJnzi634uDWErV1y86I5Z1YE4oeKoYQfdanqvPuONrLB6iYzNQQcmQVld1mwu12iwrl5gpbe3gWlInnZanZouW3qpb+52HkeY7NNpa+F47Vk1VFsmoJXZqMuvM2/0fP8gVajVAWzpvfXqesHosFd3SQfOpiBm7Jz1+j8u4AxCQcssUjIoHBBqqU9h59rGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777022078; c=relaxed/relaxed;
	bh=nSmDvRkfSjghcrtIGnXq0grda+xm9HI4mnGbjcUNF0k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kLakb6KrTuxdaSboH4d+GRw2IBMsNYWzYARixasUEuDoih1cd4fi8ViG3XnqiOzLIxEYUK6kNxbqRCBpHejyX9iSIzW+nPLn7hBpk8nd6Co2gQBvrja7lthcQ3UVR7/HOXvtiM02+mwGxZiy+ns68z/PawtRFtyab+U6e6xyORztvg8BhnsXv8rYJHn5JUfcLas5K3owT1+jP/1oqJjjw2XUfpzaR9ZkLgGBzdwd0pqo0CO3nlUf0kl3e52+x+lMS8Sy7ZZ4oDrFBob5s6pjXOurW/fT7odeMkSENkKm7yUIzVTTMrnm8jPX1yLetpKRuAO99WRzQBFxVK9P64b76g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mPgz/ZEs; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mPgz/ZEs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g26jS317xz2xZK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 19:14:35 +1000 (AEST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-43cf7683a28so5159024f8f.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 02:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777022070; x=1777626870; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSmDvRkfSjghcrtIGnXq0grda+xm9HI4mnGbjcUNF0k=;
        b=mPgz/ZEs+nWYItr8pmTClOGcrlFyjBzT3l7f1u/HikWfpeXKdFOzrWtfQhKNpKt2VX
         nIaIxAktDC5+DbCmSWULVezrNHN315wddcW7DvwWnBK2bgQrcc7i3tNw05NDWr9n2y8y
         wnYvC8PUsY6eNnIEuDETbaP2BPFJgfuW7LAEH5MlaKBJ2y8fFson3tQ/F2Fe1POWvtX3
         9mc+HvFQPn7+iZ47bcVt6i9VHu5GyErKZm8W6nceNPPeHDxq1Dx9C5QtgOVTz/BfhVVj
         AcnRXMEPmE9RCwcYYyzCFLD8yyypb5b68dysPVKqD4LU1rcjxsMfc9/WlD/ZdJwJplHa
         RsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777022070; x=1777626870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nSmDvRkfSjghcrtIGnXq0grda+xm9HI4mnGbjcUNF0k=;
        b=BqOz1A6gZHlpFdD1hG6U0s8gCMJmG3jPysAg+h9U9WyufGmbBdt8GA+XjZAUjjYXI2
         KC8VYa/3M1ayZ7UoM4g113ORwbEMpFaqkoCbf1yqNmdf7EBW/gmShM3TprrNwX/3tV+b
         yElmYrMWmd6qDt4CFtoBdw7KkpQ3mEujC1f2qf0HCM9Fi0tBB/AEHq+GoLyxuoy5rrP2
         8oqLpXDyIGyJc578qYgACHKhSThEjbZqGxOzs9GlWaPD6FZeLY8S1yQ2e4f/H1N/FIic
         DxyjoumNzV6x7sH22ofIUMvp7pkULrXXbhPp4vRknCsYDb5CwwwkaxdmCGrWUhOZ0suf
         MzLw==
X-Forwarded-Encrypted: i=1; AFNElJ82Dzr+RrB5JakNkkZGWZvhhqdzP2qsPLpCnm7Ayll3A0U+BNsuXZoN1NBLPqbRemPkgARamggIhGxARnE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwGN2wSYb0HzSNWa2+tjrgLuoiR2x8TX3RGvxMPCT+o5nJ6w1jD
	R0lGllYkmfSZd3REMwxFBrG1+zQl1eyFZMetuBINj4U9efT5J5UAxtBz
X-Gm-Gg: AeBDiev7Mf3ZfAxl9gBD672tErg1Tzn7xPdyQb7bgXTN/7fX+GPrKRMdo2tIiLZBcMc
	IxRI1luB7+DvcUhdgpraxYg806pjuDA7fG6CyD/5JUATkKkQ6DonryFIJAI/kdTa6n7MY9ExmNb
	PYUCBdPvIx72P9kyMCu+RWYsjuiDFimKPZvHwupKsKgsyJeWpdbfSjTFN3D6P3lZ7eWYoTnayej
	DvPvTXvP3Qx0vUZ9LuGyNFT4VIIB3BliULJpjSuswAL2w7m9qO9P2Bqxk3+E2mfJ7AnkRuTsVwh
	12hxBc+p4vWXsz7kcg0Qndvi4GsZLLglyqC05P9sP0X9UP6o8EPH3wqUvi6+R0NWA1lLA4rVyFH
	HtZXWnVCfIyzSO+zMiQrSFFjTyeJFKUxwd8kdSi1yVU69krboyDuEEKvcNqoJ2OJHNh5EIVWbOq
	DDs2LUQwpQOE8r0azcddvKuXCGu4vvCw64vPd2NourP6oxnDVAr63A5uHo1DvCsxoBsovVqIXcQ
	n8=
X-Received: by 2002:a5d:5f84:0:b0:43d:7783:c684 with SMTP id ffacd0b85a97d-43fe3e1e092mr49352860f8f.43.1777022067498;
        Fri, 24 Apr 2026 02:14:27 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4412150a092sm23750898f8f.23.2026.04.24.02.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 02:14:27 -0700 (PDT)
Date: Fri, 24 Apr 2026 10:14:25 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
 jbaron@akamai.com, aliceryhl@google.com, rostedt@goodmis.org,
 ardb@kernel.org, sumit.semwal@linaro.org, christian.koenig@amd.com,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org,
 nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com,
 tamird@kernel.org, arnd@arndb.de, nsc@kernel.org, simona.vetter@ffwll.ch,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, rust-for-linux@vger.kernel.org,
 llvm@lists.linux.dev, Link Mauve <linkmauve@linkmauve.fr>
Subject: Re: [PATCH V13 5/7] rust: Make __udivdi3() and __umoddi3() panic
Message-ID: <20260424101425.6bde0e17@pumpkin>
In-Reply-To: <20260424054742.45832-6-mkchauras@gmail.com>
References: <20260424054742.45832-1-mkchauras@gmail.com>
	<20260424054742.45832-6-mkchauras@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Apr 2026 11:17:40 +0530
"Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com> wrote:

> From: Link Mauve <linkmauve@linkmauve.fr>
>=20
> The core crate currently depends on these two functions for i64/u64/
> i128/u128/core::time::Duration formatting, but we shouldn=E2=80=99t use t=
hat in
> the kernel so let=E2=80=99s panic if they are ever called.

Ugg.
Surely you can make it a link-time failure?
Or change the underlying code to avoid the divide.

	David

>=20
> This doesn=E2=80=99t yet fix drm_panic_qr.rs, which also uses __udivdi3 w=
hen
> CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy, but at least makes the rest of the kernel
> build on PPC32.
>=20
> Signed-off-by: Link Mauve <linkmauve@linkmauve.fr>
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> ---
>  rust/Makefile             | 4 ++++
>  rust/compiler_builtins.rs | 6 ++++++
>  2 files changed, 10 insertions(+)
>=20
> diff --git a/rust/Makefile b/rust/Makefile
> index 2a5428a5503d..ee11fba7a03d 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -616,6 +616,10 @@ ifneq ($(or $(CONFIG_ARM64),$(and $(CONFIG_RISCV),$(=
CONFIG_64BIT))),)
>  		__ashrti3 \
>  		__ashlti3 __lshrti3
>  endif
> +ifdef CONFIG_PPC32
> +	redirect-intrinsics +=3D \
> +		__udivdi3 __umoddi3
> +endif
> =20
>  ifdef CONFIG_MODVERSIONS
>  cmd_gendwarfksyms =3D $(if $(skip_gendwarfksyms),, \
> diff --git a/rust/compiler_builtins.rs b/rust/compiler_builtins.rs
> index dd16c1dc899c..fc6b54636dd5 100644
> --- a/rust/compiler_builtins.rs
> +++ b/rust/compiler_builtins.rs
> @@ -97,5 +97,11 @@ pub extern "C" fn $ident() {
>      __aeabi_uldivmod,
>  });
> =20
> +#[cfg(target_arch =3D "powerpc")]
> +define_panicking_intrinsics!("`u64` division/modulo should not be used",=
 {
> +    __udivdi3,
> +    __umoddi3,
> +});
> +
>  // NOTE: if you are adding a new intrinsic here, you should also add it =
to
>  // `redirect-intrinsics` in `rust/Makefile`.


