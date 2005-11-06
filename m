Return-Path: <SRS0+1f43185237e13202fede+805+infradead.org+dwmw2@baythorne.srs.infradead.org>
Received: from baythorne.infradead.org (baythorne.infradead.org [81.187.2.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 94051686A2
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Nov 2005 19:01:01 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Sun, 06 Nov 2005 08:00:50 +0000
Message-Id: <1131264050.10031.265.camel@baythorne.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix ppc32 smp build.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix PPC32 SMP build -- instead of setting the now non-existent
smp_tb_synchronized when the timebases are synchronised, we clear the
CPU_FTR_USE_TB bit when they're not. Does this look sane, and did I miss
cases where they're not synchronised?

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -363,8 +363,6 @@ static void __init psurge_dual_sync_tb(i
 
 	/* now interrupt the secondary, starting both TBs */
 	psurge_set_ipi(1);
-
-	smp_tb_synchronized = 1;
 }
 
 static struct irqaction psurge_irqaction = {
@@ -396,6 +394,8 @@ static void __init smp_psurge_setup_cpu(
 
 	if (psurge_type == PSURGE_DUAL)
 		psurge_dual_sync_tb(cpu_nr);
+	else
+		cur_cpu_spec->cpu_features &= ~CPU_FTR_USE_TB;
 }
 
 void __init smp_psurge_take_timebase(void)
@@ -624,10 +624,10 @@ void smp_core99_give_timebase(void)
 	/* wait for the secondary to have taken it */
 	for (t = 100000; t > 0 && sec_tb_reset; --t)
 		udelay(10);
-	if (sec_tb_reset)
+	if (sec_tb_reset) {
 		printk(KERN_WARNING "Timeout waiting sync(2) on second CPU\n");
-	else
-		smp_tb_synchronized = 1;
+		cur_cpu_spec->cpu_features &= ~CPU_FTR_USE_TB;
+	}
 
 	/* Now, restart the timebase by leaving the GPIO to an open collector */
        	pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL, core99_tb_gpio, 0);

-- 
dwmw2
