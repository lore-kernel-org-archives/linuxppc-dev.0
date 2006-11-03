Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1418367CB9
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Nov 2006 09:32:09 +1100 (EST)
Subject: Re: [PATCH/RFC] Hookable IO operations
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200611032320.34762.arnd@arndb.de>
References: <1162588367.10630.100.camel@localhost.localdomain>
	<200611032320.34762.arnd@arndb.de>
Content-Type: text/plain
Date: Sat, 04 Nov 2006 09:32:01 +1100
Message-Id: <1162593121.10630.132.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I think it would be helpful to not generate the function name itself,
> but pass it down to the macro, so you grep for the definition, either
> 
> DEF_MMIO_IN_BE(in_be16, u16, lwz)
> 
> or going further, making it look more like a declaration
> 
> static inline u16 DEF_MMIO_IN_BE(in_be16, u16, lwz)
> 
> which may even do the right thing with ctags (need to check that)

I'll look into it.

> > +/*
> > + * IO stream instructions are defined out of line
> > + */
> > +extern void _insb(volatile u8 __iomem *port, void *buf, long count);
> > +extern void _outsb(volatile u8 __iomem *port, const void *buf, long count);
> > +extern void _insw_ns(volatile u16 __iomem *port, void *buf, long count);
> > +extern void _outsw_ns(volatile u16 __iomem *port, const void *buf, long count);
> > +extern void _insl_ns(volatile u32 __iomem *port, void *buf, long count);
> > +extern void _outsl_ns(volatile u32 __iomem *port, const void *buf, long count);
> 
> If you leave out the 'extern', it fits into a normal line ;-)

Did I change them from the initial definition ? Anyway, I dislike
prototypes in headers without "extern".

> 
> similarly here, you could write these using slightly different macros
> as 
> 
> DEF_PCI_AC_OUT_MMIO(writeb, u8)
> DEF_PCI_AC_OUT_PIO(outb, u8)
> DEF_PCI_AC_OUT_MMIO(writew, u16)
> DEF_PCI_AC_OUT_PIO(outw, u16)

I'll look at it.

> > +
> > +/* We still use EEH versions for now. Ultimately, we might just get rid of
> > + * EEH in here and use it as a set of __memset_io etc... hooks
> > + */
> 
> Yes, I fully agree. The definition of eeh_memset_io and the others
> looks like they really want to be out-of-line.

Yes.

> > +
> > +extern void (*__memset_io)(volatile void __iomem *addr, int c,
> > +			   unsigned long n);
> > +extern void (*__memcpy_fromio)(void *dest, const volatile void __iomem *src,
> > +			       unsigned long n);
> > +extern void (*__memcpy_toio)(volatile void __iomem *dest, const void *src,
> > +			     unsigned long n);
> 
> Why are these all separate symbols? Wouldn't it be clearer to group them
> in ppc_md, or a similar structure of function pointers?

Because the IO ones are separate already and I want to keep things
consistent with them.

> This is the point where it gets completely unreadable. I ended up
> running the macros through 'gcc -E' to see what they do ;-)

Come on ... :-) They are almost the same as the ones in the .h, they
just only define the function pointer.

> If you resolve all the macros, you actually get fewer lines, and
> it suddenly becomes readable, as well as parsable with grep and ctags:
> 
> u8 (*__ind_readb) (const volatile void __iomem * addr);
> EXPORT_SYMBOL(__ind_readb);
> u8 (*__ind_inb) (unsigned long port);
> EXPORT_SYMBOL(__ind_inb);
> u16 (*__ind_readw) (const volatile void __iomem * addr);
> EXPORT_SYMBOL(__ind_readw);
> u16 (*__ind_inw) (unsigned long port);
> ...
> 
> I do the same when I start using macros, it's always hard to know exactly
> when to stop ;-)

I'll look and see what the result looks like.

> > -static u8 iSeries_Read_Byte(const volatile void __iomem *IoAddress)
> > +static u8 iseries_readb(const volatile void __iomem *IoAddress)
> 
> Since you're converting iSeries_Read_Byte from SilLycAps, shouldn't
> you change IoAddress to something more sensible at the same time?

No, I'm only changing the prototype & name to better match my hooks,
further cleanups of the content of these functions is something I'll do
in a separate patch.
 
> >  {
> >  	u64 BarOffset;
> >  	u64 dsa;
> > @@ -462,7 +411,8 @@ static u8 iSeries_Read_Byte(const volati
> >  			num_printed = 0;
> >  		}
> >  		if (num_printed++ < 10)
> > -			printk(KERN_ERR "iSeries_Read_Byte: invalid access at IO address %p\n", IoAddress);
> > +			printk(KERN_ERR "iSeries_Read_Byte: invalid access at IO address %p\n",
> > +			       IoAddress);
> >  		return 0xff;
> 
> And the name in the comment should also be changed.

Ooopsa.

Ben.
