Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 02B65B6F9D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Mar 2011 19:54:28 +1100 (EST)
Date: Thu, 10 Mar 2011 09:54:14 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Jain Priyanka-B32167 <B32167@freescale.com>
Subject: Re: [rtc-linux] [PATCH] RTC driver(Linux) for PT7C4338 chip.
Message-ID: <20110310085414.GA4460@pengutronix.de>
References: <1299124299-26991-1-git-send-email-Priyanka.Jain@freescale.com>
	<20110303092239.GB3649@pengutronix.de>
	<470DB7CE2CD0944E9436E7ADEFC02FE313B1C2@039-SN1MPN1-003.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
In-Reply-To: <470DB7CE2CD0944E9436E7ADEFC02FE313B1C2@039-SN1MPN1-003.039d.mgd.msft.net>
Cc: "a.zummo@towertech.it" <a.zummo@towertech.it>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	"p_gortmaker@yahoo.com" <p_gortmaker@yahoo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Priyanka,

> Though register-set looks identical but features were different.

Can you tell what exactly is different?

> And also manufacturer is different.

That does not matter. If you look at ds_type, there are already
different manufacturers. They will be correctly distinguished by
i2c_device_id. The name of the driver itself is, well, just a name.

> But still it might be possible that we can reuse ds1307.c with some
> modification.

I agree. The driver already supports some variants. Adding one more
should not hurt. See 97f902b7be4dd6ba03c6aa8d3400783ed687ebd1 for an
example which added ds3231 support.

> But if I look at the drivers present in drivers/rtc folder. Most of
> them looks similar but still there are different drivers for different
> chips.

Yes, it probably could be cleaned up if somebody had the time/hardware.

> Please suggest which way is more preferred: modifying existing
> drivers(of different manufacturer) or writing new driver.=20

Ususally avoiding code duplication is good, it reduces maintenance
burden. However, if adding the support turns out to make the original
code unreadable or hard to follow, a new driver might be justified. This
is why it is important to understand the differences of the chip as a
first step. (I have the feeling, that modifying is the way to go here,
though).

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk14kbYACgkQD27XaX1/VRvn0ACgowh2MQ2seXXDjQWZKldLOgvz
bAsAniHelMFY/2+1diJdpauIybBz9+Tx
=9dwF
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
