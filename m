Return-Path: <wsa@pengutronix.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 11BCCB70B7
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  7 Jun 2009 18:21:33 +1000 (EST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 75F4CDDD04
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Jun 2009 18:21:32 +1000 (EST)
Date: Sun, 7 Jun 2009 10:20:56 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: John Rigby <jcrigby@gmail.com>
Subject: Re: [PATCH 05/04] *** NOT FOR RELEASE *** HACK *** Work around MII
	clock issue ***
Message-ID: <20090607082056.GA6385@pengutronix.de>
References: <1241641262-5202-1-git-send-email-wd@denx.de>
	<1241641262-5202-6-git-send-email-wd@denx.de>
	<4b73d43f0905071909v6e6e8b2el9eb6d4a1b9038f45@mail.gmail.com>
	<20090606221618.701E0832E416@gemini.denx.de>
	<4b73d43f0906061527p7ca1b301ybcfc576870a168d5@mail.gmail.com>
	<20090606232148.4E0BD832E416@gemini.denx.de>
	<4b73d43f0906061708o763409d0u10a344dfc30e32c1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
In-Reply-To: <4b73d43f0906061708o763409d0u10a344dfc30e32c1@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Chen Hongjun <Hong-jun.chen@freecale.com>,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>    My best guess is still that it is ips clock.  I think I stated in a

I fully agree.

a) Table 16-18 in the manual mentions ips and the values given there look m=
uch
   more like ips than ppc_proc_freq (25MHz?)

b) the excerpt from clock.c Wolfgang posted mentions ips as parent

c) I cannot imagine a divider wrapping around at a frequency which is insid=
e the
   range of what the processor is capable of. MII only up to 300MHz seems l=
ike a
   show-stopper to me :)

d) According to the MPC5200B-manual, ipb _is_ used there (and the linux-dri=
ver
   adheres to that). I'd guess those two CPUs are related enough to assume =
it is
   ips here.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoreGgACgkQD27XaX1/VRu8jgCfX+aDxj1AXC5JtxivFzrirkSF
wsAAoIu3EpnJCXIp2qOMV1pJLJwFG9y2
=1Gkq
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
