Return-Path: <joerg@alea.gnuu.de>
Received: from uucp.gnuu.de (uucp.gnuu.de [83.246.114.63])
	by ozlabs.org (Postfix) with ESMTP id 7A18CB70B8
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Sep 2010 00:23:21 +1000 (EST)
Date: Mon, 27 Sep 2010 14:50:37 +0200
From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Oops in trace_hardirqs_on (powerpc)
Message-ID: <20100927125037.GA4497@alea.gnuu.de>
References: <20100806233157.GA7117@alea.gnuu.de>
	<1285184671.26872.127.camel@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
In-Reply-To: <1285184671.26872.127.camel@gandalf.stny.rr.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Steven,

Steven Rostedt hat am Wed 22. Sep, 15:44 (-0400) geschrieben:
> Sorry for the late reply, but I was on vacation when you sent this, and
> I missed it while going through email.
>=20
> Do you still have this issue?

No. I've rebuild my kernel without TRACE_IRQFLAGS and the problem
vanished, as expected. The problem is, that in some cases the stack is
only two frames deep, which causes the macro CALLER_ADDR1 makes an
invalid access. Someone told me, there a workaround for the problem on
i386, too.

% sed -n 2p arch/x86/lib/thunk_32.S
 * Trampoline to trace irqs off. (otherwise CALLER_ADDR1 might crash)

Bye, J=F6rg.
--=20
Angenehme Worte sind nie wahr,
wahre Worte sind nie angenehm.

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature http://en.wikipedia.org/wiki/OpenPGP
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkygkx0ACgkQwe0mZwH1VICMRACfS1qucjIyFj+p8CB55kopPB3Q
oHwAoJmA2XysgTSHqoBhVchfOs7Fdm8J
=zPt1
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
