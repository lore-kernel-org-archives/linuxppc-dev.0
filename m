Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrlFv3DJczDq68
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 15:55:15 +1000 (AEST)
Date: Fri, 22 Apr 2016 15:15:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, alistair@popple.id.au, ruscur@russell.cc,
 mpe@ellerman.id.au
Subject: Re: [PATCH 3/3] powerpc/eeh: Drop unnecessary label in
 eeh_pe_change_owner()
Message-ID: <20160422051501.GF15176@voom.fritz.box>
References: <1461239595-5627-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1461239595-5627-3-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="l+goss899txtYvYf"
In-Reply-To: <1461239595-5627-3-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--l+goss899txtYvYf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 21, 2016 at 09:53:07PM +1000, Gavin Shan wrote:
> The label "reset" in eeh_pe_change_owner() is used only for once.
> No need to keep it and just drop it. No logicial changes introduced.
>=20
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/kernel/eeh.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> index 6544017..4b40d56 100644
> --- a/arch/powerpc/kernel/eeh.c
> +++ b/arch/powerpc/kernel/eeh.c
> @@ -1336,14 +1336,11 @@ static int eeh_pe_change_owner(struct eeh_pe *pe)
>  			    id->subdevice !=3D pdev->subsystem_device)
>  				continue;
> =20
> -			goto reset;
> +			return eeh_pe_reset_and_recover(pe);
>  		}
>  	}
> =20
>  	return eeh_unfreeze_pe(pe, true);
> -
> -reset:
> -	return eeh_pe_reset_and_recover(pe);
>  }
> =20
>  /**

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--l+goss899txtYvYf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXGbNVAAoJEGw4ysog2bOS97cQAIuEnu+plgKX/Rb/zWIyDMX/
aFRaBR3GWPoaGgR+lFa1lNnh2LmxWyGtRrz9962/tgBIpfPGyOgfUjyBln8apbcc
3k1BDPB3MdeZQ8zcPHi6r/+f+0Bgk4eIReO78zttFDt0QjHj+QpukGrDpIUEYbQs
zzztRi59CbanZr2uU+gVfBYaXD+706QOfPc3CrpwpD1YnzmfHZW+allDCLG1mv1X
hzvWAfLN2CEeP1H7sr3dd7k0n+4jUCFM3dZo5fR6y5QMkNmOuTjLAKe7K/fl9XMs
3rbiVCbgT+4Mvev3YW3vHZYbMmwPuIRnGtm/p02YDFbp0cWlUdqRFgYqc6rQd//t
CQ5mlE23meu6fxxYCPnKzfpwjCrLHDvTCqinUhpiBvoHfqRWVldhr7dAQMkeAUs8
x+pyq+1Iwtn/QbnU5kspc0Pz5aG83kK4WU42yHFh3epcByAgLxE+gzoiZybl2dXQ
2CyQQS282YESrneJ39QInlcLYGxwuqZUaRKF1vKo2w0X+efeqpEd9xjQeJz8QfCD
y6MZQeTyAoLbGQD2e9htlTzgShFoMxk0j8oQH1iPviFy0uAzIZTUxuRY4sSbyMLd
diu4gAe63ADvrmqCgqlBM6OKoA1/YzdDw0fIsVacMEnOEOCUZHZ8gFpFLpgt6Xf2
JNaNxB+VJELeckpVSiu7
=rrkk
-----END PGP SIGNATURE-----

--l+goss899txtYvYf--
