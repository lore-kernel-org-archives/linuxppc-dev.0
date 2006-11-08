Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: force 4k update_flash block and list sizes
From: Michael Ellerman <michael@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200611081028.32038.arnd@arndb.de>
References: <1162943615.13499.15.camel@sinatra.austin.ibm.com>
	<1162960202.14254.3.camel@sinatra.austin.ibm.com>
	<1162960860.20271.13.camel@localhost.localdomain>
	<200611081028.32038.arnd@arndb.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-8wwkFdMTVdG+Ou4jVLu/"
Date: Thu, 09 Nov 2006 09:40:18 +1100
Message-Id: <1163025618.7630.2.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Michael Neuling <mikey@neuling.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-8wwkFdMTVdG+Ou4jVLu/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-11-08 at 10:28 +0100, Arnd Bergmann wrote:
> On Wednesday 08 November 2006 05:41, Michael Ellerman wrote:
> > Just being picky .. but why did you decide to use the slab cache? Does
> > it make the code neater? I would have thought you could guarantee 4k
> > alignment some other way, and it seems slightly odd to use the slab
> > cache for something you only do once ..
>=20
> There are not so many allocators available. kmalloc does not guarantee
> alignment beyond a few bytes and the buddy allocator and vmalloc don't
> give you allocations smaller than PAGE_SIZE.

Yeah, I assumed kmalloc aligned on the size of the allocation, but it
doesn't looking at the code. We could set ARCH_KMALLOC_MINALIGN to 4k,
but that aligns all caches which is probably not what we want.

> The ehca people had the same problem, and I could imagine there are
> others with similar issues. How about adding a special slab allocator
> architecture-wide that gives out aligned 4k chunks independent of
> page size?

Yeah that sounds like a plan, I'm sure there's other code around that
could use it.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-8wwkFdMTVdG+Ou4jVLu/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFUlzRdSjSd0sB4dIRAgkWAJ9kKMJIauCJQ7TXnWCnyIN5PDa+YgCffZcO
bPsnVdNZlK1Y+k4HAOg5oKg=
=6UZa
-----END PGP SIGNATURE-----

--=-8wwkFdMTVdG+Ou4jVLu/--
