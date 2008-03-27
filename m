Return-Path: <dgibson@ozlabs.org>
Date: Thu, 27 Mar 2008 20:44:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH 2/2] [POWERPC] Describe memory-mapped RAM&ROM chips of
	bindings
Message-ID: <20080327094401.GB10397@localhost.localdomain>
References: <200803261344.26555.laurentp@cse-semaphore.com>
	<d195a61e876d685ea04b29474da187cc@kernel.crashing.org>
	<200803271037.17654.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200803271037.17654.laurentp@cse-semaphore.com>
Cc: ben@simtec.co.uk, linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 27, 2008 at 10:37:17AM +0100, Laurent Pinchart wrote:
> On Wednesday 26 March 2008 15:52, Segher Boessenkool wrote:
> > > +    Dedicated RAM and ROM chips are often used as storage for 
> > > temporary or
> > > +    permanent data in embedded devices. Possible usage include 
> > > non-volatile
> > > +    storage in battery-backed SRAM, semi-permanent storage in 
> > > dedicated SRAM
> > > +    to preserve data accross reboots and firmware storage in 
> > > dedicated ROM.
> > > +
> > > +     - compatible : should contain the specific model of RAM/ROM 
> > > chip(s)
> > > +       used, if known, followed by either "physmap-ram" or 
> > > "physmap-rom"
> > > +     - reg : Address range of the RAM/ROM chip
> > > +     - bank-width : Width (in bytes) of the RAM/ROM bank. Equal to the
> > > +       device width times the number of interleaved chips.
> > > +     - device-width : (optional) Width of a single RAM/ROM chip. If
> > > +       omitted, assumed to be equal to 'bank-width'.
> > 
> > Maybe I'm rehashing some old discussion here, if so, sorry; but why
> > do you have bank-width and device-width here?  What useful information
> > does it provide?  If this is about saying what the preferred (or only
> > possible) access width is, better names are in order.
> 
> device-width isn't used so we can get rid of it. bank-width is used by the 
> map_ram driver for erase operations (mapram_erase in 
> drivers/mtd/chips/map_ram.c). To be honest I'm not sure why it uses such an 
> inefficient approach instead of memsetting the whole area.

Sounds like bank-width is meaningless then, and doesn't belong in the
device tree.  The shim which instantiates the mtd device from the
device tree can make something up.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
