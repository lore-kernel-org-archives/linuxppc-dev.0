Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-f175.google.com (mail-pd0-f175.google.com
 [209.85.192.175])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 289902C009E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 18:43:39 +1000 (EST)
Received: by mail-pd0-f175.google.com with SMTP id y14so2118377pdi.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 01:43:37 -0700 (PDT)
Date: Thu, 16 May 2013 16:43:29 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/4] powerpc/book3e: introduce external_input_edge
 exception handler for 64bit kernel
Message-ID: <20130516084329.GF18214@pek-khao-d1.corp.ad.wrs.com>
References: <20130514020317.GB21564@pek-khao-d1.corp.ad.wrs.com>
 <1368653426.8202.34@snotra>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="cpvLTH7QU4gwfq3S"
In-Reply-To: <1368653426.8202.34@snotra>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--cpvLTH7QU4gwfq3S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2013 at 04:30:26PM -0500, Scott Wood wrote:
> On 05/13/2013 09:03:17 PM, Kevin Hao wrote:
> >On Mon, May 13, 2013 at 10:47:17AM -0500, Scott Wood wrote:
> >> On 05/11/2013 06:26:21 PM, Kevin Hao wrote:
> >> >In the external proxy facility mode, the interrupt is automatically
> >> >acknowledged with the same effect as reading the IACK register. So
> >> >this makes external input interrupt more like edge sensitive. That
> >> >means we can leave the irq hard enabled when it occurs with irq
> >soft
> >> >disabled just like the dec and doorbell interrupt. But the External
> >> >Proxy Register(EPR) is only considered valid from the time that the
> >> >external interrupt occurs until MSR[EE] is set to 1. So we have to
> >> >save the EPR before irq hard enabled.
> >>
> >> Is it really worth it?
> >
> >Maybe. :-)
> >Compare with the current kernel:
> >  * The overhead is that we need additional load & store the
> >contents of
> >    the EPR from/to PACA.
>=20
> There's also mental overhead of the extra complexity.

Yes, I agree. But since we already have the support for the edge sensitive
interrupt such as doorbell, decrementer, adding another one doesn't really
introduce much code complexity in my opinion.

>  The lazy EE
> stuff is already fiddly enough (e.g. the recent KVM patches).

:-)

>=20
> >  * The bonus is we keep the irq hard enabled when a external
> >interrupt occurs
> >    with irq soft-disabled. As I know we should leave the irq hard
> >enabled as
> >    much as possible. This is also the primary reason that we
> >introduce the
> >    Lazy EE.
>=20
> I don't think "as much as possible" is a good way to look at it, so
> much as "as much as is practical", balanced by also wanting to keep
> the code as simple as is practical.

Yes, I also like simple. That is why I make the following patch first.
http://patchwork.ozlabs.org/patch/235530/

But it seems that Ben doesn't like it. And it also seem not so difficulty
to support the external interrupt as edge sensitive for external proxy,
so I scratch these patches. It seems that you and Ben have different
view about this issue. Anyway I have no strong preference for these two
ways and will leave it to you guys to determine which way we like to adopt.

Thanks,
Kevin

>=20
> -Scott

--cpvLTH7QU4gwfq3S
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJRlJwxAAoJEJNY7TDerrFxZR4H/jv4CX/j6tbiSvGQnpJNf83W
bPAJRw6rnS80xEWi+eKFvAxreHK2TBLje2Cen9OMDeEY2VjK9zzNluB2x64/2i5S
gdyVkRGHLBGAOm2as39vF2JhKVT3yMmqMNLYSJGREnpqlFCD7BKvkZ+PdJMZwOWy
fFXUsAd671+LXgsczuprYcsPQBFJ5tLw8BiqFXuHh8X3TJiX4XA5I+5lsaFQ+8Bm
RZCpJagKLpxq9f6oSVkoq4B4hqEmNfTirBPloowaPIrwFD4mNqCpSZ9IMVe6uG1w
T4kPKqzMaVz2sGt2CZHzU2xlzg3RUJIlB9kaepdXkEpbOh13EyYUkjGSq2Hv6YQ=
=lthD
-----END PGP SIGNATURE-----

--cpvLTH7QU4gwfq3S--
