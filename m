Return-Path: <hch@lst.de>
Date: Wed, 16 May 2007 12:37:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Subject: Re: [PATCH] fix celleb link failure
Message-ID: <20070516103752.GA22383@lst.de>
References: <20070515130940.GA11544@lst.de>
	<200705160714.l4G7EW9b014697@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200705160714.l4G7EW9b014697@toshiba.co.jp>
Cc: linuxppc-dev@ozlabs.org, hch@lst.de, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 16, 2007 at 04:14:31PM +0900, Ishizaki Kou wrote:
> NACK.
> 
> Thanks for pointing it out. But this fix is still wrong.
> early_serial_txx9_setup is availble if CONFIG_SERIAL_TXX9=y.

You're right.  I've updated the patch to only build scc_sio.o
only if CONFIG_SERIAL_TXX9 is set.  This works because
CONFIG_SERIAL_TXX9 can't be modular currently.

> > -#ifdef CONFIG_SERIAL_TXX9_CONSOLE
> >  		req.membase = ioremap(req.mapbase, 0x24);
> > -#endif
> >  		req.irq = irq_create_of_mapping(irq.controller,
> >  			irq.specifier, irq.size);
> >  		req.flags |= UPF_IOREMAP | UPF_BUGGY_UART
> /*HAVE_CTS_LINE*/;
> 
> And we need these #ifdef and #endif.

Ok, dropped.



Index: linux-2.6.20/arch/powerpc/platforms/celleb/Makefile
===================================================================
--- linux-2.6.20.orig/arch/powerpc/platforms/celleb/Makefile	2007-05-16 11:36:28.000000000 +0200
+++ linux-2.6.20/arch/powerpc/platforms/celleb/Makefile	2007-05-16 11:36:41.000000000 +0200
@@ -4,5 +4,5 @@ obj-y				+= interrupt.o iommu.o setup.o 
 
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_PPC_UDBG_BEAT)	+= udbg_beat.o
-obj-$(CONFIG_HAS_TXX9_SERIAL)	+= scc_sio.o
+obj-$(CONFIG_SERIAL_TXX9)	+= scc_sio.o
 obj-$(CONFIG_SPU_BASE)		+= spu_priv1.o
