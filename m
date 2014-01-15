Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3A79C2C0089
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Jan 2014 17:02:15 +1100 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id s0F626I9012253
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Jan 2014 00:02:09 -0600
Message-ID: <1389765724.6933.78.camel@pasglop>
Subject: powerpc/powernv: Call OPAL sync before kexec'ing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Date: Wed, 15 Jan 2014 17:02:04 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
    
Its possible that OPAL may be writing to host memory during
kexec (like dump retrieve scenario). In this situation we might
end up corrupting host memory.
    
This patch makes OPAL sync call to make sure OPAL stops
writing to host memory before kexec'ing.
    
Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 0ac6f04..1920f70 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -162,6 +162,7 @@ extern int opal_enter_rtas(struct rtas_args *args,
 #define OPAL_DUMP_ACK				84
 #define OPAL_GET_MSG				85
 #define OPAL_CHECK_ASYNC_COMPLETION		86
+#define OPAL_SYNC_HOST_REBOOT			87
 
 #ifndef __ASSEMBLY__
 
@@ -841,6 +842,7 @@ int64_t opal_dump_read(uint32_t dump_id, uint64_t buffer);
 int64_t opal_dump_ack(uint32_t dump_id);
 int64_t opal_get_msg(uint64_t buffer, size_t size);
 int64_t opal_check_completion(uint64_t buffer, size_t size, uint64_t token);
+int64_t opal_sync_host_reboot(void);
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname, int depth, void *data);
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index d58fcae..9e7ca21 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -127,3 +127,4 @@ OPAL_CALL(opal_dump_read,			OPAL_DUMP_READ);
 OPAL_CALL(opal_dump_ack,			OPAL_DUMP_ACK);
 OPAL_CALL(opal_get_msg,				OPAL_GET_MSG);
 OPAL_CALL(opal_check_completion,		OPAL_CHECK_ASYNC_COMPLETION);
+OPAL_CALL(opal_sync_host_reboot,		OPAL_SYNC_HOST_REBOOT);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 0ba1ccb..619b94a 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -21,6 +21,7 @@
 #include <linux/kobject.h>
 #include <linux/debugfs.h>
 #include <linux/uaccess.h>
+#include <linux/delay.h>
 #include <asm/opal.h>
 #include <asm/firmware.h>
 #include <asm/mce.h>
@@ -581,10 +582,25 @@ subsys_initcall(opal_init);
 void opal_shutdown(void)
 {
 	unsigned int i;
+	long rc = OPAL_BUSY;
 
+	/* First free interrupts, which will also mask them */
 	for (i = 0; i < opal_irq_count; i++) {
 		if (opal_irqs[i])
 			free_irq(opal_irqs[i], 0);
 		opal_irqs[i] = 0;
 	}
+
+	/*
+	 * Then sync with OPAL which ensure anything that can
+	 * potentially write to our memory has completed such
+	 * as an ongoing dump retrieval
+	 */
+	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
+		rc = opal_sync_host_reboot();
+		if (rc == OPAL_BUSY)
+			opal_poll_events(NULL);
+		else
+			mdelay(10);
+	}
 }
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index ddc9690..86733d6 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -153,8 +153,10 @@ static void pnv_shutdown(void)
 	/* Let the PCI code clear up IODA tables */
 	pnv_pci_shutdown();
 
-	/* And unregister all OPAL interrupts so they don't fire
-	 * up while we kexec
+	/*
+	 * Stop OPAL activity: Unregister all OPAL interrupts so they
+	 * don't fire up while we kexec and make sure all potentially
+	 * DMA'ing ops are complete (such as dump retrieval).
 	 */
 	opal_shutdown();
 }
