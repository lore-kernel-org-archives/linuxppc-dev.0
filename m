Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8663D67B5D
	for <linuxppc-dev@ozlabs.org>; Mon,  1 May 2006 18:59:26 +1000 (EST)
Subject: Re: [PATCH] convert powermac ide blink to new led infrastructure
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1146466608.30710.36.camel@localhost.localdomain>
References: <1146235779.19164.109.camel@localhost>
	<1146237326.19164.111.camel@localhost>
	<1146466608.30710.36.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-OIjRnf82mviAHiJ1twOO"
Date: Mon, 01 May 2006 10:59:19 +0200
Message-Id: <1146473959.24172.4.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-OIjRnf82mviAHiJ1twOO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-05-01 at 16:56 +1000, Benjamin Herrenschmidt wrote:

> Hrm... you find out the hard way in general ... we'll have to be careful
> with this one, maybe have the PMU driver stop the LED after the device
> suspend dance or do a sysdev with a suspend/resume and make sure that
> any pending LED request is complete. Also, your code isn't testing if
> the PMU request is still in progress before possibly sending another
> one ... that's a bit dangerous (and may cause the LED to get "stuck").
> You can re-use a request once it's complete though. In addition, my PMU
> code was written to minimize spinlock usage in the hot path... There
> might be a way to do the same here.

I don't really understand how the PMU works hence wasn't really sure
what the whole request thing does. Do we get an interrupt when it
completes or something? If so, could I get at that notification via the
request structure?

I'll take a closer look and rework this, I think it's worthwhile even if
it requires some more effort.

johannes

--=-OIjRnf82mviAHiJ1twOO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARFXN5aVg1VMiehFYAQI1NxAAvd9TAwuSywrWPntJ9BmLmVPlQi+2CbIL
621wat+Sl5xi0ikC4wWNmmA17zNpP9hahHkO9dPu6+bpyHpTPngc5Fmremxt4vDg
ZEma9HACBuBDfp8nZy5bkkls+7W73NWb8LiWIVoAXepugc0WLzeapQ/PpcqeADny
DTnyP4diT43Oo1mpCXZKB8uVPkj9U6j+yuriP06XBdRSwPpMDofyTnRws5PL3AL3
IKV3kbbIGfEE697sSvXYl9oOKroPGo3qIxgNFdcgOfCu8Ph0WQ4sgC7NymDy9Yp6
gfKKYSc6jzPh8eEgqG6dzqdjmGCkab01QxX49+6XV1+l0dDmN8BkXU/u1W7cRWuq
gmXa21d7iUkUKs8tQCqN7Nc0o+tj/QP61djWSJOzqGsWCmGdUj5q1eocQmERHZkR
tV5b90kVLRo/zKkXFyq9zKn7MNupjq4F8YiOKZHC3faz/pEtFxxLAZ4orb/6/6j5
xlx1niZTquzYjVJ20C42EA1envGi+Zl4XxkGLMxFQwrNUWZFN8m2x7ybOl10AzMw
fWGY0u0SfQXamadd+ryTnPm984jfBizLof9H1ThLaF/SHZLvLyvLiTFmIr0HPdPw
otQEfBK1q89ovLogRZrgPWnV4CvVKSigUxXYLSliH5CERYb3cwVZryokNAZUAwau
ELVPynuO+Q0=
=40ki
-----END PGP SIGNATURE-----

--=-OIjRnf82mviAHiJ1twOO--
