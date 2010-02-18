Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ACDBCB7E24
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2010 23:31:51 +1100 (EST)
Message-Id: <20100218122000.192444618@linutronix.de>
Date: Thu, 18 Feb 2010 12:22:27 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: [patch 02/15] powerpc: Convert pmc_owner_lock to raw_spinlock
References: <20100218121904.620984825@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pmc_owner_lock needs to be a real spinlock in RT. Convert it to
raw_spinlock.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/kernel/pmc.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: linux-2.6-tip/arch/powerpc/kernel/pmc.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/kernel/pmc.c
+++ linux-2.6-tip/arch/powerpc/kernel/pmc.c
@@ -37,7 +37,7 @@ static void dummy_perf(struct pt_regs *r
 }
 
 
-static DEFINE_SPINLOCK(pmc_owner_lock);
+static DEFINE_RAW_SPINLOCK(pmc_owner_lock);
 static void *pmc_owner_caller; /* mostly for debugging */
 perf_irq_t perf_irq = dummy_perf;
 
@@ -45,7 +45,7 @@ int reserve_pmc_hardware(perf_irq_t new_
 {
 	int err = 0;
 
-	spin_lock(&pmc_owner_lock);
+	raw_spin_lock(&pmc_owner_lock);
 
 	if (pmc_owner_caller) {
 		printk(KERN_WARNING "reserve_pmc_hardware: "
@@ -59,21 +59,21 @@ int reserve_pmc_hardware(perf_irq_t new_
 	perf_irq = new_perf_irq ? new_perf_irq : dummy_perf;
 
  out:
-	spin_unlock(&pmc_owner_lock);
+	raw_spin_unlock(&pmc_owner_lock);
 	return err;
 }
 EXPORT_SYMBOL_GPL(reserve_pmc_hardware);
 
 void release_pmc_hardware(void)
 {
-	spin_lock(&pmc_owner_lock);
+	raw_spin_lock(&pmc_owner_lock);
 
 	WARN_ON(! pmc_owner_caller);
 
 	pmc_owner_caller = NULL;
 	perf_irq = dummy_perf;
 
-	spin_unlock(&pmc_owner_lock);
+	raw_spin_unlock(&pmc_owner_lock);
 }
 EXPORT_SYMBOL_GPL(release_pmc_hardware);
 
