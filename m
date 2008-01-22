Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 0266BDDD0C
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 10:51:17 +1100 (EST)
Date: Wed, 23 Jan 2008 10:51:11 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH 2/3 v3] Add initial iomega StorCenter board port.
Message-Id: <20080123105111.125f075d.sfr@canb.auug.org.au>
In-Reply-To: <E1JHRkl-0005e5-RX@jdl.com>
References: <E1JHRkl-0005e5-RX@jdl.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__23_Jan_2008_10_51_11_+1100_vSYcB7aOiI6_=eS3"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__23_Jan_2008_10_51_11_+1100_vSYcB7aOiI6_=eS3
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jon,

On Tue, 22 Jan 2008 16:37:59 -0600 Jon Loeliger <jdl@jdl.com> wrote:
>
> +++ b/arch/powerpc/platforms/embedded6xx/storcenter.c

> +extern void _nmask_and_or_msr(unsigned long nmask, unsigned long or_val);

This clearly needs to be decalred in some header file.  (I know you did
not introduce it.)  In arch/ppc, it was declared in asm/system.h (but I
don't know if that is appropriate for arch/powerpc).  Maybe you could do
a preceeding patch that does this and fixes the other user.

> +static void __init storcenter_init_IRQ(void)
> +{
> +	struct mpic *mpic;
> +	struct device_node *dnp;
> +	const void *prop;
> +	int size;
> +	phys_addr_t paddr;
> +
> +	dnp =3D of_find_node_by_type(NULL, "open-pic");
> +	if (dnp =3D=3D NULL)
> +		return;
> +
> +	prop =3D of_get_property(dnp, "reg", &size);
> +	paddr =3D (phys_addr_t)of_translate_address(dnp, prop);

What happens of "prop" is NULL?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__23_Jan_2008_10_51_11_+1100_vSYcB7aOiI6_=eS3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHloFzTgG2atn1QN8RAp49AJ9NScaZsdCSCEj7hsV/vHKxFK8kxACeOL76
esghekdHbjdqIUpyTXJil34=
=sqYy
-----END PGP SIGNATURE-----

--Signature=_Wed__23_Jan_2008_10_51_11_+1100_vSYcB7aOiI6_=eS3--
