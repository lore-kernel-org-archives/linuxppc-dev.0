Return-Path: <marc.leeman@gmail.com>
Received: from lmailproxy04.edpnet.net (lmailproxy04.edpnet.net [212.71.1.197])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CFF21DDE1F
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 01:47:32 +1000 (EST)
Received: from chiana.homelinux.org (213.219.189.138.adsl.dyn.edpnet.net
	[213.219.189.138])
	by lmailproxy04.edpnet.net (8.13.1/8.13.1) with ESMTP id l69FwMSt028351
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jul 2007 17:58:23 +0200
Received: from marc by chiana.homelinux.org with local (Exim 4.63)
	(envelope-from <marc.leeman@gmail.com>) id 1I7vSO-0000pM-Er
	for linuxppc-dev@ozlabs.org; Mon, 09 Jul 2007 17:47:24 +0200
Date: Mon, 9 Jul 2007 17:47:23 +0200
From: Marc Leeman <marc.leeman@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: 2.4/2.6/ppc/powerpc/8245/8347e
Message-ID: <20070709154723.GD2660@chiana.homelinux.org>
References: <20070621141519.GQ5417@chiana.homelinux.org>
	<0090CCD0-EBB4-4475-BF03-36AF41E2DDA1@kernel.crashing.org>
	<20070621155616.GR5417@chiana.homelinux.org>
	<20070621171340.GS5417@chiana.homelinux.org>
	<20070628180632.GA2660@chiana.homelinux.org>
	<20070629145936.GL2660@chiana.homelinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLvi8k+ew82wFfnH"
In-Reply-To: <20070629145936.GL2660@chiana.homelinux.org>
Reply-To: Marc Leeman <marc.leeman@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--SLvi8k+ew82wFfnH
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> More platforms and higher bitrate tests (I've left the previous post in
> comment):

I finally was able to figure out the culprid:

CONFIG_SLOB=3Dy

instead of=20

CONFIG_SLAB=3Dy

--------
CONFIG_SLAB:

Disabling this replaces the advanced SLAB allocator and
kmalloc support with the drastically simpler SLOB allocator.
SLOB is more space efficient but does not scale well and is
more susceptible to fragmentation.=20
--------

I was expecting a lower DMM performance but wasn't expecting such a
drain on kernel/network load.

The original reason for this change was a fixed flashmap and a increased
2.6 kernel that didn't fit in this region (backwards compatible).

--=20
  greetz, marc
I feel like I had a spiritual enema.
	Jool - Losing Time
chiana 2.6.18-4-ixp4xx #1 Tue Mar 27 18:01:56 BST 2007 GNU/Linux

--SLvi8k+ew82wFfnH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGkliKUQpj09NWLeERAtM8AJ0bjxfpQSOjRKBSGy5ntaE9q5QCxQCfYJP4
t1TeGKYO/4GhVabmamwBVZk=
=nEkv
-----END PGP SIGNATURE-----

--SLvi8k+ew82wFfnH--
