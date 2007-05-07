Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 17/19] PCI: rpaphp: Use pcibios_remove_pci_devices()
	symmetrically
From: Michael Ellerman <michael@ellerman.id.au>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20070403173154.77B623A65C@topology.austin.ibm.com>
References: <20070403173154.77B623A65C@topology.austin.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-rViW2jpdP66u2hdH77CW"
Date: Mon, 07 May 2007 15:09:14 +1000
Message-Id: <1178514554.14398.26.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
	pcihpd-discuss@lists.sourceforge.net
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-rViW2jpdP66u2hdH77CW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-04-03 at 12:31 -0500, Linas Vepstas wrote:
> At first blush, the disable_slot() routine does not look
> at all like its symmetric with the enable_slot() routine;
> as it seems to call a very different set of routines.
> However, this is easily fixed: pcibios_remove_pci_devices()
> does the right thing.
>=20
> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
> Cc: John Rose <johnrose@austin.ibm.com>
>=20
> ----
>=20
>  drivers/pci/hotplug/rpaphp_core.c |   10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>=20
> Index: linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_core.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpaphp_core.c	2007-04-=
03 11:04:41.000000000 -0500
> +++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_core.c	2007-04-03 11=
:04:47.000000000 -0500
> @@ -424,18 +424,12 @@ static int enable_slot(struct hotplug_sl
>  	return retval;
>  }
> =20
> -static int __disable_slot(struct slot *slot)
> +static inline int __disable_slot(struct slot *slot)
>  {
> -	struct pci_dev *dev, *tmp;
> -
>  	if (slot->state =3D=3D NOT_CONFIGURED)
>  		return -EINVAL;
> =20
> -	list_for_each_entry_safe(dev, tmp, &slot->bus->devices, bus_list) {
> -		eeh_remove_bus_device(dev);
> -		pci_remove_bus_device(dev);
> -	}
> -
> +	pcibios_remove_pci_devices(slot->bus);

You need to add an EXPORT_SYMBOL() for this.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-rViW2jpdP66u2hdH77CW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGPrR6dSjSd0sB4dIRApTAAJ4jW9xc85GKmXxRWIzdR/kBuDdTwACeKHCy
aT7bffxFfULDtdxB4BVGUDc=
=v2bz
-----END PGP SIGNATURE-----

--=-rViW2jpdP66u2hdH77CW--
