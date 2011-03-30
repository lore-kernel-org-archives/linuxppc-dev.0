Return-Path: <emunson@mgebm.net>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9EFF5B6F12
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 31 Mar 2011 05:37:05 +1100 (EST)
Received: by vws20 with SMTP id 20so1375029vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 30 Mar 2011 11:37:01 -0700 (PDT)
Date: Wed, 30 Mar 2011 14:36:56 -0400
From: Eric B Munson <emunson@mgebm.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] POWER: perf_event: Skip updating kernel counters if
	register value shrinks
Message-ID: <20110330183656.GA2564@mgebm.net>
References: <1301059689-4556-1-git-send-email-emunson@mgebm.net>
	<1301378637.2402.671.camel@pasglop>
	<20110329142519.GA3527@mgebm.net>
	<1301433165.2402.689.camel@pasglop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
In-Reply-To: <1301433165.2402.689.camel@pasglop>
Cc: a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org, paulus@samba.org,
	anton@samba.org, acme@ghostprotocols.net, mingo@elte.hu,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Mar 2011, Benjamin Herrenschmidt wrote:

> On Tue, 2011-03-29 at 10:25 -0400, Eric B Munson wrote:
> > Here I made the assumption that the hardware would never remove more ev=
ents in
> > a speculative roll back than it had added.  This is not a situation I
> > encoutered in my limited testing, so I didn't think underflow was possi=
ble.  I
> > will send out a V2 using the signed 32 bit delta and remeber to CC stab=
le
> > this time.=20
>=20
> I'm not thinking about underflow but rollover... or that isn't possible
> with those counters ? IE. They don't wrap back to 0 after hitting
> ffffffff ?
>=20

They do roll over to 0 after ffffffff, but I thought that case was already
covered by the perf_event_interrupt.  Are you concerned that we will reset a
counter and speculative roll back will underflow that counter?

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJNk3hIAAoJEH65iIruGRnNsUwH/3qT728+BEeypqHDAYtS6Vxt
vrLNmiVCOjkBvek7FvXdmGmK2hlqj/fziTA9UCN5Z84Bm170X4R+PJFLeDBHfJSt
kcJVVw/TwQlmUu+E7K6tg1LRt0mfxeh/JvxhZylW3XlCNyL0xvs8PLtc5anbThDL
bi52mX7vbZLJxb+5ESLP71WmGYJ5K4ldLKH2BiwzEmXc8a1XhHmM6bmsh4qBL5pg
4Z4vTn+KB+L1JpYj6OVMYynmZtxx8/H1eRPSyVPVloQy9Ty3RzaUnpiqo46Autwc
2a2hYuDtk9Uq8Z1Ru75UVZI4cW838VmikMBOaZmRzMaSdIt/uCwlJQiLxGDYXpY=
=dnjq
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
