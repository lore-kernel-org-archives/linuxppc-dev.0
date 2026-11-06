Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44094606A32C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 03:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mdeY9oDH
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLPB53rfSz2xGr;
	Fri, 06 Nov 2026 14:02:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::530" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793934173;
	cv=pass; b=AkZLyOysnajuHuWapWMZ6PalVnQ/Z8l9sEjOQQXInDYF+lcOMlqNKvxuNiczVltcKqOj6SXyo9OXPw75ztWGnuPXfr1chX9gb6BUV7+VcM/ISIp7okP3jgN2tRmrggzYzhTF3HSXNjJD3G6KdntwgFdMNx7Y65YJh/HiCiJIui/Pq8WxEi9XCx8Z8tMH0aj+uBUoz0AdqsX+wEXfpx6QqeRgvGunbsw9OzOJZgQ8fqylUnq4FmLA7ZtJY/SOjMmYq5YRDzerlSt6nRxpuAxq1rGWScqzQ6ucpDcc0500LZKjpe90fjzEORuhxLKpRTergTkFhG/oTS+ekWulLt1Sfw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793934173; c=relaxed/relaxed;
	bh=gKlkPLsxQMeV+oJVtMekbD2xgsQAsa6FTULIvqAEmaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i1ZujHzzpEiq1CLnB9pgiL40RzKD38iF4JWIJNngCHRhDa0HEkerkR4C4U00PZ7Mc5BnWQe++e4IRuos6cCzowxJ42SeMe/5WI0Q7kxi6G/FmudrEidLRls0Me9NTGStWjeGBiJ8Ev3OjuoTp4rhT9p/vDZFNEd0dakZ46PxSgMLc52l+9q2qMaFNO9rYpFa1j4DbIyK6KjixHAqx8GfwFHPQepwde/HxNCZiamYi8iUjuMQisYiKRtIc2lfNVtvkyJk31T95FA9w0TOJ2YmZASxbUhvYldr7Ed7U0UpFo3soX9grv5JrKARNrmZztL6310Yb5tTyLDrTN/p4Bb4QA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mdeY9oDH; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mdeY9oDH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLPB454w4z2xGg
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 14:02:52 +1100 (AEDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-cd8ca57ef64so544729a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 19:02:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793934170; cv=none;
        d=google.com; s=arc-20260327;
        b=MoQ6pMZzr0KKIZ4DHvk4Nv6oyOsuYVNhAVnlq9+w9yk/QFsppw1xqkgnjhoyTWLCUY
         O2/zBeOrNVYZi5XV8ZBr9YuCsTNbfMm4PL0sxTo/2QlubeYd/ollTQ8Wp1dlH+ONK9rH
         9lxwwkyoEGE526uqoPtXpW9vxHZ+mA+oGPIN2EDukFm3ROBAjxt8yN2qHl9i8JhTAGGo
         bQ4dPzBG991pHGdpSNCLPbZc6T7bMPQ2BQqPluDQkdX1/+XyFibBNvkipCcXdVqx042c
         2U7kUVYbIFx8ipJuKQ9NH6TJdtDq3VAccx7TUzR7dtAk2gss0CG+E7sqZ0nfTeDO6022
         wFoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gKlkPLsxQMeV+oJVtMekbD2xgsQAsa6FTULIvqAEmaw=;
        fh=R+o2O0fl9hNu+z8NhqTVV3dWr6shw0Sc1F4dduIe4Ew=;
        b=fKtO7WmiuYBjqfIqObmsG0fiweDl6ByEy28nigQ4uHKeLjz1amZZeJRp/OU60rtLtB
         KXor7wOoCmNXZGJfLjtVK53fpUcyG0mjghLwFdkyf/E2HKIQJX6AmzosaUlqER1uJB/L
         AsGq8B32C+5ibPRl78Tg5Woc9G54HhpzxXUpS06vLNCw5+OwjevVeIItxmCtyME192P5
         Rwlp6b5R9vJGpKy8u2Ie1F0j4muZ0U3Ase62PhoVpK+NwY02Z/HyGP2f+ADTFdFzn41i
         6yiBa5YK4hTTJNTk6vQb+1dBUnAyfB8c8BVJkBDftNkF3WQC1yRvhNow6InybHsVhnNZ
         nPew==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793934170; x=1794538970; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gKlkPLsxQMeV+oJVtMekbD2xgsQAsa6FTULIvqAEmaw=;
        b=mdeY9oDH6wWUoFzL4S+VCuxvr/Lc3BWUV/ZWKeru0wJ8BICAIDZNPS9HS+p3Uqzb5o
         fdL1SLpJtOnEKgqKBkmp8WzUA/sVZVa2woxq17/SR+JuMrUjBVasWZdyDhW56VPMPqZl
         +vJQ4wCj4vV/Skl4MUqGtpM2X3eRIvl0fMhQBeJALX/7PfNXnkBzS+we+CLeySmWZu/y
         voHWI2JIGarPmTwUClM/0x6jCNNnQTzThKxuvlg11bCwD2trceHA/tdNkIAr0xaNE63I
         IH5LAZhHiozoDmqM8UZ6ZiY00J3hL3v4awrrUuZSHFu/qpYXqalbiOVxT9CtgdnsW5Qt
         n4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793934170; x=1794538970;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gKlkPLsxQMeV+oJVtMekbD2xgsQAsa6FTULIvqAEmaw=;
        b=2o2UgaO6K8VRC4mdPq+tiKUl+BdJ7PIjlEOB+1WtGQGQZ/n38uSZ2WW71urYXmQ4px
         Owcf0+Bubk2GH/5/ZHhoKCBLihz204KxXFcCntuGQ0L7i4zo+UcTpzd0ZvortqUpqG5B
         Cf+v3SbsIMp0OxJk/KAq5Toi0evad+hUGuPfOUN8VpZq7snamW2RVnsOD14oB0TUix7Z
         WOghstNS1iOLmTtv0BQzwQ7rhcJwRlr7C5dL0zzFlvdUidNJP1L2GvJSGYj/Jof08wQD
         f/cvvqzDDVlhFnpRMmfaCKhMBcp7jncEtQKQ1i/oqVVm2cxcYeSUTgVZ132AnONWaCYE
         9c8A==
X-Forwarded-Encrypted: i=1; AL+hErGD6XAClRb01hMU4E8NwA6/8pDwi/yPL9ctxGVJggxdK6i2VGGkyNuVG93bxvAzHrtCdRfEDahlKpQvwr0=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8KLz4O8VljVF1giB/xHQ9IpnIsHpdtZliCB2643jDKRFHVyUFZ
	lx8Df53uYRlYW6mMpj+TQPLUKDs4u28evoPc0oDxxgFtAGIowQFnPsWhJ9uKDW7Iu9PxR0Hr4Cv
	dTr33ggeTDyUGAEpd7NP1xWAMIa+Ac0o=
X-Gm-Gg: AYBFou3O0ILXqa9h7uUmn7fJrux2IwGkPJXl7S/1Jx4WBskllALfNyK5fzkyBvY6EcI
	2CSacEi5KQCCQMXbIfDKjdIm/ADZ1NwD4BYoziKFH8j4C/wHLoYtlCCbAGyb1ZTpiK4e5Hr20PK
	GCGp7Z+0/TQ9XSHZSCo6pbwoLo2EsxA/m2TeHKbdUr1CAhze63Ql3Wr9rrbVDOly1eemza1u2m/
	itFsMlmJ7q/rqArv3NUVit2cUEorP+ImQWqBJXCeRkUIaVWTJFhIeISBDX21ayhT0BDf+JjKbgx
	4KSeDtjbIEkifCtTGaPjT+GC+qYSrGmZ/AR/RJ0oHK+M3TSTfcd+OFpvY1xrtSApVIDFZNClEyo
	RxymBShqFmdBkKf5VXbpwr1ysRAKcGNfCydJI
X-Received: by 2002:a17:90a:d88e:b0:3a4:b509:88bd with SMTP id
 98e67ed59e1d1-3b0db608eb2mr752950a91.2.1793934170297; Thu, 05 Nov 2026
 19:02:50 -0800 (PST)
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
References: <20261102195228.4084438-1-Frank.Li@oss.nxp.com>
In-Reply-To: <20261102195228.4084438-1-Frank.Li@oss.nxp.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 6 Nov 2026 11:02:22 +0800
X-Gm-Features: AclHuK-7yWfD5nIIYc699a1XBrVl3zaaX5gaE-98V3Kig8gZod2anKcZN_IDxRY
Message-ID: <CAA+D8APkR05hUMm+KrRhZ+dkEzppNCqD9C3jSGiG42bFziE80Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] ASoC: fsl_asrc_m2m: use dma_chan directly for dma_async_issue_pending()
To: Frank.Li@oss.nxp.com
Cc: Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, 
	Nicolin Chen <nicoleotsuka@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	"open list:FREESCALE SOC SOUND DRIVERS" <linux-sound@vger.kernel.org>, 
	"open list:FREESCALE SOC SOUND DRIVERS" <linuxppc-dev@lists.ozlabs.org>, open list <linux-kernel@vger.kernel.org>, 
	imx@lists.linux.dev, vkoul@kernel.org, Frank Li <Frank.Li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 3, 2026 at 3:52=E2=80=AFAM <Frank.Li@oss.nxp.com> wrote:
>
> From: Frank Li <Frank.Li@nxp.com>
>
> Use pair->dma_chan[] directly instead of pair->desc[]->chan when calling
> dma_async_issue_pending(), which is more straightforward and avoids
> dereferencing the descriptor to get the channel.
>
> Prepare to make struct dma_async_tx_descriptor private.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Shengjiu Wang <shengjiu.wang@gmail.com>

Best regards
Shengjiu Wang
> ---
>  sound/soc/fsl/fsl_asrc_m2m.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_asrc_m2m.c b/sound/soc/fsl/fsl_asrc_m2m.c
> index c6970a7e88f3f..796a78124765f 100644
> --- a/sound/soc/fsl/fsl_asrc_m2m.c
> +++ b/sound/soc/fsl/fsl_asrc_m2m.c
> @@ -257,12 +257,12 @@ static int asrc_m2m_device_run(struct fsl_asrc_pair=
 *pair, struct snd_compr_task
>
>         /* Submit DMA request */
>         dmaengine_submit(pair->desc[IN]);
> -       dma_async_issue_pending(pair->desc[IN]->chan);
> +       dma_async_issue_pending(pair->dma_chan[IN]);
>         if (out_dma_len > 0) {
>                 if (asrc->start_before_dma && asrc->m2m_output_ready)
>                         asrc->m2m_output_ready(pair);
>                 dmaengine_submit(pair->desc[OUT]);
> -               dma_async_issue_pending(pair->desc[OUT]->chan);
> +               dma_async_issue_pending(pair->dma_chan[OUT]);
>         }
>
>         if (!asrc->start_before_dma)
> --
> 2.43.0
>

