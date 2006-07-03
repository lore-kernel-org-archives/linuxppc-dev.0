Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D98E6679FC
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Jul 2006 23:31:10 +1000 (EST)
Subject: Re: sound connector detection
From: Johannes Berg <johannes@sipsolutions.net>
To: Dmitry Torokhov <dtor@insightbb.com>
In-Reply-To: <200607011609.59426.dtor@insightbb.com>
References: <1151671786.13412.6.camel@localhost>
	<200607011609.59426.dtor@insightbb.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-PVFLRZH4A1JZ/0hZMsOG"
Date: Mon, 03 Jul 2006 15:30:14 +0200
Message-Id: <1151933414.20701.38.camel@localhost>
Mime-Version: 1.0
Cc: linux-input <linux-input@atrey.karlin.mff.cuni.cz>,
	Richard Purdie <rpurdie@rpsys.net>, alsa-devel@lists.sourceforge.net,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-PVFLRZH4A1JZ/0hZMsOG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> I am not too happy with putting this kind of switches into input layer,
> it should be reserved for "real" buttons, ones that user can explicitely
> push or toggle (lid switch is on the edge here but it and sleep button
> are used for similar purposes so it makes sense to have it in input layer
> too). But "cable X connected" kind of events is too much [for input layer=
,
> there could well be a separate layer for it]. If we go this way we'd have
> to move cable detection code from network to input layer as well ;)

I sort of see the point. But I think it is indeed unfortunate that we
have all these events scattered throughout. I could live with the
current approach abusing the alsa mixer API, but there's little point in
making that element user-visible. So maybe I just need some new alsa
definitions here.

Although, come to think of it, a daemon keeping the mixer open blocks
unloading the module. I suppose I'd rather have it the other way around
like the eventdev system does -- the device goes away and all reads to
it fail.

johannes

--=-PVFLRZH4A1JZ/0hZMsOG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARKkb46Vg1VMiehFYAQJnlA/+JdhQWfauif68lgvDBj49O+G2QI9zUfXB
+x1QcFfQAsloL2fpBpcTMbeCEwuVyQSMn4apoBeBmH3K9iT1DVkRiOrP8tKwcog7
6KVlkwrxUVda3u8ZiWZS02OZRbgiK2XA/3Is2gE/k1DhDPxLRVvR9LSAy5DBizsE
q2lz8qIqWhm8RmtZE3Hc9l4jb9C13fTa1fw9XhSg9gxoFRfuhF0N/9pdGPlaahaU
V1pv3yTlEeOePItlstjfsfp8JsBJGOaa3cVS3IddXuviBHT33CgcRN0zgtD6ixgj
kPUEZ/FgHRELAZdUExZyj3J+QKA8UBXUMSgfifWtSOUscxvb4og3BHO5MIeRHxBB
YxxXzxXsbOzP/4EN3aIDz2AOMMG6h2TT9WKbMTGD8TGp5MSZvdypTjIFHLK1jX/l
q/4kjaPitpNRjqeCNBWb3lan8awDdJFxJCXMrd7mxbVST1ZEFC0dThCQ6SRymvo0
RPfoICSKMcbZYaIsNkm37aOgbvtdjAZEzodxVGj1YTyqLCbByvKf29u8f9ksJNEG
ADu2tZHihzKNy+p53KY0Gyr/IJ3v1Ih6ZRwBjSdpipmp2RJ3seJF7X/VQuIVJnlF
gPnYxMwupR57lUki7vgwACqsSSBh2Hvqh3DcT0+zbrjM1PIp2msMPkGNCEJdWgci
1ai2kyiTaHU=
=j9iO
-----END PGP SIGNATURE-----

--=-PVFLRZH4A1JZ/0hZMsOG--
