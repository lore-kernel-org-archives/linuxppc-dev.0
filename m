Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CB240B7BC0
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Aug 2009 16:01:23 +1000 (EST)
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B137FDDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2009 16:01:23 +1000 (EST)
Date: Fri, 21 Aug 2009 16:01:16 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/3] powerpc/pci: move pci_64.c device tree scanning
	code into pci-common.c
Message-Id: <20090821160116.b4a7b713.sfr@canb.auug.org.au>
In-Reply-To: <20090821053014.2289.59798.stgit@localhost.localdomain>
References: <20090821052714.2289.41279.stgit@localhost.localdomain>
	<20090821053014.2289.59798.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__21_Aug_2009_16_01_16_+1000_4IyZtuNPfRQ66+J."
Cc: "David S. Miller" <davem@davemloft.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__21_Aug_2009_16_01_16_+1000_4IyZtuNPfRQ66+J.
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Grant,

On Thu, 20 Aug 2009 23:30:17 -0600 Grant Likely <grant.likely@secretlab.ca>=
 wrote:
>
> +/**
> + * get_int_prop - Decode a u32 from a device tree property
> + */
> +static u32 get_int_prop(struct device_node *np, const char *name, u32 de=
f)
> +{
> +	const u32 *prop;
> +	int len;
> +
> +	prop =3D of_get_property(np, name, &len);
> +	if (prop && len >=3D 4)
> +		return *prop;
> +	return def;
> +}

Maybe you could use sparc's of_getintprop_default() (after moving it into
drivers/of ...

> +
> +/**
> + * pci_parse_of_flags - Parse the flags cell of a device tree PCI address
> + * @addr0: value of 1st cell of a device tree PCI address.
> + * @bridge: Set this flag if the address is from a bridge 'ranges' prope=
rty
> + */
> +unsigned int pci_parse_of_flags(u32 addr0, int bridge)
> +{
> +	unsigned int flags =3D 0;
> +
> +	if (addr0 & 0x02000000) {
> +		flags =3D IORESOURCE_MEM | PCI_BASE_ADDRESS_SPACE_MEMORY;
> +		flags |=3D (addr0 >> 22) & PCI_BASE_ADDRESS_MEM_TYPE_64;
> +		flags |=3D (addr0 >> 28) & PCI_BASE_ADDRESS_MEM_TYPE_1M;
> +		if (addr0 & 0x40000000)
> +			flags |=3D IORESOURCE_PREFETCH
> +				 | PCI_BASE_ADDRESS_MEM_PREFETCH;
> +		/* Note: We don't know whether the ROM has been left enabled
> +		 * by the firmware or not. We mark it as disabled (ie, we do
> +		 * not set the IORESOURCE_ROM_ENABLE flag) for now rather than
> +		 * do a config space read, it will be force-enabled if needed
> +		 */
> +		if (!bridge && (addr0 & 0xff) =3D=3D 0x30)
> +			flags |=3D IORESOURCE_READONLY;
> +	} else if (addr0 & 0x01000000)
> +		flags =3D IORESOURCE_IO | PCI_BASE_ADDRESS_SPACE_IO;
> +	if (flags)
> +		flags |=3D IORESOURCE_SIZEALIGN;
> +	return flags;
> +}
> +
> +/**
> + * of_pci_parse_addrs - Parse PCI addresses assigned in the device tree =
node
> + * @node: device tree node for the PCI device
> + * @dev: pci_dev structure for the device
> + *
> + * This function parses the 'assigned-addresses' property of a PCI devic=
es'
> + * device tree node and writes them into the associated pci_dev structur=
e.
> + */
> +static void of_pci_parse_addrs(struct device_node *node, struct pci_dev =
*dev)
> +{
> +	u64 base, size;
> +	unsigned int flags;
> +	struct resource *res;
> +	const u32 *addrs;
> +	u32 i;
> +	int proplen;
> +
> +	addrs =3D of_get_property(node, "assigned-addresses", &proplen);
> +	if (!addrs)
> +		return;
> +	pr_debug("    parse addresses (%d bytes) @ %p\n", proplen, addrs);
> +	for (; proplen >=3D 20; proplen -=3D 20, addrs +=3D 5) {
> +		flags =3D pci_parse_of_flags(addrs[0], 0);
> +		if (!flags)
> +			continue;
> +		base =3D of_read_number(&addrs[1], 2);
> +		size =3D of_read_number(&addrs[3], 2);
> +		if (!size)
> +			continue;
> +		i =3D addrs[0] & 0xff;
> +		pr_debug("  base: %llx, size: %llx, i: %x\n",
> +			 (unsigned long long)base,
> +			 (unsigned long long)size, i);
> +
> +		if (PCI_BASE_ADDRESS_0 <=3D i && i <=3D PCI_BASE_ADDRESS_5) {
> +			res =3D &dev->resource[(i - PCI_BASE_ADDRESS_0) >> 2];
> +		} else if (i =3D=3D dev->rom_base_reg) {
> +			res =3D &dev->resource[PCI_ROM_RESOURCE];
> +			flags |=3D IORESOURCE_READONLY | IORESOURCE_CACHEABLE;
> +		} else {
> +			printk(KERN_ERR "PCI: bad cfg reg num 0x%x\n", i);
> +			continue;
> +		}
> +		res->start =3D base;
> +		res->end =3D base + size - 1;
> +		res->flags =3D flags;
> +		res->name =3D pci_name(dev);
> +	}
> +}

And similarly with sparc's pci_parse_of_addrs() and pci_parse_of_flags
() ?  Maybe create drivers/of/pci.c (or drivers/pci/of.c)?  Or maybe they
are still too different?

There is probably scope for more consolidation there.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__21_Aug_2009_16_01_16_+1000_4IyZtuNPfRQ66+J.
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqOOCwACgkQjjKRsyhoI8y8sACfZplByOOfPyK0gcoYZ8yOIm1b
1loAnirmT5Lo266ZhTki2IU8z5wUlM+3
=GpP2
-----END PGP SIGNATURE-----

--Signature=_Fri__21_Aug_2009_16_01_16_+1000_4IyZtuNPfRQ66+J.--
