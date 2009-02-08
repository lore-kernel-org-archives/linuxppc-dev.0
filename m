Return-Path: <drzeus@drzeus.cx>
Received: from smtp.drzeus.cx (82-117-125-11.tcdsl.calypso.net [82.117.125.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B48C7DDD04
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Feb 2009 07:57:50 +1100 (EST)
Date: Sun, 8 Feb 2009 21:57:39 +0100
From: Pierre Ossman <drzeus@drzeus.cx>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 04/11] sdhci: Add support for card-detection polling
Message-ID: <20090208215739.26fbb34b@mjolnir.drzeus.cx>
In-Reply-To: <20090206180650.GD11548@oksana.dev.rtsoft.ru>
References: <20090206180520.GA16123@oksana.dev.rtsoft.ru>
	<20090206180650.GD11548@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1;
	boundary="=_freyr.drzeus.cx-4104-1234126663-0001-2"
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

--=_freyr.drzeus.cx-4104-1234126663-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Feb 2009 21:06:50 +0300
Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> This patch adds SDHCI_QUIRK_BROKEN_CARD_DETECTION quirk. When specified,
> sdhci driver will set MMC_CAP_NEEDS_POLL MMC host capability, and won't
> enable card insert/remove interrupts.
>=20
> This is needed for hosts with unreliable card detection, such as FSL
> eSDHC. The original eSDHC driver was tring to "debounce" card-detection
> IRQs by reading present state and disabling particular interrupts. But
> with this debouncing scheme I noticed that sometimes we miss card
> insertion/removal events.
>=20
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---

I guess you need to fix the check at the start of the request function
as well.

> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index b7a79a0..45c5f1f 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -162,6 +162,9 @@ static void sdhci_init(struct sdhci_host *host)
>  		SDHCI_INT_DMA_END | SDHCI_INT_DATA_END | SDHCI_INT_RESPONSE |
>  		SDHCI_INT_ADMA_ERROR;
> =20
> +	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
> +		intmask &=3D ~(SDHCI_INT_CARD_REMOVE | SDHCI_INT_CARD_INSERT);
> +

A matter of taste perhaps, but I think it would make more sense to not
add them in the first place than to add and then remove them.

Card detection interrupts should be handled separately anyway as they
should not be enabled before mmc_add_host() returns and should be
disabled before calling mmc_remove_host(). Patch welcome. ;)

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.drzeus.cx-4104-1234126663-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkmPR0cACgkQ7b8eESbyJLinhwCgxCrMV6jlNboNhbhJo9PjcO7P
SHoAoLJekCBLVYJpwVQ4TsgkC+3xqln2
=cNsd
-----END PGP SIGNATURE-----

--=_freyr.drzeus.cx-4104-1234126663-0001-2--
