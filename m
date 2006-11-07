Return-Path: <rmk+linuxppc-dev=ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[217.147.92.249])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5431D67D6D
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Nov 2006 09:25:34 +1100 (EST)
Date: Tue, 7 Nov 2006 22:25:14 +0000
From: Russell King <rmk-pci@arm.linux.org.uk>
To: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [RFC/PATCH 4/7] Powerpc MSI implementation
Message-ID: <20061107222514.GG9533@flint.arm.linux.org.uk>
References: <1162884080.585336.70559261997.qpush@cradle>
	<20061107072125.68E9F67CA7@ozlabs.org>
	<20061107200730.GY27140@parisc-linux.org>
	<20061107201436.GE9533@flint.arm.linux.org.uk>
	<20061107204432.GZ27140@parisc-linux.org>
	<20061107204853.GF9533@flint.arm.linux.org.uk>
	<20061107210202.GA27140@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061107210202.GA27140@parisc-linux.org>
Sender: Russell King <rmk@arm.linux.org.uk>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Ingo Molnar <mingo@elte.hu>,
	linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	"Eric W.Biederman" <ebiederm@xmission.com>,
	linux-pci@atrey.karlin.mff.cuni.cz, "David S.Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 07, 2006 at 02:02:02PM -0700, Matthew Wilcox wrote:
> On Tue, Nov 07, 2006 at 08:48:53PM +0000, Russell King wrote:
> > On Tue, Nov 07, 2006 at 01:44:32PM -0700, Matthew Wilcox wrote:
> > > On Tue, Nov 07, 2006 at 08:14:36PM +0000, Russell King wrote:
> > > > Bah.  chip_data is supposed to be __iomem.  I bet if you build ARM
> > > > with sparse it'll kick out lots of warnings as a result of that loss.
> > > 
> > > Erm, since when?  When I introduced it (back in January 2005 [1]), it
> > > was called handler_data and pointed to a struct which is chip-type
> > > dependent.
> > 
> > Since before the generic irq merge.  If I was more expert with git
> > I'd post a URL, but I'm not so I won't.  But I'm sure you can find
> > it - look at the history of include/asm-arm/mach/irq.h.
> 
> OK.  Looks like the first mention of this is in 
> 4a2581a080098ca3a0c4e416d7a282e96c75ebf8 from July 2006
> which is signed-off by you, Ingo Molnar and Thomas Gleixner:
> 
> -       void __iomem    *base;
> [...]
> +#define set_irq_chipdata(irq, d)       set_irq_chip_data(irq, d)
> +#define get_irq_chipdata(irq)          get_irq_chip_data(irq)
> -#define set_irq_chipdata(irq,d)                        do { irq_desc[irq].base = d; } while (0)
> -#define get_irq_chipdata(irq)                  (irq_desc[irq].base)

Yes and now I'm regretting having switched ARM over to the generic IRQ
stuff - the old stuff did _precisely_ what we wanted the way we wanted.
None of these compromises.

> As other architectures, you could embed the iomem pointer in a
> struct (would it be useful to you to have more than an iomem pointer
> in your handlers?), or you could put the cast adding __iomem in
> get_irq_chipdata().

That's extremely wasteful - the only way to do that would be to kmalloc
some memory, and that's 32 bytes minimum, just to store 4 bytes of
pointer.  There's no other information which needs to be stored.

I guess we'll just have to add __force casts all over the code. ;(

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
