Return-Path: <sonic_amiga@rambler.ru>
Received: from gw2.leta.ru (gw2.leta.ru [88.210.57.116])
	by ozlabs.org (Postfix) with ESMTP id 167D5DE014
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 23:15:58 +1100 (EST)
Received: from gw2.leta.ru (localhost [127.0.0.1])
	by gw.leta.sw (Postfix) with ESMTP id 8F6421055C
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 15:15:48 +0300 (MSK)
Received: from antispam.localhost (localhost [127.0.0.1])
	by gw2.leta.ru (Postfix) with SMTP id 65B3410636
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 15:15:48 +0300 (MSK)
Received: from freemm.leta.sw (freemm.leta.sw [192.168.1.187])
	by gw2.leta.ru (Postfix) with ESMTP id 3B5D51055C
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 15:15:48 +0300 (MSK)
Received: from programmer-dvk.leta.sw (programmer-dvk.leta.sw [192.168.1.224])
	by freemm.leta.sw (Postfix) with ESMTP id AAP000841C000745BDE337
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 15:06:15 +0300 (MSK)
Date: Mon, 29 Jan 2007 15:13:03 +0300
From: Pavel Fedin <sonic_amiga@rambler.ru>
Message-ID: <54654522.20070129151303@rambler.ru>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Virtual DMA support for floppy driver for new powerpc
	architecture
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Errors-To: sonic_amiga@rambler.ru
Reply-To: Pavel Fedin <sonic_amiga@rambler.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 Hello!

 During ppc64+ppc merge virtual DMA code for floppy driver was not
ported. This patch restores virtual DMA support for floppy in new
powerpc target.
 It is necessary at least on Pegasos and AmigaOne machines for the
floppy drive to function. ISA DMA controller works incorrectly there
due to its addressing limitations.
 Virtual DMA mode is activated by floppy=nodma option passed to the
kernel (or module). There's no automatic switch like on i386.

Signed-off-by: Pavel Fedin <sonic_amiga@rambler.ru>  

---

--- linux-2.6.19.2/include/asm-powerpc/floppy.h.orig    2007-01-10 22:10:37.000000000 +0300
+++ linux-2.6.19.2/include/asm-powerpc/floppy.h 2007-01-25 02:14:54.000000000 +0300
@@ -17,28 +17,115 @@
 #define fd_outb(value,port)    outb_p(value,port)
 
 #define fd_enable_dma()         enable_dma(FLOPPY_DMA)
-#define fd_disable_dma()        disable_dma(FLOPPY_DMA)
-#define fd_request_dma()        request_dma(FLOPPY_DMA, "floppy")
-#define fd_free_dma()           free_dma(FLOPPY_DMA)
+#define fd_disable_dma()        fd_ops->_disable_dma(FLOPPY_DMA)
+#define fd_free_dma()           fd_ops->_free_dma(FLOPPY_DMA)
 #define fd_clear_dma_ff()       clear_dma_ff(FLOPPY_DMA)
 #define fd_set_dma_mode(mode)   set_dma_mode(FLOPPY_DMA, mode)
 #define fd_set_dma_count(count) set_dma_count(FLOPPY_DMA, count)
+#define fd_get_dma_residue()    fd_ops->_get_dma_residue(FLOPPY_DMA)
 #define fd_enable_irq()         enable_irq(FLOPPY_IRQ)
 #define fd_disable_irq()        disable_irq(FLOPPY_IRQ)
 #define fd_cacheflush(addr,size) /* nothing */
-#define fd_request_irq()        request_irq(FLOPPY_IRQ, floppy_interrupt, \
-                                           IRQF_DISABLED, "floppy", NULL)
 #define fd_free_irq()           free_irq(FLOPPY_IRQ, NULL);
 
-#ifdef CONFIG_PCI
-
 #include <linux/pci.h>
 #include <asm/ppc-pci.h>       /* for ppc64_isabridge_dev */
 
-#define fd_dma_setup(addr,size,mode,io) powerpc_fd_dma_setup(addr,size,mode,io)
+#define fd_dma_setup(addr,size,mode,io) fd_ops->_dma_setup(addr,size,mode,io)
+
+static int fd_request_dma(void);
+
+struct fd_dma_ops {
+       void (*_disable_dma)(unsigned int dmanr);
+       void (*_free_dma)(unsigned int dmanr);
+       int (*_get_dma_residue)(unsigned int dummy);
+       int (*_dma_setup)(char *addr, unsigned long size, int mode, int io);
+};
+
+static int virtual_dma_count;
+static int virtual_dma_residue;
+static char *virtual_dma_addr;
+static int virtual_dma_mode;
+static int doing_vdma;
+static struct fd_dma_ops *fd_ops;
+
+static irqreturn_t floppy_hardint(int irq, void *dev_id)
+{
+       unsigned char st;
+       int lcount;
+       char *lptr;
+
+       if (!doing_vdma)
+               return floppy_interrupt(irq, dev_id);
+
+
+       st = 1;
+       for (lcount=virtual_dma_count, lptr=virtual_dma_addr;
+            lcount; lcount--, lptr++) {
+               st=inb(virtual_dma_port+4) & 0xa0 ;
+               if (st != 0xa0)
+                       break;
+               if (virtual_dma_mode)
+                       outb_p(*lptr, virtual_dma_port+5);
+               else
+                       *lptr = inb_p(virtual_dma_port+5);
+       }
+       virtual_dma_count = lcount;
+       virtual_dma_addr = lptr;
+       st = inb(virtual_dma_port+4);
+
+       if (st == 0x20)
+               return IRQ_HANDLED;
+       if (!(st & 0x20)) {
+               virtual_dma_residue += virtual_dma_count;
+               virtual_dma_count=0;
+               doing_vdma = 0;
+               floppy_interrupt(irq, dev_id);
+               return IRQ_HANDLED;
+       }
+       return IRQ_HANDLED;
+}
+
+static void vdma_disable_dma(unsigned int dummy)
+{
+       doing_vdma = 0;
+       virtual_dma_residue += virtual_dma_count;
+       virtual_dma_count=0;
+}
+
+static void vdma_nop(unsigned int dummy)
+{
+}
+
+
+static int vdma_get_dma_residue(unsigned int dummy)
+{
+       return virtual_dma_count + virtual_dma_residue;
+}
+
+
+static int fd_request_irq(void)
+{
+       if (can_use_virtual_dma)
+               return request_irq(FLOPPY_IRQ, floppy_hardint,
+                                  IRQF_DISABLED, "floppy", NULL);
+       else
+               return request_irq(FLOPPY_IRQ, floppy_interrupt,
+                                  IRQF_DISABLED, "floppy", NULL);
+}
+
+static int vdma_dma_setup(char *addr, unsigned long size, int mode, int io)
+{
+       doing_vdma = 1;
+       virtual_dma_port = io;
+       virtual_dma_mode = (mode  == DMA_MODE_WRITE);
+       virtual_dma_addr = addr;
+       virtual_dma_count = size;
+       virtual_dma_residue = 0;
+       return 0;
+}
 
-static __inline__ int powerpc_fd_dma_setup(char *addr, unsigned long size,
-                                          int mode, int io)
+static int hard_dma_setup(char *addr, unsigned long size, int mode, int io)
 {
        static unsigned long prev_size;
        static dma_addr_t bus_addr = 0;
@@ -46,6 +133,7 @@
        static int prev_dir;
        int dir;
 
+       doing_vdma = 0;
        dir = (mode == DMA_MODE_READ) ? PCI_DMA_FROMDEVICE : PCI_DMA_TODEVICE;
 
        if (bus_addr 
@@ -74,11 +162,32 @@
        return 0;
 }
 
-#endif /* CONFIG_PCI */
+static struct fd_dma_ops real_dma_ops =
+{
+       ._disable_dma = disable_dma,
+       ._free_dma = free_dma,
+       ._get_dma_residue = get_dma_residue,
+       ._dma_setup = hard_dma_setup
+};
+
+static struct fd_dma_ops virt_dma_ops =
+{
+       ._disable_dma = vdma_disable_dma,
+       ._free_dma = vdma_nop,
+       ._get_dma_residue = vdma_get_dma_residue,
+       ._dma_setup = vdma_dma_setup
+};
 
-__inline__ void virtual_dma_init(void)
+static int fd_request_dma()
 {
-       /* Nothing to do on PowerPC */
+       if (can_use_virtual_dma & 1) {
+               fd_ops = &virt_dma_ops;
+               return 0;
+       }
+       else {
+               fd_ops = &real_dma_ops;
+               return request_dma(FLOPPY_DMA, "floppy");
+       }
 }
 
 static int FDC1 = 0x3f0;
