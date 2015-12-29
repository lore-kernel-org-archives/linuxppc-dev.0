Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CB5C1A0156
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Dec 2015 16:35:10 +1100 (AEDT)
Date: Tue, 29 Dec 2015 15:09:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: lvivier@redhat.com, thuth@redhat.com, paulus@samba.org,
 bharata@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC 0/3] Prototype PAPR hash page table resizing (guest side)
Message-ID: <20151229040929.GA3707@voom.BigPond>
References: <1450761298-12172-1-git-send-email-david@gibson.dropbear.id.au>
 <567BB96D.6050504@linux.vnet.ibm.com>
 <20151224103844.GB3011@voom.redhat.com>
 <5680BD18.1070408@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
In-Reply-To: <5680BD18.1070408@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 28, 2015 at 10:09:52AM +0530, Anshuman Khandual wrote:
> On 12/24/2015 04:08 PM, David Gibson wrote:
> > On Thu, Dec 24, 2015 at 02:52:53PM +0530, Anshuman Khandual wrote:
> >> > On 12/22/2015 10:44 AM, David Gibson wrote:
> >>> > > I've discussed with Paul and Ben previously the possibility of
> >>> > > extending PAPR to allow changing the size of a running guest's ha=
sh
> >>> > > page table (HPT).  This would allow for much more flexible memory
> >>> > > hotplug, since the HPT wouldn't have to be sized in advance for t=
he
> >>> > > maximum possible memory size of the guest.
> >> >=20
> >> > Does it include reducing the size of HPT as well ?
> > It does, but that could fail with H_PTEG_FULL if there's a collision
> > between bolted entries in the reduced table.
>=20
> So in the case when we request for a reduced size HPT table, as mentioned
> in the second implementation method, will we allocate the required smaller
> HPT table to shadow the original or we just reduce the original HPT in
> size without allocating a new one ?

The current implementation will allocate a new HPT and free the
original one once the transition is complete.  It might be possible to
avoid that and reduce the HPT in place, but doing a rollback in case
of collision will be a lot hairier.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWggd5AAoJEGw4ysog2bOSQUkP/AoevEbiyEsHyl6jvyexmnba
4R7SOi5jb8ODlKqKnq48imIsf7U4DaGvZMxeUR1pcGlo9d2hipJIFOSO56bM4Xpp
QkHBTxF0iHaSWYBiDb4X0RB+55Ny32LAGaCLN8cV9O8qcWHBP6HNtZHKK/lrlkzM
Gk+3cqXsBqs+mZ3j/EARhdvv99RsyHERF2f0KN/jCwFpTDaKSwa7ZQUQYwr09FI7
0jey1+FK1MXRkfCWg4aYxiU+Ww+YSRYiiiyOFwCorkwcwdPZbvz2s0zwwba1ykgL
CUGLucArMUr/TcsM+6tx44DL9jv0ZMpmpzPOb67ukbJwg+5Ug6F/DQDZc0jDdz7t
9MqmXTItqeKaQSuTSAGZNdUgcc2gxznYXMnu4Mx6jT5Y2SEaVopICZihqTm5Nkz/
2m5sekDLatLQ7QjS1xLTxOT/nFQFaTRIYfedqKbAt3oVCx1/2mkhWpwSvWpOoINf
D7Fp4ibno7vCmEU6LG4nlddp7Q+R7mxQwlJCViFCs5gwq2EgdGFzgzxjEH0yCtFO
d8mCDQ/0PIaHqXMgT6Sq6X9T3wLHVi/S/l4Ud/V0n8z+CnFTU4OLdEXPJ8zfNCfE
nlcbLOW1FfvfvDspMceFzGMECxyIOwrehBx/udyMaFks+N1eqXP40KxbbNANifA3
1jeM7icEip9xTxUbFHZi
=YSZo
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
