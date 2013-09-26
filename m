Return-Path: <haokexin@gmail.com>
Received: from mail-pb0-x230.google.com (mail-pb0-x230.google.com
 [IPv6:2607:f8b0:400e:c01::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 701D22C0090
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 11:23:24 +1000 (EST)
Received: by mail-pb0-f48.google.com with SMTP id ma3so411505pbc.21
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 18:23:21 -0700 (PDT)
Date: Thu, 26 Sep 2013 09:23:11 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v3 3/3] powerpc/85xx: use one kernel option for all the
 CoreNet_Generic boards
Message-ID: <20130926012310.GB9209@pek-khao-d1.corp.ad.wrs.com>
References: <1379991797-29222-1-git-send-email-haokexin@gmail.com>
 <1379991797-29222-4-git-send-email-haokexin@gmail.com>
 <1380062492.24959.123.camel@snotra.buserror.net>
 <20130925005843.GA20572@pek-khao-d1.corp.ad.wrs.com>
 <1380150683.24959.215.camel@snotra.buserror.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
In-Reply-To: <1380150683.24959.215.camel@snotra.buserror.net>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2013 at 06:11:23PM -0500, Scott Wood wrote:
> On Wed, 2013-09-25 at 08:58 +0800, Kevin Hao wrote:
> > On Tue, Sep 24, 2013 at 05:41:32PM -0500, Scott Wood wrote:
> > > On Tue, 2013-09-24 at 11:03 +0800, Kevin Hao wrote:
> > > > +	  and B4 QDS boards
> > [...]
> > >=20
> > > Is there any difference between the 32-bit and 64-bit versions of this
> > > config symbol, other than the help text?
> >=20
> > No. As you know some of these boards only support 32bit kernel and some=
 of
> > them only support 64bit kernel. It will definitely cause confusion when=
 using
> > only one kernel option for all these boards. So I divide this into two =
options
> > (even the same name) for 32bit and 64bit respectively.
>=20
> You could just mention in the help text which boards are 32-bit, which
> are 64-bit, and which can work with either.

OK. How about this?

 arch/powerpc/platforms/85xx/Kconfig | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/8=
5xx/Kconfig
index 04456fb..4d46349 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -218,20 +218,6 @@ config GE_IMP3A
 	  This board is a 3U CompactPCI Single Board Computer with a Freescale
 	  P2020 processor.
=20
-config CORENET_GENERIC
-	bool "Freescale CoreNet Generic"
-	select DEFAULT_UIMAGE
-	select PPC_E500MC
-	select PHYS_64BIT
-	select SWIOTLB
-	select ARCH_REQUIRE_GPIOLIB
-	select GPIO_MPC8XXX
-	select HAS_RAPIDIO
-	select PPC_EPAPR_HV_PIC
-	help
-	  This option enables support for the P2041 RDB, P3041 DS, P4080 DS, P502=
0 DS
-	  and P5040 DS boards
-
 config SGY_CTS1000
 	tristate "Servergy CTS-1000 support"
 	select GPIOLIB
@@ -257,8 +243,6 @@ config PPC_QEMU_E500
 	  unset based on the emulated CPU (or actual host CPU in the case
 	  of KVM).
=20
-if PPC64
-
 config CORENET_GENERIC
 	bool "Freescale CoreNet Generic"
 	select DEFAULT_UIMAGE
@@ -271,10 +255,14 @@ config CORENET_GENERIC
 	select HAS_RAPIDIO
 	select PPC_EPAPR_HV_PIC
 	help
-	  This option enables support for the P5020 DS, P5040 DS, T4240 QDS
-	  and B4 QDS boards
+	  This option enables support for the FSL CoreNet based boards.
+	  For 32bit kernel, the following boards are supported:
+	    P2041 RDB, P3041 DS and P4080 DS
+	  For 64bit kernel, the following boards are supported:
+	    T4240 QDS and B4 QDS
+	  The following boards are supported for both 32bit and 64bit kernel:
+	    P5020 DS and P5040 DS
=20
-endif
 endif # FSL_SOC_BOOKE
=20
 config TQM85xx

Thanks,
Kevin

>=20
> -Scott
>=20
>=20
>=20

--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJSQ4x+AAoJEJNY7TDerrFxmMkH/1bXahbx+OoaseKtlnLvUaJk
qP9B07ZZ8IN779bqMo5dt72dsITODKATNj9oyR8pUn6VyOjSyhW7i+P0jQOUIWk5
x5R3ZYYuqwf+vBan2sSzs+1WR7+zFskweloUEqlWRoODIw9Gefj0p7IlCHxe0z2c
swVfMeabwTEWeHOECdcKWq8Rw4dFK6o9Ime0tXQNdaf8bpkQPiNL1AVrFnURmrxr
75s4gfD0o0Nit42lYDCP9Z0i8ciaB1Hl3ktUx1a0EkZqUYv48B7I65FsdBV6lm0t
V5eXjsKS/3zBD9gA+dH16p4JOAiRF8JSMkNjG7we99ZcwUlSLbPjTa5wABLIH5k=
=MEnw
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--
