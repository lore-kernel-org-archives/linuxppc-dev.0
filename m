Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.175])
	by ozlabs.org (Postfix) with ESMTP id 446CADDE09
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jul 2008 16:00:23 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so4142416wfg.15
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 23:00:22 -0700 (PDT)
Date: Sat, 12 Jul 2008 00:00:18 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH 3/3] ALSA SoC: Add Texas Instruments
	TLV320AIC26 codec driver
Message-ID: <20080712060018.GB23213@secretlab.ca>
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<20080701235340.16923.48024.stgit@trillian.secretlab.ca>
	<1214995713.4882.54.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1214995713.4882.54.camel@localhost.localdomain>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	broonie@opensource.wolfsonmicro.com, timur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 02, 2008 at 11:48:33AM +0100, Liam Girdwood wrote:
> On Tue, 2008-07-01 at 17:53 -0600, Grant Likely wrote:
> > From: Grant Likely <grant.likely@secretlab.ca>
> > 
> > ASoC Codec driver for the TLV320AIC26 device.  This driver uses the ASoC
> > v1 API, so I don't expect it to get merged as-is, but I want to get it
> > out there for review.
> > ---
> 
> Fwiw, I usually put all the codec registers defs in a separate header
> just in case we need to do any codec stuff in the machine driver.

okay, done

> > +	switch (params_rate(params)) {
> > +	 case 8000: fsref = 48000; divisor = AIC26_DIV_6; break;
> > +	 case 11025: fsref = 44100; divisor = AIC26_DIV_4; break;
> > +	 case 12000: fsref = 48000; divisor = AIC26_DIV_4; break;
> > +	 case 16000: fsref = 48000; divisor = AIC26_DIV_3; break;
> > +	 case 22050: fsref = 44100; divisor = AIC26_DIV_2; break;
> > +	 case 24000: fsref = 48000; divisor = AIC26_DIV_2; break;
> > +	 case 32000: fsref = 48000; divisor = AIC26_DIV_1_5; break;
> > +	 case 44100: fsref = 44100; divisor = AIC26_DIV_1; break;
> > +	 case 48000: fsref = 48000; divisor = AIC26_DIV_1; break;
> > +	 default: dev_dbg(&aic26->spi->dev, "bad rate\n"); return -EINVAL;
> > +	}
> > +
> 
> Indentation.

done.

> > +	/* Configure PLL */
> > +	pval = 1;
> > +	jval = (fsref == 44100) ? 7 : 8;
> > +	dval = (fsref == 44100) ? 5264 : 1920;
> > +	qval = 0;
> > +	reg = 0x8000 | qval << 11 | pval << 8 | jval << 2;
> > +	aic26_reg_write(codec, AIC26_REG_PLL_PROG1, reg);
> > +	reg = dval << 2;
> > +	aic26_reg_write(codec, AIC26_REG_PLL_PROG2, reg);
> > +
> 
> PLL/FLL/clock config is usually done in a separate function
> (codec_set_pll(), callable by machine driver) so that we can change
> clocks depending on the available machine clocks and srate. 
> 
> > +	/* Power up CODEC */
> > +	aic26_reg_write(codec, AIC26_REG_POWER_CTRL, 0);
> > +
> 
> Codec domain (i.e Bias power) PM stuff should be done in
> codec_dapm_event(). This allows us to power the codec on when we do
> things like sidetone (with no active playback or capture stream).
> 

Ugh, I'm going to have to leave these two for now.  I don't understand
enough about the ASoC structure yet to understand what it should look
like.  I'll probably need help, but I don't think I can get it sorted
out before the merge window.

Do these two comments need to be addressed before the driver is merged?

> > +static ssize_t aic26_regs_show(struct device *dev,
> > +				struct device_attribute *attr, char *buf)
> > +{
> > +	struct aic26 *aic26 = dev_get_drvdata(dev);
> > +	char *idx = buf;
> > +	int cache_flag, addr, page, i, reg;
> > +
> > +	cache_flag = (strcmp(attr->attr.name, "regs_cache") == 0);
> > +
> > +	for (page = 0; page < 3; page++) {
> > +		for (i = 0; i < 0x20; i++) {
> > +			addr = AIC26_PAGE_ADDR(page, i);
> > +			if (i % 8 == 0)
> > +				idx += sprintf(idx, "%i:%.2i:", page,i);
> > +			if (cache_flag)
> > +				reg = aic26_reg_read_cache(&aic26->codec, addr);
> > +			else
> > +				reg = aic26_reg_read(&aic26->codec, addr);
> > +			idx += sprintf(idx, " %.4x", reg);
> > +			if (i % 8 == 7)
> > +				idx += sprintf(idx, "\n");
> > +		}
> > +	}
> > +	return idx - buf;
> > +}
> > +
> 
> The soc_core already has a codec reg dump sysfs file, so we don't need
> this.

Hmmm, I haven't been able to find this; either in the code or on a live
running system.  Where is the common reg dump implemented.

Thanks for the comments.
g.
