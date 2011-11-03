Return-Path: <michael@ellerman.id.au>
Subject: Re: Support for multiple MSI interrupts on MPC8377
From: Michael Ellerman <michael@ellerman.id.au>
To: "Giffel, Brad" <Brad.Giffel@hbm.com>
In-Reply-To: <FBC631D6B23BAB40AF19415483130F7A6FD458@HBMURBX.hbm.com>
References: <FBC631D6B23BAB40AF19415483130F7A6FD458@HBMURBX.hbm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature"; boundary="=-8w4R55E5WU9nqr0txk7/"
Date: Thu, 03 Nov 2011 14:51:22 +1100
Message-ID: <1320292282.3852.33.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Matthew Wilcox <matthew@wil.cx>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-8w4R55E5WU9nqr0txk7/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2011-11-02 at 16:02 -0500, Giffel, Brad wrote:
> I=E2=80=99m working a project using a Spartan 6 FPGA with a PCIe interfac=
e and
> MSI interrupts.  I want to use multiple MSI interrupts (MSI-X is not
> supported in the FPGA PCIe core) but the current Linux distribution
> (3.0.8) prevents that (lines 23 to 25 in arch/powerpc/kernel/msi.c).
>=20
> =20
>=20
> What=E2=80=99s the story here?  Is the code in place but not tested?  I t=
ried
> commenting out those lines but a request_irq() called failed for the
> second interrupt requested.  Am I wasting my time here?  Should I
> re-architect to use a single MSI interrupt?

The short and easy answer is you should use a single MSI interrupt.

There is some code in place to support multiple MSI, but only in the
generic code (drivers/pci/msi.c), and I'm not sure if it's complete.
There is no arch support, for any arch AFAIK, and certainly not for
powerpc.

cheers



--=-8w4R55E5WU9nqr0txk7/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk6yD7UACgkQdSjSd0sB4dL8+gCdHLvSMHKNbm9LyFohIMLH6Vw2
IhMAoJIz7hIinsiXvAEWHUBifdge5i5I
=U3Kh
-----END PGP SIGNATURE-----

--=-8w4R55E5WU9nqr0txk7/--
