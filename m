Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id DCA9FDDDA4
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Feb 2009 03:59:30 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 11/13] sdhci: Add quirk for controllers that need IRQ
	re-init after reset
Date: Fri, 13 Feb 2009 16:47:13 +0100
References: <20090213144630.GA13436@oksana.dev.rtsoft.ru>
	<20090213144738.GK23889@oksana.dev.rtsoft.ru>
In-Reply-To: <20090213144738.GK23889@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3658195.japQ0uH52i";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200902131647.17728.laurentp@cse-semaphore.com>
Cc: sdhci-devel@list.drzeus.cx, Arnd Bergmann <arnd@arndb.de>,
	Liu Dave <DaveLiu@freescale.com>, linux-kernel@vger.kernel.org,
	Ben Dooks <ben-linux@fluff.org>, Pierre Ossman <drzeus-sdhci@drzeus.cx>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart3658195.japQ0uH52i
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Anton,

On Friday 13 February 2009 15:47:38 Anton Vorontsov wrote:
> FSL eSDHC controllers losing signal/interrupt enable states after
> reset, so we should re-enable them.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  drivers/mmc/host/sdhci.c |    7 +++++++
>  drivers/mmc/host/sdhci.h |    2 ++
>  2 files changed, 9 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index eff615d..b308dbf 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -189,6 +189,7 @@ static void sdhci_disable_card_detection(struct
> sdhci_host *host) static void sdhci_reset(struct sdhci_host *host, u8 mas=
k)
>  {
>  	unsigned long timeout;
> +	u32 ier =3D 0; /* shut up gcc */

You should use

	u32 uninitialized_var(ier);

instead to avoid generating extra code.

>
>  	if (host->quirks & SDHCI_QUIRK_NO_CARD_NO_RESET) {
>  		if (!(sdhci_readl(host, SDHCI_PRESENT_STATE) &
> @@ -196,6 +197,9 @@ static void sdhci_reset(struct sdhci_host *host, u8
> mask) return;
>  	}
>
> +	if (host->quirks & SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)
> +		ier =3D sdhci_readl(host, SDHCI_INT_ENABLE);
> +
>  	sdhci_writeb(host, mask, SDHCI_SOFTWARE_RESET);
>
>  	if (mask & SDHCI_RESET_ALL)
> @@ -215,6 +219,9 @@ static void sdhci_reset(struct sdhci_host *host, u8
> mask) timeout--;
>  		mdelay(1);
>  	}
> +
> +	if (host->quirks & SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)
> +		sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK, ier);
>  }
>
>  static void sdhci_init(struct sdhci_host *host)
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 44c820a..5c5a950 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -229,6 +229,8 @@ struct sdhci_host {
>  #define SDHCI_QUIRK_NONSTANDARD_CLOCK			(1<<19)
>  /* Controller does not like fast PIO transfers */
>  #define SDHCI_QUIRK_PIO_NEEDS_DELAY			(1<<20)
> +/* Controller losing signal/interrupt enable states after reset */
> +#define SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET		(1<<21)
>
>  	int			irq;		/* Device IRQ */
>  	void __iomem *		ioaddr;		/* Mapped address */

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart3658195.japQ0uH52i
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmVlgEACgkQlyYWY4YEWhVGLgCfe6wTJschboY9UrkTDOErAxEV
/zQAni13XLvaxbeg6/2uA9IRXK3UKJ/1
=LI2n
-----END PGP SIGNATURE-----

--nextPart3658195.japQ0uH52i--
