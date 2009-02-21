Return-Path: <drzeus@drzeus.cx>
Received: from smtp.drzeus.cx (82-117-125-11.tcdsl.calypso.net [82.117.125.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EDE20DDEF0
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Feb 2009 02:58:28 +1100 (EST)
Date: Sat, 21 Feb 2009 16:58:21 +0100
From: Pierre Ossman <drzeus@drzeus.cx>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 05/13] sdhci: Add support for card-detection polling
Message-ID: <20090221165821.1239aa5a@mjolnir.ossman.eu>
In-Reply-To: <20090213144718.GE23889@oksana.dev.rtsoft.ru>
References: <20090213144630.GA13436@oksana.dev.rtsoft.ru>
	<20090213144718.GE23889@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature";
	boundary="=_freyr.drzeus.cx-15332-1235231906-0001-2"
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

--=_freyr.drzeus.cx-15332-1235231906-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Feb 2009 17:47:18 +0300
Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> @@ -1110,13 +1113,18 @@ static void sdhci_request(struct mmc_host *mmc, s=
truct mmc_request *mrq)
> =20
>  	host->mrq =3D mrq;
> =20
> +	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
> +		goto send;
> +
>  	if (!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT)
>  		|| (host->flags & SDHCI_DEVICE_DEAD)) {
>  		host->mrq->cmd->error =3D -ENOMEDIUM;
>  		tasklet_schedule(&host->finish_tasklet);
> -	} else
> -		sdhci_send_command(host, mrq->cmd);
> -
> +		goto out;
> +	}
> +send:
> +	sdhci_send_command(host, mrq->cmd);
> +out:
>  	mmiowb();
>  	spin_unlock_irqrestore(&host->lock, flags);
>  }

goto:s seem unnecessary here, and your patch is even incorrect as it
ignores the SDHCI_DEVICE_DEAD flag. Just modify the if-clause and
things will work.

Might want to add a comment also to make it more obvious what the
if-clause does.

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.drzeus.cx-15332-1235231906-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.10 (GNU/Linux)

iEYEARECAAYFAkmgJKEACgkQ7b8eESbyJLgiYgCgul2zYdNffIGoipdqiPKO1/nP
5TkAoMa9KdnCdco77jC70kIpJYkXGXTM
=Xy78
-----END PGP SIGNATURE-----

--=_freyr.drzeus.cx-15332-1235231906-0001-2--
