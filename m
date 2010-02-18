Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C582CB840D
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2010 23:32:11 +1100 (EST)
Message-Id: <20100218122000.464157003@linutronix.de>
Date: Thu, 18 Feb 2010 12:22:55 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: [patch 09/15] powerpc: Convert feature_lock to raw_spinlock
References: <20100218121904.620984825@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

feature_lock needs to be a real spinlock in RT. Convert it to
raw_spinlock.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/include/asm/pmac_feature.h      |    2 +-
 arch/powerpc/platforms/powermac/feature.c    |    6 +++---
 arch/powerpc/platforms/powermac/pfunc_base.c |   24 ++++++++++++------------
 3 files changed, 16 insertions(+), 16 deletions(-)

Index: linux-2.6-tip/arch/powerpc/include/asm/pmac_feature.h
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/include/asm/pmac_feature.h
+++ linux-2.6-tip/arch/powerpc/include/asm/pmac_feature.h
@@ -378,7 +378,7 @@ extern struct macio_chip* macio_find(str
  * Those are exported by pmac feature for internal use by arch code
  * only like the platform function callbacks, do not use directly in drivers
  */
-extern spinlock_t feature_lock;
+extern raw_spinlock_t feature_lock;
 extern struct device_node *uninorth_node;
 extern u32 __iomem *uninorth_base;
 
Index: linux-2.6-tip/arch/powerpc/platforms/powermac/feature.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/powermac/feature.c
+++ linux-2.6-tip/arch/powerpc/platforms/powermac/feature.c
@@ -59,10 +59,10 @@ extern struct device_node *k2_skiplist[2
  * We use a single global lock to protect accesses. Each driver has
  * to take care of its own locking
  */
-DEFINE_SPINLOCK(feature_lock);
+DEFINE_RAW_SPINLOCK(feature_lock);
 
-#define LOCK(flags)	spin_lock_irqsave(&feature_lock, flags);
-#define UNLOCK(flags)	spin_unlock_irqrestore(&feature_lock, flags);
+#define LOCK(flags)	raw_spin_lock_irqsave(&feature_lock, flags);
+#define UNLOCK(flags)	raw_spin_unlock_irqrestore(&feature_lock, flags);
 
 
 /*
Index: linux-2.6-tip/arch/powerpc/platforms/powermac/pfunc_base.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/powermac/pfunc_base.c
+++ linux-2.6-tip/arch/powerpc/platforms/powermac/pfunc_base.c
@@ -50,13 +50,13 @@ static int macio_do_gpio_write(PMF_STD_A
 		value = ~value;
 
 	/* Toggle the GPIO */
-	spin_lock_irqsave(&feature_lock, flags);
+	raw_spin_lock_irqsave(&feature_lock, flags);
 	tmp = readb(addr);
 	tmp = (tmp & ~mask) | (value & mask);
 	DBG("Do write 0x%02x to GPIO %s (%p)\n",
 	    tmp, func->node->full_name, addr);
 	writeb(tmp, addr);
-	spin_unlock_irqrestore(&feature_lock, flags);
+	raw_spin_unlock_irqrestore(&feature_lock, flags);
 
 	return 0;
 }
@@ -145,9 +145,9 @@ static int macio_do_write_reg32(PMF_STD_
 	struct macio_chip *macio = func->driver_data;
 	unsigned long flags;
 
-	spin_lock_irqsave(&feature_lock, flags);
+	raw_spin_lock_irqsave(&feature_lock, flags);
 	MACIO_OUT32(offset, (MACIO_IN32(offset) & ~mask) | (value & mask));
-	spin_unlock_irqrestore(&feature_lock, flags);
+	raw_spin_unlock_irqrestore(&feature_lock, flags);
 	return 0;
 }
 
@@ -168,9 +168,9 @@ static int macio_do_write_reg8(PMF_STD_A
 	struct macio_chip *macio = func->driver_data;
 	unsigned long flags;
 
-	spin_lock_irqsave(&feature_lock, flags);
+	raw_spin_lock_irqsave(&feature_lock, flags);
 	MACIO_OUT8(offset, (MACIO_IN8(offset) & ~mask) | (value & mask));
-	spin_unlock_irqrestore(&feature_lock, flags);
+	raw_spin_unlock_irqrestore(&feature_lock, flags);
 	return 0;
 }
 
@@ -223,12 +223,12 @@ static int macio_do_write_reg32_slm(PMF_
 	if (args == NULL || args->count == 0)
 		return -EINVAL;
 
-	spin_lock_irqsave(&feature_lock, flags);
+	raw_spin_lock_irqsave(&feature_lock, flags);
 	tmp = MACIO_IN32(offset);
 	val = args->u[0].v << shift;
 	tmp = (tmp & ~mask) | (val & mask);
 	MACIO_OUT32(offset, tmp);
-	spin_unlock_irqrestore(&feature_lock, flags);
+	raw_spin_unlock_irqrestore(&feature_lock, flags);
 	return 0;
 }
 
@@ -243,12 +243,12 @@ static int macio_do_write_reg8_slm(PMF_S
 	if (args == NULL || args->count == 0)
 		return -EINVAL;
 
-	spin_lock_irqsave(&feature_lock, flags);
+	raw_spin_lock_irqsave(&feature_lock, flags);
 	tmp = MACIO_IN8(offset);
 	val = args->u[0].v << shift;
 	tmp = (tmp & ~mask) | (val & mask);
 	MACIO_OUT8(offset, tmp);
-	spin_unlock_irqrestore(&feature_lock, flags);
+	raw_spin_unlock_irqrestore(&feature_lock, flags);
 	return 0;
 }
 
@@ -278,12 +278,12 @@ static int unin_do_write_reg32(PMF_STD_A
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&feature_lock, flags);
+	raw_spin_lock_irqsave(&feature_lock, flags);
 	/* This is fairly bogus in darwin, but it should work for our needs
 	 * implemeted that way:
 	 */
 	UN_OUT(offset, (UN_IN(offset) & ~mask) | (value & mask));
-	spin_unlock_irqrestore(&feature_lock, flags);
+	raw_spin_unlock_irqrestore(&feature_lock, flags);
 	return 0;
 }
 
