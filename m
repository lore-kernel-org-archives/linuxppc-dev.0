Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B2B75DDF3B
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 17:37:43 +1000 (EST)
Subject: Re: [PATCH 07/13] Implement arch disable/enable irq hooks.
From: Johannes Berg <johannes@sipsolutions.net>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20070507182950.GF26920@ld0162-tx32.am.freescale.net>
References: <20070507182950.GF26920@ld0162-tx32.am.freescale.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-LiBGPofjUAPvQMoMxXj8"
Date: Mon, 21 May 2007 17:55:02 +0200
Message-Id: <1179762902.9122.19.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-LiBGPofjUAPvQMoMxXj8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-05-07 at 13:29 -0500, Scott Wood wrote:
> These hooks ensure that a decrementer interrupt is not pending when
> suspending; otherwise, problems may occur.  For example, with deep sleep
> on the 831x, a pending decrementer will cause a system freeze because the
> SoC thinks the decrementer interrupt would have woken the system, but the
> core must have interrupts disabled due to the setup required for deep
> sleep.

Interesting to see this first use of these hooks we had to fight for for
so long... Can you put the arch_suspend_{enable,disable}_irqs along with
the actual power management code for 831x?

On the one hand I agree with this patch, this is exactly what we wanted
the hooks for, but on the other hand I would like to have these hooks
free for some more stuff for PMU-based sleep so that I don't need to do
ugly things with platform devices or something for the powermac platform
function stuff.

Then again, if we don't implement these in common code, might we get
link problems when we try building some multiplatform kernel?

johannes

--=-LiBGPofjUAPvQMoMxXj8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGUcDW/ETPhpq3jKURApkVAKC5BMl0K+pl5R3LH1OSL1wlmqIhmQCgt/0P
2/1UorkVPbSIep9c690jUYQ=
=Obri
-----END PGP SIGNATURE-----

--=-LiBGPofjUAPvQMoMxXj8--
