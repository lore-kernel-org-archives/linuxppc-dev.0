Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 0C0B5DDE33
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 09:31:55 +1100 (EST)
Date: Tue, 15 Jan 2008 09:31:49 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [DTC PATCH] libfdt: Add ft_get_next_node(), ft_get_next_prop(),
	and ft_getprop_offset().
Message-Id: <20080115093149.39a1d703.sfr@canb.auug.org.au>
In-Reply-To: <20080114163004.GA27880@ld0162-tx32.am.freescale.net>
References: <20080114163004.GA27880@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__15_Jan_2008_09_31_49_+1100_qLqx7KCGgg9qL0hW"
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__15_Jan_2008_09_31_49_+1100_qLqx7KCGgg9qL0hW
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Scott,

On Mon, 14 Jan 2008 10:30:04 -0600 Scott Wood <scottwood@freescale.com> wro=
te:
>
> ft_get_next_node() enumerates children of a given node.
> ft_get_next_prop() enumerates propreties of a given node.
                                ^^^^^^^^^^
typo.

> ft_getprop_offset() is like ft_getprop(), but takes a property offset rat=
her
> than a node offset and property name; it is primarily intended for use
> with ft_get_next_prop().

All the "ft_" above should be "fdt_".

> +const void *fdt_getprop_offset(const void *fdt, int propoffset,
> +                               const char **name, int *lenp)
> +{

> +	tag =3D fdt_next_tag(fdt,propoffset, NULL);
                              ^
space after ','

> +++ b/libfdt/libfdt.h

> +#define FDT_ERR_BADDEPTH	8

Wouldn't it have been less intrusive to just use the next error number
rather than inserting this here?

> + * fdt_getprop_offset - retrieve the value of a given property by offset
> + * @fdt: pointer to the device tree blob
> + * @propoffset: offset of the property to read
> + * @name: pointer to a character pointer (will be overwritten) or NULL
                          ^^^^^^^^^^^^^^^^^
"string"?

> + * @lenp: pointer to an integer variable (will be overwritten) or NULL
> + *
> + * fdt_getprop() retrieves a pointer to the value of the property

fdt_getprop_offset

> + * named 'name' of the node at offset nodeoffset (this will be a
> + * pointer to within the device blob itself, not a copy of the value).
> + * If lenp is non-NULL, the length of the property value also
> + * returned, in the integer pointed to by lenp.
> + *
> + * returns:
> + *	pointer to the property's value

		if name is non-NULL, *name points to ...

> + *		if lenp is non-NULL, *lenp contains the length of the property
> + *		value (>=3D0)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__15_Jan_2008_09_31_49_+1100_qLqx7KCGgg9qL0hW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHi+LYTgG2atn1QN8RArCfAJsGZZts7i5uHqHlDamY4+VCoyJeCgCggAFY
2RKMVAZCfkriXoOzVJ/fV5A=
=YiTu
-----END PGP SIGNATURE-----

--Signature=_Tue__15_Jan_2008_09_31_49_+1100_qLqx7KCGgg9qL0hW--
