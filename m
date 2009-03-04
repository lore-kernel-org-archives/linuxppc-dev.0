Return-Path: <michael@ellerman.id.au>
Subject: RE: mpc8349e-mitx 2.6.25 serial IRQ assigned wrong
From: Michael Ellerman <michael@ellerman.id.au>
To: onramp123@yahoo.com
In-Reply-To: <025a01c99c8b$90afb030$6b03a8c0@sdelaney2>
References: <025a01c99c8b$90afb030$6b03a8c0@sdelaney2>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-CupVurozoqetgYjd+l/p"
Date: Thu, 05 Mar 2009 00:00:20 +1100
Message-Id: <1236171620.8267.20.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-CupVurozoqetgYjd+l/p
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-03-03 at 21:39 -0800, Steve DeLaney wrote:
>=20
> Here's an update on this issue. =20
>=20
> After verifying the device tree was OK, the OF traces led us to the root
> cause.
>=20
> powerpc irq.c irq_alloc_virt() assigns a virtual IRQ as a function of the
> input hardware IRQ hint, AND NUM_ISA_INTERRUPTS.  it turns out that
> asm-ppc/irq.h defines NUM_ISA_INTERRUPTS 16, so that the allocated virq
> is offset by this amount.  this accounts for the remap shown below for=20
> i2c and serial device vectors.
>=20
> I didn't realize before that /proc/interrupts=20
> serviced by irq.c show_interrupts() displays virtual vector numbers.
>=20
> For the mpc8349e-mitx this must be incorrect since there is no ISA?
> Essentially all that is needed is a 1:1 mapping hirq:virq since
> each interrupt source in the system appears to have a unique vector
> in the SOC IPIC.  It seems this scheme is needlessly complex, at least fo=
r
> mpc8349e.
>=20
> For now we simply define irq.h NUM_ISA_INTERRUPTS 0
> but this isn't a complete solution since our PCI device
> interrupt on hirq 20, ends up allocated on virq 1.  To force
> this to work, the driver does an irq_create_mapping(NULL, 20),
> then assigns its own dev->irq=3D20 before calling request_irq()
>=20
> I'm sure someone has a more elegant solution but that's what
> we've been able to come up with so far.

I'm not clear on what the problem is.

The interrupt numbers in /proc/interrupts will no longer match what the
old kernel had, because as you mention the values in /proc/interrupts
are virtual irqs.

If you want to see the mapping turn on CONFIG_VIRQ_DEBUG and you'll get
a file in debugfs called virq_mapping that shows the details.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-CupVurozoqetgYjd+l/p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmue2QACgkQdSjSd0sB4dKjiACgwDk39/WvX521LAdDHacZI9sN
16sAniy3yTYfZNnqncGi+dQf5lbb2K2S
=pS5t
-----END PGP SIGNATURE-----

--=-CupVurozoqetgYjd+l/p--
