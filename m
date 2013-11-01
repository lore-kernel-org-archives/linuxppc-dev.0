Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AA95D2C0097
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Nov 2013 05:41:23 +1100 (EST)
Date: Fri, 1 Nov 2013 11:40:08 -0700
From: Mark Brown <broonie@kernel.org>
To: Xiubo Li <Li.Xiubo@freescale.com>
Message-ID: <20131101184008.GF2493@sirena.org.uk>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-7-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="1+kiJ7gFzGEgD6MU"
In-Reply-To: <1383289495-24523-7-git-send-email-Li.Xiubo@freescale.com>
Subject: Re: [PATCHv2 6/8] ASoC: fsl: add SGTL5000 based audio machine driver.
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


--1+kiJ7gFzGEgD6MU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 01, 2013 at 03:04:53PM +0800, Xiubo Li wrote:

> Conflicts:
> 	sound/soc/fsl/Makefile

Ahem.

> +	/* TODO: The SAI driver should figure this out for us */
> +	switch (channels) {
> +	case 2:
> +		snd_soc_dai_set_tdm_slot(cpu_dai, 0xfffffffc, 0xfffffffc, 2, 0);
> +		break;
> +	case 1:
> +		snd_soc_dai_set_tdm_slot(cpu_dai, 0xfffffffe, 0xfffffffe, 1, 0);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

Yes, it should - this code should probably just be copied straight into
the SAI driver.  If we need to support other configurations we can do
that later.

> +static int fsl_sgtl5000_remove(struct platform_device *pdev)
> +{
> +	snd_soc_unregister_card(&fsl_sgt1500_card);
> +
> +	return 0;
> +}

You're using snd_soc_unregister_card() so you don't need to do this.

--1+kiJ7gFzGEgD6MU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSc/WFAAoJELSic+t+oim9Ro4P/3xf1v287JoZR9nyoMd0771B
F1Bk7L3WgUf6Uh5CqBQP+50g1Utl3RgKxDsNKLraQcFx551slcVooB+UY2itoaVa
aPIruEjPjezEwCufZiq4zysesLER7BxeBZNGpXU8qwALxyf/WfRQWo8pJCd4798t
ANucUXbO2ekgHkCmdb2+f3v6Alm1s/ZiSoyDYKKcM9BJWSc3QZL3/3lxKaqeBTC/
FS5F13y6QBjpPNQv/Js9TvvZvbO3BeBBGvrhl9mCWxI5r2xg7Ei8m+tHPsDveJBM
Jrk/VnZ++x1/gbIx1+b8mfiClRc5gi8eZx2F+bDUqyEFfM0yXxHCtJwgYA2AuUzr
gTwnSAUXnwUgbx+D9/Go8AReABYfZTUd9W+ojqgaZauhjegWf7qA2c1uXtuv0Uul
s4VsUei18tbpLd1d1aiq3keCKjPExczv825fAQswyOYYK5B+1LCQBWRg0tpgkV2E
DRyooyJPEqUvtzHjccIDZhyFpi80q28fLO0BwVdhN3biiKC0LEnRssPOzmw/DaHM
Tcyxz51G240vXTf7yzoj+JL+wCybt73GjVke7MmNGKe4qpc1vOeo6q/8bY7eSprm
EJ2PPtzz+3QQNSjPCVKh6i6DpfVDvfe467w8nQdQDRppMYgOZ2ZbQDiew0XdxMgn
warO8G6CTyjEs5cC3h+0
=Px4Z
-----END PGP SIGNATURE-----

--1+kiJ7gFzGEgD6MU--
