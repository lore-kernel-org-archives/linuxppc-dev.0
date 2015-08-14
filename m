Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com
 [IPv6:2607:f8b0:400e:c03::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CA6321A1F3C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 17:14:08 +1000 (AEST)
Received: by pacrr5 with SMTP id rr5so54660752pac.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 00:14:07 -0700 (PDT)
Date: Fri, 14 Aug 2015 15:13:57 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/3] powerpc/e6500: hw tablewalk: order the memory access
 when acquire/release tcd lock
Message-ID: <20150814071357.GI30310@pek-khao-d1.corp.ad.wrs.com>
References: <1439466697-18989-1-git-send-email-haokexin@gmail.com>
 <1439466697-18989-3-git-send-email-haokexin@gmail.com>
 <1439523559.4099.116.camel@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ijf6z65S790CMqo8"
In-Reply-To: <1439523559.4099.116.camel@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--ijf6z65S790CMqo8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2015 at 10:39:19PM -0500, Scott Wood wrote:
> On Thu, 2015-08-13 at 19:51 +0800, Kevin Hao wrote:
> > I didn't find anything unusual. But I think we do need to order the
> > load/store of esel_next when acquire/release tcd lock. For acquire,
> > add a data dependency to order the loads of lock and esel_next.
> > For release, even there already have a "isync" here, but it doesn't
> > guarantee any memory access order. So we still need "lwsync" for
> > the two stores for lock and esel_next.
>=20
> I was going to say that esel_next is just a hint and it doesn't really ma=
tter=20
> if we occasionally get the wrong value, unless it happens often enough to=
=20
> cause more performance degradation than the lwsync causes.  However, with=
 the=20
> A-008139 workaround we do need to read the same value from esel_next both=
=20
> times.  It might be less costly to save/restore an additional register=20
> instead of lwsync, though.

I will try to get some benchmark number to compare which method is a bit be=
tter.
Do you have any recommended benchmark for a case this is?

Thanks,
Kevin

>=20
> -Scott
>=20

--ijf6z65S790CMqo8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVzZU1AAoJEJNY7TDerrFxppMIAKAnwTdPE69morUo7PibMovW
+f4sqWPkYXFdFay4AL0R/elqxwB4O0A6sLqgrru+NJ/dE+6bjnGtr0Na7F2SZeEc
KmWkH+aMeIso/xW5z2/VzQna/vAh+w0lNCn/jXHF0wjHETcYU4WrXSAqZ9lMBxZl
1pKP8UU04WViZFBj+a/Lh4BRps+lvcNXHkTwhcKbjCwlYM+1ABQSS5Bsh1MHMEB5
Gx6w7/NA8MbDVu/6wD7gFWAqEyyy4NTSitawYi2BYnfS54C3W9q8kC/58UbVFLe6
qTiO4u+L8oEJ2fBR5UhqkHa80oVpuf9br9g1RaZkyO1R7/IbMojhAk31rk3vJww=
=NRhI
-----END PGP SIGNATURE-----

--ijf6z65S790CMqo8--
