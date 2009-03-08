Return-Path: <drzeus@drzeus.cx>
Received: from smtp.drzeus.cx (82-117-125-11.tcdsl.calypso.net [82.117.125.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6F1A9DDF80
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Mar 2009 01:11:31 +1100 (EST)
Date: Sun, 8 Mar 2009 15:11:21 +0100
From: Pierre Ossman <drzeus@drzeus.cx>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 05/13] sdhci: Add support for card-detection polling
Message-ID: <20090308151121.291f1abb@mjolnir.ossman.eu>
In-Reply-To: <20090304174917.GD7477@oksana.dev.rtsoft.ru>
References: <20090213144630.GA13436@oksana.dev.rtsoft.ru>
	<20090213144718.GE23889@oksana.dev.rtsoft.ru>
	<20090221165821.1239aa5a@mjolnir.ossman.eu>
	<20090304174917.GD7477@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature";
	boundary="=_freyr.drzeus.cx-21533-1236521483-0001-2"
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

--=_freyr.drzeus.cx-21533-1236521483-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 4 Mar 2009 20:49:17 +0300
Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> On Sat, Feb 21, 2009 at 04:58:21PM +0100, Pierre Ossman wrote:
> > Just modify the if-clause and
> > things will work.
>=20
> That would look horrid...
>=20
>         if ((!(host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
>                         !(sdhci_readl(host, SDHCI_PRESENT_STATE) &
>                                 SDHCI_CARD_PRESENT)) ||
>                         (host->flags & SDHCI_DEVICE_DEAD)) {
>=20

There are worse ones in that code, but I see your point. :)

> > Might want to add a comment also to make it more obvious what the
> > if-clause does.
>=20
> Let's try to avoid the if-clause above? How about this:
>=20

Looks ok.

> @@ -1096,6 +1099,7 @@ out:
>  static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  {
>  	struct sdhci_host *host;
> +	bool present;
>  	unsigned long flags;
> =20
>  	host =3D mmc_priv(mmc);

Can we use bool in the kernel?

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.drzeus.cx-21533-1236521483-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEARECAAYFAkmz0gsACgkQ7b8eESbyJLgkcgCeNGAc+jwH2/4ht5XKRKv86kIT
ZiQAn0a0K9B2vrmq6hxq8rXLf/sb0qkc
=1YEC
-----END PGP SIGNATURE-----

--=_freyr.drzeus.cx-21533-1236521483-0001-2--
