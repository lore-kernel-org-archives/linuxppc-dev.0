Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7457F2C0154
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Aug 2013 08:04:46 +1000 (EST)
Message-ID: <1376345070.20487.41.camel@snotra.buserror.net>
Subject: Re: [RFC PATCH 1/1] powerpc/embedded6xx: Add support for
 Motorola/Emerson MVME5100.
From: Scott Wood <scottwood@freescale.com>
To: Stephen N Chivers <schivers@csc.com.au>
Date: Mon, 12 Aug 2013 17:04:30 -0500
In-Reply-To: <OF23301F36.A839CDA8-ONCA257BC5.0073F671-CA257BC5.00789A7F@csc.com>
References: <OFBCFBBD51.E4ECB0DF-ONCA257BC0.0083C866-CA257BC1.0000531E@csc.com>
 <B7B7FD2F-8272-487C-B946-154107EF7C09@kernel.crashing.org>
 <1375985244.4514.21.camel@snotra.buserror.net>
 <OF23301F36.A839CDA8-ONCA257BC5.0073F671-CA257BC5.00789A7F@csc.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Chris Proctor <cproctor@csc.com.au>, linuxppc-dev@lists.ozlabs.org,
 paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-08-13 at 08:57 +1100, Stephen N Chivers wrote:
> Scott Wood <scottwood@freescale.com> wrote on 08/09/2013 04:07:24 AM:
> 
> > From: Scott Wood <scottwood@freescale.com>
> > To: Kumar Gala <galak@kernel.crashing.org>
> > Cc: Stephen N Chivers <schivers@csc.com.au>, <paulus@samba.org>, 
> > <linuxppc-dev@lists.ozlabs.org>, Chris Proctor <cproctor@csc.com.au>
> > Date: 08/09/2013 04:08 AM
> > Subject: Re: [RFC PATCH 1/1] powerpc/embedded6xx: Add support for 
> > Motorola/Emerson MVME5100.
> > 
> > On Thu, 2013-08-08 at 10:30 -0500, Kumar Gala wrote:
> > > Also, we don't take full defconfigs in the tree, look at 'make 
> > savedefconfig'
> > 
> > Why does this board need its own defconfig at all?  Just add it to
> > ppc6xx_defconfig.
> 
> The boards firmware as stated above is PPCBug. PPCBug is not Open Firmware
> compatible.
> 
> There is no U-Boot support for the board.

I'm not sure why that precludes the use of ppc6xx_defconfig...

> In ppc6xx_defconfig the e100 network device and NFS support is modular and
> that forces the use of an initrd.

OK, then let's enable those in ppc6xx_defconfig.  We do in a lot of the
other defconfigs (such as 85xx and derivatives).

> PPCBugs network boot command takes only one file argument and so makes
> it difficult to use an initrd.
> 
> So the choices are:
>         - Providing a defconfig for the board,
>         - Building the kernel with the initrd embedded in it,
>         - Finding an alternative boot loader,
>         - Doing the board support for U-Boot.
> The first choice is simple and documents the configuration of the
> board without mixing it into ppc6xx_defconfig.

The first choice means your board would get much less build-testing, and
would increase maintenance costs of defconfig changes (and/or lead to
divergence from other defconfigs that doesn't actually have anything to
do with this board or its use cases).

The fifth choice is "add what you need to ppc6xx_defconfig".  Within
reason of course, but I think a common PCI network device and NFS root
support is reasonable.

-Scott
