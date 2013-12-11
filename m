Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B23142C00A5
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Dec 2013 01:09:37 +1100 (EST)
Date: Wed, 11 Dec 2013 13:39:48 +0000
From: Mark Brown <broonie@kernel.org>
To: Hou Zhiqiang <b48286@freescale.com>
Message-ID: <20131211133948.GU11468@sirena.org.uk>
References: <1386749511-21904-1-git-send-email-b48286@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="gn1ylXQ+YRNuZICZ"
In-Reply-To: <1386749511-21904-1-git-send-email-b48286@freescale.com>
Subject: Re: [PATCH] spi/fsl-espi: Add Power Management support for eSPI
 controller
Cc: linuxppc-dev@ozlabs.org, Mingkai.Hu@freescale.com, scottwood@freescale.com,
 linux-spi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--gn1ylXQ+YRNuZICZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 11, 2013 at 04:11:51PM +0800, Hou Zhiqiang wrote:

> +#ifdef CONFIG_PM
> +static int of_fsl_espi_suspend(struct device *dev, pm_message_t state)

This should be CONFIG_PM_SLEEP.  I'd also expect to see a call to
spi_master_suspend() here (and similarly for resume) - it won't do
anything yet but it'd better for completeness in case we add extra
behaviour and looking at the driver it ought to be converted to
transfer_one_message anyway.

> +#ifdef CONFIG_PM
> +		.suspend	= of_fsl_espi_suspend,
> +		.resume		= of_fsl_espi_resume,
> +#endif

SET_SYSTEM_SLEEP_PM_OPS().

--gn1ylXQ+YRNuZICZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSqGsgAAoJELSic+t+oim9IUsP/3/H59rIAUo5xFeBDwjxRp/v
v5k0xb/N54E/ctORFJgUFECNe/fhb0qrGo6FGWEUzlHQ03yWlZLlRNncMK9nUhP4
pHTath8pwM8Bt25CnoEVKda/OpfsWdziocgjBRzh6Ij493uu1X6qWF+evxloMOnh
uw1pvtN6Wzvc3l7noYqoylVdP/7cH9kDHSlWoOWLyhTodhf0PrFB8ziPoeLt6g4P
l501BWnWUjdABslDM6/i5wiLY/GaX0LSz1O+5WdlK1MjYY/jjfKlm0ReM4OiJ6ke
JrZrCAYrlEz+1YBUYmnGzBORxke3YsI9WJRMt9+3y8dX1hzvqFwzSPUMaGCG4hWq
Tu3aMgXe4r4/zogQymYOuUCphFM1hF5bsxQqFO7+r+4GPtFo4nrKdN+3nz+o37oN
GRbg4amTyu7FeLDiTodROQNKsjfA6PAeDGiMO/Izyq8Hg0M64Y6K6UJ9K2tdFwdC
qQrNldwCQrDuerlYC/DNGLpFPxbJdrD0/ILVzIXEbZyMSNtKzaI2jr8R2Cv9aU2W
TJuLE1+iZE3yGfGKZPARW4JXLt586ofl42XXXQpEr0DSUo98zZGLKpPHPNysTrS/
lcLi5Z6PrqNOHRZh3dhCiEfTRVHKv0oGOyGUHQzYQkKV9AG3xzCBelFBrZCcI+WC
h/0obP4SS+FCCizzCLPw
=vRsf
-----END PGP SIGNATURE-----

--gn1ylXQ+YRNuZICZ--
