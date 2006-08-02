Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH][2/2] RTAS MSI
From: Michael Ellerman <michael@ellerman.id.au>
To: Jake Moilanen <moilanen@austin.ibm.com>
In-Reply-To: <1154379714.29826.396.camel@goblue>
References: <1154024154.29826.229.camel@goblue>
	<1154024834.29826.240.camel@goblue>
	<1154320382.19883.26.camel@localhost.localdomain>
	<1154379714.29826.396.camel@goblue>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-2g9HzRW+XfxR1f1ec5gt"
Date: Wed, 02 Aug 2006 19:04:21 +1000
Message-Id: <1154509462.26242.9.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, PaulMackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-2g9HzRW+XfxR1f1ec5gt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-07-31 at 16:01 -0500, Jake Moilanen wrote:
> Here's version 3 which addresses all of Michael's comments.

Sorry, more questions :)

> Index: 2.6-msi/drivers/pci/msi-rtas.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /dev/null
> +++ 2.6-msi/drivers/pci/msi-rtas.c
> @@ -0,0 +1,99 @@
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
> +	int seq_num =3D 1;
> +	int i;
> +	int rc;
> +	int query_token =3D rtas_token("ibm,query-interrupt-source-number");
> +	int ret[2];
> +	int n_intr;
> +	int last_virq =3D NO_IRQ;
> +	int virq;
> +	unsigned int addr;
> +	unsigned long buid;
> +	struct device_node * dn;
> +
> +	dn =3D pci_device_to_OF_node(pdev);
> +
> +	if (!of_find_property(dn, "ibm,req#msi", NULL))
> +		return -ENOENT;
> +
> +	buid =3D get_phb_buid(dn->parent);
> +	addr =3D (pdev->bus->number << 16) | (pdev->devfn << 8);
> +
> +	do {
> +		rc =3D rtas_call(rtas_token("ibm,change-msi"), 6, 3, ret, addr,
> +			       buid >> 32, buid & 0xffffffff,
> +			       0, 0, seq_num);
> +
> +		seq_num =3D ret[1];
> +	} while (rtas_busy_delay(rc));
> +
> +	if (rc)	{
> +		printk(KERN_WARNING "error[%d]: getting the number of "
> +		       "MSI interrupts for %s\n", rc, dn->name);
> +		return -EIO;
> +	}
> +
> +	/* Return if there's no MSI interrupts */
> +	if (!ret[0])
> +		return -ENOENT;
> +
> +	n_intr =3D ret[0];
> +
> +	for (i =3D 0; i < n_intr; i++) {
> +		do {
> +			rc =3D rtas_call(query_token, 4, 3, ret, addr,
> +				       buid >> 32, buid & 0xffffffff, i);
> +		} while (rtas_busy_delay(rc));
> +
> +		if (!rc) {
> +			virq =3D irq_create_mapping(irq_find_host(dn), ret[0],
> +						ret[1] ? IRQ_TYPE_EDGE_RISING :
> +						IRQ_TYPE_LEVEL_LOW);

I'm only just starting to get benh's new irq code, but I think
irq_find_host(dn) isn't doing what we want here. It's probably harmless,
but AFAICT irq_find_host() is only meant to be called when you have the
node of the irq controller, not for an arbitrary dn. The doco's a bit
ambiguous:

 * irq_find_host - Locates a host for a given device node
 * @node: device-tree node of the interrupt controller

But looking at the implementation, it doesn't do a search up the tree or
anything, it just checks node against each host.

Also, since's benh's latest patch went in we'll have to split this into
two calls, I think we want:

virq =3D irq_create_mapping(NULL ???, ret[0]);
set_irq_type(virq, ret[1] ? IRQ_TYPE_EDGE_RISING : IRQ_TYPE_LEVEL_LOW);

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-2g9HzRW+XfxR1f1ec5gt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBE0GqVdSjSd0sB4dIRAhxuAKCZEJmYHQQ566QxxZXJ2K75541swQCbBJyn
xaj9frFh4iPz9ybU9aptW5I=
=XyRu
-----END PGP SIGNATURE-----

--=-2g9HzRW+XfxR1f1ec5gt--
