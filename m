Date: Thu, 4 Apr 2002 09:35:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Workaround for USB DMA bugs
Message-ID: <20020403233558.GF21034@zax>
References: <20020403024321.GN1026@zax> <3CAACF45.8090003@elsoft.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CAACF45.8090003@elsoft.ch>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Apr 03, 2002 at 11:45:41AM +0200, "David M?ller (ELSOFT AG)" wrote:
> Hello
>
> David Gibson wrote:
> >Well, I'm not sure I'd want to pollute the tree with this sort of
> >hack, but on the other hand it makes things work that wouldn't
> >otherwise.
> >
> >Does anyone think it's a good idea to commit the following patch:
> >
> >diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/mm/cachemap.c
> >linux-grinch/arch/ppc/mm/cachemap.c
> >Mar 14 13:49:01 2002
> >+++ linux-grinch/arch/ppc/mm/cachemap.c	Wed Apr  3 11:51:30 2002
> >@@ -137,7 +137,18 @@
> > 	case PCI_DMA_NONE:
> > 		BUG();
> > 	case PCI_DMA_FROMDEVICE:	/* invalidate only */
> >+#ifdef CONFIG_USB
> >+		/* The USB stack is broken in that it uses DMA buffers
> >+                   on the stack which are on the stack and not
> >+                   cacheline aligned.  That means cache invalidates
> >+                   before DMA transfers corrupt the stack on machines
> >+                   without DMA-consistent cache.  This is a nasty
> >+                   workaround until the USB layer is fixed (apparently
> >+                   done in 2.5). */
> >+		flush_dcache_range(start, end);
> >+#else
> > 		invalidate_dcache_range(start, end);
> >+#endif
> > 		break;
> > 	case PCI_DMA_TODEVICE:		/* writeback only */
> > 		clean_dcache_range(start, end);
>
> Cool. This hack fixes a problem i see with the USB stack on our boards
> since quite some time.
>
> What about replacing "#ifdef CONFIG_USB" by
> "#if defined(CONFIG_USB) || defined(CONFIG_USB_MODULE)" so this
> workaround works also if the USB stack is compiled with module support
> enabled.

It might be safer / cleaner just to unconditionally enable it, as Dan
Malek suggested.

> BTW
> Do you know from which version of the 2.5 kernel on this buffer
> alignment problem is fixed?

No, I just happened to see a message from one of the USB people (Greg
K-H IIRC) saying he thought it was fixed in 2.5 and that they'd like
people to report any remaining non-cache-aligned buffers.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
