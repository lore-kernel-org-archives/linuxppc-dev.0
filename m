Return-Path: <linuxppc-dev+bounces-24081-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 892EBC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 03:22:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gz75g48Vyz2xjN;
	Mon, 13 Jul 2026 13:21:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::62e" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783912919;
	cv=pass; b=Y6/Hkkenl+nWjCdwbEZkz1zj9kEKBcwCqOOoez88NvXd//UMwenZQdCxpQy+xKLIbctExQa/qFGkedolNN7kPU66/w3oQrE3oMFRvgs6NpS0el07emSWjYEFWDHaZfGJWgl0ZhpL1bPJ4p+40lWYHN291R4vdSnZJYOZzSizIhVZOVevpK7IX06Tf0qtWXr6/1E01P/pMt6jQ1gV4ofZOnjjrZwqq6pOJTi6PYbH9zwoG2vyD6Qa+4M1MD25RTQHzjZlTOpC4mL+Fq0uelPD4To2WKvND2uoqep694kWM3SqR7OhNXVFLF7i0wXcCDyxlZQ+6kbXFgpzuj/wYG3gKg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783912919; c=relaxed/relaxed;
	bh=TSFFP+nKaR0576Boh3573ftrq0odrZqheyrYVqgy2zI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krEIr+nMvYcMHaXMcn6kjQywZjomunoYh8MJ0gXkUVxUZEweG1wqDDGdg/PORqhZnCQrEVmKUg56rp9r+kmHo0PmJKIYzEXKAkD+uhTbWJzS3nv+pWNO0egKD90DjjJi/Ib7QkQtfMvtMC6ER0T+/rAbuSHn/qHnk7P0Q6Ss8ofNshZaDzRj1kcW3dCegU0DvPLnVxlyMNQpwzq7QUKW4M2UmCVLdBr2I4CWOdjZnw+sn5uz1cH6WBbWuDRyUIHmUnfEHVd0xVLuLNi4zdiEmVLXuNgu3IuNSe8fS7axyTeO2h5nNf+Hz/pgVZy5bqIBJORnhfhnSf0NpW3vyOJEAA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZrZ0bYal; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZrZ0bYal;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gz75f1fdXz2xWP
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 13:21:57 +1000 (AEST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2ca64c3ce5fso30297255ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Jul 2026 20:21:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783912915; cv=none;
        d=google.com; s=arc-20260327;
        b=L3eKVSuHEv80XxAZVK8yp1rlHyoZLcAaSoj1ZBlgK+1QvsHUtR6xCs9ZPs4JMKuBjn
         swoueECibGLh/oDY9RncBUrPJjvMoCkbgEkAMdNpm7PtgtPG20dKpMl3a04G3tuhtKJ/
         gw18fc9OZo57nBTtpkGUS+KB0RwHvtG6w+9Z6qdGZJ09m2dvzgZbjyPPX+HVfLb72G36
         j4HO8iPR1iheLB/JwahBPSL9TMa1VB3LtQcLLUhCbHREKePX4pAK+GL2pG7H9HCCC8gL
         RN6GJ35+59BLJzYk0Dx/xBqWi/6oEAsTcUm9phn7q7QE6pk2dxDVliv6B8nl35DnLR3f
         vUtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TSFFP+nKaR0576Boh3573ftrq0odrZqheyrYVqgy2zI=;
        fh=ztDZ5SzDPjkjs3NCFg1HSmZTqs6UCKPb6KUqYAD5ooU=;
        b=ZKQXPO4Gxan93GavwNQFTXW6axxH5emE+9DVrBYIAHSajPqA2JlenxmwP01KCFwzHg
         opkOHhZzYB/Cjt1N93EJylMtz7QvUad3Zq2xkCLT6pMaZM4UHU1a8Afy1we4X3Vj2tyQ
         rGfh5+IMff/7EQJt6pQzUdAe3Ln1E8ltrQGy50bigMt5Guys9yGRVRvxlmVgcWX5CVac
         sf+mC/Wsi8DjRcqNAhgwzzG4xXNCyTXGkxki7fZ6coHtfArJ0DXzzuOMNAy/3iGvMf9V
         x7cjGfrv9c8fgviFd5pV26A/wscfl63J368fNvixfc3Uh7auWkRUDzsHEh3lC9n+qFl8
         jQcA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783912915; x=1784517715; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TSFFP+nKaR0576Boh3573ftrq0odrZqheyrYVqgy2zI=;
        b=ZrZ0bYalNbuT56bzKiJn9c5RdkAjzsepZlBnxTUMveJJ/Gmcts1GpieT/Y5FK941AU
         2b6DvzvZ6Z7ZyNP8rzE3Nb97f5YGdNa9rS9u8mukAJ+ADvVX2l8VDKJwGz7JWEZC6WhD
         AAeuU0n6Mox2Y4d1o5f6lo4CQVznR0UZpOs846r4pKY1KO0O/Oh0y1ar7K32+T8R/hgb
         wDkgWCU7HQK35Cm5PG+cf8me7iy0G70clcobQyC86p84R1wPjlAcxQ/iZ15dlpf53SKk
         VfoSeSEmPRw52GNfOCuuZ7Uukq+PqDXhguwWBMDnnHF/E12eRQ2sq7py5CHjsWGtof2L
         INoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783912915; x=1784517715;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TSFFP+nKaR0576Boh3573ftrq0odrZqheyrYVqgy2zI=;
        b=NJyVPfuwvlUVXGd3KowD1HIxgQdw+krjvs2Ph6aWA4HDJBOn8AuWGSi2D7zTiEYydT
         3Ow4/qXFouRC6CUFsJ6bj/DWkLC36GqrX6pDETEdz9e+UCnTUTvD/YbPu5PfY6urNnzf
         h2zaOmG0onnMyIsEPUOruJHTtHO6L8n+P8YfOiJRGw1WG+FXkqSDOMNNX/z48vu6QMCX
         ftn4sifm08CajmZxalh3N2NTOa9PwTF/ZPACLVc4DsCECpLurQgk8ZPWFhnWUGHUl3Mr
         SabA63nF5xdH4SgStcZdmL6DrE2VAf+jy+ciSQhZ88vItyjL6e5UJvewVhAi+Ceb0EoW
         XS2g==
X-Forwarded-Encrypted: i=1; AHgh+RpS/PSSiULB+PFPkbXH2hH4UtzIcQm4k38YnWDBzsoKTZqC1I8WQdS5WoWlWdtN5PumG8mUowDgC3ZQ5Qo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw6o8ZlHsZJDxQKt+w+7fHltiZfvDK+rH1EadGSBWh8/RyCUfKk
	KZDS6tJnYHw7en+WwXmsfz2/dYBpdT9HCP+JrEA9X/EkBbfoBjPPF/kzQ5jiI4eXzWNK5I6o53f
	DorJ6+D+772lYjMQGPrjIrVjgLW2rAS0=
X-Gm-Gg: AfdE7cmXEjB06I1Hlf0HujVoTfSeBol82joiT1StqYefCaSAypllNvYAylmM415Jg0B
	KPmzKj99oidakqg+mktWk/xBsTi7zW4xiJ3F05Y0BN4gw9IpwirjmxT1v9v4Zc7H7ix7xtTEi0/
	y0mO+qa0Xjl99Nztwe2i93c5xWeXyKGaNEop+acm1ksOqzp90sXeb6A94F+mEVt43hK2TVBmJJh
	oDzL4YLpP0Pm6khenPqM+M8lbW6XKudRnsfU8UrAmUIKswndRWKzI91R9Gu8x4EcSRxsurw
X-Received: by 2002:a17:903:b07:b0:2c9:d298:6c06 with SMTP id
 d9443c01a7336-2ce9f0268c4mr76691645ad.25.1783912915142; Sun, 12 Jul 2026
 20:21:55 -0700 (PDT)
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
References: <20260710070835.3749817-1-chancel.liu@oss.nxp.com>
In-Reply-To: <20260710070835.3749817-1-chancel.liu@oss.nxp.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Mon, 13 Jul 2026 11:21:37 +0800
X-Gm-Features: AVVi8CfYC_2UaQWz1pfB01RpZjLtZ5yJ4xkwVm543r8qOjus-QVMl3YHjma3FUk
Message-ID: <CAA+D8ANi1LKZmFeZ8bFd2LovAoaL-RrcV-6seaV9DNLGMcB59Q@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: fsl_sai: Fix spurious BCLK on resume by clearing BYP
To: Chancel Liu <chancel.liu@oss.nxp.com>
Cc: Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com, 
	lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 3:08=E2=80=AFPM Chancel Liu <chancel.liu@oss.nxp.co=
m> wrote:
>
> From: Chancel Liu <chancel.liu@nxp.com>
>
> When the BCLK divider ratio is 1:1, fsl_sai_set_bclk() enables bypass
> mode by setting BYP, but never clears the bit. The BYP=3D1 value remains
> in the regcache, and is restored by regcache_sync() on the next runtime
> resume.
>
> Since BYP=3D1 combined with BCD=3D1 immediately outputs the ungated MCLK
> as BCLK without waiting for BCE/TE/RE to be enabled, the clock is
> driven prematurely before the stream is fully configured, causing
> noise on some codecs.
>
> Fix this by clearing BYP and BCI in fsl_sai_hw_free() taking into
> account sync mode and the opposite stream's state, so that the regcache
> holds BYP=3D0 before runtime suspend and regcache_sync() on resume will
> not restore bypass mode prematurely.
>
> Fixes: a50b7926d015 ("ASoC: fsl_sai: implement 1:1 bclk:mclk ratio suppor=
t")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>

Thanks for the update.

Reviewed-by: Shengjiu Wang <shengjiu.wang@gmail.com>

Best regards
Shengjiu Wang
> ---
> Changes in v2:
> - Move BYP/BCI clearing from fsl_sai_config_disable() (trigger path)
>   to fsl_sai_hw_free() to avoid breaking pause/suspend-resume cycles
>   where hw_params() is not called again on unpause/resume.
>
>  sound/soc/fsl/fsl_sai.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 9661602b53c5..d232c8f53061 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -808,6 +808,8 @@ static int fsl_sai_hw_free(struct snd_pcm_substream *=
substream,
>         struct fsl_sai *sai =3D snd_soc_dai_get_drvdata(cpu_dai);
>         bool tx =3D substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK;
>         unsigned int ofs =3D sai->soc_data->reg_offset;
> +       int adir =3D tx ? RX : TX;
> +       int dir  =3D tx ? TX : RX;
>
>         /* Clear xMR to avoid channel swap with mclk_with_tere enabled ca=
se */
>         regmap_write(sai->regmap, FSL_SAI_xMR(tx), 0);
> @@ -815,10 +817,29 @@ static int fsl_sai_hw_free(struct snd_pcm_substream=
 *substream,
>         regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx, ofs),
>                            FSL_SAI_CR3_TRCE_MASK, 0);
>
> -       if (!sai->is_consumer_mode[tx] &&
> -           sai->mclk_streams & BIT(substream->stream)) {
> -               clk_disable_unprepare(sai->mclk_clk[sai->mclk_id[tx]]);
> -               sai->mclk_streams &=3D ~BIT(substream->stream);
> +       if (!sai->is_consumer_mode[tx]) {
> +               bool adir_active =3D !!(sai->mclk_streams & BIT(!substrea=
m->stream));
> +               /*
> +                * If opposite stream provides clocks for synchronous mod=
e and
> +                * it is inactive, Clear BYP and BCI
> +                */
> +               if (fsl_sai_dir_is_synced(sai, adir) && !adir_active)
> +                       regmap_update_bits(sai->regmap, FSL_SAI_xCR2(!tx,=
 ofs),
> +                                          FSL_SAI_CR2_BCI | FSL_SAI_CR2_=
BYP, 0);
> +               /*
> +                * Clear BYP and BCI of current stream if either of:
> +                * 1. current stream doesn't provide clocks for synchrono=
us mode
> +                * 2. current stream provides clocks for synchronous mode=
 but no
> +                *    more stream is active.
> +                */
> +               if (!fsl_sai_dir_is_synced(sai, dir) || !adir_active)
> +                       regmap_update_bits(sai->regmap, FSL_SAI_xCR2(tx, =
ofs),
> +                                          FSL_SAI_CR2_BCI | FSL_SAI_CR2_=
BYP, 0);
> +
> +               if (sai->mclk_streams & BIT(substream->stream)) {
> +                       clk_disable_unprepare(sai->mclk_clk[sai->mclk_id[=
tx]]);
> +                       sai->mclk_streams &=3D ~BIT(substream->stream);
> +               }
>         }
>
>         return 0;
> --
> 2.50.1
>

