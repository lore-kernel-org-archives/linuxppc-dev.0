Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-x230.google.com (mail-pd0-x230.google.com
 [IPv6:2607:f8b0:400e:c02::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 085332C00E8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Aug 2013 21:49:33 +1000 (EST)
Received: by mail-pd0-f176.google.com with SMTP id q10so346225pdj.21
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Aug 2013 04:49:31 -0700 (PDT)
Date: Wed, 21 Aug 2013 19:49:15 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: add the missing required isync for the coherent
 icache flush
Message-ID: <20130821114915.GC32546@pek-khao-d1.corp.ad.wrs.com>
References: <1376567767-20620-1-git-send-email-haokexin@gmail.com>
 <ABB05CD9C9F68C46A5CEDC7F1543925901020606@039-SN2MPN1-021.039d.mgd.msft.net>
 <1376883397.25016.60.camel@pasglop>
 <1376883437.25016.61.camel@pasglop>
 <20130819115029.GD20146@pek-khao-d1.corp.ad.wrs.com>
 <1376916335.25016.72.camel@pasglop>
 <20130820121627.GB18634@pek-khao-d1.corp.ad.wrs.com>
 <1377034134.25016.160.camel@pasglop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="adJ1OR3c6QgCpb/j"
In-Reply-To: <1377034134.25016.160.camel@pasglop>
Cc: Wang Dongsheng-B40534 <B40534@freescale.com>,
 linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--adJ1OR3c6QgCpb/j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2013 at 07:28:54AM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2013-08-20 at 20:16 +0800, Kevin Hao wrote:
>=20
> > Dummy question: What does the ifetch buffers mean? The instruction fetch
> > pipeline or instruction dispatch pipeline? Shouldn't all the prefetched
> > instructions in these buffers be discarded by isync?
>=20
> Architecturally isync doesn't have to toss prefetch completely. It only
> needs to make sense that context changes performed by previous
> instructions (and interrupts/traps) happen at the point of the isync,
> for example, it will ensure that a trap conditional is fully evaluated
> before subsequent instruction execution, etc....
>=20
> So in this case, it makes sure the icbi has been executed and it's the
> icbi that invalidates the prefetched instructions.
>=20
> >=20
> > >, sync orders the icbi and isync ensures its execution has been
> > > synchronized. At least I *think* that's the required sequence, I have=
 to
> > > dbl check the arch, maybe tomorrow. I wouldn't be surprise if we also
> > > need a sync before the icbi to order the actual stores to memory that
> > > might have modified instructions with the icbi.
> >=20
> > Doesn't the coherence between icache and dcache be maintained by the sn=
ooping?
>=20
> The icache yes, but not the ifetch buffers (basically think of them as
> buffering stages between icache and dispatch). At least that's my
> understanding of the implementation.=20

OK. Thanks for the explanation. I will update the patch according to your
suggestions.

Thanks,
Kevin

--adJ1OR3c6QgCpb/j
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJSFKk7AAoJEJNY7TDerrFxbFkIAJK77BOyDdz9/b27dKlTDP0W
9dhtsoVqe/fVjpwAtbwKa66Iw+PH5uAaPLFPH2D943TOX857kclDCPPT+NLZnHql
vWa49v0hqzdegeiYj+Pc4wYEJlBPwHU/iTFU6U3sZoqiqJWHLLl4QXCqgrBue3AL
UOygB3JemcwojXiHnoXhW8ojkkOYHsmTr9OWb3tTABQ1eVKv/m3nxTH3eQ2Sxm39
zhcAaGkpPicwb8lAgRA5u5PThM1H2Nf54hBvntHMexpU2UZ9NGQHyFreGuPOdcGf
HzR3m0m/MUz6jin83KHU96D1eK3zgzE0fYvC2SISzNaTX7fJeSGqVjs+pHKzKFk=
=OyRT
-----END PGP SIGNATURE-----

--adJ1OR3c6QgCpb/j--
