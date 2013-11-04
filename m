Return-Path: <B47053@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0189.outbound.messaging.microsoft.com [213.199.154.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6ABDA2C0097
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Nov 2013 14:45:22 +1100 (EST)
From: Li Xiubo <B47053@freescale.com>
To: Guangyu Chen <B42378@freescale.com>
Subject: RE: [PATCHv2 1/8] ALSA: Add SAI SoC Digital Audio Interface driver.
Date: Mon, 4 Nov 2013 03:45:10 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F82874201@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-2-git-send-email-Li.Xiubo@freescale.com>
 <20131101085904.GC28401@MrMyself>
In-Reply-To: <20131101085904.GC28401@MrMyself>
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
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "grant.likely@linaro.org" <grant.likely@linaro.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "ian.campbell@citrix.com" <ian.campbell@citrix.com>,
 "pawel.moll@arm.com" <pawel.moll@arm.com>,
 "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "broonie@kernel.org" <broonie@kernel.org>, "oskar@scara.com" <oskar@scara.com>,
 Fabio Estevam <r49496@freescale.com>,
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

> > This adds Freescale SAI ASoC Audio support.
> > This implementation is only compatible with device tree definition.
> > Features:
> > o Supports playback/capture
> > o Supports 16/20/24 bit PCM
> > o Supports 8k - 96k sample rates
> > o Supports slave mode only.
> >
>=20
> Just for curiosity, I found there're quite a bit code actually support
> I2S master mode such as set_sysclk() and register configuration to FMT
> SND_SOC_DAIFMT_CBS_CFS.
>=20
> Is that really "supports slave mode only"? Or just you haven't make it
> properly work?
>=20

Sorry, this comments is not very consistent with the driver implementation.
On VF610 there only supports slave mode.

So, I will revise this.


> > diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig index
> > b7ab71f..9a8851e 100644
> > --- a/sound/soc/fsl/Kconfig
> > +++ b/sound/soc/fsl/Kconfig
> > @@ -213,3 +213,19 @@ config SND_SOC_IMX_MC13783
> >  	select SND_SOC_IMX_PCM_DMA
> >
> >  endif # SND_IMX_SOC
> > +
> > +menuconfig SND_FSL_SOC
> > +	tristate "SoC Audio for Freescale FSL CPUs"
> > +	help
> > +	  Say Y or M if you want to add support for codecs attached to
> > +	  the FSL CPUs.
> > +
> > +	  This will enable Freeacale SAI, SGT15000 codec.
> > +
> > +if SND_FSL_SOC
>=20
> Why check this here? SAI should be a regular IP module which can be used
> by other SoC as well. We would never know if next i.MX SoC won't contain
> SAI.
>=20
> > +
> > +config SND_SOC_FSL_SAI
> > +	tristate
> > +	select SND_SOC_GENERIC_DMAENGINE_PCM
>=20
> I think you should keep SAI beside SSI/SPDIF directly.
>=20

That's right.

> > +
> > +endif # SND_FSL_SOC
> > diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile index
> > 8db705b..e5acc03 100644
> > --- a/sound/soc/fsl/Makefile
> > +++ b/sound/soc/fsl/Makefile
> > @@ -56,3 +56,8 @@ obj-$(CONFIG_SND_SOC_IMX_SGTL5000) +=3D
> > snd-soc-imx-sgtl5000.o
> >  obj-$(CONFIG_SND_SOC_IMX_WM8962) +=3D snd-soc-imx-wm8962.o
> >  obj-$(CONFIG_SND_SOC_IMX_SPDIF) +=3D snd-soc-imx-spdif.o
> >  obj-$(CONFIG_SND_SOC_IMX_MC13783) +=3D snd-soc-imx-mc13783.o
> > +
> > +# FSL ARM SAI/SGT15000 Platform Support
>=20
> Should be SGTL5000, not SGT1. And SAI should not be used with SGTL5000
> only, it's a bit confusing to mention SGTL5000 here.
>=20

Yes, this will be revised then.

> > +snd-soc-fsl-sai-objs :=3D fsl-sai.o
>=20
> And I think it should be better to put it along with fsl-ssi.o and fsl-
> spdif.o
>=20

But fsl-ssi.o and fsl-spdif.o is based PowrePC platform? Which we can see f=
rom the comments.
While fsl-sai.o is base ARM platform.
Despite whether there is any different between ARM and PPC or not, the comm=
ents won't be correct.


> > +
> > +obj-$(CONFIG_SND_SOC_FSL_SAI) +=3D snd-soc-fsl-sai.o
>=20
> Ditto
>=20
> > diff --git a/sound/soc/fsl/fsl-sai.c b/sound/soc/fsl/fsl-sai.c new
> > file mode 100644 index 0000000..bb57e67
> > --- /dev/null
> > +++ b/sound/soc/fsl/fsl-sai.c
> > @@ -0,0 +1,472 @@
> > +/*
> > + * Freescale SAI ALSA SoC Digital Audio Interface driver.
> > + *
> > + * Copyright 2012-2013 Freescale Semiconductor, Inc.
> > + *
> > + * This program is free software; you can redistribute  it and/or
> > +modify it
> > + * under  the terms of  the GNU General  Public License as published
> > +by the
> > + * Free Software Foundation;  either version 2 of the  License, or
> > +(at your
> > + * option) any later version.
>=20
> There're too many double space inside. Could you pls revise it?
>=20

Yes, see the next version.

> > + *
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/module.h>
> > +#include <linux/slab.h>
> > +#include <linux/of_address.h>
> > +#include <sound/core.h>
> > +#include <sound/pcm_params.h>
> > +#include <linux/delay.h>
> > +#include <linux/dmaengine.h>
> > +#include <sound/dmaengine_pcm.h>
>=20
> I think it's better to keep <sound/xxx.h> together. And basically we can
> keep header files ordered by alphabet.
>=20

Okey.

> > +
> > +#include "fsl-sai.h"
> > +
> > +static int fsl_sai_set_dai_sysclk_tr(struct snd_soc_dai *cpu_dai,
> > +		int clk_id, unsigned int freq, int fsl_dir) {
> > +	u32 val_cr2, reg_cr2;
> > +	struct fsl_sai *sai =3D snd_soc_dai_get_drvdata(cpu_dai);
> > +
> > +	if (fsl_dir =3D=3D FSL_FMT_TRANSMITTER)
> > +		reg_cr2 =3D FSL_SAI_TCR2;
> > +	else
> > +		reg_cr2 =3D FSL_SAI_RCR2;
> > +
> > +	val_cr2 =3D readl(sai->base + reg_cr2);
> > +	switch (clk_id) {
> > +	case FSL_SAI_CLK_BUS:
> > +		val_cr2 &=3D ~FSL_SAI_CR2_MSEL_MASK;
> > +		val_cr2 |=3D FSL_SAI_CR2_MSEL_BUS;
> > +		break;
> > +	case FSL_SAI_CLK_MAST1:
> > +		val_cr2 &=3D ~FSL_SAI_CR2_MSEL_MASK;
> > +		val_cr2 |=3D FSL_SAI_CR2_MSEL_MCLK1;
> > +		break;
> > +	case FSL_SAI_CLK_MAST2:
> > +		val_cr2 &=3D ~FSL_SAI_CR2_MSEL_MASK;
> > +		val_cr2 |=3D FSL_SAI_CR2_MSEL_MCLK2;
> > +		break;
> > +	case FSL_SAI_CLK_MAST3:
> > +		val_cr2 &=3D ~FSL_SAI_CR2_MSEL_MASK;
> > +		val_cr2 |=3D FSL_SAI_CR2_MSEL_MCLK3;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +	writel(val_cr2, sai->base + reg_cr2);
> > +
> > +	return 0;
> > +}
> > +
> > +static int fsl_sai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
> > +		int clk_id, unsigned int freq, int dir) {
> > +	int ret;
> > +
> > +	if (dir =3D=3D SND_SOC_CLOCK_IN)
> > +		return 0;
> > +
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
> > +	if (ret) {
> > +		dev_err(cpu_dai->dev,
> > +				"Cannot set sai's receiver sysclk: %d\n",
> > +				ret);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
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
> > +
> > +	} else if (div_id =3D=3D FSL_SAI_RX_DIV) {
> > +		rcr2 =3D readl(sai->base + FSL_SAI_RCR2);
> > +		rcr2 &=3D ~FSL_SAI_CR2_DIV_MASK;
> > +		rcr2 |=3D FSL_SAI_CR2_DIV(div);
> > +		writel(rcr2, sai->base + FSL_SAI_RCR2);
> > +
> > +	} else
> > +		return -EINVAL;
>=20
> It would look better if using switch-case. And the last 'else'
> could be 'default:'.
>=20

I'll think it over.

> > +
> > +	return 0;
> > +}
> > +
> > +static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai *cpu_dai,
> > +				unsigned int fmt, int fsl_dir)
> > +{
> > +	u32 val_cr2, val_cr3, val_cr4, reg_cr2, reg_cr3, reg_cr4;
> > +	struct fsl_sai *sai =3D snd_soc_dai_get_drvdata(cpu_dai);
> > +
> > +	if (fsl_dir =3D=3D FSL_FMT_TRANSMITTER) {
> > +		reg_cr2 =3D FSL_SAI_TCR2;
> > +		reg_cr3 =3D FSL_SAI_TCR3;
> > +		reg_cr4 =3D FSL_SAI_TCR4;
> > +	} else {
> > +		reg_cr2 =3D FSL_SAI_RCR2;
> > +		reg_cr3 =3D FSL_SAI_RCR3;
> > +		reg_cr4 =3D FSL_SAI_RCR4;
> > +	}
> > +
> > +	val_cr2 =3D readl(sai->base + reg_cr2);
> > +	val_cr3 =3D readl(sai->base + reg_cr3);
> > +	val_cr4 =3D readl(sai->base + reg_cr4);
> > +
> > +	if (sai->fbt =3D=3D FSL_SAI_FBT_MSB)
> > +		val_cr4 |=3D FSL_SAI_CR4_MF;
> > +	else if (sai->fbt =3D=3D FSL_SAI_FBT_LSB)
> > +		val_cr4 &=3D ~FSL_SAI_CR4_MF;
> > +
> > +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> > +	case SND_SOC_DAIFMT_I2S:
> > +		val_cr4 |=3D FSL_SAI_CR4_FSE;
> > +		val_cr4 |=3D FSL_SAI_CR4_FSP;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> > +	case SND_SOC_DAIFMT_IB_IF:
> > +		val_cr4 |=3D FSL_SAI_CR4_FSP;
> > +		val_cr2 &=3D ~FSL_SAI_CR2_BCP;
> > +		break;
> > +	case SND_SOC_DAIFMT_IB_NF:
> > +		val_cr4 &=3D ~FSL_SAI_CR4_FSP;
> > +		val_cr2 &=3D ~FSL_SAI_CR2_BCP;
> > +		break;
> > +	case SND_SOC_DAIFMT_NB_IF:
> > +		val_cr4 |=3D FSL_SAI_CR4_FSP;
> > +		val_cr2 |=3D FSL_SAI_CR2_BCP;
> > +		break;
> > +	case SND_SOC_DAIFMT_NB_NF:
> > +		val_cr4 &=3D ~FSL_SAI_CR4_FSP;
> > +		val_cr2 |=3D FSL_SAI_CR2_BCP;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> > +	case SND_SOC_DAIFMT_CBS_CFS:
> > +		val_cr2 |=3D FSL_SAI_CR2_BCD_MSTR;
> > +		val_cr4 |=3D FSL_SAI_CR4_FSD_MSTR;
> > +		break;
> > +	case SND_SOC_DAIFMT_CBM_CFM:
> > +		val_cr2 &=3D ~FSL_SAI_CR2_BCD_MSTR;
> > +		val_cr4 &=3D ~FSL_SAI_CR4_FSD_MSTR;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	val_cr3 |=3D FSL_SAI_CR3_TRCE;
> > +
> > +	if (fsl_dir =3D=3D FSL_FMT_RECEIVER)
> > +		val_cr2 |=3D FSL_SAI_CR2_SYNC;
> > +
> > +	writel(val_cr2, sai->base + reg_cr2);
> > +	writel(val_cr3, sai->base + reg_cr3);
> > +	writel(val_cr4, sai->base + reg_cr4);
> > +
> > +	return 0;
>=20
> > +
>=20
> Pls drop this extra line.
>

See the next version.

>=20
> > +}
> > +
> > +static int fsl_sai_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned
> > +int fmt) {
> > +	int ret;
> > +
> > +	ret =3D fsl_sai_set_dai_fmt_tr(cpu_dai, fmt, FSL_FMT_TRANSMITTER);
> > +	if (ret) {
> > +		dev_err(cpu_dai->dev,
> > +				"Cannot set sai's transmitter format: %d\n",
> > +				ret);
> > +		return ret;
> > +	}
> > +
> > +	ret =3D fsl_sai_set_dai_fmt_tr(cpu_dai, fmt, FSL_FMT_RECEIVER);
> > +	if (ret) {
> > +		dev_err(cpu_dai->dev,
> > +				"Cannot set sai's receiver format: %d\n",
> > +				ret);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int fsl_sai_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai,
> > +		unsigned int tx_mask, unsigned int rx_mask,
> > +		int slots, int slot_width)
> > +{
> > +	struct fsl_sai *sai =3D snd_soc_dai_get_drvdata(cpu_dai);
> > +	u32 tcr4, rcr4;
> > +
> > +	tcr4 =3D readl(sai->base + FSL_SAI_TCR4);
> > +	tcr4 &=3D ~FSL_SAI_CR4_FRSZ_MASK;
> > +	tcr4 |=3D FSL_SAI_CR4_FRSZ(2);
> > +	writel(tcr4, sai->base + FSL_SAI_TCR4);
> > +	writel(tx_mask, sai->base + FSL_SAI_TMR);
> > +
> > +	rcr4 =3D readl(sai->base + FSL_SAI_RCR4);
> > +	rcr4 &=3D ~FSL_SAI_CR4_FRSZ_MASK;
> > +	rcr4 |=3D FSL_SAI_CR4_FRSZ(2);
> > +	writel(rcr4, sai->base + FSL_SAI_RCR4);
> > +	writel(rx_mask, sai->base + FSL_SAI_RMR);
> > +
> > +	return 0;
> > +}
> > +
> > +static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
> > +		struct snd_pcm_hw_params *params,
> > +		struct snd_soc_dai *cpu_dai)
> > +{
> > +	u32 val_cr4, val_cr5, reg_cr4, reg_cr5, word_width;
> > +	struct fsl_sai *sai =3D snd_soc_dai_get_drvdata(cpu_dai);
> > +
> > +	if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
> > +		reg_cr4 =3D FSL_SAI_TCR4;
> > +		reg_cr5 =3D FSL_SAI_TCR5;
> > +	} else {
> > +		reg_cr4 =3D FSL_SAI_RCR4;
> > +		reg_cr5 =3D FSL_SAI_RCR5;
> > +	}
> > +
> > +	val_cr4 =3D readl(sai->base + reg_cr4);
> > +	val_cr4 &=3D ~FSL_SAI_CR4_SYWD_MASK;
> > +
> > +	val_cr5 =3D readl(sai->base + reg_cr5);
> > +	val_cr5 &=3D ~FSL_SAI_CR5_WNW_MASK;
> > +	val_cr5 &=3D ~FSL_SAI_CR5_W0W_MASK;
> > +	val_cr5 &=3D ~FSL_SAI_CR5_FBT_MASK;
> > +
> > +	switch (params_format(params)) {
> > +	case SNDRV_PCM_FORMAT_S16_LE:
> > +		word_width =3D 16;
> > +		break;
> > +	case SNDRV_PCM_FORMAT_S20_3LE:
> > +		word_width =3D 20;
> > +		break;
> > +	case SNDRV_PCM_FORMAT_S24_LE:
> > +		word_width =3D 24;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	val_cr4 |=3D FSL_SAI_CR4_SYWD(word_width);
> > +	val_cr5 |=3D FSL_SAI_CR5_WNW(word_width);
> > +	val_cr5 |=3D FSL_SAI_CR5_W0W(word_width);
> > +
> > +	if (sai->fbt =3D=3D FSL_SAI_FBT_MSB)
> > +		val_cr5 |=3D FSL_SAI_CR5_FBT(word_width - 1);
> > +	else if (sai->fbt =3D=3D FSL_SAI_FBT_LSB)
> > +		val_cr5 |=3D FSL_SAI_CR5_FBT(0);
> > +
> > +	writel(val_cr4, sai->base + reg_cr4);
> > +	writel(val_cr5, sai->base + reg_cr5);
> > +
> > +	return 0;
> > +}
> > +
> > +static int fsl_sai_trigger(struct snd_pcm_substream *substream, int
> cmd,
> > +		struct snd_soc_dai *dai)
> > +{
> > +	struct fsl_sai *sai =3D snd_soc_dai_get_drvdata(dai);
> > +	unsigned int tcsr, rcsr;
> > +
> > +	tcsr =3D readl(sai->base + FSL_SAI_TCSR);
> > +	rcsr =3D readl(sai->base + FSL_SAI_RCSR);
> > +
> > +	if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
> > +		tcsr |=3D FSL_SAI_CSR_FRDE;
> > +		rcsr &=3D ~FSL_SAI_CSR_FRDE;
> > +	} else {
> > +		rcsr |=3D FSL_SAI_CSR_FRDE;
> > +		tcsr &=3D ~FSL_SAI_CSR_FRDE;
> > +	}
> > +
> > +	switch (cmd) {
> > +	case SNDRV_PCM_TRIGGER_START:
> > +	case SNDRV_PCM_TRIGGER_RESUME:
> > +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> > +		tcsr |=3D FSL_SAI_CSR_TERE;
> > +		rcsr |=3D FSL_SAI_CSR_TERE;
> > +		writel(rcsr, sai->base + FSL_SAI_RCSR);
> > +		udelay(10);
>=20
> Does SAI really needs this udelay() here? Required by IP's operation flow=
?
> If so, I think it's better to add comments here to explain it.
>=20
+++++++++++++++++
Synchronous mode
The SAI transmitter and receiver can be configured to operate with synchron=
ous bit clock
and frame sync.

1,
If the transmitter bit clock and frame sync are to be used by both the tran=
smitter and
receiver:
	...
* It is recommended that the transmitter is the last enabled and the first =
disabled.

2,
If the receiver bit clock and frame sync are to be used by both the transmi=
tter and
receiver:
	...
* It is recommended that the receiver is the last enabled and the first dis=
abled.
------------------

So I think the delay is needed, and I still tunning it.



> > +		writel(tcsr, sai->base + FSL_SAI_TCSR);
> > +		break;
> > +
> > +	case SNDRV_PCM_TRIGGER_STOP:
> > +	case SNDRV_PCM_TRIGGER_SUSPEND:
> > +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> > +		if (!(dai->playback_active || dai->capture_active)) {
> > +			tcsr &=3D ~FSL_SAI_CSR_TERE;
> > +			rcsr &=3D ~FSL_SAI_CSR_TERE;
> > +		}
> > +		writel(rcsr, sai->base + FSL_SAI_RCSR);
> > +		udelay(10);
> > +		writel(tcsr, sai->base + FSL_SAI_TCSR);
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct snd_soc_dai_ops fsl_sai_pcm_dai_ops =3D {
> > +	.set_sysclk	=3D fsl_sai_set_dai_sysclk,
> > +	.set_clkdiv	=3D fsl_sai_set_dai_clkdiv,
> > +	.set_fmt	=3D fsl_sai_set_dai_fmt,
> > +	.set_tdm_slot	=3D fsl_sai_set_dai_tdm_slot,
> > +	.hw_params	=3D fsl_sai_hw_params,
> > +	.trigger	=3D fsl_sai_trigger,
> > +};
> > +
> > +static int fsl_sai_dai_probe(struct snd_soc_dai *dai) {
> > +	int ret;
> > +	struct fsl_sai *sai =3D dev_get_drvdata(dai->dev);
> > +
> > +	ret =3D clk_prepare_enable(sai->clk);
> > +	if (ret)
> > +		return ret;
> > +
> > +	writel(0x0, sai->base + FSL_SAI_RCSR);
> > +	writel(0x0, sai->base + FSL_SAI_TCSR);
> > +	writel(sai->dma_params_tx.maxburst, sai->base + FSL_SAI_TCR1);
> > +	writel(sai->dma_params_rx.maxburst, sai->base + FSL_SAI_RCR1);
> > +
> > +	dai->playback_dma_data =3D &sai->dma_params_tx;
> > +	dai->capture_dma_data =3D &sai->dma_params_rx;
> > +
> > +	snd_soc_dai_set_drvdata(dai, sai);
> > +
> > +	return 0;
> > +}
> > +
> > +int fsl_sai_dai_remove(struct snd_soc_dai *dai)
>=20
> static
>=20

Yes.

> > +{
> > +	struct fsl_sai *sai =3D dev_get_drvdata(dai->dev);
> > +
> > +	clk_disable_unprepare(sai->clk);
> > +
> > +	return 0;
> > +}
> > +
> > +static struct snd_soc_dai_driver fsl_sai_dai =3D {
> > +	.probe =3D fsl_sai_dai_probe,
> > +	.remove =3D fsl_sai_dai_remove,
> > +	.playback =3D {
> > +		.channels_min =3D 1,
> > +		.channels_max =3D 2,
> > +		.rates =3D SNDRV_PCM_RATE_8000_96000,
> > +		.formats =3D FSL_SAI_FORMATS,
> > +	},
> > +	.capture =3D {
> > +		.channels_min =3D 1,
> > +		.channels_max =3D 2,
> > +		.rates =3D SNDRV_PCM_RATE_8000_96000,
> > +		.formats =3D FSL_SAI_FORMATS,
> > +	},
> > +	.ops =3D &fsl_sai_pcm_dai_ops,
> > +};
> > +
> > +static const struct snd_soc_component_driver fsl_component =3D {
> > +	.name           =3D "fsl-sai",
> > +};
> > +
> > +static int fsl_sai_probe(struct platform_device *pdev) {
> > +	struct resource *res;
> > +	struct fsl_sai *sai;
> > +	int ret =3D 0;
> > +
> > +	sai =3D devm_kzalloc(&pdev->dev, sizeof(*sai), GFP_KERNEL);
> > +	if (!sai)
> > +		return -ENOMEM;
> > +
> > +	sai->fbt =3D FSL_SAI_FBT_MSB;
> > +
> > +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	sai->base =3D devm_ioremap_resource(&pdev->dev, res);
> > +	if (IS_ERR(sai->base))
> > +		return PTR_ERR(sai->base);
> > +
> > +	sai->clk =3D devm_clk_get(&pdev->dev, "sai");
> > +	if (IS_ERR(sai->clk)) {
> > +		dev_err(&pdev->dev, "Cannot get sai's clock: %d\n", ret);
> > +		return PTR_ERR(sai->clk);
> > +	}
> > +
> > +	sai->dma_params_rx.addr =3D res->start + FSL_SAI_RDR;
> > +	sai->dma_params_rx.maxburst =3D 6;
> > +
> > +	sai->dma_params_tx.addr =3D res->start + FSL_SAI_TDR;
> > +	sai->dma_params_tx.maxburst =3D 6;
> > +
> > +	platform_set_drvdata(pdev, sai);
> > +
> > +	ret =3D devm_snd_soc_register_component(&pdev->dev, &fsl_component,
> > +			&fsl_sai_dai, 1);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D snd_dmaengine_pcm_register(&pdev->dev, NULL,
> > +			SND_DMAENGINE_PCM_FLAG_NO_RESIDUE);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> > +
> > +static int fsl_sai_remove(struct platform_device *pdev) {
> > +	snd_dmaengine_pcm_unregister(&pdev->dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id fsl_sai_ids[] =3D {
> > +	{ .compatible =3D "fsl,vf610-sai", },
>=20
> > +	{ /*sentinel*/ }
>=20
> I think this could be left in blank without comments inside.
> And if you really want to add it, pls add like: /* sentinel */
> 						  ^        ^

Okey.

> > +};
> > +
> > +static struct platform_driver fsl_sai_driver =3D {
> > +	.probe =3D fsl_sai_probe,
> > +	.remove =3D fsl_sai_remove,
> > +
> > +	.driver =3D {
> > +		.name =3D "fsl-sai",
> > +		.owner =3D THIS_MODULE,
> > +		.of_match_table =3D fsl_sai_ids,
> > +	},
> > +};
> > +module_platform_driver(fsl_sai_driver);
> > +
> > +MODULE_AUTHOR("Xiubo Li, <Li.Xiubo@freescale.com>");
> > +MODULE_AUTHOR("Alison Wang, <b18965@freescale.com>");
> > +MODULE_DESCRIPTION("Freescale Soc SAI Interface");
> > +MODULE_LICENSE("GPL");
>=20
> Should be better if added:
> MODULE_ALIAS("platform:fsl-sai");
>=20
> This would support module auto-load feature in some Linux-OS.
>=20

I will think it over.

BRS,
Xiubo
