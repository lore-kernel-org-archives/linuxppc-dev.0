Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 3/3] powerpc: kdump: Use chip->shutdown to disable IRQs
From: Michael Ellerman <michael@ellerman.id.au>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20100511022738.GG12203@kryten>
References: <20100511022329.GE12203@kryten> <20100511022551.GF12203@kryten>
	<20100511022738.GG12203@kryten>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-IWkyQI3eCc+DcjCndUzl"
Date: Tue, 11 May 2010 14:11:15 +1000
Message-ID: <1273551075.9209.133.camel@concordia>
Mime-Version: 1.0
Cc: mikey@neuling.org, paulus@samba.org, miltonm@bga.com,
	linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-IWkyQI3eCc+DcjCndUzl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2010-05-11 at 12:27 +1000, Anton Blanchard wrote:
> I saw this in a kdump kernel:
>=20
> IOMMU table initialized, virtual merging enabled
> Interrupt 155954 (real) is invalid, disabling it.
> Interrupt 155953 (real) is invalid, disabling it.
>=20
> ie we took some spurious interrupts.=20

OK, but it should have still worked OK?

> default_machine_crash_shutdown tries
> to disable all interrupt sources but uses chip->disable which maps to
> the default action of:
>=20
> static void default_disable(unsigned int irq)
> {
> }
>=20
> If we use chip->shutdown, then we actually mask the IRQ:
>=20
> static void default_shutdown(unsigned int irq)
> {
>         struct irq_desc *desc =3D irq_to_desc(irq);
>=20
>         desc->chip->mask(irq);
>         desc->status |=3D IRQ_MASKED;
> }
>=20
> Not sure why we don't implement a ->disable action for xics.c, or why
> default_disable doesn't mask the interrupt.

It used to mask, see 76d21601, I knew that would bite us somewhere.

Not 100% sure about the change to use shutdown, but it's probably sane
and you've tested it so cool :)

cheers



--=-IWkyQI3eCc+DcjCndUzl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkvo2OMACgkQdSjSd0sB4dIgWACfan1pHGpaSTO/nVoFQKJmYWcN
gk4AnAtRtlqXGjiEwULEa6YD7aLcVkOl
=Jb89
-----END PGP SIGNATURE-----

--=-IWkyQI3eCc+DcjCndUzl--
