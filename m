Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by ozlabs.org (Postfix) with ESMTP id 9A8B2DDF01
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jul 2008 21:46:01 +1000 (EST)
Date: Mon, 14 Jul 2008 12:45:55 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [alsa-devel] [PATCH v2 3/3] ALSA SoC: Add Texas Instruments
	TLV320AIC26 codec	driver
Message-ID: <20080714114554.GA25448@sirena.org.uk>
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080712083939.15025.31192.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080712083939.15025.31192.stgit@trillian.secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	liam.girdwood@wolfsonmicro.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jul 12, 2008 at 02:39:39AM -0600, Grant Likely wrote:

> ASoC Codec driver for the TLV320AIC26 device.  This driver uses the ASoC
> v1 API, so I don't expect it to get merged as-is, but I want to get it
> out there for review.

This looks basically good - most of the issues below are nitpicky.

> +	/* Configure PLL */
> +	pval = 1;
> +	jval = (fsref == 44100) ? 7 : 8;
> +	dval = (fsref == 44100) ? 5264 : 1920;
> +	qval = 0;
> +	reg = 0x8000 | qval << 11 | pval << 8 | jval << 2;
> +	aic26_reg_write(codec, AIC26_REG_PLL_PROG1, reg);
> +	reg = dval << 2;
> +	aic26_reg_write(codec, AIC26_REG_PLL_PROG2, reg);

Does the PLL configuration not depend on the input clock frequency?  You
have a set_sysclk() method to configure the MCLK supplied but the driver
never appears to reference the value anywhere.

> +	/* Power up CODEC */
> +	aic26_reg_write(codec, AIC26_REG_POWER_CTRL, 0);

As discussed this should probably just be removed from hw_params().

> +static int aic26_set_fmt(struct snd_soc_codec_dai *codec_dai, unsigned int fmt)
> +{

> +	/* interface format */
> +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +	case SND_SOC_DAIFMT_I2S: aic26->datfm = AIC26_DATFM_I2S; break;
> +	case SND_SOC_DAIFMT_DSP_A: aic26->datfm = AIC26_DATFM_DSP; break;
> +	case SND_SOC_DAIFMT_RIGHT_J: aic26->datfm = AIC26_DATFM_RIGHTJ; break;
> +	case SND_SOC_DAIFMT_LEFT_J: aic26->datfm = AIC26_DATFM_LEFTJ; break;
> +	default: dev_dbg(&aic26->spi->dev, "bad format\n"); return -EINVAL;
> +	}

I'm having a hard time liking this indentation style.  It's not an
obstacle to merging but it doesn't really help legibility - there's not
enough white space and once you have a non-standard line like the
default: one.

> +static const char *aic26_capture_src_text[] = {"Mic", "Aux"};
> +static const struct soc_enum aic26_capture_src_enum =
> +	SOC_ENUM_SINGLE(AIC26_REG_AUDIO_CTRL1, 12,2, aic26_capture_src_text);

checkpatch complains about the 12,2 here and a bunch of other stuff -
ALSA is generally very strict about that.

> +	SOC_SINGLE("Keyclick activate", AIC26_REG_AUDIO_CTRL2, 15, 0x1, 0),
> +	SOC_SINGLE("Keyclick amplitude", AIC26_REG_AUDIO_CTRL2, 12, 0x7, 0),
> +	SOC_SINGLE("Keyclick frequency", AIC26_REG_AUDIO_CTRL2, 8, 0x7, 0),
> +	SOC_SINGLE("Keyclick period", AIC26_REG_AUDIO_CTRL2, 4, 0xf, 0),

This configuration is also exposed via a sysfs file, including some of
the configurability.  Exposing the information via sysfs isn't a
particular problem but allowing it to be written to without going
through ALSA seems wrong.

> +static ssize_t aic26_regs_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{

As discussed this is replicating the existing codec register display
sysfs file.

> +#if defined(CONFIG_SND_SOC_OF)
> +	/* Tell the of_soc helper about this codec */
> +	of_snd_soc_register_codec(&aic26_soc_codec_dev, aic26, &aic26_dai,
> +				  spi->dev.archdata.of_node);
> +#endif

CONFIG_SND_SOC_OF could be a module - this needs to also check for it
being a module.

> +#define AIC26_RATES	(SNDRV_PCM_RATE_8000  | SNDRV_PCM_RATE_11025 |\
> +			 SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |\
> +			 SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |\
> +			 SNDRV_PCM_RATE_48000)
> +#define AIC26_FORMATS	(SNDRV_PCM_FMTBIT_S8     | SNDRV_PCM_FMTBIT_S16_BE |\
> +			 SNDRV_PCM_FMTBIT_S24_BE | SNDRV_PCM_FMTBIT_S32_BE)

These are usually kept in the driver code.
