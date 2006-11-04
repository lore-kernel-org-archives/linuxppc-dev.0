Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B4A8667BC6
	for <linuxppc-dev@ozlabs.org>; Sun,  5 Nov 2006 09:05:17 +1100 (EST)
Subject: Re: [PATCH/RFC] Hookable IO operations
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <CE55E1AD-1553-442C-98FC-D348BC73E7A4@kernel.crashing.org>
References: <1162588367.10630.100.camel@localhost.localdomain>
	<CE55E1AD-1553-442C-98FC-D348BC73E7A4@kernel.crashing.org>
Content-Type: text/plain
Date: Sun, 05 Nov 2006 09:05:11 +1100
Message-Id: <1162677911.28571.55.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-11-04 at 17:28 +0100, Segher Boessenkool wrote:
> > + * Those operate direction on a kernel virtual address. Note that  
> > the prototype
> 
> s/direction/directly/ ?

Thanks.

> > + * for the out_* accessors has the arguments in opposite order  
> > from the usual
> > + * linux PCI accessors. Unlike those, they take the address first  
> > and the value
> > + * next.
> 
> Isn't that more confusing than useful?

That's how they have been singe day 1. I'm not about to change that and
go fix every bit of ppc code that uses them. At least not with this
patch.

> > +#define DEF_MMIO_IN(name, type, insn)					\
> > +static inline type in_##name(const volatile type __iomem *addr)		\
> > +{									\
> > +	type ret;							\
> > +	__asm__ __volatile__("sync;" insn ";twi 0,%0,0;isync"		\
> > + 		: "=r" (ret) : "r" (addr), "m" (*addr));		\
> > +	return ret;							\
> > +}
> 
> Drop the "inline" and you don't need any macro games anymore, and code
> size drops, and it shouldn't be slower -- the I/O operation itself
> dominates runtime (but testing is needed, of course).

No, the low level accessors are staying inline and I don't see how that
would prevent macro games... Anyway that doesn't matter much at this
point. Note that I've posted a second version of the patch with simpler
macros.

> You can also drop the "volatile" -- it has no effect.

Well, it's possible, but I've never quite understood when and when not C
compilers need/want volatile or not in the case of IO accessors :-) It
seems to be the rule accross linux that those functions take volatile so
I will continue following it.

> "r"(addr) should probably be "b" (and you might want to lose the "m" --
> it certainly won't have any bad effects if you decide to get rid of the
> inline).

In which case should "r" be "b" ? Those macros are directly equivalent
to the previous code that was there and it didn't use "b". If you look
closely, depending on the type of operations(lbz,lhz,lwz etc.. vs.
lhbrz, lwbrx etc...), we use %1 or %2 for the address. In the former
case, we get more efficient code by letting gcc generate the right type
of instruction (update form, indexed form, ... using %U and %X) by using
and "m" input. For the later, we use "r" and we use it for rB which can
safely be r0 afaik so we don't need "b".

> > +#define DEF_MMIO_IN_BE(pfx, size, insn) \
> > +	DEF_MMIO_IN(pfx##size, u##size, __stringify(insn)"%U2%X2 %0,%2")
> > +#define DEF_MMIO_IN_LE(pfx, size, insn) \
> > +	DEF_MMIO_IN(pfx##size, u##size, __stringify(insn)" %0,0,%1")
> 
> ... "r" is okay actually, no "b" needed (would be needed if addr was the
> first arg -- which is very much preferred on most CPUs for performance
> reasons).

Ah ? But how so ? I mean, there has to be a rB, there is no form of
these instructions (the LE ones) with only one argument. Thus there is
always a register specified as the second part of the address. So if I
was using "b" with rA, I would have to spill another register for rB and
put 0 in it. I fail to see how that would be an improvement, and I fail
to see how the processor implementation would go faster getting 2
registers to add together rather than one.

> > + * as EEH can use the new hook mecanism, provided it doesn't impact
> 
> s/mecanism/mechanism/ .

Ok.

> > + * performances too much
> 
> s/s//

Ok.

> > +#ifdef CONFIG_PPC_INDIRECT_IO
> > +#define DEF_PCI_HOOK(x)		x
> > +#else
> > +#define DEF_PCI_HOOK(x)		NULL
> > +#endif
> > +
> > +#define DEF_PCI_AC_IN_MMIO(ts)							\
> > +extern DEF_PCI_DT_##ts (*__ind_read##ts)(const volatile void  
> > __iomem * addr);	\
> > +static inline DEF_PCI_DT_##ts read##ts(const volatile void __iomem  
> > * addr)	\
> > +{										\
> > +	if (DEF_PCI_HOOK(__ind_read##ts) != NULL)				\
> > +		return __ind_read##ts(addr);					\
> > +	return eeh_read##ts(addr);						\
> > +}
> 
> You really went over the top with macros here.  Luckily this will
> disappear if you move EEH to use the hooks, too.

Those macros won't disappear but I've simplified them significantly in
the patch #2 that I posted ysterday.

> > +/* Enforce in-order execution of data I/O.
> > + * No distinction between read/write on PPC; use eieio for all three.
> > + */
> 
> It also prevents write gathering; if not, the _w version wouldn't
> need eieio.

That was there already, I haven't touched that comment. Maybe I
should...

> > +#define iobarrier_rw() eieio()
> > +#define iobarrier_r()  eieio()
> > +#define iobarrier_w()  eieio()
> 
> 
> > +config PPC_INDIRECT_IO
> 
> I find this name a little confusing, it sounds too much like the
> "PCI indirect I/O".

Any better idea ?

> > -static u8 iSeries_Read_Byte(const volatile void __iomem *IoAddress)
> > +static u8 iseries_readb(const volatile void __iomem *IoAddress)
> 
> Get rid of the caps in IoAddress too?

As I said to Arnd, I will do that in a separate patch as I sanitize a
bit the content of those functions. In fact, I originally changed those
names because I also had to change the prototype (some initial version
of the patch that wasn't posted). Since then, the prototype is back to
what it was, so I might just drop the name change completely from the
patch and do it all in a separate iseries cleanup patch.

> > -			printk(KERN_ERR "iSeries_Read_Byte: invalid access at IO  
> > address %p\n", IoAddress);
> > +			printk(KERN_ERR "iSeries_Read_Byte: invalid access at IO  
> > address %p\n",
> > +			       IoAddress);
> 
> Update the printk() to say the new function name.

Yup. See above.

> > +void __init iSeries_pcibios_init(void)
> 
> Caps.  There's a few more, can you remove them while you're
> touching the code anyway please?

As I said, in a separate patch.

Thanks for your comments !

Cheers
Ben.
