Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3D7C567B9B
	for <linuxppc-dev@ozlabs.org>; Sun,  5 Nov 2006 03:29:17 +1100 (EST)
In-Reply-To: <1162588367.10630.100.camel@localhost.localdomain>
References: <1162588367.10630.100.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CE55E1AD-1553-442C-98FC-D348BC73E7A4@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH/RFC] Hookable IO operations
Date: Sat, 4 Nov 2006 17:28:38 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> + * Those operate direction on a kernel virtual address. Note that  
> the prototype

s/direction/directly/ ?

> + * for the out_* accessors has the arguments in opposite order  
> from the usual
> + * linux PCI accessors. Unlike those, they take the address first  
> and the value
> + * next.

Isn't that more confusing than useful?

> +#define DEF_MMIO_IN(name, type, insn)					\
> +static inline type in_##name(const volatile type __iomem *addr)		\
> +{									\
> +	type ret;							\
> +	__asm__ __volatile__("sync;" insn ";twi 0,%0,0;isync"		\
> + 		: "=r" (ret) : "r" (addr), "m" (*addr));		\
> +	return ret;							\
> +}

Drop the "inline" and you don't need any macro games anymore, and code
size drops, and it shouldn't be slower -- the I/O operation itself
dominates runtime (but testing is needed, of course).

You can also drop the "volatile" -- it has no effect.

"r"(addr) should probably be "b" (and you might want to lose the "m" --
it certainly won't have any bad effects if you decide to get rid of the
inline).

> +#define DEF_MMIO_IN_BE(pfx, size, insn) \
> +	DEF_MMIO_IN(pfx##size, u##size, __stringify(insn)"%U2%X2 %0,%2")
> +#define DEF_MMIO_IN_LE(pfx, size, insn) \
> +	DEF_MMIO_IN(pfx##size, u##size, __stringify(insn)" %0,0,%1")

... "r" is okay actually, no "b" needed (would be needed if addr was the
first arg -- which is very much preferred on most CPUs for performance
reasons).

> + * as EEH can use the new hook mecanism, provided it doesn't impact

s/mecanism/mechanism/ .

> + * performances too much

s/s//

> +#ifdef CONFIG_PPC_INDIRECT_IO
> +#define DEF_PCI_HOOK(x)		x
> +#else
> +#define DEF_PCI_HOOK(x)		NULL
> +#endif
> +
> +#define DEF_PCI_AC_IN_MMIO(ts)							\
> +extern DEF_PCI_DT_##ts (*__ind_read##ts)(const volatile void  
> __iomem * addr);	\
> +static inline DEF_PCI_DT_##ts read##ts(const volatile void __iomem  
> * addr)	\
> +{										\
> +	if (DEF_PCI_HOOK(__ind_read##ts) != NULL)				\
> +		return __ind_read##ts(addr);					\
> +	return eeh_read##ts(addr);						\
> +}

You really went over the top with macros here.  Luckily this will
disappear if you move EEH to use the hooks, too.

> +/* Enforce in-order execution of data I/O.
> + * No distinction between read/write on PPC; use eieio for all three.
> + */

It also prevents write gathering; if not, the _w version wouldn't
need eieio.

> +#define iobarrier_rw() eieio()
> +#define iobarrier_r()  eieio()
> +#define iobarrier_w()  eieio()


> +config PPC_INDIRECT_IO

I find this name a little confusing, it sounds too much like the
"PCI indirect I/O".

> -static u8 iSeries_Read_Byte(const volatile void __iomem *IoAddress)
> +static u8 iseries_readb(const volatile void __iomem *IoAddress)

Get rid of the caps in IoAddress too?

> -			printk(KERN_ERR "iSeries_Read_Byte: invalid access at IO  
> address %p\n", IoAddress);
> +			printk(KERN_ERR "iSeries_Read_Byte: invalid access at IO  
> address %p\n",
> +			       IoAddress);

Update the printk() to say the new function name.

> +void __init iSeries_pcibios_init(void)

Caps.  There's a few more, can you remove them while you're
touching the code anyway please?


Segher
