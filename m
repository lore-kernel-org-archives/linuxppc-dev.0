Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by ozlabs.org (Postfix) with ESMTP id 58C8ADE1EF
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jul 2008 06:49:35 +1000 (EST)
Date: Fri, 4 Jul 2008 21:49:27 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [alsa-devel] [PATCH 3/3] ALSA SoC: Add Texas Instruments
	TLV320AIC26 codec driver
Message-ID: <20080704204927.GC20719@sirena.org.uk>
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<20080701235340.16923.48024.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080701235340.16923.48024.stgit@trillian.secretlab.ca>
Cc: liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org,
	timur@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 01, 2008 at 05:53:40PM -0600, Grant Likely wrote:

> +static ssize_t aic26_keyclick_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct aic26 *aic26 = dev_get_drvdata(dev);
> +	int val, amp, freq, len;
> +
> +	val = aic26_reg_read_cache(&aic26->codec, AIC26_REG_AUDIO_CTRL2);
> +	amp = (val >> 12) & 0x7;
> +	freq = (125 << ((val >> 8) & 0x7)) >> 1;
> +	len = 2 * (1 +((val >> 8) & 0xf));
> +
> +	return sprintf(buf, "amp=%x freq=%iHz len=%iclks\n", amp, freq, len);
> +}

It might be nice if these parameters were exposed as controls if they
can be configured, though obviously that's not essential.

> +	/* Tell the of_soc helper about this codec */
> +	of_snd_soc_register_codec(&aic26_soc_codec_dev, aic26, &aic26_dai,
> +				  spi->dev.archdata.of_node);

Does this need to be ifdefed out if of_snd_soc_register_codec() is not
in use or is the function stubbed out if it's not in use?  Stubbing it
out would be cleaner.
