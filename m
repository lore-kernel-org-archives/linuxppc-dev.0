Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 273142C0097
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Nov 2013 03:19:19 +1100 (EST)
Date: Mon, 4 Nov 2013 08:15:37 -0800
From: Mark Brown <broonie@kernel.org>
To: Li Xiubo <B47053@freescale.com>
Message-ID: <20131104161537.GI2493@sirena.org.uk>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-2-git-send-email-Li.Xiubo@freescale.com>
 <20131101182514.GE2493@sirena.org.uk>
 <1DD289F6464F0949A2FCA5AA6DC23F8287439D@039-SN2MPN1-013.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="9jVH9MMcXWLfwoO6"
In-Reply-To: <1DD289F6464F0949A2FCA5AA6DC23F8287439D@039-SN2MPN1-013.039d.mgd.msft.net>
Subject: Re: [PATCHv2 1/8] ALSA: Add SAI SoC Digital Audio Interface driver.
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "tiwai@suse.de" <tiwai@suse.de>, Huan Wang <B18965@freescale.com>,
 "timur@tabi.org" <timur@tabi.org>, "perex@perex.cz" <perex@perex.cz>,
 Shawn Guo <r65073@freescale.com>,
 "LW@KARO-electronics.de" <LW@KARO-electronics.de>,
 "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
 Guangyu Chen <B42378@freescale.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "grant.likely@linaro.org" <grant.likely@linaro.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "ian.campbell@citrix.com" <ian.campbell@citrix.com>,
 "pawel.moll@arm.com" <pawel.moll@arm.com>,
 "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "oskar@scara.com" <oskar@scara.com>, Fabio Estevam <r49496@freescale.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rob@landley.net" <rob@landley.net>, Zhengxiong Jin <R64188@freescale.com>,
 "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--9jVH9MMcXWLfwoO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 04, 2013 at 07:35:12AM +0000, Li Xiubo wrote:

> From the ASoC subsystem comments we can see that:
> ++++++
> Configures the clock dividers. This is used to derive the best DAI bit and
> frame clocks from the system or master clock. It's best to set the DAI bit
> and frame clocks as low as possible to save system power.
> ------

You should never use this unless you have to, there is no point in every
single machine driver using your driver having to duplicate the same
calculations.

>=20
> > > +static int fsl_sai_dai_probe(struct snd_soc_dai *dai) {
> > > +	int ret;
> > > +	struct fsl_sai *sai =3D dev_get_drvdata(dai->dev);
> > > +
> > > +	ret =3D clk_prepare_enable(sai->clk);
> > > +	if (ret)
> > > +		return ret;

> > It'd be nicer to only enable the clock while the device is in active us=
e.

> While if the module clock is not enabled here, the followed registers can=
not read/write in the same function.
> And this _probe function is the _dai_probe not the driver's module _probe.

So you can enable the clock when you explicitly need to write to the
registers...

> If the clk_prepare_enable(sai->clk) is not here, where should it be will =
be nicer ?
> One of the following functions ?
>         .set_sysclk     =3D fsl_sai_set_dai_sysclk,
>         .set_clkdiv     =3D fsl_sai_set_dai_clkdiv,
>         .set_fmt        =3D fsl_sai_set_dai_fmt,
>         .set_tdm_slot   =3D fsl_sai_set_dai_tdm_slot,
>         .hw_params      =3D fsl_sai_hw_params,
>         .trigger        =3D fsl_sai_trigger,

It could be in any or all of them except trigger (where the core should
hold a runtime PM reference anyway).  You can always take a reference
for the duration of the function if you're concerned it may be called
when the referent isn't otherwise held.

> > > +	ret =3D snd_dmaengine_pcm_register(&pdev->dev, NULL,
> > > +			SND_DMAENGINE_PCM_FLAG_NO_RESIDUE);
> > > +	if (ret)
> > > +		return ret;

> > We should have a devm_ version of this.

> Sorry, is there one patch for adding the devm_ version of snd_dmaengine_p=
cm_register() already ?
> In the -next and other topics branches I could not find it.

No, there isn't one but there should be one.

--9jVH9MMcXWLfwoO6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSd8gmAAoJELSic+t+oim9AZMQAIefObmkvnzc13/Qx9sJCNa0
47Mt+0tfJFdjadPL6ocKpX0tYxvxdeY30L/zOL7mq8Ehdvdp3PXQHWret3dHovwI
w4CYGja+2GenT711PAFfz9jYqlTEj17NhPMsfDc7gf4TSNSt+MztlejKcIpsXO+3
Mcbhl9n4j++Tr2p3PcT60KJEArAJSYxdu0JybxEdSv04dQcLCm3atqnMjJx8/C6W
w3HTaHtggsa6fa/hlgMGH9cGghtSPnISCtr60mc8/Kp9xa6p6RHNJx+DMYsDfgf2
OFA84thNFynw6hh54NaBhelaAGGydM2BuybD7C+Tik5V0mS2quFgTVS28EU6YlL8
xzCnt7CgmieVHwsKJ7Aq4tKrAvCf+ojub5mlXJAMnrv3Sp77i9rU94ICu7wGw+UG
vQ5bcmeYfLgrfxTtGjo/bp/mhvpI9/oNFJn/8NbiZ++XIjEsLp8VpZoPhMp3orI/
zuK8cfR5oSNVmYvn8xrQCqge1sUziYEJvANqDI3XiqOm5t9LIdrO/1Uc3x2vy7g1
VCcEk14w8HZWKZqu4zBKkiE9ezXSD5ZI1IEGLAM+1o0V1B1+bUuZv8olcPyS0XSq
m2j/ch+sbCR6MaHB817WVyICYDS85pOB4VeB1Fk7R5frmiWajqqsyPipZKZT/Kw2
Z3AO4y0D8GQT16dJL1a0
=YZgo
-----END PGP SIGNATURE-----

--9jVH9MMcXWLfwoO6--
