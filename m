Return-Path: <Li.Xiubo@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0203.outbound.protection.outlook.com [207.46.163.203])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AC21A1400A4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Apr 2014 20:43:26 +1100 (EST)
From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
To: "guangyu.chen@freescale.com" <guangyu.chen@freescale.com>
Subject: RE: [PATCH 1/2] ASoC: fsl_sai: Add clock control for SAI
Date: Fri, 4 Apr 2014 09:43:12 +0000
Message-ID: <f713ce2310f44ef883194429ba97d4a8@BY2PR03MB505.namprd03.prod.outlook.com>
References: <cover.1396352401.git.Guangyu.Chen@freescale.com>
 <87d225a25812d730c0865f9d0bb733c67d8b3ed1.1396352401.git.Guangyu.Chen@freescale.com>
 <49295d4f0f0f42c4b9c6de77583b978e@BY2PR03MB505.namprd03.prod.outlook.com>
 <20140404092804.GA2735@MrMyself>
In-Reply-To: <20140404092804.GA2735@MrMyself>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "pawel.moll@arm.com" <pawel.moll@arm.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
 "timur@tabi.org" <timur@tabi.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "broonie@kernel.org" <broonie@kernel.org>, "rob@landley.net" <rob@landley.net>,
 "galak@codeaurora.org" <galak@codeaurora.org>,
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

> Subject: Re: [PATCH 1/2] ASoC: fsl_sai: Add clock control for SAI
>=20
> Hi Xiubo,
>=20
> On Fri, Apr 04, 2014 at 05:24:39PM +0800, Xiubo Li-B47053 wrote:
> > Hi,
> >
> > I have test this series on my Vybrid-TWR board and it works happily.
>=20
> You just checked the wrong version. I've sent a mail to let people disreg=
ard
> this version and a newer v2.
>=20

Sorry, I didn't receive these, I will search it in the web page.

> >
> > [...]
> > > diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> > > index 3847d2a..2d749df 100644
> > > --- a/sound/soc/fsl/fsl_sai.c
> > > +++ b/sound/soc/fsl/fsl_sai.c
> > > @@ -428,5 +428,18 @@ static int fsl_sai_startup(struct snd_pcm_substr=
eam
> > > *substream,
> > >  {
> > >  	struct fsl_sai *sai =3D snd_soc_dai_get_drvdata(cpu_dai);
> > > -	u32 reg;
> > > +	struct device *dev =3D &sai->pdev->dev;
> > > +	u32 reg, ret;
> > > +
> >
> > I'd prefer:
> >   +	int ret;
>=20
> Just like last time I said, it would be converted to 'int' any way. There=
's
> no much difference between them.
>=20

Yes, it is...

I have ever encounter something like this in the feature maybe someone will
do the following check:

If (ret < 0)
	...

Just one potential problem and one suggestion.

Thanks,


> >
> > > +	ret =3D clk_prepare_enable(sai->ipg_clk);
> > > +	if (ret) {
> > > +		dev_err(dev, "failed to prepare and enable ipg clock\n");
> > > +		return ret;
> > > +	}
> > > +
> >
> > [...]
> >
> > > @@ -609,5 +630,5 @@ static int fsl_sai_probe(struct platform_device *=
pdev)
> > >
> > >  	sai->regmap =3D devm_regmap_init_mmio_clk(&pdev->dev,
> > > -			"sai", base, &fsl_sai_regmap_config);
> > > +			"ipg", base, &fsl_sai_regmap_config);
> > >  	if (IS_ERR(sai->regmap)) {
> > >  		dev_err(&pdev->dev, "regmap init failed\n");
> > > @@ -615,4 +636,16 @@ static int fsl_sai_probe(struct platform_device =
*pdev)
> > >  	}
> > >
> > > +	sai->ipg_clk =3D devm_clk_get(&pdev->dev, "ipg");
> > > +	if (IS_ERR(sai->ipg_clk)) {
> > > +		dev_err(&pdev->dev, "failed to get ipg clock\n");
> > > +		return PTR_ERR(sai->ipg_clk);
> > > +	}
> > > +
> >
> > Since the 'ipg' clock is just intend to be used for registers accessing=
 and
> > We are using the regmap_init_mmio_clk(), so we can just drop it here an=
d
> > Let the regmap APIs to do the clock options properly.
>=20
> This 'ipg' clock, which I renamed in v2 to 'bus clock', is not just used
> in the way you said but also able to drive bit clock as your own code in
> the fsl_sai_set_dai_sysclk_tr(), and as reference manual describes:
>=20
> 52.3.1.3 Bus clock
> The bus clock is used by the control and configuration registers and to
> generate synchronous interrupts and DMA requests.
>=20
> Thanks,
> Nicolin
>=20
> >
> > Otherwise it look good to me.
> >
> > After this:
> > Acked-by: Xiubo Li <Li.Xiubo@freescale.com>
> >
> >
> >
> > Thanks,
> >
> > Brs,
> > Xiubo
> >
> >
> >
> >
> > > +	sai->sai_clk =3D devm_clk_get(&pdev->dev, "sai");
> > > +	if (IS_ERR(sai->sai_clk)) {
> > > +		dev_err(&pdev->dev, "failed to get sai clock\n");
> > > +		return PTR_ERR(sai->sai_clk);
> > > +	}
> > > +
> > >  	irq =3D platform_get_irq(pdev, 0);
> > >  	if (irq < 0) {
> > > diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
> > > index 677670d..cbaf114 100644
> > > --- a/sound/soc/fsl/fsl_sai.h
> > > +++ b/sound/soc/fsl/fsl_sai.h
> > > @@ -127,4 +127,6 @@ struct fsl_sai {
> > >  	struct platform_device *pdev;
> > >  	struct regmap *regmap;
> > > +	struct clk *ipg_clk;
> > > +	struct clk *sai_clk;
> > >
> > >  	bool big_endian_regs;
> > > --
> > > 1.8.4
> > >
> >
