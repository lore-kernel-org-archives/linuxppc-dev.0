Return-Path: <dgibson@ozlabs.org>
Date: Thu, 28 Jun 2007 10:38:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 3/3] First cut at PReP support for arch/powerpc
Message-ID: <20070628003813.GC15298@localhost.localdomain>
References: <20070627071008.GA30648@localhost.localdomain>
	<d8960a6c86859c19b84dc9fd41446fbd@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d8960a6c86859c19b84dc9fd41446fbd@bga.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 27, 2007 at 06:22:27AM -0500, Milton Miller wrote:
> On Wed Jun 27 17:10:08 EST 2007, David Gibson wrote:
> > Here is an implementation to allow PReP systems to boot under the
> > arch/powerpc codebase, one of the few remaining platforms supported in
> > arch/ppc but not so far in arch/powerpc.
> >
> > This support is still fairly incomplete - it needs to obtain a lot
> > more device information from the residual data and put it into the
> > device tree, rather than relying on hardcoded values (both in the code
> > and in prep.dts).  Likewise many peripherals will not be supported -
> > in particular the RTC is not yet supported, so the time will generally
> > be wrong.
> 
> 
> Hi David.
> 
> A few things I noticed:
> 
> (1) Your cleaned up mkprep.c seems to always put on a floppy header, 
> where as before that was optional with the -php flag.  Is that header 
> right for a hard disk partition?  Or would that just have the 1-sector 
> header?

Well, the arch/ppc code always invokes mkprep with the -php option to
make the zImage.prep.  That's what I was basing my change on..

> The comments in the old mkprep impiled the raw elf contents 
> are used for netboot.  What if the zImage does't fit on the 1.44MB disk 
> given in the header?

Um... dunno.

> (2) Uour wrapper rule can leave behind zImage.dts.prep.elf, but there 
> is no clean rule for that

Hrm, yes.  And this is true for a number of intermediares that the
wrapper can make.  Fix later...

> (3) Is this the right platform to create the device tree from scratch 
> by traversing fw data?  A significiant number of the properties are to 
> be filled in or say IBM, which is incorrect.

Maybe, I'm certainly considering it.  For a first cut tweaking a fixed
tree was easier, but by the time we read all the information from the
residual data that we ought to, we may well be more-or-less making a
tree from scratch.

I'm hoping to merge libfdt into the kernel tree before attempting this
path, though.

> (4) Adding a 5th udbg_putc method that calls a byte read to 
> udbg_comport->lsr masked with THRE until 0 and performs a byte write to 
> ->thr shows we have the wrong abstraction.   Please make the inb/outb a 
> method with the comport.  It would seem the actual init_xx could be in 
> the platforms, passing inb, outb, and comport to a helper in 
> udbg_16550.c.   I'm fine with declaring all the early inits in udbg.h

Hrm.. I'm not entirely convinced.  The duplication of the serial
polling stuff is duplication, certainly, but it's not that complex a
bit of code:  I'm not sure it's worth inventing a second level of
indirection in the udbg stuff to get rid of it.  We'd still need the
putc/getc callbacks, to deal with non-8250 like debug methods
(e.g. OF, HV).

> (5) the printk PReP architecture is in the middle of prep_find_bridges?

Huh..?  I have no idea what you mean.

> (6) #if 0 prep_request_io will need platform check

If it stays.  I'm pretty unconvinced we need it at all - if we
actually need to use those devices, they can have their own entries in
the device tree and of_platform drivers which can do the
OF_request_ranges thing.

> (7) do you expect both the kernel and the boot code will continue to 
> need residual.h?  If so, can we have the boot dir make a copy like the 
> zlib headers?  Or is this only temporary, the kernel only needs a copy 
> of the raw blob to export to userspace in the same spot and the 
> include/asm-powerpc copy will go away?

For now, only the boot code needs it, and I'm hoping it can be kept
that way.  Anything the kernel proper needs from the residual should
probably be copied to a relevant place in the device tree.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
