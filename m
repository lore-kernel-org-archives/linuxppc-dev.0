Return-Path: <balbi@ti.com>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E70892C008C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2013 18:50:27 +1100 (EST)
Date: Mon, 14 Jan 2013 09:50:16 +0200
From: Felipe Balbi <balbi@ti.com>
To: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/1] usb: fsl-mxc-udc: fix build error due to
 mach/hardware.h
Message-ID: <20130114075016.GB10176@arwen.pp.htv.fi>
References: <1357898188-10540-1-git-send-email-peter.chen@freescale.com>
 <20130111125059.GA12715@arwen.pp.htv.fi>
 <20130114011241.GC24575@S2101-09.ap.freescale.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
In-Reply-To: <20130114011241.GC24575@S2101-09.ap.freescale.net>
Cc: r58472@freescale.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 Felipe Balbi <balbi@ti.com>, Peter Chen <peter.chen@freescale.com>,
 kernel@pengutronix.de, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Reply-To: balbi@ti.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 14, 2013 at 09:12:43AM +0800, Shawn Guo wrote:
> Balbi,
>=20
> On Fri, Jan 11, 2013 at 02:50:59PM +0200, Felipe Balbi wrote:
> > As I said before, this patch is too big for -rc and is unnecessary
> > considering patch I wrote above. Note that there is no problems in
> > checking if ULPI PHY clk is 60MHz on all arches and, for the workaround,
> > you already have a runtime check.
> >=20
> Ok, I did not have these facts on my mind.  If these are true, the
> cpu_is_xxx() shouldn't be necessary there from the beginning, and we
> can simply remove them then.
>=20
> > Shawn, it can be broken down into smaller pieces because you can *FIX
> > THE COMPILE BREAKAGE* with a very small patch as above (only issue now
> > is usage of MX32_IO_ADDRESS()).
> >=20
> The MX35_IO_ADDRESS() also seems unnecessary, since as Peter's patch
> suggested that pdata->regs can be used instead.

pdata->regs is a hack. The 'canonical' way to pass addresses to drivers
is via struct resource.

--=20
balbi

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ87i4AAoJEIaOsuA1yqREwGMP/i+x1y2NZXmSjBk9NhiUwgY3
BJHXjJEqnHaq0wVk1IsTFVqvhNet39Y2w0IIKPRtMKUCBBRQdiVz3RNPWhOQoPG6
QZaUB+ZxAaQ0WQvJuJFztXnZpw8Jjp9h+Sgx+4B7RQQ3BBQ7U1sNkijB5zyiogia
pK53qA4SJzz74AkJO0q6v1UNykUURH2yalDV9M2SCuK2iiaF8OSRTpLsbQxdMT9s
FavmN6gj+FnL+Xh2kyI83fcTUxQs6lMlNtFIxxBlpXdF0JDQ8Sfz2xAUA2dXVMRV
UKeb6fmQ00H76O8j16dqT4g7zR7F5N6VPe5nO6mCpmDL+Ls+C6/Sw52Gl9ad1WTm
xCx5haaU+27BuVXXd73mcS/hjrc9gxpGU9DoDqn7IW12L6oOvtupPSWLXNKc+EqF
uctzuoCDrBbk1Rd1VWDAZQVEfSCg8GJtQ4z/cE6/5BvkuMp3BFYm3W3JXYKVK9GR
q2yo5h32cFvEW4iQ2DMKexLZJGlBQDk3NQF0boXLOoCrqZfi5kqd3TKyzCSDlYsH
yraJ9kk/qBrEfaaIGxdUOuEn/PS0IdWRcALLh3IX7ObGtxplhJvD1dchFvgn3Kn5
UQgeKJwXwKNooBXfjDQsGaItwMwU0ZMwdGpS1RgYtTtcjSnMoqhI9kE4teYMgUiH
l1Ftehymx399VTuTTBdS
=nDyT
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
