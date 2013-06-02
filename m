Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-f181.google.com (mail-pd0-f181.google.com
 [209.85.192.181])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4245D2C009F
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Jun 2013 10:07:32 +1000 (EST)
Received: by mail-pd0-f181.google.com with SMTP id bv13so3946484pdb.40
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 01 Jun 2013 17:07:29 -0700 (PDT)
Date: Sun, 2 Jun 2013 08:07:20 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] powerpc/mpc85xx: remove the unneeded pci init
 functions for corenet ds board
Message-ID: <20130602000720.GA22546@pek-khao-d1.corp.ad.wrs.com>
References: <1369137900-5748-1-git-send-email-haokexin@gmail.com>
 <1369137900-5748-2-git-send-email-haokexin@gmail.com>
 <1369781529.18630.25@snotra>
 <20130530102034.GB18702@pek-khao-d1.corp.ad.wrs.com>
 <1369940099.14679.14@snotra>
 <20130531064102.GB16514@pek-khao-d1.corp.ad.wrs.com>
 <1369995080.3928.140.camel@pasglop>
 <20130601105936.GA1850@pek-khao-d1.corp.ad.wrs.com>
 <1370087236.3766.43.camel@pasglop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
In-Reply-To: <1370087236.3766.43.camel@pasglop>
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 01, 2013 at 09:47:16PM +1000, Benjamin Herrenschmidt wrote:
> On Sat, 2013-06-01 at 18:59 +0800, Kevin Hao wrote:
>=20
> > The effect of this change is that the isa_io_base will be 0 and the IO
> > resource are equal to the virtual address of the IO space. But the IO
> > functions such as outx/inx should work as well. This is why I ask the
> > above question. What do you think about this? Are there any subtle bugs
> > that will be triggered by this?
>=20
> I don't see any obvious reason why that wouldn't work but like anything
> in that area, it needs a bit of testing & hammering to be sure ;-)

Agreed.

>=20
> In fact it would work on pmac32 as well since those generally don't have
> legacy crap either.
>=20
> So I have no fundamental objection, it just needs testing. My worry is
> that we need to make sure we don't break old chrp and I don't have any
> to test with.

Don't worry, my patch just drop the picking of primary bus for several
fsl boards. All these changes are in board specific file, so it should
have no affect to other boards at all.

For the other boards which have the same issue, since this is not emergency,
we don't want handle them in a rush.  So I would like to merge this patch
first and then wait one or two kernel release cycle before handling the oth=
ers
to make sure that we don't break anything.

Thanks,
Kevin

> I'm happy to drop support for stuff nobody uses anymore
> (we did drop PReP after all and I'm *that* close to drop power3) but as
> long as somebody is still using a CHRP RS6K or a Pegasos I can't quite
> drop those... And they do have legacy ISA crap to deal with.
>=20
> Cheers,
> Ben.
>=20
>=20

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJRqoy4AAoJEJNY7TDerrFx3OYH/j8GUL0c6PmJANsKuthP0Dgq
ipl0/gmCN4QlHmpszZ4wjKnhnisFBUsAEWnnj/lIDtKNubHp+dYQ7E3je1U0GaoU
gHoLAdPoqtU4XvQmQqbYIrTHDf6/4BNjQW85JrwAkuDJSg8blY8DliFmBM2q4DYE
9m/0e0cVFxeNYCC7dzbNeou5WzXNZ09D97jsp/Ra8LzeS4vKnpwOsmu3W0uZ3jQo
lmFrSb655BYcubsqpKW1EmNW0elO/7tQ85gjtLgW1EgRVU87yDOJkZowzNUfDCnv
c7tmBtCOjhR+upAv3/BfUjsld6YGle1fVUA5BbBYuDY9H/PWGbN52w2ha7rrUR4=
=EE9x
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
