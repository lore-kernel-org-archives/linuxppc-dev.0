Return-Path: <marc.leeman@gmail.com>
Received: from lmailproxy03.edpnet.net (lmailproxy03.edpnet.net [212.71.1.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DA8C9DDDFC
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 17:55:40 +1000 (EST)
Date: Tue, 10 Jul 2007 09:55:29 +0200
From: Marc Leeman <marc.leeman@gmail.com>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: 2.4/2.6/ppc/powerpc/8245/8347e
Message-ID: <20070710075529.GJ2660@chiana.homelinux.org>
References: <20070621141519.GQ5417@chiana.homelinux.org>
	<0090CCD0-EBB4-4475-BF03-36AF41E2DDA1@kernel.crashing.org>
	<20070621155616.GR5417@chiana.homelinux.org>
	<20070621171340.GS5417@chiana.homelinux.org>
	<20070628180632.GA2660@chiana.homelinux.org>
	<20070629145936.GL2660@chiana.homelinux.org>
	<20070709154723.GD2660@chiana.homelinux.org>
	<20070709195623.GK4457@austin.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7knXg9dK90d7f3Md"
In-Reply-To: <20070709195623.GK4457@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: Marc Leeman <marc.leeman@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--7knXg9dK90d7f3Md
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > I was expecting a lower DMM performance but wasn't expecting such a
> > drain on kernel/network load.
>=20
> OK, to be clear: you seem to be saying that using the SLOB instead
> of the SLAB allocator results in such terrible memory fragmentation
> that network performance is degraded by large factors (2x or 5x or
> something like that, if I remember your earlier emails). Is that right?

Yep, I thought I would at least post my findings after hurracing the
list with my posts.

Well, I don't really know if it is the fragmentation that comes into
play, or if it is simply the implementation of the slob allocator that
much more inefficient in allocating free blocks of memory; but that's
about right.

> I thought I heard about some memory-defrag patches being posted. =20
> What happens if these are used together with SLOB? Does one regain the
> lost performance? Perhaps maybe one gets even better performance?

In the ChangeLog of the 2.6.22, I saw something about a slub allocator
that I want to test; I'll give your suggestion a go too, though I would
not expect significant improvements: I suspect it's the slob
implementation that is slower.

But I had a small problem with my flash not being detected anymore when
quickly booting the 2.6.22, I'll look into it today, there was a note in
the ChangeLog for powerpc about this IIRC.

--=20
  greetz, marc
Better wed than dead.
	Crichton - Look at the Princess - A Kiss is Just a Kiss
chiana 2.6.18-4-ixp4xx #1 Tue Mar 27 18:01:56 BST 2007 GNU/Linux

--7knXg9dK90d7f3Md
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGkztwUQpj09NWLeERAvErAKDdcQJ8cdaqng1pNtbwiwck0U6tbwCeMGUV
8XIqww+pIb/kAiwDOw5Wm54=
=Rx4P
-----END PGP SIGNATURE-----

--7knXg9dK90d7f3Md--
