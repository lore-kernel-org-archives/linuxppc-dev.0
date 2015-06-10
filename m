Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 699C81A0018
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 04:09:28 +1000 (AEST)
Date: Wed, 10 Jun 2015 19:09:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Zidan Wang <zidan.wang@freescale.com>
Cc: nicoleotsuka@gmail.com, perex@perex.cz, tiwai@suse.de, timur@tabi.org,
 Xiubo.Lee@gmail.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org
Message-ID: <20150610180912.GQ14071@sirena.org.uk>
References: <b2a3c323a0507f3706041e1da98da8375aa61576.1433923593.git.zidan.wang@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="geeFENrZXK6HHgAa"
In-Reply-To: <b2a3c323a0507f3706041e1da98da8375aa61576.1433923593.git.zidan.wang@freescale.com>
Subject: Re: [alsa-devel][PATCH] ASoC: fsl: add imx-wm8960 machine driver
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--geeFENrZXK6HHgAa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 10, 2015 at 04:26:27PM +0800, Zidan Wang wrote:

> +  - hp-det		: ADCLRC/GPIO1, LINPUT3/JD2 and RINPUT3/JD3 pins can
> +			  be selected as headphone jack detect inputs to
> +			  automatically disable the speaker output and enable
> +			  the headphone output.
> +			  hp-det = <hp-det-pin hp-det-polarity>;
> +			  hp-det-pin = 1: ADCLRC/GPIO1 used as detect pin
> +			  hp-det-pin = 2: LINPUT3/JD2 used as detect pin
> +			  hp-det-pin = 3: RINPUT3/JD3 used as detect pin
> +			  hp-det-polarity = 0: hp detect high for headphone
> +			  hp-det-polarity = 1: hp detect high for speaker

This looks like something that should be in the DT binding for the
CODEC, not the machine driver.

> +static int hp_set_status_check(void *data)
> +{

Why is this in the driver?

> +	hp_status = gpio_get_value(priv->hp_set_gpio) ? 1 : 0;

gpio_get_value() already returns a boolean.

> +	if (hp_status != priv->hp_active_low) {
> +		snprintf(buf, 32, "STATE=%d", 2);
> +		snd_soc_dapm_disable_pin(&priv->codec->dapm, "Ext Spk");
> +		snd_soc_dapm_disable_pin(&priv->codec->dapm, "Main MIC");
> +		ret = imx_hp_set_gpio.report;

The generic jack code already has support for disabling and enabling
pins, though disabling the speaker looks like a policy decision which
probably doesn't belong here.

> +		/*
> +		 *  As the hp MIC only connect the input for left channel, we
> +		 *  need to route it for right channel.
> +		 */
> +		snd_soc_update_bits(priv->codec, WM8960_ADDCTL1, 3<<2, 1<<2);

This looks like routing which we'd expect userspace to be doing.

> +		snd_kctl_jack_report(priv->snd_card, priv->headset_kctl, 1);

Use the ASoC level helpers.

> +	envp[0] = "NAME=headset";
> +	envp[1] = buf;
> +	envp[2] = NULL;
> +	kobject_uevent_env(&pdev->dev.kobj, KOBJ_CHANGE, envp);
> +	kfree(buf);

Let the core deal with notifying userspace - it looks like you want to
implement extcon integration there.

> +	/* set cpu DAI configuration */
> +	ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
> +	if (ret) {
> +		dev_err(dev, "failed to set cpu dai fmt: %d\n", ret);
> +		return ret;
> +	}
> +	/* set codec DAI configuration */
> +	ret = snd_soc_dai_set_fmt(codec_dai, fmt);
> +	if (ret) {
> +		dev_err(dev, "failed to set codec dai fmt: %d\n", ret);
> +		return ret;
> +	}

Initialise these in the dai_link structure.

> +	for (i = 0; i < ARRAY_SIZE(sysclk_divs); ++i) {
> +		if (sysclk_divs[i] == -1)
> +			continue;
> +		sysclk /= sysclk_divs[i];
> +		for (j = 0; j < ARRAY_SIZE(dac_divs); ++j) {
> +			if (sysclk == sample_rate * dac_divs[j]) {
> +				for (k = 0; k < ARRAY_SIZE(bclk_divs); ++k)
> +					if (sysclk == bclk * bclk_divs[k] / 10)
> +						break;
> +				if (k != ARRAY_SIZE(bclk_divs))
> +					break;
> +			}
> +		}
> +		if (j != ARRAY_SIZE(dac_divs))
> +			break;
> +	}
> +	if (i != ARRAY_SIZE(sysclk_divs)) {
> +		/* Set codec sysclk */
> +		snd_soc_dai_set_sysclk(codec_dai,
> +				       WM8960_SYSCLK_MCLK, sysclk, 0);
> +		snd_soc_dai_set_clkdiv(codec_dai, WM8960_SYSCLKDIV, i << 1);
> +		return 0;
> +	}

Better, upgrade the CODEC driver to do this.

> +	/* codec mclk should be enabled early to avoid jack detect error */
> +	ret = clk_prepare_enable(data->codec_clk);
> +	if (ret) {
> +		dev_err(card->dev, "Failed to enable MCLK: %d\n", ret);
> +		return ret;
> +	}

Similarly integrating clock API support into the CODEC is better - it
makes all the DT stuff work a lot more smoothly and avoids things having
to get duplicated.

--geeFENrZXK6HHgAa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVeH1HAAoJECTWi3JdVIfQ5lwH/2utWkhCU4tFs2hA7lIqV0wl
L5MieRLa3IF89cZtChKY8iskWpyYEUfH4/2GGqVK/bZN4Wzr/Xg818LDeBYPpm4s
LKx+2+hSt0Iahugg4z5ULQ5Qeddc58GUaFkD1UOGhSXCJYE+0l8q7hT36/ZGrhG9
ygAgBklPxmfpaEN2Vb01v/6MY8H8HYQbvPFdaG2m6fSmL7XQ0EeAIN147YaUI7fK
8qN0vdAkzXwEcaFgemN2TZJ/iMkc0sVLjAmSjI+vNL5hYyogcb8LZPvsXqU3purj
qdBU70gsyxIv5qxYga4eD5ywzFvwyFHm4zikbcSYzKhW0zv4OPMoPvX/dnYKUW4=
=wo1m
-----END PGP SIGNATURE-----

--geeFENrZXK6HHgAa--
