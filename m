Return-Path: <linuxppc-dev+bounces-19325-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E7AE63FFB
	for <linuxppc-dev@archiver.kernel.org>; Sat,  4 Apr 2026 21:04:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fp7Pj21j3z2ykf;
	Sun, 05 Apr 2026 07:04:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::132a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775336665;
	cv=pass; b=NDRQO1tfRbkxYroFhoo6/GbFP6SlQnSqFp0kJs1KmiMH85A74VyCY6bL00HK2AHWj5O0RSls40ArcEyyW9R2/64v/fndK1hH/6RnhdpV7/XaWnVYGRsgeX5KfSPX9MQLanHSNyWMzi75Dnvv2WVR2uL4uk7vuLQFsiwc7hSjuHSVJyc3IV77mARHcLduBDaumCENYbn9jBBaR3rjHhRLwaBHnrDZqZ3FLhizaloPUdYk0sRE5UT6ulI5zN/yWkgfvnrxxo+dGT5HVW78IkPj6WTF4S/TGS+c0pzw9aBiYqVQhw9ZpOv9fm80uXA+rUH33isAuj1qy1iEunKCBd8GQQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775336665; c=relaxed/relaxed;
	bh=cYhFiwqA+wDjtVVMvyF4BuvxXVvpM8t3h/p4jRxczq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fODMkJNTR5DTsH9kR0xXnY6XbG8N4dByVsVEHqhzQ7m75pRUM7IINkhW2j5KpIIq1bvTo1WahvF1bi4w2KR1GEWNkfUqMrvbEJ0drMGuLu+7e4Ae6gP6Lw2WPr2NgxjFtEl/dViYYfQtitG0ghLqZ05SX7DV5zLfGKIz0Pmw65qSdWzpqyDD3Wrp2wGMaUeAPZ67Pc/vq56poqjnYpHshKPblagLz8WFY96nTVt1jfyJI9aCO1daUSpFSw+4shcQY9nQYw/S+UfHorjGZ5/PJE7sQkhX4omlJAn/j6PbVsLP6SPwEQzqJdszBbD9GgPqXBrB7XpHP1L7EXP2vVGilA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lRFT2Xi+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lRFT2Xi+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132a.google.com (mail-dy1-x132a.google.com [IPv6:2607:f8b0:4864:20::132a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fp7Ph10ltz2yjx
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 07:04:23 +1000 (AEST)
Received: by mail-dy1-x132a.google.com with SMTP id 5a478bee46e88-2cdf546f956so25055eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 14:04:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775336660; cv=none;
        d=google.com; s=arc-20240605;
        b=RVpR0iwA8Fr147IwM2l5OFevVQsy+p6mlYNT2TefqbjnIK9yOiIxJRuCj2Adi1HfC+
         H8OKvsvX9W0g1kk3W296W/S4hSwlm30gDsYVxoe2ipLPtFqRZUHFT+J1pnP3VCZyFvW1
         SWKaiq5ONmm5Vq7sFwOTqrjXtMdPEjPb+j2GBZ59AiJMmL6LnrfjFTlkSACMq8i/g5Y/
         DuSTfysobOA5p1Qh51ixNbYm5aE6FCTSpYq6ZAskFiFb8sojZEQbC4kfis2twwnLyWC/
         lGrY4fy23H1Spf0WPne6Ijgi4z1N7UtrFP6u4ZakrGh499zu/sT5kQxbvDfngKtAortn
         Olwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cYhFiwqA+wDjtVVMvyF4BuvxXVvpM8t3h/p4jRxczq8=;
        fh=3h+Ghpi7Pz54gqmk/ZbyBlPGoeFbWaExgzlWi7zI/g0=;
        b=bZK7jE7FTDkYPa8t2FdHp4fBU19yEsHu/mEXvQ1vBKbfABAR2qK33OC3tOzUV2cJAY
         KncB390rP2UehnwIHEt/mFm6gz6oIKA7+eaOkn4OH8NxO8XlfTUnm3+QFid3gn5/WGi2
         khB2x7I9OtF9EqAsXVcV6J9MlmHSg/MsVlhRZimDCGfmD4ydo5+tlyregubfkKlNYVW8
         y20mZS9/Jk+4CHhUQvqu+k4DZ8i/GTIyqLBab2gImLS+6The9zSLqDUbDXNlAGSMab5t
         1SCN8iHd3uZfse7A3ATlMSLSHrZ6Rlf4pqHUOgLdlHW5/4u9VgKQBqRozAeH8j+u0Dtp
         UvaQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775336660; x=1775941460; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYhFiwqA+wDjtVVMvyF4BuvxXVvpM8t3h/p4jRxczq8=;
        b=lRFT2Xi+GOjpQcOJnrjO4kKKLQmv23K8Th5pm4mryMjSjgrYp8nexQ4snhbobpnWHR
         lhb7E7Eno7EuGRLwPYqLHsv9Nv1357Ifccv+u9pAKfskXwbbxHhSR61u6Qi/x4Ox1iK+
         Axi1OxyoZxm2P46oBUJmSdinz/3hXbxdxe5pgmg7Upq2789anKHYeMG29yvb0m+qadI2
         smR7HDHCoWm8NnfKoIUxvd1LfBFM7rVt2WfTZ+AG2S8febX/WZBOHgbwPzAfysMg/CAm
         52tfPy8yxR6ThKJnMr4Hi2FfDpHMNXNxMd39EoHIFGYXW4MZe5DSBqVI/uW/i7QBVvwV
         NzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775336660; x=1775941460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cYhFiwqA+wDjtVVMvyF4BuvxXVvpM8t3h/p4jRxczq8=;
        b=B1YI1nr5z03pdjTRIkFVnHpFRAD7odIyPHj6xSnFLuFyjcHGQyN+kQZiR3gK/qzz1s
         OZo3ZpE2NoSg/JvdSjNJEajiaGQLq7aRUC9Gq/YngpujxqxAmPzcDFyjF4Cm4a4KbZ7m
         B7DNwsfwtRHCRwQ11/wckKQH31xzk+Pxn00R6Kgf2Hfl5CPpgT+n7AQ2HVwjBHEfl2+P
         rGg3OSCGG+16OTCUQ9DN/2qKqERRVNQorARlFYfFdX5Ra6/ycqDEBUa7sFCDX6ADY/Sg
         vORS6LpWRfUh1JO/0OMeYQdKZBeNP+yGlOnZndIoCETpoHU4duMRx/i3armuj51tNDy4
         GjHw==
X-Forwarded-Encrypted: i=1; AJvYcCXOewoSr+g43jcT42RwLFg2wBOVmNyyu8PsZHZy4ja4ZCV8NGibZsOaqNB4K3Tx+jTOOpciJVgG8OY1t2Y=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy7jIsn7dGTSRLSi/sQ9T/bq66BmLHZwaG7Dy81eeAmW2gv1+LX
	IgcdIvalqTn3WUcQWdl26jkhutqdbp/BY7+XES67BDNcjkPBpxgm89tTZ7bW6k1+ULZWgvi0xOA
	VajKkfUkliii3ZxVcdVS0O9sCLCSzv+s=
X-Gm-Gg: AeBDietQ/6Twv5B8k8lRephfchnj5jp+J5cTWVFgll312FpxIQSwzkRpynUPC107D+p
	NHG05Cz8VNBcxNUzDrmikQboSMP/b3XXQ/rILTUYbfgXNqlAbBYS9qYdWIVZLKOxP2U45pzEXhH
	3OyCg40/scskEvTgA0EqxaTjuD170UvDE1I1rLVRA3YUZx9GNYrPcNRMVvr/0fz4IrfiJAli0MN
	Rapx2j8vObyZUDjQ8PqjgKOsE005Y9i8yzrqwfEPGRY/vp9hY2Yr0ndgSZfMoa1YKc31gM1SuBz
	gRJzJrXwxfUIrjwysTm5hbSa1b4u7DdxJgQdxRcBH6MHgcdcE2yT96LpFRK+Cbh4aA891TrtNhH
	tz3ZuhsyAEwTZxR5TmMX3SMn2kKILqHkyNw==
X-Received: by 2002:a05:7300:8623:b0:2c7:8e1c:956b with SMTP id
 5a478bee46e88-2cbfc16eba8mr1628403eec.4.1775336660175; Sat, 04 Apr 2026
 14:04:20 -0700 (PDT)
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
References: <20260404121610.1956528-1-mkchauras@gmail.com> <20260404121610.1956528-2-mkchauras@gmail.com>
In-Reply-To: <20260404121610.1956528-2-mkchauras@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 4 Apr 2026 23:04:08 +0200
X-Gm-Features: AQROBzCMgLHa7cowntiZYSKVuRyKGh1fP2Cda-tJiBMZoAlSB8e92ElsqLSq1yE
Message-ID: <CANiq72k1KN68wG_dh0GcTyfiXUyrVUErJ5D8AOaV6z6=sX4BAg@mail.gmail.com>
Subject: Re: [PATCH V9 1/4] rust: Fix "multiple candidates for rmeta
 dependency core" error
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, 
	jbaron@akamai.com, aliceryhl@google.com, rostedt@goodmis.org, ardb@kernel.org, 
	ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 4, 2026 at 2:16=E2=80=AFPM Mukesh Kumar Chaurasiya (IBM)
<mkchauras@gmail.com> wrote:
>
> When building Rust code with LLVM=3D1 with -j1, rustc was encountering
> an error:
> "multiple candidates for `rmeta` dependency `core` found", with two
> candidates:
> 1. The host's standard library from the rustup toolchain
> 2. The kernel's custom libcore.rmeta in the rust/ directory

Please clarify in what conditions this happens, e.g. when building
natively in an architecture like powerpc for which the target (...)

Otherwise, it sounds like this is something that would be happening to
essentially everyone just by building with `-j1`, which is not the
case.

Also, since you may need to reword a bit, please take the chance to
use the present tense to describe the current state, and then the
imperative for what is changed. (The past is usually used for
something that already changed in the past, not for something that
still happens before the patch is applied -- I hope that makes sense).

> - Update rustdoc-pin_init to use explicit --extern paths for proc macros
>   as pin-init also needs alloc crate from -L$(objtree)/rust. So the proc
>   macros needs an absolute path

As Gary mentioned, this list may be too exhaustive, i.e. one needs to
see it in the diff anyway. Usually what we do is try to summarize, and
most importantly, explain the "why".

Also, it doesn't seem like the list covers every change anyway if that
was the intention, e.g. the removal of `--out-dir`.

> -rustdoc-quote: private rustc_target_flags =3D $(quote-flags)
> +rustdoc-quote: private rustc_target_flags =3D $(quote-flags) \
> +    --extern proc_macro2

Hmm... why is this needed? The variable already carries the flag, no?

> -               --out-dir $(objtree)/$(obj) -L$(objtree)/$(obj) \

This looks like an important removal that is not explained/mentioned elsewh=
ere.

Also, is there a reason why we cannot keep the `-L` here instead of
adding it in every proc macro library?

> +    --extern pin_init_internal=3D$(abspath $(objtree)/$(obj)/$(libpin_in=
it_internal_name)) \
> +    --extern macros=3D$(abspath $(objtree)/$(obj)/$(libmacros_name)) \
> +    $(call cfgs-to-flags,$(pin_init-cfgs)) \

Hmm... This special handling isn't great, and the fact that it means
hardcoding/duplicating `pin_init-flags`.

Should we move the proc macros too?

> -               --crate-type proc-macro -L$(objtree)/$(obj) \
> +               --crate-type proc-macro \
> +               -L$(objtree)/$(obj)/host \

Spurious newline added?

> -               @$(objtree)/include/generated/rustc_cfg $<
> +               @$(objtree)/include/generated/rustc_cfg \
> +               $(rustc_target_flags) \
> +               $<

Why is the variable moved here?

Thanks!

Cheers,
Miguel

