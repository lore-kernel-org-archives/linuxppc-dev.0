Return-Path: <linuxppc-dev+bounces-20129-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D058FF885C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Apr 2026 11:49:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3Q3F0TSVz2ygY;
	Sun, 26 Apr 2026 21:49:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777204168;
	cv=none; b=c0Ze4HAYJoxhKMI1W4WjX2iNUl//ujkr2+14AcKqvh4RVG5bOtzFAdHE+xSRpadStRw8Sl3tu6T4Dgl1AtaWGp6uW2TCJQZJfoPIliPaeDo2KTibb3O8LHaAXXVOXDcMjk2Z23mLLLZ0AezOP1mLTG1oVCS5EFDsrdm5uDUdpZmTSQvBdO2lg9gr9n3gkRQsiD/EM0vTaw13pjb3KsCqChzTZV+qWatWgey3fuutuI6CtFFtxQn2M/20vdvffmX8M/XsJ7/0ViRXzS7+B1I/nzFvYQo02QinQ2dwo89AvHgQ6Evi4hibKejzFJEKaqBQegEVceFnzxj2yX46ulJNeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777204168; c=relaxed/relaxed;
	bh=IywXIO5DH2wY+7oMRMtv2QIoyGhfedV6T5nXUSTMOdE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZyLrzUhHOOxLmnfGBcysT5sZp6rtxqvsPPLeYR3uqL+3CLju5PaPB+DHLqHMibg1FeFo7D+CsdqniRf7UIdIAVnVFUlJlrFA2HaiW8bjfCrWmcoV1lg+ApoZqrdgphKa3f6RDBGf/oMHj3gn//GdcEvxCbE4NARUXsfkzMTwQBh4aw4YxM4mlcaUFJYY61Y8NwN0LGmW9R652EYnFm+DRK0/n1dvQvJWjbhzma1Jf+STkXnPBtKigGv89+7KnwJM92e65peykKB+kzarcsQKQbBW2gzKuX5m0jhzZ7g7Eg8RIWkHqDG2iDo7AGoZsQ9E6ftMaDtoNu8j/dkIIFFcqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=A2/TSrH4; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=A2/TSrH4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3Q3C5vRyz2ySV
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 21:49:27 +1000 (AEST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso130616905e9.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 04:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777204164; x=1777808964; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IywXIO5DH2wY+7oMRMtv2QIoyGhfedV6T5nXUSTMOdE=;
        b=A2/TSrH4+AsNZ7cNKS1Lcvq/e09BksnNZ2vXKxqatiEcUufS7QqnJ0N5mL9xbJ5i6k
         N4azEFFJjsJrKDW7gkZjS1tWReeu8tf9jnA+UdFLsJX/GCZggpz4GdRZc/ZmVGWqCwsn
         GK68NHnAf8wkU1C7vFy45rRY/eGjplKZeiBUOkRKzqkikYvBldT3SvbDIWIP0DCYRogJ
         cwPc2wzmTME63UTlpBtrqsv40vtlif8K+yv+C466ZMvxFCo1mmS3vvuLT9XT/gx7obCT
         +ZqCzULfntkkc9IsiKjP0swftlP8wL37iOrBtjX5veREAZg2ff/sIQRJqrkxSZHWfvqk
         zINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777204164; x=1777808964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IywXIO5DH2wY+7oMRMtv2QIoyGhfedV6T5nXUSTMOdE=;
        b=JLoFn3Z43BjERIlme0s0n9lpdsN9SGgcHqt7/eY4LOkKcBci3czsaYfdxbhUs3tj/1
         hvOpsVQ9r62Lc5jRlvQQNCjQLI1KaA457NesPjNRJcf+5iWL09h5GEd2IXE9wAfxypnK
         Qyy8VrEKdJV78Hq6w7dcWHhWQ5wWa5baBUpzGq8AsSfRsr+bz6cHEsKNOB0ALWp2hnQH
         GIhJm1Z7PmWoj+1Q2ETH6T1BqR8aSXrL0+IRwnJUa8LiNmMh1ptUgIS3lQtl3c0jSCoA
         R4zIYaHcATn1SJxF2d/SjOTiM/gp0V3Q3+RQfevnBO98GkoReG8ASh5kzHgH1sFY93KS
         50Eg==
X-Forwarded-Encrypted: i=1; AFNElJ+QjUb4p+OIqmDmVDjz6QlEf+s5QVWnhOew4Uvh8smtw2wPAVcF8TC98oV2EE+bZlJzH5HiXi5rdp9J/oE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyxNsb+OEELhIzGgWwvaKI3Q/Kfey/txax4kt+fhpQS3rmumi7B
	9sWyNpn7Bw+h8CC2Na9cda0BhZU9K+UFWUAi5f9UTqXGJcsUKZBjWA+Z
X-Gm-Gg: AeBDies6b3WkNAfTi2J9ifFvbL+6dCvFNQmbfjW1WAtKEjMOnP223vts6f4qu/Lusqw
	OxIA2YnE/lULsAreSfB3BIzdmKSWnGPuHew2jmNGQT44rVvaEqlT4/jICXMLmtiSZ6V6mONy1PB
	LtirKf2SP1+Rw23E1YW0zerL5ga6WQxBYg2uQTbbG+2KvC+Oy+zULpVr2Afz4AvPiw9fdOAhrB3
	Ih7dGlSkmYgaV1UxRfkPB4Hz/a6yMISISViG8wT6KpA/pH9iUtEgGkUODcEmCvdNbRhwiKez17O
	RKk5EAuBUFjtEimuFoHknmuNQxscdRgzEUZDCEPcRufU0gwlvRrlHub89KVLDcNo+YFrsaQMitA
	LKLR2SEfDIbBBQSIu/onW2+Hp8+fNYWHjgm4gwHrLkGrKnw1M6lv2fcF6j3Euhq+HZg3eCasCVl
	Gk1m8rjZyf6lNpCN5B6Cir5ti82xqb+xwb7ju+rOfztn0TNgtPRxohNaczBjrVik3F+lZcnPqQ/
	AE=
X-Received: by 2002:a05:600c:64c7:b0:488:a2ac:a334 with SMTP id 5b1f17b1804b1-488fb73aa3bmr565343015e9.3.1777204163630;
        Sun, 26 Apr 2026 04:49:23 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb754842sm222683295e9.8.2026.04.26.04.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 04:49:23 -0700 (PDT)
Date: Sun, 26 Apr 2026 12:49:21 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
 jbaron@akamai.com, aliceryhl@google.com, rostedt@goodmis.org,
 ardb@kernel.org, ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org,
 nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com,
 daniel.almeida@collabora.com, fujita.tomonori@gmail.com,
 viresh.kumar@linaro.org, prafulrai522@gmail.com,
 gregkh@linuxfoundation.org, arnd@arndb.de, tamird@kernel.org,
 lyude@redhat.com, airlied@gmail.com, j@jannau.net,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, llvm@lists.linux.dev, Link Mauve
 <linkmauve@linkmauve.fr>
Subject: Re: [PATCH V14 5/7] rust: Make __udivdi3() and __umoddi3() panic
Message-ID: <20260426124921.28eb433f@pumpkin>
In-Reply-To: <20260426085725.2090827-6-mkchauras@gmail.com>
References: <20260426085725.2090827-1-mkchauras@gmail.com>
	<20260426085725.2090827-6-mkchauras@gmail.com>
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

On Sun, 26 Apr 2026 14:27:23 +0530
"Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com> wrote:

> From: Link Mauve <linkmauve@linkmauve.fr>
>=20
> The core crate currently depends on these two functions for i64/u64/
> i128/u128/core::time::Duration formatting, but we shouldn=E2=80=99t use t=
hat in
> the kernel so let=E2=80=99s panic if they are ever called.
>=20
> This doesn=E2=80=99t yet fix drm_panic_qr.rs, which also uses __udivdi3 w=
hen
> CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy, but at least makes the rest of the kernel
> build on PPC32.

This needs resolving properly.

>=20
> Signed-off-by: Link Mauve <linkmauve@linkmauve.fr>
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> ---
>  rust/Makefile             | 4 ++++
>  rust/compiler_builtins.rs | 6 ++++++
>  2 files changed, 10 insertions(+)
>=20
> diff --git a/rust/Makefile b/rust/Makefile
> index f6369d121c50..9aa18cff2fae 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -615,6 +615,10 @@ ifneq ($(or $(CONFIG_ARM64),$(and $(CONFIG_RISCV),$(=
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


