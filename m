Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id DFE3CDDE0F
	for <linuxppc-dev@ozlabs.org>; Sun, 13 May 2007 08:33:40 +1000 (EST)
Date: Sat, 12 May 2007 17:36:23 -0500
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] powerpc: make ioport_map() handle already mapped ranges
Message-ID: <20070512223623.GA16045@lixom.net>
References: <20070512143221.GB12890@lixom.net>
	<200705130018.42612.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200705130018.42612.arnd@arndb.de>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, May 13, 2007 at 12:18:42AM +0200, Arnd Bergmann wrote:
> On Saturday 12 May 2007, Olof Johansson wrote:
> > Make ioport_map() handle already mapped port range without trying
> > to add _IO_BASE to them.
> > 
> > 
> > Signed-off-by: Olof Johansson <olof@lixom.net>
> > 
> > Index: 2.6.21/arch/powerpc/kernel/iomap.c
> > ===================================================================
> > --- 2.6.21.orig/arch/powerpc/kernel/iomap.c
> > +++ 2.6.21/arch/powerpc/kernel/iomap.c
> > @@ -106,7 +106,13 @@ EXPORT_SYMBOL(iowrite32_rep);
> > ?
> > ?void __iomem *ioport_map(unsigned long port, unsigned int len)
> > ?{
> > -???????return (void __iomem *) (port + _IO_BASE);
> > +???????/* Do nothing if we're being asked to map an already
> > +??????? * ioremapped() address
> > +??????? */
> > +???????if (port >= IMALLOC_BASE && (port+len) < IMALLOC_END)
> > +???????????????return (void __iomem *) port;
> > +???????else
> > +???????????????return (void __iomem *) (port + _IO_BASE);
> > ?}
> 
> This patch looks wrong to me, it's an indication that either a driver
> is confusing ioport and __iomem addresses, or that something went
> wrong during the initialization of the primary PCI bus.

It's not for PCI. See discussion in:

http://ozlabs.org/pipermail/linuxppc-dev/2007-May/035744.html

> We have a bug on cell that would be fixed with this patch, so it
> might be the same problem, see the patch that I suggested for
> this at http://patchwork.ozlabs.org/linuxppc/patch?id=10840 .

Not in this case, but thanks for the pointer. Your case is still based
on the fact that you only have one io space range, you're just making
sure you're allocating out of that range. In my case, I have two distinct
ranges, they're even on different busses...


-Olof
