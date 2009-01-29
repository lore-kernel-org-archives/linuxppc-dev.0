Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 59715DE0E0
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 08:50:03 +1100 (EST)
Date: Thu, 29 Jan 2009 22:49:58 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc/5200: Bugfix for PCI mapping of memory and IMMR
Message-ID: <20090129214958.GG1406@pengutronix.de>
References: <20090127043315.26160.43312.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MiFvc8Vo6wRSORdP"
In-Reply-To: <20090127043315.26160.43312.stgit@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--MiFvc8Vo6wRSORdP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2009 at 09:34:36PM -0700, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
>=20
> This patch ensures that memory gets properly mapped into the PCI
> address space.  Without this patch, the memory window BAR is left
> at whatever value happened to be loaded into the BAR when Linux
> was booted.  Without this patch, memory could end up getting mapped
> at any of the 1G address boundaries instead of at '0' where Linux
> expects it.
>=20
> Similarly, this patch also ensures that the internally memory mapped
> registers (IMMR) are mapped to the correct PCI address range.
>=20
> Without this patch, PCI appears to work correctly until a PCI
> device is inserted which DMAs into memory.
>=20
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

No regression with a phyCORE-MPC5200B-tiny. U-Boot did probably the
right thing here...

Tested-by: Wolfram Sang <w.sang@pengutronix.de>

> ---
>=20
> This is a bugfix that I intend to merge into 2.6.29 and once it is
> mainlined get it added to the stable queue.  If you have a 5200 system,
> please test and make sure it works for you.
>=20
> Thanks
> g.
>=20
>  arch/powerpc/platforms/52xx/mpc52xx_pci.c |   24 ++++++++++--------------
>  1 files changed, 10 insertions(+), 14 deletions(-)
>=20
>=20
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pci.c b/arch/powerpc/pla=
tforms/52xx/mpc52xx_pci.c
> index c3f2c21..87ff522 100644
> --- a/arch/powerpc/platforms/52xx/mpc52xx_pci.c
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
> @@ -20,14 +20,6 @@
> =20
> =20
>  /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> -/* PCI windows config                                                   =
    */
> -/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> -
> -#define MPC52xx_PCI_TARGET_IO	0xf0000000
> -#define MPC52xx_PCI_TARGET_MEM	0x00000000
> -
> -
> -/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
>  /* Structures mapping & Defines for PCI Unit                            =
    */
>  /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> =20
> @@ -244,7 +236,7 @@ static struct pci_ops mpc52xx_pci_ops =3D {
> =20
>  static void __init
>  mpc52xx_pci_setup(struct pci_controller *hose,
> -                  struct mpc52xx_pci __iomem *pci_regs)
> +                  struct mpc52xx_pci __iomem *pci_regs, phys_addr_t pci_=
phys)
>  {
>  	struct resource *res;
>  	u32 tmp;
> @@ -314,10 +306,14 @@ mpc52xx_pci_setup(struct pci_controller *hose,
>  	/* Set all the IWCR fields at once; they're in the same reg */
>  	out_be32(&pci_regs->iwcr, MPC52xx_PCI_IWCR_PACK(iwcr0, iwcr1, iwcr2));
> =20
> -	out_be32(&pci_regs->tbatr0,
> -		MPC52xx_PCI_TBATR_ENABLE | MPC52xx_PCI_TARGET_IO );
> -	out_be32(&pci_regs->tbatr1,
> -		MPC52xx_PCI_TBATR_ENABLE | MPC52xx_PCI_TARGET_MEM );
> +	/* Map IMMR onto PCI bus */
> +	pci_phys &=3D 0xfffc0000; /* bar0 has only 14 significant bits */
> +	out_be32(&pci_regs->tbatr0, MPC52xx_PCI_TBATR_ENABLE | pci_phys);
> +	out_be32(&pci_regs->bar0, PCI_BASE_ADDRESS_MEM_PREFETCH | pci_phys);
> +
> +	/* Map memory onto PCI bus */
> +	out_be32(&pci_regs->tbatr1, MPC52xx_PCI_TBATR_ENABLE);
> +	out_be32(&pci_regs->bar1, PCI_BASE_ADDRESS_MEM_PREFETCH);
> =20
>  	out_be32(&pci_regs->tcr, MPC52xx_PCI_TCR_LD | MPC52xx_PCI_TCR_WCT8);
> =20
> @@ -414,7 +410,7 @@ mpc52xx_add_bridge(struct device_node *node)
> =20
>  	/* Finish setting up PCI using values obtained by
>  	 * pci_proces_bridge_OF_ranges */
> -	mpc52xx_pci_setup(hose, pci_regs);
> +	mpc52xx_pci_setup(hose, pci_regs, rsrc.start);
> =20
>  	return 0;
>  }
>=20

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--MiFvc8Vo6wRSORdP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmCJIYACgkQD27XaX1/VRt9VQCeNYQmSFTth1JH8S24NhhOGdFg
btsAmgJBewvW8wAWKYt84Ezwf7PqNGBQ
=Kz9u
-----END PGP SIGNATURE-----

--MiFvc8Vo6wRSORdP--
