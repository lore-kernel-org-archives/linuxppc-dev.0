Return-Path: <pierre@ossman.eu>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 241A2B71F8
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 13 Jun 2009 21:05:44 +1000 (EST)
Received: from smtp.ossman.eu (82-117-125-11.tcdsl.calypso.net [82.117.125.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 99A62DDD01
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Jun 2009 21:05:42 +1000 (EST)
Date: Sat, 13 Jun 2009 13:05:31 +0200
From: Pierre Ossman <pierre@ossman.eu>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] sdhci: Add support for hosts that are only capable of
	1-bit transfers
Message-ID: <20090613130531.59d4e733@mjolnir.ossman.eu>
In-Reply-To: <20090611201545.GA15942@oksana.dev.rtsoft.ru>
References: <20090611201545.GA15942@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature";
	boundary="=_freyr.ossman.eu-24962-1244891135-0001-2"
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	sdhci-devel@lists.ossman.eu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.ossman.eu-24962-1244891135-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 12 Jun 2009 00:15:45 +0400
Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> Some hosts (hardware configurations, or particular SD/MMC slots) may
> not support 4-bit bus. For example, on MPC8569E-MDS boards we can
> switch between serial (1-bit only) and nibble (4-bit) modes, thought
> we have to disable more peripherals to work in 4-bit mode.
>=20
> Along with some small core changes, this patch modifies sdhci-of
> driver, so that now it looks for "mode" property in the device-tree.
>=20
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>=20
> Pierre, I'm not sure if a quirk would be appropriate here. If so,
> I can redo the patch with FORCE_1_BIT_DATA quirk.
>=20

I'd prefer a quirk, yes. 4-bit support is mandated so this would be a
deviation from the spec and such should always be handled by quirks for
clarity.

(I do think it is silly that they made it mandatory though considering
the embedded market)

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.ossman.eu-24962-1244891135-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEARECAAYFAkozh/8ACgkQ7b8eESbyJLiHfQCfTcehGZGmEuEnPGhP7MbD5oCD
UiIAn27D4I3tNJONmxJb0aqMPBxC8fKP
=1svL
-----END PGP SIGNATURE-----

--=_freyr.ossman.eu-24962-1244891135-0001-2--
