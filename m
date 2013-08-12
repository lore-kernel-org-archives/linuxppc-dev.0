Return-Path: <schivers@csc.com.au>
Received: from mail1.bemta12.messagelabs.com (mail1.bemta12.messagelabs.com
 [216.82.251.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.bemta12.messagelabs.com",
 Issuer "VeriSign Class 3 International Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 426302C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Aug 2013 08:04:09 +1000 (EST)
In-Reply-To: <1375985244.4514.21.camel@snotra.buserror.net>
References: <OFBCFBBD51.E4ECB0DF-ONCA257BC0.0083C866-CA257BC1.0000531E@csc.com>	
 <B7B7FD2F-8272-487C-B946-154107EF7C09@kernel.crashing.org>
 <1375985244.4514.21.camel@snotra.buserror.net>
To: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 1/1] powerpc/embedded6xx: Add support for
 Motorola/Emerson MVME5100.
From: Stephen N Chivers <schivers@csc.com.au>
Message-ID: <OF23301F36.A839CDA8-ONCA257BC5.0073F671-CA257BC5.00789A7F@csc.com>
Date: Tue, 13 Aug 2013 08:57:10 +1100
Content-Type: text/plain; charset="US-ASCII"
Cc: Chris Proctor <cproctor@csc.com.au>, linuxppc-dev@lists.ozlabs.org,
 paulus@samba.org, Stephen N Chivers <schivers@csc.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <scottwood@freescale.com> wrote on 08/09/2013 04:07:24 AM:

> From: Scott Wood <scottwood@freescale.com>
> To: Kumar Gala <galak@kernel.crashing.org>
> Cc: Stephen N Chivers <schivers@csc.com.au>, <paulus@samba.org>, 
> <linuxppc-dev@lists.ozlabs.org>, Chris Proctor <cproctor@csc.com.au>
> Date: 08/09/2013 04:08 AM
> Subject: Re: [RFC PATCH 1/1] powerpc/embedded6xx: Add support for 
> Motorola/Emerson MVME5100.
> 
> On Thu, 2013-08-08 at 10:30 -0500, Kumar Gala wrote:
> > On Aug 7, 2013, at 7:03 PM, Stephen N Chivers wrote:
> > 
> > > Add support for the Motorola/Emerson MVME5100 Single Board Computer.
> > > 
> > > The MVME5100 is a 6U form factor VME64 computer with:
> > > 
> > >        - A single MPC7410 or MPC750 CPU
> > >        - A HAWK Processor Host Bridge (CPU to PCI) and
> > >          MultiProcessor Interrupt Controller (MPIC)
> > >        - Up to 500Mb of onboard memory
> > >        - A M48T37 Real Time Clock (RTC) and Non-Volatile Memory chip
> > >        - Two 16550 compatible UARTS
> > >        - Two Intel E100 Fast Ethernets
> > >        - Two PCI Mezzanine Card (PMC) Slots
> > >        - PPCBug Firmware
> > > 
> > > The HAWK PHB/MPIC is compatible with the MPC10x devices.
> > > 
> > > There is no onboard disk support. This is usually provided by 
> installing a 
> > > PMC
> > > in first PMC slot.
> > > 
> > > This patch revives the board support, it was present in early 2.6
> > > series kernels. The board support in those days was by Matt Porter 
of
> > > MontaVista Software.
> > > 
> > > CSC Australia has around 31 of these boards in service. The kernel 
in use
> > > for the boards is based on 2.6.31. The boards are operated without 
disks
> > > from a file server. 
> > > 
> > > This patch is based on linux-3.11-rc4 and has been boot tested.
> > > 
> > > Signed-off-by: Stephen Chivers <schivers@csc.com>
> > > ---
> > > arch/powerpc/boot/dts/mvme5100.dts            |  195 ++
> > > arch/powerpc/boot/mvme5100.c                  |   28 +
> > > arch/powerpc/configs/mvme5100_defconfig       | 2597 
> > > +++++++++++++++++++++++++
> > > arch/powerpc/platforms/embedded6xx/mvme5100.c |  288 +++
> > > 4 files changed, 3108 insertions(+), 0 deletions(-)
> > 
> > Please look at fixing the white space issues you seem to have 
> throughout this patch.
> > 
> > Also, we don't take full defconfigs in the tree, look at 'make 
> savedefconfig'
> 
> Why does this board need its own defconfig at all?  Just add it to
> ppc6xx_defconfig.

The boards firmware as stated above is PPCBug. PPCBug is not Open Firmware
compatible.

There is no U-Boot support for the board.

In ppc6xx_defconfig the e100 network device and NFS support is modular and
that forces the use of an initrd.

PPCBugs network boot command takes only one file argument and so makes
it difficult to use an initrd.

So the choices are:
        - Providing a defconfig for the board,
        - Building the kernel with the initrd embedded in it,
        - Finding an alternative boot loader,
        - Doing the board support for U-Boot.
The first choice is simple and documents the configuration of the
board without mixing it into ppc6xx_defconfig.
The second choice would, I believe, fail for ppc6xx_defconfig when built
by the automaton at "kisskb". The failure would be caused by the lack of
a ramdisk in the vanilla kernel source.
For the third, I spent a lot of time over the weekend looking for an
alternative boot loader to no avail. 
The last choice is possibly difficult and would take considerable time.

Other possibilities include:
        - a boot script for PPCBug that loads the initrd first and
          then executes the network boot command. I believe that the
          initrd start and size can be specified in the dts file.
        - porting the "tftplilo" program used with the ancient
          MVME-167 68k SBCs. This is probably feasible as PPCBug is
          a descendant of the older 167Bug. tftplilo uses the network
          routines in 167Bug to do its work and similar things exist
          in PPCBug.

Suggestions please. 
> 
> -Scott
> 
> 
>
Stephen Chivers.
