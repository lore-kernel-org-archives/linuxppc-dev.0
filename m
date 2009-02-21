Return-Path: <drzeus@drzeus.cx>
Received: from smtp.drzeus.cx (82-117-125-11.tcdsl.calypso.net [82.117.125.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F3912DDF1E
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Feb 2009 02:58:40 +1100 (EST)
Date: Sat, 21 Feb 2009 16:58:33 +0100
From: Pierre Ossman <drzeus@drzeus.cx>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 07/13] sdhci: Add support for hosts with strict 32 bit
	addressing
Message-ID: <20090221165833.6dec220a@mjolnir.ossman.eu>
In-Reply-To: <20090213144722.GG23889@oksana.dev.rtsoft.ru>
References: <20090213144630.GA13436@oksana.dev.rtsoft.ru>
	<20090213144722.GG23889@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature";
	boundary="=_freyr.drzeus.cx-15419-1235231918-0001-2"
Cc: Ben Dooks <ben-linux@fluff.org>, Arnd Bergmann <arnd@arndb.de>,
	Liu Dave <DaveLiu@freescale.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sdhci-devel@list.drzeus.cx,
	Pierre Ossman <drzeus-sdhci@drzeus.cx>
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

--=_freyr.drzeus.cx-15419-1235231918-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Feb 2009 17:47:22 +0300
Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> SDHCI driver must take special care when working with "triggering"
> registers on hosts with strict 32 bit addressing.
>=20
> In FSL eSDHC hosts all registers are 32 bit width, writing to the
> first half of any register will cause [undefined?] write the second
> half of the register. That is, 16 bit write to the TRANSFER_MODE
> register, makes hardware see a bogus write to the COMMAND register
> (these two registers are adjacent).
>=20
> This patch adds SDHCI_QUIRK_32BIT_REGISTERS quirk. When specified,
> the sdhci driver will try to "pack" all dangerous writes into single
> 32 bit write transaction.
>=20
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---

What about the other places where we have 16 and 8 bit registers?

--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.drzeus.cx-15419-1235231918-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.10 (GNU/Linux)

iEYEARECAAYFAkmgJK0ACgkQ7b8eESbyJLjyKACgzC2anefb2CIywcvAzFxxOOy8
d9wAn143aHZoPApTiQOxXDIqFMkmDPtk
=dsV3
-----END PGP SIGNATURE-----

--=_freyr.drzeus.cx-15419-1235231918-0001-2--
