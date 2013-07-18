Return-Path: <broonie@sirena.org.uk>
Date: Thu, 18 Jul 2013 21:49:56 +0100
From: Mark Brown <broonie@kernel.org>
To: Gerhard Sittig <gsi@denx.de>
Message-ID: <20130718204956.GU22506@sirena.org.uk>
References: <1373914074-20889-1-git-send-email-gsi@denx.de>
 <1374166855-7280-1-git-send-email-gsi@denx.de>
 <1374166855-7280-2-git-send-email-gsi@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="UsIKHTtpqa9hxcvF"
In-Reply-To: <1374166855-7280-2-git-send-email-gsi@denx.de>
Subject: Re: [PATCH v2 01/24] spi: mpc512x: cleanup clock API use
Cc: Mike Turquette <mturquette@linaro.org>, Detlev Zundel <dzu@denx.de>,
 Wolfram Sang <wsa@the-dreams.de>, David Woodhouse <dwmw2@infradead.org>,
 devicetree-discuss@lists.ozlabs.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <rob.herring@calxeda.com>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Wolfgang Grandegger <wg@grandegger.com>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--UsIKHTtpqa9hxcvF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 18, 2013 at 07:00:32PM +0200, Gerhard Sittig wrote:

> +	psc_num = master->bus_num;
> +	snprintf(clk_name, sizeof(clk_name), "psc%d_mclk", psc_num);
> +	mps->clk_mclk = clk_get(dev, clk_name);
> +	if (IS_ERR(mps->clk_mclk))
> +		goto free_irq;

Should be using devm_clk_get().

--UsIKHTtpqa9hxcvF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR6FTxAAoJELSic+t+oim9NNcP/A9TP2KECJIULm9OaazmNXl4
Ckij+jj4rK31RPK+1Hx/2hfRPl/Z+RJ7Q0LStXV/CYMskBTH86L5TWKI9r4bmFuf
2DpClmSuzsHVMZazAigcG0uVqbUST49AWvmPKCrgL4h0RVLxQFvb2A4AMqamZfpN
e6YkKRl0vgg5Zm1wlML9qmU1nBCMwvmxZ49IaWzv1pua+EG6BI1bBqn0FoOpI5rC
0C/b7Z8FDEVjkDl3+fG4d6A6tO18mtEbMXpYLuzwANCkSX8vPHGDA6CxHIOBo0m+
0Dalsm/eLEIXzkYu+2fzGDSiiOZkETVdk0ywJgC3ufi3tvJUX2JLBWzVDuELV5ZD
6apqWKwapVZxBHt3Zdn0LOiSS4GYLl85qKraJMpTjNpVlo5J0wZ32h0ZJ14Q3Npa
5B/A+GZv9d0DS2u5Ef1fu0qztX8reXZqxy3iYVn3edz/Qcgav0GEOnTEZvWQDL4n
FrhOrKP07bOgfg/CbDz80D8S1aReprvfbKE2zsP4iMtWXsezWbeIkSSiuJWmO+80
4cRIea/Ct1JuPKi946Va4uLbgD6rd58NcGJ0cCPzQMLAtQJwa4Libh3xrDB94tsU
5sHZVExmFKVqpv/tAcIbmbMvZH5RWEVow+jQxRD33yu1/+yJIrQvvtZcC5nZOaNp
nl3zY6ZTZnKUfAyeVrLL
=gM5y
-----END PGP SIGNATURE-----

--UsIKHTtpqa9hxcvF--
