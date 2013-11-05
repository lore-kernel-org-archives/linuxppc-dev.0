Return-Path: <B47053@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 125E72C0141
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Nov 2013 14:21:59 +1100 (EST)
From: Li Xiubo <B47053@freescale.com>
To: Mark Brown <broonie@kernel.org>
Subject: RE: [PATCHv2 1/8] ALSA: Add SAI SoC Digital Audio Interface driver.
Date: Tue, 5 Nov 2013 03:21:49 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F82875482@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-2-git-send-email-Li.Xiubo@freescale.com>
 <20131101182514.GE2493@sirena.org.uk>
 <1DD289F6464F0949A2FCA5AA6DC23F8287439D@039-SN2MPN1-013.039d.mgd.msft.net>
 <20131104161537.GI2493@sirena.org.uk>
In-Reply-To: <20131104161537.GI2493@sirena.org.uk>
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

> > From the ASoC subsystem comments we can see that:
> > ++++++
> > Configures the clock dividers. This is used to derive the best DAI bit
> > and frame clocks from the system or master clock. It's best to set the
> > DAI bit and frame clocks as low as possible to save system power.
> > ------
>=20
> You should never use this unless you have to, there is no point in every
> single machine driver using your driver having to duplicate the same
> calculations.
>=20

Okey, I'll think it over, if not have to, I will revise this.

> >
> > > > +static int fsl_sai_dai_probe(struct snd_soc_dai *dai) {
> > > > +	int ret;
> > > > +	struct fsl_sai *sai =3D dev_get_drvdata(dai->dev);
> > > > +
> > > > +	ret =3D clk_prepare_enable(sai->clk);
> > > > +	if (ret)
> > > > +		return ret;
>=20
> > > It'd be nicer to only enable the clock while the device is in active
> use.
>=20
> > While if the module clock is not enabled here, the followed registers
> cannot read/write in the same function.
> > And this _probe function is the _dai_probe not the driver's module
> _probe.
>=20
> So you can enable the clock when you explicitly need to write to the
> registers...
>=20
> > If the clk_prepare_enable(sai->clk) is not here, where should it be
> will be nicer ?
> > One of the following functions ?
> >         .set_sysclk     =3D fsl_sai_set_dai_sysclk,
> >         .set_clkdiv     =3D fsl_sai_set_dai_clkdiv,
> >         .set_fmt        =3D fsl_sai_set_dai_fmt,
> >         .set_tdm_slot   =3D fsl_sai_set_dai_tdm_slot,
> >         .hw_params      =3D fsl_sai_hw_params,
> >         .trigger        =3D fsl_sai_trigger,
>=20
> It could be in any or all of them except trigger (where the core should
> hold a runtime PM reference anyway).  You can always take a reference for
> the duration of the function if you're concerned it may be called when
> the referent isn't otherwise held.
>=20

While in this _sai_dai_probe function just followed the clock enable senten=
ce, there are some register writing operations:
The PATCH:
+++++++++++++++++++++++
+static int fsl_sai_dai_probe(struct snd_soc_dai *dai) {
+	int ret;
+	struct fsl_sai *sai =3D dev_get_drvdata(dai->dev);
+
+	ret =3D clk_prepare_enable(sai->clk);                     =3D=3D=3D=3D=3D=
> clock enable here
+	if (ret)
+		return ret;
+
+	writel(0x0, sai->base + FSL_SAI_RCSR);			  =3D=3D=3D=3D=3D=3D>registers w=
riting here.
+	writel(0x0, sai->base + FSL_SAI_TCSR);			  =3D=3D=3D=3D=3D=3D> and here
+	writel(sai->dma_params_tx.maxburst, sai->base + FSL_SAI_TCR1); =3D=3D=3D=
=3D=3D=3D=3D>and here
+	writel(sai->dma_params_rx.maxburst, sai->base + FSL_SAI_RCR1); =3D=3D=3D=
=3D=3D=3D=3D>and here
+
+	dai->playback_dma_data =3D &sai->dma_params_tx;
+	dai->capture_dma_data =3D &sai->dma_params_rx;
+
+	snd_soc_dai_set_drvdata(dai, sai);
+
+	return 0;
+}
-------------------------

As your opinions, should I move the four register writing operations to .se=
t_sysclk/set_clkdiv/... functions too ?
Or just add a clk_disable_unprepare() after them here, and then add clk_pre=
pare_enable in one of .set_sysclk/set_clkdiv/...?

And the first two of this four registers must be initialize as early as pos=
sible, and if move them to one of the .set_sysclk/set_clkdiv/... functions,
How can I very ensure which one is the first to be called ?
Won't the calling sequence be changed in the feature ?

>From the debug logs, we can see that:
1, _sai_probe
This is called when the machine brings up and has one SAI device.

2, _sai_dai_probe
3, .set_sysclk
4, .set_fmt
Are called in order when the machine has Audio driver and is enabled, and a=
lso while the machine brings up.

The above four steps only be called one time in order.

When aplay/arecord is runs the following will be called in order:
5, .set_tdm_slot
6, .hw_param
7, .trigger -->begain=20
8, .trigger --> end

The 2,3,4 are always called almost the same time, and they are all have reg=
ister read/write operations.
Now the clk_prepare_enable() is in step 2, and it won't be any different mo=
ving to step 3 or 4.

So, only could move it to step 5 or 6, if so every time the aplay/arecord r=
uns, clk_prepare_enable() will be
called, and there has no chance to call clk_disable_unprepare().

Now from the code we can see that I have add clk_prepare_enable() in _sai_d=
ai_probe() and clk_disable_unprepare() in _sai_dai_remove().
Isn't this okey ?



> > > > +	ret =3D snd_dmaengine_pcm_register(&pdev->dev, NULL,
> > > > +			SND_DMAENGINE_PCM_FLAG_NO_RESIDUE);
> > > > +	if (ret)
> > > > +		return ret;
>=20
> > > We should have a devm_ version of this.
>=20
> > Sorry, is there one patch for adding the devm_ version of
> snd_dmaengine_pcm_register() already ?
> > In the -next and other topics branches I could not find it.
>=20
> No, there isn't one but there should be one.
>
And if it has existed then I will use it.




BRs,
Xiubo
