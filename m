Message-ID: <3CAB3E58.723625D9@mvista.com>
Date: Wed, 03 Apr 2002 09:39:36 -0800
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Armin <akuster@pacbell.net>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Workaround for USB DMA bugs
References: <20020403024321.GN1026@zax> <3CAABAB0.5030000@pacbell.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Armin wrote:
>
> David Gibson wrote:
> > Well, I'm not sure I'd want to pollute the tree with this sort of
> > hack, but on the other hand it makes things work that wouldn't
> > otherwise.
> >
> > Does anyone think it's a good idea to commit the following patch:
> >
> > diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/mm/cachemap.c linux-grinch/arch/ppc/mm/cachemap.c
> > --- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/mm/cachemap.c    Thu Mar 14 13:49:01 2002
> > +++ linux-grinch/arch/ppc/mm/cachemap.c       Wed Apr  3 11:51:30 2002
> > @@ -137,7 +137,18 @@
> >       case PCI_DMA_NONE:
> >               BUG();
> >       case PCI_DMA_FROMDEVICE:        /* invalidate only */
> > +#ifdef CONFIG_USB
> > +             /* The USB stack is broken in that it uses DMA buffers
> > +                   on the stack which are on the stack and not
> > +                   cacheline aligned.  That means cache invalidates
> > +                   before DMA transfers corrupt the stack on machines
> > +                   without DMA-consistent cache.  This is a nasty
> > +                   workaround until the USB layer is fixed (apparently
> > +                   done in 2.5). */
> > +             flush_dcache_range(start, end);
> > +#else
> >               invalidate_dcache_range(start, end);
> > +#endif
> >               break;
> >       case PCI_DMA_TODEVICE:          /* writeback only */
> >               clean_dcache_range(start, end);
> >
> >
> > --
> > David Gibson                  | For every complex problem there is a
> > david@gibson.dropbear.id.au   | solution which is simple, neat and
> >                               | wrong.  -- H.L. Mencken
> > http://www.ozlabs.org/people/dgibson
> >
> >
> >
> >
> >
>
> Ah yes,  We have done something simular (internally) and had the same
> reservations. This will help me with the ocp usb drivers i am working
> on.   I would like to see some way of reminding us that this was done.
> let say a config option for 4xx_usb_dma_workarround.

Not just 4xx processors - this applies to all processors that require
CONFIG_NOT_COHERENT_CACHE.

-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
