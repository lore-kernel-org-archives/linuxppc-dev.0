Return-Path: <dgibson@ozlabs.org>
Date: Thu, 13 Sep 2007 16:22:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>,
	Tony Breeds <tony@bakeyournoodle.com>, linuxppc-dev@ozlabs.org
Subject: Make mpc82xx use generic_calibrate_decr()
Message-ID: <20070913062201.GA24281@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The only difference between m82xx_calibrate_decr() and
generic_calibrate_decr() is that the former computes the timebase
frequency from the cpu node's bus-frequency property, instead of
directly from the timebase-frequency property.

But there's no reason the timebase-frequency shouldn't be correct on
82xx like everything else.  Certainly the 82xx bootwrapper in
arch/powerpc/boot/cuboot-pq2.c should get it right.

Therefore, this patch removes mpc82xx_calibrate_decr(), using
generic_calibrate_decr() instead.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---

I've compiled this, but no booted it, since I don't have any 82xx
hardware.  I'm hoping for an ack from someone who can test boot it.

Index: working-2.6/arch/powerpc/platforms/82xx/mpc82xx_ads.c
===================================================================
--- working-2.6.orig/arch/powerpc/platforms/82xx/mpc82xx_ads.c	2007-09-13 16:14:18.000000000 +1000
+++ working-2.6/arch/powerpc/platforms/82xx/mpc82xx_ads.c	2007-09-13 16:14:38.000000000 +1000
@@ -635,6 +635,6 @@ define_machine(mpc82xx_ads)
 	.init_IRQ =    mpc82xx_ads_pic_init,
 	.show_cpuinfo =    mpc82xx_ads_show_cpuinfo,
 	.get_irq =    cpm2_get_irq,
-	.calibrate_decr =    m82xx_calibrate_decr,
+	.calibrate_decr = generic_calibrate_decr,
 	.restart = m82xx_restart,.halt = m82xx_halt,
 };
Index: working-2.6/arch/powerpc/platforms/82xx/mpc82xx.c
===================================================================
--- working-2.6.orig/arch/powerpc/platforms/82xx/mpc82xx.c	2007-09-13 16:13:48.000000000 +1000
+++ working-2.6/arch/powerpc/platforms/82xx/mpc82xx.c	2007-09-13 16:15:13.000000000 +1000
@@ -51,42 +51,6 @@
 
 #include "pq2ads.h"
 
-static int __init get_freq(char *name, unsigned long *val)
-{
-	struct device_node *cpu;
-	const unsigned int *fp;
-	int found = 0;
-
-	/* The cpu node should have timebase and clock frequency properties */
-	cpu = of_find_node_by_type(NULL, "cpu");
-
-	if (cpu) {
-		fp = of_get_property(cpu, name, NULL);
-		if (fp) {
-			found = 1;
-			*val = *fp;
-		}
-
-		of_node_put(cpu);
-	}
-
-	return found;
-}
-
-void __init m82xx_calibrate_decr(void)
-{
-	ppc_tb_freq = 125000000;
-	if (!get_freq("bus-frequency", &ppc_tb_freq)) {
-		printk(KERN_ERR "WARNING: Estimating decrementer frequency "
-				"(not found)\n");
-	}
-	ppc_tb_freq /= 4;
-	ppc_proc_freq = 1000000000;
-	if (!get_freq("clock-frequency", &ppc_proc_freq))
-		printk(KERN_ERR "WARNING: Estimating processor frequency"
-				"(not found)\n");
-}
-
 void mpc82xx_ads_show_cpuinfo(struct seq_file *m)
 {
 	uint pvid, svid, phid1;

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
