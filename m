Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tCZmN64lczDvZ3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2016 14:39:00 +1100 (AEDT)
Date: Tue, 8 Nov 2016 14:33:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH kernel v4 4/4] powerpc/mm/iommu, vfio/spapr: Put pages on
 VFIO container shutdown
Message-ID: <20161108033312.GI28688@umbus.fritz.box>
References: <1477291990-2872-1-git-send-email-aik@ozlabs.ru>
 <1477291990-2872-5-git-send-email-aik@ozlabs.ru>
 <20161025044414.GW11052@umbus.fritz.box>
 <9f5fda35-be4d-12d1-e027-d8576cc8e8fe@ozlabs.ru>
 <20161031031318.GM18226@umbus.fritz.box>
 <baf7960d-dbd2-efc8-5574-6a575f2714c6@ozlabs.ru>
 <20161031042347.GN18226@umbus.fritz.box>
 <d03177f8-231e-cef7-d518-e33bea5a1cfb@ozlabs.ru>
 <20161103010228.GD4764@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rCb8EA+9TsBVtA92"
In-Reply-To: <20161103010228.GD4764@fergus.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--rCb8EA+9TsBVtA92
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 03, 2016 at 12:02:28PM +1100, Paul Mackerras wrote:
> On Wed, Nov 02, 2016 at 01:44:03PM +1100, Alexey Kardashevskiy wrote:
> > On 31/10/16 15:23, David Gibson wrote:
> [...]
> > >=20
> > > Um.. yeah.. that's not really ok.  Prohibiting overlapping
> > > registrations on the same container is reasonable enough.  Having a
> > > container not be able to register memory because some completely
> > > different container has registered something overlapping is getting
> > > very ugly.
> >=20
> > I am lost here. Does this mean the patches cannot go upstream?
> >=20
> > Also how would I implement overlapping if we are not teaching KVM about
> > VFIO containers? The mm list has a counter of how many times each memory
> > region was mapped via TCE (and this prevents unregistration), and if we
> > want overlapping regions - a "mapped" counter of which one would I upda=
te
> > in real mode (where I only have a user address and a LIOBN)?
>=20
> The patches fix a real bug, where we run out of memory to run VMs.
>=20
> The patches don't change the interface, and don't introduce the
> constraint that is being discussed here (that the regions being
> registered may not overlap unless they are identical to a previously
> registered region).  That constraint is already present in the
> upstream code.

Ah, good point.  I hadn't thought that through and realized that
limitation was already through.

> They do change the behaviour when you use a container fd from a
> different process from the one which opened the fd, but that is not
> something that worked in any meaningful way before anyway.
>=20
> So David, do you still see any reason why the patches should not be
> accepted?

Given the (still hideously ugly) limitation is not new, then no, not
any more.  I'll send an R-b.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rCb8EA+9TsBVtA92
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYIUd3AAoJEGw4ysog2bOS52wP/RRvUjeJWH7maZGFxpZNWYOq
qZkB4U28XjO/S8zR5crHl4Q/tfA6wEXkq5nwRvc9masxgnB4nL5sTHvCgvQwv30D
dOMHVBqHuKw2PIj0vNZqSD+g45oHOlhlA6le3T6InGGURDhdBKxp9mZRsIPYWerA
PgRVMlcMoQwsZPNVc9P/px49Zp6ou6TZwnEwJh5kq35sSU+cSJGPVjjAizDOKsRN
BzLc7zwTbqsQ+r6Qv78q8hTlgscGKYWhTG5QJkwMdIGz2toJzHtcHrogt5m8tevd
HMEuzCqpdopVwdgCXGt0A6dGKJ8cqBh14hPrVskDwGGHCihR0BQVnVuv6eD8zhUL
KG7LcVhd+eb1gN9Ebrek9O4XSePY/ILT8HGyZabU+Z/clk3v0y2OIMMd0gy7+WKt
f3MC0jIHh6vBOU0WGsLJFtvlwqWtoNj6yXPulnbaIWfZS/7hVKZQ5pi5yywzUQZk
m45G31WaXLBc8rBhONpZ4Dze0ZpRib7uWSfxcVsrvO+wYBqpJFdKvqyIjIUYNDLr
IruupS6CJFX7soE8+fd05u1ikETwxCMt+mf86SFNsUr1+i2su2sBUqGPM2LQu1ke
AfCvRwYYomYNKDKpv8KiZoRTu319o3V6f9+1PYbgDYJA9YlTyWuVkLy84ZOn6atN
xYqyDZ59YJWFsJQEDGxW
=OfMD
-----END PGP SIGNATURE-----

--rCb8EA+9TsBVtA92--
