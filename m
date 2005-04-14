Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (sipsolutions.net [66.160.135.76])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 61F7467B5E
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Apr 2005 22:56:10 +1000 (EST)
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1113113792.9517.476.camel@gaston>
References: <1113113792.9517.476.camel@gaston>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ix/IDBPL7bIg3nVUeOyP"
Date: Thu, 14 Apr 2005 14:55:44 +0200
Message-Id: <1113483344.5614.17.camel@localhost>
Mime-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: [PATCH] pmac: sound support for latest laptops
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-ix/IDBPL7bIg3nVUeOyP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

> This patch hacks the current Alsa snd-powermac driver to add support for
> recent machine models with the tas3004 chip, that is basically new
> laptop models.

So this works, but is incompatible with gstreamer. I took it with a
rhythmbox/gstreamer developer and he said that it's a driver issue. A
gstreamer log is here:
http://johannes.sipsolutions.net/files/rhythmbox-alsa-debug
(produced by GST_DEBUG=3Dalsa*:5 rhythmbox 2>&1 | tee logfile)

He also asked me to try
$ gst-launch-0.8 sinesrc ! alsasink device=3Dhw:0

which yields:
RUNNING pipeline ...
ERROR: pipeline doesn't want to play.

So the conclusion was:
"set_periods_near ioctl does something weird"

Any ideas?

johannes

--=-ix/IDBPL7bIg3nVUeOyP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iQIVAwUAQl5oTqVg1VMiehFYAQL6xBAAlEnplTi3aRE2i99HrYvmVEYa9/yAcb9g
2JyEZtcOQyNhLPzyqtWeJe3Kq29U6saB6V7xJI9eEO+wRtrWkzmY/x2dJKHg094s
kaL78b0gqwSQzXg/rzBpxVrY8Wus1CQinC5JIsqkB5dlYpZCd1WVs5LuQN31cQgO
SNs7Uglia04ucAdH7AawwDl4PSwzXtHRYjxgwE32vsuCzp5a2eYsO8X7bKvoO/ld
JREyzbWfuCdBZ4pSlD+spUXakQp+kSEGR3MIu1q5/6Xye4iy6eEcoWw1TvSp2vMS
71OSm+0xZehwBF22/FWEZ3CPoHarRx2Fxmu8WN71cnA+ErrMA7w95kSiXk/2d6RX
z9XB7AQ8ewrM5r2JYnBtdjThYCdtF2wrH1XzfoIcNNemBaAWzoTmKi+ecWbKLG3/
ODTDg7uhKk/mHrszZ8TujzjkFcjeVvileU81mBdEz/Sz9DtlLuE7lTT+I/EkIRcL
PkfzaNt4iZy6Ai3IunCfRC/c42pIc5N75UVO1LkopXm9WS89Zu+U08v/yeP1F3uI
kpRO8QmarQc6aacpJYYkTskVDvwhLpK/xBMDyCK5bKU+usGxdHggVTES/clTtDya
DGpsMm9nkyVmGmQwCeV+oyeDKWzi+t6gNp5He+2Gy3SHer1cepMcEsPy0IaVEfqg
kysI3ZP+O7U=
=YwOt
-----END PGP SIGNATURE-----

--=-ix/IDBPL7bIg3nVUeOyP--
