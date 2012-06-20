Return-Path: <B38951@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 84269B7017
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2012 12:33:56 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Bhushan Bharat-R65777 <R65777@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>
Subject: RE: [PATCH 0/6] Description for PCI patches using platform driver
Date: Wed, 20 Jun 2012 02:33:45 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01A0C2DA@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1339148527-16911-1-git-send-email-B38951@freescale.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D03D71F38@039-SN2MPN1-022.039d.mgd.msft.net>
 <412C8208B4A0464FA894C5F0C278CD5D01A0921B@039-SN1MPN1-002.039d.mgd.msft.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D03D78FAE@039-SN2MPN1-022.039d.mgd.msft.net>
 <412C8208B4A0464FA894C5F0C278CD5D01A0973E@039-SN1MPN1-002.039d.mgd.msft.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D03D84C22@039-SN2MPN1-022.039d.mgd.msft.net>
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D03D84C22@039-SN2MPN1-022.039d.mgd.msft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Ben, Kumar, others:

This series of patches had been pending for a long time on upstream.
We fixed some issues we found and there still some issues should be
discussed like swiotlb init thing. Do you have time for a review?

Thanks.
-Jia Hongtao.

> -----Original Message-----
> From: Bhushan Bharat-R65777
> Sent: Thursday, June 14, 2012 5:52 PM
> To: Jia Hongtao-B38951; linuxppc-dev@lists.ozlabs.org;
> galak@kernel.crashing.org; benh@kernel.crashing.org
> Cc: Li Yang-R58472; Wood Scott-B07421
> Subject: RE: [PATCH 0/6] Description for PCI patches using platform
> driver
>=20
> Hello Ben, Kumar, others
>=20
> Please provide your comments/thoughts on this ?
>=20
> Thanks
> -Bharat
>=20
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Jia Hongtao-B38951
> > > > > > Sent: Friday, June 08, 2012 3:12 PM
> > > > > > To: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org
> > > > > > Cc: Li Yang-R58472; benh@kernel.crashing.org; Wood Scott-B07421=
;
> > > > > Bhushan Bharat-
> > > > > > R65777; Jia Hongtao-B38951
> > > > > > Subject: [PATCH 0/6] Description for PCI patches using platform
> > > > > > driver
> > > > > >
> > > > > > This series of patches are to unify pci initialization code and
> > > > > > add PM
> > > > > support
> > > > > > for all 85xx/86xx powerpc boards. But two side effects are
> > > > > > introduced
> > > > > by this
> > > > > > mechanism which listed below:
> > > > > >
> > > > > > 1. of_platform_bus_probe() will be called twice but in some
> > > > > > cases
> > > > > duplication
> > > > > >    warning occured. We fix this in [PATCH 5/6].
> > > > > >
> > > > > > 2. Edac driver failed to register pci nodes as platform devices=
.
> > > > > > We fix
> > > > > this
> > > > > >    in [PATCH 6/6].
> > > > >
> > > > > With these patches will not the SWIOTLB will not be initialized
> > > > > even if PCI/PCIe demanded?
> > > > >
> > > > > Thanks
> > > > > -Bharat
> > > > >
> > > >
> > > > These patches still have the swiotlb init problem if
> > > "ppc_swiotlb_enable" is
> > > > only demanded by PCI/PCIe. One of the purposes of sending out these
> > > patches is
> > > > to let us start a discussion for this problem in upstream.
> > >
> > > Ok, I did not find any mention of that, so I thought that you have
> > > resolved the issue by some means in these patches which I did not
> catch.
> > >
> > > So, these patches introduces the issue, that SWIOTLB will not be
> > > initialized if requested by pci/pcie. The request is raised by
> setting
> > > the flag ppc_swiotlb_enable. The swiotlb_init() will be called in
> > > mem_init() if ppc_swiotlb_enable is set. Now with these patches, the
> > > request is raised after mem_init() is called. So request not
> handled :).
> > >
> > > Following are the solutions we have thought of during our internal
> > > discussions (if I did not missed any):
> > >
> > > 1. These patches move the code from platform init to device init
> > > (arch_initcall()). Rather than moving the whole code, let us divide
> > > the code into two. First, which is needed to raise the swiotlb init
> > > request and second the rest. Define this first as an function in
> > > arch/powerpc/sysdev/fsl_pci.c and call this from platform init code
> of
> > > the SOCs.
> > >
> > > 2. All known devices, the lowest PCIe outbound range starts at
> > > 0x80000000, but there's nothing above 0xc0000000. So the inbound of
> > > size 0x8000_0000 is always availbe on all devices. Hardcode the check
> > > in platform code to check memblock_end_of_DRAM() to 0x80000000.
> > >
> > > Something like this:
> > >
> > > diff --git a/arch/powerpc/platforms/85xx/corenet_ds.c
> > > b/arch/powerpc/platforms/85xx/corenet_ds.c
> > > index 1f7028e..ef4e215 100644
> > > --- a/arch/powerpc/platforms/85xx/corenet_ds.c
> > > +++ b/arch/powerpc/platforms/85xx/corenet_ds.c
> > > @@ -79,7 +79,7 @@ void __init corenet_ds_setup_arch(void)  #endif
> > >
> > > #ifdef CONFIG_SWIOTLB
> > > -       if (memblock_end_of_DRAM() > 0xffffffff)
> > > +       if (memblock_end_of_DRAM() > 0xff000000)
> > >                  ppc_swiotlb_enable =3D 1;  #endif
> > >          pr_info("%s board from Freescale Semiconductor\n",
> > > ppc_md.name);
> > >
> > > -------------
> > >
> > > 3. Always do swiotlb_init() in mem_init() and later after PCI init,
> if
> > > the swiotlb is not needed then free it (swiotlb_free()).
> > >
> > > 4. etc, please provide some other better way.
> > >
> > > Thanks
> > > -Bharat
> >
> > Thanks.
> > In my point of view the 2nd solution is better for it does not treat
> PCI/PCIe as
> > the special kind of devices from others.
> >
> > -Jia Hongtao.
