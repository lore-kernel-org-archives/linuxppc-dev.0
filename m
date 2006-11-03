Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 08A2767C42
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Nov 2006 09:20:45 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH/RFC] Hookable IO operations
Date: Fri, 3 Nov 2006 23:20:34 +0100
References: <1162588367.10630.100.camel@localhost.localdomain>
In-Reply-To: <1162588367.10630.100.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611032320.34762.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 03 November 2006 22:12, Benjamin Herrenschmidt wrote:
> +/*
> + *
> + * Low level MMIO accessors
> + *
> + * This provides the non-bus specific accessors to MMIO. Those are PowerPC
> + * specific and thus shouldn't be used in generic code. The accessors
> + * provided here are:
> + *
> + *	in_8, in_le16, in_be16, in_le32, in_be32, in_le64, in_be64
> + *	out_8, out_le16, out_be16, out_le32, out_be32, out_le64, out_be64
> + *	_insb, _insw_ns, _insl_ns, _outsb, _outsw_ns, _outsl_ns
> + *
> + * Those operate direction on a kernel virtual address. Note that the prototype
> + * for the out_* accessors has the arguments in opposite order from the usual
> + * linux PCI accessors. Unlike those, they take the address first and the value
> + * next.
> + *
> + * Note: I might drop the _ns suffix on the stream operations soon as it is
> + * simply normal for stream operations to not swap in the first place.
> + *
> + */
> +
> +#define DEF_MMIO_IN(name, type, insn)					\
> +static inline type in_##name(const volatile type __iomem *addr)		\
> +{									\
> +	type ret;							\
> +	__asm__ __volatile__("sync;" insn ";twi 0,%0,0;isync"		\
> + 		: "=r" (ret) : "r" (addr), "m" (*addr));		\
> +	return ret;							\
> +}
> +
> +#define DEF_MMIO_OUT(name, type, insn)					\
> +static inline void out_##name(volatile type __iomem *addr, type val)	\
> +{									\
> +	__asm__ __volatile__("sync;" insn				\
> + 		: "=m" (*addr) : "r" (val), "r" (addr));		\
> +	get_paca()->io_sync = 1;					\
> +}
> +
> +
> +#define DEF_MMIO_IN_BE(pfx, size, insn) \
> +	DEF_MMIO_IN(pfx##size, u##size, __stringify(insn)"%U2%X2 %0,%2")
> +#define DEF_MMIO_IN_LE(pfx, size, insn) \
> +	DEF_MMIO_IN(pfx##size, u##size, __stringify(insn)" %0,0,%1")
> +
> +#define DEF_MMIO_OUT_BE(pfx, size, insn) \
> +	DEF_MMIO_OUT(pfx##size, u##size, __stringify(insn)"%U0%X0 %1,%0")
> +#define DEF_MMIO_OUT_LE(pfx, size, insn) \
> +	DEF_MMIO_OUT(pfx##size, u##size, __stringify(insn)" %1,0,%2")
> +
> +DEF_MMIO_IN_BE(  ,  8, lbz);
> +DEF_MMIO_IN_BE(be, 16, lhz);
> +DEF_MMIO_IN_BE(be, 32, lwz);
> +DEF_MMIO_IN_BE(be, 64, ld);
> +DEF_MMIO_IN_LE(le, 16, lhbrx);
> +DEF_MMIO_IN_LE(le, 32, lwbrx);
> +
> +DEF_MMIO_OUT_BE(  ,  8, stb);
> +DEF_MMIO_OUT_BE(be, 16, sth);
> +DEF_MMIO_OUT_BE(be, 32, stw);
> +DEF_MMIO_OUT_BE(be, 64, std);
> +DEF_MMIO_OUT_LE(le, 16, sthbrx);
> +DEF_MMIO_OUT_LE(le, 32, stwbrx);

I think it would be helpful to not generate the function name itself,
but pass it down to the macro, so you grep for the definition, either

DEF_MMIO_IN_BE(in_be16, u16, lwz)

or going further, making it look more like a declaration

static inline u16 DEF_MMIO_IN_BE(in_be16, u16, lwz)

which may even do the right thing with ctags (need to check that)

> +/*
> + * IO stream instructions are defined out of line
> + */
> +extern void _insb(volatile u8 __iomem *port, void *buf, long count);
> +extern void _outsb(volatile u8 __iomem *port, const void *buf, long count);
> +extern void _insw_ns(volatile u16 __iomem *port, void *buf, long count);
> +extern void _outsw_ns(volatile u16 __iomem *port, const void *buf, long count);
> +extern void _insl_ns(volatile u32 __iomem *port, void *buf, long count);
> +extern void _outsl_ns(volatile u32 __iomem *port, const void *buf, long count);

If you leave out the 'extern', it fits into a normal line ;-)


> +
> +/*
> + * PCI IO accessors.
> + *
> + * Right now, we still use the eeh versions inline but that might change
> + * as EEH can use the new hook mecanism, provided it doesn't impact
> + * performances too much
> + */
> +
> +#include <asm/eeh.h>
> +
> +#define DEF_PCI_DT_b		u8
> +#define DEF_PCI_DT_w		u16
> +#define DEF_PCI_DT_l		u32
> +#define DEF_PCI_DT_q		u64
> +
> +#define __do_writeb(val, addr)	out_8(addr, val)
> +#define __do_writew(val, addr)	out_le16(addr, val)
> +#define __do_writel(val, addr)	out_le32(addr, val)
> +#define __do_writeq(val, addr)	out_le64(addr, val)
> +
> +#ifdef CONFIG_PPC_INDIRECT_IO
> +#define DEF_PCI_HOOK(x)		x
> +#else
> +#define DEF_PCI_HOOK(x)		NULL
> +#endif
> +
> +#define DEF_PCI_AC_IN_MMIO(ts)							\
> +extern DEF_PCI_DT_##ts (*__ind_read##ts)(const volatile void __iomem * addr);	\
> +static inline DEF_PCI_DT_##ts read##ts(const volatile void __iomem * addr)	\
> +{										\
> +	if (DEF_PCI_HOOK(__ind_read##ts) != NULL)				\
> +		return __ind_read##ts(addr);					\
> +	return eeh_read##ts(addr);						\
> +}
> +
> +#define DEF_PCI_AC_IN_PIO(ts)							\
> +extern DEF_PCI_DT_##ts (*__ind_in##ts)(unsigned long port);			\
> +static inline DEF_PCI_DT_##ts in##ts(unsigned long port)	       		\
> +{										\
> +	if (DEF_PCI_HOOK(__ind_in##ts) != NULL)					\
> +		return __ind_in##ts(port);					\
> +	return read##ts((void __iomem *)pci_io_base + port);			\
> +}
> +
> +#define DEF_PCI_AC_OUT_MMIO(ts)							\
> +extern void (*__ind_write##ts)(DEF_PCI_DT_##ts val,				\
> +			       volatile void __iomem *addr);			\
> +static inline void write##ts(DEF_PCI_DT_##ts val, volatile void __iomem *addr)	\
> +{										\
> +	if (DEF_PCI_HOOK(__ind_write##ts) != NULL)				\
> +		__ind_write##ts(val, addr);					\
> +	else									\
> +		__do_write##ts(val, addr);					\
> +}
> +
> +#define DEF_PCI_AC_OUT_PIO(ts)							\
> +extern void (*__ind_out##ts)(DEF_PCI_DT_##ts val, unsigned long port);		\
> +static inline void out##ts(DEF_PCI_DT_##ts val, unsigned long port)		\
> +{										\
> +	if (DEF_PCI_HOOK(__ind_out##ts) != NULL)				\
> +		__ind_out##ts(val, port);					\
> +	else									\
> +		write##ts(val, (void __iomem *)pci_io_base + port);		\
> +}
> +
> +#define DEF_PCI_AC_MMIO(ts, dir)	DEF_PCI_AC_##dir##_MMIO(ts)
> +#define DEF_PCI_AC_PIO(ts, dir)		DEF_PCI_AC_##dir##_PIO(ts)
> +
> +#define DEF_PCI_AC(ts, dir)		DEF_PCI_AC_MMIO(ts, dir)		\
> +					DEF_PCI_AC_PIO(ts, dir)
> +DEF_PCI_AC(b, IN)
> +DEF_PCI_AC(w, IN)
> +DEF_PCI_AC(l, IN)
> +DEF_PCI_AC_MMIO(q, IN)
> +DEF_PCI_AC(b, OUT)
> +DEF_PCI_AC(w, OUT)
> +DEF_PCI_AC(l, OUT)
> +DEF_PCI_AC_MMIO(q, OUT)

similarly here, you could write these using slightly different macros
as 

DEF_PCI_AC_OUT_MMIO(writeb, u8)
DEF_PCI_AC_OUT_PIO(outb, u8)
DEF_PCI_AC_OUT_MMIO(writew, u16)
DEF_PCI_AC_OUT_PIO(outw, u16)

> +
> +/* We still use EEH versions for now. Ultimately, we might just get rid of
> + * EEH in here and use it as a set of __memset_io etc... hooks
> + */

Yes, I fully agree. The definition of eeh_memset_io and the others
looks like they really want to be out-of-line.

> +
> +extern void (*__memset_io)(volatile void __iomem *addr, int c,
> +			   unsigned long n);
> +extern void (*__memcpy_fromio)(void *dest, const volatile void __iomem *src,
> +			       unsigned long n);
> +extern void (*__memcpy_toio)(volatile void __iomem *dest, const void *src,
> +			     unsigned long n);

Why are these all separate symbols? Wouldn't it be clearer to group them
in ppc_md, or a similar structure of function pointers?

> --- linux-cell.orig/arch/powerpc/kernel/setup_64.c	2006-11-03 15:52:54.000000000 +1100
> +++ linux-cell/arch/powerpc/kernel/setup_64.c	2006-11-03 18:51:14.000000000 +1100
> @@ -599,3 +599,48 @@ void __init setup_per_cpu_areas(void)
>  	}
>  }
>  #endif
> +
> +
> +#ifdef CONFIG_PPC_INDIRECT_IO
> +
> +#define EXP_PCI_AC_IN_MMIO(ts)						\
> +DEF_PCI_DT_##ts (*__ind_read##ts)(const volatile void __iomem * addr);	\
> +EXPORT_SYMBOL(__ind_read##ts);
> +
> +#define EXP_PCI_AC_IN_PIO(ts)						\
> +DEF_PCI_DT_##ts (*__ind_in##ts)(unsigned long port);			\
> +EXPORT_SYMBOL(__ind_in##ts);
> +
> +#define EXP_PCI_AC_OUT_MMIO(ts)						\
> +void (*__ind_write##ts)(DEF_PCI_DT_##ts val,				\
> +			volatile void __iomem *addr);			\
> +EXPORT_SYMBOL(__ind_write##ts);
> +
> +#define EXP_PCI_AC_OUT_PIO(ts)						\
> +void (*__ind_out##ts)(DEF_PCI_DT_##ts val, unsigned long port);		\
> +EXPORT_SYMBOL(__ind_out##ts);
> +
> +#define EXP_PCI_AC_MMIO(ts, dir)	EXP_PCI_AC_##dir##_MMIO(ts)
> +#define EXP_PCI_AC_PIO(ts, dir)		EXP_PCI_AC_##dir##_PIO(ts)
> +
> +#define EXP_PCI_AC(ts, dir)		EXP_PCI_AC_MMIO(ts, dir)	\
> +					EXP_PCI_AC_PIO(ts, dir)
> +EXP_PCI_AC(b, IN)
> +EXP_PCI_AC(w, IN)
> +EXP_PCI_AC(l, IN)
> +EXP_PCI_AC_MMIO(q, IN)
> +EXP_PCI_AC(b, OUT)
> +EXP_PCI_AC(w, OUT)
> +EXP_PCI_AC(l, OUT)
> +EXP_PCI_AC_MMIO(q, OUT)

This is the point where it gets completely unreadable. I ended up
running the macros through 'gcc -E' to see what they do ;-)

If you resolve all the macros, you actually get fewer lines, and
it suddenly becomes readable, as well as parsable with grep and ctags:

u8 (*__ind_readb) (const volatile void __iomem * addr);
EXPORT_SYMBOL(__ind_readb);
u8 (*__ind_inb) (unsigned long port);
EXPORT_SYMBOL(__ind_inb);
u16 (*__ind_readw) (const volatile void __iomem * addr);
EXPORT_SYMBOL(__ind_readw);
u16 (*__ind_inw) (unsigned long port);
...

I do the same when I start using macros, it's always hard to know exactly
when to stop ;-)

> -static u8 iSeries_Read_Byte(const volatile void __iomem *IoAddress)
> +static u8 iseries_readb(const volatile void __iomem *IoAddress)

Since you're converting iSeries_Read_Byte from SilLycAps, shouldn't
you change IoAddress to something more sensible at the same time?

>  {
>  	u64 BarOffset;
>  	u64 dsa;
> @@ -462,7 +411,8 @@ static u8 iSeries_Read_Byte(const volati
>  			num_printed = 0;
>  		}
>  		if (num_printed++ < 10)
> -			printk(KERN_ERR "iSeries_Read_Byte: invalid access at IO address %p\n", IoAddress);
> +			printk(KERN_ERR "iSeries_Read_Byte: invalid access at IO address %p\n",
> +			       IoAddress);
>  		return 0xff;

And the name in the comment should also be changed.

	Arnd <><
