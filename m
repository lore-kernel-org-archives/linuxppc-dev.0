Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 2/5] powerpc: ftrace, convert to new dynamic ftrace
	arch API
From: Michael Ellerman <michael@ellerman.id.au>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18730.1723.708467.812600@drongo.ozlabs.ibm.com>
References: <20081120190948.057007623@goodmis.org>
	<20081120191149.285359258@goodmis.org>
	<18730.1723.708467.812600@drongo.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-r+25O08s0JUtGpkIm/4s"
Date: Mon, 24 Nov 2008 13:49:36 +1100
Message-Id: <1227494976.21735.1.camel@localhost>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>,
	linuxppc-dev@ozlabs.org, Steven Rostedt <srostedt@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-r+25O08s0JUtGpkIm/4s
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-11-24 at 12:43 +1100, Paul Mackerras wrote:
> Steven Rostedt writes:
>=20
> > Thanks to Paul Mackennas for pointing out the mistakes of my original
>=20
> Mackerras
>=20
> > +static int test_24bit_addr(unsigned long ip, unsigned long addr)
> > +{
> > +	long diff;
> > +
> > +	/*
> > +	 * Can we get to addr from ip in 24 bits?
> > +	 *  (26 really, since we mulitply by 4 for 4 byte alignment)
> > +	 */
> > +	diff =3D addr - ip;
> > +
> > +	/*
> > +	 * Return true if diff is less than 1 << 25
> > +	 *  and greater than -1 << 26.
> > +	 */
> > +	return (diff < (1 << 25)) && (diff > (-1 << 26));
>=20
> I think this still isn't right, and the comment is one of those ones
> that is only useful to people who can't read C, as it's just a
> transliteration of the code.
>=20
> The comment should say something like "Return true if diff can be
> represented as a 26-bit twos-complement binary number" and the second
> part of the test should be (diff >=3D (-1 << 25)).  However, since you
> define a test_offset() function in patch 4/5 that does the same test
> but using only one comparison instead of two, why don't you just say:
>=20
> 	return !test_offset(diff);
>=20
> (having first moved test_offset() before test_24bit_addr)?

Or better still, split out and use the code from create_branch() in
arch/powerpc/lib/code-patching.c .. which is hopefully correct :)

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-r+25O08s0JUtGpkIm/4s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkqFkAACgkQdSjSd0sB4dKp0ACfWuPTFB51BJJR/p+Sfz5khn92
rc0An253nCU9GwUYDlRvNFR7E7gu9Mpr
=cHhd
-----END PGP SIGNATURE-----

--=-r+25O08s0JUtGpkIm/4s--
