Message-ID: <3CAABAB0.5030000@pacbell.net>
Date: Wed, 03 Apr 2002 08:17:52 +0000
From: Armin <akuster@pacbell.net>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Workaround for USB DMA bugs
References: <20020403024321.GN1026@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:
> Well, I'm not sure I'd want to pollute the tree with this sort of
> hack, but on the other hand it makes things work that wouldn't
> otherwise.
>
> Does anyone think it's a good idea to commit the following patch:
>
> diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/mm/cachemap.c linux-grinch/arch/ppc/mm/cachemap.c
> --- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/mm/cachemap.c	Thu Mar 14 13:49:01 2002
> +++ linux-grinch/arch/ppc/mm/cachemap.c	Wed Apr  3 11:51:30 2002
> @@ -137,7 +137,18 @@
>  	case PCI_DMA_NONE:
>  		BUG();
>  	case PCI_DMA_FROMDEVICE:	/* invalidate only */
> +#ifdef CONFIG_USB
> +		/* The USB stack is broken in that it uses DMA buffers
> +                   on the stack which are on the stack and not
> +                   cacheline aligned.  That means cache invalidates
> +                   before DMA transfers corrupt the stack on machines
> +                   without DMA-consistent cache.  This is a nasty
> +                   workaround until the USB layer is fixed (apparently
> +                   done in 2.5). */
> +		flush_dcache_range(start, end);
> +#else
>  		invalidate_dcache_range(start, end);
> +#endif
>  		break;
>  	case PCI_DMA_TODEVICE:		/* writeback only */
>  		clean_dcache_range(start, end);
>
>
> --
> David Gibson			| For every complex problem there is a
> david@gibson.dropbear.id.au	| solution which is simple, neat and
> 				| wrong.  -- H.L. Mencken
> http://www.ozlabs.org/people/dgibson
>
>
>
>
>

Ah yes,  We have done something simular (internally) and had the same
reservations. This will help me with the ocp usb drivers i am working
on.   I would like to see some way of reminding us that this was done.
let say a config option for 4xx_usb_dma_workarround.
.

-armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
