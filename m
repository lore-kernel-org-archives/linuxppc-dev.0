Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A909606A32C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 02:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YBKBB6zZ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKn0w7457z2xNC;
	Thu, 05 Nov 2026 13:52:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::430" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793847168;
	cv=pass; b=TKGZGshlqXN+cQngGtt+vG36tdWr1VpGHjEfQKn6UFHszZJsC0fgsyxFuQ2OQQw/81DlJXLkZJM01ov1x7TDBMLb90RkdNmsQ3k5GTNGQUpeRQma6lxIouUtL8Qa7arCeHM4dql67Mwbdc695chy9RfiFJpy6bp4Ms2SR1JR0ajg03r77HfYp4c6JLHXuRa/Z+a94ayE9cgQlgBSuj5zesJFU4JD7Fcu7ZZj/QSjjszjp/KkbSKxAA+fZoXl+TlonuH/JXj7jFyOOLS7gSvKd9MLQruQL10RwHw45CrxShkU6Rk+k47UEXQ75Th26FN5po6g+kX2HFUkloyMi62p/A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793847168; c=relaxed/relaxed;
	bh=Ey1iV8iQoLj7ydlNgUyOjkiFHdD4l+/Plkd+sDU6ZFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=URXDkFFFnvYlLokRL5/W48yMHINkr0BKc75Tie+wj732QbPUU4YMhaEGvH8wyAbgwjBqv+U8h8mgSpzYalWQyc906oMEDO5iKbNuzEHiiBkKBrF52aR5+Y6PvzUzrb+ioI9aTiZAXL4+s40F6v6IUgr/o9FEu09WagCw/Cnrw4x6QO8LZE+6LL68ut5MozEf1VCKjHloIPuV2LU3nu5HHXT46FvUsgWIWwzcc2UVCfU+PmamZKeoJjwqEMRbfmWfkT0fbLTD7QwETtGhsPAyRu1OkZOnWmpY9m3RLjapelDCYAjDWAqlOLjkAKFUlud5H8n2ACTnDID64vdViSimbg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YBKBB6zZ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YBKBB6zZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKn0v0x5Hz2xHP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 13:52:46 +1100 (AEDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-8a60f90a924so607432b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 18:52:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793847163; cv=none;
        d=google.com; s=arc-20260327;
        b=AqxJ7d8GRgj8O+XKSxNTem5HxqCgHdUStn6AL8n0HN6NTdUigPDobHTP7xEgUWcPR0
         8qE4KC5vete44eXLTnROHW9AyRpsbAfGdXkv4PEN9gSufeB8O2NEQRn1I2cTWgqMOtSx
         iSRAuBIqDztisIEZtSTyxzUNIFS8fkwIZMDhbFf6IGPc3EDEeRuHTEV1zG/vntYVxj6J
         +KXzBkhNmpdvQzEQUCpujj1SuPC6zA5ksDpki60jXydRly41Ap9U3I3G5/yPkudSSVqK
         qIR/WoTs00O7RIAJXzK6LcqoCch+7hdoYt8MkXeoy6ut8m28rwwkGjm+cQ8QIY5xWM3t
         ErGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ey1iV8iQoLj7ydlNgUyOjkiFHdD4l+/Plkd+sDU6ZFc=;
        fh=9T+gh7LpPF5LeCH3N/Kybritn7bFhpWIs5G8YZmIpMM=;
        b=oZMhuoqov85gGofj/NJSuGYWRI9RX6DObQug51+JeHGI9C6s2E34VWGp5HQH4YG7E4
         13THqv0s2i5Aow2WtL6JgVRPed4xLkqFlpPP+OZJv5CUgixFiTYqhw6eBBVMOVKUeOeg
         CVKSKX29iqVNWCkdpJWRjFqnoCuJ8dASDVQ75SjssbEDlUJ1LsLvNqghsa/X2cFcmzvv
         eFjiK3tluss4bI42vPJoSfxaJQw+m+frHzej/enwOtngmvD+rlFt+aX92K58b1IK8q65
         Q0HdTrSIWvotQTJlVO/mSl7aa1kKEHF0XYBpOAJeZipBHuWjd/xGNnmraBzhLZy8KPXW
         xCgg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793847163; x=1794451963; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ey1iV8iQoLj7ydlNgUyOjkiFHdD4l+/Plkd+sDU6ZFc=;
        b=YBKBB6zZWRfBHNCuKrUNZvcTqOfhZMbPxle+0uihBKQow9VVr8KZlbT/vknWVegkaJ
         R/8LOYNEo9OPqX3Uk2NkqtrqkBdjjF/B1noNh0/6YEMv0qilYNnkCbELCxfhmsSmt6+4
         NcEhdj9bXOeZAcvm7qzTw0tckyFpyR/Pu+nJyjFOkfvEkKlc2hj09zyuNu/0zmzjffzL
         2Qh1uahNw8dWojI5gGSqvdVeozXkUqk4qikkBGTKFhP0HFkWJYNoiboxY9pxs2AqK0U5
         5MD3rgGVMKclJwp3huSamDGwtS0KGxNI1G0h1uis8SlTX/APR6pGOP+c6Asv7RGUmi9k
         UoOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793847163; x=1794451963;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ey1iV8iQoLj7ydlNgUyOjkiFHdD4l+/Plkd+sDU6ZFc=;
        b=KjxB6YfwkfGKxO2+o//lI8rivQxsX1ua6cBkdNxcg8QgqJBLmqu2JPd8g4lwdADECS
         oQLO9XPIkf1T4M0jgWIl/s1giOO7CzxbRYeEWBBC3X4as03t88WO6uVrCAhhLcNyxx9C
         j1A11TFdvQsLXBDRMXtZAmhvHIkSc2vvK9+XoqFBvepZ8nik/3OgEZU0GtQWpj4Ou3fJ
         evWSu/cnoz4BHImNP3eBkFnvO10hm4KW3D/4jpb/Tg6WkTmjMqAPTHAHuR6NqyvLMr6u
         bD1tt+lGZ3zS/MdAztYjBUIh+QYsepIonXN2OSsTVynJw/FCcwf/m1ASxObZc+79/PCo
         3YTQ==
X-Forwarded-Encrypted: i=1; AKwUvByyzqdUoE7U2QcaNDcK3PhkRl5geojurrI5l3/LdtLIbIWgCPdmjmA93qknK4sN3RpTvsx/YPQ9cj/ZfrA=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/sI/ZvVV9KAfduGj+dS3FNubElf44R5xcBIMdAn0oc206XP4TZ
	G2kVF7Qcbil3m2DzpFPpImhQ3dhxVXI2FwZSMTMD/aR2nVjls9nZ0+J5fTalWHuBsxIxSNxs8Va
	7lAwkQwEXjk6mHCx+mYu1JtIEUTtDgD4=
X-Gm-Gg: AYBFou06kHQ47Q9HfaNhKCM4rc9lVN3oshWxBq3Y0Mv3RvshIz+c0HLmtmlQur96lH3
	HNr/eofnSlaXIYTaDR4moqSLKiIfr01LPuPguep0dKUDBepZbMHXqnmbhr7zvadXyiC9GY4VoaY
	KifxESNN/99DT2SfIc+fKItTke+UZ84L/w8MFLbUxvbhAHocYvZHWbMnsDWUDWxB8Kgc8iudy3p
	Ms4dkkoUsOEweOwJN681vzx7Kuoi3zopE6259Y0qLnz5zQBze4ilMAW6Be6jXuo/5mcecKkD7Ft
	ROExKghCk60/du99pl/yiu5hIkBHfqFF4YEqVyF0Pds3TRBdRyzQzvBBeOvOF3YLV7ZpIDUXHCC
	wE2/w60kFW5Ie3UAynW3+QknzJKkuh82Zyc8w
X-Received: by 2002:a05:6a00:2d96:b0:8a0:5f63:5521 with SMTP id
 d2e1a72fcca58-8a9ba703d12mr13438966b3a.8.1793847163495; Wed, 04 Nov 2026
 18:52:43 -0800 (PST)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104113228.1634005-1-peng.fan@oss.nxp.com>
In-Reply-To: <20261104113228.1634005-1-peng.fan@oss.nxp.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Thu, 5 Nov 2026 10:52:14 +0800
X-Gm-Features: AclHuK8gtw_SYmYC4rZ2ec9F7qmZC5mmmsY7xqdrym-SeKMj27M0HT9x7LVxGTo
Message-ID: <CAA+D8AM5Nr9vDzohQaz-XN=_F9dBfXoBJJv_3FS3jDeGQ_6G4Q@mail.gmail.com>
Subject: Re: [PATCH] ASoC: imx-audmux: Convert to subsys_platform_driver()
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, 
	Nicolin Chen <nicoleotsuka@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, linux-sound@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 4, 2026 at 7:35=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.com=
> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Replace the open-coded subsys_initcall()/module_exit() platform driver
> registration with subsys_platform_driver().
>
> No functional change.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Shengjiu Wang <shengjiu.wang@gmail.com>

Best regards
Shengjiu Wang
> ---
>  sound/soc/fsl/imx-audmux.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
> index f8335a04595a..d46f43ab66cf 100644
> --- a/sound/soc/fsl/imx-audmux.c
> +++ b/sound/soc/fsl/imx-audmux.c
> @@ -361,18 +361,7 @@ static struct platform_driver imx_audmux_driver =3D =
{
>                 .of_match_table =3D imx_audmux_dt_ids,
>         }
>  };
> -
> -static int __init imx_audmux_init(void)
> -{
> -       return platform_driver_register(&imx_audmux_driver);
> -}
> -subsys_initcall(imx_audmux_init);
> -
> -static void __exit imx_audmux_exit(void)
> -{
> -       platform_driver_unregister(&imx_audmux_driver);
> -}
> -module_exit(imx_audmux_exit);
> +subsys_platform_driver(imx_audmux_driver);
>
>  MODULE_DESCRIPTION("Freescale i.MX AUDMUX driver");
>  MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
> --
> 2.51.0
>

