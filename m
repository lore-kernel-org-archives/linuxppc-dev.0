Return-Path: <anton@samba.org>
Date: Thu, 22 Mar 2012 12:58:03 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 5/6] powerpc/pseries: Clean up ras_error_interrupt code
Message-ID: <20120322125803.40bb5e34@kryten>
In-Reply-To: <20120322125649.434c6f5e@kryten>
References: <20120322124707.3cd3037f@kryten> <20120322125343.63d77e82@kryten>
 <20120322125649.434c6f5e@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The RAS error interrupt is no longer used but we may as well
mirror the changes we made to the EPOW interrupt.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/platforms/pseries/ras.c
===================================================================
--- linux-build.orig/arch/powerpc/platforms/pseries/ras.c	2012-03-22 12:43:56.574267101 +1100
+++ linux-build/arch/powerpc/platforms/pseries/ras.c	2012-03-22 12:44:13.306570733 +1100
@@ -246,7 +246,7 @@ static irqreturn_t ras_epow_interrupt(in
 static irqreturn_t ras_error_interrupt(int irq, void *dev_id)
 {
 	struct rtas_error_log *rtas_elog;
-	int status = 0xdeadbeef;
+	int status;
 	int fatal;
 
 	spin_lock(&ras_log_buf_lock);
@@ -254,7 +254,7 @@ static irqreturn_t ras_error_interrupt(i
 	status = rtas_call(ras_check_exception_token, 6, 1, NULL,
 			   RTAS_VECTOR_EXTERNAL_INTERRUPT,
 			   virq_to_hw(irq),
-			   RTAS_INTERNAL_ERROR, 1 /*Time Critical */,
+			   RTAS_INTERNAL_ERROR, 1 /* Time Critical */,
 			   __pa(&ras_log_buf),
 				rtas_get_error_log_max());
 
@@ -269,24 +269,13 @@ static irqreturn_t ras_error_interrupt(i
 	log_error(ras_log_buf, ERR_TYPE_RTAS_LOG, fatal);
 
 	if (fatal) {
-		udbg_printf("Fatal HW Error <0x%lx 0x%x>\n",
-			    *((unsigned long *)&ras_log_buf), status);
-		printk(KERN_EMERG "Error: Fatal hardware error <0x%lx 0x%x>\n",
-		       *((unsigned long *)&ras_log_buf), status);
-
-#ifndef DEBUG_RTAS_POWER_OFF
-		/* Don't actually power off when debugging so we can test
-		 * without actually failing while injecting errors.
-		 * Error data will not be logged to syslog.
-		 */
-		ppc_md.power_off();
-#endif
+		pr_emerg("Fatal hardware error reported by firmware");
+		pr_emerg("Check RTAS error log for details");
+		pr_emerg("Immediate power off");
+		emergency_sync();
+		kernel_power_off();
 	} else {
-		udbg_printf("Recoverable HW Error <0x%lx 0x%x>\n",
-			    *((unsigned long *)&ras_log_buf), status);
-		printk(KERN_WARNING
-		       "Warning: Recoverable hardware error <0x%lx 0x%x>\n",
-		       *((unsigned long *)&ras_log_buf), status);
+		pr_err("Recoverable hardware error reported by firmware");
 	}
 
 	spin_unlock(&ras_log_buf_lock);
