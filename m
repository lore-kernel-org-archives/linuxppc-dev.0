Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7489067A2E
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 22:06:10 +1000 (EST)
Subject: snd-aoa status update / automatic driver loading
From: Johannes Berg <johannes@sipsolutions.net>
To: debian-powerpc <debian-powerpc@lists.debian.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-wB/tYAI9+58wst9kgTiE"
Date: Wed, 17 May 2006 12:09:24 +0200
Message-Id: <1147860564.14395.6.camel@johannes>
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


--=-wB/tYAI9+58wst9kgTiE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hey,

Currently snd-aoa is known to work on the following machines:
* PowerBook5,8
* PowerBook5,7
* PowerMac8,1
* PowerMac8,2
* 17" October 2005 PowerBook (don't know the number)
* PowerMac11,2
* PowerBook6,8
and my
* PowerBook5,6

People with those machines are encouraged to use and stress-test it, it
also provides much better hardware support than snd-powermac, for
example it can actually reprogram the hardware if you have a 48KHz file
instead of having to digitally downsample it to 44.1KHz like required
with snd-powermac in most cases.

Note that the big missing feature is headphone/line-in/line-out
autodetection at the moment, so if you rely on that don't use snd-aoa
for the moment.

There are apparently some cases where it loses interrupts and then the
sound is garbled, my brother's investigating that at the moment, it
doesn't happen with my powerbook nor with my powermac.

Note that Topaz chips (optical input usually, though I think there's a
version where it does optical output too, probably the tas/topaz
combinations I heard about) are not supported yet as I don't have any
optical hardware except for my PowerMac11,2 and haven't written any code
for the required clock recovering and switching. If you want to see it
supported (and don't want to write the code yourself) your best bet is
probably to send me some hardware that has a controllable optical
output ;) If you want to write the code yourself talk to me first
please.

But the other reason for writing this mail is that I finally found the
last remaining bug that prevented sound module autoloading! :)

Now, when you boot, mac-io is already built-in so provides the i2s
device, which my i2sbus module binds to. Since udev synthesizes events,
i2sbus gets loaded automatically. Now, i2sbus creates uevents on its
own, with the layout number given as the MODALIAS. Hence, the layout
fabric module is loaded because it has an alias for all the layouts it
handles, and it in turn requests all the codec modules that it requires.
Also, this means that 'modprobe i2sbus' will suffice to get the driver
up and running without a reboot, provided that all modules are
installed.

Have fun,
johannes

--=-wB/tYAI9+58wst9kgTiE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARGr2UaVg1VMiehFYAQIAABAAtaidoI6FVJdhlJpBnVac9Dx6wpcsH/r6
5LulsaDEoBeBg6Ttia9zklbz+lrC2dFD/nT6HTIe8bV8+5weX8AS72owTdujmeLE
ipGS7nna/259zzdRHx09o5887NSk2xQOmHKxXc9ssrnkyMfIjLMfIjiDoHo9xWZV
mJ5dHvrnpkhCCpH8QROHsHpJ4EVPP3/Zpw/DdbdTW+73QCU2Xo/PSwpSIm/8FLF1
AkDGGXyF8ohNIfgls7M4XBESET07u7fPAWcs3/+yL+q7bj+w+9uAYEOMz3VUFWoz
kIcre2ibxngW5o4zRb+XEOwB64dAVeWInOF+B3TDuIAYvcl2cg+MTKeJ1zKnaFZv
6vx7TK328mvOllMXk93e22+ZfQ17Xe0bge68ZbopuVtYXTGBGh9IPVaoGPSa1kKX
zCthJsPYs+xpASjWe5aa4+3xjUY5oUBF51IXR7gshSynlYyRyE5R2IrxEdW2VImf
DHZ6jmxOoAtRWkA1UAGdeCKtP7XxdGPgsDWnRPXzRnhON3yPCuL6VPwsM0j6nplo
ql7PEwbpGshdDdmBXtc20e3yq0W2F/9yjXjHeNqvsUQn+wCHQxNbHO4AjAU/6V0C
Xs3NxiaOI7FzXE6Ych0mHul5izG858cBCweLJgaOBkSj095MiNGucg7HuO/ziRgN
COT4ZQDr4Ag=
=9byp
-----END PGP SIGNATURE-----

--=-wB/tYAI9+58wst9kgTiE--
