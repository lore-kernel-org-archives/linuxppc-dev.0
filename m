Return-Path: <linuxppc-dev+bounces-22022-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF141CD6E57
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 09:37:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWKGr1ShJz2y1Y;
	Thu, 04 Jun 2026 19:37:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::42c" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780565844;
	cv=pass; b=cLPBLJjK/IdhIIzQZnH90aBHEyG7w13qb/xdJzW8kB/LY9S8rUj2IPpt8ZOLazHf7fhM9dwxBPA3NyudwrpJEOw6OIe6lGfeJMZ99nV1ePRKnu6jSY+TqQtE3btGG8/Ep9TRPyj2HZmM3vwXgHf1PAiAp75zu9sVYbwfB22LhFQ2RbJjXGkwKfHx5KhL7k0h3kFLoaSUNyUHnQ2g7b6U7VucXIQYMu/xJShnOoViQBFnsA7260kbM81x9SG8u0LcmISBoxj/tVmO608nmbJQOlwEUP6p5zRDLnbBDOmrSnyI2km0o01E2yV0MEMQRhjA5qOZ8Xca2Y5hehCyHRCadQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780565844; c=relaxed/relaxed;
	bh=WAE5dsUcOf+50j6c1n0GmreYE4E4GrWSX2T6ZZrsAus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AZLVBBRXTZI/yIy6SrFGjzjmuRjmzs/esMq77Z0/aUI30THPC9/ZNyYLuBv1l63h1B+G2NkNwxHscamkD7mpvFZvOXX+mdrQ+1QuL0NhRs6I+CGdJJeJfRjkmWP3KcX8qBIlZAXbc3FMNq0PKgcmOfOsm4c1y62j1htVotk6hjKuRosgmyQQOCub430/mHO3uwNVrE1SjItvJ0EbSLFv9AiTrWWk1bxkDWSAgS5vX7lcxCl8eGZK5BFHftQ8FQm+e+Wwr7Z3/BSPkZ8keBlQAfeydWrojwW6eVO2c8uI/MkYGugIyEM47UadrpDMxtRPf+vi0/VW1GRJxPKISeafag==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aslWqwwg; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aslWqwwg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWKGq1z2Zz2xHF
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 19:37:22 +1000 (AEST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-8423efd76c8so348003b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 02:37:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780565839; cv=none;
        d=google.com; s=arc-20240605;
        b=SjdWYltoqZ5GkD8GrNUJLgX7OhDxS9lVX28Uz3m98IJP/JxqCpmSbymzlNZ/mDLH5u
         pyUa0Qll6aYX2hTXvWtjoLSxJV0PWc8lqrAMr6wPBHc92JG7Sa04hP0HUM8K0qMiSYfJ
         lL8G+Me6LNyWInXWGxdv2gTVJcHufl3NOJkiS7Uvd66+khfnWRaSunvaT12z2Ma+0U3Y
         8AaAKsA7kysJj7mEuURbidAavm9TaX6bp4dNGuHr/xEfl7iEAwnadkfef5vyWp3MHM/y
         I5/BjOTFT6SxD5aSQPgqaOe1h8PMecoGZoL7u9fvUaqZNRuZlYYFegkhAYE3l/R+uqAQ
         ECRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WAE5dsUcOf+50j6c1n0GmreYE4E4GrWSX2T6ZZrsAus=;
        fh=hRmWoR7kI/EAnl+3auN0U0KFI7Hhe7h4P5pGRsNsjos=;
        b=ScE2BgbdVlZ3iUTpdtE+BljGwnBUe4Z1nlTIpPAoCmcUZJVDBj01qY7FIwBILw3ArP
         dqQxoRA/zzmbCjdhfg/EwjaY/BfOwpx1oMEvcjhUhe9cTWd044GbUf+VVaHod7H7DmvB
         eoYtex3oz3OzFSlqOzlGSoQ+f5e5oly5NIja8nQ0KdyARnt6v48orJSWNfxkhFisNq8n
         S88xyAJD7XOnsIRRiBWgpaOlXMb99yAfEykLk/7mAy9arns87c7l7+lL3Lc891p+XOTB
         tINr6Inq05Lw4nHNqs/i1da+6vKOme0i3zhrDJMX7Uxtiydsfsv4rvxo9DVOWN6eX9jx
         vDfQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780565839; x=1781170639; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAE5dsUcOf+50j6c1n0GmreYE4E4GrWSX2T6ZZrsAus=;
        b=aslWqwwgYZgmS+22zaxcpwk1SUiPbZNv9oh6EpFXLtkvutKBaU3khC8b3v3suk8IN4
         dnZkZQzdee3D+Qfp+iEco/V36ScQYykwmOyRY/NpkK1e2zaYqfr9XtF+sWWkH6Qcuzef
         WJ3+wEJ2uR+P6aoYoBCmo3QaYqgGrgvp0+ugTWVnMzeafxKCdYBlRjejTN9qYO9HZF3V
         VyZ7CxDiFAs2DpaYMbGcJbSCt5Vy9vCgOSZhOHeRJ5zAiVd05NcdpruJ6dN//Yg+lvpS
         q8qhZSejKjnf+HGEex4y0WiYvSL17xtq4Oxnme/jeOM3bBsesEHFWc7hA/f1yqJjUWa0
         fYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780565839; x=1781170639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WAE5dsUcOf+50j6c1n0GmreYE4E4GrWSX2T6ZZrsAus=;
        b=mUp6tn1fMibJPzEE8KfrTiB5sj4izv+2op0K1rXBXy7s3+hA/33zVDV8Qhx5cZAXHH
         7+PxOE4QCJ3j1RjfRDtWU6GyyIqDSUJkXpDwoq7TKKRlnF0nuoxD/f2Q2rlw6r11Fi45
         rfnklp24vp3GbuVo98Pnrhxwgkd/Jtr7z7ORI8fEYtWUYBPXuUiTnjfptatvFVJm+uiu
         j0CXOTSZOwrFNm2zZNVg7LZ4DlhESjKEthP6FOY9MQLfcdUNSptXV4M4MmC2G0GMOLUx
         KDUDWC5dL6RONkVn1ZTqhsJhzvmuqg9H17EctX/L5iI0eCUbWoaCvZsZkVcoE6/3agjm
         3Uxw==
X-Forwarded-Encrypted: i=1; AFNElJ8VRPQz1QcHkgXMT7M+zMl4eAWzq1guXekhaR1Kdvq7d0nJKPTWxUxVTYh/c5pDPpy6VbDjAAsXjqHg0ak=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxPYmThxFyy9BUWNDneBdIIDx7ovz9SY54b/xC0S7BYC8UOQaej
	jAFsyNXLxwfI5bV4+imjojd5YZwrKvgAUXQB8DeixIla5H5wpLsduQYoh6IrXxln8Wv137eplG6
	uyKFVXf6q28iTSXAh3jPHg0Z9iqXBSWM=
X-Gm-Gg: Acq92OGvVWTVkGAqx2dpu1ifEnJ9p7bRXa/AO7RjAGGCtVXz1Igx/SIeGxolvkO5jEM
	hKI3EqiauHruo/I6mJZLwA3lyxTCQrSrHkduo05BZCEHaaliJjIIVPflDmBmJ4hXikTZtIu/d77
	K5ie7XdlrDsUEk5Tip0wCIk8Xiap0lQcau8YKo/+c15D5cYij/VWDLNvMD7DJRfyqtmjZO1t8D7
	ARxbtP66z0wK5WuPe/iJz4UxoRJKEVsLI4vB6Ta1iDExgAgKqEYjNpZ/pDOEVtQSkXmZ6kVSKLz
	i3zTvsyuc5efFxT7Ww==
X-Received: by 2002:a05:6a00:4191:b0:842:65f8:bb3a with SMTP id
 d2e1a72fcca58-84284dc1e20mr7432079b3a.19.1780565839303; Thu, 04 Jun 2026
 02:37:19 -0700 (PDT)
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
References: <20260601083327.1535185-1-chancel.liu@oss.nxp.com>
In-Reply-To: <20260601083327.1535185-1-chancel.liu@oss.nxp.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Thu, 4 Jun 2026 17:37:07 +0800
X-Gm-Features: AVHnY4K0i1x-lAIE5B37fSqEfd9RBkopGxh1S9hjIVvMEyOSCUjsLJScERtWN3E
Message-ID: <CAA+D8AMEv4++ZC_xgXxiLrWWBmJS2Xo10Bj9pboDQ3mFh9STfw@mail.gmail.com>
Subject: Re: [PATCH v3] ASoC: fsl_sai: Fix 32 slots TDM broken by integer
 shift UB in xMR write
To: chancel.liu@oss.nxp.com
Cc: Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com, 
	lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sound@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 4:33=E2=80=AFPM <chancel.liu@oss.nxp.com> wrote:
>
> From: Chancel Liu <chancel.liu@nxp.com>
>
> When configuring 32 slots TDM (channels =3D=3D slots =3D=3D 32), the xMR
> (Mask Register) write used:
> ~0UL - ((1 << min(channels, slots)) - 1)
>
> The literal "1" is a signed 32-bit int. Shifting it by 32 positions is
> undefined behaviour which may set this register to 0xFFFFFFFF, masking
> all 32 slots.
>
> Use GENMASK_U32() macro instead. For 32 slots this produces a zero mask:
> ~GENMASK_U32(31, 0) =3D ~0xFFFFFFFF =3D 0x00000000
> Behaviour for fewer than 32 slots is unchanged.
>
> Fixes: 770f58d7d2c5 ("ASoC: fsl_sai: Support multiple data channel enable=
 bits")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>

Reviewed-by: Shengjiu Wang <shengjiu.wang@gmail.com>

Best regards
Shengjiu Wang
> ---
> Changes in v3
> - Fix patch can't be applied
>
> Changes in v2
> - Use GENMASK_U32() macro instead to make it clearer and safer
>
>  sound/soc/fsl/fsl_sai.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index d6dd95680892..9661602b53c5 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -797,7 +797,7 @@ static int fsl_sai_hw_params(struct snd_pcm_substream=
 *substream,
>                                    FSL_SAI_CR4_FSD_MSTR, FSL_SAI_CR4_FSD_=
MSTR);
>
>         regmap_write(sai->regmap, FSL_SAI_xMR(tx),
> -                    ~0UL - ((1 << min(channels, slots)) - 1));
> +                    ~GENMASK_U32(min(channels, slots) - 1, 0));
>
>         return 0;
>  }
> --
> 2.50.1
>

