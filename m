Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AA0606A326
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 06:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=beSpYzuB
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKtFm13JYz2xLt;
	Thu, 05 Nov 2026 17:49:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1036" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793861356;
	cv=pass; b=Ceooi/coIIm7b8mBVaH4iLGx7yiSXYthTP0YY212VSRrdlOIN90j3KNORipy5IOfXBaXuoWjR5GCu9O03CbiGhvPnM5g19Dkn7WDAscPDiYofxdaYPSIz4H3CwbL0jGVzXlkOyQa/5jlMZ9oyaIzjJ+RYqUgF3CTffmKmLW3YpXokraVbFxByCr9MVTRtwWgL7E5v0Z4yYYyVz4poy7J3WQqszsrKbcyjWsFuBz+/YQA3xncP2d2PuQZJT2e+XWPYKwClg7qJcjKJWvaFFR6z3TxD0dfHTSOxELoY5nQELW3EKwgDnq39on2zeQ4bVBuRt0ACtUmM5f0/fU53lOCkA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793861356; c=relaxed/relaxed;
	bh=dqJik3giojyQdxTVlYt/SVYHbelelREmDC0vou6fiGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SpCYvl96UQO01oFGniM1pjqQOCzubLnV/KbvmYwWEuC7ZjpAsG0NVxXrcJjSCcS4G+JYUtnTAoXQyE+RL5pbe5zlT2wjG4vkAvC+O4jIb7CKwn20L8GjirfT635X+IzvVeqm5PuFL+Yt7bu5FzLLsLUUmfXQUsK8UFz3uZFaL6k+eMOrKHPg33A5wdEKmor4V+2VtcpeBZgSDo27XFOhkln0rycLjBPa4Fl2BRUvPzq0iozLi4TTULvDGp0FzutFXVofZcoDZEGiPP1xu1cHwX5gLam9NcLz4J0F1jnkevh8lDr590EhWqyh4i0FYPnNpj3oERsIsecI2HOFfNmD2w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=beSpYzuB; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=beSpYzuB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKtFk6xPkz2xJR
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 17:49:14 +1100 (AEDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-3ae6b4c669fso193457a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 22:49:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793861352; cv=none;
        d=google.com; s=arc-20260327;
        b=MNzGC4u8ubtEGIfwJI7c8e7GdhlIKNUmy2M43f0zfL1097bEdCT/UmK2qdTkuAUjH4
         Sj5WPOrWou7aalCrqCN/lN7C5GvQfMxCmdWtZDS4dXn+PZ6nRB1P7eb3cC/c3zb96M9k
         8kYF3NRjWDnwt+mMB1g0l2uhuiJvG/KPrnKzXAtdPHUGIPrODULzxXJlSeQB9FvlXOgE
         tnmkALsffIddtHZ70iOTMzh0lOq/vzk8EzOt4M52atEo0FXsb8h0mO6bWUpenB8746M9
         mxQ6x+rJjyvYhchK4Vt/tTjVMzD/FKNJ0zVQbOKErmz7ca2ebxk6uasVxxJwbb1vKE5T
         09Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dqJik3giojyQdxTVlYt/SVYHbelelREmDC0vou6fiGs=;
        fh=HjyvJIjk3GK0OiCHb2RRRCAFK6zLAl6pNH3BZ/khyYI=;
        b=LhxPmvbAnruAx7gW9EeGuoSFjz44B3H6ZIQ6C1e/9OJLDw2r+A3vMrFoq047mtxRN9
         1kOgVaG1upDEjAaLMIATSJkX6xFA7wXYFVrTaD/5EHPeliKZkKj/YgbNq4asIihjFyk0
         mBPh33QjAIVZD2yD0KKezuXptcRir6IIK7IaaJrvjBX09kJzdwI+NLIJ3utzZPH0YxWY
         Gx6F/G72hwWKDTakJseGTFXumC+DV6h+g+eNahaaxrWiu7P2AhMimdDNT02di4hbPC/n
         L+p8XTawD0nXzgTdVn77JeEPwv7TksWk45U+P7XTCHKX+0kMGx8sCZpapHaWso/Os0HH
         GIvg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793861352; x=1794466152; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dqJik3giojyQdxTVlYt/SVYHbelelREmDC0vou6fiGs=;
        b=beSpYzuBujUvHP+KAXSspn8T14cQofJC+3uvHKzQx/o9Pxve4pXUq0ATGWCPZmZAdq
         RkN10V/g8FJi6ezWfmCPnF9v+mudrW/9ndLWiyBYihvi4fgsWlXjE1+XwulXq9iiSrPG
         ZbMSITe0nhqb0P5Ho4cE+vQGIAedO30EsMUGdMSdFDbrKqv/bnRmpPjRpY4ZjGCg6Hrf
         4neTE0T4hnFheYiQ6ZZZMq4tJOzlXiHD7dxFZQSlJ5445PMahQKRrJCDsPUSw0ECkuHh
         qZXU7DeUeKQbkr06Yef6+KFqdWj5FJYWJa3fvgAhvtvnZe5sRUb9ORCaas3iXl7WFrAv
         ZDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793861352; x=1794466152;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dqJik3giojyQdxTVlYt/SVYHbelelREmDC0vou6fiGs=;
        b=ZmQ1c7kjLmB6v6HAMewvdNo4ii/mGq+RqdCbcDy2xr9oHHgLHVONGTfpaosvNqTAp6
         NnRGAKSEgyxVU3uEMdtPUPeKsj81Dgevi4My+p7zYAPUEs+252RGucsiriGvm8qgK7a6
         /slDPkM6MJ1Q/NMXzBgwRL+9n34mV6okZ8IReLm6MZmkLqNKZKTbXw/4naL3wDuWY4tZ
         JsjIVgLzZoUrl22uObmTWKtxRlfdSC8R0v3sSG3t8bw5eN9VD2dRbtas4/CWXmIbknvY
         zxHvof8yDp9ggmuf+hgUIFkpU4Nfq1h8/eejljNDRDXAwPVwGoxYzxCLkWnjp0wsjAn2
         wlHg==
X-Forwarded-Encrypted: i=1; AKwUvBwuCF20xHGpGh6/uMfoI2BqC4EaxjHz5sS2ESp2be9DHrAkjuL7F4A0Yf3bWbYbbXrE7l4Yld5bRmASDL0=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z94vj+HIAcMgZJ177RFrsqCtyfE5Ea3O+9oOFiWrVEx3v4900ZL
	o7XafNsUgQL3tvf+04iGXTEyWq0X0gE8NCi4zr74B9Vj7AlMWPHPgNCyITqoYnKh6Rl8B5CQ1gs
	QyWPnb1yiMAcGzQyrQS6pBZ8yeb0dA7Y=
X-Gm-Gg: AYBFou2/01rwyJ72IFS1iPxTOe5SsJRNQYwx+4Aq3N3D63CnZExccYKKKpIgfvcr2ko
	jNojvsicPt1KmMdWFMhJrj5E6zZdYsjvgWJBLch6XZV6cqvzAVXxMXWTtm4Kzd8T+gzLbXZr9PL
	Y75dGj6mxQ5TKWiK8RPTVMnlIEn9b8QBF8w2e9AqUx87LjsjA23A6+VlaNKigFMWRqV4qTECNHL
	nM1z2JOW5jKygUjJfaP1zTpYFaobbMp9she65yta3jaW7eOvYvUe2KWWuuT7v6yTgUiZTqqukR5
	3LwDfkvGvfdGVYbVXvHsDAw2fBjJf+twszLfoUFuLOgCgQjT9Wt0cigjGDmkdFgEx/pvDrc4YZo
	tdgLSPsmHC6KlGJHgmWVZqRimgQRrFqSDLUMd
X-Received: by 2002:a17:90b:5145:b0:3b0:a7b5:c044 with SMTP id
 98e67ed59e1d1-3b0afbf69bamr928353a91.1.1793861351672; Wed, 04 Nov 2026
 22:49:11 -0800 (PST)
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
References: <20261104-imx-sgtl5000-cleanup-v1-1-62739fbb4a25@baylibre.com>
In-Reply-To: <20261104-imx-sgtl5000-cleanup-v1-1-62739fbb4a25@baylibre.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Thu, 5 Nov 2026 14:48:43 +0800
X-Gm-Features: AclHuK9RYtMW40xJ2QKN3LFb2Z1eP_S0Ak6cnyuxLFg7_4CvqzYMgBFsDCsykmE
Message-ID: <CAA+D8AO6dy8Jn+yAaSmdQ2Zh0r_L_ChCAOhpQ-AJh1k+C_usrA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl: imx-sgtl5000: release codec clock right after
 reading its rate
To: Valerio Setti <vsetti@baylibre.com>
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

On Wed, Nov 4, 2026 at 6:48=E2=80=AFPM Valerio Setti <vsetti@baylibre.com> =
wrote:
>
> The 'codec_clk' is only used in 'probe' to read its rate, which is then
> cached in clk_frequency and used by 'imx_sgtl5000_dai_init()'. Holding th=
e
> clk until 'remove()' serves no purpose.
>
> Release the clock right after reading its rate. This allows turning
> 'codec_clk' into a local variable, simplifying the probe error path and
> dropping the 'remove()' callback, which has nothing left to do.
>
> Signed-off-by: Valerio Setti <vsetti@baylibre.com>

Reviewed-by: Shengjiu Wang <shengjiu.wang@gmail.com>

Best regards
Shengjiu Wang
> ---
> While reviewing [1] I realized that the driver could be simplified a bit.
> 'codec_clk' is only used in the 'probe()' function with 'clk_get_rate()',
> so it can be a local variable there. Also it must be put when no more
> used, still in the 'probe()' function.
> This allows to remove 'imx_sgtl5000_remove()'.
>
> This patch does not depend on [1] and they are addressing different thing=
s.
> The two should apply cleanly on 7.4-rc1.
>
> [1] https://lore.kernel.org/all/20261104022815.1484320-1-vulab@iscas.ac.c=
n/
> ---
>  sound/soc/fsl/imx-sgtl5000.c | 24 +++++++-----------------
>  1 file changed, 7 insertions(+), 17 deletions(-)
>
> diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
> index 8bcf54ef709e..032ea3e066bd 100644
> --- a/sound/soc/fsl/imx-sgtl5000.c
> +++ b/sound/soc/fsl/imx-sgtl5000.c
> @@ -20,7 +20,6 @@ struct imx_sgtl5000_data {
>         struct snd_soc_card card;
>         char codec_dai_name[DAI_NAME_SIZE];
>         char platform_name[DAI_NAME_SIZE];
> -       struct clk *codec_clk;
>         unsigned int clk_frequency;
>  };
>
> @@ -54,8 +53,9 @@ static int imx_sgtl5000_probe(struct platform_device *p=
dev)
>         struct device_node *ssi_np, *codec_np;
>         struct platform_device *ssi_pdev;
>         struct i2c_client *codec_dev;
> -       struct imx_sgtl5000_data *data =3D NULL;
> +       struct imx_sgtl5000_data *data;
>         struct snd_soc_dai_link_component *comp;
> +       struct clk *codec_clk;
>         int int_port, ext_port;
>         int ret;
>
> @@ -129,13 +129,14 @@ static int imx_sgtl5000_probe(struct platform_devic=
e *pdev)
>                 goto put_device;
>         }
>
> -       data->codec_clk =3D clk_get(&codec_dev->dev, NULL);
> -       if (IS_ERR(data->codec_clk)) {
> -               ret =3D PTR_ERR(data->codec_clk);
> +       codec_clk =3D clk_get(&codec_dev->dev, NULL);
> +       if (IS_ERR(codec_clk)) {
> +               ret =3D PTR_ERR(codec_clk);
>                 goto put_device;
>         }
>
> -       data->clk_frequency =3D clk_get_rate(data->codec_clk);
> +       data->clk_frequency =3D clk_get_rate(codec_clk);
> +       clk_put(codec_clk);
>
>         data->dai.cpus          =3D &comp[0];
>         data->dai.codecs        =3D &comp[1];
> @@ -185,22 +186,12 @@ static int imx_sgtl5000_probe(struct platform_devic=
e *pdev)
>  put_device:
>         put_device(&codec_dev->dev);
>  fail:
> -       if (data && !IS_ERR(data->codec_clk))
> -               clk_put(data->codec_clk);
>         of_node_put(ssi_np);
>         of_node_put(codec_np);
>
>         return ret;
>  }
>
> -static void imx_sgtl5000_remove(struct platform_device *pdev)
> -{
> -       struct snd_soc_card *card =3D platform_get_drvdata(pdev);
> -       struct imx_sgtl5000_data *data =3D snd_soc_card_get_drvdata(card)=
;
> -
> -       clk_put(data->codec_clk);
> -}
> -
>  static const struct of_device_id imx_sgtl5000_dt_ids[] =3D {
>         { .compatible =3D "fsl,imx-audio-sgtl5000", },
>         { /* sentinel */ }
> @@ -214,7 +205,6 @@ static struct platform_driver imx_sgtl5000_driver =3D=
 {
>                 .of_match_table =3D imx_sgtl5000_dt_ids,
>         },
>         .probe =3D imx_sgtl5000_probe,
> -       .remove =3D imx_sgtl5000_remove,
>  };
>  module_platform_driver(imx_sgtl5000_driver);
>
>
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261104-imx-sgtl5000-cleanup-371e704e5de6
>
> Best regards,
> --
> Valerio Setti <vsetti@baylibre.com>
>

