Return-Path: <marc.leeman@gmail.com>
Received: from lmailproxy04.edpnet.net (lmailproxy04.edpnet.net [212.71.1.197])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DA3B8DE031
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Jun 2007 00:59:44 +1000 (EST)
Received: from chiana.homelinux.org (213.219.137.187.adsl.dyn.edpnet.net
	[213.219.137.187])
	by lmailproxy04.edpnet.net (8.13.1/8.13.1) with ESMTP id l5TF9sng025981
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2007 17:09:54 +0200
Received: from marc by chiana.homelinux.org with local (Exim 4.63)
	(envelope-from <marc.leeman@gmail.com>) id 1I4Hwf-0001KP-6I
	for linuxppc-dev@ozlabs.org; Fri, 29 Jun 2007 16:59:37 +0200
Date: Fri, 29 Jun 2007 16:59:36 +0200
From: Marc Leeman <marc.leeman@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: 2.4/2.6/ppc/powerpc/8245/8347e
Message-ID: <20070629145936.GL2660@chiana.homelinux.org>
References: <20070621141519.GQ5417@chiana.homelinux.org>
	<0090CCD0-EBB4-4475-BF03-36AF41E2DDA1@kernel.crashing.org>
	<20070621155616.GR5417@chiana.homelinux.org>
	<20070621171340.GS5417@chiana.homelinux.org>
	<20070628180632.GA2660@chiana.homelinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="N+qDRRsDvMgizTft"
In-Reply-To: <20070628180632.GA2660@chiana.homelinux.org>
Reply-To: Marc Leeman <marc.leeman@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--N+qDRRsDvMgizTft
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

More platforms and higher bitrate tests (I've left the previous post in
comment):

> a) 8245/2.4.34/e100: 2.3.43-k1, @400 MHz
> b) 8245/2.6.17/e100: 2.3.43-k1 [2] @350 MHz
> c) 8347e/2.6.21.1/gianfar @400 Mhz
> d) XScale-IXP42x/2.6.18-4/ixp4xx @266 MHz (NSLU2)
e) 8245/2.6.17/e100: 3.5.10-k2-NAPI @350 MHz
f) 405/2.6.22-rc6/smsc9117 @200 MHz
g) 405/2.4.32/IBM OCP EMAC: 2.0 @266 MHz
h) Coppermine/2.6.18/e100: 3.5.10-k2-NAPI @930 MHz
=20
> (2.3.43-k1 is the e100 driver version).

Platform h is just an old server as reference to see if a 2.6.x scales
as bad with an e100 on a different architecture.

>=20
> The process load for taking in the data is:
>=20
> a) 4-5% [3]
> b) 10-11%
> c) 13-14%
> d) 4-5%
e) 10-11%
f) 2-3%
g) 5%
h) 0%

This situation is even (a lot) worse when increasing the bitrate. When
a bitrate of 12 Mbps is used, we get the following results:

a) 4-5%
b) 18%
c) 35%
d) 4-7%
e) 18%
f) -
g) -
h) 1-2 %

> While the current 8347/gianfar platform is the worst performer, the
> 2.6 kernel with the 2.4 e100 (before the rewrite) seems to perform
> poorly too [4].
>=20
> So the 834x preforms worse wrt the 8245 based configuration even though
> it is slightly higher clocked.
>=20
> It seems as if I bumped into the problem that lead me stick with the 2.4
> in the first place for this 8245 platform; but never got round to
> investigating. I find these results especially intriguing when
> considering an ARM platform (NSLU2 device) that I had around, clocked at
> only 66% of the 8347 and at 80% of the 8245 performs certainly in par
> with the last one...

The load is even worsening in a non linearly as the bitrate goes up (I
coult not test all the platforms for this since not all the embedded
platforms are located in our network and I've rallied some collegues
=66rom over the company to get some other platforms tested, probably I
will get more data next week).

> Even though I will need to recheck this (results to follow), a quick
> test didn't reveal any significant difference between a ppc and powerpc
> arch in the kernel.
>=20
> It does look like, on our 8245/83xx platforms, the 2.6.x kernel performs
> worse wrt the 2.4 ppc kernels and the 83xx configuration is worse wrt
> the 8245 based configuration [5]. In retrospect, we had signals that
> there was a problem with the 8245/83xx performance over the network last
> year when investigating gstreamer, but due to time pressure but assumed
> it was due to gstreamer and not the processor. This came as a suprise to
> some of the ppl on the gstreamer mailing list that reported performant
> ports to ARM architectures.

If I look at platform (f), 405/2.6.22-rc6, it doesn't seem to be a
general powerpc problem, but just a 824x/83xx or platform issue.

> The results with the NSLU2 will certainly put heat on us from management
> when redesigning or for follow up designs :(
>=20
> Anyhow, I'm currently extending my test setups since this is an
> important problem and set back.
>=20
> If anyone has a hint to explaining what is going on here, please do
> since solving this will certainly beat redesigning (esp. considering the
> timeframe we've been assigned).
>=20
>=20
> I've only found one relevant reference to 2.4/2.6 network performance
> decrease at this point [6].
>=20
>=20
> [1] sources attached
 mcrecv -a 225.1.2.3 -p 12345
 mcsend -a 225.1.2.3 -p 12345 -b 8192

--=20
  greetz, marc
Aeryn, did I say or do anything to piss you off? I mean other than
caving in the side of your head?
	Crichton - Die Me, Dichotomy
chiana 2.6.18-4-ixp4xx #1 Tue Mar 27 18:01:56 BST 2007 GNU/Linux

--N+qDRRsDvMgizTft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGhR5XUQpj09NWLeERAifpAKCgIA8J0rfIveJTyD7PBxPHvrSc6QCdGVQy
8wKajS9foT5JO46zpSYp0eQ=
=YdzS
-----END PGP SIGNATURE-----

--N+qDRRsDvMgizTft--
