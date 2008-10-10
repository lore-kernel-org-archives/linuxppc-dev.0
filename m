Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 82773DE14C
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 22:56:56 +1100 (EST)
Date: Fri, 10 Oct 2008 06:56:50 -0500 (CDT)
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: linuxppc-dev@ozlabs.org, Ben Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerrus <paulus@samba.org>
Message-id: <patch-ipi-3@bga.com>
In-Reply-To: <patch-ipi-2@bga.com>
Subject: [PATCH 14/16] powerpc mpic: use smp_request_message_ipi
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

mpic has 4 ipis so use the new smp_request_message_ipi to reduce
pathlength when reciving an ipi.

This has the side effect of using the common ipi names, and also
continuing to try request the remaining messages when one fails.

Signed-off-by: Milton Miller <miltonm@bga.com>

Index: next.git/arch/powerpc/sysdev/mpic.c
===================================================================
--- next.git.orig/arch/powerpc/sysdev/mpic.c	2008-10-05 00:20:41.000000000 -0500
+++ next.git/arch/powerpc/sysdev/mpic.c	2008-10-05 00:21:41.000000000 -0500
@@ -616,17 +616,6 @@ static inline void mpic_eoi(struct mpic 
 	(void)mpic_cpu_read(MPIC_INFO(CPU_WHOAMI));
 }
 
-#ifdef CONFIG_SMP
-static irqreturn_t mpic_ipi_action(int irq, void *data)
-{
-	long ipi = (long)data;
-
-	smp_message_recv(ipi);
-
-	return IRQ_HANDLED;
-}
-#endif /* CONFIG_SMP */
-
 /*
  * Linux descriptor level callbacks
  */
@@ -1492,13 +1481,7 @@ unsigned int mpic_get_mcirq(void)
 void mpic_request_ipis(void)
 {
 	struct mpic *mpic = mpic_primary;
-	long i, err;
-	static char *ipi_names[] = {
-		"IPI0 (call function)",
-		"IPI1 (reschedule)",
-		"IPI2 (call function single)",
-		"IPI3 (debugger break)",
-	};
+	int i;
 	BUG_ON(mpic == NULL);
 
 	printk(KERN_INFO "mpic: requesting IPIs ... \n");
@@ -1507,17 +1490,10 @@ void mpic_request_ipis(void)
 		unsigned int vipi = irq_create_mapping(mpic->irqhost,
 						       mpic->ipi_vecs[0] + i);
 		if (vipi == NO_IRQ) {
-			printk(KERN_ERR "Failed to map IPI %ld\n", i);
-			break;
-		}
-		err = request_irq(vipi, mpic_ipi_action,
-				  IRQF_DISABLED|IRQF_PERCPU,
-				  ipi_names[i], (void *)i);
-		if (err) {
-			printk(KERN_ERR "Request of irq %d for IPI %ld failed\n",
-			       vipi, i);
-			break;
+			printk(KERN_ERR "Failed to map %s\n", smp_ipi_name[i]);
+			continue;
 		}
+		smp_request_message_ipi(vipi, i);
 	}
 }
 
