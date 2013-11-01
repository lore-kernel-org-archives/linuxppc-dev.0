Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D95E72C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Nov 2013 05:26:51 +1100 (EST)
Date: Fri, 1 Nov 2013 11:25:14 -0700
From: Mark Brown <broonie@kernel.org>
To: Xiubo Li <Li.Xiubo@freescale.com>
Message-ID: <20131101182514.GE2493@sirena.org.uk>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-2-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="hjFmXiTvfEJBEd4m"
In-Reply-To: <1383289495-24523-2-git-send-email-Li.Xiubo@freescale.com>
Subject: Re: [PATCHv2 1/8] ALSA: Add SAI SoC Digital Audio Interface driver.
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


--hjFmXiTvfEJBEd4m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 01, 2013 at 03:04:48PM +0800, Xiubo Li wrote:

> +static int fsl_sai_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
> +		int div_id, int div)
> +{
> +	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
> +	u32 tcr2, rcr2;
> +
> +	if (div_id == FSL_SAI_TX_DIV) {
> +		tcr2 = readl(sai->base + FSL_SAI_TCR2);
> +		tcr2 &= ~FSL_SAI_CR2_DIV_MASK;
> +		tcr2 |= FSL_SAI_CR2_DIV(div);
> +		writel(tcr2, sai->base + FSL_SAI_TCR2);

What is this divider and why does the user have to set it manually?

> +	} else
> +		return -EINVAL;
> +

Coding style?

> +static int fsl_sai_dai_probe(struct snd_soc_dai *dai)
> +{
> +	int ret;
> +	struct fsl_sai *sai = dev_get_drvdata(dai->dev);
> +
> +	ret = clk_prepare_enable(sai->clk);
> +	if (ret)
> +		return ret;

It'd be nicer to only enable the clock while the device is in active
use.

> +	ret = snd_dmaengine_pcm_register(&pdev->dev, NULL,
> +			SND_DMAENGINE_PCM_FLAG_NO_RESIDUE);
> +	if (ret)
> +		return ret;

We should have a devm_ version of this.

--hjFmXiTvfEJBEd4m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSc/IHAAoJELSic+t+oim9rBkP/A0JFjGit6Y3Zo+3J28ul2QB
PvJCI/B5f6vmMxp5NWemjLgvSf+X7Vazu/v80gBZuVFM3nei+N9ReysV0eTahsj1
bCRpEPRkeNEl2w3S0135kF3yDUJfehrZaGRQwt8yNUh/VZA28SSA4qlMt0q5XdDd
Dxg9aHXBqnQ1C2jVRvkqV9aN30qxJC0FsW6amVu8hd7YYBDZV4shswE27E2UevLa
9soL8GPTjlLdntQMkaRjkuUHKhxCYfAlIB4JSL11YOKl8ZyXtNt3wcSaZZy5Rtfw
+lq5ZRLQkepfxOu9ImR98Bds+HbUAxoXQlDdBpBuSGs4icbHRISYTU4DEONN55px
C0Y7r815ruXcjq0Hn8zLVGytgna8mb0KiwaTCvYQ7X2Mw8dp6zgMgYqNVpNPt9LF
WA03+IGRe6+WWHeCYSYRY4fh9DFh1wQ+are8qY0tJTCoNaoVW1am3D2+0gJKECZg
Gytfdn8UIV8RYLEuD+F1pMGu8ik9iFoCVmGFBeYDClJTGmSDAolqJr70YBs9t6S5
CWAZvH+yZLodn6Doid6LydZLZE4A5hxZUAOW/c8m3Z75Z+nD8sbNeVPLgnQ58wai
WSZdyFjrNh9XUbFAySSmlJ3aYA7T8fIKIHCtcPZAX5hYGpagpWG9sgVHkAKO16+v
eGM2IulA5cJGsLmk7YAh
=Sj0u
-----END PGP SIGNATURE-----

--hjFmXiTvfEJBEd4m--
