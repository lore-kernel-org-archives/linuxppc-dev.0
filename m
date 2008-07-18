Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.171])
	by ozlabs.org (Postfix) with ESMTP id 39BCCDDF9B
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 16:29:41 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so148965wfg.15
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 23:29:40 -0700 (PDT)
Date: Fri, 18 Jul 2008 00:29:37 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	liam.girdwood@wolfsonmicro.com, jonsmirl@gmail.com
Subject: Re: [alsa-devel] [PATCH v2 3/3] ALSA SoC: Add Texas Instruments
	TLV320AIC26 codec driver
Message-ID: <20080718062937.GA10988@secretlab.ca>
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080712083939.15025.31192.stgit@trillian.secretlab.ca>
	<20080714114554.GA25448@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080714114554.GA25448@sirena.org.uk>
Sender: Grant Likely <glikely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 14, 2008 at 12:45:55PM +0100, Mark Brown wrote:
> On Sat, Jul 12, 2008 at 02:39:39AM -0600, Grant Likely wrote:
> 
> > ASoC Codec driver for the TLV320AIC26 device.  This driver uses the ASoC
> > v1 API, so I don't expect it to get merged as-is, but I want to get it
> > out there for review.
> 
> This looks basically good - most of the issues below are nitpicky.
> 
> > +	/* Configure PLL */
> > +	pval = 1;
> > +	jval = (fsref == 44100) ? 7 : 8;
> > +	dval = (fsref == 44100) ? 5264 : 1920;
> > +	qval = 0;
> > +	reg = 0x8000 | qval << 11 | pval << 8 | jval << 2;
> > +	aic26_reg_write(codec, AIC26_REG_PLL_PROG1, reg);
> > +	reg = dval << 2;
> > +	aic26_reg_write(codec, AIC26_REG_PLL_PROG2, reg);
> 
> Does the PLL configuration not depend on the input clock frequency?  You
> have a set_sysclk() method to configure the MCLK supplied but the driver
> never appears to reference the value anywhere.

Yes, this should be done better.  I'm working on making this better, but
I'm hoping it is okay to have that as follow-on patches.

> > +	/* Power up CODEC */
> > +	aic26_reg_write(codec, AIC26_REG_POWER_CTRL, 0);
> 
> As discussed this should probably just be removed from hw_params().

done

> > +static int aic26_set_fmt(struct snd_soc_codec_dai *codec_dai, unsigned int fmt)
> > +{
> 
> > +	/* interface format */
> > +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> > +	case SND_SOC_DAIFMT_I2S: aic26->datfm = AIC26_DATFM_I2S; break;
> > +	case SND_SOC_DAIFMT_DSP_A: aic26->datfm = AIC26_DATFM_DSP; break;
> > +	case SND_SOC_DAIFMT_RIGHT_J: aic26->datfm = AIC26_DATFM_RIGHTJ; break;
> > +	case SND_SOC_DAIFMT_LEFT_J: aic26->datfm = AIC26_DATFM_LEFTJ; break;
> > +	default: dev_dbg(&aic26->spi->dev, "bad format\n"); return -EINVAL;
> > +	}
> 
> I'm having a hard time liking this indentation style.  It's not an
> obstacle to merging but it doesn't really help legibility - there's not
> enough white space and once you have a non-standard line like the
> default: one.

Cleaned up.

> > +static const char *aic26_capture_src_text[] = {"Mic", "Aux"};
> > +static const struct soc_enum aic26_capture_src_enum =
> > +	SOC_ENUM_SINGLE(AIC26_REG_AUDIO_CTRL1, 12,2, aic26_capture_src_text);
> 
> checkpatch complains about the 12,2 here and a bunch of other stuff -
> ALSA is generally very strict about that.

Originally, that had been to keep the line under 80 chars, but some of
the names have changed since then to make it no longer necessary.  I'll
clean up the checkpatch stuff.

> 
> > +	SOC_SINGLE("Keyclick activate", AIC26_REG_AUDIO_CTRL2, 15, 0x1, 0),
> > +	SOC_SINGLE("Keyclick amplitude", AIC26_REG_AUDIO_CTRL2, 12, 0x7, 0),
> > +	SOC_SINGLE("Keyclick frequency", AIC26_REG_AUDIO_CTRL2, 8, 0x7, 0),
> > +	SOC_SINGLE("Keyclick period", AIC26_REG_AUDIO_CTRL2, 4, 0xf, 0),
> 
> This configuration is also exposed via a sysfs file, including some of
> the configurability.  Exposing the information via sysfs isn't a
> particular problem but allowing it to be written to without going
> through ALSA seems wrong.

All the written bit does is trigger the keyclick event.  It doesn't
adjust the parameters in any way.

> > +static ssize_t aic26_regs_show(struct device *dev,
> > +				struct device_attribute *attr, char *buf)
> > +{
> 
> As discussed this is replicating the existing codec register display
> sysfs file.

removed

> > +#if defined(CONFIG_SND_SOC_OF)
> > +	/* Tell the of_soc helper about this codec */
> > +	of_snd_soc_register_codec(&aic26_soc_codec_dev, aic26, &aic26_dai,
> > +				  spi->dev.archdata.of_node);
> > +#endif
> 
> CONFIG_SND_SOC_OF could be a module - this needs to also check for it
> being a module.

Doesn't #if defined() match on both static and module selection?

> > +#define AIC26_RATES	(SNDRV_PCM_RATE_8000  | SNDRV_PCM_RATE_11025 |\
> > +			 SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |\
> > +			 SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |\
> > +			 SNDRV_PCM_RATE_48000)
> > +#define AIC26_FORMATS	(SNDRV_PCM_FMTBIT_S8     | SNDRV_PCM_FMTBIT_S16_BE |\
> > +			 SNDRV_PCM_FMTBIT_S24_BE | SNDRV_PCM_FMTBIT_S32_BE)
> 
> These are usually kept in the driver code.

fixed.

Thanks,
g.
