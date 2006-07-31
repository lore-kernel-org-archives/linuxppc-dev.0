Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH][2/2] RTAS MSI
From: Michael Ellerman <michael@ellerman.id.au>
To: Jake Moilanen <moilanen@austin.ibm.com>
In-Reply-To: <1154024834.29826.240.camel@goblue>
References: <1154024154.29826.229.camel@goblue>
	<1154024834.29826.240.camel@goblue>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-/SBdM8o++6ha1QIiFmjr"
Date: Mon, 31 Jul 2006 14:33:02 +1000
Message-Id: <1154320382.19883.26.camel@localhost.localdomain>
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


--=-/SBdM8o++6ha1QIiFmjr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-07-27 at 13:27 -0500, Jake Moilanen wrote:
> Rebased with the IRQ layer rewrite.  The code is not deallocating the
> vectors on a pci_disable_msi().  This is to work around a firmware
> vector release bug.  Plus it is really not needed, as
> irq_create_mapping() just returns mappings to irqs that it knows of.
>=20
> Additionally, the patch includes the client architecture bit for MSI,
> and correctly identifying that MSI is edge triggered. =20

Hey Jake, just a few niggles below ..

> Index: 2.6-msi/drivers/pci/msi-rtas.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /dev/null
> +++ 2.6-msi/drivers/pci/msi-rtas.c
> @@ -0,0 +1,111 @@
> +/*
> + * Jake Moilanen <moilanen@austin.ibm.com>
> + * Copyright (C) 2006 IBM
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; version 2 of the
> + * License.
> + *
> + */
> +
> +#include <linux/pci.h>
> +#include <linux/irq.h>
> +#include <asm/rtas.h>
> +#include <asm/hw_irq.h>
> +#include <asm/ppc-pci.h>
> +
> +int rtas_enable_msi(struct pci_dev* pdev)
> +{
> +	static int seq_num =3D 1;

Do we really want seq_num to be static? By my reading of PAPR we only
need to maintain the seq number across calls that return -2/990x, and we
handle that all inside this function. If it does need to be unique for
_all_ calls, then I don't see how seq_num being static is going to work,
a different cpu could stomp on the seq_num value between calls, which
presumably would make firmware mad.

> +	int i;
> +	int rc;
> +	int query_token =3D rtas_token("ibm,query-interrupt-source-number");
> +	int devfn;
> +	int busno;
> +	u32 *reg;
> +	int reglen;
> +	int ret[3];

You only need ret[2] I think, the first return value (status) is handled
inside rtas_call for you.

> +	int dummy;
> +	int n_intr;
> +	int last_virq =3D NO_IRQ;
> +	int virq;
> +	unsigned int addr;
> +	unsigned long buid =3D -1;

No need to set buid to -1 as you unconditionally assign to it later.

> +	struct device_node * dn;
> +
> +	dn =3D pci_device_to_OF_node(pdev);
> +
> +	if (!of_find_property(dn, "ibm,req#msi", &dummy))
> +		return -ENOENT;

You don't need dummy, just pass NULL.

> +
> +	reg =3D (u32 *) get_property(dn, "reg", &reglen);
> +	if (reg =3D=3D NULL || reglen < 20)
> +		return -ENXIO;
> +
> +	devfn =3D (reg[0] >> 8) & 0xff;
> +	busno =3D (reg[0] >> 16) & 0xff;
> +
> +	buid =3D get_phb_buid(dn->parent);
> +	addr =3D (busno << 16) | (devfn << 8);

Why do we need to read the reg here, can't we just use the existing
fields? ie:

        addr =3D (pdev->bus->number << 16) | (pdev->devfn << 8);

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-/SBdM8o++6ha1QIiFmjr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEzYf+dSjSd0sB4dIRAu6KAJ9IFgFLy+XFOyae13qoBYuo0mA23QCgnShb
tgEDvGAHMknhw6d4fkxYl4M=
=4Ydk
-----END PGP SIGNATURE-----

--=-/SBdM8o++6ha1QIiFmjr--
