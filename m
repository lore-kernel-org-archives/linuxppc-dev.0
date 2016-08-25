Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sKsVx3yg8zDr7p
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 04:03:53 +1000 (AEST)
Date: Thu, 25 Aug 2016 13:57:29 -0400
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: aik@ozlabs.ru, benh@kernel.crashing.org, bharata@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, michael@ellerman.id.au
Subject: Re: [RFCv3 00/17] PAPR HPT resizing, guest & host side
Message-ID: <20160825175729.GC2225@littlecatz>
References: <1458532404-21258-1-git-send-email-david@gibson.dropbear.id.au>
 <20160825123834.GB4815@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
In-Reply-To: <20160825123834.GB4815@fergus.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 25, 2016 at 10:38:34PM +1000, Paul Mackerras wrote:
> On Mon, Mar 21, 2016 at 02:53:07PM +1100, David Gibson wrote:
> > This is an implementation of the kernel parts of the PAPR hashed page
> > table (HPT) resizing extension.
> >=20
> > It contains a complete guest-side implementation - or as complete as
> > it can be until we have a final PAPR change.
> >=20
> > It also contains a draft host side implementation for KVM HV (the KVM
> > PR and TCG host-side implementations live in qemu).  This works, but
> > is very slow in the critical section (where the guest must be
> > stopped).  It is significantly slower than the TCG/PR implementation;
> > unusably slow for large hash tables (~2.8s for a 1G HPT).
> >=20
> > I'm still looking into what's the cause of the slowness, and I'm not
> > sure yet if the current approach can be tweaked to be fast enough, or
> > if it will require a new approach.
>=20
> I have finally managed to have a close look at this series.  The
> approach and implementation seem basically sane,

Ok, good to know.

> though I think the
> rehash function could be optimized a bit.  I also have an optimized
> implementation of hpte_page_size() and hpte_base_page_size() which
> should be a lot quicker than the 2d linear (areal?) search which we do
> at present.

Ok, sounds like with those optimizations this approach might be good
enough.  I aim to send a revised version of these some time after the
RHEL 7.3 crunch.

In the meantime, any word on the PAPR proposal?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXvzGJAAoJEGw4ysog2bOSYtcP/1KOIRFE0oH4hpXMaMSThsCh
+eiZeHN5AiTPL1+bI/RcBgDBzddqnhccuHeaIsCRoYlO8SWZP+eaEJosujLT4FFj
xpQAjmkATF1T8gzUuUbq8EuxEZHJGDRGwmWr7zZVit08RkHCvjILH5B/fop6wqPu
aS+3j0CON8if2aqCYod+pVUwnDb92sIOcH6d1iUNFza7sZpu3UMpbhUCxTKiIVll
Yr0IZXxU5T4U3GYpT1+bZqepAG0Dr8iI0IRciwlF9W7SJNYPDq1G2CpFGmWBKZOo
pCZEjZ6etLYOtt3a+J8NWCnPwxN9RSnQVZoJCUrynfhLtQ7OWYI3EkO+A/ypRzsl
2h6/DfR034ka9a4w+jqQnwK3TjVYcH+/0x/h0THy3BKR/gVEz7WczuVCy6ENVcx7
xJbkzkyTS0AP6v2gharRBvh/ZO/Ld+jpYB3HxBaCx4SS7xCfpR1YJ/v80/Wn50fW
VjmBo3LtYKLGEbfBrWMMedWIdPIPcDt69yRzwfM3udu6ulSZ39QtjfsrHv/kO6Xx
/QUrLn/s9pM7l7gP3nuUYq2282GrqiuCeDhyohBD+DUkwGoLId2tjcL575GXQ9G9
NLmGjjNra/Kdx8DbhEaL5z/I6ojiRAV6aQYK/d4zAqj+gvHIN8QvYocc3fbexJ7H
t8Iw0DTiZYw8lfIeAlQ4
=PR6y
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
