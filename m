Return-Path: <computersforpeace@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfqW12h0wzDqvY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 03:32:28 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id i123so5022987pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 10:32:28 -0700 (PDT)
Date: Wed, 29 Jun 2016 10:32:23 -0700
From: Brian Norris <computersforpeace@gmail.com>
To: Raghav Dogra <raghav.dogra@nxp.com>
Cc: Leo Li <pku.leo@gmail.com>,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 Yang-Leo Li <leoyang.li@nxp.com>,
 Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
 Scott Wood <oss@buserror.net>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Raghav Dogra <raghav@freescale.com>,
 Jaiprakash Singh <b44839@freescale.com>
Subject: Re: [PATCH][v3] mtd/ifc: Add support for IFC controller version 2.0
Message-ID: <20160629173223.GA47625@google.com>
References: <20160406175254.GC5243@localhost>
 <AM2PR04MB0770036256E58407BD045C5A8F9F0@AM2PR04MB0770.eurprd04.prod.outlook.com>
 <20160408024507.69fb4fc1@bbrezillon>
 <CADRPPNRXj_00GF-h_5yHtKPMU=U1C8PXQLZqEVzQvJZobmM7dg@mail.gmail.com>
 <20160525223412.086e45e9@bbrezillon>
 <CADRPPNSeQsOZZ9XRR4BOfZvewoB9RoEy0KzPrRzoDm21LtacnQ@mail.gmail.com>
 <20160527224401.4b776ad4@bbrezillon>
 <20160527211247.GA123214@google.com>
 <CADRPPNR5NXuug7Nig=s8be0yEOB4RKg9zj53t00fdSffo5s72A@mail.gmail.com>
 <DB4PR04MB346C1FA9FCC3906B906E7C589230@DB4PR04MB346.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DB4PR04MB346C1FA9FCC3906B906E7C589230@DB4PR04MB346.eurprd04.prod.outlook.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Wed, Jun 29, 2016 at 02:53:03PM +0000, Raghav Dogra wrote:
> 
> 
> > -----Original Message-----
> > From: Leo Li [mailto:pku.leo@gmail.com]
> > Sent: Saturday, May 28, 2016 3:34 AM

1 month delay? So much for the rush...

> > To: Brian Norris <computersforpeace@gmail.com>; Raghav Dogra
> > <raghav.dogra@nxp.com>
> > Cc: Boris Brezillon <boris.brezillon@free-electrons.com>; Yang-Leo Li
> > <leoyang.li@nxp.com>; Prabhakar Kushwaha
> > <prabhakar.kushwaha@nxp.com>; Scott Wood <oss@buserror.net>; linux-
> > mtd@lists.infradead.org; linuxppc-dev <linuxppc-dev@lists.ozlabs.org>;
> > Raghav Dogra <raghav@freescale.com>; Jaiprakash Singh
> > <b44839@freescale.com>
> > Subject: Re: [PATCH][v3] mtd/ifc: Add support for IFC controller version 2.0
> > 
> > On Fri, May 27, 2016 at 4:12 PM, Brian Norris
> > <computersforpeace@gmail.com> wrote:
> > > On Fri, May 27, 2016 at 10:44:01PM +0200, Boris Brezillon wrote:
> > >> On Fri, 27 May 2016 15:15:00 -0500
> > >> Leo Li <pku.leo@gmail.com> wrote:
> > >> >
> > >> > The pull request does have patch "mtd/ifc: Add support for IFC
> > >> > controller version 2.0", but it doesn't have another patch
> > >> > "driver/memory: Update dependency of IFC for
> > >> > Layerscape"(https://patchwork.ozlabs.org/patch/557389/) needed to
> > >> > make the driver selectable on new hardware.
> > >
[...]

> > >> BTW, in the patch description you say you're only modifying a Kconfig
> > >> dependency, but you're actually doing more than that: you're removing
> > >> an asm header inclusion and manually include several other headers
> > >> (which I guess were previously included by asm/prom.h).
> > >
> > > Please resend this patch with a more complete commit description; I'd
> > > like it to get actual review (and time in linux-next) before it gets
> > > merged, so at best, it'll wait a few -rc's. I also suspect the patch
> > > isn't optimal. I believe Scott has suggested [1] that we didn't need
> > > the FSL_SOC dependency on the LBC driver. I think IFC looks like a
> > > similar case?
> 
> Hi Brian,
> 
> The patch being talked about does not add a FSL_SOC dependency on the IFC driver.
> It uses a generic ARCH_LAYERSCAPE macro to enable IFC. This should be Ok? 

Maybe... but if we know that this driver doesn't actually have an
FSL_SOC dependency, and the FSL maintainers don't really want it in the
first place, then a simpler patch is to just remove the FSL_SOC
dependency, rather than making the deps more complicated.

But anyway, if you resend with the comments addresses (e.g., better
commit description), then we can consider applying it. If the FSL folks
have nothing to contribute here, then I don't see why we wouldn't take
your patch.

Regards,
Brian
