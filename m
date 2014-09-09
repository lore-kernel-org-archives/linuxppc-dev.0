Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C28141A0019
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Sep 2014 01:22:13 +1000 (EST)
Date: Tue, 9 Sep 2014 16:21:14 +0100
From: Mark Brown <broonie@kernel.org>
To: Timur Tabi <timur@tabi.org>
Message-ID: <20140909152114.GA2601@sirena.org.uk>
References: <e5a50d8bfde3aea5fcd092118da5aea4072c7e2f.1410254125.git.shengjiu.wang@freescale.com>
 <540EFDFF.7050804@tabi.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="7A15IXT36zwL5BDA"
In-Reply-To: <540EFDFF.7050804@tabi.org>
Subject: Re: [PATCH V1] ASoC: fsl_ssi: refine ipg clock usage in this module
Cc: Shengjiu Wang <shengjiu.wang@freescale.com>, alsa-devel@alsa-project.org,
 tiwai@suse.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
 perex@perex.cz, nicoleotsuka@gmail.com, Li.Xiubo@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--7A15IXT36zwL5BDA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 09, 2014 at 08:17:51AM -0500, Timur Tabi wrote:
> Shengjiu Wang wrote:
> >+	if (ssi_private->soc->imx)
> >+		clk_prepare_enable(ssi_private->clk);

> How about this instead?

> if (ssi_private->clk)
> 	clk_prepare_enable(ssi_private->clk);

Should be a !IS_ERR() - NULL is a valid clock.

--7A15IXT36zwL5BDA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUDxrmAAoJECTWi3JdVIfQGHQH/iYPDA+Ux7C65f6IB8MrMaBa
UekhxwGPUW+ixAdaweL1z04umskGJbbJHRbxkaFFyWi15lzF6KLN+ntWwxg7qpld
H7yUxhQixGWicLewybTFxSj5TMId8yNmbuC3pXDEn9eRz46F1MHwznSCcuEP4ueA
dsxAUoapO6cieCphAljMKOL/UEVOUmLbYCnpaVF/sOJThVY+IWWzZHVhjPqCiXx3
2VXxbK5VG9bZRWirapyOV2O54iFWKtcVGxsZKmDieMj32YzVMtDPn15qsAk+2trZ
ESajHSwBg45/QLRejykIoJC5Y+p3AeaWRmB48Hwb6SV+Z9udzliEf2+EblvVEbA=
=xkyN
-----END PGP SIGNATURE-----

--7A15IXT36zwL5BDA--
