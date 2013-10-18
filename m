Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 909B12C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Oct 2013 04:29:24 +1100 (EST)
Date: Fri, 18 Oct 2013 18:28:14 +0100
From: Mark Brown <broonie@kernel.org>
To: Xiubo Li <Li.Xiubo@freescale.com>
Message-ID: <20131018172814.GT2443@sirena.org.uk>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-6-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ozmrAWQcVMJcOLTa"
In-Reply-To: <1382000477-17304-6-git-send-email-Li.Xiubo@freescale.com>
Subject: Re: [PATCHv1 5/8] ASoC: sgtl5000: Revise the bugs about the sgt15000
 codec.
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


--ozmrAWQcVMJcOLTa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 17, 2013 at 05:01:14PM +0800, Xiubo Li wrote:

> @@ -883,14 +883,19 @@ static int ldo_regulator_register(struct snd_soc_codec *codec,
>  				struct regulator_init_data *init_data,
>  				int voltage)
>  {
> +#ifdef CONFIG_SND_SOC_FSL_SGTL5000
> +	return 0;
> +#else
>  	dev_err(codec->dev, "this setup needs regulator support in the kernel\n");
>  	return -EINVAL;
> +#endif
>  }

If these systems don't actually need the internal regulator then should
they not be trying to enable it?  Alternatively if it's OK to ignore
this then why is this conditional in the board?

If this is something that it's safe to ignore then it should either be
ignored all the time or should be controlled by platform data not by a
compile time #define.

--ozmrAWQcVMJcOLTa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSYW+rAAoJELSic+t+oim9e1cP/iq+FRM1OthmKupHcsx75mPo
/BSHzbRMV3vQg8d5stwzWn2iH0cDe8uu61lc/clarnoWdBdscb3dgvsRMrV4SO1X
K/VGYDmdC/baGPYNL+Mx6CFEgO5bv0HOzYh0ItCbfht1DJWe7WK8YPW3xidxutsN
2vc4SiBdYepNKPpeqMP+OLdS1TFxn+nZKKxERsDoMrdAt9XsDW6MSaqXt7/q7cUd
fUEnXTINIJl+KhNqsrsf+pxhds6ezL0SkyCjuRDdXpUyw1ur0HBndJsTL4XKtClU
gr022z5LRSwXano+JbtpWoydBJ2t7qhUL956CG29JVjHfzGNJvep2k2vW7bXC4lB
UWjfy7xBf+NZNlQtTvIGi6tSlMvqEEKF5EKOMZoNMGa1+Pk0vtx3eqdjZk/9GFzJ
82cW0sRdS1l2fNvF4LYb5jC8rcqV43UKjG0SWOT0vxEKaLdWGFMSXHwgZaepwBx9
TAIclxB5+F20Yfo6cxUDmaVwywyCf1xJNL3pjqOFDYwEdX82SHqh+xabGp+Bsf9l
QtLpmAB6o1nvMNj/l45hDPoO7Vz5c1P1WwuDcppVtz72M4HIBlGRVna9Q2DDX60s
/luBFR/1qhLsDzE5ZGm+rqcb8gftbZqmLDLCZmO4gf9lbkgtwLuIavytfXKZUrAb
1EzNihFkatoctVTdBBN0
=tZKV
-----END PGP SIGNATURE-----

--ozmrAWQcVMJcOLTa--
