Return-Path: <B47053@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0249.outbound.messaging.microsoft.com [213.199.154.249])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AB8762C0084
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Oct 2013 18:15:27 +1100 (EST)
From: Xiubo Li-B47053 <B47053@freescale.com>
To: Mark Brown <broonie@kernel.org>
Subject: RE: [PATCHv1 1/8] ALSA: Add SAI SoC Digital Audio Interface driver.
Date: Mon, 28 Oct 2013 07:15:14 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F8286A4FA@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com>
 <20131024110543.GA18506@sirena.org.uk>
In-Reply-To: <20131024110543.GA18506@sirena.org.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "tiwai@suse.de" <tiwai@suse.de>, Wang Huan-B18965 <B18965@freescale.com>,
 "timur@tabi.org" <timur@tabi.org>, "perex@perex.cz" <perex@perex.cz>,
 Guo Shawn-R65073 <r65073@freescale.com>,
 "LW@KARO-electronics.de" <LW@KARO-electronics.de>,
 "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
 Chen Guangyu-B42378 <B42378@freescale.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "grant.likely@linaro.org" <grant.likely@linaro.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "ian.campbell@citrix.com" <ian.campbell@citrix.com>,
 "pawel.moll@arm.com" <pawel.moll@arm.com>,
 "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "oskar@scara.com" <oskar@scara.com>,
 Estevam Fabio-R49496 <r49496@freescale.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rob@landley.net" <rob@landley.net>,
 Jin Zhengxiong-R64188 <R64188@freescale.com>,
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


> > +static struct snd_pcm_hardware snd_fsl_hardware =3D {
> > +	.info =3D SNDRV_PCM_INFO_INTERLEAVED |
> > +		SNDRV_PCM_INFO_BLOCK_TRANSFER |
> > +		SNDRV_PCM_INFO_MMAP |
> > +		SNDRV_PCM_INFO_MMAP_VALID |
> > +		SNDRV_PCM_INFO_PAUSE |
> > +		SNDRV_PCM_INFO_RESUME,
> > +	.formats =3D SNDRV_PCM_FMTBIT_S16_LE,
> > +	.rate_min =3D 8000,
> > +	.channels_min =3D 2,
> > +	.channels_max =3D 2,
> > +	.buffer_bytes_max =3D FSL_SAI_DMABUF_SIZE,
> > +	.period_bytes_min =3D 4096,
> > +	.period_bytes_max =3D FSL_SAI_DMABUF_SIZE / TCD_NUMBER,
> > +	.periods_min =3D TCD_NUMBER,
> > +	.periods_max =3D TCD_NUMBER,
> > +	.fifo_size =3D 0,
> > +};
>=20
> There's a patch in -next that lets the generic dmaengine code figure out
> some settings from the dmacontroller rather than requiring the driver to
> explicitly provide configuration - it's "ASoC: dmaengine-pcm: Provide
> default config".  Please update your driver to use this, or let's work
> out what it doesn't do any try to fix it.
>

I will do a research.
=20
> > +	ret =3D fsl_sai_set_dai_sysclk_tr(cpu_dai, clk_id, freq,
> > +					FSL_FMT_TRANSMITTER);
> > +	if (ret) {
> > +		dev_err(cpu_dai->dev,
> > +				"Cannot set sai's transmitter sysclk: %d\n",
> > +				ret);
> > +		return ret;
> > +	}
> > +
> > +	ret =3D fsl_sai_set_dai_sysclk_tr(cpu_dai, clk_id, freq,
> > +					FSL_FMT_RECEIVER);
>=20
> As other people have commented these should be exposed as separate clocks
> rather than set in sync, unless there's some hardware reason they need to
> be identical.  If that is the case then a comment explaining the
> limitation would be good.
>=20
> Similarly with several of the other functions.
>=20

As I have replied before, there is one function couldn't be separated for t=
he hardware limitation.

> > +int fsl_sai_dai_remove(struct snd_soc_dai *dai) {
> > +	struct fsl_sai *sai =3D dev_get_drvdata(dai->dev);
> > +
> > +	clk_disable_unprepare(sai->clk);
>=20
> It'd be a bit nicer to only enable the clock while the driver is actively
> being used rather than all the time the system is powered up but it's not
> a blocker for merge.
>=20
Actully there are to "XXX_probe" functions and two "XXX_remove" functions:

fsl_sai_dai_probe() and fsl_sai_dai_remove() are callbacks of the ASoC subs=
ystem.
And in fsl_sai_dai_probe() needs to read/write the SAI controller's registe=
rs, so
the clk_enable_prepare() must be here and clk_disable_unprepare() in fsl_sa=
i_dai_remove().

fsl_sai_probe() and fsl_sai_remove() are the driver's probe and remove inte=
rfaces.

So the "+	clk_disable_unprepare(sai->clk);" sentence in fsl_sai_remove() wi=
ll be removed later.


> > +	ret =3D snd_soc_register_component(&pdev->dev, &fsl_component,
> > +			&fsl_sai_dai, 1);
> > +	if (ret)
> > +		return ret;
>=20
> There's a devm_snd_soc_register_component() in -next, please use that.
>=20
See the next version.

> > +
> > +	ret =3D fsl_pcm_dma_init(pdev);
> > +	if (ret)
> > +		goto out;
> > +
> > +	platform_set_drvdata(pdev, sai);
>=20
> These should go before the driver is registered with the subsystem
> otherwise you've got a race where something might try to use the driver
> before init is finished.
>=20
> > +static int fsl_sai_remove(struct platform_device *pdev) {
> > +	struct fsl_sai *sai =3D platform_get_drvdata(pdev);
> > +
> > +	fsl_pcm_dma_exit(pdev);
> > +
> > +	snd_soc_unregister_component(&pdev->dev);
>=20
> Similarly here, unregister from the subsystem then clean up after.
>=20

See the next version.

> > +#define SAI_CR5_FBT(x)		((x) << 8)
> > +#define SAI_CR5_FBT_MASK	(0x1f << 8)
> > +
> > +/* SAI audio dividers */
> > +#define FSL_SAI_TX_DIV		0
> > +#define FSL_SAI_RX_DIV		1
>=20
> Make the namespacing consistent please - for preference use FSL_SAI
> always.
>

See the next version.
