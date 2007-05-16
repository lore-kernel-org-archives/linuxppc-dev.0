Return-Path: <kou.ishizaki@toshiba.co.jp>
Date: Wed, 16 May 2007 16:14:31 +0900 (JST)
Message-Id: <200705160714.l4G7EW9b014697@toshiba.co.jp>
To: hch@lst.de
Subject: Re: [PATCH] fix celleb link failure
In-Reply-To: <20070515130940.GA11544@lst.de>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christoph, 

> txx9_serial_init calls early_serial_txx9_setup which is only available
> if CONFIG_SERIAL_TXX9_CONSOLE is define.  From looking at scc_sio.c
> it seems like the whole file is only needed for
> CONFIG_SERIAL_TXX9_CONSOLE=y, so we should only build it for that
case.
> 
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

NACK.

Thanks for pointing it out. But this fix is still wrong.
early_serial_txx9_setup is availble if CONFIG_SERIAL_TXX9=y.


> Index: linux-2.6.20/arch/powerpc/platforms/celleb/Makefile
> ===================================================================
> ---
linux-2.6.20.orig/arch/powerpc/platforms/celleb/Makefile	2007-05-
15 14:42:15.000000000 +0200
> +++
linux-2.6.20/arch/powerpc/platforms/celleb/Makefile	2007-05-15
14:42:31.000000000 +0200
> @@ -4,5 +4,5 @@ obj-y				+= interrupt.o iommu.o
setup.o 
>  
>  obj-$(CONFIG_SMP)		+= smp.o
>  obj-$(CONFIG_PPC_UDBG_BEAT)	+= udbg_beat.o
> -obj-$(CONFIG_HAS_TXX9_SERIAL)	+= scc_sio.o
> +obj-$(CONFIG_SERIAL_TXX9_CONSOLE) += scc_sio.o
>  obj-$(CONFIG_SPU_BASE)		+= spu_priv1.o

So scc_sio.o is depend on CONFIG_SERIAL_TXX9.


> Index: linux-2.6.20/arch/powerpc/platforms/celleb/scc_sio.c
> ===================================================================
> ---
linux-2.6.20.orig/arch/powerpc/platforms/celleb/scc_sio.c	2007-05-
15 14:40:49.000000000 +0200
> +++
linux-2.6.20/arch/powerpc/platforms/celleb/scc_sio.c	2007-05-15
14:42:47.000000000 +0200
> @@ -65,9 +65,7 @@ static int txx9_serial_init(void)
>  		req.line = i;
>  		req.iotype = UPIO_MEM;
>  		req.mapbase = res.start + txx9_scc_tab[i].offset;
> -#ifdef CONFIG_SERIAL_TXX9_CONSOLE
>  		req.membase = ioremap(req.mapbase, 0x24);
> -#endif
>  		req.irq = irq_create_of_mapping(irq.controller,
>  			irq.specifier, irq.size);
>  		req.flags |= UPF_IOREMAP | UPF_BUGGY_UART
/*HAVE_CTS_LINE*/;

And we need these #ifdef and #endif.

Best regards,
Kou Ishizaki
