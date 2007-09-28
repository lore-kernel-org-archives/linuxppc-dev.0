Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] Make sure to of_node_get() the result of
	pci_device_to_OF_node()
From: Michael Ellerman <michael@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <8183225ab4b14684bb0939e0c5258caaf5b8102f.1190008974.git.michael@ellerman.id.au>
References: <8183225ab4b14684bb0939e0c5258caaf5b8102f.1190008974.git.michael@ellerman.id.au>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-FXfdDgAXdo2WSojM+x+A"
Date: Fri, 28 Sep 2007 16:47:14 +1000
Message-Id: <1190962034.11937.8.camel@concordia>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, Arnd Bergmann <arnd@arndb.de>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-FXfdDgAXdo2WSojM+x+A
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-09-17 at 16:03 +1000, Michael Ellerman wrote:
> pci_device_to_OF_node() returns the device node attached to a PCI device,
> but doesn't actually grab a reference - we need to do it ourselves.

Hi Paul,

Can you stick this in your 24 tree for the moment, the warnings it fixes
are giving people the willys. I'll look at the proper fix of having
pci_device_to_OF_node() take the reference and fixing all the callers.

cheers


> diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platfo=
rms/cell/axon_msi.c
> index 57a6149..2b2dfcc 100644
> --- a/arch/powerpc/platforms/cell/axon_msi.c
> +++ b/arch/powerpc/platforms/cell/axon_msi.c
> @@ -119,7 +119,7 @@ static struct axon_msic *find_msi_translator(struct p=
ci_dev *dev)
>  	const phandle *ph;
>  	struct axon_msic *msic =3D NULL;
> =20
> -	dn =3D pci_device_to_OF_node(dev);
> +	dn =3D of_node_get(pci_device_to_OF_node(dev));
>  	if (!dn) {
>  		dev_dbg(&dev->dev, "axon_msi: no pci_dn found\n");
>  		return NULL;
> @@ -176,7 +176,7 @@ static int setup_msi_msg_address(struct pci_dev *dev,=
 struct msi_msg *msg)
>  	int len;
>  	const u32 *prop;
> =20
> -	dn =3D pci_device_to_OF_node(dev);
> +	dn =3D of_node_get(pci_device_to_OF_node(dev));
>  	if (!dn) {
>  		dev_dbg(&dev->dev, "axon_msi: no pci_dn found\n");
>  		return -ENODEV;
--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-FXfdDgAXdo2WSojM+x+A
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG/KNydSjSd0sB4dIRAuYDAJ9hVGfnt5+8O4hTzEFi68XC3DnJ1QCdFId6
CS+ByXgWk7GZr1RxsQ85ch0=
=mT54
-----END PGP SIGNATURE-----

--=-FXfdDgAXdo2WSojM+x+A--
