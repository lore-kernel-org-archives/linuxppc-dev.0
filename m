Return-Path: <B47053@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3FB2A2C008F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Nov 2013 18:35:23 +1100 (EST)
From: Li Xiubo <B47053@freescale.com>
To: Mark Brown <broonie@kernel.org>
Subject: RE: [PATCHv2 1/8] ALSA: Add SAI SoC Digital Audio Interface driver.
Date: Mon, 4 Nov 2013 07:35:12 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F8287439D@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-2-git-send-email-Li.Xiubo@freescale.com>
 <20131101182514.GE2493@sirena.org.uk>
In-Reply-To: <20131101182514.GE2493@sirena.org.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "tiwai@suse.de" <tiwai@suse.de>, Huan Wang <B18965@freescale.com>,
 "timur@tabi.org" <timur@tabi.org>, "perex@perex.cz" <perex@perex.cz>,
 Shawn Guo <r65073@freescale.com>,
 "LW@KARO-electronics.de" <LW@KARO-electronics.de>,
 "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
 Guangyu Chen <B42378@freescale.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "grant.likely@linaro.org" <grant.likely@linaro.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "ian.campbell@citrix.com" <ian.campbell@citrix.com>,
 "pawel.moll@arm.com" <pawel.moll@arm.com>,
 "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "oskar@scara.com" <oskar@scara.com>, Fabio Estevam <r49496@freescale.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rob@landley.net" <rob@landley.net>, Zhengxiong Jin <R64188@freescale.com>,
 "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > +static int fsl_sai_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
> > +		int div_id, int div)
> > +{
> > +	struct fsl_sai *sai =3D snd_soc_dai_get_drvdata(cpu_dai);
> > +	u32 tcr2, rcr2;
> > +
> > +	if (div_id =3D=3D FSL_SAI_TX_DIV) {
> > +		tcr2 =3D readl(sai->base + FSL_SAI_TCR2);
> > +		tcr2 &=3D ~FSL_SAI_CR2_DIV_MASK;
> > +		tcr2 |=3D FSL_SAI_CR2_DIV(div);
> > +		writel(tcr2, sai->base + FSL_SAI_TCR2);
>=20
> What is this divider and why does the user have to set it manually?
>=20

This is the bit clock divider. I'll add some comments or rename them to be =
more readable.
>From the IP spec:
++++++
Bit Clock Divide
Divides down the audio master clock to generate the bit clock when configur=
ed for an internal bit clock.
------

>From the ASoC subsystem comments we can see that:
++++++
Configures the clock dividers. This is used to derive the best DAI bit and
frame clocks from the system or master clock. It's best to set the DAI bit
and frame clocks as low as possible to save system power.
------


> > +static int fsl_sai_dai_probe(struct snd_soc_dai *dai) {
> > +	int ret;
> > +	struct fsl_sai *sai =3D dev_get_drvdata(dai->dev);
> > +
> > +	ret =3D clk_prepare_enable(sai->clk);
> > +	if (ret)
> > +		return ret;
>=20
> It'd be nicer to only enable the clock while the device is in active use.
>=20

While if the module clock is not enabled here, the followed registers canno=
t read/write in the same function.
And this _probe function is the _dai_probe not the driver's module _probe.

If the clk_prepare_enable(sai->clk) is not here, where should it be will be=
 nicer ?
One of the following functions ?
        .set_sysclk     =3D fsl_sai_set_dai_sysclk,
        .set_clkdiv     =3D fsl_sai_set_dai_clkdiv,
        .set_fmt        =3D fsl_sai_set_dai_fmt,
        .set_tdm_slot   =3D fsl_sai_set_dai_tdm_slot,
        .hw_params      =3D fsl_sai_hw_params,
        .trigger        =3D fsl_sai_trigger,


> > +	ret =3D snd_dmaengine_pcm_register(&pdev->dev, NULL,
> > +			SND_DMAENGINE_PCM_FLAG_NO_RESIDUE);
> > +	if (ret)
> > +		return ret;
>=20
> We should have a devm_ version of this.

Sorry, is there one patch for adding the devm_ version of snd_dmaengine_pcm=
_register() already ?
In the -next and other topics branches I could not find it.



Best Regards,
Xiubo
