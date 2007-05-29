Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: paulus@samba.org
Subject: [PATCH] fix compile warning in pseries xics 
In-reply-to: <1180417937.5313.6.camel@concordia.ozlabs.ibm.com> 
References: <27973.1180417829@neuling.org>
	<1180417937.5313.6.camel@concordia.ozlabs.ibm.com>
Date: Tue, 29 May 2007 17:01:52 +1000
Message-ID: <4564.1180422112@neuling.org>
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
Updated based on comments from mpe and benh.

 arch/powerpc/platforms/pseries/xics.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/platforms/pseries/xics.c
+++ linux-2.6-ozlabs/arch/powerpc/platforms/pseries/xics.c
@@ -752,6 +752,7 @@ skip_gserver_check:
 void xics_request_IPIs(void)
 {
 	unsigned int ipi;
+	int rc;
 
 	ipi = irq_create_mapping(xics_host, XICS_IPI);
 	BUG_ON(ipi == NO_IRQ);
@@ -762,11 +763,12 @@ void xics_request_IPIs(void)
 	 */
 	set_irq_handler(ipi, handle_percpu_irq);
 	if (firmware_has_feature(FW_FEATURE_LPAR))
-		request_irq(ipi, xics_ipi_action_lpar, IRQF_DISABLED,
-			    "IPI", NULL);
+		rc = request_irq(ipi, xics_ipi_action_lpar, IRQF_DISABLED,
+				"IPI", NULL);
 	else
-		request_irq(ipi, xics_ipi_action_direct, IRQF_DISABLED,
-			    "IPI", NULL);
+		rc = request_irq(ipi, xics_ipi_action_direct, IRQF_DISABLED,
+				"IPI", NULL);
+	BUG_ON(rc);
 }
 #endif /* CONFIG_SMP */
 
