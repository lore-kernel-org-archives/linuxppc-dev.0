Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 381B0DDF72
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 00:13:53 +1000 (EST)
Subject: Re: [PATCH] powerpc: enforce sane MAX_ORDER
From: Johannes Berg <johannes@sipsolutions.net>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <B38CBE3A-B9DA-44BA-8646-AEE81FB82437@kernel.crashing.org>
References: <1222262654.4257.4.camel@johannes.berg>
	<B38CBE3A-B9DA-44BA-8646-AEE81FB82437@kernel.crashing.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-nPNJ12/DsIqLO/9fRBNv"
Date: Wed, 24 Sep 2008 16:13:03 +0200
Message-Id: <1222265583.4257.21.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-nPNJ12/DsIqLO/9fRBNv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-09-24 at 09:05 -0500, Kumar Gala wrote:

> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -415,8 +415,11 @@ config PPC_64K_PAGES
> >
> > config FORCE_MAX_ZONEORDER
> > 	int "Maximum zone order"
> > +	range 9 999 if PPC_64K_PAGES
> > 	default "9" if PPC_64K_PAGES
> > +	range 13 999 if PPC64 && !PPC_64K_PAGES
> > 	default "13" if PPC64 && !PPC_64K_PAGES
> > +	range 11 999
> > 	default "11"
> > 	help
> > 	  The kernel memory allocator divides physically contiguous memory
>=20
> Hope about setting the upper bound to 32 or 64. =20

Works for me, I'm interested in the lower bound because if you set
CONFIG_PM on a machine with dart iommu and set this to 9 then the thing
will BUG_ON during boot.

> Since I believe this =20
> in effect 2^FORCE_MAX_ZONEORDER, so 999 is just insane. =20

Indeed it is, and no argument that it's insane. But it's not limited at
all right now, so you can in theory set it to 10000, write a kernel
module that calls alloc_pages(1000) and have it fail because not enough
memory is available, rather than failing because of the MAX_ORDER check.

> I'd almost =20
> prefer something like 16 since that might still be in the realm of =20
> reasonable and able to work.

with 4k pages that would be 256M memory, that seems well possible to
allocate. Even 20 might still be possible (4G memory) if you allocate it
early enough at boot and have a lot of memory (on a 64-bit system).

On the other hand, why bother limiting it? If people set it too large in
their config all that will happen is that it takes a bit longer to fail
to allocate such a ridiculous amount of memory.

johannes

--=-nPNJ12/DsIqLO/9fRBNv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJI2krqAAoJEKVg1VMiehFYfMQP/1/+cEV9j1KpRH7ZTwWT3NnQ
QfxU3YsHlXGeKm4EbfnCAZbkSlGNwcb2/JXvR+lzMawGw/n3sYnJFhR40/XL4DnU
g2srq2heyY7jQZNSTGrO8/KTWkNrPi9tcFS4a+8vCswCrb4lRn0STNwzdC0OH6+A
yAm7AfLg0PDGvE4OgwqrK3wvM3+kwdq2xySdw/iljUuEfRv7hYGJesToSmgSsxJH
suMOzxJljApUtFZAcgyT8bA6muRWI/52itEahuBe2nw4in+FF2RYykFmK1HKA3d3
B7xc1RLxvBDP6uC9LL47ZoHWqS9Zx8PIWUhpzaVZgo2pBa40QHkJjCl2M0UTU1Gn
tr2fKDhrF74XeW3GEE2FesDqYhBQLikoKbuO6aPlNGwMkUdnnINGkuU8g1uYygTQ
dE1fwPgJxzrOniCBj3hV2Gg9MqOJt8YtpJOJRz+VUfZk2ue/cQR4YWloYeh415VR
B7ZcTPGjtGO6PMuFx9k9dNtZuh2WkBS8q/5DBzDM1w7ir3Fte2UG0Jcs3lWBYkcW
QU/Spq78dZtKNknhX60xkw0coZgUrr7CTqTsMoj+vgUHKzj9+yhAGq9xumzpsm2t
R4ZNdf1JQ5W9kvRYe+W/oSEeBwOfXEXdKeIQl8UPpqAsyi9a17vRFG89p2DJdSwE
qptInfARndWOHi398a/S
=AeD/
-----END PGP SIGNATURE-----

--=-nPNJ12/DsIqLO/9fRBNv--
