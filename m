Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id B102ADDF43
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2007 21:22:22 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <20070627071008.GA30648@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d8960a6c86859c19b84dc9fd41446fbd@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 3/3] First cut at PReP support for arch/powerpc
Date: Wed, 27 Jun 2007 06:22:27 -0500
To: David Gibson <david@gibson.dropbear.id.au>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed Jun 27 17:10:08 EST 2007, David Gibson wrote:
> Here is an implementation to allow PReP systems to boot under the
> arch/powerpc codebase, one of the few remaining platforms supported in
> arch/ppc but not so far in arch/powerpc.
>
> This support is still fairly incomplete - it needs to obtain a lot
> more device information from the residual data and put it into the
> device tree, rather than relying on hardcoded values (both in the code
> and in prep.dts).  Likewise many peripherals will not be supported -
> in particular the RTC is not yet supported, so the time will generally
> be wrong.


Hi David.

A few things I noticed:

(1) Your cleaned up mkprep.c seems to always put on a floppy header, 
where as before that was optional with the -php flag.  Is that header 
right for a hard disk partition?  Or would that just have the 1-sector 
header?  The comments in the old mkprep impiled the raw elf contents 
are used for netboot.  What if the zImage does't fit on the 1.44MB disk 
given in the header?

(2) Uour wrapper rule can leave behind zImage.dts.prep.elf, but there 
is no clean rule for that

(3) Is this the right platform to create the device tree from scratch 
by traversing fw data?  A significiant number of the properties are to 
be filled in or say IBM, which is incorrect.

(4) Adding a 5th udbg_putc method that calls a byte read to 
udbg_comport->lsr masked with THRE until 0 and performs a byte write to 
->thr shows we have the wrong abstraction.   Please make the inb/outb a 
method with the comport.  It would seem the actual init_xx could be in 
the platforms, passing inb, outb, and comport to a helper in 
udbg_16550.c.   I'm fine with declaring all the early inits in udbg.h

(5) the printk PReP architecture is in the middle of prep_find_bridges?

(6) #if 0 prep_request_io will need platform check

(7) do you expect both the kernel and the boot code will continue to 
need residual.h?  If so, can we have the boot dir make a copy like the 
zlib headers?  Or is this only temporary, the kernel only needs a copy 
of the raw blob to export to userspace in the same spot and the 
include/asm-powerpc copy will go away?

milton
