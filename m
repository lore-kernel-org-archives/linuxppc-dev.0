Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: paulus@samba.org
MIME-Version: 1.0
Subject: [PATCH] fix compile warning in pseries xics
Date: Tue, 29 May 2007 15:50:29 +1000
Message-ID: <27973.1180417829@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In 616883df78bd4b3fcdb6ddc39bd3d4cb902bfa32 request_irq was marked as
__must_check so we must... er... check it.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
This is the only request_irq which is not checked in arch/powerpc

 arch/powerpc/platforms/pseries/xics.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/platforms/pseries/xics.c
+++ linux-2.6-ozlabs/arch/powerpc/platforms/pseries/xics.c
@@ -752,6 +752,7 @@ skip_gserver_check:
 void xics_request_IPIs(void)
 {
 	unsigned int ipi;
+	int t;
 
 	ipi = irq_create_mapping(xics_host, XICS_IPI);
 	BUG_ON(ipi == NO_IRQ);
@@ -762,11 +763,15 @@ void xics_request_IPIs(void)
 	 */
 	set_irq_handler(ipi, handle_percpu_irq);
 	if (firmware_has_feature(FW_FEATURE_LPAR))
-		request_irq(ipi, xics_ipi_action_lpar, IRQF_DISABLED,
-			    "IPI", NULL);
+		t = request_irq(ipi, xics_ipi_action_lpar, IRQF_DISABLED,
+				"IPI", NULL);
 	else
-		request_irq(ipi, xics_ipi_action_direct, IRQF_DISABLED,
-			    "IPI", NULL);
+		t = request_irq(ipi, xics_ipi_action_direct, IRQF_DISABLED,
+				"IPI", NULL);
+	if (t)
+		printk(KERN_ERR "Unable to request interrupt %d for IPI\n",
+		       ipi);
+
 }
 #endif /* CONFIG_SMP */
 
