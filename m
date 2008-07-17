Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 42E6BDE3AA
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 02:02:26 +1000 (EST)
Message-ID: <487F6D07.40503@freescale.com>
Date: Thu, 17 Jul 2008 11:02:15 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 3/3] ALSA SoC: Add Texas Instruments TLV320AIC26 codec
	driver
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080712083939.15025.31192.stgit@trillian.secretlab.ca>
In-Reply-To: <20080712083939.15025.31192.stgit@trillian.secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
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

Grant Likely wrote:

> +	aic26->codec.reg_cache_size = sizeof(aic26->reg_cache);
> +	aic26->codec.reg_cache = aic26->reg_cache;

...

> +	/* Register the sysfs files for debugging */
> +	/* Create SysFS files */
> +	rc = device_create_file(&spi->dev, &dev_attr_regs);
> +	rc |= device_create_file(&spi->dev, &dev_attr_regs_cache);
> +	rc |= device_create_file(&spi->dev, &dev_attr_keyclick);
> +	if (rc)
> +		dev_info(&spi->dev, "error creating sysfs files\n");

I believe ASoC creates sysfs entries if you use reg_cache and reg_cache_size, so
you should not be creating your own sysfs entries if you use these variables.

> +
> +#if defined(CONFIG_SND_SOC_OF)
> +	/* Tell the of_soc helper about this codec */
> +	of_snd_soc_register_codec(&aic26_soc_codec_dev, aic26, &aic26_dai,
> +				  spi->dev.archdata.of_node);
> +#endif

I haven't paid any attention to the of_soc helper, because it's for ASoC V1
only.  However, I don't understand why you need to reference it in the codec
driver.  My CS4270 codec driver knows nothing about OF and works fine in
arch/powerpc.

-- 
Timur Tabi
Linux kernel developer at Freescale
