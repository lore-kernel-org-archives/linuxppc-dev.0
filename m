Return-Path: <fthain@telegraphics.com.au>
Received: from mail.telegraphics.com.au (www.telegraphics.com.au
	[204.15.192.19]) by ozlabs.org (Postfix) with ESMTP id 00175B70CF
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 20:03:03 +1100 (EST)
Date: Tue, 17 Nov 2009 20:03:05 +1100 (EST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 10/13] mac68k: start CUDA early, take 2
In-Reply-To: <1258423421.2140.555.camel@pasglop>
Message-ID: <alpine.OSX.2.00.0911171715450.371@silk.local>
References: <alpine.OSX.2.00.0911031502250.483@silk.local>
	<1258423421.2140.555.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-m68k@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The valkyriefb driver needs the CUDA to work in order to set the video 
mode at boot. So initialise the device earlier, and bring the m68k code 
closer to the powermac code.

Take 2 was changed as per Benjamin Herrenschmidt's review.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

---
 arch/m68k/mac/config.c       |    6 +++
 drivers/macintosh/adb.c      |    6 ++-
 drivers/macintosh/via-cuda.c |   74 +++++++++++++++++++++++--------------------
 3 files changed, 51 insertions(+), 35 deletions(-)

Index: linux-2.6.31/arch/m68k/mac/config.c
===================================================================
--- linux-2.6.31.orig/arch/m68k/mac/config.c	2009-11-17 17:11:47.000000000 +1100
+++ linux-2.6.31/arch/m68k/mac/config.c	2009-11-17 17:11:47.000000000 +1100
@@ -23,6 +23,8 @@
 #include <linux/init.h>
 #include <linux/vt_kern.h>
 #include <linux/platform_device.h>
+#include <linux/adb.h>
+#include <linux/cuda.h>
 
 #define BOOTINFO_COMPAT_1_0
 #include <asm/setup.h>
@@ -889,6 +891,10 @@ static void __init mac_identify(void)
 	oss_init();
 	psc_init();
 	baboon_init();
+
+#ifdef CONFIG_ADB_CUDA
+	find_via_cuda();
+#endif
 }
 
 static void __init mac_report_hardware(void)
Index: linux-2.6.31/drivers/macintosh/via-cuda.c
===================================================================
--- linux-2.6.31.orig/drivers/macintosh/via-cuda.c	2009-11-17 17:07:58.000000000 +1100
+++ linux-2.6.31/drivers/macintosh/via-cuda.c	2009-11-17 17:11:47.000000000 +1100
@@ -89,7 +89,6 @@ static int cuda_fully_inited;
 
 #ifdef CONFIG_ADB
 static int cuda_probe(void);
-static int cuda_init(void);
 static int cuda_send_request(struct adb_request *req, int sync);
 static int cuda_adb_autopoll(int devs);
 static int cuda_reset_adb_bus(void);
@@ -107,17 +106,42 @@ int cuda_request(struct adb_request *req
 
 #ifdef CONFIG_ADB
 struct adb_driver via_cuda_driver = {
-	"CUDA",
-	cuda_probe,
-	cuda_init,
-	cuda_send_request,
-	cuda_adb_autopoll,
-	cuda_poll,
-	cuda_reset_adb_bus
+	.name         = "CUDA",
+	.probe        = cuda_probe,
+	.send_request = cuda_send_request,
+	.autopoll     = cuda_adb_autopoll,
+	.poll         = cuda_poll,
+	.reset_bus    = cuda_reset_adb_bus,
 };
 #endif /* CONFIG_ADB */
 
-#ifdef CONFIG_PPC
+#ifdef CONFIG_MAC
+int __init find_via_cuda(void)
+{
+    struct adb_request req;
+    int err;
+
+    if (macintosh_config->adb_type != MAC_ADB_CUDA)
+	return 0;
+
+    via = via1;
+    cuda_state = idle;
+
+    err = cuda_init_via();
+    if (err) {
+	printk(KERN_ERR "cuda_init_via() failed\n");
+	via = NULL;
+	return 0;
+    }
+
+    /* enable autopoll */
+    cuda_request(&req, NULL, 3, CUDA_PACKET, CUDA_AUTOPOLL, 1);
+    while (!req.complete)
+	cuda_poll();
+
+    return 1;
+}
+#else
 int __init find_via_cuda(void)
 {
     struct adb_request req;
@@ -175,7 +199,7 @@ int __init find_via_cuda(void)
     vias = NULL;
     return 0;
 }
-#endif /* CONFIG_PPC */
+#endif /* !defined CONFIG_MAC */
 
 static int __init via_cuda_start(void)
 {
@@ -184,14 +208,14 @@ static int __init via_cuda_start(void)
 
 #ifdef CONFIG_MAC
     cuda_irq = IRQ_MAC_ADB;
-#else /* CONFIG_MAC */
+#else
     cuda_irq = irq_of_parse_and_map(vias, 0);
     if (cuda_irq == NO_IRQ) {
 	printk(KERN_ERR "via-cuda: can't map interrupts for %s\n",
 	       vias->full_name);
 	return -ENODEV;
     }
-#endif /* CONFIG_MAC */
+#endif
 
     if (request_irq(cuda_irq, cuda_interrupt, 0, "ADB", cuda_interrupt)) {
 	printk(KERN_ERR "via-cuda: can't request irq %d\n", cuda_irq);
@@ -216,28 +240,10 @@ cuda_probe(void)
 #else
     if (macintosh_config->adb_type != MAC_ADB_CUDA)
 	return -ENODEV;
-    via = via1;
 #endif
-    return 0;
-}
-
-static int __init
-cuda_init(void)
-{
-#ifdef CONFIG_PPC
     if (via == NULL)
 	return -ENODEV;
     return 0;
-#else 
-    int err = cuda_init_via();
-    if (err) {
-	printk(KERN_ERR "cuda_init_via() failed\n");
-	return -ENODEV;
-    }
-    out_8(&via[IER], IER_SET|SR_INT); /* enable interrupt from SR */
-
-    return via_cuda_start();
-#endif
 }
 #endif /* CONFIG_ADB */
 
@@ -430,9 +436,11 @@ cuda_poll(void)
     /* cuda_interrupt only takes a normal lock, we disable
      * interrupts here to avoid re-entering and thus deadlocking.
      */
-    disable_irq(cuda_irq);
+    if (cuda_irq)
+	disable_irq(cuda_irq);
     cuda_interrupt(0, NULL);
-    enable_irq(cuda_irq);
+    if (cuda_irq)
+	enable_irq(cuda_irq);
 }
 
 static irqreturn_t
@@ -446,7 +454,7 @@ cuda_interrupt(int irq, void *arg)
     
     spin_lock(&cuda_lock);
 
-    /* On powermacs, this handler is registered for the VIA IRQ. But it uses
+    /* On powermacs, this handler is registered for the VIA IRQ. But they use
      * just the shift register IRQ -- other VIA interrupt sources are disabled.
      * On m68k macs, the VIA IRQ sources are dispatched individually. Unless
      * we are polling, the shift register IRQ flag has already been cleared.
Index: linux-2.6.31/drivers/macintosh/adb.c
===================================================================
--- linux-2.6.31.orig/drivers/macintosh/adb.c	2009-11-17 17:07:58.000000000 +1100
+++ linux-2.6.31/drivers/macintosh/adb.c	2009-11-17 17:11:47.000000000 +1100
@@ -317,9 +317,11 @@ static int __init adb_init(void)
 			break;
 		}
 	}
-	if ((adb_controller == NULL) || adb_controller->init()) {
-		printk(KERN_WARNING "Warning: no ADB interface detected\n");
+	if (adb_controller != NULL && adb_controller->init &&
+	    adb_controller->init())
 		adb_controller = NULL;
+	if (adb_controller == NULL) {
+		printk(KERN_WARNING "Warning: no ADB interface detected\n");
 	} else {
 #ifdef CONFIG_PPC
 		if (machine_is_compatible("AAPL,PowerBook1998") ||
