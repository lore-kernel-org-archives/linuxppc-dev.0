Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077CC606A326
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 03:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CCsTd0iI
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLPck4qGYz2xH7;
	Fri, 06 Nov 2026 14:22:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::534" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793935350;
	cv=pass; b=WGGZ9y155XSbMBRoe+c1bv7/vODgU2yi/zqtvaZXDzkZYYQlssxicmzcY0+DRcyF43JYlTkTXAJEbxrEXFtcIFsEGTQRTgm8b2gvg4vdqFbU5nRZGG9l3O/fCAAZbBwDE+Z5qr7+x7UE9bLA/RqrNc7MOnLw0nuMFveewYj1JnAWp5GyxZR2R/KyGKmZ5dPVsgrGL1gYkdONtJWO4FZ9jA2hIhKnvLb9vofc6k3VkD7YsdNpNVj1fJAnkQlAC+BS0QXqxplQGjX+4d2Qc6/OZCK78qHBkhx2Jcd1TCNK1xglU8FB59lyVul5ocFI5hgThWPXE1EekdBI7TKu//Z3GA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793935350; c=relaxed/relaxed;
	bh=w32LmgqDCV1eew1K0IjeecQXsQlnn48/GdAJChQRoV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FuQHfCKRa8aKNOCl6+Ze/MGp3BXCMX4T9Mgi0IKqLZBUoz85CsPMyZQymNgvTIaQuZwyy09OgQzqtao1OO2/bSaPeHK5XExtZSxQ4sZ7dMWJVc+l4KdRRAfCrcvZd1DjCdAs+LhXHfcE3KbmRd7yRcZEBfh5Zw5JbKndvIfJwVf/hpeveS24jALXJ5vqa6ZczwmVAAckkb40Mam9SGSAwVUnafAPxfm/JiAqr+r+CVL1C+kqiibsoHyl/66xEk3JB17DD01WaRpTW0aB8GtJIChhJBh83yxd0TVpGhr65QMdqmBBQ0tcV5uwXxPc+XdVckvasinQAqa40rl4Y2pVOw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CCsTd0iI; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CCsTd0iI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLPcj4BWFz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 14:22:28 +1100 (AEDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-cdb684859cbso124531a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 19:22:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793935346; cv=none;
        d=google.com; s=arc-20260327;
        b=GtP85qTtDYonE7QNh644XbQCNHjk77nMXDXq1lVnzPP+piia2uYUm5qHmYPMufs8yD
         WjX5GUkrW4znYlWf0s19KP+v62nFb3P2SyQRJcFIbKUB3yeh+7BaF7lOmOXkbaBOPkih
         AFT5ioStLEcPg9/uSZJMrU10yWFBMxrx/xh5Hwafkgjf6wgarBymS0CYiEL7TMLz1gxB
         t8KkYqlcJSk3U1xsCEjlENpwevpNpRb74+jx0HImy0ELs4iLW6+CV+Fq+0+3BCwhjtrq
         zlTYj4t+3fkRPj7n1eYd9/aDfmI2GHRtO701EeKSLjq+jk5FY+vOBWiOdNmD2mrXqESx
         DH4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w32LmgqDCV1eew1K0IjeecQXsQlnn48/GdAJChQRoV0=;
        fh=Dvd/8ldfPpZNj3Nu4pGoBx4BBDW2CSIajkXc1kNEkqk=;
        b=P06J1L6vuJ2i/0s3a+KTVzoH2Ihv8zfg8f/JWUzsy87k+wQjHzXmERk4OocLlZR5HC
         p4rWEE/ZWQBD8WCnVma4ayDNzbSAy4jBSVjVgrbp8Dxg3Ctm+E4cmw0D4rO7cDKneo7R
         AGsLMYocrNzinrzDw3fXN0BfwMwrEBhwZOX9/Y6KZiqs+0oeRzsMvwTSWYQit5qiPxZr
         cIes+sNH5BkVyUPHH63YwSSbWMcVtAmQvtD2sFGy6xQO6EpR9n2yG3dh101N09gsdfjb
         5TJcJkEWPt4J7P9F2zl1lAtOu7YivnyPhRK1ek1rJ7A59nrAIdE26XbIBTlOigH6tQjO
         EVXg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793935346; x=1794540146; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w32LmgqDCV1eew1K0IjeecQXsQlnn48/GdAJChQRoV0=;
        b=CCsTd0iILTdc5S0Ny+or7A7zbqJ0/cZkSlSFt/qfnC3teRe/27L6+uEIVaKou5UsZp
         Mq+VBM4uU6kijJwaBCAG85qq2c+n72OwtRN7hHzNfLPazIiTY8j00BiJ2HVrt/4K2iM8
         yhaJ/5LlD6vjIQoYSM3iQSdXwLjj2mfpniOQA8ArAiP1gP6oq+bvuNOPnuE133XDygk2
         /qfMlOADdlM61cn1+cNhYJFQI1ot1VNnRz63kJgAxqPXaVjMFXakbhM0sRJKvs9AZrVo
         Y02RnnMc3O3El/bPICQbAzO3q1Wom+bvlzZrCBUinV/h6wjx7ilfdDCOq9G5zkcftm2f
         g+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793935346; x=1794540146;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w32LmgqDCV1eew1K0IjeecQXsQlnn48/GdAJChQRoV0=;
        b=eJ7iNnNvwivTd7e3FPFhL8v3zymmJ6o6dCsm/vRn8OS7IsYmH1zUhp2ryYtyriCdnM
         Iv8RPprLagz/jB27xL3yof0cIO5JADnDV+YDbKzzQSSWGK3mjqDTA/pFwr9u4HG/9/cm
         KOfWzdrlYM96TVIeroHEyF3MuDY5wz7wVZpShC01DAUHBVHHe/RUNGx+1MjjrFXR1GQv
         9wLPaOiY+d0KssFbC5vvUmqyXa3xwmC04No/rN/KvAKgwiqrtJeWBA8lkbz7dfumDyyU
         gUH5QJKTWdANUl7/1TQesIHyceULVtcv5xyxLIFc55lnEwun3AAYLt/ESzNFhv3LWVd3
         UhvA==
X-Forwarded-Encrypted: i=1; AL+hErEBgEEmPHaa2F35TZdlzyLIsLhcggnqoGw9P7lLOQNAeY2XtCiVX/S0IB/VdzG1Psw0jyhhTqSrLGIqRKI=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8o/THyoouFM/OSxycL/0EqRXD3030nhSm6IWBVi+2oe9fl6+rS
	CMpqMOFnHu5XCIxqFOODWYuUgsbtVcLeNULDhPkZFB0gD+/DyqQaIVG+SOyrt5TOlvVikA8EeR+
	tEMQL5Q6PtCth+6ip+Y0fHOgJ+fd2icc=
X-Gm-Gg: AYBFou0iVrsmgpy6SLW4LaVTZ7Bce54TkK/sztR/T7x5aSS5tfn0/IVYlhoUsEmsmQY
	ofu6NeRpv9RMwUJt6orxfFWWsYBxWpSJELypWOhXrQ4i9Rcv7JkvDpYuMs9PnAoEW6lzQnQ351o
	3O1e9ujvNM8hTtdhK6MEZlPXleE/joRpxPSwT9NTAQcLQVm6r+vujYIaAGuySRD7iGatYWOQ4ol
	Uu7ymMfY5jSCiuE55e694ngu5ef7lFKloxZi2tWpVZ+8SwF8NFE9zBwzqcAVaIbR+pQxdZzIIin
	peoupmxvG1OwfvEqPggxfkiQYSlQXdECS6KziwtkWx5Y9TiNiA1n6xb68oQth95j1hPF9L7zSpM
	ZfBD+7dHhwH4VbBg2hSRwv3if2u5HHzzMRHnu
X-Received: by 2002:a17:90b:4983:b0:3ac:9d26:551d with SMTP id
 98e67ed59e1d1-3b0db6f11f7mr1320600a91.50.1793935346215; Thu, 05 Nov 2026
 19:22:26 -0800 (PST)
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
References: <20261102180915.3981805-1-Frank.Li@oss.nxp.com>
In-Reply-To: <20261102180915.3981805-1-Frank.Li@oss.nxp.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 6 Nov 2026 11:21:57 +0800
X-Gm-Features: AclHuK-h3hDpTZTCQrDXlURnXU4dNiye78ZL33OWRSh0a0w-nnzOWFYn2sw0Q-0
Message-ID: <CAA+D8ANwEqFJYQ39h+1A3zXhcUfpFGzSvVjEzx2htoYxB4sLGg@mail.gmail.com>
Subject: Re: [PATCH 1/1] ASoC/sound: use dmaengine_desc_set_callback()
To: Frank.Li@oss.nxp.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, 
	Nicolin Chen <nicoleotsuka@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Kexin Sun <kexinsun@smail.nju.edu.cn>, 
	Frank Li <Frank.Li@nxp.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Tianchu Chen <flynnnchen@tencent.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	bui duc phuc <phucduc.bui@gmail.com>, Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, 
	"open list:SOUND" <linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:FREESCALE SOC SOUND DRIVERS" <linuxppc-dev@lists.ozlabs.org>, 
	"open list:RENESAS R-CAR & FSI AUDIO (ASoC) DRIVERS" <linux-renesas-soc@vger.kernel.org>, 
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>, 
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, imx@lists.linux.dev, 
	vkoul@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 3, 2026 at 2:09=E2=80=AFAM <Frank.Li@oss.nxp.com> wrote:
>
> From: Frank Li <Frank.Li@nxp.com>
>
> Replace open-coded assignments to callback and callback_param fields
> of struct dma_async_tx_descriptor with calls to the
> dmaengine_desc_set_callback() helper across sound drivers.
>
> No functional change intended. Prepare to make struct
> dma_async_tx_descriptor private to the DMA engine.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

For fsl part
Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>

Best regards
Shengjiu Wang
> ---
>  sound/core/pcm_dmaengine.c         | 3 +--
>  sound/soc/fsl/fsl_asrc_dma.c       | 3 +--
>  sound/soc/fsl/fsl_asrc_m2m.c       | 3 +--
>  sound/soc/renesas/fsi.c            | 3 +--
>  sound/soc/renesas/siu_pcm.c        | 6 ++----
>  sound/soc/sprd/sprd-pcm-compress.c | 5 +++--
>  sound/soc/sprd/sprd-pcm-dma.c      | 5 +++--
>  sound/soc/stm/stm32_spdifrx.c      | 3 +--
>  8 files changed, 13 insertions(+), 18 deletions(-)
>
> diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
> index 1306b04be171a..41feb5312ffec 100644
> --- a/sound/core/pcm_dmaengine.c
> +++ b/sound/core/pcm_dmaengine.c
> @@ -169,8 +169,7 @@ static int dmaengine_pcm_prepare_and_submit(struct sn=
d_pcm_substream *substream)
>         if (!desc)
>                 return -ENOMEM;
>
> -       desc->callback =3D dmaengine_pcm_dma_complete;
> -       desc->callback_param =3D substream;
> +       dmaengine_desc_set_callback(desc, dmaengine_pcm_dma_complete, NUL=
L, substream);
>         prtd->cookie =3D dmaengine_submit(desc);
>
>         return 0;
> diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
> index b417de6abebe4..cd3bf6340b650 100644
> --- a/sound/soc/fsl/fsl_asrc_dma.c
> +++ b/sound/soc/fsl/fsl_asrc_dma.c
> @@ -76,8 +76,7 @@ static int fsl_asrc_dma_prepare_and_submit(struct snd_p=
cm_substream *substream,
>                 return -ENOMEM;
>         }
>
> -       pair->desc[!dir]->callback =3D fsl_asrc_dma_complete;
> -       pair->desc[!dir]->callback_param =3D substream;
> +       dmaengine_desc_set_callback(pair->desc[!dir], fsl_asrc_dma_comple=
te, NULL, substream);
>
>         dmaengine_submit(pair->desc[!dir]);
>
> diff --git a/sound/soc/fsl/fsl_asrc_m2m.c b/sound/soc/fsl/fsl_asrc_m2m.c
> index 58101ce07c9f9..c6970a7e88f3f 100644
> --- a/sound/soc/fsl/fsl_asrc_m2m.c
> +++ b/sound/soc/fsl/fsl_asrc_m2m.c
> @@ -176,8 +176,7 @@ static int asrc_dmaconfig(struct fsl_asrc_pair *pair,
>                 return -EINVAL;
>         }
>
> -       pair->desc[dir]->callback =3D ASRC_xPUT_DMA_CALLBACK(dir);
> -       pair->desc[dir]->callback_param =3D pair;
> +       dmaengine_desc_set_callback(pair->desc[dir], ASRC_xPUT_DMA_CALLBA=
CK(dir), NULL, pair);
>
>         return 0;
>  }
> diff --git a/sound/soc/renesas/fsi.c b/sound/soc/renesas/fsi.c
> index 74e2ea002fbb1..fa21cf47befff 100644
> --- a/sound/soc/renesas/fsi.c
> +++ b/sound/soc/renesas/fsi.c
> @@ -1375,8 +1375,7 @@ static int fsi_dma_transfer(struct fsi_priv *fsi, s=
truct fsi_stream *io)
>                 goto fsi_dma_transfer_err;
>         }
>
> -       desc->callback          =3D fsi_dma_complete;
> -       desc->callback_param    =3D io;
> +       dmaengine_desc_set_callback(desc, fsi_dma_complete, NULL, io);
>
>         if (dmaengine_submit(desc) < 0) {
>                 dev_err(dai->dev, "tx_submit() fail\n");
> diff --git a/sound/soc/renesas/siu_pcm.c b/sound/soc/renesas/siu_pcm.c
> index fd5b20b469a4a..7208514e16a43 100644
> --- a/sound/soc/renesas/siu_pcm.c
> +++ b/sound/soc/renesas/siu_pcm.c
> @@ -125,8 +125,7 @@ static int siu_pcm_wr_set(struct siu_port *port_info,
>                 return -ENOMEM;
>         }
>
> -       desc->callback =3D siu_dma_tx_complete;
> -       desc->callback_param =3D siu_stream;
> +       dmaengine_desc_set_callback(desc, siu_dma_tx_complete, NULL, siu_=
stream);
>         cookie =3D dmaengine_submit(desc);
>         if (cookie < 0) {
>                 dev_err(dev, "Failed to submit a dma transfer\n");
> @@ -175,8 +174,7 @@ static int siu_pcm_rd_set(struct siu_port *port_info,
>                 return -ENOMEM;
>         }
>
> -       desc->callback =3D siu_dma_tx_complete;
> -       desc->callback_param =3D siu_stream;
> +       dmaengine_desc_set_callback(desc, siu_dma_tx_complete, NULL, siu_=
stream);
>         cookie =3D dmaengine_submit(desc);
>         if (cookie < 0) {
>                 dev_err(dev, "Failed to submit dma descriptor\n");
> diff --git a/sound/soc/sprd/sprd-pcm-compress.c b/sound/soc/sprd/sprd-pcm=
-compress.c
> index f790b959cd4e4..a810c9c8a0b5b 100644
> --- a/sound/soc/sprd/sprd-pcm-compress.c
> +++ b/sound/soc/sprd/sprd-pcm-compress.c
> @@ -247,8 +247,9 @@ static int sprd_platform_compr_dma_config(struct snd_=
soc_component *component,
>
>         /* Only channel 1 transfer can wake up the AP system. */
>         if (!params->no_wake_mode && channel =3D=3D 1) {
> -               dma->desc->callback =3D sprd_platform_compr_dma_complete;
> -               dma->desc->callback_param =3D cstream;
> +               dmaengine_desc_set_callback(dma->desc,
> +                                           sprd_platform_compr_dma_compl=
ete,
> +                                           NULL, cstream);
>         }
>
>         kfree(sg);
> diff --git a/sound/soc/sprd/sprd-pcm-dma.c b/sound/soc/sprd/sprd-pcm-dma.=
c
> index bbd7516f81954..968901ae4c335 100644
> --- a/sound/soc/sprd/sprd-pcm-dma.c
> +++ b/sound/soc/sprd/sprd-pcm-dma.c
> @@ -287,8 +287,9 @@ static int sprd_pcm_hw_params(struct snd_soc_componen=
t *component,
>                 }
>
>                 if (!runtime->no_period_wakeup) {
> -                       data->desc->callback =3D sprd_pcm_dma_complete;
> -                       data->desc->callback_param =3D dma_private;
> +                       dmaengine_desc_set_callback(data->desc,
> +                                                   sprd_pcm_dma_complete=
,
> +                                                   NULL, dma_private);
>                 }
>         }
>
> diff --git a/sound/soc/stm/stm32_spdifrx.c b/sound/soc/stm/stm32_spdifrx.=
c
> index 88863dbd05d9b..44467a25fb69a 100644
> --- a/sound/soc/stm/stm32_spdifrx.c
> +++ b/sound/soc/stm/stm32_spdifrx.c
> @@ -302,8 +302,7 @@ static int stm32_spdifrx_dma_ctrl_start(struct stm32_=
spdifrx_data *spdifrx)
>         if (!spdifrx->desc)
>                 return -EINVAL;
>
> -       spdifrx->desc->callback =3D stm32_spdifrx_dma_complete;
> -       spdifrx->desc->callback_param =3D spdifrx;
> +       dmaengine_desc_set_callback(spdifrx->desc, stm32_spdifrx_dma_comp=
lete, NULL, spdifrx);
>         cookie =3D dmaengine_submit(spdifrx->desc);
>         err =3D dma_submit_error(cookie);
>         if (err)
> --
> 2.43.0
>

