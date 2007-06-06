Return-Path: <dgibson@ozlabs.org>
Date: Wed, 6 Jun 2007 12:39:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
Message-ID: <20070606023939.GC8182@localhost.localdomain>
References: <20070601232022.GA21237@mag.az.mvista.com>
	<20070604205646.GD10612@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070604205646.GD10612@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 04, 2007 at 01:56:46PM -0700, Mark A. Greer wrote:
> Okay, >25 msgs from a ~10 line patch.  I think that's a new personal
> record for me. ;)
> 
> More seriously, I've simply been trying to provide a DT node that works
> with the current code in drivers/mtd/maps/physmap_of.c.  Obviously,
> there are issues with that code and my DT node.
> 
> So to try a different approach, here is the hardware info and a copy of
> the relevant DT that I currently have.  Segher, et. al., if you can
> find the time, please give me your best guidance as to what the DT
> node(s) should really look like (and how physmap.c should really work).
> I'll be happy to hack physmap_of.c once I have a clear understanding of
> how it should work (and there is clear agreement on that :).
> 
> Mark
> ---
> 
> Hardware:
> ---------
> [As I read this, I realize I have the DT node messed up anyway.]
> - Not that this matters but this is a Marvell mv64360/mv64362 based board
>   with a MPC7447A processor.
> - There are two 32MB banks of two Intel Stata Flash (NOR) chips (CFI).
>   Each 32MB bank is 32-bits wide built with two 8Mx16 28F128K3 devices
>   (http://download.intel.com/design/flcomp/datashts/29073709.pdf).
>   Bits 0-15 from the first device, bits 16-31 from the second one.
>   The two banks are contiguous in the processor's physical memory space.
> - The MTD partitions are described in the DT.
> 
> For your reference, the exiting DT:
> -----------------------------------
> 
> 	mv64x60@f1000000 { /* Marvell Discovery */
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 		#interrupt-cells = <1>;
> 		model = "mv64360";			/* Default */
> 		compatible = "marvell,mv64x60";
> 		clock-frequency = <7f28155>;		/* 133.333333 MHz */
> 		reg = <f1000000 00010000>;
> 		virtual-reg = <f1000000>;
> 		ranges = <88000000 88000000 01000000	/* PCI 0 I/O Space */
> 			  80000000 80000000 08000000	/* PCI 0 MEM Space */
> 			  a0000000 a0000000 04000000	/* User FLASH */
> 			  00000000 f1000000 00010000	/* Bridge's regs */
> 			  f2000000 f2000000 00040000>;	/* Integrated SRAM */
> 
> 		flash@a0000000 {
> 			device_type = "rom";
> 			compatible = "direct-mapped";
> 			reg = <a0000000 4000000>; /* Default (64MB) */
> 			probe-type = "CFI";
> 			bank-width = <4>;
> 			partitions = <00000000 00100000 /* RO */
> 				      00100000 00040001 /* RW */
> 				      00140000 00400000 /* RO */
> 				      00540000 039c0000 /* RO */
> 				      03f00000 00100000>; /* RO */
> 			partition-names = "FW Image A", "FW Config Data", "Kernel Image", "Filesystem", "FW Image B";
> 		};

Whatever Segher says, I think it's fine to have the partition
information here.  It may not be hardware information, but it is
(often) firmware information; there are plenty precedents for things
like this in the device tree and it doesn't get in the way of any real
hardware information.

That said, I'm a bit dubious about the encoding of the RO/RW bit into
the partition length (which I only just realised was used now).

I'll have to think some more about the rest.

> So, what should the DT look like for this thing?  And, what should
> phymap_of.c be doing?
> 
> Mark
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
