Return-Path: <GBIRAN@il.ibm.com>
In-Reply-To: <200811171710.24521.arnd@arndb.de>
Subject: Re: [PATCH] powerpc/cell/axon-msi: retry on missing interrupt
To: Arnd Bergmann <arnd@arndb.de>
Message-ID: <OFAA8011D7.7EC11C03-ONC2257505.00480C55-C2257505.00486E5E@il.ibm.com>
From: Giora Biran <GBIRAN@il.ibm.com>
Date: Tue, 18 Nov 2008 15:11:08 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: paulus@samba.org, cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd,
>> However, reading that position does not flush the DMA, so that we can
observe stale data in the buffer.

The position register is in the DCR space from which a read does not flush
the interrupt. But it seem that reading a register mapped to the PLB5 can
flush the interrupts if the C3PO is set to producer/consumer mode.


Giora



                                                                           
             Arnd Bergmann                                                 
             <arnd@arndb.de>                                               
                                                                        To 
             17/11/2008 18:10          linuxppc-dev@ozlabs.org,            
                                       benh@kernel.crashing.org,           
                                       paulus@samba.org                    
                                                                        cc 
                                       Giora Biran/Haifa/IBM@IBMIL,        
                                       cbe-oss-dev@ozlabs.org, Michael     
                                       Ellerman <michael@ellerman.id.au>   
                                                                   Subject 
                                       [PATCH] powerpc/cell/axon-msi:      
                                       retry on missing interrupt          
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           




The MSI capture logic for the axon bridge can sometimes
lose interrupts in case of high DMA and interrupt load,
when it signals an MSI interrupt to the MPIC interrupt
controller while we are already handling another MSI.

Each MSI vector gets written into a FIFO buffer in main
memory using DMA, and that DMA access is normally flushed
by the actual interrupt packet on the IOIF. An MMIO
register in the MSIC holds the position of the last
entry in the FIFO buffer that was written. However,
reading that position does not flush the DMA, so that
we can observe stale data in the buffer.

In a stress test, we have observed the DMA to arrive
up to 14 microseconds after reading the register.

This patch works around this problem by retrying the
access to the FIFO buffer.

We can reliably detect the conditioning by writing
an invalid MSI vector into the FIFO buffer after
reading from it, assuming that all MSIs we get
are valid. After detecting an invalid MSI vector,
we udelay(1) in the interrupt cascade for up to
100 times before giving up.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

---

 axon_msi.c |   36 +++++++++++++++++++++++++++++++-----
 1 files changed, 31 insertions(+), 5 deletions(-)

Index: linux-2.6/arch/powerpc/platforms/cell/axon_msi.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/axon_msi.c
2008-11-17 10:29:05.000000000 -0500
+++ linux-2.6/arch/powerpc/platforms/cell/axon_msi.c         2008-11-17
10:29:08.000000000 -0500
@@ -95,6 +95,7 @@
             struct axon_msic *msic = get_irq_data(irq);
             u32 write_offset, msi;
             int idx;
+            int retry = 0;

             write_offset = dcr_read(msic->dcr_host,
MSIC_WRITE_OFFSET_REG);
             pr_debug("axon_msi: original write_offset 0x%x\n",
write_offset);
@@ -102,7 +103,7 @@
             /* write_offset doesn't wrap properly, so we have to mask it
*/
             write_offset &= MSIC_FIFO_SIZE_MASK;

-            while (msic->read_offset != write_offset) {
+            while (msic->read_offset != write_offset && retry < 100) {
                         idx  = msic->read_offset / sizeof(__le32);
                         msi  = le32_to_cpu(msic->fifo_virt[idx]);
                         msi &= 0xFFFF;
@@ -110,13 +111,37 @@
                         pr_debug("axon_msi: woff %x roff %x msi %x\n",
                                       write_offset, msic->read_offset,
msi);

+                        if (msi < NR_IRQS && irq_map[msi].host == msic->
irq_host) {
+                                    generic_handle_irq(msi);
+                                    msic->fifo_virt[idx] = cpu_to_le32
(0xffffffff);
+                        } else {
+                                    /*
+                                     * Reading the MSIC_WRITE_OFFSET_REG
does not
+                                     * reliably flush the outstanding DMA
to the
+                                     * FIFO buffer. Here we were reading
stale
+                                     * data, so we need to retry.
+                                     */
+                                    udelay(1);
+                                    retry++;
+                                    pr_debug("axon_msi: invalid irq
0x%x!\n", msi);
+                                    continue;
+                        }
+
+                        if (retry) {
+                                    pr_debug("axon_msi: late irq 0x%x,
retry %d\n",
+                                                 msi, retry);
+                                    retry = 0;
+                        }
+
                         msic->read_offset += MSIC_FIFO_ENTRY_SIZE;
                         msic->read_offset &= MSIC_FIFO_SIZE_MASK;
+		 }

-                        if (msi < NR_IRQS && irq_map[msi].host == msic->
irq_host)
-                                    generic_handle_irq(msi);
-                        else
-                                    pr_debug("axon_msi: invalid irq
0x%x!\n", msi);
+            if (retry) {
+                        printk(KERN_WARNING "axon_msi: irq timed out\n");
+
+                        msic->read_offset += MSIC_FIFO_ENTRY_SIZE;
+                        msic->read_offset &= MSIC_FIFO_SIZE_MASK;
             }

             desc->chip->eoi(irq);
@@ -364,6 +389,7 @@
                                dn->full_name);
                         goto out_free_fifo;
             }
+            memset(msic->fifo_virt, 0xff, MSIC_FIFO_SIZE_BYTES);

             msic->irq_host = irq_alloc_host(dn, IRQ_HOST_MAP_NOMAP,
                                                             NR_IRQS,
&msic_host_ops, 0);
