Return-Path: <drzeus@drzeus.cx>
Received: from smtp.drzeus.cx (82-117-125-11.tcdsl.calypso.net [82.117.125.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2C9A6DDD1C
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Feb 2009 07:50:31 +1100 (EST)
Date: Sun, 8 Feb 2009 21:50:20 +0100
From: Pierre Ossman <drzeus@drzeus.cx>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 02/11] sdhci: Add support for bus-specific IO memory
	accessors
Message-ID: <20090208215020.46ca5724@mjolnir.drzeus.cx>
In-Reply-To: <20090206180645.GB11548@oksana.dev.rtsoft.ru>
References: <20090206180520.GA16123@oksana.dev.rtsoft.ru>
	<20090206180645.GB11548@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1;
	boundary="=_freyr.drzeus.cx-3732-1234126226-0001-2"
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

--=_freyr.drzeus.cx-3732-1234126226-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Feb 2009 21:06:45 +0300
Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> Currently the SDHCI driver works with PCI accessors (write{l,b,w} and
> read{l,b,w}).
>=20
> With this patch drivers may change memory accessors, so that we can
> support hosts with "weird" IO memory access requirments.
>=20
> For example, in "FSL eSDHC" SDHCI hardware all registers are 32 bit
> width, with big-endian addressing. That is, readb(0x2f) should turn
> into readb(0x2c), and readw(0x2c) should be translated to
> le16_to_cpu(readw(0x2e)).
>=20
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---

I was hoping we wouldn't have to do a lot of magic in the accessors
since the spec is rather clear on the register interface. :/

Let's see if I've understood this correctly.

1. The CPU is big-endian but the register are little-endian (as the
spec requires). I was under the impression that the read*/write*
accessor handled any endian conversion between the bus and the cpu? How
do e.g. PCI work on Sparc?

2. Register access must be done 32 bits at a time. Now this is just
broken and might cause big problems as some registers cannot just be
read and written back to. OTOH you refer to readw() in your example,
not readl(). What's the deal here?

> +static inline void sdhci_writel(struct sdhci_host *host, u32 val, int re=
g)
> +{
> +	host->writel(host, val, reg);
> +}

Having to override these are worst case scenario as far as I'm
concerned, so I'd prefer something like:

if (!host->ops->writel)
	writel(host->ioaddr + reg, val);
else
	host->ops->writel(host, val, reg);

and maybe even a likely() up there.

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.drzeus.cx-3732-1234126226-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkmPRZEACgkQ7b8eESbyJLhTUACeLUXTRKqOgBNTxtpnNF2pWs/f
eNMAn28CPdmEUm5dE4T1B2iETaW6W5gV
=++gn
-----END PGP SIGNATURE-----

--=_freyr.drzeus.cx-3732-1234126226-0001-2--
