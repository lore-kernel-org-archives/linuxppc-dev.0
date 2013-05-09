Return-Path: <R65777@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0249.outbound.messaging.microsoft.com [213.199.154.249])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A19DE2C00EC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 May 2013 18:13:02 +1000 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Kevin Hao <haokexin@gmail.com>
Subject: RE: [RFC][KVM][PATCH 1/1] kvm:ppc:booke-64: soft-disable interrupts
Date: Thu, 9 May 2013 08:12:51 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D0700E5F5@039-SN2MPN1-011.039d.mgd.msft.net>
References: <51885F49.6060605@windriver.com> <1367892390.3398.12@snotra>
 <300B73AA675FCE4A93EB4FC1D42459FF3F00D0@039-SN2MPN1-013.039d.mgd.msft.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0700E50E@039-SN2MPN1-011.039d.mgd.msft.net>
 <518B54A6.1070505@windriver.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0700E563@039-SN2MPN1-011.039d.mgd.msft.net>
 <20130509080813.GD2263@pek-khao-d1.corp.ad.wrs.com>
In-Reply-To: <20130509080813.GD2263@pek-khao-d1.corp.ad.wrs.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
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



> -----Original Message-----
> From: Kevin Hao [mailto:haokexin@gmail.com]
> Sent: Thursday, May 09, 2013 1:38 PM
> To: Bhushan Bharat-R65777
> Cc: tiejun.chen; Caraman Mihai Claudiu-B02008; kvm@vger.kernel.org; Wood =
Scott-
> B07421; agraf@suse.de; kvm-ppc@vger.kernel.org; linuxppc-dev@lists.ozlabs=
.org
> Subject: Re: [RFC][KVM][PATCH 1/1] kvm:ppc:booke-64: soft-disable interru=
pts
>=20
> On Thu, May 09, 2013 at 07:51:09AM +0000, Bhushan Bharat-R65777 wrote:
> >
> >
> > > -----Original Message-----
> > > From: tiejun.chen [mailto:tiejun.chen@windriver.com]
> > > Sent: Thursday, May 09, 2013 1:18 PM
> > > To: Bhushan Bharat-R65777
> > > Cc: Caraman Mihai Claudiu-B02008; Wood Scott-B07421; linuxppc-
> > > dev@lists.ozlabs.org; agraf@suse.de; kvm-ppc@vger.kernel.org;
> > > kvm@vger.kernel.org
> > > Subject: Re: [RFC][KVM][PATCH 1/1] kvm:ppc:booke-64: soft-disable
> > > interrupts
> > >
> > > On 05/09/2013 03:33 PM, Bhushan Bharat-R65777 wrote:
> > > >
> > > >
> > > >> -----Original Message-----
> > > >> From: Linuxppc-dev [mailto:linuxppc-dev-
> > > >> bounces+bharat.bhushan=3Dfreescale.com@lists.ozlabs.org] On Behalf
> > > >> bounces+Of Caraman
> > > >> Mihai Claudiu-B02008
> > > >> Sent: Wednesday, May 08, 2013 6:44 PM
> > > >> To: Wood Scott-B07421; tiejun.chen
> > > >> Cc: linuxppc-dev@lists.ozlabs.org; agraf@suse.de;
> > > >> kvm-ppc@vger.kernel.org; kvm@vger.kernel.org
> > > >> Subject: RE: [RFC][KVM][PATCH 1/1] kvm:ppc:booke-64: soft-disable
> > > >> interrupts
> > > >>
> > > >>>> This only disable soft interrupt for kvmppc_restart_interrupt()
> > > >>>> that restarts interrupts if they were meant for the host:
> > > >>>>
> > > >>>> a. SOFT_DISABLE_INTS() only for BOOKE_INTERRUPT_EXTERNAL |
> > > >>>> BOOKE_INTERRUPT_DECREMENTER | BOOKE_INTERRUPT_DOORBELL
> > > >>>
> > > >>> Those aren't the only exceptions that can end up going to the hos=
t.
> > > >>> We could get a TLB miss that results in a heavyweight MMIO exit, =
etc.
> > > >>>
> > > >>>> And shouldn't we handle kvmppc_restart_interrupt() like the
> > > >>>> original HOST flow?
> > > >>>>
> > > >>>> #define MASKABLE_EXCEPTION(trapnum, intnum, label, hdlr,
> > > >>>> ack)           \
> > > >>>>
> > > >>>> START_EXCEPTION(label);                                         =
\
> > > >>>>          NORMAL_EXCEPTION_PROLOG(trapnum, intnum,
> > > >>>> PROLOG_ADDITION_MASKABLE)\
> > > >>>>          EXCEPTION_COMMON(trapnum, PACA_EXGEN,
> > > >>>> *INTS_DISABLE*)             \
> > > >>>> 	...
> > > >>>
> > > >>> Could you elaborate on what you mean?
> > > >>
> > > >> I think Tiejun was saying that host has flags and replays only
> > > >> EE/DEC/DBELL interrupts. There is special macro
> > > >> masked_interrupt_book3e in those exception handlers that sets
> > > >> paca-
> > > >irq_happened.
> > > >>
> > > >> The list of replied interrupts is limited to asynchronous
> > > >> noncritical interrupts which can be masked by MSR[EE] (therefore n=
o TLB
> miss).
> > > >
> > > > Embedded Perfmon interrupt is also asynchronous, Why that is not
> > > > in the list
> > > of masked interruts.
> > >
> > > Are you saying perfmon? If so, its also in that list:
> > >
> > >          START_EXCEPTION(perfmon);
> > >          NORMAL_EXCEPTION_PROLOG(0x260, BOOKE_INTERRUPT_PERFORMANCE_M=
ONITOR,
> > >                                  PROLOG_ADDITION_NONE)
> > >          EXCEPTION_COMMON(0x260, PACA_EXGEN, INTS_DISABLE)
> >
> > Where it is recorded in paca->irq_happned to be replayed later ?
>=20
> Actually we don't want replay the perfmon interrupt later. We would run i=
t even
> soft irq is disabled and just treat it as NMI. Please see the following f=
unction
> quoted from arch/powerpc/perf/core-fsl-emb.c:
>   /*
>    * If interrupts were soft-disabled when a PMU interrupt occurs, treat
>    * it as an NMI.
>    */
>   static inline int perf_intr_is_nmi(struct pt_regs *regs)
>   {
>   #ifdef __powerpc64__
>           return !regs->softe;
>   #else
>           return 0;
>   #endif
>   }

Is it because that we cannot afford to lose perfmon interrupt for more accu=
rate capturing of data ?

-Bharat

>=20
> Thanks,
> Kevin
>=20
> >
> > >
> > > Tiejun
> > >
> > > >
> > > > -Bharat
> > > >
> > > >> Now on KVM book3e we
> > > >> don't want to put them in the irq_happened lazy state but rather
> > > >> to execute them directly, so there is no reason for exception
> > > >> handling symmetry between host and guest.
> > > >>
> > > >> -Mike
> > >
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
