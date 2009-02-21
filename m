Return-Path: <drzeus@drzeus.cx>
Received: from smtp.drzeus.cx (82-117-125-11.tcdsl.calypso.net [82.117.125.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E8DC9DDEEB
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Feb 2009 02:58:51 +1100 (EST)
Date: Sat, 21 Feb 2009 16:58:44 +0100
From: Pierre Ossman <drzeus@drzeus.cx>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 12/13] sdhci: Add quirk for controllers with max. block
	size up to 4096 bytes
Message-ID: <20090221165844.4f494043@mjolnir.ossman.eu>
In-Reply-To: <20090213144739.GL23889@oksana.dev.rtsoft.ru>
References: <20090213144630.GA13436@oksana.dev.rtsoft.ru>
	<20090213144739.GL23889@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature";
	boundary="=_freyr.drzeus.cx-15490-1235231929-0001-2"
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

--=_freyr.drzeus.cx-15490-1235231929-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Feb 2009 17:47:39 +0300
Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> @@ -831,7 +832,12 @@ static void sdhci_prepare_data(struct sdhci_host *ho=
st, struct mmc_data *data)
>  	sdhci_set_transfer_irqs(host);
> =20
>  	/* We do not handle DMA boundaries, so set it to max (512 KiB) */
> -	sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, data->blksz), SDHCI_BLOCK_SIZE);
> +	if (host->quirks & SDHCI_QUIRK_MAX_BLK_SZ_4096)
> +		blksz =3D data->blksz;
> +	else
> +		blksz =3D SDHCI_MAKE_BLKSZ(7, data->blksz);
> +
> +	sdhci_writew(host, blksz, SDHCI_BLOCK_SIZE);
>  	sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
>  }
> =20

Hmm.. I seem to have overlooked this part previously. I guess they've
basically stripped out the DMA boundary stuff and used the bits for
other things?

At this point I'm leaning more towards simply not supporting their
extended block size. After all, is it ever used?

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.drzeus.cx-15490-1235231929-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.10 (GNU/Linux)

iEYEARECAAYFAkmgJLkACgkQ7b8eESbyJLjhyACaA8FHr1u1aWy6/2W+aqlFgHWe
8YYAn32H12Pi4hPcFacaLNuTBGNDdDgi
=Vynl
-----END PGP SIGNATURE-----

--=_freyr.drzeus.cx-15490-1235231929-0001-2--
