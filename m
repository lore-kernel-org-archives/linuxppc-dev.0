Return-Path: <michael@ellerman.id.au>
Subject: Re: bug in lmb_enforce_memory_limit()
From: Michael Ellerman <michael@ellerman.id.au>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20080815.152501.193746275.davem@davemloft.net>
References: <20080814.012004.193702132.davem@davemloft.net>
	<1218713213.10673.17.camel@localhost>
	<20080815.152501.193746275.davem@davemloft.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-fWZA5eCQnmrP3Pu1T7CM"
Date: Sat, 16 Aug 2008 10:46:22 +1000
Message-Id: <1218847582.7576.6.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-fWZA5eCQnmrP3Pu1T7CM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2008-08-15 at 15:25 -0700, David Miller wrote:
> From: Michael Ellerman <michael@ellerman.id.au>
> Date: Thu, 14 Aug 2008 21:26:53 +1000
>=20
> > Perhaps after the first loop we should set memory_limit to equal
> > lmb_end_of_DRAM(), then the second loop should work as it is.
>=20
> Sounds great.  Mind if I push the following to Linus?

Looks good to me.

I'll test it on Monday. I don't know if I have a system with memory
holes to test on, but I take it you do?

I notice some of our 32-bit code is using lmb_enforce_memory_limit() to
enforce an address limit, which is technically broken, but is probably
fine because it doesn't need to worry about holes.


> lmb: Fix reserved region handling in lmb_enforce_memory_limit().
>=20
> The idea of the implementation of this fix is from Michael Ellerman.
>=20
> This function has two loops, but they each interpret the memory_limit
> value differently.  The first loop interprets it as a "size limit"
> whereas the second loop interprets it as an "address limit".
>=20
> Before the second loop runs, reset memory_limit to lmb_end_of_DRAM()
> so that it all works out.
>=20
> Signed-off-by: David S. Miller <davem@davemloft.net>

Acked-by: Michael Ellerman <michael@ellerman.id.au>

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-fWZA5eCQnmrP3Pu1T7CM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIpiNedSjSd0sB4dIRAh5nAJ498G1SxPqR8zEZCEg7hhQBuqXdTgCeLJkx
nHwqw4inx1mD5dsRa0ECVDQ=
=qc5G
-----END PGP SIGNATURE-----

--=-fWZA5eCQnmrP3Pu1T7CM--
