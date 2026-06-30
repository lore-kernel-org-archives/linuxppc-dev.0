Return-Path: <linuxppc-dev+bounces-23190-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ABA3C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 12:34:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqMzW3sJzz2yZ8;
	Tue, 30 Jun 2026 22:34:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::533" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782822887;
	cv=pass; b=YkKZvnqTKagbIDCLU0vTNfpNPk95QDDUjiCK1zyDZZMOpaVNMbgAUQbnWj9svD4iG9p12HY9qtX3+rbcrdHEyvvbTSwMFAPT1/co7XtiTGuxZ1MXp2KHpXcYQGnJoFss8KnAxaUD7/5GwiP/xn+kxeX0oCm/Puhn5swGvmb2IMRnV7f28cp92hdgjV0uQRpClgBJOLgUHeyzqliop2JuVI51HmWPoQkwleuYG0jNgDCYXjQnVdWz0PHABbrOS5ATL94K5rlpGOeaqe4yZA2wqv21Q7rprUYD7//EdZp3ybKLEWlCxfcN14yWM25JTJ8U+mq+f1b7kgEgDf8K/L/yIQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782822887; c=relaxed/relaxed;
	bh=8cTZGQWdZGBUbtMIqk3jv7rpPUO86WUjTSNnrFYPk0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jyLKnfWTVHKR8TE0/4SH5G87qxa3mgEdv27rEVCn2X7TKMtc/t7uwuhWYgxK12WY5Mj2gySaAS8V6TTdo+PXx/h06X+d6M5phmNBONrHErbflIT3xBkH8nKo3JR5AieRoOVZkaQeMIhcyoLDRbd57R2pV14ki86mZfhjyaxPIT7y+TI4FaomXmhvdGs+HZYH/D0k10XJAfafZ+/UTYZJCO5jZts1vzta3vcscBWrGGQ5gVMV2g1NgKM7Prn2ofFVg3Fz+FIQGjpKATgPrJZiCyguEQ/3D64p285Jd3jPKeRIZwu/7Rql6sQTaxhlF3cTf90U7GsQ4qMamHzSurHzyg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OiuQ56HG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OiuQ56HG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqMzT6sF9z2xyk
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 22:34:44 +1000 (AEST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-c969ad04c1dso907693a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 05:34:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782822882; cv=none;
        d=google.com; s=arc-20260327;
        b=gfo/EfVXA9owA04lrvTV66xyE0vTvyDUVNo9c+so6vzZWzcju48mz7qH0VyX+U9lyb
         Vg38Lak2biiuUv3pl/keb2Rg75JlIQ71dvqCqax4y4i+snxIe65l2l/Itrf3xUhb1QwW
         y3zktN7hjfWsbTOI2Iv/Nr8Zei7dKGRGEAwokMz96VOAaKtVz2reZX44SEswV555xRao
         pp4gxm19jZmaymMrwQpwz0A5SN+/ryupT79sS8lzLDk5WuPFljt1ReIouHGhVIAGu1yS
         tVs2IPj11bAUUDN4RWkKGSfEfWqxDr+WvihnWRnf/kXO65Xz+EX2o89YcpyMnsSYmcVq
         +Bsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8cTZGQWdZGBUbtMIqk3jv7rpPUO86WUjTSNnrFYPk0E=;
        fh=wDIkIbSOe+KKzaMB7SYvTMKV8pztirjMnc/+yoa88rA=;
        b=jMGxw3pJ5h+sa4lbdaMNsZ6hzcLG00Sr5B1yaeLACv/UCszBJzuUyX8PMk9tI6tOZo
         ChOc2bYymI5mVmOB6vE0sZIWWovAoRSPw8afpxuqfuoUl+VOiUfwI+AL5fOquZvzce6G
         duWp2GRQtsCSpnKgxWpAlMNMjA/RADuFTKS8Zk7I0nfDa0foAF8Vmhil8GgG0IMr62iD
         r684+payczx87J0z02UVlIbQnJJx5s1fF/Rs8c+TYWiDPslQvuqTxl0SDdBSBSyMt/0u
         Y1GkTR1EEb9MGTxHSrOLoLNnGkt12mHzVc27K4I6cm/UxNUkDsq1THKaA26w2uQUE/Qx
         v91A==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782822882; x=1783427682; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cTZGQWdZGBUbtMIqk3jv7rpPUO86WUjTSNnrFYPk0E=;
        b=OiuQ56HGy62BRx4pioD+j/0Yi5+IG7n0NQ1AvZ3f0kzSUNxYMdemqVnQoADFaWRAEw
         edxdL2k6Bv+gXEcyKJszgTiUbl1rUaAa98XRFH1zHZKgdaxZXyEd8PZNTYj6qMmrqrrE
         PqVOzSqyWG9PGSnw9O7vhStJOKnjMfuaXTXm7QsP3bVuCWEhuwhOEE7mXdSciZr29v+t
         XIl3zCuTu10X3QWFFGV2cawDeKL//SNLgk3nha8Dhk9zFv4WOofTbcxWnOWlD9IFlLVH
         RBYJXz6oXvyjPIIISSaTUGS6ORRW9H10TVtNC+mOm0xH9vklqkSxyQaEyJ4fntMjsbIl
         wVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782822882; x=1783427682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8cTZGQWdZGBUbtMIqk3jv7rpPUO86WUjTSNnrFYPk0E=;
        b=Cr5gcMOPC8TeLGk+6+/obsZT71n4yU1Y51Hqh8VzwycEoUC+OSxk1nQbt8DxAGv91z
         B+HPSKeu3KVrmCAeO+8LOc/HRP4fGbb2LNMmDtufNc4g66HYqn8zjKsjvOVLFtlWE1gT
         J+oVIkbCogDENRJwYjnVfVwAqmM6WtWNCzsiK+UWZJ3nWZsNQaHTsO72p8gL729D11M8
         dFFZn9S4ojgpTGMgWLpu7mGSBjpOiG7/VS8PlIR0VwWlWI9CEgmay3vEMn02J1MSQkIO
         sT2MGSYAkEHDsNKOhlR0sD0pEQFoiS2BsquEwS1fEJHdTa5jG/aqRtcCi/rvZS+MknhT
         CnKQ==
X-Forwarded-Encrypted: i=1; AFNElJ/8QkjjcnTAZhRZ+Rrhg1wNrc1fcFQmhQICTrID2xZYdHaJX/A65skTB2FjhVkfjqyqyawhcQOso1X8lRo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwJuTy9dkH8073WVc9X/7Y4cGaASsytpBC4uFIH9eotxA7yQtZc
	fgHEG0RGEhHl8kVWSryIQZcv2BdkWgV44sSZoEhStTuj748Dw69nM9r+zSMpUTz8nSxESc0QMcB
	AXOld8lzkbEBtJvLGwrWfd+SYEKvPDKY=
X-Gm-Gg: AfdE7cmtMHpn8Lpmgoz5nGyoKiC7T4svMxs3xJ7d7EIHoHuw8f5746plYhpkbDgtvgf
	vLi9DiIU0S+YMx0PD6+nVh17HEYM/uKMuCmJ0zKJI18Kc0l3mFaNushXJTbmrIfXPzD07Dg7npn
	4HCM8g3I6x7Y8GVMTmuFwUat6sAAP4DUNvXNUp5Jk8eZGmj4HKnRQBLLUao4E2KeDWZhK3bV8j0
	tJ83Dhf5IRIU3LgoFrTiW0HIj3jP03veGBsx6pCeD0evK+0vQEpKV4BnELlIRrZLHqmDPsW5rsC
	NDvI7A==
X-Received: by 2002:a05:6a21:730c:b0:3bf:8604:9a3c with SMTP id
 adf61e73a8af0-3bfdc6960a0mr159009637.28.1782822881873; Tue, 30 Jun 2026
 05:34:41 -0700 (PDT)
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
References: <20260618023818.31618-1-shengjiu.wang@oss.nxp.com>
In-Reply-To: <20260618023818.31618-1-shengjiu.wang@oss.nxp.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 30 Jun 2026 20:34:13 +0800
X-Gm-Features: AVVi8CfAJzmiJgX_RFr2-7EAvsuYt47fANCiqBHiroPWd01EydFM7sAOdVTrYjk
Message-ID: <CAA+D8AOqc_OBopHQBFDjvLiZLD0EnfpzFsgFcSnb1kdbZxhDew@mail.gmail.com>
Subject: Re: [PATCH V2] ASoC: fsl_audmix: rework runtime PM handling in probe
To: shengjiu.wang@oss.nxp.com
Cc: Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com, 
	lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, 
	linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 10:33=E2=80=AFAM <shengjiu.wang@oss.nxp.com> wrote:
>
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
>
> After pm_runtime_enable() the AUDMIX block is powered off and stays
> suspended until the first runtime resume. Register writes issued between
> probe() and the first resume (e.g. from DAPM or ALSA control paths)
> target unpowered hardware and cause a system hang.
>
> Fix this by calling pm_runtime_resume_and_get() immediately after
> pm_runtime_enable() to power the hardware up and enable its clocks.
> Release the reference afterwards with pm_runtime_put() to allow the
> runtime PM framework to suspend the device and switch the regmap to
> cache-only mode when idle.
>
> When CONFIG_PM is disabled or runtime PM is not enabled, pm_runtime_*
> calls are stubs that do not power up the hardware. Handle this case
> explicitly by calling fsl_audmix_runtime_resume() directly so the
> hardware is always initialised and its clocks are enabled, ensuring
> register accesses succeed regardless of PM configuration.
>
> Fixes: be1df61cf06ef ("ASoC: fsl: Add Audio Mixer CPU DAI driver")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
> Changes in v2:
> - remove the call of regcache_cache_only in probe, rework the runtime
>   handling in probe, call the pm_runtime_put() to enable the cache only.
> - refine the commit message
>
>  sound/soc/fsl/fsl_audmix.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_audmix.c b/sound/soc/fsl/fsl_audmix.c
> index f819f33ec46b..2885cc10b02d 100644
> --- a/sound/soc/fsl/fsl_audmix.c
> +++ b/sound/soc/fsl/fsl_audmix.c
> @@ -457,6 +457,9 @@ static const struct of_device_id fsl_audmix_ids[] =3D=
 {
>  };
>  MODULE_DEVICE_TABLE(of, fsl_audmix_ids);
>
> +static int fsl_audmix_runtime_resume(struct device *dev);
> +static int fsl_audmix_runtime_suspend(struct device *dev);
> +
>  static int fsl_audmix_probe(struct platform_device *pdev)
>  {
>         struct device *dev =3D &pdev->dev;
> @@ -488,13 +491,25 @@ static int fsl_audmix_probe(struct platform_device =
*pdev)
>         spin_lock_init(&priv->lock);
>         platform_set_drvdata(pdev, priv);
>         pm_runtime_enable(dev);
> +       if (!pm_runtime_enabled(dev)) {
> +               ret =3D fsl_audmix_runtime_resume(dev);
> +               if (ret)
> +                       goto err_disable_pm;
> +       }
> +
> +       ret =3D pm_runtime_resume_and_get(dev);
> +       if (ret < 0)
> +               goto err_pm_get_sync;
> +
> +       /* To enable regmap cache only when runtime PM enabled */
> +       pm_runtime_put(dev);

Check the comments from Sashiko. Needs to use pm_runtime_put_sync to
avoid the race
of asynchronous.
Will send the next version.

Best regards
Shengjiu Wang
>
>         ret =3D devm_snd_soc_register_component(dev, &fsl_audmix_componen=
t,
>                                               fsl_audmix_dai,
>                                               ARRAY_SIZE(fsl_audmix_dai))=
;
>         if (ret) {
>                 dev_err(dev, "failed to register ASoC DAI\n");
> -               goto err_disable_pm;
> +               goto err_pm_get_sync;
>         }
>
>         /*
> @@ -506,12 +521,15 @@ static int fsl_audmix_probe(struct platform_device =
*pdev)
>                 if (IS_ERR(priv->pdev)) {
>                         ret =3D PTR_ERR(priv->pdev);
>                         dev_err(dev, "failed to register platform: %d\n",=
 ret);
> -                       goto err_disable_pm;
> +                       goto err_pm_get_sync;
>                 }
>         }
>
>         return 0;
>
> +err_pm_get_sync:
> +       if (!pm_runtime_status_suspended(dev))
> +               fsl_audmix_runtime_suspend(dev);
>  err_disable_pm:
>         pm_runtime_disable(dev);
>         return ret;
> @@ -522,6 +540,8 @@ static void fsl_audmix_remove(struct platform_device =
*pdev)
>         struct fsl_audmix *priv =3D dev_get_drvdata(&pdev->dev);
>
>         pm_runtime_disable(&pdev->dev);
> +       if (!pm_runtime_status_suspended(&pdev->dev))
> +               fsl_audmix_runtime_suspend(&pdev->dev);
>
>         if (priv->pdev)
>                 platform_device_unregister(priv->pdev);
> --
> 2.34.1
>

