Return-Path: <michael@amarulasolutions.com>
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com
 [209.85.212.178])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E0FC41A0441
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Sep 2014 06:02:55 +1000 (EST)
Received: by mail-wi0-f178.google.com with SMTP id ho1so1283029wib.17
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 13:02:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <894383e00876763f22988fc5f3f9f232f939f923.1410517971.git.shengjiu.wang@freescale.com>
References: <894383e00876763f22988fc5f3f9f232f939f923.1410517971.git.shengjiu.wang@freescale.com>
Date: Fri, 12 Sep 2014 22:02:50 +0200
Message-ID: <CAOf5uwmvoy-8q9RqSXBz_bCZK5gXWgfJ7Ghm+7zUYjPnGzxRYw@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH V3] ASoC: fsl_ssi: refine ipg clock usage in
 this module
From: Michael Trimarchi <michael@amarulasolutions.com>
To: Shengjiu Wang <shengjiu.wang@freescale.com>
Content-Type: multipart/alternative; boundary=f46d043749a50c92330502e3c59a
Cc: alsa-devel@alsa-project.org, timur@tabi.org, tiwai@suse.de,
 linux-kernel@vger.kernel.org, broonie@kernel.org, lgirdwood@gmail.com,
 perex@perex.cz, nicoleotsuka@gmail.com, Li.Xiubo@freescale.com,
 mpa@pengutronix.de, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--f46d043749a50c92330502e3c59a
Content-Type: text/plain; charset=UTF-8

Hi

Il 12/set/2014 14:18 "Shengjiu Wang" <shengjiu.wang@freescale.com> ha
scritto:
>
> Check if ipg clock is in clock-names property, then we can move the
> ipg clock enable and disable operation to startup and shutdown, that
> is only enable ipg clock when ssi is working and keep clock is disabled
> when ssi is in idle.
> But when the checking is failed, remain the clock control as before.
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
> ---
> V3 change log:
> update patch according Nicolin and markus's comments
>
>
>  sound/soc/fsl/fsl_ssi.c |   53
++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 45 insertions(+), 8 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index 2fc3e66..6d1dfd5 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -169,6 +169,7 @@ struct fsl_ssi_private {
>         u8 i2s_mode;
>         bool use_dma;
>         bool use_dual_fifo;
> +       bool has_ipg_clk_name;
>         unsigned int fifo_depth;
>         struct fsl_ssi_rxtx_reg_val rxtx_reg_val;
>
> @@ -530,6 +531,11 @@ static int fsl_ssi_startup(struct snd_pcm_substream
*substream,
>         struct snd_soc_pcm_runtime *rtd = substream->private_data;
>         struct fsl_ssi_private *ssi_private =
>                 snd_soc_dai_get_drvdata(rtd->cpu_dai);
> +       int ret;
> +
> +       ret = clk_prepare_enable(ssi_private->clk);
> +       if (ret)
> +               return ret;
>
>         /* When using dual fifo mode, it is safer to ensure an even period
>          * size. If appearing to an odd number while DMA always starts its
> @@ -544,6 +550,21 @@ static int fsl_ssi_startup(struct snd_pcm_substream
*substream,
>  }
>
>  /**
> + * fsl_ssi_shutdown: shutdown the SSI
> + *
> + */
> +static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
> +                             struct snd_soc_dai *dai)
> +{
> +       struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +       struct fsl_ssi_private *ssi_private =
> +               snd_soc_dai_get_drvdata(rtd->cpu_dai);
> +
> +       clk_disable_unprepare(ssi_private->clk);
> +
> +}
> +
> +/**
>   * fsl_ssi_set_bclk - configure Digital Audio Interface bit clock
>   *
>   * Note: This function can be only called when using SSI as DAI master
> @@ -1043,6 +1064,7 @@ static int fsl_ssi_dai_probe(struct snd_soc_dai
*dai)
>
>  static const struct snd_soc_dai_ops fsl_ssi_dai_ops = {
>         .startup        = fsl_ssi_startup,
> +       .shutdown       = fsl_ssi_shutdown,
>         .hw_params      = fsl_ssi_hw_params,
>         .hw_free        = fsl_ssi_hw_free,
>         .set_fmt        = fsl_ssi_set_dai_fmt,
> @@ -1168,17 +1190,22 @@ static int fsl_ssi_imx_probe(struct
platform_device *pdev,
>         u32 dmas[4];
>         int ret;
>
> -       ssi_private->clk = devm_clk_get(&pdev->dev, NULL);
> +       if (ssi_private->has_ipg_clk_name)
> +               ssi_private->clk = devm_clk_get(&pdev->dev, "ipg");
> +       else
> +               ssi_private->clk = devm_clk_get(&pdev->dev, NULL);
>         if (IS_ERR(ssi_private->clk)) {
>                 ret = PTR_ERR(ssi_private->clk);
>                 dev_err(&pdev->dev, "could not get clock: %d\n", ret);
>                 return ret;
>         }
>
> -       ret = clk_prepare_enable(ssi_private->clk);
> -       if (ret) {
> -               dev_err(&pdev->dev, "clk_prepare_enable failed: %d\n",
ret);
> -               return ret;
> +       if (!ssi_private->has_ipg_clk_name) {
> +               ret = clk_prepare_enable(ssi_private->clk);
> +               if (ret) {
> +                       dev_err(&pdev->dev, "clk_prepare_enable failed:
%d\n", ret);
> +                       return ret;
> +               }
>         }
>
>         /* For those SLAVE implementations, we ingore non-baudclk cases
> @@ -1236,8 +1263,9 @@ static int fsl_ssi_imx_probe(struct platform_device
*pdev,
>         return 0;
>
>  error_pcm:
> -       clk_disable_unprepare(ssi_private->clk);
>
> +       if (!ssi_private->has_ipg_clk_name)
> +               clk_disable_unprepare(ssi_private->clk);
>         return ret;
>  }
>
> @@ -1246,7 +1274,8 @@ static void fsl_ssi_imx_clean(struct
platform_device *pdev,
>  {
>         if (!ssi_private->use_dma)
>                 imx_pcm_fiq_exit(pdev);
> -       clk_disable_unprepare(ssi_private->clk);
> +       if (!ssi_private->has_ipg_clk_name)
> +               clk_disable_unprepare(ssi_private->clk);
>  }
>
>  static int fsl_ssi_probe(struct platform_device *pdev)
> @@ -1321,8 +1350,16 @@ static int fsl_ssi_probe(struct platform_device
*pdev)
>                 return -ENOMEM;
>         }
>
> -       ssi_private->regs = devm_regmap_init_mmio(&pdev->dev, iomem,
> +       ret = of_property_match_string(np, "clock-names", "ipg");
> +       if (ret < 0) {
> +               ssi_private->has_ipg_clk_name = false;

It's false already.

Michael

> +               ssi_private->regs = devm_regmap_init_mmio(&pdev->dev,
iomem,
>                         &fsl_ssi_regconfig);
> +       } else {
> +               ssi_private->has_ipg_clk_name = true;
> +               ssi_private->regs = devm_regmap_init_mmio_clk(&pdev->dev,
> +                       "ipg", iomem, &fsl_ssi_regconfig);
> +       }
>         if (IS_ERR(ssi_private->regs)) {
>                 dev_err(&pdev->dev, "Failed to init register map\n");
>                 return PTR_ERR(ssi_private->regs);
> --
> 1.7.9.5
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--f46d043749a50c92330502e3c59a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Hi</p>
<p dir=3D"ltr">Il 12/set/2014 14:18 &quot;Shengjiu Wang&quot; &lt;<a href=
=3D"mailto:shengjiu.wang@freescale.com">shengjiu.wang@freescale.com</a>&gt;=
 ha scritto:<br>
&gt;<br>
&gt; Check if ipg clock is in clock-names property, then we can move the<br=
>
&gt; ipg clock enable and disable operation to startup and shutdown, that<b=
r>
&gt; is only enable ipg clock when ssi is working and keep clock is disable=
d<br>
&gt; when ssi is in idle.<br>
&gt; But when the checking is failed, remain the clock control as before.<b=
r>
&gt;<br>
&gt; Signed-off-by: Shengjiu Wang &lt;<a href=3D"mailto:shengjiu.wang@frees=
cale.com">shengjiu.wang@freescale.com</a>&gt;<br>
&gt; ---<br>
&gt; V3 change log:<br>
&gt; update patch according Nicolin and markus&#39;s comments<br>
&gt;<br>
&gt;<br>
&gt; =C2=A0sound/soc/fsl/fsl_ssi.c |=C2=A0 =C2=A053 +++++++++++++++++++++++=
+++++++++++++++++-------<br>
&gt; =C2=A01 file changed, 45 insertions(+), 8 deletions(-)<br>
&gt;<br>
&gt; diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c<br>
&gt; index 2fc3e66..6d1dfd5 100644<br>
&gt; --- a/sound/soc/fsl/fsl_ssi.c<br>
&gt; +++ b/sound/soc/fsl/fsl_ssi.c<br>
&gt; @@ -169,6 +169,7 @@ struct fsl_ssi_private {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 i2s_mode;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool use_dma;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool use_dual_fifo;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0bool has_ipg_clk_name;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int fifo_depth;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct fsl_ssi_rxtx_reg_val rxtx_reg_val;<=
br>
&gt;<br>
&gt; @@ -530,6 +531,11 @@ static int fsl_ssi_startup(struct snd_pcm_substre=
am *substream,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct snd_soc_pcm_runtime *rtd =3D substr=
eam-&gt;private_data;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct fsl_ssi_private *ssi_private =3D<br=
>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 snd_soc_dai_ge=
t_drvdata(rtd-&gt;cpu_dai);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D clk_prepare_enable(ssi_private-&gt=
;clk);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br=
>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* When using dual fifo mode, it is safer =
to ensure an even period<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* size. If appearing to an odd numbe=
r while DMA always starts its<br>
&gt; @@ -544,6 +550,21 @@ static int fsl_ssi_startup(struct snd_pcm_substre=
am *substream,<br>
&gt; =C2=A0}<br>
&gt;<br>
&gt; =C2=A0/**<br>
&gt; + * fsl_ssi_shutdown: shutdown the SSI<br>
&gt; + *<br>
&gt; + */<br>
&gt; +static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct snd_soc_dai *dai)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct snd_soc_pcm_runtime *rtd =3D substr=
eam-&gt;private_data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct fsl_ssi_private *ssi_private =3D<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0snd_soc_dai_ge=
t_drvdata(rtd-&gt;cpu_dai);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0clk_disable_unprepare(ssi_private-&gt;clk)=
;<br>
&gt; +<br>
&gt; +}<br>
&gt; +<br>
&gt; +/**<br>
&gt; =C2=A0 * fsl_ssi_set_bclk - configure Digital Audio Interface bit cloc=
k<br>
&gt; =C2=A0 *<br>
&gt; =C2=A0 * Note: This function can be only called when using SSI as DAI =
master<br>
&gt; @@ -1043,6 +1064,7 @@ static int fsl_ssi_dai_probe(struct snd_soc_dai =
*dai)<br>
&gt;<br>
&gt; =C2=A0static const struct snd_soc_dai_ops fsl_ssi_dai_ops =3D {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 .startup=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D fs=
l_ssi_startup,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0.shutdown=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D fs=
l_ssi_shutdown,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 .hw_params=C2=A0 =C2=A0 =C2=A0 =3D fsl_ssi=
_hw_params,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 .hw_free=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D fs=
l_ssi_hw_free,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 .set_fmt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D fs=
l_ssi_set_dai_fmt,<br>
&gt; @@ -1168,17 +1190,22 @@ static int fsl_ssi_imx_probe(struct platform_d=
evice *pdev,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 dmas[4];<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0ssi_private-&gt;clk =3D devm_clk_get(&amp;=
pdev-&gt;dev, NULL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ssi_private-&gt;has_ipg_clk_name)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ssi_private-&g=
t;clk =3D devm_clk_get(&amp;pdev-&gt;dev, &quot;ipg&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ssi_private-&g=
t;clk =3D devm_clk_get(&amp;pdev-&gt;dev, NULL);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (IS_ERR(ssi_private-&gt;clk)) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D PTR_ER=
R(ssi_private-&gt;clk);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&amp;p=
dev-&gt;dev, &quot;could not get clock: %d\n&quot;, ret);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br=
>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D clk_prepare_enable(ssi_private-&gt=
;clk);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;p=
dev-&gt;dev, &quot;clk_prepare_enable failed: %d\n&quot;, ret);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ssi_private-&gt;has_ipg_clk_name) {<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D clk_pr=
epare_enable(ssi_private-&gt;clk);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0dev_err(&amp;pdev-&gt;dev, &quot;clk_prepare_enable failed: %=
d\n&quot;, ret);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* For those SLAVE implementations, we ing=
ore non-baudclk cases<br>
&gt; @@ -1236,8 +1263,9 @@ static int fsl_ssi_imx_probe(struct platform_dev=
ice *pdev,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;<br>
&gt; =C2=A0error_pcm:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0clk_disable_unprepare(ssi_private-&gt;clk)=
;<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ssi_private-&gt;has_ipg_clk_name)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clk_disable_un=
prepare(ssi_private-&gt;clk);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt; =C2=A0}<br>
&gt;<br>
&gt; @@ -1246,7 +1274,8 @@ static void fsl_ssi_imx_clean(struct platform_de=
vice *pdev,<br>
&gt; =C2=A0{<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ssi_private-&gt;use_dma)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 imx_pcm_fiq_ex=
it(pdev);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0clk_disable_unprepare(ssi_private-&gt;clk)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ssi_private-&gt;has_ipg_clk_name)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clk_disable_un=
prepare(ssi_private-&gt;clk);<br>
&gt; =C2=A0}<br>
&gt;<br>
&gt; =C2=A0static int fsl_ssi_probe(struct platform_device *pdev)<br>
&gt; @@ -1321,8 +1350,16 @@ static int fsl_ssi_probe(struct platform_device=
 *pdev)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM=
;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0ssi_private-&gt;regs =3D devm_regmap_init_=
mmio(&amp;pdev-&gt;dev, iomem,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D of_property_match_string(np, &quot=
;clock-names&quot;, &quot;ipg&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ssi_private-&g=
t;has_ipg_clk_name =3D false;</p>
<p dir=3D"ltr">It&#39;s false already.</p>
<p dir=3D"ltr">Michael<br></p>
<p dir=3D"ltr">&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0ssi_private-&gt;regs =3D devm_regmap_init_mmio(&amp;pdev-&gt;dev, iomem,=
<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &amp;fsl_ssi_regconfig);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ssi_private-&g=
t;has_ipg_clk_name =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ssi_private-&g=
t;regs =3D devm_regmap_init_mmio_clk(&amp;pdev-&gt;dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0&quot;ipg&quot;, iomem, &amp;fsl_ssi_regconfig);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (IS_ERR(ssi_private-&gt;regs)) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&amp;p=
dev-&gt;dev, &quot;Failed to init register map\n&quot;);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return PTR_ERR=
(ssi_private-&gt;regs);<br>
&gt; --<br>
&gt; 1.7.9.5<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; Alsa-devel mailing list<br>
&gt; <a href=3D"mailto:Alsa-devel@alsa-project.org">Alsa-devel@alsa-project=
.org</a><br>
&gt; <a href=3D"http://mailman.alsa-project.org/mailman/listinfo/alsa-devel=
">http://mailman.alsa-project.org/mailman/listinfo/alsa-devel</a><br>
</p>

--f46d043749a50c92330502e3c59a--
