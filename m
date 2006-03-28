Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (unknown [213.151.39.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7BFCE679F9
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Mar 2006 23:10:43 +1100 (EST)
Subject: snd-aoa: new apple sound driver
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-9JIUpAu3hGIzK3zHoRx1"
Date: Tue, 28 Mar 2006 14:10:26 +0200
Message-Id: <1143547826.13615.24.camel@localhost>
Mime-Version: 1.0
Cc: debian-powerpc <debian-powerpc@lists.debian.org>,
	Alastair Poole <netstar@gatheringofgray.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-9JIUpAu3hGIzK3zHoRx1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I think I accomplished most of the things I wanted to accomplish now :)

snd-aoa is now split into a core module and snd-aoa-fabric-layout,
snd-aoa-codec-onyx. I'm going to write a snd-aoa-codec-tas3004 soon, so
that I can use the new code here on both of my machines.

What's left to do? (in order of importance to me)

Locking. There are no locks at all and it still works! Locking shouldn't
be too hard, most things are implicitly serialised anyway, but there
definitely must be some locking. I'll revisit that, but probably not in
the next two weeks. Other sets of eyes always welcome.

GPIO stuff. Currently, the only GPIO I touch is the amp-mute one to turn
on the internal speakers. This is done in the onyx codec module which
obviously isn't the right place for it. This should be moved into the
layout fabric module which draws on some common gpio code to program the
GPIOs. Then it creates controls alsa for amp-mute etc. instead of
unconditionally turning it on, and also registers the interrupts for
headhpone detection etc.

Clock setting. I'm clueless as to programming keylargo in linux. Thing
is, I need to stop the clock to the i2s cell before reprogramming it's
serial format register, and this requires access to the FCR registers.
But I don't know how to get at them best. Need help here. Clock setting
also includes running the i2s cell in slave mode so we can have digital
input. The infrastructure for slave mode isn't too established yet, but
it should be easy to fit it over what is currently there in
soundbus.h/i2sbus.

Modalias situtation. I played some tricks: i2sbus depends on soundbus
but announces its willingness to be bound to the i2s OF thing that macio
exports on its bus, so i2sbus is loaded automatically. i2sbus creates
some soundbus devices that have a name based on the layout ID if
possible, which should in turn auto-load snd-aoa-fabric-layout which
declares its willingness to be bound to such devices. This doesn't
happen during boot, even though modprobe `cat ...../modalias` works just
fine. No idea, need help from someone versed with hotplugging.
But hey, it's already much much closer than snd-powermac ever was ;)

Recording. There's code to record sound, but it doesn't do anything on
my machine. I have no idea why.

Suspend. I have a plan for it, so before thinking about it you may want
to look at some old revisions of my code where a huge comment about
suspend is buried in soundbus.h (I removed it again because it wasn't
quite right any more, but still has the essence of what I intend to do).

Onyx digital output. Currently, onyx always declares that the digital
output is usable even if it is turned off, leading to a restriction in
the output formats you can play. Note that due to 'clock switching'
above, you can only play 44.1KHz currently anyway. But Onyx should make
that depend on the status of the control, and then lock the control if a
bitrate was chosen that isn't compatible with the digital output.

Make i2sbus compatible with old machines. I wrote i2sbus for new
machines only, it relies a lot on stuff that older machines may not have
in the device tree. So someone who has older machines should look into
it and give me patches.


Now, that said, it's actually working fine for just playing sound on the
internal speakers now :)
The GPIO stuff should be a fairly low-hanging fruit so if someone wants
to take it...

johannes

--=-9JIUpAu3hGIzK3zHoRx1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARCknsaVg1VMiehFYAQJOjw/6AxHbiw0AP8CzmyOu7t8mT/tRAjRkstW1
Ez7FebB/kSwHMNKNK9HX73ToWXfbgnqt7MLfIZHb7zDueHzGQ+R3Ea4J4Ewl8T1t
p73jVTFsc465Dl44hMD6VliSu30xAVZnkcwsoEmCC/pcPgsH8wg6E287h/xi3xAJ
4PpSbs153b7DVS4DoNe6wOl631YKnTfQh21E58p8qSz5RiCykkSY3txmuxAiVpuS
Xp8zsJyG50K0a3TT6kxnDhGLhC8Q9/8h//dyChu0JqNqoAtPFwHXIhR3XeZDEZeR
Mgb+LQYQqQMNfHFn72T3ivaXHqEc455FufLWFy0xcrj+pAh/1Pm0mDpdZ4m44OYh
MRKdUSJo8UwY84LEhKxt6WKQXByfqD73kntD7Ahq/EW3aPY9PujseoVZoicJU7yZ
/A0ZagzPXctujt53uNoHxkNgm/nQWIKepaxdpWM+N5H13s74jchJv//QaKAOcs4V
t5KHmn4XVejWO4zSwHHDdp3mNFXzwp1uh8Hpwe9gWMYoNShW7g+DcrPNg6yh8TPS
3a0ZpEvHRNouJEZVcydZkj+j58Wo9s3zZott+DGSLCZxH8HVK1eRSk0vDO4mf1kx
DsOdqd7nPrBXy/k1oKZhSHw/1Pe+VHdHQIaCM4jt9ia4/Ry4k3OPmuBRJLXx2a2L
B0GHFk5p/QA=
=c1ZY
-----END PGP SIGNATURE-----

--=-9JIUpAu3hGIzK3zHoRx1--
