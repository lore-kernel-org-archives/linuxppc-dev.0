Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1CD3867C04
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Nov 2006 12:06:42 +1100 (EST)
Subject: Re: [PATCH/RFC] Hookable IO operations
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200611040115.34235.arnd@arndb.de>
References: <1162588367.10630.100.camel@localhost.localdomain>
	<200611032348.38402.arnd@arndb.de>
	<1162594589.10630.135.camel@localhost.localdomain>
	<200611040115.34235.arnd@arndb.de>
Content-Type: text/plain
Date: Sat, 04 Nov 2006 12:06:34 +1100
Message-Id: <1162602394.10630.146.camel@localhost.localdomain>
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

On Sat, 2006-11-04 at 01:15 +0100, Arnd Bergmann wrote:

> 	void (*outq)(u64 val);
> 	u64  (*inq)(void);

There is no outq/intq :-) Also, we need the ins{b,w,l}/outs{n,w,l} ones.
I haven' hooked them yet but we'll need them and we'll need the MMIO
versions of them which aren't defined properly except with iomap. That
is 12 more hooks...

> 	void (*memset_io)(volatile void __iomem *addr, int c, unsigned long n);
> 	void (*memcpy_fromio)(void *dest,
> 			const volatile void __iomem *src, unsigned long n);
> 	void (*memcpy_toio)(volatile void __iomem *dest,
> 			const void *src, unsigned long n);
> } ppc_io;
> 
> /* all these should be static inline or extern */
> void direct_writeb(u8 val);
> void direct_writew(u16 val);
> void direct_writel(u32 val);
> void direct_writeq(u64 val);
> u8   direct_readb(void);
> u16  direct_readw(void);
> u32  direct_readl(void);
> u64  direct_readq(void);
> void direct_outb(u8 val);
> void direct_outw(u16 val);
> void direct_outl(u32 val);
> void direct_outq(u64 val);
> u8   direct_inb(void);
> u16  direct_inw(void);
> u32  direct_inl(void);
> u64  direct_inq(void);

Well, I still need to use the EEH version for now so I'd rather stick to
what my current macros are doing. You are also not passing any
address :)

> void direct_memset_io(volatile void __iomem *addr, int c,
>                        unsigned long n);
> void direct_memcpy_fromio(void *dest,
>               const volatile void __iomem *src, unsigned long n);
> void direct_memcpy_toio(volatile void __iomem *dest,
>                 const void *src, unsigned long n);
> 
> /* a simple indirection more than your code, going
>    through the structure */
> #ifdef CONFIG_INDIRECT_IO
> #define ppc_io_indirect(x) ppc_io.x
> #else
> #define ppc_io_indirect(x) NULL
> #endif
> 
> #define DEF_IO_OUT(name, arg) \
> static inline void name(arg val) \
> { \
> 	if (ppc_io_indirect(name)) \
> 		return ppc_io.name(val); \
> 	else \
> 		return direct_ ## name(val); \
> }

Address type is different between IO and MMIO too. IO takes unsigned
long port and MMIO takes void __iomem *, with a const for the read
versions...

> #define DEF_IO_IN(name, arg) \
> static inline arg name(void) \
> { \
> 	if (ppc_io_indirect(name)) \
> 		return ppc_io.name(); \
> 	else \
> 		return direct_ ## name(); \
> }
> 
> DEF_IO_OUT(writeb, u8)
> DEF_IO_OUT(writew, u16)
> DEF_IO_OUT(writel, u32)
> DEF_IO_OUT(writeq, u64)
> DEF_IO_IN(readb, u8)
> DEF_IO_IN(readw, u16)
> DEF_IO_IN(readl, u32)
> DEF_IO_IN(readq, u64)
> DEF_IO_OUT(outb, u8)
> DEF_IO_OUT(outw, u16)
> DEF_IO_OUT(outl, u32)
> DEF_IO_OUT(outq, u64)
> DEF_IO_IN(inb, u8)
> DEF_IO_IN(inw, u16)
> DEF_IO_IN(inl, u32)
> DEF_IO_IN(inq, u64)

Overall, I still prefer my version :-)

Another thing I can do is to have an io_defs.h that contains basically
a list of all of them:

PCI_IO_DEF(writeb, u8, MMIO, OUT)
PCI_IO_DEF(writew, u16, MMIO, OUT)
 .../...

And then have the various .h and .c files #include that file after
#defining PCI_IO_DEF to different things.

Thus we could have that file included twice: once for the struct
definiction ppc_io that includes them to define the callbacks and once
to implement the inline accessors.

If the callbacks are in a struct, I don't have to implement them all
separately and EXPORT_SYMBOL each of them.

Ben.

 
