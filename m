Return-Path: <michael@ellerman.id.au>
Subject: Re: msi_bitmap.c question
From: Michael Ellerman <michael@ellerman.id.au>
To: Tirumala Marri <tmarri@apm.com>
In-Reply-To: <6cfa2d1c7ecd946ea4acbd3077defa92@mail.gmail.com>
References: <6cfa2d1c7ecd946ea4acbd3077defa92@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-uwrjMoXkKpZurUXL/rk6"
Date: Fri, 15 Oct 2010 11:25:54 +1100
Message-ID: <1287102354.4194.15.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-uwrjMoXkKpZurUXL/rk6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-10-14 at 15:56 -0700, Tirumala Marri wrote:
> Hi,
>=20
> I am trying to resubmit a patch for MSI support for ppc4xx devices.
> One of the review feedback was not to use the bit map as it is only
> for the devices which don=E2=80=99t have hard wired mapping between inter=
rupt
> controller interrupts and MSI number. For example intr-ctrl0 interrupt
> 20 goes to MSI-0, interrupt 21 goes to MSI-1 ..etc. But when I checked
> freescale SoCs and cell SoCs they have interrupts hard wired to MSI
> interrupts. =20
>=20
> =20
>=20
> Why do they have to use the bitmap and create irqhost, even though
> they are one-to-one mapped between interrupt controller numbers and
> MSI ?

I'm not quite sure I understand your question.

The MSI bitmap and the irq_host are two different things.

The MSI bitmap is basically an allocator for hardware numbers that can
be used for MSI. On some interrupt controllers that might be any
interrupt that's not used, on others there are restrictions on which
numbers can be used for MSI, it depends. So it's possible you don't need
to use that code, but I don't know how your hardware works.

The irq_host is the struct that controls mapping hardware irq numbers
into linux irq numbers. The cell MSI code has no restrictions on what
the MSI value is, so it just uses the Linux irq number directly using
irq_create_direct_mapping().

cheers




--=-uwrjMoXkKpZurUXL/rk6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAky3n48ACgkQdSjSd0sB4dL4kACgmcA0oIA6ESSGnyFVOUX7d5Qb
VvsAnjuNlKMmKE390qsXo26VTbgVi3eZ
=U6rO
-----END PGP SIGNATURE-----

--=-uwrjMoXkKpZurUXL/rk6--
