Return-Path: <R65777@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C723C2C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Aug 2013 02:52:23 +1000 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: RE: Powerpc: Kernel warn_on when enabling IOMMU_API
Date: Mon, 12 Aug 2013 16:52:07 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D0710E441@039-SN2MPN1-013.039d.mgd.msft.net>
References: <6A3DF150A5B70D4F9B66A25E3F7C888D0710DCBF@039-SN2MPN1-013.039d.mgd.msft.net>
 <5208ED95.4090204@ozlabs.ru>
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
> From: Bhushan Bharat-R65777
> Sent: Monday, August 12, 2013 9:45 PM
> To: 'Alexey Kardashevskiy'
> Cc: benh@kernel.crashing.org; linuxppc-dev@lists.ozlabs.org
> Subject: RE: Powerpc: Kernel warn_on when enabling IOMMU_API
>=20
>=20
>=20
> > -----Original Message-----
> > From: Alexey Kardashevskiy [mailto:aik@ozlabs.ru]
> > Sent: Monday, August 12, 2013 7:44 PM
> > To: Bhushan Bharat-R65777
> > Cc: benh@kernel.crashing.org; linuxppc-dev@lists.ozlabs.org
> > Subject: Re: Powerpc: Kernel warn_on when enabling IOMMU_API
> >
> > On 08/12/2013 08:20 PM, Bhushan Bharat-R65777 wrote:
> > > And this simple fix work for me
> > > diff --git a/arch/powerpc/kernel/iommu.c
> > > b/arch/powerpc/kernel/iommu.c index b20ff17..8869b0d 100644
> > > --- a/arch/powerpc/kernel/iommu.c
> > > +++ b/arch/powerpc/kernel/iommu.c
> > > @@ -48,6 +48,8 @@
> > >  #include <asm/vio.h>
> > >  #include <asm/tce.h>
> > >
> > > +#define DEBUG
> > > +
> > >  #define DBG(...)
> > >
> > >  static int novmerge;
> > > @@ -871,7 +873,7 @@ void iommu_free_coherent(struct iommu_table
> > > *tbl, size_t
> > size,
> > >         }
> > >  }
> > >
> > > -#ifdef CONFIG_IOMMU_API
> > > +#ifdef SPAPR_TCE_IOMMU
> > >  /*
> > >   * SPAPR TCE API
> > >   */
> > > ----------------------
> >
> >
> > And with this fix, what does "ls -laR /sys/kernel/iommu_groups/" print?
>=20
> It shows the list of group id and respective devices:

We uses the common iommu code to add a device with iommu_group (drivers/iom=
mu/iommu.c) using bus_set_iommu().
Also this have notifier to support hotplug-able device.
So when this initcall (in arch/powerpc/kernel/iommu.c) is called, iommu gro=
up is already setup.

So we do not this piece of code for powerpc. BTW why we need this with Powe=
r/TCE, does not the code in driver/iommu/iommu.c serve the purpose?

-Bharat

>=20
> root@p5040ds:~# ls -laR /sys/kernel/iommu_groups/
> /sys/kernel/iommu_groups/:
> total 0
> drwxr-xr-x 15 root root 0 Sep  6 01:42 .
> drwxr-xr-x  6 root root 0 Jan  1  1970 ..
> drwxr-xr-x  3 root root 0 Sep  6 01:43 0 drwxr-xr-x  3 root root 0 Sep  6=
 01:43
> 1 drwxr-xr-x  3 root root 0 Sep  6 01:43 10 drwxr-xr-x  3 root root 0 Sep=
  6
> 01:43 11 drwxr-xr-x  3 root root 0 Sep  6 01:43 12 drwxr-xr-x  3 root roo=
t 0 Sep
> 6 01:43 2 drwxr-xr-x  3 root root 0 Sep  6 01:43 3 drwxr-xr-x  3 root roo=
t 0 Sep
> 6 01:43 4 drwxr-xr-x  3 root root 0 Sep  6 01:43 5 drwxr-xr-x  3 root roo=
t 0 Sep
> 6 01:43 6 drwxr-xr-x  3 root root 0 Sep  6 01:43 7 drwxr-xr-x  3 root roo=
t 0 Sep
> 6 01:43 8 drwxr-xr-x  3 root root 0 Sep  6 01:43 9
>=20
> /sys/kernel/iommu_groups/0:
> total 0
> drwxr-xr-x  3 root root 0 Sep  6 01:43 .
> drwxr-xr-x 15 root root 0 Sep  6 01:42 ..
> drwxr-xr-x  2 root root 0 Sep  6 01:43 devices
>=20
> /sys/kernel/iommu_groups/0/devices:
> total 0
> drwxr-xr-x 2 root root 0 Sep  6 01:43 .
> drwxr-xr-x 3 root root 0 Sep  6 01:43 ..
> lrwxrwxrwx 1 root root 0 Sep  6 01:43 ffe100300.dma ->
> ../../../../devices/ffe000000.soc/ffe100300.dma
>=20
> /sys/kernel/iommu_groups/1:
> total 0
> drwxr-xr-x  3 root root 0 Sep  6 01:43 .
> drwxr-xr-x 15 root root 0 Sep  6 01:42 ..
> drwxr-xr-x  2 root root 0 Sep  6 01:43 devices
>=20
> /sys/kernel/iommu_groups/1/devices:
> total 0
> drwxr-xr-x 2 root root 0 Sep  6 01:43 .
> drwxr-xr-x 3 root root 0 Sep  6 01:43 ..
> lrwxrwxrwx 1 root root 0 Sep  6 01:43 ffe101300.dma ->
> ../../../../devices/ffe000000.soc/ffe101300.dma
>=20
> /sys/kernel/iommu_groups/10:
> total 0
> drwxr-xr-x  3 root root 0 Sep  6 01:43 .
> drwxr-xr-x 15 root root 0 Sep  6 01:42 ..
> drwxr-xr-x  2 root root 0 Sep  6 01:43 devices
>=20
> /sys/kernel/iommu_groups/10/devices:
> total 0
> drwxr-xr-x 2 root root 0 Sep  6 01:43 .
> drwxr-xr-x 3 root root 0 Sep  6 01:43 ..
> lrwxrwxrwx 1 root root 0 Sep  6 01:43 ffe302000.jr ->
> ../../../../devices/ffe000000.soc/ffe300000.crypto/ffe302000.jr
>=20
> /sys/kernel/iommu_groups/11:
> total 0
> drwxr-xr-x  3 root root 0 Sep  6 01:43 .
> drwxr-xr-x 15 root root 0 Sep  6 01:42 ..
> drwxr-xr-x  2 root root 0 Sep  6 01:43 devices
>=20
> /sys/kernel/iommu_groups/11/devices:
> total 0
> drwxr-xr-x 2 root root 0 Sep  6 01:43 .
> drwxr-xr-x 3 root root 0 Sep  6 01:43 ..
> lrwxrwxrwx 1 root root 0 Sep  6 01:43 ffe303000.jr ->
> ../../../../devices/ffe000000.soc/ffe300000.crypto/ffe303000.jr
>=20
> /sys/kernel/iommu_groups/12:
> total 0
> drwxr-xr-x  3 root root 0 Sep  6 01:43 .
> drwxr-xr-x 15 root root 0 Sep  6 01:42 ..
> drwxr-xr-x  2 root root 0 Sep  6 01:43 devices
>=20
> /sys/kernel/iommu_groups/12/devices:
> total 0
> drwxr-xr-x 2 root root 0 Sep  6 01:43 .
> drwxr-xr-x 3 root root 0 Sep  6 01:43 ..
> lrwxrwxrwx 1 root root 0 Sep  6 01:43 ffe304000.jr ->
> ../../../../devices/ffe000000.soc/ffe300000.crypto/ffe304000.jr
>=20
> /sys/kernel/iommu_groups/2:
> total 0
> drwxr-xr-x  3 root root 0 Sep  6 01:43 .
> drwxr-xr-x 15 root root 0 Sep  6 01:42 ..
> drwxr-xr-x  2 root root 0 Sep  6 01:43 devices
>=20
> /sys/kernel/iommu_groups/2/devices:
> total 0
> drwxr-xr-x 2 root root 0 Sep  6 01:43 .
> drwxr-xr-x 3 root root 0 Sep  6 01:43 ..
> lrwxrwxrwx 1 root root 0 Sep  6 01:43 ffe114000.sdhc ->
> ../../../../devices/ffe000000.soc/ffe114000.sdhc
>=20
> /sys/kernel/iommu_groups/3:
> total 0
> drwxr-xr-x  3 root root 0 Sep  6 01:43 .
> drwxr-xr-x 15 root root 0 Sep  6 01:42 ..
> drwxr-xr-x  2 root root 0 Sep  6 01:43 devices
>=20
> /sys/kernel/iommu_groups/3/devices:
> total 0
> drwxr-xr-x 2 root root 0 Sep  6 01:43 .
> drwxr-xr-x 3 root root 0 Sep  6 01:43 ..
> lrwxrwxrwx 1 root root 0 Sep  6 01:43 ffe210000.usb ->
> ../../../../devices/ffe000000.soc/ffe210000.usb
>=20
> /sys/kernel/iommu_groups/4:
> total 0
> drwxr-xr-x  3 root root 0 Sep  6 01:43 .
> drwxr-xr-x 15 root root 0 Sep  6 01:42 ..
> drwxr-xr-x  2 root root 0 Sep  6 01:43 devices
>=20
> /sys/kernel/iommu_groups/4/devices:
> total 0
> drwxr-xr-x 2 root root 0 Sep  6 01:43 .
> drwxr-xr-x 3 root root 0 Sep  6 01:43 ..
> lrwxrwxrwx 1 root root 0 Sep  6 01:43 ffe211000.usb ->
> ../../../../devices/ffe000000.soc/ffe211000.usb
>=20
> /sys/kernel/iommu_groups/5:
> total 0
> drwxr-xr-x  3 root root 0 Sep  6 01:43 .
> drwxr-xr-x 15 root root 0 Sep  6 01:42 ..
> drwxr-xr-x  2 root root 0 Sep  6 01:43 devices
>=20
> /sys/kernel/iommu_groups/5/devices:
> total 0
> drwxr-xr-x 2 root root 0 Sep  6 01:43 .
> drwxr-xr-x 3 root root 0 Sep  6 01:43 ..
> lrwxrwxrwx 1 root root 0 Sep  6 01:43 ffe220000.sata ->
> ../../../../devices/ffe000000.soc/ffe220000.sata
>=20
> /sys/kernel/iommu_groups/6:
> total 0
> drwxr-xr-x  3 root root 0 Sep  6 01:43 .
> drwxr-xr-x 15 root root 0 Sep  6 01:42 ..
> drwxr-xr-x  2 root root 0 Sep  6 01:43 devices
>=20
> /sys/kernel/iommu_groups/6/devices:
> total 0
> drwxr-xr-x 2 root root 0 Sep  6 01:43 .
> drwxr-xr-x 3 root root 0 Sep  6 01:43 ..
> lrwxrwxrwx 1 root root 0 Sep  6 01:43 ffe221000.sata ->
> ../../../../devices/ffe000000.soc/ffe221000.sata
>=20
> /sys/kernel/iommu_groups/7:
> total 0
> drwxr-xr-x  3 root root 0 Sep  6 01:43 .
> drwxr-xr-x 15 root root 0 Sep  6 01:42 ..
> drwxr-xr-x  2 root root 0 Sep  6 01:43 devices
>=20
> /sys/kernel/iommu_groups/7/devices:
> total 0
> drwxr-xr-x 2 root root 0 Sep  6 01:43 .
> drwxr-xr-x 3 root root 0 Sep  6 01:43 ..
> lrwxrwxrwx 1 root root 0 Sep  6 01:43 0001:00:00.0 ->
> ../../../../devices/ffe201000.pcie/pci0001:00/0001:00:00.0
> lrwxrwxrwx 1 root root 0 Sep  6 01:43 0001:01:00.0 ->
> ../../../../devices/ffe201000.pcie/pci0001:00/0001:00:00.0/0001:01:00.0
>=20
> /sys/kernel/iommu_groups/8:
> total 0
> drwxr-xr-x  3 root root 0 Sep  6 01:43 .
> drwxr-xr-x 15 root root 0 Sep  6 01:42 ..
> drwxr-xr-x  2 root root 0 Sep  6 01:43 devices
>=20
> /sys/kernel/iommu_groups/8/devices:
> total 0
> drwxr-xr-x 2 root root 0 Sep  6 01:43 .
> drwxr-xr-x 3 root root 0 Sep  6 01:43 ..
> lrwxrwxrwx 1 root root 0 Sep  6 01:43 ffe301000.jr ->
> ../../../../devices/ffe000000.soc/ffe300000.crypto/ffe301000.jr
>=20
> /sys/kernel/iommu_groups/9:
> total 0
> drwxr-xr-x  3 root root 0 Sep  6 01:43 .
> drwxr-xr-x 15 root root 0 Sep  6 01:42 ..
> drwxr-xr-x  2 root root 0 Sep  6 01:43 devices
>=20
> /sys/kernel/iommu_groups/9/devices:
> total 0
> drwxr-xr-x 2 root root 0 Sep  6 01:43 .
> drwxr-xr-x 3 root root 0 Sep  6 01:43 ..
> lrwxrwxrwx 1 root root 0 Sep  6 01:43 0000:00:00.0 ->
> ../../../../devices/ffe200000.pcie/pci0000:00/0000:00:00.0
> lrwxrwxrwx 1 root root 0 Sep  6 01:43 0000:01:00.0 ->
> ../../../../devices/ffe200000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0
>=20
> -Bharat
> >
> >
> >
> > --
> > Alexey
