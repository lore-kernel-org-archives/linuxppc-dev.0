Return-Path: <schivers@csc.com.au>
Received: from mail1.bemta7.messagelabs.com (mail1.bemta7.messagelabs.com
 [216.82.254.110])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.bemta7.messagelabs.com",
 Issuer "VeriSign Class 3 International Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1DD7E2C0113
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 06:58:29 +1000 (EST)
In-Reply-To: <1376345070.20487.41.camel@snotra.buserror.net>
References: <OFBCFBBD51.E4ECB0DF-ONCA257BC0.0083C866-CA257BC1.0000531E@csc.com>		
 <B7B7FD2F-8272-487C-B946-154107EF7C09@kernel.crashing.org>
 <1375985244.4514.21.camel@snotra.buserror.net>	
 <OF23301F36.A839CDA8-ONCA257BC5.0073F671-CA257BC5.00789A7F@csc.com>
 <1376345070.20487.41.camel@snotra.buserror.net>
To: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 1/1] powerpc/embedded6xx: Add support for
 Motorola/Emerson MVME5100.
From: Stephen N Chivers <schivers@csc.com.au>
Message-ID: <OFE77F59FB.5CB18F2A-ONCA257BCB.007040E3-CA257BCB.00733D8F@csc.com>
Date: Mon, 19 Aug 2013 07:58:35 +1100
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

Scott Wood <scottwood@freescale.com> wrote on 08/13/2013 08:04:30 AM:

> From: Scott Wood <scottwood@freescale.com>
> To: Stephen N Chivers <schivers@csc.com.au>
> Cc: Chris Proctor <cproctor@csc.com.au>, Kumar Gala 
> <galak@kernel.crashing.org>, <linuxppc-dev@lists.ozlabs.org>, 
> <paulus@samba.org>
> Date: 08/13/2013 08:04 AM
> Subject: Re: [RFC PATCH 1/1] powerpc/embedded6xx: Add support for 
> Motorola/Emerson MVME5100.
> 
> On Tue, 2013-08-13 at 08:57 +1100, Stephen N Chivers wrote:
> > Scott Wood <scottwood@freescale.com> wrote on 08/09/2013 04:07:24 AM:
> > 
> > > From: Scott Wood <scottwood@freescale.com>
> > > To: Kumar Gala <galak@kernel.crashing.org>
> > > Cc: Stephen N Chivers <schivers@csc.com.au>, <paulus@samba.org>, 
> > > <linuxppc-dev@lists.ozlabs.org>, Chris Proctor <cproctor@csc.com.au>
> > > Date: 08/09/2013 04:08 AM
> > > Subject: Re: [RFC PATCH 1/1] powerpc/embedded6xx: Add support for 
> > > Motorola/Emerson MVME5100.
> > > 
> > > On Thu, 2013-08-08 at 10:30 -0500, Kumar Gala wrote:
> > > > Also, we don't take full defconfigs in the tree, look at 'make 
> > > savedefconfig'
> > > 
> > > Why does this board need its own defconfig at all?  Just add it to
> > > ppc6xx_defconfig.
> > 
> > The boards firmware as stated above is PPCBug. PPCBug is not Open 
Firmware
> > compatible.
> > 
> > There is no U-Boot support for the board.
> 
> I'm not sure why that precludes the use of ppc6xx_defconfig...
> 
> > In ppc6xx_defconfig the e100 network device and NFS support is modular 
and
> > that forces the use of an initrd.
> 
> OK, then let's enable those in ppc6xx_defconfig.  We do in a lot of the
> other defconfigs (such as 85xx and derivatives).
> 
> > PPCBugs network boot command takes only one file argument and so makes
> > it difficult to use an initrd.
> > 
> > So the choices are:
> >         - Providing a defconfig for the board,
> >         - Building the kernel with the initrd embedded in it,
> >         - Finding an alternative boot loader,
> >         - Doing the board support for U-Boot.
> > The first choice is simple and documents the configuration of the
> > board without mixing it into ppc6xx_defconfig.
> 
> The first choice means your board would get much less build-testing, and
> would increase maintenance costs of defconfig changes (and/or lead to
> divergence from other defconfigs that doesn't actually have anything to
> do with this board or its use cases).
> 
> The fifth choice is "add what you need to ppc6xx_defconfig".  Within
> reason of course, but I think a common PCI network device and NFS root
> support is reasonable.
Thanks for the suggestion.

I have tried it and ppc6xx_defconfig does generate a viable kernel for
the MVME5100 but there is a total lack of serial console messages.

The reason is due to the requirement for a register shift to access the
UART register(s) on (via) the HAWK ASIC. The HAWK ASIC is very likely to
be a MPC107/TSI107, making it compatible with "tsi-bridge". The TSI
bridges also require register shifts to access their "built-in" UARTS.

I will check the MPC107 data sheet against the TSI107 datasheet
and the MVME5100 programmers manual later today.

The serial console setup in 'legacy_serial' does not support reg-shift
or reg-offset properties and so a preferred_console is not added by it.
The DTS file for the board does specify the register shift so that
'of_serial' will correctly setup the UARTS. But that is too late, the
preferred console will be tty0 as the .config derived from 
ppc6xx_defconfig
has CONF_VT_CONSOLE set. In the test kernels I have built 'con_init' in
the VT support is always called before serial8250_console_init.

I did try modifying legacy_serial to correctly support the tsi-bridge
UARTS and add the preferred console but encountered even more problems
in 8250_core when registering the serial console (to the point of
having a silently panic'ing kernel).

So I think for the moment, the board will need its own default config.

I think similar problems would occur for the Holly and MPC7448_HPC2 boards
as these also have tsi-bridges, but their dts files do not specify the
reg-shift properties. This begs the question do the serial consoles
for Holly and MPC7448_HPC2 actually work?
> 
> -Scott
> 
> 
> 
