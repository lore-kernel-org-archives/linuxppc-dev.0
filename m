Return-Path: <michael@ellerman.id.au>
Subject: Re: MSI-X vector allocation failure in upstream kernel
From: Michael Ellerman <michael@ellerman.id.au>
To: Anirban Chakraborty <anirban.chakraborty@qlogic.com>
In-Reply-To: <9101728E-3FFC-457E-AF5B-87B2037FEC32@qlogic.com>
References: <9101728E-3FFC-457E-AF5B-87B2037FEC32@qlogic.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-muU6eKtjqtQN/RpZDLdh"
Date: Wed, 13 Oct 2010 12:51:28 +1100
Message-ID: <1286934688.24583.12.camel@concordia>
Mime-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Ameen Rahman <ameen.rahman@qlogic.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-muU6eKtjqtQN/RpZDLdh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2010-10-05 at 10:18 -0700, Anirban Chakraborty wrote:
> Hi All,
>=20
> I am trying to test qlcnic driver (for 10Gb QLogic network adapter) on a =
Power 6 system=20
> (IBM P 520, System type 8203) with upstream kernel and I do see that the =
kernel is=20
> not able to allocate any MSI-X vectors. The driver requests for 4 vectors=
 in pci_enable_msix,
> which returns 2.

OK, that's the platform code saying it can only support 2, that seems
low, but it's possible.

>  The driver again attempts, this time for 2 vectors but the kernel can't =
allocate=20
> and it returns a value of 0xfffffffd.=20

OK, that's odd. That is -3, which AFAICS we don't return from the linux
code. So it must be coming from firmware? In which case it would be
"parameter error".

> I upgraded the system FW to 01EL350 (from 01EL340) just to make sure
> if MSI-X is enabled in the system.

Is that the latest FW version?

Adding #define DEBUG at the top of arch/powerpc/platforms/pseries/msi.c
will give us lots of useful info.

Or you can enable CONFIG_DYNAMIC_DEBUG, and enable it that way.

cheers

--=-muU6eKtjqtQN/RpZDLdh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAky1EKAACgkQdSjSd0sB4dJujQCeItpvro8XGkikJAbMtxsvRUOZ
EKUAnRDnmsqf3o+LqyInvJXjsyFbNs6x
=C806
-----END PGP SIGNATURE-----

--=-muU6eKtjqtQN/RpZDLdh--
