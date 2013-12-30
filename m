Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4C9192C00C8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Dec 2013 23:15:27 +1100 (EST)
Date: Mon, 30 Dec 2013 12:15:20 +0000
From: Mark Brown <broonie@kernel.org>
To: Xiubo Li <Li.Xiubo@freescale.com>
Message-ID: <20131230121520.GR31886@sirena.org.uk>
References: <1388026642-1464-1-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="99FKeZQ5IARcBmLz"
In-Reply-To: <1388026642-1464-1-git-send-email-Li.Xiubo@freescale.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Fix one bug for hardware limitation.
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de,
 linux-kernel@vger.kernel.org, timur@tabi.org, perex@perex.cz,
 shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org, b47053@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--99FKeZQ5IARcBmLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 26, 2013 at 10:57:22AM +0800, Xiubo Li wrote:
> This is maybe one bug or a limitation of the hardware that the {T,R}CR2's
> Synchronous Mode bits must be set as late as possible, or the SAI device
> maybe hanged up, and there has not any explaination about this limitation
> in the SAI Data Sheet.

If they really should be set as late as possible then I'd expect them to
be being set in the trigger function, that's what gets called as the
audio actually starts streaming.  This is moving it to the startup
function which is one of the first things that happens during audio
stream setup so presumably makes things worse.

Also...

> @@ -62,6 +62,7 @@ static int fsl_sai_set_dai_sysclk_tr(struct snd_soc_dai=
 *cpu_dai,
>  		reg_cr2 =3D FSL_SAI_RCR2;
> =20
>  	val_cr2 =3D sai_readl(sai, sai->base + reg_cr2);
> +
>  	switch (clk_id) {
>  	case FSL_SAI_CLK_BUS:
>  		val_cr2 &=3D ~FSL_SAI_CR2_MSEL_MASK;
> @@ -82,6 +83,7 @@ static int fsl_sai_set_dai_sysclk_tr(struct snd_soc_dai=
 *cpu_dai,
>  	default:
>  		return -EINVAL;
>  	}
> +
>  	sai_writel(sai, val_cr2, sai->base + reg_cr2);
> =20
>  	return 0;

These appear to be unrelated changes - please send as a separate patch
if they're useful.

--99FKeZQ5IARcBmLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSwWPVAAoJELSic+t+oim9Q9kQAJKZnwLZ5pE0ty4KCli4IzUG
S82G1YCQqQSMkEhJkauo16yfnoFLUIFwbvEm+MRwG5TgsUeBaFjKlrlMugh3c6Q+
9T/uIUpXrmsmTXW8mmGPUrKGppdkYxNL5+LOHqYDVi/NiceZ5guJl3ql/aInUZs/
0EI29sF4MwYJLNHuxXf2eoWyqrwhSAc3yg4MRuzKL9CdQU11Ym3V63sgCJa8ouFU
7n9Smpzv08yd9ZWU4PgV41gDElK5pCim1GqMDl1IKEpaO6gJItwkPdEsn0m3DxMN
GF9K98PZXSrcd/YwCqt+BVcs2w8j37VGt+PuYBAmcLYZXHQjkPnsz3k/VkzfA/tk
7ibJ9tihdaZiCz8+7kOv8/kqcPRV4G6/Oht6MDFz0dtpUNo9SQQ7X42PUXyomzCU
+zQAaCyRGaguUi0xfP/JBXp9c8osdBnGoVyZeFhwRfHLr/zqXGq/sm62dRXyP1Au
LVIXIncX09RLRbiCO3IL+zWu/CHpAgUtdqYuiVOw/D+BhSF6np8qgkCwr910ZzPg
I3XohrvOzHbQ3mvfWDcsfMe3KEDzkvXX07Gh2VPH8Uop2Wg3JVY9+f5i3xylRryt
/2enkTFJ8dZmr5qfEMJaI5dq/pkdr/Ut8DdXBDEHieBmQoqSYbMzYA+yp6kG87CI
vJsaQTPlYadXdGTVDFpD
=gZsL
-----END PGP SIGNATURE-----

--99FKeZQ5IARcBmLz--
