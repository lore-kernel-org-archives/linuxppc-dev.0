Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 45297679E2
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Jul 2006 02:51:19 +1000 (EST)
Subject: Re: snd-aoa issues & fixes
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1151481678.4044.11.camel@localhost.localdomain>
References: <1151481678.4044.11.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-abR7NqCwHVl3z9qNlyCe"
Date: Thu, 06 Jul 2006 18:51:05 +0200
Message-Id: <1152204665.4995.104.camel@localhost>
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


--=-abR7NqCwHVl3z9qNlyCe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-06-28 at 18:01 +1000, Benjamin Herrenschmidt wrote:

> - Redefinition of various FCR related bits in i2s-control. I've fixed
> that in the patch and used existing definitions. However, we still have
> a problem that we don't properly lock with pmac_feature for access to
> these. We need to either expose new feature calls now that we are
> upstream or expose the pmac_feature spinlock

Oh, good point. I'd say we add feature calls for that.

> - I noticed you don't call pmac_feature and don't set bits in FCR3
> etc... (enabling the 18Mhz clock for example). Is that normal ? You
> don't use that clock ? That's the only difference in FCR content that
> I've been able to spot between snd-powermac and snd-aoa but hacking it
> doesn't seem to make much difference.

Nah, I simply forgot that. Apparently all the clocks are on anyway? All
rates seem to work here... We want clock refcounting so we can actually
turn them off again, turning them all on is easy enough.

> - The fabric stuff needs a bit of cleanup... You seem to be fond of
> defining lotsa struct's :) Even when they don't contain much :) Triggers
> another problem below

Awww :)

> - I've had a crash with built-in snd-aoa at boot... The problem is that
> when built-in, there is no enforced ordering between module_init() calls
> except for link order... What happens here is that soundbus is last in
> the Makefile, thus we try to register soundbus devices before we
> register the bus type. I fixes that in the patch both by putting
> soundbus first in the Make

Good point. I think someone else noticed that too.

> - If i2sbus is loaded after the codec and fabric, the codec fails to
> initialize. I haven't tried to debug that one

Uhh. I thought the codec couldn't be loaded before i2sbus. I'll have to
see what causes this, probably some reference missing.

> - The dmesg output could use some cleanup :)

:)

> I think we need to change the codec probe phase dramatically:=20

It's not as dramatic as you think.

>   1 - codec drivers register the i2c thingy as normal
>   2 - i2c kicks in, they do the current device-node and/or i2c bus name
> check and register
>       themselves with the core. They do not try to touch the hardware at
> this point
>   3 - fabric kicks in (or was already there). It checks the list of
> codecs registered when
>       loaded and gets notified of new ones added. If codec matches the
> layout, then codec
>       init is called
>   4 - codec init called by fabric. That is where we try to tap the
> hardware. Might fail in
>       which case the fabric doesn't try to use the codec

> (That is, there is a global list of registered codecs at the core, and a
> list of "active" codecs in the fabric or bus, whatever...)

Nah. All we need to do is change the onyx codec driver to not try
probing the onyx. The tas already does it this way iirc. The toonie is a
bit different again, the module will fail loading when the fabric
doesn't want it. But that's fine.

johannes

--=-abR7NqCwHVl3z9qNlyCe
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARK0/d6Vg1VMiehFYAQKQRA//dUgHlL8Psf656WbJppF/lzCjfFsCDwDl
K2+pbD+nC6Hb9WWV0EMhX+WItb1QPVOzDPDSWgSdutHPWtuspwPsc4Tj/8UeAuuJ
Nol8epERoH4qbUIFK0zZpVEzqbXOsKoCcq6A5lXYdmjAbD+EbX59+QCh29I+UnPL
AadIHvafXBEX7B96ZKJCsfp98loExG7qxu2bZ5d52EqHylYNoSV7av1RJ0fZ/bN8
NtRa7WEZSGvR2qqRgJpR+/fDDA+EEvYRTUVgdwO7E7yegFxjIA5Rin26vIFuuYVC
1NSkRdKHYYA3MCG/m1ifmQAIsQUZOuvIqZXs1I4344KGfI/RL0AS8kk0v3vPea9E
7pICFTFeZZWbDvBrfyw0py4xhRHqBTiMKE2cg+6egHioiobBPdvWh2tzmiQusfRP
Y+jlWOom7D0o9x6BHSXdPvPNBmWreTy0F7kVmkA0dmEXdTrOCr9HBMWrqm8Q+BkG
YK/xlGIAElloBIJctNhxDDkemATMsOSn7Z9Vwig7hQo8DCBbGGWZXYPRCqqXgigJ
yEhxeVtm1KW3Hhqryi3/MLcTVp3Yc3PnBLoT99POYcrXHnzAqwWPr1ENH0MdROYO
MyQCMjE2YcTxDWL7siPJrCsNQrvXEpx2B6ECUS/EL9J+6XuxpYhjDf2FYI6rL9VC
RC3n2AKqAMg=
=iBrO
-----END PGP SIGNATURE-----

--=-abR7NqCwHVl3z9qNlyCe--
