Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 727BE67C33
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Nov 2006 11:15:43 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH/RFC] Hookable IO operations
Date: Sat, 4 Nov 2006 01:15:34 +0100
References: <1162588367.10630.100.camel@localhost.localdomain>
	<200611032348.38402.arnd@arndb.de>
	<1162594589.10630.135.camel@localhost.localdomain>
In-Reply-To: <1162594589.10630.135.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611040115.34235.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 03 November 2006 23:56, Benjamin Herrenschmidt wrote:
> 
> > Did you never consider this, or did you make your mind up in the
> > process?
> 
> I considered this and decided against it while doing the macro since I
> could get the hooks auto-generated easier as globals, but I can still
> change it, it's not that much bloat and might indeed look nicer.

I've just tried hacking something up, this is the best I could come up
with using the structure:

/* are these all we need, or did I miss any? */
struct ppc_io {
	void (*writeb)(u8 val);
	void (*writew)(u16 val);
	void (*writel)(u32 val);
	void (*writeq)(u64 val);
	u8   (*readb)(void);
	u16  (*readw)(void);
	u32  (*readl)(void);
	u64  (*readq)(void);
	void (*outb)(u8 val);
	void (*outw)(u16 val);
	void (*outl)(u32 val);
	void (*outq)(u64 val);
	u8   (*inb)(void);
	u16  (*inw)(void);
	u32  (*inl)(void);
	u64  (*inq)(void);
	void (*memset_io)(volatile void __iomem *addr, int c, unsigned long n);
	void (*memcpy_fromio)(void *dest,
			const volatile void __iomem *src, unsigned long n);
	void (*memcpy_toio)(volatile void __iomem *dest,
			const void *src, unsigned long n);
} ppc_io;

/* all these should be static inline or extern */
void direct_writeb(u8 val);
void direct_writew(u16 val);
void direct_writel(u32 val);
void direct_writeq(u64 val);
u8   direct_readb(void);
u16  direct_readw(void);
u32  direct_readl(void);
u64  direct_readq(void);
void direct_outb(u8 val);
void direct_outw(u16 val);
void direct_outl(u32 val);
void direct_outq(u64 val);
u8   direct_inb(void);
u16  direct_inw(void);
u32  direct_inl(void);
u64  direct_inq(void);
void direct_memset_io(volatile void __iomem *addr, int c,
                       unsigned long n);
void direct_memcpy_fromio(void *dest,
              const volatile void __iomem *src, unsigned long n);
void direct_memcpy_toio(volatile void __iomem *dest,
                const void *src, unsigned long n);

/* a simple indirection more than your code, going
   through the structure */
#ifdef CONFIG_INDIRECT_IO
#define ppc_io_indirect(x) ppc_io.x
#else
#define ppc_io_indirect(x) NULL
#endif

#define DEF_IO_OUT(name, arg) \
static inline void name(arg val) \
{ \
	if (ppc_io_indirect(name)) \
		return ppc_io.name(val); \
	else \
		return direct_ ## name(val); \
}

#define DEF_IO_IN(name, arg) \
static inline arg name(void) \
{ \
	if (ppc_io_indirect(name)) \
		return ppc_io.name(); \
	else \
		return direct_ ## name(); \
}

DEF_IO_OUT(writeb, u8)
DEF_IO_OUT(writew, u16)
DEF_IO_OUT(writel, u32)
DEF_IO_OUT(writeq, u64)
DEF_IO_IN(readb, u8)
DEF_IO_IN(readw, u16)
DEF_IO_IN(readl, u32)
DEF_IO_IN(readq, u64)
DEF_IO_OUT(outb, u8)
DEF_IO_OUT(outw, u16)
DEF_IO_OUT(outl, u32)
DEF_IO_OUT(outq, u64)
DEF_IO_IN(inb, u8)
DEF_IO_IN(inw, u16)
DEF_IO_IN(inl, u32)
DEF_IO_IN(inq, u64)

/* using variadic macros makes this somewhat simpler
 * than writing the whole prototype */
#define memset_io(arg...)				\
	do {						\
		if (ppc_io_indirect(memset_io)) 	\
			ppc_io.memset_io(arg);		\
		else					\
			direct_memset_io(arg);		\
	} while (0)

#define memcpy_fromio(arg...)				\
	do {						\
		if (ppc_io_indirect(memcpy_fromio))	\
			ppc_io.memcpy_fromio(arg);	\
		else					\
			direct_memcpy_fromio(arg);	\
	} while (0)

#define memcpy_toio(arg...)				\
	do {						\
		if (ppc_io_indirect(memcpy_toio))	\
			ppc_io.memcpy_toio(arg);	\
		else					\
			direct_memcpy_toio(arg);	\
	} while (0)
