Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: EOI spurious irqs during boot so they can be
	reenabled later
From: Michael Ellerman <michael@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <02B3273A-55F2-42A3-AB17-8B90FCE27961@kernel.crashing.org>
References: <3d6dc055c5b18a641a5467b7331d935ede87efb2.1217943634.git.michael@ellerman.id.au>
	<02B3273A-55F2-42A3-AB17-8B90FCE27961@kernel.crashing.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-drgh+T7HoHv+SdpTCvNS"
Date: Wed, 06 Aug 2008 11:58:47 +1000
Message-Id: <1217987927.7893.2.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Milton Miller <miltonm@bga.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-drgh+T7HoHv+SdpTCvNS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-08-05 at 18:48 +0200, Segher Boessenkool wrote:
> > So when we receive a spurious irq, EOI it, and then mask it.
>=20
> What happens when a new IRQ arrives on the interrupt controller
> between these EOI and mask calls?  Should you instead first mask
> it, and only then EOI it?  Or doesn't that work on XICS?

Yeah right, in which case we'd have not EOI'ed that one and we're back
at square one.

It seems to work with a mask then EOI, so unless Milton says otherwise
I'll do it that way - new patch coming.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-drgh+T7HoHv+SdpTCvNS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBImQVXdSjSd0sB4dIRArEhAKCFKwVFGiti5+2dXkzf4Zo2rhzaXwCfU0g3
LKpG/5DVdGo2N3Al5I7qU/4=
=UsYB
-----END PGP SIGNATURE-----

--=-drgh+T7HoHv+SdpTCvNS--
