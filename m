Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] pseries: asm/pci-bridge.h CONFIG_ minor cleanup
From: Michael Ellerman <michael@ellerman.id.au>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20070521231816.GH5921@austin.ibm.com>
References: <20070521231816.GH5921@austin.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-7OOIRUSTYDVNs8oVKW36"
Date: Tue, 22 May 2007 10:40:59 +1000
Message-Id: <1179794459.7189.2.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-7OOIRUSTYDVNs8oVKW36
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-05-21 at 18:18 -0500, Linas Vepstas wrote:
> Use the correct CONFIG_ option to mark off the EEH bits.
> Move the EEH bits to the bottom of the struct.
>=20
> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
>=20
> ----
>  include/asm-powerpc/pci-bridge.h |   15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>=20
> Index: linux-2.6.22-rc1/include/asm-powerpc/pci-bridge.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.22-rc1.orig/include/asm-powerpc/pci-bridge.h	2007-05-21 18:=
13:00.000000000 -0500
> +++ linux-2.6.22-rc1/include/asm-powerpc/pci-bridge.h	2007-05-21 18:13:36=
.000000000 -0500
> @@ -70,19 +70,20 @@ struct pci_dn {
>  	int	devfn;			/* pci device and function number */
>  	int	class_code;		/* pci device class */
> =20
> -#ifdef CONFIG_PPC_PSERIES
> -	int	eeh_mode;		/* See eeh.h for possible EEH_MODEs */
> -	int	eeh_config_addr;
> -	int	eeh_pe_config_addr; /* new-style partition endpoint address */
> -	int 	eeh_check_count;	/* # times driver ignored error */
> -	int 	eeh_freeze_count;	/* # times this device froze up. */
> -#endif

You're making the struct 4 bytes larger by creating a hole here :(

>  	int	pci_ext_config_space;	/* for pci devices */
>  	struct  pci_controller *phb;	/* for pci devices */
>  	struct	iommu_table *iommu_table;	/* for phb's or bridges */
>  	struct	pci_dev *pcidev;	/* back-pointer to the pci device */
>  	struct	device_node *node;	/* back-pointer to the device_node */
> +
> +#ifdef CONFIG_EEH
> +	int	eeh_mode;		/* See eeh.h for possible EEH_MODEs */
> +	int	eeh_config_addr;
> +	int	eeh_pe_config_addr; /* new-style partition endpoint address */
> +	int 	eeh_check_count;	/* # times driver ignored error */
> +	int 	eeh_freeze_count;	/* # times this device froze up. */
>  	u32	config_space[16];	/* saved PCI config space */
> +#endif

It looks correct, but I think it's worth mentioning in the changelog
that config_space was previously unconditionally defined, but is now
within CONFIG_EEH.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-7OOIRUSTYDVNs8oVKW36
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGUjwbdSjSd0sB4dIRAvHVAJwOJRRvWipz8lZ6LPa1VvARAlaPDQCgwy6x
fXwRQv04u01UBBw4DDcT+SA=
=DkK6
-----END PGP SIGNATURE-----

--=-7OOIRUSTYDVNs8oVKW36--
