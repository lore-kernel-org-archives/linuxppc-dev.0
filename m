Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41162606A32E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 13:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l/vNW1T8
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPkJg6ZVMz2y8W;
	Thu, 12 Nov 2026 00:05:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::530" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794402307;
	cv=pass; b=XPuoDZVYEO0ejm/sk8dcsuzY6L3f63WsPd2315nTXJXiB64XkpQqzugj1AtF1MwngnZ3noxqNO3Z0rB8C5PyhYMWL1oOOdpObbA/ydHrFz04znOe3ta9n17AzxacyA0kCpd+5KvAzHv3KjZwkAlhsQ4Vao5OrMSP/xCe34DKZ1F++Bam+oF22wFuq0QiM/FIoSuSksSXw8263455Ny5/bvuhC4zY4F9ZGXgKH8NzTpUGS09rHth4Kz5Jn4tHsVGT/ZIfw9isORS0MXKghmK8bbB1EYvTMBRimCRrp2axI7iCVfP+E341NvAL8eDWQeiaz1i8JquVZp+SUj5Btf6Q3g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794402307; c=relaxed/relaxed;
	bh=hUdHRWHMk5SGs7+YuKFMHezWxysz9j61hMdmcrFAg1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=khVthGBAUDJI0fV8lG1SGNdfGg+it8Hz55wj3sVhLBGY/VqJB6UeFpZVY410jmbletwQ9QKpnCgH1SSyIZhsWBweVxpwKrn5MioiHlWFU9NHpAHiL6qbaegGov3YF/PmyGBh/Ba5fr3HXwkWhjHuR5lFflINEs+A17/NZVRlAb8SjMdrunT7VUjPSRRdRRAlm2bJFiSbP1MvIt2u23FVtujz3cE5KUZZDkrnqW7AE6TdcIcxsIhLdSh1yWsqXGkyCQNG6T2e2yU/7AdW7HNR9Rjxl2qSg5v29ezQs0gBBTAgnQDhxRJu0mPQSvcu5l/vRpE/HRsxg7A0tBz8VcYXPQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l/vNW1T8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l/vNW1T8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPkJf19ZYz2xqr
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 00:05:05 +1100 (AEDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-cdb9d5c1c8eso1618663a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 05:05:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794402303; cv=none;
        d=google.com; s=arc-20260327;
        b=ZEbFNGVHKFZm6CCBM26FDyBVrhw01qFOlo44f+FLH6RNa+7HVmAlxB4REWeWTEZa7t
         xsP+DYFw8D+xRlU4PkxyaDv+OJYFCeqpLaJ4yyErFBdLXEVnAWL99fmcZ1qizZdvqQc1
         Y8LzvR3zZZs0wZzLOVtamKoZEFg6ul/gsDq9Z3DLkef26juE+oLqFljdmb00F1sdaLUm
         OaLzWs/hcIn7P4L3xYYqO+4Z43IB6AIeeaVpNu7QKA3CWry8XC1cryY6VM4RxSK++jI1
         m5WfpFp5ZT7RtLcKvMYBaj4IfTxW6tocdzMVBEVqpSscA27LhVyQfZdUGFodbEI0XoBA
         NTXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hUdHRWHMk5SGs7+YuKFMHezWxysz9j61hMdmcrFAg1A=;
        fh=rSktxTWcUzIsYcUKFdOBNojL7A/op5KbU4r/qsFGcRI=;
        b=XMk01FHpDrXw8AEAbBySGwKMn+lJq5dLAcI1C0Jyqo3Ld/bwUTfG6OvuHjhhYx6daV
         k6kJn1+h9Jn2BcCyEo7bv3lTZXDXN0g33C8urn1FJeEebFc/3n1Ct/FL04gqg76OeJOF
         zxQ61CY6VhgRcak7LUqCYVgGx08Xhcq/lyZnJQfJge427OAYtETkwSCewHMzas32OSrm
         76lhSaFaZKwQYQOaf8Bu8Ys3/HotaUTEmvflrdS/B8+V2b6ykX/JvRWtrHKTkM1kIYDY
         +mZMkOm0wo1MQIuMkXy6q8M5mCr8grPCK98nADl/gAFJkauWFLphhLtA3V1qj9aHB2GN
         dWzQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794402303; x=1795007103; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hUdHRWHMk5SGs7+YuKFMHezWxysz9j61hMdmcrFAg1A=;
        b=l/vNW1T80dbL8WWY+vjABemPK7ihEX85Ka4JLmaUIufnzcUoQDa3CuiK8T0yolXfhy
         3JiqZPnERI4PT4R80626gnGsMmq67B5cGLYrko4LW6QFkYSIsZwF4NepbjhNObajG0KY
         CR1xP3s9Vm5K11woWdBSbrqPQc/Z7Z8WiG7wkwUKjtjamIozqDyuWSDaxmrVFYJbJgFy
         Scx0C3sCdlPPa+yodj1ELoGE9/LkTdfo3Pxw6Se4UpnozSl1hcUlwUNx7c8b+w4KdKeI
         YTR6hFntWwxiXlBoBH5PqYDh+ImA+fXZazs5iOFzI7D6D3F9+0P0NpvxWeyc6dOVBY2h
         G5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794402303; x=1795007103;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hUdHRWHMk5SGs7+YuKFMHezWxysz9j61hMdmcrFAg1A=;
        b=u2hY7kGAhXmQC2ykLVnQyRdeOJSLutaPk3l/9TSTfykPow1ebP3+UhREkY/2OE49bG
         /XygnsnlpCOMM+3OIcdq4a/WubSFCGhYG+rWcKDBRrqePknjnv6+peoLpxFcQxf1Nl6p
         AEEqaALOfHXmqvbjtA7vgo0Rg2gEfaPGSLwGS9dh3JcpUxd+Ctf27JQ1tDhxhl9zTH6e
         pFssdMkQik7zfWNwSZAVEHvFC/hQ3nTrjmKEUoV8Al4emQ32LPzk2uQKmoOy+Rqzh7EH
         IyYyAX/hR2rov3xJhapsdxRcnT40y3WQorIM/RB31YoUoAm7HwsCLvpYWgR7l0hkzmeD
         yIUQ==
X-Forwarded-Encrypted: i=1; AL+hErFmmeJmY/nVAlc5zVjS4k2jW2of0vdphn8y4dvXJFcOQSRZDbJM8lyO0n4ejAhCBqZNcFg+SGcQXuSEvRg=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8/02LzBgAaq+ZnUpFnMGq9jzc9FQcPEPifcIi1jCV1dPT29HSX
	tnBhsvFji1B92v6nGnCjfO4QwAoNzR30y6jJtLqXXMRiATQYQA1cfirSKmWIfxiLZmMU/OiHabo
	pSG8uJ5esNWMZti6l8SofE/65IEZPujk=
X-Gm-Gg: AYBFou3cS6p82XjEnbeczpQfbq5/Pf2PY2EXAOMnk6sTnSvjV7HPw75xIjZB5B5slaw
	YkC8TFygybdOH48T6kN6U5nGYzH3T+uIVMQd9kOS9fIQQcmtb7OvI2jWZwl6DOMU4OPLz7aiYMe
	4lMhZxQkMun5Mw0OYG7Prs/+SDQYQz1jfJHXF7ccHBCYlc6/UzBclmLE4UadYTxk9W8tOqGf3YM
	L3T84niWsIuGvrHZ1wNWvOXOwFNTSu6qP8z/Avo/mtMvli+Pd8VVz1M33TD9JlXKszO3GDDXLwp
	JBjBx339uBdXwprhRvAV4B/1cUyHIuE/OvHXqVlidAGHIdPx4Zf/sRs3F7c5KGzYUeWnNkEJtQz
	OUh+QoqxlW9faSU3b5lVqE3NofYNFdCdm+VPRdA==
X-Received: by 2002:a17:90b:1c01:b0:3b0:9a2e:b491 with SMTP id
 98e67ed59e1d1-3b182f8c3e4mr2105707a91.66.1794402302257; Wed, 11 Nov 2026
 05:05:02 -0800 (PST)
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
References: <20261110120743.6301-1-stefan.ghetu@nxp.com> <20261110120743.6301-2-stefan.ghetu@nxp.com>
In-Reply-To: <20261110120743.6301-2-stefan.ghetu@nxp.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Wed, 11 Nov 2026 21:04:47 +0800
X-Gm-Features: AclHuK9gW152QspKH7kQnf0y9WcVt11cA0ZeBNkE67Czjx0uGH17tx_pcQrtqzY
Message-ID: <CAA+D8AO47ctz1voKax0OsyYiLQ+UT9gU-E7Z0i6=D6RKgb9=yA@mail.gmail.com>
Subject: Re: [PATCH 1/5] ASoC: fsl_asrc_m2m: fix out-of-bounds write when draining
To: Stefan Ghetu <stefan.ghetu@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, linux-sound@vger.kernel.org, daniel.baluta@nxp.com, 
	Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, 
	Nicolin Chen <nicoleotsuka@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 8:07=E2=80=AFPM Stefan Ghetu <stefan.ghetu@nxp.com>=
 wrote:
>
> asrc_read_last_fifo() checks the FIFO fill level, a number of frames,
> against a length in bytes, and ignores the frames already drained by
> previous iterations of its retry loop. With an output length close to
> the 512 KiB buffer size, which userspace controls through the task input
> size and formats, the drain writes past the end of the output buffer:
> 312 bytes for 10 channels of S24_LE with 8 frames left in the FIFO.
> 8-bit formats are also stored as 3 bytes per sample.
>
> Check the space needed by all drained frames in bytes, and add a 1-byte
> path for 8-bit formats.
>
> Fixes: 24a01710f627 ("ASoC: fsl_asrc_m2m: Add memory to memory function")
> Signed-off-by: Stefan Ghetu <stefan.ghetu@nxp.com>
> ---
>  sound/soc/fsl/fsl_asrc_m2m.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_asrc_m2m.c b/sound/soc/fsl/fsl_asrc_m2m.c
> index 58101ce07c9f..cadfebb12e7c 100644
> --- a/sound/soc/fsl/fsl_asrc_m2m.c
> +++ b/sound/soc/fsl/fsl_asrc_m2m.c
> @@ -53,21 +53,26 @@ static void asrc_read_last_fifo(struct fsl_asrc_pair =
*pair, void *dma_vaddr, u32
>  {
>         struct fsl_asrc *asrc =3D pair->asrc;
>         enum asrc_pair_index index =3D pair->index;
> -       u32 i, reg, size, t_size =3D 0, width;
> +       u32 i, reg, size, t_size =3D 0, width, frame_bytes;
>         u32 *reg32 =3D NULL;
>         u16 *reg16 =3D NULL;
>         u8  *reg24 =3D NULL;
> +       u8  *reg8 =3D NULL;

The asrc doesn't support 8bit output. so don't need to add reg8 here.

Best regards
Shengjiu Wang
>
>         width =3D snd_pcm_format_physical_width(pair->sample_format[OUT])=
;
>         if (width =3D=3D 32)
>                 reg32 =3D dma_vaddr + *length;
>         else if (width =3D=3D 16)
>                 reg16 =3D dma_vaddr + *length;
> +       else if (width =3D=3D 8)
> +               reg8 =3D dma_vaddr + *length;
>         else
>                 reg24 =3D dma_vaddr + *length;
> +
> +       frame_bytes =3D pair->channels * width / 8;
>  retry:
>         size =3D asrc->get_output_fifo_size(pair);
> -       if (size + *length > ASRC_M2M_BUFFER_SIZE)
> +       if (*length + (t_size + size) * frame_bytes > ASRC_M2M_BUFFER_SIZ=
E)
>                 goto end;
>
>         for (i =3D 0; i < size * pair->channels; i++) {
> @@ -76,6 +81,8 @@ static void asrc_read_last_fifo(struct fsl_asrc_pair *p=
air, void *dma_vaddr, u32
>                         *reg32++ =3D reg;
>                 } else if (reg16) {
>                         *reg16++ =3D (u16)reg;
> +               } else if (reg8) {
> +                       *reg8++ =3D (u8)reg;
>                 } else {
>                         *reg24++ =3D (u8)reg;
>                         *reg24++ =3D (u8)(reg >> 8);
> @@ -89,12 +96,7 @@ static void asrc_read_last_fifo(struct fsl_asrc_pair *=
pair, void *dma_vaddr, u32
>                 goto retry;
>  end:
>         /* Update payload length */
> -       if (reg32)
> -               *length +=3D t_size * pair->channels * 4;
> -       else if (reg16)
> -               *length +=3D t_size * pair->channels * 2;
> -       else
> -               *length +=3D t_size * pair->channels * 3;
> +       *length +=3D t_size * frame_bytes;
>  }
>
>  /* config dma channel */
> --
> 2.53.0
>

