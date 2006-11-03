Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 80A2367C48
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Nov 2006 09:48:47 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH/RFC] Hookable IO operations
Date: Fri, 3 Nov 2006 23:48:37 +0100
References: <1162588367.10630.100.camel@localhost.localdomain>
	<200611032320.34762.arnd@arndb.de>
	<1162593121.10630.132.camel@localhost.localdomain>
In-Reply-To: <1162593121.10630.132.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200611032348.38402.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 03 November 2006 23:32, Benjamin Herrenschmidt wrote:

> > If you leave out the 'extern', it fits into a normal line ;-)
> 
> Did I change them from the initial definition ? Anyway, I dislike
> prototypes in headers without "extern".

I prefer writing down the extern as well, but the common style
seems to have moved away from it now.

> 
> > > +
> > > +extern void (*__memset_io)(volatile void __iomem *addr, int c,
> > > +			   unsigned long n);
> > > +extern void (*__memcpy_fromio)(void *dest, const volatile void __iomem *src,
> > > +			       unsigned long n);
> > > +extern void (*__memcpy_toio)(volatile void __iomem *dest, const void *src,
> > > +			     unsigned long n);
> > 
> > Why are these all separate symbols? Wouldn't it be clearer to group them
> > in ppc_md, or a similar structure of function pointers?
> 
> Because the IO ones are separate already and I want to keep things
> consistent with them.

Actually I meant all of the I/O pointers, not just these three. When
you were describing your idea to me, I was thinking of something like

struct ppc_io {
	void (*writeb)(u8 val);
	void (*writew)(u16 val);
	void (*writel)(u32 val);
	void (*writeq)(u64 val);
	...
	void (*memset_io)(volatile void __iomem *addr, int c,
				 unsigned long n);
	void (*__memcpy_fromio)(void *dest,
			const volatile void __iomem *src, unsigned long n);
	void (*__memcpy_toio)(volatile void __iomem *dest,
			const void *src, unsigned long n);
} *ppc_io;

Did you never consider this, or did you make your mind up in the
process?

Is your current code more efficient?

> > > -static u8 iSeries_Read_Byte(const volatile void __iomem *IoAddress)
> > > +static u8 iseries_readb(const volatile void __iomem *IoAddress)
> > 
> > Since you're converting iSeries_Read_Byte from SilLycAps, shouldn't
> > you change IoAddress to something more sensible at the same time?
> 
> No, I'm only changing the prototype & name to better match my hooks,
> further cleanups of the content of these functions is something I'll do
> in a separate patch.

ok, makes sense.

	Arnd <><
