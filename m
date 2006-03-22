Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (unknown [213.151.39.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B9141679E6
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Mar 2006 20:35:43 +1100 (EST)
Subject: new sound driver
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-AuTxo6Lr31iGXgftC2Sg"
Date: Wed, 22 Mar 2006 10:35:19 +0100
Message-Id: <1143020119.11724.41.camel@localhost>
Mime-Version: 1.0
Cc: Alastair Poole <netstar@gatheringofgray.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-AuTxo6Lr31iGXgftC2Sg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

After considering the code a while I decided that snd-powermac needs to
be rewritten. Ok, kidding, I didn't need to look at the source for
long :)

So I started to rewrite snd-powermac as snd-aoa, which I currently keep
in a git tree at http://johannes.sipsolutions.net/snd-aoa.git/

I will need a bit of help, so this email is intended to solicit that,
and to get some input on what everyone else thinks about what I've been
doing in that code.

Let me start with a brief layout. To those I've talked about this
before: please read again -- I significantly changed what I'm doing.

Since Ben says that he wants to be able to handle really old stuff with
the new driver too, I first created a virtual 'soundbus'. This is in the
module 'soundbus', and doesn't yet have any functionality in itself but
providing the driver model bus object.
I then created an i2sbus module that grabs all i2s devices from the
macio bus, enumerates their children (i2s-a, i2s-b etc) and adds them to
the soundbus.
Obviously, we'll need to add more bus backends there.

Now enter snd-aoa: snd-aoa has a rather generic architecture where the
core just initialises plugin code for different ways to find sound codec
chips. Currently, only one way is implemented -- that is going off the
layout-id property. This part (snd-aoa-fabric-layout.c) is a soundbus
driver and attaches to all soundbus nodes that have a 'sound' child with
a 'layout-id' property that it knows about. The list is encoded in
snd-aoa-layouts.c.
Plan is to make the fabrics and the codecs into modules too, but this
isn't done at the moment. Shouldn't be too hard, and should probably be
done before writing any more fabrics or codecs.

Anyway, back to what happens. Now the fabric module detects a layout-id
that it can handle, so it then goes to instantiate the codecs. Right now
I only have an onyx codec there. It tries to attach to the i2c control
interface (using two methods, but for that refer to the code). Then the
codec creates the alsa mixer devices that it can handle, using some alsa
helper code (snd-aoa-alsa) that manages the alsa card object.

That's about it. It can mute/unmute and control the left/right volume,
so it might work if you use both this and snd-powermac...

I had planned to actually get sound output working last night, but that
didn't turn out since I ended up rewriting all the lower levels.

So let me just say what the immediate plan is:

Firstly, the soundbus objects need to be able to handle data
transmission. What I'm not too sure about is how the API should look
like. I'm thinking that since all objects there are actually sound
objects (well, there's the modem too, but it can get an alsa interface
too), the soundbus objects actually get to create the alsa pcm
interfaces, somehow helped by the codecs to select the valid rates and
formats. Or the codecs create the alsa pcm streams, but refer to
soundbus object functions for handling the actual data transfer. I'd
like to push as much of the interface into the soundbus object as
possible. At this point also the question of how to program the dbdma
engine best comes up. I really don't know, because I don't quite
understand the alsa pcm api.
In any case, I'm thinking of putting dbdma register stuff into the
soundbus module and adding dbdma data to struct soundbus_dev.

Actually, this isn't quite possible. On the newer machines where you
have two codecs on the same i2s bus, we need to have the layout fabric
create the one pcm stream and have it ask the codecs what it should
advertise. Then it needs to advertise the lowest common denominator of
the multiple codecs... (Or can alsa handle pcms that change their
supported rates/formats?) Then it refers to the soundbus functions for
actual data transmission.

Another thing that needs to be done is teach the layout-id fabric module
how to handle all the dozens of platform functions and publish those to
alsa that make sense to be set by the user (like line out select etc.).
Then also register the interrupt ones and handle them appropriately. The
codecs will need to be notified on changes/interrupts though, since in
some cases things need to be switched around there too. This is just a
matter of inventing the right way to find all of the functions...

Whee. I was going to write more but for one it is already long enough,
and I also forgot what I wanted to write :)

johannes

--=-AuTxo6Lr31iGXgftC2Sg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARCEaVKVg1VMiehFYAQL+1w/+KWdU6B2ef+yYSk/w5tFbuvRtVbalcP1c
clokgGMpMqVT0t+TnOXXKls7iFq2xTBEk5NMJBh9ua+wZOxg/iHXinCyEDD2hx5Y
7EW3Q/5drDqE0smtFSIyxToBIIvyAd2fasn+dFhI65ea8GmcqGSRmzGNVLHSPHK/
SUBokDn1SNAVKr1/EabBIOVOxb8L72mTSDEJZ5OOn7FwSxLVBKCzSNoHnSlb+hVt
33oOTlP587gq0R8Din0As8CNFsFUH1Ly65Q+MluSNgYx8ko9fCc04wNnrvTGeOex
yAIui36oAScZQv06EmW+btMmFopMm7E6oJjYFUv1Y4mP7w2N/A3sSLKtApu1Zm30
Jg0gAb8G2mRRPiBARFeKivwKY2Cshru8no6sDwT9i5tZ29JPYdRnvmZiO7Y5GGLg
LA0YquDir4mEPECqAcr7cOkSoEB0SkCmGdi4GriIpvNmDHqodHw3RQs8oQijWGav
/8hGBCpJC4e1+qVqHErXp8rNchIlxBOtl9D6F1zkALFxzklT70TXBtOMVm0sZJLl
OrmS6NAPUe2L3nq3brPSBiCWG22717Wwc5WAwNIUkq4xr5XyEBfb8pKi/gNQaaXz
XtNO/IVR0m/V8hCFi5Rqt/JW1Q60TeJMeK/7aPgOWWZDARr2Tepjsg3giXmKO5Tj
tqDCqidpIfo=
=yOYP
-----END PGP SIGNATURE-----

--=-AuTxo6Lr31iGXgftC2Sg--
