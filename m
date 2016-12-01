Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tTn8J0L04zDvy9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 17:15:27 +1100 (AEDT)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Message-Id: <e93f70a138c45d7f021d2b5267180dd742ecf09f.1480572271.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1480572271.git.fthain@telegraphics.com.au>
References: <cover.1480572271.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 07/10] via-cuda: Use spinlock_irq_save/restore instead of
 enable/disable_irq
Date: Thu,  1 Dec 2016 01:09:33 -0500 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The cuda_start() function uses spinlock_irq_save/restore for mutual
exclusion. Let's have cuda_poll() do the same when polling the VIA
interrupt.

The benefit to disabling local irqs when the interrupt is being polled
is that the interrupt handler now has the same timing properties
regardless of whether it is invoked normally or from cuda_poll().

This driver was written back when local irqs remained enabled during
execution of interrupt handlers and cuda_poll() was probably trying
to achieve the same effect by use of enable/disable_irq.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

---

I wondered whether the use of enable/disable_irq was an attempt to reduce
interrupt latency given that VIA register accesses are slow. But if the
interrupt has not yet fired, only one VIA access will take place, which
imposes neglible latency anyway.
---
 drivers/macintosh/via-cuda.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/macintosh/via-cuda.c b/drivers/macintosh/via-cuda.c
index ff9062a..b801c67 100644
--- a/drivers/macintosh/via-cuda.c
+++ b/drivers/macintosh/via-cuda.c
@@ -459,14 +459,7 @@ cuda_start(void)
 void
 cuda_poll(void)
 {
-    /* cuda_interrupt only takes a normal lock, we disable
-     * interrupts here to avoid re-entering and thus deadlocking.
-     */
-    if (cuda_irq)
-	disable_irq(cuda_irq);
-    cuda_interrupt(0, NULL);
-    if (cuda_irq)
-	enable_irq(cuda_irq);
+	cuda_interrupt(0, NULL);
 }
 EXPORT_SYMBOL(cuda_poll);
 
@@ -475,13 +468,14 @@ EXPORT_SYMBOL(cuda_poll);
 static irqreturn_t
 cuda_interrupt(int irq, void *arg)
 {
+    unsigned long flags;
     u8 status;
     struct adb_request *req = NULL;
     unsigned char ibuf[16];
     int ibuf_len = 0;
     int complete = 0;
     
-    spin_lock(&cuda_lock);
+    spin_lock_irqsave(&cuda_lock, flags);
 
     /* On powermacs, this handler is registered for the VIA IRQ. But they use
      * just the shift register IRQ -- other VIA interrupt sources are disabled.
@@ -494,7 +488,7 @@ cuda_interrupt(int irq, void *arg)
 #endif
     {
         if ((in_8(&via[IFR]) & SR_INT) == 0) {
-            spin_unlock(&cuda_lock);
+            spin_unlock_irqrestore(&cuda_lock, flags);
             return IRQ_NONE;
         } else {
             out_8(&via[IFR], SR_INT);
@@ -616,7 +610,7 @@ cuda_interrupt(int irq, void *arg)
     default:
 	pr_err("cuda_interrupt: unknown cuda_state %d?\n", cuda_state);
     }
-    spin_unlock(&cuda_lock);
+    spin_unlock_irqrestore(&cuda_lock, flags);
     if (complete && req) {
     	void (*done)(struct adb_request *) = req->done;
     	mb();
-- 
2.7.3
