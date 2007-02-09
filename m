Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 708E0DDEC8
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 02:43:36 +1100 (EST)
Subject: Re: [PATCH 13/12] mpic: add affinity callback for IPI "chip"
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1170969252.2620.335.camel@localhost.localdomain>
References: <20070207124536.963531000@sipsolutions.net>
	<1170940611.4385.56.camel@johannes.berg>
	<1170969252.2620.335.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-zPaFEoyswYyTO6SYPiBy"
Date: Fri, 09 Feb 2007 16:41:08 +0100
Message-Id: <1171035668.4520.12.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-zPaFEoyswYyTO6SYPiBy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-02-09 at 08:14 +1100, Benjamin Herrenschmidt wrote:
>=20
> > This patch adds a dummy affinity callback for the IPI "chip" to avoid
> > getting a warning ("Cannot set affinity for irq 251") when taking a
> > CPU offline via sysfs or during suspend.
>=20
> Wouldn't be a better option to make sure they have IRQF_PERCPU set and
> that we don't do the affinity thing on interrupts with that flag when=20
> offlining a CPU ?

Hmm. Yeah, something like that could be possible. Looking at
fixup_irqs() there is a test:

                if (irq_desc[irq].status & IRQ_PER_CPU)
                        continue;

but I'd have to dig what else this means.

johannes

--=-zPaFEoyswYyTO6SYPiBy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFzJYU/ETPhpq3jKURAl39AKCx9da7MJvKlrWL0p6Gg3y0iEHjpwCfdUzy
3bHIMm/M8KBGpHlfhTyvnd4=
=rR9r
-----END PGP SIGNATURE-----

--=-zPaFEoyswYyTO6SYPiBy--
