Return-Path: <B42378@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E23FB2C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 13:08:20 +1000 (EST)
Date: Mon, 19 Aug 2013 11:07:44 +0800
From: Nicolin Chen <b42378@freescale.com>
To: Bhushan Bharat-R65777 <R65777@freescale.com>
Subject: Re: [PATCH v6 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Message-ID: <20130819030743.GA10544@MrMyself>
References: <cover.1376657643.git.b42378@freescale.com>
 <df3c09cd5679649b144bb45dfd5fc746628266d4.1376657643.git.b42378@freescale.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D07114BC3@039-SN2MPN1-013.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D07114BC3@039-SN2MPN1-013.039d.mgd.msft.net>
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

Hi Bhushan,

   Thank you for the comments :)
   I'll fix some in v7.

   Here is my some replies to you.

On Sat, Aug 17, 2013 at 02:24:19AM +0800, Bhushan Bharat-R65777 wrote:
> > This patch add S/PDIF controller driver for Freescale SoC.
> 
> Please give some more description of the driver?

I've referred some ASoC drivers, all of them seem to be brief as mine.
So I'm not sure what else information I should provide here. It's already
kinda okay to me.


> > +struct spdif_mixer_control {
> > +	/* buffer ptrs for writer */
> > +	u32 upos;
> > +	u32 qpos;
> 
> They does not look like pointer?

They are more like offsets to get the correspond pointer.
But I'll change the confusing comments.


> > +/* U/Q Channel receive register full */
> > +static void spdif_irq_uqrx_full(struct fsl_spdif_priv *spdif_priv, char name)
> > +{
> > +	struct spdif_mixer_control *ctrl = &spdif_priv->fsl_spdif_control;
> > +	struct regmap *regmap = spdif_priv->regmap;
> > +	struct platform_device *pdev = spdif_priv->pdev;
> > +	u32 *pos, size, val, reg;
> > +
> > +	switch (name) {
> > +	case 'U':
> > +		pos = &ctrl->upos;
> > +		size = SPDIF_UBITS_SIZE;
> > +		reg = REG_SPDIF_SRU;
> > +		break;
> > +	case 'Q':
> > +		pos = &ctrl->qpos;
> > +		size = SPDIF_QSUB_SIZE;
> > +		reg = REG_SPDIF_SRQ;
> > +		break;
> > +	default:
> > +		return;
> 
> Should return error.

IMHO, this should be fine. It's a void type function and being used
in the isr(). The params 'name' is totally controlled by driver itself,
so basically we don't need to worry about the default path.

> > +	if (*pos >= size * 2) {
> > +		*pos = 0;
> > +	} else if (unlikely((*pos % size) + 3 > size)) {
> > +		dev_err(&pdev->dev, "User bit receivce buffer overflow\n");
> > +		return;
> 
> Should return error.

Ditto, it's being used in isr(), we don't need to detect the return value,
just use dev_err() to warn users and let the driver clear the irq.


> > +/* U/Q Channel framing error */
> > +static void spdif_irq_uq_err(struct fsl_spdif_priv *spdif_priv)
> > +{
> > +	struct spdif_mixer_control *ctrl = &spdif_priv->fsl_spdif_control;
> > +	struct regmap *regmap = spdif_priv->regmap;
> > +	struct platform_device *pdev = spdif_priv->pdev;
> > +	u32 val;
> > +
> > +	dev_dbg(&pdev->dev, "isr: U/Q Channel framing error\n");
> > +
> > +	/* read U/Q data and do buffer reset */
> > +	regmap_read(regmap, REG_SPDIF_SRU, &val);
> > +	regmap_read(regmap, REG_SPDIF_SRQ, &val);
> 
> Above prints says read u/q data and buffer reset, what is buffer reset? Is that read on clear?

That's the behavior needed by IP, according to the reference manual:
"U Channel receive register full, can't be cleared with reg. IntClear.
To clear it, read from U Rx reg." and "Q Channel receive register full,
can't be cleared with reg. IntClear. To clear it, read from Q Rx reg."


> > +static void spdif_softreset(struct fsl_spdif_priv *spdif_priv)
> > +{
> > +	struct regmap *regmap = spdif_priv->regmap;
> > +	u32 val, cycle = 1000;
> > +
> > +	regmap_write(regmap, REG_SPDIF_SCR, SCR_SOFT_RESET);
> > +	regcache_sync(regmap);
> > +
> > +	/* RESET bit would be cleared after finishing its reset procedure */
> > +	do {
> > +		regmap_read(regmap, REG_SPDIF_SCR, &val);
> > +	} while ((val & SCR_SOFT_RESET) && cycle--);
> 
> What if reset is not cleared and timeout happen? 

We here suppose the reset bit would be cleared -- "The software reset
will last 8 cycles." from RM, so if this happened to be a failure, the
whole IP module won't be normally working as well.

Well, but I don't mind to put here an extra failed return to make it
clear. 


> > +static u8 reverse_bits(u8 input)
> > +{
> > +	u8 tmp = input;
> > +
> > +	tmp = ((tmp & 0b10101010) >> 1) | ((tmp << 1) & 0b10101010);
> > +	tmp = ((tmp & 0b11001100) >> 2) | ((tmp << 2) & 0b11001100);
> > +	tmp = ((tmp & 0b11110000) >> 4) | ((tmp << 4) & 0b11110000);
> 
> What is this logic, can the hardcoding be removed and some description on above calculation?

This was provided by Philipp Zabel in his review at patch v3.
It's pretty clear to me that it just reverses the bits for u8.
I don't think this logic has any problem and the mask here 
doesn't look like any hardcode to me.


> > +static bool fsl_spdif_volatile_reg(struct device *dev, unsigned int reg)
> > +{
> > +	/* Sync all registers after reset */
> 
> Where us sync :) ?

The "return true" would do that. For volatile registers, if no "return true"
here, the whole regmap would use the value in cache, while for some bits
we need to trace its true value from the physical registers not from cache.


Best regards,
Nicolin Chen
