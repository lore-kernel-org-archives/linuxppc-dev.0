Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C86B41A001F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Sep 2014 04:15:52 +1000 (EST)
Date: Tue, 9 Sep 2014 19:15:16 +0100
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Message-ID: <20140909181516.GI2601@sirena.org.uk>
References: <e5a50d8bfde3aea5fcd092118da5aea4072c7e2f.1410254125.git.shengjiu.wang@freescale.com>
 <20140909112750.GS2601@sirena.org.uk>
 <20140909180309.GA6784@Asurada>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="8lKUOMLFs7xrer6k"
In-Reply-To: <20140909180309.GA6784@Asurada>
Subject: Re: [PATCH V1] ASoC: fsl_ssi: refine ipg clock usage in this module
Cc: Shengjiu Wang <shengjiu.wang@freescale.com>, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, tiwai@suse.de, linux-kernel@vger.kernel.org,
 timur@tabi.org, perex@perex.cz, Li.Xiubo@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--8lKUOMLFs7xrer6k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 09, 2014 at 11:03:10AM -0700, Nicolin Chen wrote:
> On Tue, Sep 09, 2014 at 12:27:50PM +0100, Mark Brown wrote:
> > On Tue, Sep 09, 2014 at 05:18:07PM +0800, Shengjiu Wang wrote:
> > > -	ssi_private->clk = devm_clk_get(&pdev->dev, NULL);
> > > +	ssi_private->clk = devm_clk_get(&pdev->dev, "ipg");

> > Why is this change being made?  It wasn't mentioned in the commit log
> > and doesn't seem relevant to moving where the enable and disable are
> > done which is what the patch is supposed to be doing...

> I think Shengjiu is trying to keep the clock disabled while SSI's idle.
> The current driver enables ipg clock anyway even if there's no stream
> running.

> Apparently, these should be put into the comment log.

I got that bit.  However as well as changing where the enable and
disable take place this is also changing from requesting a clock with a
NULL to requesting one called "ipg".

--8lKUOMLFs7xrer6k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUD0OsAAoJECTWi3JdVIfQbgwH/20teJPh6rqrGN8svTU/E6r4
mZir/1YdrwwoMgjT0h7TmC5D+v5CoV4fo12fpPuXPzLjVSoGpmCxnoQH/89X92g/
86BxCIZSh1haKI9YxNlysOgO9wO6OHvz6N1C+4hnWhWMSZ03SP97XEtzLcuYXwEu
PZMq376RA1UAJUi72UFhdUGwSXK+dUlskBOo1OG3Lqh3XXjYdJT889Kt22o6dXJD
/uFnSf4TDnVKmWRfFkmcTtapjNuhp4KFbxXB4ttQgymvHvUusscltgxdn2pDb/gz
n75lx26dlHsRAnkp7uJd5FmPQDSZxRaE/bBx+bODPEIX9pKvwUsyEKWN5mtMpss=
=4PvN
-----END PGP SIGNATURE-----

--8lKUOMLFs7xrer6k--
