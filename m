Return-Path: <wolfi@mittelerde.physik.uni-konstanz.de>
Received: from honk1.physik.uni-konstanz.de (honk1.physik.uni-konstanz.de
	[134.34.140.224])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B93F0679E2
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Jun 2005 19:34:24 +1000 (EST)
Date: Mon, 6 Jun 2005 11:34:11 +0200
From: Wolfram Quester <wolfi@mittelerde.physik.uni-konstanz.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20050606093411.GB3478@halley.zuhause>
References: <1117424155.5228.28.camel@gaston>
	<3db27390050530145939d260e4@mail.gmail.com>
	<20050602130502.GA6151@halley.zuhause>
	<1117750504.31082.76.camel@gaston>
	<20050603093316.GA4777@halley.zuhause>
	<1117838638.31082.173.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
In-Reply-To: <1117838638.31082.173.camel@gaston>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: ppc32: Rework power management take #3
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ben,

On Sat, Jun 04, 2005 at 08:43:57AM +1000, Benjamin Herrenschmidt wrote:
>=20
> > Normally I use rivafb, but I tried video=3Dofonly and did not get a
> > freeze. I tried it three times and I hope that this is good statistics.
> > With 2.6.12-rc2 and riva fb I got the freeze in about 80% of all initial
> > suspends, with rc{4,5-git6} and riva fb I had it everytime. But it may
> > still well be that there is a random component since I learned to
> > workaround the problem by switching to tty1 and thus don't trigger the
> > freeze condition that often.
>=20
> Ok, what happens if you run rivafb, ssh into the box, and open a new tty
> (that is leave the box on X, but do something like echo "toto"
> >/dev/tty8) to create a new tty in the background.
>=20
> Does that trigger the freeze ?
>=20
> Ben.

OK, I tried that in some variations. If I do as you suggest, nothing
happens, I can login and use X as normal. But as soon as I try to switch
to tty1, the machine freezes. Without this ssh-stuff I can switch to
tty1 and back and be happy.

Then I rebooted, ssh'd into the box and added the line
8:23:respawn:/sbin/getty 38400 tty8
to open getty on tty8. I did telinit q to reload the init config and got
the same thing as described above. After a reboot and leaving the line
intact I could switch to tty8 and be happy.=20

Again, I ssh'd into the box and opened tty9 via echo... which lead to
the behaviour already described.

This looks to me as if it fails to switch to a tty which was not
allocated before.

Thanks for looking into this,

Wolfi

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCpBiTH0o2mefAfsQRAoXLAJ9qOGveWaBCU46W5JZrxRlYMbOlhgCdGUjd
Z5otffj6/cFwoHXjeB1uDkM=
=FQsk
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--
