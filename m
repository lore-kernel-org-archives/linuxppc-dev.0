Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 423dWL4GDbzF3Bg
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Sep 2018 15:17:18 +1000 (AEST)
Date: Mon, 3 Sep 2018 15:17:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH kernel] KVM: PPC: Avoid mapping compound pages to TCEs in
 real mode
Message-ID: <20180903051714.GE2679@umbus.fritz.box>
References: <20180831060850.33010-1-aik@ozlabs.ru>
 <20180903032844.GD2679@umbus.fritz.box>
 <20180903051529.GA7848@fergus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Lb0e7rgc7IsuDeGj"
In-Reply-To: <20180903051529.GA7848@fergus>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Lb0e7rgc7IsuDeGj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 03, 2018 at 03:15:29PM +1000, Paul Mackerras wrote:
> On Mon, Sep 03, 2018 at 01:28:44PM +1000, David Gibson wrote:
> > On Fri, Aug 31, 2018 at 04:08:50PM +1000, Alexey Kardashevskiy wrote:
> > > At the moment the real mode handler of H_PUT_TCE calls iommu_tce_xchg=
_rm()
> > > which in turn reads the old TCE and if it was a valid entry - marks
> > > the physical page dirty if it was mapped for writing. Since it is
> > > the real mode, realmode_pfn_to_page() is used instead of pfn_to_page()
> > > to get the page struct. However SetPageDirty() itself reads the compo=
und
> > > page head and returns a virtual address for the head page struct and
> > > setting dirty bit for that kills the system.
> > >=20
> > > This moves dirty bit setting before updating the hardware table
> >=20
> > Um.. but now you're setting DIRTY based on the *new* TCE's
> > permissions, instead of the old TCE's permissions, which I don't think
> > is correct.
>=20
> He's setting dirty on the page which is about to be mapped if the new
> TCE allows the page to be written by the device.  Given that the page
> is pinned, I don't see any reason why the dirty setting has to be done
> when the page is unmapped rather than when it is mapped.  Do you see a
> reason?

Hrm.  Couldn't the page get marked clean by some other path before it
is unmapped in that case?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Lb0e7rgc7IsuDeGj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluMw9cACgkQbDjKyiDZ
s5LI8A//TkMFziMY98N7Yrar+FQmd50WcGhEfsPzSBdxHS7VReIdTBh8ClK7ILJc
FogI4g8TtjFU5BpsB31TnFpI1L5XJWrwwRPlcsE9QrQCzoxxagA6Q5eP76W9A1jm
aW4uNXWerhbdnnBiDSN9nQBTv8kZKSyR4CbOi/rstoE6ZLMcgG4wqzlVOK0n03cv
5niSJWHsYguSyezVXpVYl4JvwThuPrzVZaqmeIhpouUEGXVqrQy8OY8MijcJ48KN
bD8qcoiRtpk7XR65Y5Vyg+e1lgfdhWcImMDP2KNj6W/3EUeJOwfkcHKEyMLDtc30
HM3cFGiU5T/9rmYTzuf7OvBo52gYiA/KJXtpj/OemDh/i9tm6kFGHv7G7ZOfmyMQ
0z64XpA8Z7LMhdaOU6OWkHZ+7k+5cwXicUoC0VCTuWzLt7EurZqmVPzgvpoQ7aCq
XbbjmNUGzAT1iDaKoFkJscfBGM1hXUgt2Yxz3DH+9+R4vF8rtZ6o97a+bd11wLWH
Poc8hHx86lbUC2xg9maNa6+xnl6Dyeo8WDvriZjHwdmqeK15pAJmIsiGkezecinF
c/NwPDqwsiSbZloobXPgJvjOb/I9bItc3CTE2h8gaY6/MhRpJMq9pj0sTrsFIoim
6K7jwtBj8yn+5IewT5b8l/Caq1FxmY0ITxWauf9/vTbnNd+deac=
=WfGK
-----END PGP SIGNATURE-----

--Lb0e7rgc7IsuDeGj--
