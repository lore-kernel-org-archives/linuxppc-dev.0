Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B219467B5C
	for <linuxppc-dev@ozlabs.org>; Mon,  1 May 2006 19:25:20 +1000 (EST)
Subject: Re: [PATCH] convert powermac ide blink to new led infrastructure
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1146474648.30710.48.camel@localhost.localdomain>
References: <1146235779.19164.109.camel@localhost>
	<1146237326.19164.111.camel@localhost>
	<1146466608.30710.36.camel@localhost.localdomain>
	<1146473959.24172.4.camel@localhost>
	<1146474648.30710.48.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Df9ndwETYjlc3SVFkHOH"
Date: Mon, 01 May 2006 11:25:13 +0200
Message-Id: <1146475513.24172.10.camel@localhost>
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


--=-Df9ndwETYjlc3SVFkHOH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-05-01 at 19:10 +1000, Benjamin Herrenschmidt wrote:

> Yes, there is a callback, that's the "done" function, but you can also
> poll/check on request->complete though in this case, polling is not
> recommended, the LED stuff should be as low latency as possible.

I suppose then what I'll do is request a done callback, and when an LED
update comes in while not done, just save it into a new 'next state
should be' variable, which is compared when done so that at worst I
loose events, but not the final status.

Can I use pmu_request from within the done callback with the same
structure? Probably not a good idea right? I can schedule_work then.

johannes

--=-Df9ndwETYjlc3SVFkHOH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARFXT96Vg1VMiehFYAQIljg/+MIDC6GWyUVmc+bIRj4oXdyZ5OSLE8ir8
lkY/u9/4p3AiW4+1Fr15NHq/JvDr8LxH6lTcIR34yahpydfHSdYDYh7NQx9L8RCY
T5+dit9ZnJm0823rW/ka5De237RdKEVDiLmwUbFi/XutdwtKzxT6Z3vdhWT41K5K
YJDVaxDckWqFIscHivv4ty8IoT8cyfwOrI6ZUc7SvPiWkU+gopQBW5ilt30MYWW1
FQEVw/0efWsQ6RkTqkcWKRmpd3BCnSvFzugimOGIuXqAemySJ6ZVD3HPqvtzd4wa
hFe3SfwiBFbKXUEmP0biWglUlRnDSj8tPnL9O2GuWItEXK237oGLR28mNufck3gY
T4BpVbCeZid9oDjL7yMFhxAJMyHM/4Yw4atphUjOn2u/u+++sZ7QaoG9aSx6fUT+
9wFonpqxSDyLUHR7WR5XNRaylLcqsR0kFmkTxvBDgcgsQ8V2yY4SVzB+1v7aur2O
iMKI7BlFAgLRWRygyjfXVsPmaX8kF/s+z3wI9IFVG3yxxS1fXorVbkdm7mR2y5Mk
TVHxnUWO3+nw3cWD7NieqivreSc+0GVtnwzzNNF2cFz08kkwlZQe1Mpu1HvpDGPp
EON2Dh366JKxYsuyF+fB0fsy074H97qoNsCvxwZnzxOOidcgtO2yZb2RFPdOh5gD
a8eUrJDR0ro=
=YUQ6
-----END PGP SIGNATURE-----

--=-Df9ndwETYjlc3SVFkHOH--
