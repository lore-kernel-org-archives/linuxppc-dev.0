Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A2F6D67B33
	for <linuxppc-dev@ozlabs.org>; Tue, 23 May 2006 22:28:20 +1000 (EST)
Subject: Re: snd-aoa status update / automatic driver loading
From: Johannes Berg <johannes@sipsolutions.net>
To: Hollis Blanchard <hollis@penguinppc.org>
In-Reply-To: <20060522221138.683790c2@diesel>
References: <1147860564.14395.6.camel@johannes>
	<20060522221138.683790c2@diesel>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-adQVexOb3aRjNRIT1Szh"
Date: Tue, 23 May 2006 14:27:52 +0200
Message-Id: <1148387282.25971.8.camel@johannes>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-adQVexOb3aRjNRIT1Szh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-05-22 at 22:11 -0500, Hollis Blanchard wrote:

> The "auto-loading" stuff doesn't seem to be working for me on my
> PowerMac11,2, with a fresh git clone as of right now. What is the base
> module that should load all the others? After a "make install", I still
> had to modprobe almost everything by hand (`find ./snd-aoa -name \*.ko`
> in the source directory to get a list).

Odd. i2sbus should pull in all other required modules, and should itself
load automatically at boot due to having a modalias that matches the
of:... modalias the mac-io bus device for the i2s stuff has.

> snd-aoa-codec-tas: found keywest-i2c-bus, checking if tas chip is on it
> snd-aoa-codec-tas: created and attached tas instance
> snd-aoa-codec-tas: found keywest-i2c-bus, checking if tas chip is on it
> snd-aoa-codec-tas: created and attached tas instance

Uh. That one I need to check, there is no tas codec on your machine.

> snd: Unknown layout ID 0x44

That looks like you have snd-powermac loaded too. Or not? I don't think
I have anything that prints "snd:" as the prefix but I might be wrong.

> snd-aoa-fabric-layout: found bus with layout 68 (using)
> snd-aoa: fabric didn't like codec tas
> snd-aoa: fabric didn't like codec tas
> snd-aoa-codec-onyx: found pcm3052
> snd-aoa-fabric-layout: platform-onyx-codec-ref doesn't match!
> snd-aoa: fabric didn't like codec onyx
> snd-aoa-codec-onyx: created and attached onyx instance
> snd-aoa-codec-onyx: found pcm3052
> snd-aoa-fabric-layout: can use this codec
> snd-aoa-codec-onyx: attached to onyx codec via i2c
> snd-aoa-codec-onyx: created and attached onyx instance

Most of this is due to that device-tree bug on those machines.

> For the record, there are two "layout-id" properties in my device tree,
> as discussed in this patch:
> http://patchwork.ozlabs.org/linuxppc/patch?id=3D4867

Note that the patch is mine :)
But also note that this isn't the reason that there are two layout-id
properties, there really *are* two sound nodes with layout-id property
because there are two i2s busses for the two codecs.

> Ultimately, snd_aoa_codec_onyx seems to be the happy module. Only the
> headphone jack was enabled; I had to use GNOME's "Volume Control" panel
> applet to enable speakers or line out (both of which work).
>=20
> However, volume control doesn't work at all, for both line-out and
> headphone jacks. Should it?

Yes, it should. I think the bug is that the tas module thinks it can
attach a codec here. Can you try *not* loading that module and see if it
works better then? I'll try to see if I can make the tas module not
attach on those machines, but as long as you don't load it manually all
should be fine.

> Also, it would be helpful if the git tree were better publicized
> somewhere (e.g. http://johannes.sipsolutions.net/). I had to dig through =
a LOT of mails to find the source.

Sorry. I linked it up on http://johannes.sipsolutions.net/Projects/ and
will add a few more details later.

johannes

--=-adQVexOb3aRjNRIT1Szh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARHL/xaVg1VMiehFYAQI35w//QLL6mc2AZ2D1T7BxqX8wNefco93WYJe2
p+G/tjqV0P5t9hxE6xnXomop9OE+PFrDTpPZKWrE+fAT0Y5NddaCNIgi1RQB8R3w
y6Zrc9mjp4SHJL38V8ZmAz6Y90tAyGQptI2aak5OdBlUWqAJDTIuScc5eaxo9Rqs
SXuaicWn37aUK2cjBHRheZHd5JIdlBSY+5SYv0zBURc6eOkaoZloUAZy5ArBZHtc
ffhkj4M4P2G6eLKJCD1VXyCG42T9OpT05MOteXIimWRJ+/WVGHoy8WX95Wy8RFDm
9AWcVavvDyEOr1R+4q9FiyljmXm8h+ZfvTawbzp70Pt48/rkXHS8Z57VerM4yscC
6o+TjI8fdL4R/pUlOpM6dEl1k1ypDx35WfqIb+mYXtvcCSHMZf5JgVhdLGQOokZB
2Uh+Pl/21BcOgVi6KHHvMFgGbmE31+k5YCY7boJD4U4ady0pLwloiJAlSApnit5R
d5m7vaJsDE+h/Huk9+ScLLzkMmjuapT58/0Tq3aqtjDX23sOPsEXJAG0IEFAp6n2
6OkFedthyGxl0z1DJ7zO+bVS2QNBX60V5p21k7nbL1wdzeTQ8UwTfjNV+Eb4VKWx
kRbIouLl9yVJRCLNegSOo72t3RfaahS00LiiJqbwLtcztRTICQHmdUJ0uySohsX6
w9FT3QEFNd0=
=goaM
-----END PGP SIGNATURE-----

--=-adQVexOb3aRjNRIT1Szh--
