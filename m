Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1955DDDF66
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 21:17:46 +1000 (EST)
Subject: Re: Executing from readablee, no-exec pages
From: Johannes Berg <johannes@sipsolutions.net>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <468D68D4.4050704@freescale.com>
References: <468D68D4.4050704@freescale.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-MICaiwHOITc0IYF30xqA"
Date: Fri, 06 Jul 2007 13:18:42 +0200
Message-Id: <1183720722.3818.126.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-MICaiwHOITc0IYF30xqA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-07-05 at 16:55 -0500, Scott Wood wrote:
> As revealed by the recent "Prevent data exception in kernel space"=20
> patch, versions of glibc prior to 2.4[1] assume that, on powerpc32, they=20
> can execute out of any readable mapping, regardless of whether it is=20
> marked for execution.  This happens in the elf_machine_load_address()=20
> function.

Umm, are you sure about this? The "prevent data exception in kernel
space" patch came from a test program I had that attempted to execute a
page with /no permissions/ at all!

I know that I used to have problems with mono making this assumption but
these have since been fixed; however if I understand you correctly then
you can always pre-fault the page by a read and then execute it so I
don't see the point in not doing the change you suggest.

johannes

--=-MICaiwHOITc0IYF30xqA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGjiUS/ETPhpq3jKURAskPAJsF+KIoSlt45mKRYKi3K8l0xNuoNwCfZBsS
z2f+zpMRrGl0VVxu+YiqN3Y=
=qBMJ
-----END PGP SIGNATURE-----

--=-MICaiwHOITc0IYF30xqA--
