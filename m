Return-Path: <drzeus@drzeus.cx>
Received: from smtp.drzeus.cx (82-117-125-11.tcdsl.calypso.net [82.117.125.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 26D17DDD04
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Feb 2009 07:53:24 +1100 (EST)
Date: Sun, 8 Feb 2009 21:53:10 +0100
From: Pierre Ossman <drzeus@drzeus.cx>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 03/11] sdhci: Add type checking for IO memory accessors
Message-ID: <20090208215310.22a8239b@mjolnir.drzeus.cx>
In-Reply-To: <20090206180648.GC11548@oksana.dev.rtsoft.ru>
References: <20090206180520.GA16123@oksana.dev.rtsoft.ru>
	<20090206180648.GC11548@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1;
	boundary="=_freyr.drzeus.cx-3867-1234126398-0001-2"
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

--=_freyr.drzeus.cx-3867-1234126398-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Feb 2009 21:06:48 +0300
Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> A new restricted integer type introduced: sdhci_reg_t.
>=20
> Header file now specifies registers via sdhci_reg() inline function.
> Only one place (not counting sdhci_def_*() accessors) need to cast
> a register back to an offset, i.e. sdhci_finish_command().
>=20
> From now on sparse tool will warn about IO memory accessors misuses,
> for exampple:
>=20
> sdhci_writeb(host, SDHCI_TIMEOUT_CONTROL, count);
>=20
>   CHECK   sdhci.c
> sdhci.c:614:21: warning: incorrect type in argument 2 (different base typ=
es)
> sdhci.c:614:21:    expected unsigned char [unsigned] [usertype] val
> sdhci.c:614:21:    got restricted int
> sdhci.c:614:44: warning: incorrect type in argument 3 (different base typ=
es)
> sdhci.c:614:44:    expected restricted int [usertype] reg
> sdhci.c:614:44:    got unsigned char [unsigned] [assigned] [usertype] cou=
nt
>=20
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---

Is this really a problem? It's a lot of noise in the code and I can't
really see this as a major issue, or even a minor one. :)

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.drzeus.cx-3867-1234126398-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkmPRj0ACgkQ7b8eESbyJLjThACg291FPLnUFcUeDma3Ewc/PcTb
5+EAn2C4Tb5nNZM40WXG6yV7jJN9sSUO
=dcFE
-----END PGP SIGNATURE-----

--=_freyr.drzeus.cx-3867-1234126398-0001-2--
