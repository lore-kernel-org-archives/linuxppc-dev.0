Return-Path: <drzeus@drzeus.cx>
Received: from smtp.drzeus.cx (82-117-125-11.tcdsl.calypso.net [82.117.125.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BCAC6DDF81
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Mar 2009 01:17:19 +1100 (EST)
Date: Sun, 8 Mar 2009 15:17:10 +0100
From: Pierre Ossman <drzeus@drzeus.cx>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 07/13] sdhci: Add support for hosts with strict 32 bit
	addressing
Message-ID: <20090308151710.637fe280@mjolnir.ossman.eu>
In-Reply-To: <20090304174845.GC7477@oksana.dev.rtsoft.ru>
References: <20090213144630.GA13436@oksana.dev.rtsoft.ru>
	<20090213144722.GG23889@oksana.dev.rtsoft.ru>
	<20090221165833.6dec220a@mjolnir.ossman.eu>
	<20090304174845.GC7477@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature";
	boundary="=_freyr.drzeus.cx-21860-1236521833-0001-2"
Cc: Ben Dooks <ben-linux@fluff.org>, Arnd Bergmann <arnd@arndb.de>,
	Liu Dave <DaveLiu@freescale.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sdhci-devel@list.drzeus.cx
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.drzeus.cx-21860-1236521833-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 4 Mar 2009 20:48:45 +0300
Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> But I see the point of confusion... Instead of teaching
> "SDHCI core" to work with 32 bits hosts, we'd better handle this
> in the eSDHC part, in the accessors.
>=20
> This is relatively trivial and should not cause much overhead
> (at least when using DMA), just a small state machine with
> the xfer mode register shadowed in software (plus, notice that
> this also handles BLOCK_SIZE, as I promised in another email):
>=20

Me like. Keeps my life a lot saner. :)

Just be aware that there is a remote risk of breakage as people hacking
on sdhci-core won't be aware of esdhc's, let's call it unique,
behaviour. Some testing now and then on your part would be prudent. :)

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.drzeus.cx-21860-1236521833-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEARECAAYFAkmz02kACgkQ7b8eESbyJLi+9ACfTPELBvqvxvpyZrSpgjCBL32t
ARYAn1KnDdIMAk/ONTs4epEqRHmMx+Ej
=drI/
-----END PGP SIGNATURE-----

--=_freyr.drzeus.cx-21860-1236521833-0001-2--
