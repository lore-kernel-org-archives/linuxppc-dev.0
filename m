Return-Path: <jdl@freescale.com>
Received: from motgate6.mot.com (motgate6.mot.com [144.189.100.106])
	by ozlabs.org (Postfix) with ESMTP id 3EA3A2BDA0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Oct 2004 01:39:38 +1000 (EST)
Received: from az33exr03.mot.com (az33exr03.mot.com [10.64.251.233])
	by motgate6.mot.com (Motorola/Motgate6) with ESMTP id i9EFdY3x027050
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Oct 2004 08:39:34 -0700 (MST)
Received: from postal.somerset.sps.mot.com (postal.somerset.sps.mot.com
	[163.12.132.5])
	by az33exr03.mot.com (Motorola/az33exr03) with ESMTP id i9EFdH6I017609
	for <linuxppc-embedded@ozlabs.org>; Thu, 14 Oct 2004 10:39:17 -0500
Received: from [10.82.19.2] (cashmere.sps.mot.com [10.82.19.2])
	by postal.somerset.sps.mot.com (8.11.0/8.11.0) with ESMTP id
	i9EFdW825280 for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Oct 2004 10:39:32 -0500 (CDT)
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
In-Reply-To: <004401c4b1d3$1ac0df40$5201a8c0@GEG2400>
References: <004401c4b1d3$1ac0df40$5201a8c0@GEG2400>
Content-Type: text/plain
Message-Id: <1097768371.14656.17.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Thu, 14 Oct 2004 10:39:31 -0500
Subject: RE: MPC8560 problem to launch user application like /sbin/init
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2004-10-14 at 04:49, Laurent Lagrange wrote:
> Hi,
> 
> 
> > Have you turned on emulation of FP in the kernel?
> No I did not it, but with the FP emulation on, the Linux runs...
> Many thanks for your help.

Excellent!

> > > The console is mapped on SCC1 port.
> > > CCSRBAR is mapped at 0xF8000000 and immr at 0xF8080000.
> > I would suggest using the standard memory map the rest of
> > us use for 8560.  It makes the porting lots easier.
> Sure. But where can I find the standard rules ?
> Are the rules dependent on each demo board like 8560_ads ?
> Do the custom boots respect some rules ?

Uh, rules?  No, but in the U-Boot tree, you can find them
in the file u-boot/doc/README.mpc85xxads and, related,
README.mpc85xxcds.  Relevant section here:

2. MEMORY MAP TO WORK WITH LINUX KERNEL

2.1. For the initial bringup, we adopted a consistent memory scheme
     between u-boot and linux kernel, you can customize it based on your
     system requirements:

     0x0000_0000     0x7fff_ffff     DDR                     2G
     0x8000_0000     0x9fff_ffff     PCI MEM                 512M
     0xc000_0000     0xdfff_ffff     Rapid IO                512M
     0xe000_0000     0xe00f_ffff     CCSR                    1M
     0xe200_0000     0xe2ff_ffff     PCI IO                  16M
     0xf000_0000     0xf7ff_ffff     SDRAM                   128M
     0xf800_0000     0xf80f_ffff     BCSR                    1M
     0xff00_0000     0xffff_ffff     FLASH (boot bank)       16M

and from the CDS README:

Memory Map
----------

The memory map for u-boot and linux has been extended w.r.t. the ADS
platform to allow for utilization of all 85xx CDS devices.  The memory
map is setup for linux to operate properly.  The linux source when
configured for MPC85xx CDS has been updated to reflect the new memory
map.

The mapping is:

   0x0000_0000     0x7fff_ffff     DDR                     2G
   0x8000_0000     0x9fff_ffff     PCI1 MEM                512M
   0xa000_0000     0xbfff_ffff     PCI2 MEM                512M
   0xe000_0000     0xe00f_ffff     CCSR                    1M
   0xe200_0000     0xe2ff_ffff     PCI1 IO                 16M
   0xe300_0000     0xe3ff_ffff     PCI2 IO                 16M
   0xf000_0000     0xf7ff_ffff     SDRAM                   128M
   0xf800_0000     0xf80f_ffff     NVRAM/CADMUS (*)        1M
   0xff00_0000     0xff7f_ffff     FLASH (2nd bank)        8M
   0xff80_0000     0xffff_ffff     FLASH (boot bank)       8M

   (*) The system control registers (CADMUS) start at offset 0xfdb0_4000
   within the NVRAM/CADMUS region of memory.


You can get some of the details from the Linux code in the file

    linuxppc-2.4/arch/ppc/platforms/mpc85xx_ads_common.h

HTH,
jdl
