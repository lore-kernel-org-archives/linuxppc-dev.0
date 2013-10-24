Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B7ADE2C00C6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Oct 2013 22:06:52 +1100 (EST)
Date: Thu, 24 Oct 2013 12:05:43 +0100
From: Mark Brown <broonie@kernel.org>
To: Xiubo Li <Li.Xiubo@freescale.com>
Message-ID: <20131024110543.GA18506@sirena.org.uk>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
In-Reply-To: <1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com>
Subject: Re: [PATCHv1 1/8] ALSA: Add SAI SoC Digital Audio Interface driver.
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org,
 linux-doc@vger.kernel.org, tiwai@suse.de, b18965@freescale.com, timur@tabi.org,
 perex@perex.cz, r65073@freescale.com, LW@KARO-electronics.de,
 linux@arm.linux.org.uk, b42378@freescale.com,
 linux-arm-kernel@lists.infradead.org, grant.likely@linaro.org,
 devicetree@vger.kernel.org, ian.campbell@citrix.com, pawel.moll@arm.com,
 swarren@wwwdotorg.org, rob.herring@calxeda.com, oskar@scara.com,
 fabio.estevam@freescale.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
 rob@landley.net, r64188@freescale.com, shawn.guo@linaro.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 17, 2013 at 05:01:10PM +0800, Xiubo Li wrote:

> +static struct snd_pcm_hardware snd_fsl_hardware = {
> +	.info = SNDRV_PCM_INFO_INTERLEAVED |
> +		SNDRV_PCM_INFO_BLOCK_TRANSFER |
> +		SNDRV_PCM_INFO_MMAP |
> +		SNDRV_PCM_INFO_MMAP_VALID |
> +		SNDRV_PCM_INFO_PAUSE |
> +		SNDRV_PCM_INFO_RESUME,
> +	.formats = SNDRV_PCM_FMTBIT_S16_LE,
> +	.rate_min = 8000,
> +	.channels_min = 2,
> +	.channels_max = 2,
> +	.buffer_bytes_max = FSL_SAI_DMABUF_SIZE,
> +	.period_bytes_min = 4096,
> +	.period_bytes_max = FSL_SAI_DMABUF_SIZE / TCD_NUMBER,
> +	.periods_min = TCD_NUMBER,
> +	.periods_max = TCD_NUMBER,
> +	.fifo_size = 0,
> +};

There's a patch in -next that lets the generic dmaengine code figure out
some settings from the dmacontroller rather than requiring the driver to
explicitly provide configuration - it's "ASoC: dmaengine-pcm: Provide
default config".  Please update your driver to use this, or let's work
out what it doesn't do any try to fix it.

> +	ret = fsl_sai_set_dai_sysclk_tr(cpu_dai, clk_id, freq,
> +					FSL_FMT_TRANSMITTER);
> +	if (ret) {
> +		dev_err(cpu_dai->dev,
> +				"Cannot set sai's transmitter sysclk: %d\n",
> +				ret);
> +		return ret;
> +	}
> +
> +	ret = fsl_sai_set_dai_sysclk_tr(cpu_dai, clk_id, freq,
> +					FSL_FMT_RECEIVER);

As other people have commented these should be exposed as separate
clocks rather than set in sync, unless there's some hardware reason they
need to be identical.  If that is the case then a comment explaining the
limitation would be good.

Similarly with several of the other functions.

> +int fsl_sai_dai_remove(struct snd_soc_dai *dai)
> +{
> +	struct fsl_sai *sai = dev_get_drvdata(dai->dev);
> +
> +	clk_disable_unprepare(sai->clk);

It'd be a bit nicer to only enable the clock while the driver is
actively being used rather than all the time the system is powered up
but it's not a blocker for merge.

> +	ret = snd_soc_register_component(&pdev->dev, &fsl_component,
> +			&fsl_sai_dai, 1);
> +	if (ret)
> +		return ret;

There's a devm_snd_soc_register_component() in -next, please use that.

> +
> +	ret = fsl_pcm_dma_init(pdev);
> +	if (ret)
> +		goto out;
> +
> +	platform_set_drvdata(pdev, sai);

These should go before the driver is registered with the subsystem
otherwise you've got a race where something might try to use the driver
before init is finished.

> +static int fsl_sai_remove(struct platform_device *pdev)
> +{
> +	struct fsl_sai *sai = platform_get_drvdata(pdev);
> +
> +	fsl_pcm_dma_exit(pdev);
> +
> +	snd_soc_unregister_component(&pdev->dev);

Similarly here, unregister from the subsystem then clean up after.

> +#define SAI_CR5_FBT(x)		((x) << 8)
> +#define SAI_CR5_FBT_MASK	(0x1f << 8)
> +
> +/* SAI audio dividers */
> +#define FSL_SAI_TX_DIV		0
> +#define FSL_SAI_RX_DIV		1

Make the namespacing consistent please - for preference use FSL_SAI
always.

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSaP8EAAoJELSic+t+oim98ckP/0NBo4AKqrOWlBbpLWtZaoKt
idtXIrSBEyB1yvlJJCBguE2djGe0fgOzbMIfChRSno3AkFvD7cTjz6lKrzVo0nmC
/RDXX7EZzwuyuog/4fuTIySMZf9MTlwgjRv1YYqS5iXQ+2HlHVIi0R9V0+7A8xrl
wPXjBwpfJmlUjbUHJtGfGHy729tPrdDyqhcV2x5YKN5LftsbP+SjHzJAq4ZEaexk
S6RQReBmwabmpESCzj9SUZNhjuZCvA+jN8xTcyNKmVEZoIzgMXKrncmeAzuAtRik
FYp5h1svJQCvV4s1v2nyAN9Cd2FM59AUtHO/582dSJNzfoShHQh9jAHDJDfPlW7Q
+PnuKu8d7H+vf6Bnp35y49LOMgYIYRuE8gx6ZQn+ybqErMrE+NuLQLfWIb0ONYRV
6wpnl2czcI20YEuWLskPq8tA97alaFeiVrJOwGk/2UgdfuC4smDTZ+0GHSbdwroz
rHaZh3gRDE3dGOhOyWLYO6XvAqv+vfvg+ZWhkSFCvsBa0SPCsFWY4tqkRRGeKgrN
kfruj1UBt6V4evRhI1X8uoDyj+Hf4YImf6REEXmKSDPLpeai/DI+Rx7BicPJHFoo
ah5wj8Hbg4fB6A2fhQWm/mb4wVxeK+f44fbeIGUJpHtV4cekSIyYWv8YLZZl75zk
nt4qmQMv3lWrZk879i0f
=3gvt
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
