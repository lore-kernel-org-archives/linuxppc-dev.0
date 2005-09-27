Return-Path: <zippel@linux-m68k.org>
Received: from scrub.xs4all.nl (scrub.xs4all.nl [194.109.195.176])
	by ozlabs.org (Postfix) with ESMTP id 18E37683CE
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Sep 2005 10:36:15 +1000 (EST)
Date: Tue, 27 Sep 2005 02:36:11 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Hollis Blanchard <hollis@penguinppc.org>
In-Reply-To: <96e9df75a769d22905026438cb4c5131@penguinppc.org>
Message-ID: <Pine.LNX.4.61.0509270230560.3728@scrub.home>
References: <Pine.LNX.4.61.0509250043410.19178@scrub.home>
	<96e9df75a769d22905026438cb4c5131@penguinppc.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 5/8] ppc: use correct asm ops
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Mon, 26 Sep 2005, Hollis Blanchard wrote:

> > --- linux.orig/include/asm-ppc/io.h	2005-09-23 16:20:24.000000000 +0200
> > +++ linux/include/asm-ppc/io.h	2005-09-23 16:20:26.000000000 +0200
> > @@ -294,10 +294,10 @@ extern __inline__ void name(unsigned int
> >  __do_out_asm(outb, "stbx")
> >  #ifdef CONFIG_APUS
> >  __do_in_asm(inb, "lbzx")
> > -__do_in_asm(inw, "lhz%U1%X1")
> > -__do_in_asm(inl, "lwz%U1%X1")
> > -__do_out_asm(outl,"stw%U0%X0")
> > -__do_out_asm(outw, "sth%U0%X0")
> > +__do_in_asm(inw, "lhzx")
> > +__do_in_asm(inl, "lwzx")
> > +__do_out_asm(outl,"stwx")
> > +__do_out_asm(outw, "sthx")
> >  #elif defined (CONFIG_8260_PCI9)
> >  /* in asm cannot be defined if PCI9 workaround is used */
> >  #define inb(port)		in_8((port)+___IO_BASE)
> 
> I don't see where this is explained in the GCC docs, but as I understand it
> those %U %X things are allowing somebody to use the "update" and "index"
> variants of the instruction. Why doesn't this work for you?

Because it requires the matching arguments, which are defined by 
__do_{in,out}_asm, otherwise an invalid instruction is generated.

bye, Roman
