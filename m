Return-Path: <michael@ellerman.id.au>
Subject: Re: Problem with MPC8536 and external IRQs when using a loadable
	kernel module
From: Michael Ellerman <michael@ellerman.id.au>
To: Mark Pearson <Mark.Pearson@bladenetwork.net>
In-Reply-To: <11BA25866A2E3A45A797B469B2344B3901554D3D@blademail.bladenetwork.net>
References: <11BA25866A2E3A45A797B469B2344B3901554D3D@blademail.bladenetwork.net>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-FUyyQdoLWuNh6NSMbvOq"
Date: Fri, 10 Dec 2010 10:33:14 +1100
Message-ID: <1291937594.3523.20.camel@concordia>
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


--=-FUyyQdoLWuNh6NSMbvOq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-12-09 at 12:45 -0800, Mark Pearson wrote:
> I have a curious problem. This is on a MPC8636 based platform with
> 36-bit address space (that may or may not be important).
>=20
> =20
>=20
> I have a very simple driver that registers for one of the external
> IRQs with a trivial interrupt handler. It works great when built in as
> part of the kernel.
>=20
> =20
>=20
> However, if I make it a loadable module I get the crash shown below
> (blade_irq is my IRQ handler).
>=20
> =20
>=20
> -----Console capture ----------------------------------------
>=20
> Unable to handle kernel paging request for instruction fetch
                                            ^^^^^^^^^^^^^^^^^

Your interrupt handler isn't mapped executable? Something wrong with
module loading?

Do you need 78e2e68a2b79f394b7cd61e07987a8a89af907f7 ?

cheers



--=-FUyyQdoLWuNh6NSMbvOq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk0BZzgACgkQdSjSd0sB4dLUKQCgqP//cIvEiVLPO8OZ1GlR0/gQ
VmwAn0p4EN5Q1uxQkeKZLeEYko4+w810
=kbzj
-----END PGP SIGNATURE-----

--=-FUyyQdoLWuNh6NSMbvOq--
