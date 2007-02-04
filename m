Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4289CDDE41
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Feb 2007 00:43:44 +1100 (EST)
Subject: Re: powerbook/radeon PM problem
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1170564480.2620.30.camel@localhost.localdomain>
References: <1170357083.4036.5.camel@johannes.berg>
	<1170564480.2620.30.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-/Um13jmLM2bEYF/nmd1R"
Date: Sun, 04 Feb 2007 14:42:50 +0100
Message-Id: <1170596570.23273.8.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-/Um13jmLM2bEYF/nmd1R
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2007-02-04 at 15:47 +1100, Benjamin Herrenschmidt wrote:

> Yeah well, it's -supposed- to be taken by the resume function, but the
> early resume path is a hack that runs -really- early (so you get a
> screen back for debugging). I should find a way to silence those stupid
> warnings...

Yes, I agree that the semaphore that the comment talks about won't ever
be taken anyway. The warning actually comes from the notifier chain that
is used there, of course.

> > I'm totally unsure what the correct fix for this is.
>=20
> None other than removing the early wakeup hack :-(

Actually, looking at the code again... fb_notifier_list is a blocking
notifier list. This could be converted to a raw one without any locking,
and we could require that callers of fb_register_client,
fb_unregister_client and fb_notifier_call_chain hold the console
semaphore while calling.
Then, some callers in drivers/video/fbmem.c would need to be updated,
but since fb_set_suspend already requires the semaphore to be held it
wouldn't acquire it again, of course.

We'd still abuse fb_set_suspend here by calling it without the semaphore
held, but we know that nobody else can hold it at that time so that'd be
ok.

Just a thought.

johannes

--=-/Um13jmLM2bEYF/nmd1R
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFxeLZ/ETPhpq3jKURAufJAJ0Sx11Ozt/auEqBlIc/UHapFoVoEwCghUi2
kh8eOLte8eVc/u0ophQ9uIQ=
=1how
-----END PGP SIGNATURE-----

--=-/Um13jmLM2bEYF/nmd1R--
