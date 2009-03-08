Return-Path: <drzeus@drzeus.cx>
Received: from smtp.drzeus.cx (82-117-125-11.tcdsl.calypso.net [82.117.125.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0822ADDEEA
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Mar 2009 01:21:36 +1100 (EST)
Date: Sun, 8 Mar 2009 15:21:20 +0100
From: Pierre Ossman <drzeus@drzeus.cx>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 12/13] sdhci: Add quirk for controllers with max. block
	size up to 4096 bytes
Message-ID: <20090308152120.38deb08b@mjolnir.ossman.eu>
In-Reply-To: <20090304174744.GB7477@oksana.dev.rtsoft.ru>
References: <20090213144630.GA13436@oksana.dev.rtsoft.ru>
	<20090213144739.GL23889@oksana.dev.rtsoft.ru>
	<20090221165844.4f494043@mjolnir.ossman.eu>
	<20090304174744.GB7477@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature";
	boundary="=_freyr.drzeus.cx-22064-1236522085-0001-2"
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

--=_freyr.drzeus.cx-22064-1236522085-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 4 Mar 2009 20:47:44 +0300
Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

>=20
> I'll get rid of this particular patch, and put some BLOCK_SIZE
> magic into the writew accessor (to clean the DMA bits) instead.
>=20
> Though, I'll prepare another patch to force blksz to 2048, since
> eSDHC specifies "3" in the blksz capability bitfield, and that
> causes SDHCI core to fall back to the 512 byte blocks.
>=20

Ok.

> > After all, is it ever used?
>=20
> Not sure, maybe `dd bs=3D' can use it? A bit lazy to check this
> right now, but from the quick tests, enabling/disabling "blksz
> of 4096 bytes" doesn't cause any performance change. At least
> with the ordinary SD cards.
>=20

Memory cards will not use this (at least not with the current
standards), as the block layer thinks in 512 byte blocks. Also, the
sector size propagates to user space in a way that causes filesystems
to behave differently, making cards incompatible with all other
operating systems (i.e. if we don't use 512 byte blocks).

So the only scenario where this might be used is SDIO, and I'm not sure
such big blocks are a win there either because of the overhead of
changing block size.

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.drzeus.cx-22064-1236522085-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEARECAAYFAkmz1GIACgkQ7b8eESbyJLhTfwCdEb94fpg8zMP799gEvcK6mzxd
omMAoL3BAmCZ4lBj5T91PH11e7It/950
=7CIh
-----END PGP SIGNATURE-----

--=_freyr.drzeus.cx-22064-1236522085-0001-2--
