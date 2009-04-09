Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EE892DE0F9
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Apr 2009 17:45:00 +1000 (EST)
Subject: Re: [PATCH] AOA: Convert onyx and tas codecs to new-style i2c drivers
From: Johannes Berg <johannes@sipsolutions.net>
To: Jean Delvare <khali@linux-fr.org>
In-Reply-To: <20090408224858.04cb6dc4@hyperion.delvare>
References: <20090408150249.5a62a56c@hyperion.delvare>
	<1239205899.16477.32.camel@johannes.local>
	<20090408224858.04cb6dc4@hyperion.delvare>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-bcXH8uKV4RboVtu//2Qf"
Date: Thu, 09 Apr 2009 09:44:49 +0200
Message-Id: <1239263089.24548.30.camel@johannes.local>
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


--=-bcXH8uKV4RboVtu//2Qf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Jean!

> Yes, "probing" would be duplicated if we had to support more than one
> bus. But as far as I can see, the onyx and tas devices can only be
> found on i2c-powermac buses, so this shouldn't be an issue. And there
> isn't really any probing going on, it's really only a matter of walking
> a small subset of the device tree (the children of the I2C bus) and
> instantiating I2C devices.

Right, it was just an unrelated thought, it's not related to this in
particular.

> > Now, aoa will currently automatically load from the layout fabric
> > module, and then pull in the modules for the codecs it _knows_ to be
> > present on the bus. Therefore, it seems that your patch makes things
> > less efficient because you probe for all those codecs, and there's no
> > machine that has all of them. The aoa fabric only loads the modules for
> > those it knows to be present, and they then probe (and in reality the
> > probing never fails because they really are there).
>=20
> Can you please point me to the layout fabric / aoa fabric? I'd like to
> understand how it works. Then I may be able to rewrite my patch
> completely differently.

That's in sound/aoa/fabric/layout.c

> There are basically two ways to instantiate I2C devices in the new
> model. The first method is to declare the I2C devices as platform data
> and let i2c-core instantiate them. The second method is to have the i2c
> bus driver instantiate the clients. My patch uses the second method
> because I didn't know how to use the first method. However using the
> first method would solve the issues you raised. But I need some help
> from someone more familiar with the powermac platform initialization
> code to get it right.

Interesting. Does it need to be _platform_ data, or could
sound/aoa/fabric/layout.c declare the devices instead?

> > Now, since aoa needs information on how the entire system is glued
> > together (the fabric I was talking about with the line-in example), it
> > has to infer that from platform data, in this case the device tree.
> > Because I do not have any older machines, am lazy and snd-powermac work=
s
> > for the old machines, snd-powermac with its "tumbler" is a driver for
> > the same tas3004 codec, but on a different, older, fabric.
>=20
> I think I've found that one by now (snd_pmac_detect in
> sound/ppc/pmac.c, right?), thanks for the clarification.

That's snd-powermac, yes.

> BTW, that code doesn't seem significantly different from what my patch
> is adding to i2c-powermac.

That would be true, yes, with your patch I don't understand how to load
snd-powermac _or_ snd-aoa based on the platform data (or in the case of
snd-powermac, not load it automatically at all).

> Hmm, OK, I expected the code I moved from the aoa drivers to
> i2c-powermac to only match the subset of machines actually supported by
> aoa. If that's not the case then indeed it is incorrect.

Yeah, that's not the case, I think the 'deq' node will be present on
older machines as well and you would load snd-aoa-codec-tas where
snd-powermac should be loaded.

> > Therefore, probing the codecs in i2c-powermac and automatically loading
> > the corresponding aoa module will break sound on old machines.
>=20
> Does this mean that manually loading snd_aoa_codec_tas today on an old
> system with a TAS would break sound too?

Yes, I'm pretty sure it does on some systems. Actually, I'm not entirely
sure, because I don't know whether the i2c core will prevent two drivers
from talking to the same chip on the same bus, and if it doesn't then
this might still work but it would at least be very strange wrt. suspend
resume.

> Anyway, the key point of my patch is to get rid of the legacy i2c
> binding model, not efficiency.

Yes, I understand :)

> > Since I'm away from all machines I could test this with I have no data
> > on any that or the module device table thing I pointed out for now.
> >=20
> > Anyway, some more technical comments on your patch:
> >  * I realise you just copied things around but it would be nice to clea=
n
> >    up the coding style, especially comment style, a little while at it.
> >    (yeah, it's my fault)
>=20
> I can fix anything you like, just tell me what :)

I think CodingStyle wants
 /*
  * ...
  * ...
  */

> >  * aoa_codec_* is the module name, I see no reason to use that as the
> >    i2c name, that should be the codec's name instead (aka pcm3052 etc)
>=20
> The names are totally arbitrary and we can change them if you like.
> Keep in mind though that we should avoid using mere chip names for
> non-generic drivers. The aoa drivers are powermac-specific, we don't
> want the names we pick to collide with another driver, that's why I
> chose to keep the aoa prefix.

Oh ok, that kinda ties in with my very first question about what happens
if the same chip is known in different contexts, on different buses etc.
Makes sense in that case I guess. But I still think that you shouldn't
auto-load the aoa codec modules based on this anyway.

johannes

--=-bcXH8uKV4RboVtu//2Qf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJ3aduAAoJEKVg1VMiehFYMI4QAJ4mE6VIX3b8GsTCORhfnY5u
I91JZUbD5HCt5NzZa1SlyZthFRxzz84da+z7KchU0FMIRabbDQqesdIx6/XsHBQ8
XE4eIRPpZBmta5ESr5G0yLbRjfmOLiVO8BEcPuzmR0t5NpquL5qWVbqGBwfRMxsd
Cawhk4yH3T+vn7wvOl8lRCgM3ucvLFkqhwQQE38/BlCKY/5irurGAnGstB3EiNE7
BYIpxJ7ueYOl9bPcHlfiuurpm7OHm5U4BCYIIk2EUQxKruLbnukn70ymh38UiFZX
S82IHnQgmxvVn6vNqptqAN6kXIl3E7oia14TenBVCq3RfJjA/uft5a4mwTl2DxU+
IA7VZRoUcVBIEJcW98fCWSk8vk2wx8aUWDcVZ7/RFRSE4tbVCkR+URFQu+osuDuN
tP9+YRXEzD2/UBUjLEdVO3BtzqNRoSEGFKnteCB9bl96RCRssNIrduq8XszVeQfO
Mm9ESdhZWzsu9FVEHTqwydn5Yomgv8XQLM7h5Y0sGd1WsGw9FHa8lnVaVwYAAOx3
bQapr3A/EocPNDdjaFsTBFIVlWhuXsBq59xh8WKl6n3mkwVnfg7B48rohjJe0Dvu
L10cZCShVhoTi1o5beTv7+O+bOVgWNFHd3zyteI3A1pcmW20nqluG4T7nO6FQgEA
aARwZxSEtmGhMVymPO7E
=0lKx
-----END PGP SIGNATURE-----

--=-bcXH8uKV4RboVtu//2Qf--
