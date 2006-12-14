Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 6/9] MPIC MSI allocator
From: Michael Ellerman <michael@ellerman.id.au>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20061213122353.7498a25e@pb15>
References: <1166006370.90082.476088563252.qpush@cradle>
	<20061213104007.4B8F967DA9@ozlabs.org> <20061213122353.7498a25e@pb15>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-xBOQ2jROdVty4JF48zzM"
Date: Thu, 14 Dec 2006 11:34:51 +1100
Message-Id: <1166056491.6838.13.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
	Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-xBOQ2jROdVty4JF48zzM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-12-13 at 12:23 -0600, Olof Johansson wrote:
> On Wed, 13 Dec 2006 21:40:03 +1100 Michael Ellerman <michael@ellerman.id.=
au> wrote:
>=20
> > To support MSI on MPIC we need a way to reserve and allocate hardware i=
rq
> > numbers, this patch implements an allocator for that. It looks like we'=
ll
> > end up with several backends based on the MPIC, so the allocator is att=
ached
> > to the struct mpic, not the msi backend.
> >=20
> > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
>=20
> > +static void mpic_msi_auto_reserve_hwirqs(struct mpic *mpic)
> > +{
> > +	irq_hw_number_t hwirq;
> > +	struct irq_host_ops *ops =3D mpic->irqhost->ops;
> > +	struct device_node *np;
> > +	int flags, index, i;
> > +	struct of_irq oirq;
> > +
> > +	/* Reserve source numbers we know are reserved in the HW */
>=20
> How do we know? Reserved on what HW? Sure looks system/platform
> dependent to me.

I agree. It's a fall-back position, we first check for the
"msi-available" property, and if that's not there we try to guess. New
firmwares should define "msi-available", but we don't want to wait for
that to happen, if it really bothers you we could have a
CONFIG_MPIC_MSI_DODGY_ALLOCATOR_GUESSING_ENABLE :)

So 0-7, 42-45 and 100-104 are known to be reserved on various revisions
of MPIC (and if there's more we can add them), and then we go through
the whole device tree and reserve anything that's already got an irq
mapped.

>=20
> > +	for (i =3D 0;   i < 8;   i++)
> > +		__mpic_msi_reserve_hwirq(mpic, i);
> > +	for (i =3D 42;  i < 26;  i++)
>              ^^^^^^^^^^^^^^^
>=20
> Is this some sort of check to see if we're awake? :)

Hehe. No it's proof that I wasn't awake when I wrote it, that's late
night hacking for you :)

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-xBOQ2jROdVty4JF48zzM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFgJwrdSjSd0sB4dIRAruWAJ0aoo8p3xGpY1szuv0u57ozRNEPAgCgk2q8
rcCJbsB4jGbr2PBgAcBqS+M=
=aonn
-----END PGP SIGNATURE-----

--=-xBOQ2jROdVty4JF48zzM--
