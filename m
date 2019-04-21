Return-Path: <SRS0=M5iZ=SX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870B6C10F14
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 07:28:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A09912087F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 07:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/2xkpcA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A09912087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44n1XZ1S6ZzDqTm
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 17:28:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com;
 envelope-from=daniel.baluta@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="K/2xkpcA"; 
 dkim-atps=neutral
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44n1Vt39hGzDqP0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Apr 2019 17:27:00 +1000 (AEST)
Received: by mail-ed1-x542.google.com with SMTP id d46so7359920eda.7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Apr 2019 00:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RwZZBuIT2g03XvndH8sbHe1AHIfLw+gx2oqC1JgvpJQ=;
 b=K/2xkpcAw8XJTQUSiBs2SyTT/7muXOLLGwSYcHLc2ShR6wJKQI/AmnzvhT2A7kXaR9
 OEM2xGCX1KPIjD1+5j6kYKr1+ToIXED4xZPLeYzjDuUJfYIFLOKJa02dfqjO+lQAPGCZ
 DQ8j5MUuwU4hcd9BG6Jof4WedjEed46fISr8Hq4JP2V5IGqbRhk8mdDpC8jpgpWDgmKt
 +5TfSf/eR8WWxZ2iBwHUiAT5vtfgVAbI60/+XcfHccEXsqan34Cm9v8QZkbTzjGDpxF4
 wgGFA5ze5MvbW/7TKAvCHUIxGRJRWKMfhO65ss1rjjsV7JW5Ng298GGvhdsURGN65MGH
 BZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RwZZBuIT2g03XvndH8sbHe1AHIfLw+gx2oqC1JgvpJQ=;
 b=DwM9vSuOG49+811xgvN0MoKfp+PLBA8WMUilVMj+K4qfN1HAyA8wrzHkrBrItXByMx
 Won6IUaTZe3F5pvHwM0hHu4er/3puc4NSc5mm3ELQJIOFH7BawZgkBAg0HxdvXJO0JKY
 CtHWxWo6CZ61ktG5BAgQhcb/7DOsYVBcVmxE+ytdBHjEAgDJ3uKlKq0nUmQTIFTcO2+m
 BstVuAc/Hxu1N1EMXutS795MUXAukGiVSPLGWZi3ipG9joLBBw7St7/f4iFlwahUUqcO
 d1LjYNQ921OS5l9nBFUPG10vrpAdm4iJx53G/5nzEPPEyeT+C7iFT3B/kfu/6a0zvVW1
 7KaA==
X-Gm-Message-State: APjAAAXqpZDoQd6zFdh+PWCE1rcDIscAvYLjlGCGaDpMGpFC3neFGW8V
 RE67t3VO0K5sfePhgyY+iGB+Hrwm8HudkEUjL+A=
X-Google-Smtp-Source: APXvYqxggNugDIuULEBiz552LV0+9dAU5xeg7x8xr9MIygiKGvjSoS2+wN3yYPbKSRRz/V7mLD4J/Jfsjo0Eximyyrk=
X-Received: by 2002:a50:a3c2:: with SMTP id t2mr8188138edb.46.1555831612567;
 Sun, 21 Apr 2019 00:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190420154038.14576-1-daniel.baluta@nxp.com>
 <20190421053749.GA5552@Asurada>
In-Reply-To: <20190421053749.GA5552@Asurada>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Sun, 21 Apr 2019 10:26:40 +0300
Message-ID: <CAEnQRZDs_gnS8ehjM2M_y+Yw0Ge-Sq=A2c9BV-g=P_d0+O40hQ@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl: sai: Fix clock source for mclk0
To: Nicolin Chen <nicoleotsuka@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>,
 "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Nicolin,

Thanks for review!

On Sun, Apr 21, 2019 at 8:39 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> By following the pattern of previous Subjects:
> ASoC: fsl_sai: Fix clock Source for mclk0

I see. Will fix in v2.

>
> On Sat, Apr 20, 2019 at 03:41:04PM +0000, Daniel Baluta wrote:
> > SAI provide multiple master clock source options selectable
> > via bit MSEL of TCR2/RCR2.
> >
> > All possible master clock sources are stored in sai->mclk_clk
> > array. Current implementation assumes that MCLK0 source is always
> > busclk, but this is wrong!
> >
> > For example, on i.MX8QM we have:
> >
> > 00b - Bus Clock selected.
> > 01b - Master Clock (MCLK) 1 option selected.
> > 10b - Master Clock (MCLK) 2 option selected.
> > 11b - Master Clock (MCLK) 3 option selected.
> >
> > while on i.MX6SX we have:
> >
> > 00b - Master Clock (MCLK) 1 option selected.
> > 01b - Master Clock (MCLK) 1 option selected.
> > 10b - Master Clock (MCLK) 2 option selected.
> > 11b - Master Clock (MCLK) 3 option selected.
> >
> > So, this patch will read mclk0 source clock from device tree.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  sound/soc/fsl/fsl_sai.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> > index d2a4dc744fd7..faa8de87ff83 100644
> > --- a/sound/soc/fsl/fsl_sai.c
> > +++ b/sound/soc/fsl/fsl_sai.c
> > @@ -829,8 +829,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
> >               sai->bus_clk = NULL;
> >       }
> >
> > -     sai->mclk_clk[0] = sai->bus_clk;
> > -     for (i = 1; i < FSL_SAI_MCLK_MAX; i++) {
> > +     for (i = 0; i < FSL_SAI_MCLK_MAX; i++) {
> >               sprintf(tmp, "mclk%d", i);
>
> Firstly, according to your commit message, neither imx8qm nor
> imx6sx has an "mclk0" clock in the clock list. Either of them
> starts with "mclk1". So, before you change the driver, I don't
> think it's even a right thing to define an "mclk0" in the DT.

From what I understand mclk0 means option 00b of MSEL bits which is:
* busclk for i.MX8
* mclk1 for i.MX6/7.

Adding a mclk0 in the DT and making it point to the correct option
(busclk or mclk1) does no harm as the driver doesn't yet parse mclk0.

I have already sent a patch to add mclk0 to imx6/7 DTS here:

https://lkml.org/lkml/2019/4/20/56

So, even if the DT change gets accepted first there shouldn't pe any
problem, as the driver won't parse mclk0 string yet.

Even if the current patch gets accepted first it shouldn't be any problem
also as the probe will try to find "mclk0" in the DT and will just print a
warning and move on looking for mclk1, mclk2...

>
> >               sai->mclk_clk[i] = devm_clk_get(&pdev->dev, tmp);
> >               if (IS_ERR(sai->mclk_clk[i])) {
>
> Secondly, this would break existing DT bindings of imx6sx and
> imx7 platforms as they both have clock-names defined in DTB:
>         clock-names = "bus", "mclk1", "mclk2", "mclk3";
> Since there's no "mclk0", the entire probe() would error-out.

Not exactly. The probe won't error-out. It will just print a warning message

dev_err(&pdev->dev, "failed to get mclk%d clock: %ld\n"

and move on.

The functionality, will still be the same.

> And mainline has a DT backward-compatible policy, which means
> you can't just rename the "bus" in the DTBs but would have to
> support them, not to mention "mclk0" is still questionable.

My patch doesn't rename "bus" in the DTB. "bus" clock stays there. It just
adds another clock "mclk0".

In my opinion, the current implementation of fsl_sai has a bug for imx6/7.

Currently, fsl_sai.c driver does:

       sai->mclk_clk[0] = sai->bus_clk;

is wrong, because on imx6/7 mclk_clk[0] should point to the same clk
as mclk_clk[1]


>
> So the right way to fix it is, in my option, to differentiate
> the mclk_clk[0] clock source name with the compatible string.
> Then you can get the clock name and simply do:
> -       sai->mclk_clk[0] = sai->bus_clk;
> +       sai->mclk_clk[0] = devm_clk_get(&pdev->dev, tmp);
> +       if (IS_ERR(sai->mclk_clk[0)) {
> +               /* error-out*/
> +       }

My approach is to add mclk0 in the DT and make it point to:
* busclk for i.MX8
* mclk1 for i.MX6/7.

So, here it is how the DT nodes will look like:

$ arch/arm/boot/dts/imx6sx.dtsi

clocks = <&clks IMX6SX_CLK_SAI1_IPG>,
   <&clks IMX6SX_CLK_SAI1>,
    <&clks IMX6SX_CLK_SAI1>,
    <&clks 0>, <&clks 0>;
clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";

$ arch/arm64/boot/dts/freescale/fsl-imx8mq.dtsi
clocks = <&clk IMX8MQ_CLK_SAI2_IPG>,
             <&clk  IMX8MQ_CLK_SAI2_IPG>,
             <&clk IMX8MQ_CLK_SAI2_ROOT>,
             <&clk IMX8MQ_CLK_DUMMY>, <&clk IMX8MQ_CLK_DUMMY>;
clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";

This approach makes busclk/mclk0 handling generic and avoids the looking
for compatible strings.

thanks,
Daniel.
