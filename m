Return-Path: <mgreer@mvista.com>
Date: Wed, 19 Jul 2006 17:39:15 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [HACK] add sandpoint + flattened dt support to arch/powerpc/boot
Message-ID: <20060720003915.GK3887@mag.az.mvista.com>
References: <20060518002142.GA23182@mag.az.mvista.com>
	<1147930376.17679.72.camel@localhost.localdomain>
	<20060523005846.GA15797@mag.az.mvista.com>
	<Pine.LNX.4.60.0607192144310.6432@poirot.grange>
	<20060719221019.GA32203@mag.az.mvista.com>
	<Pine.LNX.4.60.0607200008560.9110@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.60.0607200008560.9110@poirot.grange>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 20, 2006 at 12:29:04AM +0200, Guennadi Liakhovetski wrote:
> On Wed, 19 Jul 2006, Mark A. Greer wrote:
> > 
> > Ben and I have talked a little bit privately and the ball is in my court
> > to produce a set of patches.  To that end, I have them ready so expect to
> > see them shortly.
> 
> Great! So, I can really relax and enjoy my holiday next week in beautiful 
> Eifel:-) And as your patches arrive we'll see how best to integrate 
> kurobox with them.

Okay, but don't be in too much of a rush.  I'm sure there will be
comments that will induce changes to those patches.

> One question so far. Looking at your sandpoint.dts pci map:
> 
> 	ranges = <80000000 80000000 70000000	/* pci mem space */
> 		  fc000000 fc000000 00100000	/* EUMB */
> 		  fe000000 fe000000 00c00000	/* pci i/o space */
> 		  fec00000 fec00000 00300000	/* pci cfg regs */
> 		  fef00000 fef00000 00100000>;	/* pci iack */
> 
> I can match hardware addresses against defines in 
> include/asm-ppc/mpc10x.h,

Don't spend a lot of time in ppc, powerpc is where you need to live now.

> but virtual one - is the map above just an 
> example and anyway-not-used, or is it a new mapping, or am I missing 
> something and it has always been like that (1-to-1)? At least this comment

The above mapping are physical addresses and are a part of the hardware
description passed into the kernel (i.e., the fdt).  It knows nothing
about virtual addresses.

>  * MAP B (CHRP Map)
>  *   Processor: 0xfe000000 - 0xfebfffff -> PCI I/O: 0x00000000 - 0x00bfffff
>  *   Processor: 0x80000000 - 0xbfffffff -> PCI MEM: 0x80000000 - 0xbfffffff
>  *   PCI MEM:   0x00000000 -> Processor System Memory: 0x00000000

This table is telling you how the hardware maps processor physical
memory space to/from PCI I/O and MEM space.  For example, if the
processor reads physical location 0xfe000000 that will go across the
hostbridge and read PCI I/O location/register 0 (assuming there is a
PCI device set to respond to that PCI I/O address).  If a PCI device
reads PCI MEM address 0 it will go across the hostbridge and read
address 0 of the processor's physical address space (i.e., system
memory address 0).

>  *   EUMB mapped to: ioremap_base - 0x00100000 (ioremap_base - 1 MB)
> 
> seems to contradict with the above map in pci io area, as well as this 
> one:
> 
> 	 * Want processor accesses of 0xFDxxxxxx to be mapped
> 	 * to PCI memory space at 0x00000000.  Do not want
> 
> Actually, I cannot even match these 2 together?

You need to read the "Address Map B Options Register" section of the
824x or 10x manuals.  This is talking about an alias capability of the
hardware that I enabled...but as I think about it, I probably shouldn't
have. 8-P  Anyway, if you get confused by a comment, read the code--code
doesn't lie...it may be wrong, but it doesn't lie. ;)

Mark
--
