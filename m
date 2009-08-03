Return-Path: <albrecht.dress@arcor.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3442EB6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 Aug 2009 04:46:50 +1000 (EST)
Received: from smtp3.netcologne.de (smtp3.netcologne.de [194.8.194.66])
	by ozlabs.org (Postfix) with ESMTP id 6AB33DDD04
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Aug 2009 04:46:49 +1000 (EST)
Date: Mon, 03 Aug 2009 20:46:38 +0200
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Re: [PATCH] powerpc/mpc52xx/wdt: Fix 5200 wdt always being used as gpt
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40908031050g2d03abb5s9dfe4dceb2072af6@mail.gmail.com>
	(from grant.likely@secretlab.ca on Mon Aug  3 19:50:05 2009)
Message-Id: <1249325206.3404.1@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1; boundary="=-r1vhCBVLESF+MM4S8TB7"
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>, wim@iguana.be
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-r1vhCBVLESF+MM4S8TB7
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 03.08.09 19:50 schrieb(en) Grant Likely:
> Just about all mpc5200 device trees have the fsl,has-wdt property on =20
> GPT0 even when it isn't used as a watchdog.

Sorry, I do not understand...  The file =20
Documentation/powerpc/dts-bindings/fsl/mpc5200.txt says

<snip>
On the mpc5200 and 5200b, GPT0 has a watchdog timer function.  If the =20
board design supports the internal wdt, then the device node for GPT0 =20
should include the empty property 'fsl,has-wdt'.
</snip>

I interpreted this as "if you don't want to have the wdt function of =20
gpt0, remove this property".  If this assumption is wrong, how is the =20
kernel supposed to decide if a device shall be used as gpt or as wdt?

> The boards using GPT0 as a GPIO or timer will be broken by this patch.

A wdt is a security device which will (IMHO) either not be used as =20
such, or it is a *must not* be used for something else on a particular =20
board (you may even want u-boot to activate it, e.g. to detect a =20
hanging boot process).  In both cases, a "tuned" device tree is needed.

> I know it is a lot more work, but the correct solution is to merge =20
> the GPT watchdog driver into the regular GPT driver so that we don't =20
> have two device drivers trying to bind against the same device.

I see the benefit of removing some duplicate code and of having gpio =20
access in parallel with the wdt, but it wouldn't solve the general =20
confusion above!  Will look into that, though...

Best, Albrecht.

--=-r1vhCBVLESF+MM4S8TB7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iD8DBQBKdzCWn/9unNAn/9ERAt5xAJ9D5RltzE3BNHxmIob2pU9rX4+a1QCfVqiL
tsS0zdELefKXXimd8ka/m/A=
=58vU
-----END PGP SIGNATURE-----

--=-r1vhCBVLESF+MM4S8TB7--
