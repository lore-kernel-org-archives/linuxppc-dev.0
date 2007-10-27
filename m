Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 11B7DDDE3E
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Oct 2007 13:37:45 +1000 (EST)
Date: Sat, 27 Oct 2007 13:37:34 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH 1/2] PowerPC: Add 44x NDFC device-tree aware support
Message-Id: <20071027133734.82d38ab1.sfr@canb.auug.org.au>
In-Reply-To: <20071026163958.GA11784@ru.mvista.com>
References: <20071026163058.GA11354@ru.mvista.com>
	<20071026163958.GA11784@ru.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__27_Oct_2007_13_37_34_+1000_/UbibhD/Wuuzso7/"
Cc: linuxppc-dev@ozlabs.org, tglx@linutronix.de, sr@denx.de,
	linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sat__27_Oct_2007_13_37_34_+1000_/UbibhD/Wuuzso7/
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Oct 2007 20:39:58 +0400 Valentine Barshak <vbarshak@ru.mvista.co=
m> wrote:
>
> +static int __devinit parse_partitions(struct of_ndfc *ndfc,
> +				      struct of_device *dev)
> +{
> +	const char *partname;
> +	static const char *part_probe_types[]
> +		=3D { "cmdlinepart", "RedBoot", NULL };
> +	struct device_node *dp =3D dev->node, *pp;
> +	int nr_parts, i;
> +
> +	/* First look for RedBoot table or partitions on the command
> +	 * line, these take precedence over device tree information */
> +	nr_parts =3D parse_mtd_partitions(&ndfc->mtd, part_probe_types,
> +					&ndfc->parts, 0);
> +	if (nr_parts > 0) {
> +		add_mtd_partitions(&ndfc->mtd, ndfc->parts, nr_parts);
> +		return 0;
> +	}
> +
> +	/* First count the subnodes */
> +	nr_parts =3D 0;
> +	for (pp =3D dp->child; pp; pp =3D pp->sibling)

For proper ref counting and locking, use:

	for (pp =3D of_get_next_child(dp, NULL); pp;
	     pp =3D of_get_next_child(dp, pp))

> +		nr_parts++;
> +
> +	if (nr_parts =3D=3D 0)
> +		return 0;
> +
> +	ndfc->parts =3D kzalloc(nr_parts * sizeof(*ndfc->parts),
> +			      GFP_KERNEL);
> +	if (!ndfc->parts)
> +		return -ENOMEM;
> +
> +	for (pp =3D dp->child, i =3D 0; pp; pp =3D pp->sibling, i++) {

	for (pp =3D of_get_next_child(dp, NULL), i =3D 0; pp;
	     pp =3D of_get_next_child(dp, pp), i++)

> +		const u32 *reg;
> +		int len;
> +
> +		reg =3D of_get_property(pp, "reg", &len);
> +		if (!reg || (len !=3D 2*sizeof(u32))) {

			of_node_put(pp);

> +			dev_err(&dev->dev, "Invalid 'reg' on %s\n",
> +				dp->full_name);
> +			kfree(ndfc->parts);
> +			ndfc->parts =3D NULL;
> +			return -EINVAL;
> +		}
> +		ndfc->parts[i].offset =3D reg[0];
> +		ndfc->parts[i].size =3D reg[1];
> +
> +		partname =3D of_get_property(pp, "label", &len);
> +		if (!partname)
> +			partname =3D of_get_property(pp, "name", &len);
> +		ndfc->parts[i].name =3D (char *)partname;
> +
> +		if (of_get_property(pp, "read-only", &len))
> +			ndfc->parts[i].mask_flags =3D MTD_WRITEABLE;
> +	}
> +
> +	return nr_parts;
> +}
> +#else /* MTD_PARTITIONS */
> +#define	OF_FLASH_PARTS(ndfc)		(0)
> +#define parse_partitions(ndfc, dev)	(0)

static inline int parse_partitions(struct of_ndfc *ndfc, struct of_device *=
dev)
{
	return 0;
}

> +#endif /* MTD_PARTITIONS */

> +static int __devinit of_ndfc_probe(struct of_device *dev,
> +				    const struct of_device_id *match)
> +{
> +	struct device_node *dp =3D dev->node;
> +	struct resource res;
> +	struct of_ndfc *ndfc;
> +	const u32 *prop;
> +	resource_size_t rlen;
> +	int err;
> +
> +	err =3D -ENXIO;
> +	if (of_address_to_resource(dp, 0, &res)) {
> +		dev_err(&dev->dev, "can't get IO address from device tree\n");
> +		goto err_out;
> +	}
> +
> +       	dev_dbg(&dev->dev, "regs: %.8llx-%.8llx\n",

indentation ?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__27_Oct_2007_13_37_34_+1000_/UbibhD/Wuuzso7/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHIrKDTgG2atn1QN8RAiWeAJ4pfodc0hw9qx+HIDP85zTQlV6ZCACdFYDV
gI1ymjtII58eNMEVPcyNjQ8=
=J6vf
-----END PGP SIGNATURE-----

--Signature=_Sat__27_Oct_2007_13_37_34_+1000_/UbibhD/Wuuzso7/--
