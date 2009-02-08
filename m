Return-Path: <drzeus@drzeus.cx>
Received: from smtp.drzeus.cx (82-117-125-11.tcdsl.calypso.net [82.117.125.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 00CB8DDD04
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Feb 2009 08:03:06 +1100 (EST)
Date: Sun, 8 Feb 2009 22:02:55 +0100
From: Pierre Ossman <drzeus@drzeus.cx>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 07/11] sdhci: Add quirk to suppress PIO interrupts
	during DMA transfers
Message-ID: <20090208220255.6fb15ea8@mjolnir.drzeus.cx>
In-Reply-To: <20090206180655.GG11548@oksana.dev.rtsoft.ru>
References: <20090206180520.GA16123@oksana.dev.rtsoft.ru>
	<20090206180655.GG11548@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1;
	boundary="=_freyr.drzeus.cx-4457-1234126980-0001-2"
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

--=_freyr.drzeus.cx-4457-1234126980-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Feb 2009 21:06:55 +0300
Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> Some hosts (that is, FSL eSDHC) throw PIO interrupts during DMA
> transfers, this causes tons of unneeded interrupts, and thus highly
> degraded speed.
>=20
> This patch adds SDHCI_QUIRK_PIO_IRQS_DURING_DMA quirk. When specified,
> the sdhci driver will disable PIO interrupts during DMA transfers.
>=20
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---

It's probably better to change the interrupt handling to only enable
relevant interrupts instead of having everything on constantly. Too
many quirks just makes the driver difficult to understand.

--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.drzeus.cx-4457-1234126980-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkmPSIQACgkQ7b8eESbyJLg1hACbBK5jyGywf72X22+7A2VyU2Z0
e/YAn1Z37Djr5d02dnayfDpn2XUOINGj
=fmlo
-----END PGP SIGNATURE-----

--=_freyr.drzeus.cx-4457-1234126980-0001-2--
