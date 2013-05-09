Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-f179.google.com (mail-pd0-f179.google.com
 [209.85.192.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BFEE22C00E2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 May 2013 18:08:26 +1000 (EST)
Received: by mail-pd0-f179.google.com with SMTP id q10so1848380pdj.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 May 2013 01:08:24 -0700 (PDT)
Date: Thu, 9 May 2013 16:08:13 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Bhushan Bharat-R65777 <R65777@freescale.com>
Subject: Re: [RFC][KVM][PATCH 1/1] kvm:ppc:booke-64: soft-disable interrupts
Message-ID: <20130509080813.GD2263@pek-khao-d1.corp.ad.wrs.com>
References: <51885F49.6060605@windriver.com> <1367892390.3398.12@snotra>
 <300B73AA675FCE4A93EB4FC1D42459FF3F00D0@039-SN2MPN1-013.039d.mgd.msft.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0700E50E@039-SN2MPN1-011.039d.mgd.msft.net>
 <518B54A6.1070505@windriver.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0700E563@039-SN2MPN1-011.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="HWvPVVuAAfuRc6SZ"
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D0700E563@039-SN2MPN1-011.039d.mgd.msft.net>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Caraman Mihai Claudiu-B02008 <B02008@freescale.com>,
 "agraf@suse.de" <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "tiejun.chen" <tiejun.chen@windriver.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--HWvPVVuAAfuRc6SZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2013 at 07:51:09AM +0000, Bhushan Bharat-R65777 wrote:
>=20
>=20
> > -----Original Message-----
> > From: tiejun.chen [mailto:tiejun.chen@windriver.com]
> > Sent: Thursday, May 09, 2013 1:18 PM
> > To: Bhushan Bharat-R65777
> > Cc: Caraman Mihai Claudiu-B02008; Wood Scott-B07421; linuxppc-
> > dev@lists.ozlabs.org; agraf@suse.de; kvm-ppc@vger.kernel.org;
> > kvm@vger.kernel.org
> > Subject: Re: [RFC][KVM][PATCH 1/1] kvm:ppc:booke-64: soft-disable inter=
rupts
> >=20
> > On 05/09/2013 03:33 PM, Bhushan Bharat-R65777 wrote:
> > >
> > >
> > >> -----Original Message-----
> > >> From: Linuxppc-dev [mailto:linuxppc-dev-
> > >> bounces+bharat.bhushan=3Dfreescale.com@lists.ozlabs.org] On Behalf Of
> > >> bounces+Caraman
> > >> Mihai Claudiu-B02008
> > >> Sent: Wednesday, May 08, 2013 6:44 PM
> > >> To: Wood Scott-B07421; tiejun.chen
> > >> Cc: linuxppc-dev@lists.ozlabs.org; agraf@suse.de;
> > >> kvm-ppc@vger.kernel.org; kvm@vger.kernel.org
> > >> Subject: RE: [RFC][KVM][PATCH 1/1] kvm:ppc:booke-64: soft-disable
> > >> interrupts
> > >>
> > >>>> This only disable soft interrupt for kvmppc_restart_interrupt()
> > >>>> that restarts interrupts if they were meant for the host:
> > >>>>
> > >>>> a. SOFT_DISABLE_INTS() only for BOOKE_INTERRUPT_EXTERNAL |
> > >>>> BOOKE_INTERRUPT_DECREMENTER | BOOKE_INTERRUPT_DOORBELL
> > >>>
> > >>> Those aren't the only exceptions that can end up going to the host.
> > >>> We could get a TLB miss that results in a heavyweight MMIO exit, et=
c.
> > >>>
> > >>>> And shouldn't we handle kvmppc_restart_interrupt() like the
> > >>>> original HOST flow?
> > >>>>
> > >>>> #define MASKABLE_EXCEPTION(trapnum, intnum, label, hdlr,
> > >>>> ack)           \
> > >>>>
> > >>>> START_EXCEPTION(label);                                         \
> > >>>>          NORMAL_EXCEPTION_PROLOG(trapnum, intnum,
> > >>>> PROLOG_ADDITION_MASKABLE)\
> > >>>>          EXCEPTION_COMMON(trapnum, PACA_EXGEN,
> > >>>> *INTS_DISABLE*)             \
> > >>>> 	...
> > >>>
> > >>> Could you elaborate on what you mean?
> > >>
> > >> I think Tiejun was saying that host has flags and replays only
> > >> EE/DEC/DBELL interrupts. There is special macro
> > >> masked_interrupt_book3e in those exception handlers that sets paca-
> > >irq_happened.
> > >>
> > >> The list of replied interrupts is limited to asynchronous noncritical
> > >> interrupts which can be masked by MSR[EE] (therefore no TLB miss).
> > >
> > > Embedded Perfmon interrupt is also asynchronous, Why that is not in t=
he list
> > of masked interruts.
> >=20
> > Are you saying perfmon? If so, its also in that list:
> >=20
> >          START_EXCEPTION(perfmon);
> >          NORMAL_EXCEPTION_PROLOG(0x260, BOOKE_INTERRUPT_PERFORMANCE_MON=
ITOR,
> >                                  PROLOG_ADDITION_NONE)
> >          EXCEPTION_COMMON(0x260, PACA_EXGEN, INTS_DISABLE)
>=20
> Where it is recorded in paca->irq_happned to be replayed later ?

Actually we don't want replay the perfmon interrupt later. We would run it
even soft irq is disabled and just treat it as NMI. Please see the following
function quoted from arch/powerpc/perf/core-fsl-emb.c:
  /*
   * If interrupts were soft-disabled when a PMU interrupt occurs, treat
   * it as an NMI.
   */
  static inline int perf_intr_is_nmi(struct pt_regs *regs)
  {
  #ifdef __powerpc64__                                                     =
                                                                           =
                        =20
          return !regs->softe;
  #else
          return 0;
  #endif
  }

Thanks,
Kevin

>=20
> >=20
> > Tiejun
> >=20
> > >
> > > -Bharat
> > >
> > >> Now on KVM book3e we
> > >> don't want to put them in the irq_happened lazy state but rather to
> > >> execute them directly, so there is no reason for exception handling
> > >> symmetry between host and guest.
> > >>
> > >> -Mike
> >=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

--HWvPVVuAAfuRc6SZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJRi1ltAAoJEJNY7TDerrFxYn4H/0Xq78EBnJfMssO9O569hv7J
+3NOH/rGlN2TURIg+cseiSw8oGEBDeS4U7cuCFThMWVHZM/Hg78/SEDCMH0BA22B
8eea/HzmvI7I2gTgLdkN0ul7HDAh2Groy585iiwrNnV2RMG6sKKmXGIpWJkuZmMj
xPg4K6n8tUFMFOe1ymVRcpO/U+d5Ybby0FhEtWBl8ktWKklPi45JrS5tb4cuxXGv
kF86cOlGw2uMWT9VO1iZhGSlO0aI3I/0klfUemfQsAI8yAde863MzDeJnCBHRM+U
k2SRd/l2fzCyaqqwC8SWxeVVuYHEsGpf6cHw1ubcVIDUnlZSI/B6cmJCUg0AzjA=
=UIxp
-----END PGP SIGNATURE-----

--HWvPVVuAAfuRc6SZ--
