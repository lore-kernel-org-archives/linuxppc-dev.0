Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 80C1DDE03F
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 08:00:37 +1000 (EST)
Subject: Re: [PATCH] AOA: Convert onyx and tas codecs to new-style i2c   
	drivers
From: Johannes Berg <johannes@sipsolutions.net>
To: Jean Delvare <khali@linux-fr.org>
In-Reply-To: <20090414214949.736597d9@hyperion.delvare>
References: <20090408150249.5a62a56c@hyperion.delvare>
	<1239205899.16477.32.camel@johannes.local>
	<20090408224858.04cb6dc4@hyperion.delvare>
	<1239263089.24548.30.camel@johannes.local>
	<20090409141945.116772e3@hyperion.delvare>
	<1239723613.24771.8.camel@johannes.local>
	<1239724227.24771.9.camel@johannes.local>
	<1239730915.24771.12.camel@johannes.local>
	<20090414214949.736597d9@hyperion.delvare>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-6JVP1Ggw0mOQUSIbJ9Zf"
Date: Tue, 14 Apr 2009 23:59:59 +0200
Message-Id: <1239746399.4205.21.camel@johannes.local>
Mime-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-6JVP1Ggw0mOQUSIbJ9Zf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Jean,

> Thanks for the quick test and sorry that it didn't work. I'll take a
> look at the trace below and try to figure out what went wrong.

No worries, seems some error path is going wrong but I can't see what it
is right now.

> Did you remove the 2 MODULE_DEVICE_TABLE from my patch? If you didn't,
> please pick the latest version of my patch which doesn't have them:
> ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-=
i2c/sound-aoa-codecs-convert-to-new-style.patch
> I don't think they are the reason of the crash, but who knows...

No, I didn't, but I was loading the modules manually so that didn't kick
in.

> Are you using a machine with onyx or tas? I guess onyx but I want to be
> sure.

onyx only.

> > [   10.267137] snd-aoa-codec-onyx: found pcm3052
> > [   10.267238] PM: Adding info for i2c:2-0046
> > [   10.267926] snd-aoa-fabric-layout: platform-onyx-codec-ref doesn't m=
atch!
>=20
> Does this error also happen without my patch? It would help to see the
> logs without my patch to see where it starts diverging.

Yes -- this happens normally.

> > [   10.267930] snd-aoa: fabric didn't like codec onyx
> > [   10.268041] aoa_codec_onyx: probe of 2-0046 failed with error -22
>=20
> Apparently aoa_codec_register failed in onyx_i2c_probe(), I have to
> understand why.

Because the device-tree is broken -- there are two nodes for the same
device, and only one of them can be used. Then the fabric rejects the
first instantiation from the broken node. Here's how it looks normally:

...
[   10.398296] snd-aoa-codec-onyx: found pcm3052
[   10.398472] PM: Adding info for i2c:2-0046
[   10.412189] snd-aoa-fabric-layout: platform-onyx-codec-ref doesn't match=
!
[   10.462593] snd-aoa: fabric didn't like codec onyx
[   10.468030] PM: Removing info for i2c:2-0046
[   10.473892] snd-aoa-codec-onyx: found pcm3052
[   10.479317] PM: Adding info for i2c:3-0046
[   10.485631] snd-aoa-fabric-layout: can use this codec
...

johannes

--=-6JVP1Ggw0mOQUSIbJ9Zf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJ5QdcAAoJEKVg1VMiehFYX8gQAJSyv5CfQ6sujVv6m532v6Ao
TA2DL/PkjFMF9q2uIWlvRTTDkTKDrBXJzRibLZ8FGxaPCc2WfsQ7a1dJ62MTMXbR
3QXXDN2DFggIajq2NKA1KuXAljKAEZx7PLseAw/WSYiXdhGXq6uPoSmMLptYvBQe
WJ5nc36fhQhEmVadELz9LLb57SM5g9/33/yX2ttnh9Rr2b874O6x/Dy21Up32ZEw
c0IXH1Q+VfcgYTpvgZGq5kGhZmdptUp/mQcHw/4PzUGW4O5OM2IzBQ0vhbXhOXJz
v+EJekuPYHbO/878X7x1+Vyc+XnHmRwuAEr3a0YSTUSUb0gaWIVv4zqCo8M++Smj
MfvFrljqDBlA6AJ4kjyoSOqeluZ03MfXemfb/Pj4oQuBIjTNQBDfEp9HW41HtiMN
HTH4gN8yAY8tdhSsLUmTrv9kEAff8fNleeAaZMRSs044kWQvYkaiZy2YO87NKdQh
MydX5BXoAmGCPBFnK9O4qxyRbj7/o5dNDFc9gH6y1hfues/fEajZaFBTJOQ3qaM3
qv4ZeixdfrRD641i4LmFWZduMoITMw9IsO50HkM0OYZ+EbK9YTro9iDVe1310nJQ
qd96OugSNYPnEsd61doi2prgWn4L916ZQrtbRam7XBnVi48vE81rWKIEzLvVVjU4
IqMtUxgZidxws3L4SVxN
=ulXN
-----END PGP SIGNATURE-----

--=-6JVP1Ggw0mOQUSIbJ9Zf--
