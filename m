Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6064CDDF4D
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 09:13:32 +1100 (EST)
Subject: Re: [PATCH 1/5] powerpc: generic time suspend/resume code
From: Johannes Berg <johannes@sipsolutions.net>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
In-Reply-To: <Pine.LNX.4.60.0703192236420.10137@poirot.grange>
References: <20070319105352.771599000@sipsolutions.net>
	<20070319105357.964696000@sipsolutions.net>
	<1174315651.5044.4.camel@localhost.localdomain>
	<Pine.LNX.4.60.0703192236420.10137@poirot.grange>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-OtkDVmBafBjmmhLieuz/"
Date: Mon, 19 Mar 2007 23:11:26 +0100
Message-Id: <1174342286.22561.25.camel@johannes.berg>
Mime-Version: 1.0
Cc: David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-OtkDVmBafBjmmhLieuz/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-03-19 at 22:51 +0100, Guennadi Liakhovetski wrote:

> Notice also, that my linkstation suspend patch in its present form also=20
> uses the previous version of this patch from Johannes', but I'd rather=20
> delay its acceptance upstream and directly go for the ultimate solution.

I just posted a whole other series of cleanup patches that depend on the
removal of the arcane pmu notifier in the timer code. I don't see the
point in holding that for much longer just because there's some big
structural change possibly coming up for the rtc code.

It's not just the generic RTC suspend code that is relevant but also the
ppc_md rtc hooks, ultimately they probably should be removed totally
once powerpc completely migrates to genrtc everywhere. In the patch you
showed me to this file you actually circumvented the ppc_md rtc hooks
because you're already using genrtc, in that case the genrtc suspend
code is obviously much more appropriate.

Since currently only 32-bit powermac even implements suspend in
mainline, the whole issue is sort of moot anyway. Once the genrtc
suspend patches is in this file can be removed with the patch that
migrates powermac to genrtc, and then new platforms wanting to implement
suspend will need to use genrtc.

johannes

--=-OtkDVmBafBjmmhLieuz/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBF/wqO/ETPhpq3jKURAgrFAJ96JRVkccc/ymCcz3BARjcn+70lbACfXlkL
poLPKaszbww4BxT/qzLErhE=
=Wq0r
-----END PGP SIGNATURE-----

--=-OtkDVmBafBjmmhLieuz/--
