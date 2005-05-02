Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E802E67A70
	for <linuxppc-dev@ozlabs.org>; Mon,  2 May 2005 16:14:09 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 02 May 2005 16:12:00 +1000
Message-Id: <1115014320.6031.14.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] ppc32: Fix might_sleep() warning with clock spreading
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

The clock spreading disable/enable code was called to late/early during
the suspend/resume code on some laptops and would trigger a
might_sleep() warning due to the down() call in the low level i2c code.

This fixes it by calling those functions earlier/later when interrupts
are still enabled.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/include/asm-ppc/pmac_feature.h
===================================================================
--- linux-work.orig/include/asm-ppc/pmac_feature.h	2005-05-02 10:49:57.000000000 +1000
+++ linux-work/include/asm-ppc/pmac_feature.h	2005-05-02 15:43:08.000000000 +1000
@@ -316,6 +316,9 @@
 extern void pmac_suspend_agp_for_card(struct pci_dev *dev);
 extern void pmac_resume_agp_for_card(struct pci_dev *dev);
 
+/* Used by the via-pmu driver for suspend/resume
+ */
+extern void pmac_tweak_clock_spreading(int enable);
 
 /*
  * The part below is for use by macio_asic.c only, do not rely
Index: linux-work/arch/ppc/platforms/pmac_feature.c
===================================================================
--- linux-work.orig/arch/ppc/platforms/pmac_feature.c	2005-05-02 13:16:22.000000000 +1000
+++ linux-work/arch/ppc/platforms/pmac_feature.c	2005-05-02 15:43:55.000000000 +1000
@@ -1591,8 +1591,10 @@
 }
 
 
-static void __pmac pmac_tweak_clock_spreading(struct macio_chip* macio, int enable)
+void __pmac pmac_tweak_clock_spreading(int enable)
 {
+	struct macio_chip* macio = &macio_chips[0];
+
 	/* Hack for doing clock spreading on some machines PowerBooks and
 	 * iBooks. This implements the "platform-do-clockspreading" OF
 	 * property as decoded manually on various models. For safety, we also
@@ -1707,9 +1709,6 @@
 	    macio->type != macio_intrepid)
 		return -ENODEV;
 
-	/* Disable clock spreading */
-	pmac_tweak_clock_spreading(macio, 0);
-
 	/* We power off the wireless slot in case it was not done
 	 * by the driver. We don't power it on automatically however
 	 */
@@ -1852,9 +1851,6 @@
 	UN_OUT(UNI_N_CLOCK_CNTL, save_unin_clock_ctl);
 	udelay(100);
 
-	/* Enable clock spreading */
-	pmac_tweak_clock_spreading(macio, 1);
-
 	return 0;
 }
 
@@ -2822,7 +2818,7 @@
 	 * clock spreading now. This should be a platform function but we
 	 * don't do these at the moment
 	 */
-	pmac_tweak_clock_spreading(&macio_chips[0], 1);
+	pmac_tweak_clock_spreading(1);
 
 #endif /* CONFIG_POWER4 */
 
Index: linux-work/drivers/macintosh/via-pmu.c
===================================================================
--- linux-work.orig/drivers/macintosh/via-pmu.c	2005-05-02 10:48:11.000000000 +1000
+++ linux-work/drivers/macintosh/via-pmu.c	2005-05-02 15:45:49.000000000 +1000
@@ -2351,6 +2351,10 @@
 		return -EBUSY;
 	}
 
+	/* Disable clock spreading on some machines */
+	pmac_tweak_clock_spreading(0);
+
+	/* Stop preemption */
 	preempt_disable();
 
 	/* Make sure the decrementer won't interrupt us */
@@ -2417,11 +2421,12 @@
 
 	/* Re-enable local CPU interrupts */
 	local_irq_enable();
-
 	mdelay(100);
-
 	preempt_enable();
 
+	/* Re-enable clock spreading on some machines */
+	pmac_tweak_clock_spreading(1);
+
 	/* Resume devices */
 	device_resume();
 
