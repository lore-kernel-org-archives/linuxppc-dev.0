Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yqvft74JQzDrMq
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Dec 2017 17:12:22 +1100 (AEDT)
Date: Mon, 4 Dec 2017 17:10:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Serhii Popovych <spopovyc@redhat.com>
Cc: linux-kernel@vger.kernel.org, michael@ellerman.id.au, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 0/4] Fix use after free in HPT resizing code and related
 minor improvements
Message-ID: <20171204061025.GQ2130@umbus.fritz.box>
References: <1511973506-65683-1-git-send-email-spopovyc@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4dIe/AmYstFUGHTF"
In-Reply-To: <1511973506-65683-1-git-send-email-spopovyc@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--4dIe/AmYstFUGHTF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2017 at 11:38:22AM -0500, Serhii Popovych wrote:
> It is possible to trigger use after free during HPT resize
> causing host kernel to crash. More details and analysis of
> the problem can be found in change with corresponding subject
> (KVM: PPC: Book3S HV: Fix use after free in case of multiple
> resize requests).
>=20
> We need some changes to prepare for the fix, especially
> make ->error in HPT resize instance single point for
> tracking allocation state, improve kvmppc_allocate_hpt()
> and kvmppc_free_hpt() so they can be used more safely.
>=20
> See individual commit description message to get more
> information on changes presented.

I spoke with Paul Mackerras about these patches on IRC today.  We want
this as a fix, ASAP, in 4.15.  However, he's uncomfortable with
pushing some of extra cleanups which aren't necessary for the bug fix
this late for 4.15, and was having trouble following what was the core
of the fix.  He was also nervous about the addition of more BUG_ON()s.

To avoid the round trip to Ukraine time and back, I've made revised
versions of patches 1 & 3 which should apply standalone, replaced the
BUG_ON()s with WARN_ON()s and revised the commit messages to better
explain the crucial part of the fix.

However, I've run out of time to test them.

Serhii,  I'll send you my revised patches shortly.  Can you please
test them and repost.  Then you can rebase patches 2 & 4 from this
series on top of the revised patches and post those separately (as a
cleanup with less urgency than the actual fix).

A couple of people have also suggested CCing kvm@vger.kernel.org on
the next round in addition to the lists already included.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4dIe/AmYstFUGHTF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlok5s8ACgkQbDjKyiDZ
s5JE7BAAhOXROb4XsPRNQdKrulpQ09aShopMonE64HS+S2SL6OAuuSwkXw6EmePr
9XzARMnVDuCwt8ticRgBR1o34PHR0Gh0JbDe6dY00/oARbH0cck8buHtfeTBpton
F+QG1muBymoH3suC+UF42/orUFbdIxF6CKGbzWeLu1utdF0p/RTEyEBTZ4opnEVA
tzoKlFFCFfKFB+kBUfMdcr/m237G+gISyUWDZKH8okWz7qjQYT0Pgsv8JILp7ufX
qpC0RXrS5qu7BbeyvS8VF0Vx1iqlP1PpgdzNfjFYtIk1vq1PQzo167VHUqBQrz+t
Nq2azhveo8EhEz3OOeDJTafoaif1RBRIN3ejDFnzzkt00eBYDPGmAb8+UQgfdG0Z
woDhdqwMAibxs1GhSWJHSi+l/y0ydFCgpQOjWJNco9oFkuYq0CkyLxkVCu9TsGZo
r7ZYgLXb9z51GpKk7mVyr8nUrzut9YmRydeaSswOWXZ+AZFgi7QWi+jbKSjEMhBS
QI6kIv3k87TwBnpTEskiJNKGzVaMgwtVFdnzJqUaoFgLuhX984niyuG0g8ly8qr4
61bubQg9speHVvioSaFv/R0Oj0uVMpOAtWeB6iFSV0IeUvlx7A/PlunbCd1vb8P/
1aWaWeDOGrxTeETjbD3q2RHGevhnAHOV1thQf7eDZNPDArpxX3g=
=AWt3
-----END PGP SIGNATURE-----

--4dIe/AmYstFUGHTF--
