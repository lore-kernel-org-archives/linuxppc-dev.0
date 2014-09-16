Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 21F4B1A0009
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 04:32:57 +1000 (EST)
Date: Tue, 16 Sep 2014 11:32:31 -0700
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Message-ID: <20140916183231.GW7960@sirena.org.uk>
References: <1410867994-32138-1-git-send-email-shengjiu.wang@freescale.com>
 <20140916180028.GA6784@Asurada>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="WqTjpp3GQTmREKEt"
In-Reply-To: <20140916180028.GA6784@Asurada>
Subject: Re: [PATCH] ASoC: fsl_spdif: don't change the root clock rate of
 spdif in driver
Cc: Shengjiu Wang <shengjiu.wang@freescale.com>, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, tiwai@suse.de, linux-kernel@vger.kernel.org,
 timur@tabi.org, perex@perex.cz, Li.Xiubo@freescale.com,
 linuxppc-dev@lists.ozlabs.org, shawn.guo@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--WqTjpp3GQTmREKEt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 16, 2014 at 11:19:28AM -0700, Nicolin Chen wrote:

> So I think, if it's a shared clock, we should not define it as a
> rate-changeable one in the SoC level, as we might still have some
> SoCs provide a dedicated clock to S/PDIF so as to get the maximum
> range of clock support for users.

> @Shawn
> Sorry to involve you in this topic. I'm not so sure if we can do
> this in the clock driver so that the clock rate would be fixed
> even if the driver is trying to change it. If we can, I think we
> may use a better solution here instead.

I tend to agree here.  My first thought here is that we should have
support in the clock API for constraining clocks in the clock API so we
can still set the clock where there's a possibility to do that.  Not
trivail to implement though.

--WqTjpp3GQTmREKEt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUGII+AAoJECTWi3JdVIfQIvQH/j2M+9wF9bsoaA5a9C0ez09n
XNDSYe0ckk6/FufDwY0Jhan6FjtTSNIq159kQtqjL3GnuXJww0ZOabmHGDRWBedY
CZ5D4NDvoBnN0KBxzO3UqOvRFBFBlfFz8kKG6H+Usl899qBI3cvXBxol/wWK1vAx
giDr48DV6V/g6WEuFA7ESndZzXbGYjzLxrUCdHMwliAK2AAMtr23kE1PJofVkBoh
Iki9hDPuIKpcr6YBHFNWngyMuzo7lO3CCXraABZ1lXvLSZuE71ltjPcfwSf/RHc6
SRqmYtmYoDrCqyAJACCjeBb6y6oTY1xEPkUIIfeM2hyv0/yET5hWKQzqVTkvBK4=
=eDxO
-----END PGP SIGNATURE-----

--WqTjpp3GQTmREKEt--
