Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 13790B816C
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2010 23:32:01 +1100 (EST)
Message-Id: <20100218122000.582599512@linutronix.de>
Date: Thu, 18 Feb 2010 12:23:07 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: [patch 12/15] powerpc: Convert confirm_error_lock to raw_spinlock
References: <20100218121904.620984825@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

confirm_error_lock needs to be a real spinlock in RT. Convert it to
raw_spinlock.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/platforms/pseries/eeh.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

Index: linux-2.6-tip/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/pseries/eeh.c
+++ linux-2.6-tip/arch/powerpc/platforms/pseries/eeh.c
@@ -100,7 +100,7 @@ int eeh_subsystem_enabled;
 EXPORT_SYMBOL(eeh_subsystem_enabled);
 
 /* Lock to avoid races due to multiple reports of an error */
-static DEFINE_SPINLOCK(confirm_error_lock);
+static DEFINE_RAW_SPINLOCK(confirm_error_lock);
 
 /* Buffer for reporting slot-error-detail rtas calls. Its here
  * in BSS, and not dynamically alloced, so that it ends up in
@@ -436,7 +436,7 @@ static void __eeh_clear_slot(struct devi
 void eeh_clear_slot (struct device_node *dn, int mode_flag)
 {
 	unsigned long flags;
-	spin_lock_irqsave(&confirm_error_lock, flags);
+	raw_spin_lock_irqsave(&confirm_error_lock, flags);
 	
 	dn = find_device_pe (dn);
 	
@@ -447,7 +447,7 @@ void eeh_clear_slot (struct device_node 
 	PCI_DN(dn)->eeh_mode &= ~mode_flag;
 	PCI_DN(dn)->eeh_check_count = 0;
 	__eeh_clear_slot(dn, mode_flag);
-	spin_unlock_irqrestore(&confirm_error_lock, flags);
+	raw_spin_unlock_irqrestore(&confirm_error_lock, flags);
 }
 
 /**
@@ -506,7 +506,7 @@ int eeh_dn_check_failure(struct device_n
 	 * in one slot might report errors simultaneously, and we
 	 * only want one error recovery routine running.
 	 */
-	spin_lock_irqsave(&confirm_error_lock, flags);
+	raw_spin_lock_irqsave(&confirm_error_lock, flags);
 	rc = 1;
 	if (pdn->eeh_mode & EEH_MODE_ISOLATED) {
 		pdn->eeh_check_count ++;
@@ -575,7 +575,7 @@ int eeh_dn_check_failure(struct device_n
 	 * with other functions on this device, and functions under
 	 * bridges. */
 	eeh_mark_slot (dn, EEH_MODE_ISOLATED);
-	spin_unlock_irqrestore(&confirm_error_lock, flags);
+	raw_spin_unlock_irqrestore(&confirm_error_lock, flags);
 
 	eeh_send_failure_event (dn, dev);
 
@@ -586,7 +586,7 @@ int eeh_dn_check_failure(struct device_n
 	return 1;
 
 dn_unlock:
-	spin_unlock_irqrestore(&confirm_error_lock, flags);
+	raw_spin_unlock_irqrestore(&confirm_error_lock, flags);
 	return rc;
 }
 
@@ -1064,7 +1064,7 @@ void __init eeh_init(void)
 	struct device_node *phb, *np;
 	struct eeh_early_enable_info info;
 
-	spin_lock_init(&confirm_error_lock);
+	raw_spin_lock_init(&confirm_error_lock);
 	spin_lock_init(&slot_errbuf_lock);
 
 	np = of_find_node_by_path("/rtas");
