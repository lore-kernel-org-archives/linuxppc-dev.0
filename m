Return-Path: <geert@linux-m68k.org>
Date: Wed, 7 Mar 2007 22:00:07 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@sonytel.be
To: Felix Domke <tmbinc@elitedvb.net>
Subject: Re: [patch 3/7] xenon: udbg support (ugly)
In-Reply-To: <20070307180525.919926000@elitedvb.net>>
Message-ID: <Pine.LNX.4.62.0703072159220.4463@pademelon.sonytel.be>
References: <20070307180144.812594000@elitedvb.net>>
	<20070307180525.919926000@elitedvb.net>>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux/PPC Development <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 7 Mar 2007, Felix Domke wrote:
> --- linux-2.6.20.orig/arch/powerpc/kernel/udbg.c	2007-03-07 19:01:12.000000000 +0100
> +++ linux-2.6.20/arch/powerpc/kernel/udbg.c	2007-03-07 19:01:21.000000000 +0100
> @@ -25,6 +25,18 @@
>   * Early debugging facilities. You can enable _one_ of these via .config,
>   * if you do so your kernel _will not boot_ on anything else. Be careful.
>   */
> +
> +extern u8 real_readb(volatile u8 __iomem  *addr);
> +extern void real_writeb(u8 data, volatile u8 __iomem *addr);
> +
> +void udbg_xenon_real_putc(char c)
> +{
> +	if (c == '\n')
> +		udbg_xenon_real_putc('\r');
> +	while (!(real_readb((void*)0x80000200ea001018ULL)&0x02));
> +	real_writeb(c, (void*)0x80000200ea001014ULL);
> +}
> +
>  void __init udbg_early_init(void)
>  {
>  #if defined(CONFIG_PPC_EARLY_DEBUG_LPAR)
> @@ -46,6 +58,7 @@
>  	/* For iSeries - hit Ctrl-x Ctrl-x to see the output */
>  	udbg_init_iseries();
>  #endif
> +	udbg_putc = udbg_xenon_real_putc;

No #ifdef?

>  }
>  
>  /* udbg library, used by xmon et al */
> @@ -150,6 +163,7 @@
>  		printk(KERN_INFO "early console immortal !\n");
>  		return;
>  	}
> +	return;

??

>  	unregister_console(&udbg_console);
>  	early_console_initialized = 0;
>  }

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
