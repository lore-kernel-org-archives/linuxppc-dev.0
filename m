Message-ID: <3CAACF45.8090003@elsoft.ch>
Date: Wed, 03 Apr 2002 11:45:41 +0200
From: =?ISO-8859-1?Q?=22David_M=FCller_=28ELSOFT_AG=29=22?= <d.mueller@elsoft.ch>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Workaround for USB DMA bugs
References: <20020403024321.GN1026@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello

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


Cool. This hack fixes a problem i see with the USB stack on our boards
since quite some time.


What about replacing "#ifdef CONFIG_USB" by
"#if defined(CONFIG_USB) || defined(CONFIG_USB_MODULE)" so this
workaround works also if the USB stack is compiled with module support
enabled.

BTW
Do you know from which version of the 2.5 kernel on this buffer
alignment problem is fixed?


Dave


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
