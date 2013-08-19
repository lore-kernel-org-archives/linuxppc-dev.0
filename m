Return-Path: <R65777@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0D5B82C0182
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 14:38:20 +1000 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Chen Guangyu-B42378 <B42378@freescale.com>
Subject: RE: [PATCH v6 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Date: Mon, 19 Aug 2013 04:38:11 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D07116BA7@039-SN2MPN1-013.039d.mgd.msft.net>
References: <cover.1376657643.git.b42378@freescale.com>
 <df3c09cd5679649b144bb45dfd5fc746628266d4.1376657643.git.b42378@freescale.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D07114BC3@039-SN2MPN1-013.039d.mgd.msft.net>
 <20130819030743.GA10544@MrMyself>
In-Reply-To: <20130819030743.GA10544@MrMyself>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lars@metafoo.de" <lars@metafoo.de>,
 "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "timur@tabi.org" <timur@tabi.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
 "festevam@gmail.com" <festevam@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Chen Guangyu-B42378
> Sent: Monday, August 19, 2013 8:38 AM
> To: Bhushan Bharat-R65777
> Cc: broonie@kernel.org; lars@metafoo.de; p.zabel@pengutronix.de;
> s.hauer@pengutronix.de; mark.rutland@arm.com; devicetree@vger.kernel.org;=
 alsa-
> devel@alsa-project.org; swarren@wwwdotorg.org; festevam@gmail.com;
> timur@tabi.org; rob.herring@calxeda.com; tomasz.figa@gmail.com;
> shawn.guo@linaro.org; linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH v6 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
>=20
> Hi Bhushan,
>=20
>    Thank you for the comments :)
>    I'll fix some in v7.
>=20
>    Here is my some replies to you.
>=20
> On Sat, Aug 17, 2013 at 02:24:19AM +0800, Bhushan Bharat-R65777 wrote:
> > > This patch add S/PDIF controller driver for Freescale SoC.
> >
> > Please give some more description of the driver?
>=20
> I've referred some ASoC drivers, all of them seem to be brief as mine.
> So I'm not sure what else information I should provide here. It's already=
 kinda
> okay to me.

Other does not have description does not mean we also should not add descri=
ption here.
Please describe in few lines about this driver and devices it handles?

>=20
>=20
> > > +struct spdif_mixer_control {
> > > +	/* buffer ptrs for writer */
> > > +	u32 upos;
> > > +	u32 qpos;
> >
> > They does not look like pointer?
>=20
> They are more like offsets to get the correspond pointer.
> But I'll change the confusing comments.
>=20
>=20
> > > +/* U/Q Channel receive register full */ static void
> > > +spdif_irq_uqrx_full(struct fsl_spdif_priv *spdif_priv, char name) {
> > > +	struct spdif_mixer_control *ctrl =3D &spdif_priv->fsl_spdif_control=
;
> > > +	struct regmap *regmap =3D spdif_priv->regmap;
> > > +	struct platform_device *pdev =3D spdif_priv->pdev;
> > > +	u32 *pos, size, val, reg;
> > > +
> > > +	switch (name) {
> > > +	case 'U':
> > > +		pos =3D &ctrl->upos;
> > > +		size =3D SPDIF_UBITS_SIZE;
> > > +		reg =3D REG_SPDIF_SRU;
> > > +		break;
> > > +	case 'Q':
> > > +		pos =3D &ctrl->qpos;
> > > +		size =3D SPDIF_QSUB_SIZE;
> > > +		reg =3D REG_SPDIF_SRQ;
> > > +		break;
> > > +	default:
> > > +		return;
> >
> > Should return error.
>=20
> IMHO, this should be fine. It's a void type function and being used in th=
e
> isr(). The params 'name' is totally controlled by driver itself, so basic=
ally we
> don't need to worry about the default path.

Silently returning on potential error is bad. At least add a printk/BUGON o=
r something similar which points that some unexpected parameter is passed.

>=20
> > > +	if (*pos >=3D size * 2) {
> > > +		*pos =3D 0;
> > > +	} else if (unlikely((*pos % size) + 3 > size)) {
> > > +		dev_err(&pdev->dev, "User bit receivce buffer overflow\n");
> > > +		return;
> >
> > Should return error.
>=20
> Ditto, it's being used in isr(), we don't need to detect the return value=
, just
> use dev_err() to warn users and let the driver clear the irq.

Same as above

>=20
>=20
> > > +/* U/Q Channel framing error */
> > > +static void spdif_irq_uq_err(struct fsl_spdif_priv *spdif_priv) {
> > > +	struct spdif_mixer_control *ctrl =3D &spdif_priv->fsl_spdif_control=
;
> > > +	struct regmap *regmap =3D spdif_priv->regmap;
> > > +	struct platform_device *pdev =3D spdif_priv->pdev;
> > > +	u32 val;
> > > +
> > > +	dev_dbg(&pdev->dev, "isr: U/Q Channel framing error\n");
> > > +
> > > +	/* read U/Q data and do buffer reset */
> > > +	regmap_read(regmap, REG_SPDIF_SRU, &val);
> > > +	regmap_read(regmap, REG_SPDIF_SRQ, &val);
> >
> > Above prints says read u/q data and buffer reset, what is buffer reset?=
 Is
> that read on clear?
>=20
> That's the behavior needed by IP, according to the reference manual:
> "U Channel receive register full, can't be cleared with reg. IntClear.
> To clear it, read from U Rx reg." and "Q Channel receive register full, c=
an't be
> cleared with reg. IntClear. To clear it, read from Q Rx reg."

Then please add this behavior in comment.

>=20
>=20
> > > +static void spdif_softreset(struct fsl_spdif_priv *spdif_priv) {
> > > +	struct regmap *regmap =3D spdif_priv->regmap;
> > > +	u32 val, cycle =3D 1000;
> > > +
> > > +	regmap_write(regmap, REG_SPDIF_SCR, SCR_SOFT_RESET);
> > > +	regcache_sync(regmap);
> > > +
> > > +	/* RESET bit would be cleared after finishing its reset procedure *=
/
> > > +	do {
> > > +		regmap_read(regmap, REG_SPDIF_SCR, &val);
> > > +	} while ((val & SCR_SOFT_RESET) && cycle--);
> >
> > What if reset is not cleared and timeout happen?
>=20
> We here suppose the reset bit would be cleared -- "The software reset wil=
l last
> 8 cycles." from RM, so if this happened to be a failure, the whole IP mod=
ule
> won't be normally working as well.

Also add a comment describing this against why cycle =3D 1000 is selected.

>=20
> Well, but I don't mind to put here an extra failed return to make it clea=
r.
>=20
>=20
> > > +static u8 reverse_bits(u8 input)
> > > +{
> > > +	u8 tmp =3D input;
> > > +
> > > +	tmp =3D ((tmp & 0b10101010) >> 1) | ((tmp << 1) & 0b10101010);
> > > +	tmp =3D ((tmp & 0b11001100) >> 2) | ((tmp << 2) & 0b11001100);
> > > +	tmp =3D ((tmp & 0b11110000) >> 4) | ((tmp << 4) & 0b11110000);
> >
> > What is this logic, can the hardcoding be removed and some description =
on
> above calculation?
>=20
> This was provided by Philipp Zabel in his review at patch v3.
> It's pretty clear to me that it just reverses the bits for u8.

This is not obvious. Why not use bitrev8() ?

> I don't think this logic has any problem and the mask here doesn't look l=
ike any
> hardcode to me.
>=20
>=20
> > > +static bool fsl_spdif_volatile_reg(struct device *dev, unsigned int =
reg)
> > > +{
> > > +	/* Sync all registers after reset */
> >
> > Where us sync :) ?
>=20
> The "return true" would do that. For volatile registers, if no "return tr=
ue"
> here, the whole regmap would use the value in cache, while for some bits
> we need to trace its true value from the physical registers not from cach=
e.

Where will be device registers cached? Do not we program them to be non-cac=
heable in core?

-Bharat
>=20
>=20
> Best regards,
> Nicolin Chen
