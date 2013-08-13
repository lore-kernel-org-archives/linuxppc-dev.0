Return-Path: <R65777@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9E8702C00FF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 01:30:19 +1000 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: RE: Powerpc: Kernel warn_on when enabling IOMMU_API
Date: Tue, 13 Aug 2013 15:30:08 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D0710F95C@039-SN2MPN1-013.039d.mgd.msft.net>
References: <6A3DF150A5B70D4F9B66A25E3F7C888D0710DCBF@039-SN2MPN1-013.039d.mgd.msft.net>
 <5208ED95.4090204@ozlabs.ru>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0710E32E@039-SN2MPN1-013.039d.mgd.msft.net>
 <520979A6.8040200@ozlabs.ru>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0710F3DA@039-SN2MPN1-013.039d.mgd.msft.net>
 <520A2C9E.7070004@ozlabs.ru>
In-Reply-To: <520A2C9E.7070004@ozlabs.ru>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Alexey Kardashevskiy [mailto:aik@ozlabs.ru]
> Sent: Tuesday, August 13, 2013 6:25 PM
> To: Bhushan Bharat-R65777
> Cc: benh@kernel.crashing.org; linuxppc-dev@lists.ozlabs.org
> Subject: Re: Powerpc: Kernel warn_on when enabling IOMMU_API
>=20
> On 08/13/2013 08:44 PM, Bhushan Bharat-R65777 wrote:
> >
> >
> >> -----Original Message----- From: Alexey Kardashevskiy
> >> [mailto:aik@ozlabs.ru] Sent: Tuesday, August 13, 2013 5:41 AM To:
> >> Bhushan Bharat-R65777 Cc: benh@kernel.crashing.org;
> >> linuxppc-dev@lists.ozlabs.org Subject: Re: Powerpc: Kernel warn_on
> >> when enabling IOMMU_API
> >>
> >> On 08/13/2013 02:14 AM, Bhushan Bharat-R65777 wrote:
> >>>
> >>>
> >>>> -----Original Message----- From: Alexey Kardashevskiy
> >>>> [mailto:aik@ozlabs.ru] Sent: Monday, August 12, 2013 7:44 PM To:
> >>>> Bhushan Bharat-R65777 Cc: benh@kernel.crashing.org;
> >>>> linuxppc-dev@lists.ozlabs.org Subject: Re: Powerpc: Kernel warn_on
> >>>> when enabling IOMMU_API
> >>>>
> >>>> On 08/12/2013 08:20 PM, Bhushan Bharat-R65777 wrote:
> >>>>> And this simple fix work for me diff --git
> >>>>> a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c index
> >>>>> b20ff17..8869b0d 100644 --- a/arch/powerpc/kernel/iommu.c
> >>>>> +++ b/arch/powerpc/kernel/iommu.c @@ -48,6 +48,8 @@ #include
> >>>>> <asm/vio.h> #include <asm/tce.h>
> >>>>>
> >>>>> +#define DEBUG + #define DBG(...)
> >>>>>
> >>>>> static int novmerge; @@ -871,7 +873,7 @@ void
> >>>>> iommu_free_coherent(struct iommu_table *tbl, size_t
> >>>> size,
> >>>>> } }
> >>>>>
> >>>>> -#ifdef CONFIG_IOMMU_API +#ifdef SPAPR_TCE_IOMMU /* * SPAPR TCE
> >>>>> API */ ----------------------
> >>>>
> >>>>
> >>>> And with this fix, what does "ls -laR /sys/kernel/iommu_groups/"
> >>>> print?
> >>>
> >>> It shows the list of group id and respective devices:
> >>>
> >>
> >> Is it vanilla 3.11-rc1 kernel? Wow. What does "lspci" show there?
> >
> > It is 3.11-rc1 + (FSL_IOMMU + VFIO-PCI : local changes).
> >
> > root@p5040ds:~# lspci
> 00:00.0 Class 0604: 1957:0450
> 01:00.0 Class 0200: 8086:10fb
> 00:00.0 Class 0604: 1957:0450
> 01:00.0 Class 0200: 8086:10d3
>=20
>=20
> Is it one PCI domain or two PCI domains? Hm.
>=20
> > We uses the bus_set_iommu(), generic iommu api, which creates a
> > iommu_group for a device (drivers/iommu/iommu.c) using. Also this have
> > notifier to support hotplug-able device. So when this initcall (in
> > arch/powerpc/kernel/iommu.c) is called, iommu group is already setup
> > for the device/s.
>=20
> > I think we do not need this piece of code for powerpc. So what is the
> > best way to stub this out for FSL PowerPC/IOMMU?
>=20
>=20
> So you implemented iommu_ops? Can you share your code somewhere, just to =
have a
> look?

https://lkml.org/lkml/2013/7/1/158

>=20
>=20
> > Will the above #ifdef SPAPR_TCE_IOMMU work? Other way can be selecting
> > iommu.c and dma-iommu.c in Makefile if SPAPR_TCE_IOMMU defined and not
> > if CONFIG_64BIT.
>=20
> If SPAPR_TCE_IOMMU is enabled, the code would compile and the subsys_init=
 would
> be called anyway, so normal production kernel will fail anyway.

We will not enable this on FSL powerpc,

-Bharat

>=20
>=20
>=20
> --
> Alexey
