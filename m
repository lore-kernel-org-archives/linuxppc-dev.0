Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-f172.google.com (mail-pd0-f172.google.com
 [209.85.192.172])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0FED92C00B0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 May 2013 12:03:28 +1000 (EST)
Received: by mail-pd0-f172.google.com with SMTP id 6so4830429pdd.31
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 19:03:26 -0700 (PDT)
Date: Tue, 14 May 2013 10:03:17 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/4] powerpc/book3e: introduce external_input_edge
 exception handler for 64bit kernel
Message-ID: <20130514020317.GB21564@pek-khao-d1.corp.ad.wrs.com>
References: <1368314784-971-2-git-send-email-haokexin@gmail.com>
 <1368460037.8202.8@snotra>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
In-Reply-To: <1368460037.8202.8@snotra>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2013 at 10:47:17AM -0500, Scott Wood wrote:
> On 05/11/2013 06:26:21 PM, Kevin Hao wrote:
> >In the external proxy facility mode, the interrupt is automatically
> >acknowledged with the same effect as reading the IACK register. So
> >this makes external input interrupt more like edge sensitive. That
> >means we can leave the irq hard enabled when it occurs with irq soft
> >disabled just like the dec and doorbell interrupt. But the External
> >Proxy Register(EPR) is only considered valid from the time that the
> >external interrupt occurs until MSR[EE] is set to 1. So we have to
> >save the EPR before irq hard enabled.
>=20
> Is it really worth it?

Maybe. :-)
Compare with the current kernel:
  * The overhead is that we need additional load & store the contents of
    the EPR from/to PACA.
  * The bonus is we keep the irq hard enabled when a external interrupt occ=
urs
    with irq soft-disabled. As I know we should leave the irq hard enabled =
as
    much as possible. This is also the primary reason that we introduce the
    Lazy EE.

>  Are you having a real-world problem with
> profilability as things stand, that this resolves?

No.=20

>  We should
> already be no worse off than non-external-proxy hardware...

Yes, I agree. But we can leverage the advantage of external proxy and
make it even more better.

Thanks,
Kevin

>=20
> -Scott

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJRkZtlAAoJEJNY7TDerrFx108H/2K4/0cE9S90o1iCIbob+GUr
+u6Ck3qPkNYRYJxChn4vaDuFWpApTzb+HELt0vsFAJVZDT/fTgzjhLrCRvFF8LkK
pAfs9X8GlSSc1EpXnLzizo6xdrMEvUwvkteEJLahqvZ4fkR+UZO4AtRtRfdXh3fD
1BdO5tjT1xKFWLXvA+AHDLfeWYH8n8uV+3O6dB7iBagy/nAVanbTynBZ9O6TpIvU
eI/MZqLQ6U+Tz2O6gupKiu8c+bZvKZIIx1IVHK/TuZRQmwZ0PUJ6axReWEZfl8EM
YnztDgW3TfNPotuUsDWP1HnLXbjI4jAmMC34AWx1QpU+Gzie10dQjwONS6s18Sc=
=Rc8b
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--
