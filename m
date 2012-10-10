Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 6F6F42C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2012 11:07:33 +1100 (EST)
Date: Wed, 10 Oct 2012 11:07:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: linux-next: build failure after merge of the origin tree
Message-Id: <20121010110727.9cfd1d80a27e0f308131baed@canb.auug.org.au>
In-Reply-To: <20121009164514.b7a7e227.akpm@linux-foundation.org>
References: <20121010102150.81c192c6fdf60689dc823b20@canb.auug.org.au>
 <20121009164514.b7a7e227.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Wed__10_Oct_2012_11_07_27_+1100_XoIO9eDzcvU5JeRh"
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, linux-next@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Wed__10_Oct_2012_11_07_27_+1100_XoIO9eDzcvU5JeRh
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Tue, 9 Oct 2012 16:45:14 -0700 Andrew Morton <akpm@linux-foundation.org>=
 wrote:
>
> On Wed, 10 Oct 2012 10:21:50 +1100 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
>=20
> > I can't see what the point of the "pfn" variable is
>=20
> This:
>=20
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c~a
> +++ a/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -101,7 +101,7 @@ static int pseries_remove_memblock(unsig
>  	sections_to_remove =3D (memblock_size >> PAGE_SHIFT) / PAGES_PER_SECTIO=
N;
>  	for (i =3D 0; i < sections_to_remove; i++) {
>  		unsigned long pfn =3D start_pfn + i * PAGES_PER_SECTION;
> -		ret =3D __remove_pages(zone, start_pfn,  PAGES_PER_SECTION);
> +		ret =3D __remove_pages(zone, pfn, PAGES_PER_SECTION);
>  		if (ret)
>  			return ret;
>  	}

Can we get that fix to Linus ASAP, please?

> > and this patch never
> > appeared in linux-next before being merged.  :-(
>=20
> It was first sighted October 3.

Yeah, my mistake. But it never made it to linux-next.

> > I have reverted that commit for today.
> >=20
> > If this patch truly was authored yesterday (according the Author Date in
> > git), why was it merged yesterday while still under discussion?  And the
> > latest update to it still has this build problem ... did anyone even try
> > to build this for powerpc (since that architecture was obviously
> > affected)?
>=20
> Apparently not - the ppc bit was a best-effort fixup for a patch which
> addresses an x86 problem.

Right, and that is one of the reasons we have linux-next - to test for
cross architecture problems.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Wed__10_Oct_2012_11_07_27_+1100_XoIO9eDzcvU5JeRh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJQdLw/AAoJEECxmPOUX5FEaI0P/j6AS0q7CqweKGTA23sGoQfh
rGO36Dv98+dnOuAy81e0SSFWFnAdj9dqIzEPDXcE60W7mgMfAnrbDXXct/z9336A
Nc3g19MU+J8IeEyz6iUhEa+cuhqZpFeYC6c0nyvrtzIHNYWz9tqtkpihtA5FycL2
nJZxGIt+wThITKT7xq0ccbhbDXSOaS1fQb0XnvmEITLEMz1sqnvs3gop2euQYc87
5Ni2ePWyqa/qWedon66VvROl/G5nK24s+q9pLigxEaF0QPkg5gorIHBrwuFBjjh1
VnQFUZ1R5fJyIdTx2Rs472Hp+ff69aB1Izw/cLq5nrRMJ7qqtEOmMfDNtbT1xwhR
kEMN8hBhPY8p665cGH9fUUzlUvOsFUv74AvtPQ9mbtd99Cl34k58SZUKpza3r/km
DAR0kbTcrInc8EAA27fpohTuJUwYqgn32sNqnv1kPl9zQveLV+zkYQbTD/1LnFRC
UxHvdciLcqt5MH4kc0HJDxTIEAt1ZyJNig1Ym5wJpm8C7Z9VZk03+ymtE5gQqEwf
TRTC3EP1D8LckgkfEpi1hRy6LT0ysI+vLDuALY0skS97CADKPvcqBTHp+tpC86bc
vjqSsB/Ey8lV5l/OsAdBQAHLSngozSFZepNo+cAAAgzbiZusiooQeMKExP+O58ZW
88o4SSSnXwkRayDAjxB9
=Q7Le
-----END PGP SIGNATURE-----

--Signature=_Wed__10_Oct_2012_11_07_27_+1100_XoIO9eDzcvU5JeRh--
