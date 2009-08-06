Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7225BB6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Aug 2009 23:40:48 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 62486DDD0C
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2009 23:40:48 +1000 (EST)
Subject: Re: 2.6.31-rc5-git2 crash on a idle system.
From: Michael Ellerman <michael@ellerman.id.au>
To: Sachin Sant <sachinp@in.ibm.com>
In-Reply-To: <4A7ADBB1.3050906@in.ibm.com>
References: <4A78292A.5000607@in.ibm.com>
	<1249421223.18245.36.camel@pasglop> <4A794E26.8080207@in.ibm.com>
	<1249465934.18245.54.camel@pasglop>  <4A7ADBB1.3050906@in.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-sY2mzGgcVxmEYJHgLlQX"
Date: Thu, 06 Aug 2009 23:40:46 +1000
Message-Id: <1249566046.4800.178.camel@concordia>
Mime-Version: 1.0
Cc: neilb@suse.de, linux-raid@vger.kernel.org, linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-sY2mzGgcVxmEYJHgLlQX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2009-08-06 at 19:03 +0530, Sachin Sant wrote:
> Benjamin Herrenschmidt wrote:
> > Thanks. Since it's a memory corruption (or seems to be) however, it's
> > possible that the bisection will mislead you. IE. The culprit could be
> > somewhere else, and the commit you'll find via bisection just happens t=
o
> > move things around in the kernel in such a way that the corruption hits
> > that code path instead of another rarely used one.
> >
> > I would suggest using printk to print out the content of memory where
> > the code appears to have been smashed at different stages during boot
> > (maybe even in the initcalls loop in init/main.c) to try to point out
> > what appears to be causing the corruption.
> >  =20
> By the time machine is up and running the particular memory location
> in question is already overwritten. So seems like the corruption occurs
> during the boot.
>=20
> I added few printks in the initcall debug code patch. The o/p suggests
> that by the time first initicall debug message is printed the code is
> already corrupted. Further debug suggests, when start_kernel() is
> called the code at address(0xc000000000600000) is already corrupted.
> About 28 bytes of code starting from the above address is overwritten.=20
>=20
> I will try to add few more debug statements to find the place where
> this corruption might me happening.

Is it always the exact same pattern at the exact same address? Or does
it change and if so how?

cheers

--=-sY2mzGgcVxmEYJHgLlQX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkp63V4ACgkQdSjSd0sB4dJ6bwCfVZDxUvTSHvekSmtpoYSE8KOf
I3cAoJYboxAdcfglEqfJPSyjxWPSg2/W
=5F/U
-----END PGP SIGNATURE-----

--=-sY2mzGgcVxmEYJHgLlQX--
