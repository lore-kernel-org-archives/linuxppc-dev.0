Return-Path: <fthain@telegraphics.com.au>
Received: from loopy.telegraphics.com.au (loopy.telegraphics.com.au
	[202.45.126.152]) by ozlabs.org (Postfix) with ESMTP id 8C913DDEEB
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Mar 2007 13:30:45 +1100 (EST)
Date: Sun, 18 Mar 2007 13:30:45 +1100 (EST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 10/13] CUDA ADB fixes, version 2
In-Reply-To: <Pine.LNX.4.64.0703171731391.4875@loopy.telegraphics.com.au>
Message-ID: <Pine.LNX.4.64.0703181327160.11593@loopy.telegraphics.com.au>
References: <Pine.LNX.4.64.0703171731391.4875@loopy.telegraphics.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-m68k@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


v2 is v1 with a comment moved to the correct side of a semi-colon (thanks 
to David D. Kelzer for spotting that).

Fix the flakiness in the CUDA ADB driver on m68k macs (keypresses getting 
wedged down or ADB just going AWOL altogether).

The only IRQ used by this driver is the VIA shift register IRQ. The 
PowerMac conditional code disables the other VIA IRQ sources, so don't 
mess with the other IRQ flags in the common code -- m68k macs need them.

When polling, don't disable local interrupts when we only need to disable 
the CUDA interrupt.

Unless polling, don't clear the shift register IRQ flag. On m68k macs this 
creates a race that often breaks CUDA ADB.

Tested on Quadra 840av and LC630 (both m68k); also Beige G3 (powerpc).

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
 
 drivers/macintosh/via-cuda.c |   58 +++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 26 deletions(-)

Index: linux-2.6.20/drivers/macintosh/via-cuda.c
===================================================================
--- linux-2.6.20.orig/drivers/macintosh/via-cuda.c	2007-03-05 15:19:49.000000000 +1100
+++ linux-2.6.20/drivers/macintosh/via-cuda.c	2007-03-05 15:20:49.000000000 +1100
@@ -83,6 +83,7 @@ static unsigned char cuda_rbuf[16];
 static unsigned char *reply_ptr;
 static int reading_reply;
 static int data_index;
+static int cuda_irq;
 #ifdef CONFIG_PPC
 static struct device_node *vias;
 #endif
@@ -161,10 +162,8 @@ int __init find_via_cuda(void)
     /* Clear and enable interrupts, but only on PPC. On 68K it's done  */
     /* for us by the main VIA driver in arch/m68k/mac/via.c        */
 
-#ifndef CONFIG_MAC
     out_8(&via[IFR], 0x7f);	/* clear interrupts by writing 1s */
     out_8(&via[IER], IER_SET|SR_INT); /* enable interrupt from SR */
-#endif
 
     /* enable autopoll */
     cuda_request(&req, NULL, 3, CUDA_PACKET, CUDA_AUTOPOLL, 1);
@@ -182,24 +181,22 @@ int __init find_via_cuda(void)
 
 static int __init via_cuda_start(void)
 {
-    unsigned int irq;
-
     if (via == NULL)
 	return -ENODEV;
 
 #ifdef CONFIG_MAC
-    irq = IRQ_MAC_ADB;
+    cuda_irq = IRQ_MAC_ADB;
 #else /* CONFIG_MAC */
-    irq = irq_of_parse_and_map(vias, 0);
-    if (irq == NO_IRQ) {
+    cuda_irq = irq_of_parse_and_map(vias, 0);
+    if (cuda_irq == NO_IRQ) {
 	printk(KERN_ERR "via-cuda: can't map interrupts for %s\n",
 	       vias->full_name);
 	return -ENODEV;
     }
-#endif /* CONFIG_MAP */
+#endif /* CONFIG_MAC */
 
-    if (request_irq(irq, cuda_interrupt, 0, "ADB", cuda_interrupt)) {
-	printk(KERN_ERR "via-cuda: can't request irq %d\n", irq);
+    if (request_irq(cuda_irq, cuda_interrupt, 0, "ADB", cuda_interrupt)) {
+	printk(KERN_ERR "via-cuda: can't request irq %d\n", cuda_irq);
 	return -EAGAIN;
     }
 
@@ -239,6 +236,7 @@ cuda_init(void)
 	printk(KERN_ERR "cuda_init_via() failed\n");
 	return -ENODEV;
     }
+    out_8(&via[IER], IER_SET|SR_INT); /* enable interrupt from SR */
 
     return via_cuda_start();
 #endif
@@ -264,15 +262,17 @@ cuda_init_via(void)
     out_8(&via[B], in_8(&via[B]) | TACK | TIP);			/* negate them */
     out_8(&via[ACR] ,(in_8(&via[ACR]) & ~SR_CTRL) | SR_EXT);	/* SR data in */
     (void)in_8(&via[SR]);						/* clear any left-over data */
-#ifndef CONFIG_MAC
+#ifdef CONFIG_PPC
     out_8(&via[IER], 0x7f);					/* disable interrupts from VIA */
     (void)in_8(&via[IER]);
+#else
+    out_8(&via[IER], SR_INT);					/* disable SR interrupt from VIA */
 #endif
 
     /* delay 4ms and then clear any pending interrupt */
     mdelay(4);
     (void)in_8(&via[SR]);
-    out_8(&via[IFR], in_8(&via[IFR]) & 0x7f);
+    out_8(&via[IFR], SR_INT);
 
     /* sync with the CUDA - assert TACK without TIP */
     out_8(&via[B], in_8(&via[B]) & ~TACK);
@@ -283,7 +283,7 @@ cuda_init_via(void)
     /* wait for the interrupt and then clear it */
     WAIT_FOR(in_8(&via[IFR]) & SR_INT, "CUDA response to sync (2)");
     (void)in_8(&via[SR]);
-    out_8(&via[IFR], in_8(&via[IFR]) & 0x7f);
+    out_8(&via[IFR], SR_INT);
 
     /* finish the sync by negating TACK */
     out_8(&via[B], in_8(&via[B]) | TACK);
@@ -292,7 +292,7 @@ cuda_init_via(void)
     WAIT_FOR(in_8(&via[B]) & TREQ, "CUDA response to sync (3)");
     WAIT_FOR(in_8(&via[IFR]) & SR_INT, "CUDA response to sync (4)");
     (void)in_8(&via[SR]);
-    out_8(&via[IFR], in_8(&via[IFR]) & 0x7f);
+    out_8(&via[IFR], SR_INT);
     out_8(&via[B], in_8(&via[B]) | TIP);	/* should be unnecessary */
 
     return 0;
@@ -429,16 +429,12 @@ cuda_start(void)
 void
 cuda_poll(void)
 {
-    unsigned long flags;
-
     /* cuda_interrupt only takes a normal lock, we disable
      * interrupts here to avoid re-entering and thus deadlocking.
-     * An option would be to disable only the IRQ source with
-     * disable_irq(), would that work on m68k ? --BenH
      */
-    local_irq_save(flags);
+    disable_irq(cuda_irq);
     cuda_interrupt(0, NULL);
-    local_irq_restore(flags);
+    enable_irq(cuda_irq);
 }
 
 static irqreturn_t
@@ -449,15 +445,25 @@ cuda_interrupt(int irq, void *arg)
     unsigned char ibuf[16];
     int ibuf_len = 0;
     int complete = 0;
-    unsigned char virq;
     
     spin_lock(&cuda_lock);
 
-    virq = in_8(&via[IFR]) & 0x7f;
-    out_8(&via[IFR], virq);   
-    if ((virq & SR_INT) == 0) {
-        spin_unlock(&cuda_lock);
-	return IRQ_NONE;
+    /* On powermacs, this handler is registered for the VIA IRQ. But it uses
+     * just the shift register IRQ -- other VIA interrupt sources are disabled.
+     * On m68k macs, the VIA IRQ sources are dispatched individually. Unless
+     * we are polling, the shift register IRQ flag has already been cleared.
+     */
+
+#ifdef CONFIG_MAC
+    if (!arg)
+#endif
+    {
+        if ((in_8(&via[IFR]) & SR_INT) == 0) {
+            spin_unlock(&cuda_lock);
+            return IRQ_NONE;
+        } else {
+            out_8(&via[IFR], SR_INT);
+        }
     }
     
     status = (~in_8(&via[B]) & (TIP|TREQ)) | (in_8(&via[ACR]) & SR_OUT);
