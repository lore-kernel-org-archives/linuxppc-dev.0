Return-Path: <drzeus@drzeus.cx>
Received: from smtp.drzeus.cx (82-117-125-11.tcdsl.calypso.net [82.117.125.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 22C04DDEE8
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Feb 2009 02:58:14 +1100 (EST)
Date: Sat, 21 Feb 2009 16:58:07 +0100
From: Pierre Ossman <drzeus@drzeus.cx>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 03/13] sdhci: Split card-detection IRQs management from
	sdhci_init()
Message-ID: <20090221165807.3d78c35f@mjolnir.ossman.eu>
In-Reply-To: <20090213144715.GC23889@oksana.dev.rtsoft.ru>
References: <20090213144630.GA13436@oksana.dev.rtsoft.ru>
	<20090213144715.GC23889@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature";
	boundary="=_freyr.drzeus.cx-15227-1235231892-0001-2"
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

--=_freyr.drzeus.cx-15227-1235231892-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Feb 2009 17:47:15 +0300
Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> Card detection interrupts should be handled separately as they should
> not be enabled before mmc_add_host() returns and should be disabled
> before calling mmc_remove_host(). The same is for suspend and resume
> routines.
>=20
> sdhci_init() no longer enables card-detection irqs. Instead, two new
> functions implemented: sdhci_enable_card_detection() and
> sdhci_disable_card_detection().
>=20
> New sdhci_reinit() call implemented to behave the same way as the old
> sdhci_init().
>=20
> Also, this patch implements and uses few new helpers to manage IRQs in
> a more conveinient way, that is:
>=20
> - sdhci_clear_set_irqs()
> - sdhci_unmask_irqs()
> - sdhci_mask_irqs()
> - SDHCI_INT_ALL_MASK constant
>=20
> sdhci_enable_sdio_irq() converted to these new helpers, plus the
> helpers will be used by the subsequent patches.
>=20
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---

That's a lot of indirection, but fair enough. :)

> @@ -1792,6 +1832,8 @@ int sdhci_add_host(struct sdhci_host *host)
> =20
>  	mmc_add_host(mmc);
> =20
> +	sdhci_enable_card_detection(host);
> +
>  	printk(KERN_INFO "%s: SDHCI controller on %s [%s] using %s%s\n",
>  		mmc_hostname(mmc), host->hw_name, dev_name(mmc_dev(mmc)),
>  		(host->flags & SDHCI_USE_ADMA)?"A":"",

There is a small race here, but I'm not sure it's worth dealing with.

> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index e907441..45c8309 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -124,6 +124,10 @@
>  		SDHCI_INT_DATA_AVAIL | SDHCI_INT_SPACE_AVAIL | \
>  		SDHCI_INT_DATA_TIMEOUT | SDHCI_INT_DATA_CRC | \
>  		SDHCI_INT_DATA_END_BIT)
> +#define SDHCI_INT_ALL_MASK	(SDHCI_INT_CMD_MASK | SDHCI_INT_DATA_MASK | \
> +		SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE | \
> +		SDHCI_INT_CARD_INT | SDHCI_INT_ERROR | SDHCI_INT_BUS_POWER | \
> +		SDHCI_INT_ACMD12ERR | SDHCI_INT_ADMA_ERROR)
> =20

In the context this is used, why not just use (unsigned)-1?

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.drzeus.cx-15227-1235231892-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.10 (GNU/Linux)

iEYEARECAAYFAkmgJJMACgkQ7b8eESbyJLj59QCgpiJ2ffBLK8g3mLGbyl2G5goP
OK0AnjCB7Gxi5FEmSoeVg1HU5p2IdZpe
=VpV9
-----END PGP SIGNATURE-----

--=_freyr.drzeus.cx-15227-1235231892-0001-2--
