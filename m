Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DBAD7DDF04
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Apr 2009 16:48:04 +1000 (EST)
Subject: Re: [PATCH] Quieten arch/powerpc in a allmodconfig build.
From: Michael Ellerman <michael@ellerman.id.au>
To: Tony Breeds <tony@bakeyournoodle.com>
In-Reply-To: <20090408055126.GG16602@bilbo.ozlabs.org>
References: <2c4bcf8d1d7083ff53ce5b556765e96676a007fb.1239165378.git.tony@bakeyournoodle.com>
	<1239167335.10104.26.camel@localhost>
	<20090408055126.GG16602@bilbo.ozlabs.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-XuiZUEUluVpA+yR8Vu3/"
Date: Wed, 08 Apr 2009 16:48:03 +1000
Message-Id: <1239173283.10104.38.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-XuiZUEUluVpA+yR8Vu3/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-04-08 at 15:51 +1000, Tony Breeds wrote:
> On Wed, Apr 08, 2009 at 03:08:55PM +1000, Michael Ellerman wrote:
>=20
> > The getter routines in here could really multiplex their return values
> > with a negative error code, which I generally prefer, but this works I
> > guess.
>=20
> I was hoping someone would notice and suggest it.  tag you're it!

I meant we /could/ change them, but we could also leave them, it's a bit
of a coin-flip which is better. Nathan might have an opinion?

Something like this:

diff --git a/arch/powerpc/kernel/cacheinfo.c b/arch/powerpc/kernel/cacheinf=
o.c
index bb37b1d..9f3a155 100644
--- a/arch/powerpc/kernel/cacheinfo.c
+++ b/arch/powerpc/kernel/cacheinfo.c
@@ -191,7 +191,7 @@ static void cache_cpu_set(struct cache *cache, int cpu)
        }
 }
=20
-static int cache_size(const struct cache *cache, unsigned int *ret)
+static int cache_size(const struct cache *cache)
 {
        const char *propname;
        const u32 *cache_size;
@@ -202,19 +202,18 @@ static int cache_size(const struct cache *cache, unsi=
gned=20
        if (!cache_size)
                return -ENODEV;
=20
-       *ret =3D *cache_size;
-       return 0;
+       return cache_size;
 }
=20
-static int cache_size_kb(const struct cache *cache, unsigned int *ret)
+static int cache_size_kb(const struct cache *cache)
 {
        unsigned int size;
=20
-       if (cache_size(cache, &size))
-               return -ENODEV;
+       size =3D cache_size(cache);
+       if (size < 0)
+               return size;
=20
-       *ret =3D size / 1024;
-       return 0;
+       return size / 1024;
 }
=20
 /* not cache_line_size() because that's a macro in include/linux/cache.h *=
/
@@ -515,8 +514,9 @@ static ssize_t size_show(struct kobject *k, struct kobj=
_attr
=20
        cache =3D index_kobj_to_cache(k);
=20
-       if (cache_size_kb(cache, &size_kb))
-               return -ENODEV;
+       size_kb =3D cache_size_kb(cache);
+       if (size_kb < 0)
+               return size_kb;
=20
        return sprintf(buf, "%uK\n", size_kb);
 }


cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-XuiZUEUluVpA+yR8Vu3/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkncSKMACgkQdSjSd0sB4dK6ogCgrPJS8bJK7SFsRjtZJDom67Ol
ElAAn3Uh7VolFbavhe3Xh7i0DRutlVN0
=fYjK
-----END PGP SIGNATURE-----

--=-XuiZUEUluVpA+yR8Vu3/--
