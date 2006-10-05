Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 8B7E567D81
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Oct 2006 10:16:39 +1000 (EST)
Date: Thu, 5 Oct 2006 04:16:22 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 10/11] Add MPC8360EMDS board support
Message-ID: <20061005041622.58c9ada2@vitb-lp.dev.rtsoft.ru>
In-Reply-To: <17700.19414.724178.711359@cargo.ozlabs.ibm.com>
References: <20060927155626.4d5ca19c@vitb.ru.mvista.com>
	<4879B0C6C249214CBE7AB04453F84E4D19D865@zch01exm20.fsl.freescale.net>
	<20060927165556.04c8d5d7@vitb.ru.mvista.com>
	<CE624A83-809E-4180-800E-660A578FFCFC@embeddedalley.com>
	<20060927112201.293fef44@localhost.localdomain>
	<EBD0615C-4F22-430F-BD23-1283DF98F1B3@embeddedalley.com>
	<1159942128.13323.21.camel@localhost.localdomain>
	<7BD0D5CE-7BA3-43DC-B972-B75672F6A31E@embeddedalley.com>
	<1160005019.5887.30.camel@localhost.localdomain>
	<17700.19414.724178.711359@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_=.4ZWK2o7Og1J473N8aGmgH";
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_=.4ZWK2o7Og1J473N8aGmgH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Oct 2006 10:03:34 +1000
Paul Mackerras wrote:

> Benjamin Herrenschmidt writes:
>=20
> > > It's the 'or not' part that I am worried about.  Things like
> > > you mention above make sense.  I'm starting to worry about
> > > some of this other stuff, and the bscr example is what
> > > woke me up :-)  I think that's an example of things that
> > > should be considered not necessary.
> >=20
> > I haven't looked at this specific example. I'll try to have a look
> > later. I jumped into the discussion pointed by somebody else :)
>=20
> That one was interesting - the bcsr was being referenced from an
> ethernet driver that looked to me like it would be useful on any board
> based on an 836x chip (I think).  Yet it was claimed that the bcsr was
> so specific and unique to each board that there was no point putting
> it in the device tree - which implies that we would have to have a
> separate lump of code in the tree to drive it for every single
> board. :P  I asked why the ethernet driver was accessing it directly
> if that was the case, but didn't get an answer (well, only an indirect
> answer in that the bcsr access code got removed from the ethernet
> driver).
>=20

Well that's because accessing bcsr in generic code is just odd. Yes, there =
are some places with=20
such a stuff still. bcsr is something like a sw jumper to enable/disable st=
uff, configure things, etc.=20
which may vary up to the hw design even if it's following the reference clo=
sely.

It's unique across the boards, and should be touched in BSP code only to ke=
ep the base sane.

Such a thing in the eth driver directly was sort of "nice" because takes ca=
re of enabling network "physically"
on board. For the same aim, I used to have board-specific callback to set u=
p some bits if needed(speaking about
fs_enet/ppc). IOW, upon network driver init, it triggers callback function =
(passed in there via platform data) that's intended to do the bsp setup (or=
 may be unset if nothing needed). In powerpc, only sane solution seems to b=
e Dan's proposed=20
feature_call thing. I wish I'd have some time for that ...

Thanks,=20
-Vitaly

--Sig_=.4ZWK2o7Og1J473N8aGmgH
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFJE7XuOg9JvQhSEsRAuE+AKCObc5XlKJUt0iYIOC7hP6LscvsEQCdEdff
XzYG4gf6ZJo0zsogjwe1JxE=
=HPyp
-----END PGP SIGNATURE-----

--Sig_=.4ZWK2o7Og1J473N8aGmgH--
