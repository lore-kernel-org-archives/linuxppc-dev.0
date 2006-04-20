Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id A195C679E7
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Apr 2006 18:00:40 +1000 (EST)
From: David Jander <david.jander@protonic.nl>
To: Dan Malek <dan@embeddedalley.com>
Subject: Re: kernel 2.6.15: cpm_uart driver broken?
Date: Thu, 20 Apr 2006 09:41:30 +0200
References: <4D8794260B62C940BBA7150CC5EB3BD432D512@bosmail.BOS.int.mrv.com>
	<C8993021-BD00-4418-BF26-4BC8961BB53D@embeddedalley.com>
In-Reply-To: <C8993021-BD00-4418-BF26-4BC8961BB53D@embeddedalley.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200604200941.30812.david.jander@protonic.nl>
Cc: Kenneth Poole <kpoole@mrv.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi,

On Wednesday 19 April 2006 23:14, Dan Malek wrote:
> > I assumed that this test was simply to exclude console ports from
> > conversion.
>
> Bad assumption.  It's done to be able to use buffers allocated out
> of the CPM memory or before the VM is sufficiently configured to
> relocate the buffers.   This is needed for early debug prints, xmon,
> and kgdb.

Yes, but it's broken. In order to work as expected it had to be something 
like:

if((addr >= CPM_ADDR) && (addr <= CPM_ADDR_END))....

Otherwise you are also, in some configurations, excluding dma allocated memory 
from mapping, since in those cases (my case for instance) 
CONFIG_CONSISTENT_START > CPM_ADDR_END. (Assuming CPM_ADDR_END is something 
like CPM_ADDR+sizeof(DPRAM)).

What about the following patch?
This patch adds another member to "struct uart_cpm_port" to store a 
dma_offset. That offset is computed in cpm_uart_cpm?.c and passed to the 
cpu2cpm_addr() and cpm2cpu_addr() functions as a second argument.
One thing that still smells IMHO, is the check in cpm2cpu_addr() to see if we 
originally come from a dma-type address, although it should work under all 
situations I can think of. Any ideas?

=======================================
--- drivers/serial/cpm_uart/cpm_uart.h  (revision 513)
+++ drivers/serial/cpm_uart/cpm_uart.h  (working copy)
@@ -64,6 +64,7 @@
        uint                     dp_addr;
        void                    *mem_addr;
        dma_addr_t               dma_addr;
+       unsigned long    dma_offset;
        /* helpers */
        int                      baud;
        int                      bits;
--- drivers/serial/cpm_uart/cpm_uart_cpm1.c     (revision 513)
+++ drivers/serial/cpm_uart/cpm_uart_cpm1.c     (working copy)
@@ -191,11 +191,11 @@
                /* was hostalloc but changed cause it blows away the */
                /* large tlb mapping when pinning the kernel area    */
                mem_addr = (u8 *) cpm_dpram_addr(cpm_dpalloc(memsz, 8));
-               dma_addr = 0;
+               dma_addr = (dma_addr_t)mem_addr;
        } else
                mem_addr = dma_alloc_coherent(NULL, memsz, &dma_addr,
                                              GFP_KERNEL);
@@ -206,6 +206,7 @@
        pinfo->dp_addr = dp_offset;
        pinfo->mem_addr = mem_addr;
        pinfo->dma_addr = dma_addr;
+       pinfo->dma_offset = (dma_addr_t)((unsigned long)dma_addr - (unsigned 
long)mem_addr);

        pinfo->rx_buf = mem_addr;
        pinfo->tx_buf = pinfo->rx_buf + L1_CACHE_ALIGN(pinfo->rx_nrfifos
--- drivers/serial/cpm_uart/cpm_uart_core.c     (revision 518)
+++ drivers/serial/cpm_uart/cpm_uart_core.c     (working copy)
@@ -71,17 +71,19 @@

 /**************************************************************/

-static inline unsigned long cpu2cpm_addr(void *addr)
+static inline unsigned long cpu2cpm_addr(void *addr, unsigned long offset)
 {
-       if ((unsigned long)addr >= CPM_ADDR)
-               return (unsigned long)addr;
+       if (((unsigned long)addr >= CPM_ADDR)
+               || ((unsigned long)addr >= CONFIG_CONSISTENT_START))
+               return (unsigned long)addr + offset;
        return virt_to_bus(addr);
 }

-static inline void *cpm2cpu_addr(unsigned long addr)
+static inline void *cpm2cpu_addr(unsigned long addr, unsigned long offset)
 {
-       if (addr >= CPM_ADDR)
-               return (void *)addr;
+       if (((unsigned long)(addr - offset) >= CPM_ADDR)
+               || ((unsigned long)(addr - offset) >= 
CONFIG_CONSISTENT_START))
+               return (void *)(addr - offset);
        return bus_to_virt(addr);
 }
@@ -261,7 +262,7 @@
                }

                /* get pointer */
-               cp = cpm2cpu_addr(bdp->cbd_bufaddr);
+               cp = cpm2cpu_addr(bdp->cbd_bufaddr, pinfo->dma_offset);

                /* loop through the buffer */
                while (i-- > 0) {
@@ -615,7 +605,7 @@
                /* Pick next descriptor and fill from buffer */
                bdp = pinfo->tx_cur;

-               p = cpm2cpu_addr(bdp->cbd_bufaddr);
+               p = cpm2cpu_addr(bdp->cbd_bufaddr, pinfo->dma_offset);

                *p++ = xmit->buf[xmit->tail];
                bdp->cbd_datlen = 1;
@@ -642,7 +632,7 @@

        while (!(bdp->cbd_sc & BD_SC_READY) && (xmit->tail != xmit->head)) {
                count = 0;
-               p = cpm2cpu_addr(bdp->cbd_bufaddr);
+               p = cpm2cpu_addr(bdp->cbd_bufaddr, pinfo->dma_offset);
                while (count < pinfo->tx_fifosize) {
                        *p++ = xmit->buf[xmit->tail];
                        xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
@@ -680,6 +670,7 @@
 {
        int i;
        u8 *mem_addr;
+       unsigned long dma_offset;
        volatile cbd_t *bdp;

        pr_debug("CPM uart[%d]:initbd\n", pinfo->port.line);
@@ -689,14 +680,15 @@
         * virtual address for us to work with.
         */
        mem_addr = pinfo->mem_addr;
+       dma_offset = pinfo->dma_offset;
        bdp = pinfo->rx_cur = pinfo->rx_bd_base;
        for (i = 0; i < (pinfo->rx_nrfifos - 1); i++, bdp++) {
-               bdp->cbd_bufaddr = cpu2cpm_addr(mem_addr);
+               bdp->cbd_bufaddr = cpu2cpm_addr(mem_addr, dma_offset);
                bdp->cbd_sc = BD_SC_EMPTY | BD_SC_INTRPT;
                mem_addr += pinfo->rx_fifosize;
        }

-       bdp->cbd_bufaddr = cpu2cpm_addr(mem_addr);
+       bdp->cbd_bufaddr = cpu2cpm_addr(mem_addr, dma_offset);
        bdp->cbd_sc = BD_SC_WRAP | BD_SC_EMPTY | BD_SC_INTRPT;

        /* Set the physical address of the host memory
@@ -706,12 +698,12 @@
        mem_addr = pinfo->mem_addr + L1_CACHE_ALIGN(pinfo->rx_nrfifos * 
pinfo->rx_fifosize);
        bdp = pinfo->tx_cur = pinfo->tx_bd_base;
        for (i = 0; i < (pinfo->tx_nrfifos - 1); i++, bdp++) {
-               bdp->cbd_bufaddr = cpu2cpm_addr(mem_addr);
+               bdp->cbd_bufaddr = cpu2cpm_addr(mem_addr, dma_offset);
                bdp->cbd_sc = BD_SC_INTRPT;
                mem_addr += pinfo->tx_fifosize;
        }

-       bdp->cbd_bufaddr = cpu2cpm_addr(mem_addr);
+       bdp->cbd_bufaddr = cpu2cpm_addr(mem_addr, dma_offset);
        bdp->cbd_sc = BD_SC_WRAP | BD_SC_INTRPT;
 }

@@ -1041,7 +1033,7 @@
                 * If the buffer address is in the CPM DPRAM, don't
                 * convert it.
                 */
-               cp = cpm2cpu_addr(bdp->cbd_bufaddr);
+               cp = cpm2cpu_addr(bdp->cbd_bufaddr, pinfo->dma_offset);

                *cp = *s;

@@ -1058,7 +1050,7 @@
                        while ((bdp->cbd_sc & BD_SC_READY) != 0)
                                ;

-                       cp = cpm2cpu_addr(bdp->cbd_bufaddr);
+                       cp = cpm2cpu_addr(bdp->cbd_bufaddr, 
pinfo->dma_offset);

                        *cp = 13;
                        bdp->cbd_datlen = 1;
======================================================

cpm_uart_cpm2.c may need the same changes as cpm_uart_cpm1.c.

> These modifications further remove features that have been
> part of past kernels, and it has to stop.

Hmmm. What do you mean? The driver is broken, we want to fix it.

Greetings,

-- 
David Jander
Protonic Holland.
tel.: +31 (0) 229 212928
fax.: +31 (0) 229 210930
Factorij 36 / 1689 AL Zwaag
