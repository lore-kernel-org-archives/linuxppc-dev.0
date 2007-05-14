Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 6972EDDD0D
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 06:56:19 +1000 (EST)
Date: Mon, 14 May 2007 15:59:12 -0500
To: paulus@samba.org
Subject: [PATCH] powerpc: remove warning in mpic.c
Message-ID: <20070514205912.GA2951@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

arch/powerpc/sysdev/mpic.c: In function 'mpic_request_ipis':
arch/powerpc/sysdev/mpic.c:1445: warning: ignoring return value of 'request_irq', declared with attribute warn_unused_result

Signed-off-by: Olof Johansson <olof@lixom.net>


diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 4fd2bec..75aad38 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1424,7 +1424,7 @@ #ifdef CONFIG_SMP
 void mpic_request_ipis(void)
 {
 	struct mpic *mpic = mpic_primary;
-	int i;
+	int i, err;
 	static char *ipi_names[] = {
 		"IPI0 (call function)",
 		"IPI1 (reschedule)",
@@ -1442,8 +1442,14 @@ void mpic_request_ipis(void)
 			printk(KERN_ERR "Failed to map IPI %d\n", i);
 			break;
 		}
-		request_irq(vipi, mpic_ipi_action, IRQF_DISABLED|IRQF_PERCPU,
-			    ipi_names[i], mpic);
+		err = request_irq(vipi, mpic_ipi_action,
+				  IRQF_DISABLED|IRQF_PERCPU,
+				  ipi_names[i], mpic);
+		if (err) {
+			printk(KERN_ERR "Request of irq %d for IPI %d failed\n",
+			       vipi, i);
+			break;
+		}
 	}
 }
 
