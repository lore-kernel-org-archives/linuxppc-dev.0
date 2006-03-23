Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (unknown [213.151.39.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 90C2E67A5A
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2006 04:13:47 +1100 (EST)
Subject: Re: new sound driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1143064237.3823.29.camel@localhost.localdomain>
References: <1143020119.11724.41.camel@localhost>
	<1143064237.3823.29.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-YtJskgHYWUARV0yPRCwV"
Date: Thu, 23 Mar 2006 18:13:37 +0100
Message-Id: <1143134017.8395.19.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Alastair Poole <netstar@gatheringofgray.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-YtJskgHYWUARV0yPRCwV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-03-23 at 08:50 +1100, Benjamin Herrenschmidt wrote:

> that would make soundbus totally pmac specific, in which case you should
> call it aoa-bus or something like that.

Yeah, well, I just did it differently now with the dbdma stuff done by
the i2sbus objects.

> Regarding your previous question well... I think the soundbus can create
> the pcm streams. Alsa has 2 levels: PCM objects and PCM substreams. We
> need the former. Substreams are used when the harware has several
> streams that are hw mixed to the same mixers which isn't the case with
> apple layout. When we have multiple i2s busses, they are really
> independant with separate codecs, frame rates & formats etc.. thus
> separate PCM objects.
>=20
> I think the sound bus should create the PCMs. Now I don't remember from
> Alsa API but do we need to know the available rates in advance ? In that
> case, we may want to have the bitmask provided by the fabric (from the
> layout array for example).

Right. I was still confused on the notion of PCM streams vs. objects.
Got that sorted out, and yes, it is creating pcm objects.

> I'm also not sure how Alsa handle changes there. For example, if you
> plug a digital input, the entire bus where this input is has to be
> clocked from that, thus limiting dynamically what rates/formats are
> available. I'm not sure Alsa API can cope with that yet.

Well, if we're unlucky the Alsa API must just return -EINVAL to users
trying to use other bitrates, if we're lucky then it copes better ;)

> > Actually, this isn't quite possible. On the newer machines where you
> > have two codecs on the same i2s bus, we need to have the layout fabric
> > create the one pcm stream and have it ask the codecs what it should
> > advertise. Then it needs to advertise the lowest common denominator of
> > the multiple codecs... (Or can alsa handle pcms that change their
> > supported rates/formats?) Then it refers to the soundbus functions for
> > actual data transmission.
>=20
> The problem is that codec objects have to be created asynchronously
> since they use asynchronous i2c discovery. Unless you instanciate them
> all but simply mark them "offline" and then mark them "online" later
> when the hardware actually shows up. That is fine except for .. topaz
> where you need to access the hw to know the chip type, thus you can't
> really know everything you need early enough (or maybe you can ...)

What I'm currently thinking of is creating one PCM per codec, and then
if you can't use them at the same time just forbid access to it.
=20
> Just sleep on it for now :) We definitely need a "core" module that
> handles all of the gpio mess. ..

Yeah. Haven't even opened that can of worms yet...

johannes

--=-YtJskgHYWUARV0yPRCwV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARCLXPaVg1VMiehFYAQIhuA/+IiZFIoQJTw1enYFGr0euAPdL1Oe4I7Y/
T0A/eeMBo6MyBD4g2wY2z9Q0PjvcwyZTPEP2O+W6fQfvg81MyBf58usRdiS1gJIy
YfcFtoX4LzKYs0/qPet1I8F/5x+DqAevznAkLop7SD3CjEghvYBejxN0QvamAgyD
TEDEGTd1xqnffoqlo05ja5lvceZlcJAwn6epb4ymVVtmySHtF36VVVuKr12z0zMm
k3ObCh48viBZa3GbV+WrLdpKeXJLeJdfEO9xt1kQpwim67HMPT1KUtUUXSTMw8m1
0fb4KSeLZdQpNueFTZ/CO0t7byhnj5hNXNAU9pgTf8JQjeTg74YDkUOmvDSQAXS4
WoOYTA28hGgChRy1XHnSih+K88lRM3v2a+W6Hw56m+mH7PXQEalF14I+vtJwfwue
AF53PVT8xzpU8QmXxUr0nPsxdAcyOiyAqEYGYTEEU1wUad3sMmsJsIW2tVkl1KGY
FnP3nPHeDZMg9rQGmrjF23UYRo26DQlN/eUxm7atYeHdDxQRb3lSYKo3bd8+6izB
zloaH9YnecrRiJqogp69ulBqzmrDhBYbwmNjFF3Nlmwh1De5qBoyoAuxwMNybRjR
vkxKd2jL+QwGBJr3PaLbVU1BxpBpG0IZcR5wqfbuVMnlOg8akrke8Y/z5NE+cEjg
47lBBiNutF4=
=Ia8L
-----END PGP SIGNATURE-----

--=-YtJskgHYWUARV0yPRCwV--
