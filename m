Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tK8Jv2mrqzDvrN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 16:07:59 +1100 (AEDT)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Cc: gwshan@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com,
 Russell Currey <ruscur@russell.cc>
Subject: [PATCH] powerpc/eeh: Refactor EEH PE reset functions
Date: Thu, 17 Nov 2016 16:07:47 +1100
Message-Id: <20161117050747.18250-1-ruscur@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

eeh_pe_reset and eeh_reset_pe are two different functions in the same
file which do mostly the same thing.  Not only is this confusing, but
potentially causes disrepancies in functionality, notably eeh_reset_pe
as it does not check return values for failure.

Refactor this into the following:

 - eeh_pe_reset(): stays as is, performs a single operation, exported
 - eeh_pe_reset_full(): new, full reset process that calls eeh_pe_reset()
 - eeh_reset_pe(): removed and replaced by eeh_pe_reset_full()
 - eeh_reset_pe_once(): removed


Signed-off-by: Russell Currey <ruscur@russell.cc>
---
I'm not sure if this should go to stable.  Apparently it fixes some bug by
checking returns, but I don't fully understand what the problem was or how
severe it is.  Andrew (on CC) should know more.

Also the diff for this looks awful, much easier to read when applied
---
 arch/powerpc/include/asm/ppc-pci.h |  2 +-
 arch/powerpc/kernel/eeh.c          | 82 +++++++++++++++++---------------------
 arch/powerpc/kernel/eeh_driver.c   |  4 +-
 3 files changed, 40 insertions(+), 48 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
index 0f73de0..7262880 100644
--- a/arch/powerpc/include/asm/ppc-pci.h
+++ b/arch/powerpc/include/asm/ppc-pci.h
@@ -53,7 +53,7 @@ void eeh_addr_cache_rmv_dev(struct pci_dev *dev);
 struct eeh_dev *eeh_addr_cache_get_dev(unsigned long addr);
 void eeh_slot_error_detail(struct eeh_pe *pe, int severity);
 int eeh_pci_enable(struct eeh_pe *pe, int function);
-int eeh_reset_pe(struct eeh_pe *);
+int eeh_pe_reset_full(struct eeh_pe *pe);
 void eeh_save_bars(struct eeh_dev *edev);
 int rtas_write_config(struct pci_dn *, int where, int size, u32 val);
 int rtas_read_config(struct pci_dn *, int where, int size, u32 *val);
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index f257316..ad743d3 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -808,76 +808,67 @@ static void *eeh_set_dev_freset(void *data, void *flag)
 }
 
 /**
- * eeh_reset_pe_once - Assert the pci #RST line for 1/4 second
+ * eeh_pe_reset_full - Complete a full reset process on the indicated PE
  * @pe: EEH PE
  *
- * Assert the PCI #RST line for 1/4 second.
+ * This function executes a full reset procedure on a PE, including setting
+ * the appropriate flags, performing a fundamental or hot reset, and then
+ * deactivating the reset status.  It is designed to be used within the EEH
+ * subsystem, as opposed to eeh_pe_reset which is exported to drivers and
+ * only performs a single operation at a time.
+ *
+ * This function will attempt to reset a PE three times before failing.
  */
-static void eeh_reset_pe_once(struct eeh_pe *pe)
+int eeh_pe_reset_full(struct eeh_pe *pe)
 {
+	int active_flags = (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE);
+	int reset_state = (EEH_PE_RESET | EEH_PE_CFG_BLOCKED);
+	int type = EEH_RESET_HOT;
 	unsigned int freset = 0;
+	int i, state, ret;
 
-	/* Determine type of EEH reset required for
-	 * Partitionable Endpoint, a hot-reset (1)
-	 * or a fundamental reset (3).
-	 * A fundamental reset required by any device under
-	 * Partitionable Endpoint trumps hot-reset.
+	/*
+	 * Determine the type of reset to perform - hot or fundamental.
+	 * Hot reset is the default operation, unless any device under the
+	 * PE requires a fundamental reset.
 	 */
 	eeh_pe_dev_traverse(pe, eeh_set_dev_freset, &freset);
 
 	if (freset)
-		eeh_ops->reset(pe, EEH_RESET_FUNDAMENTAL);
-	else
-		eeh_ops->reset(pe, EEH_RESET_HOT);
-
-	eeh_ops->reset(pe, EEH_RESET_DEACTIVATE);
-}
-
-/**
- * eeh_reset_pe - Reset the indicated PE
- * @pe: EEH PE
- *
- * This routine should be called to reset indicated device, including
- * PE. A PE might include multiple PCI devices and sometimes PCI bridges
- * might be involved as well.
- */
-int eeh_reset_pe(struct eeh_pe *pe)
-{
-	int flags = (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE);
-	int i, state, ret;
+		type = EEH_RESET_FUNDAMENTAL;
 
-	/* Mark as reset and block config space */
-	eeh_pe_state_mark(pe, EEH_PE_RESET | EEH_PE_CFG_BLOCKED);
+	/* Mark the PE as in reset state and block config space accesses */
+	eeh_pe_state_mark(pe, reset_state);
 
-	/* Take three shots at resetting the bus */
+	/* Make three attempts at resetting the bus */
 	for (i = 0; i < 3; i++) {
-		eeh_reset_pe_once(pe);
+		ret = eeh_pe_reset(pe, type);
+		if (ret)
+			break;
 
-		/*
-		 * EEH_PE_ISOLATED is expected to be removed after
-		 * BAR restore.
-		 */
+		ret = eeh_pe_reset(pe, EEH_RESET_DEACTIVATE);
+		if (ret)
+			break;
+
+		/* Wait until the PE is in a functioning state */
 		state = eeh_ops->wait_state(pe, PCI_BUS_RESET_WAIT_MSEC);
-		if ((state & flags) == flags) {
-			ret = 0;
-			goto out;
-		}
+		if ((state & active_flags) == active_flags)
+			break;
 
 		if (state < 0) {
-			pr_warn("%s: Unrecoverable slot failure on PHB#%d-PE#%x",
+			pr_warn("%s: Unrecoverable slot failure on PHB#%x-PE#%d",
 				__func__, pe->phb->global_number, pe->addr);
 			ret = -ENOTRECOVERABLE;
-			goto out;
+			break;
 		}
 
-		/* We might run out of credits */
+		/* Set error in case this is our last attempt */
 		ret = -EIO;
-		pr_warn("%s: Failure %d resetting PHB#%x-PE#%x\n (%d)\n",
+		pr_warn("%s: Failure %d resetting PHB#%x-PE#%d\n (%d)\n",
 			__func__, state, pe->phb->global_number, pe->addr, (i + 1));
 	}
 
-out:
-	eeh_pe_state_clear(pe, EEH_PE_RESET | EEH_PE_CFG_BLOCKED);
+	eeh_pe_state_clear(pe, reset_state);
 	return ret;
 }
 
@@ -1601,6 +1592,7 @@ static int eeh_pe_reenable_devices(struct eeh_pe *pe)
 	return eeh_unfreeze_pe(pe, true);
 }
 
+
 /**
  * eeh_pe_reset - Issue PE reset according to specified type
  * @pe: EEH PE
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index a62be72..bb653f6 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -588,7 +588,7 @@ int eeh_pe_reset_and_recover(struct eeh_pe *pe)
 	eeh_pe_dev_traverse(pe, eeh_dev_save_state, NULL);
 
 	/* Issue reset */
-	ret = eeh_reset_pe(pe);
+	ret = eeh_pe_reset_full(pe);
 	if (ret) {
 		eeh_pe_state_clear(pe, EEH_PE_RECOVERING);
 		return ret;
@@ -659,7 +659,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
 	 * config accesses. So we prefer to block them. However, controlled
 	 * PCI config accesses initiated from EEH itself are allowed.
 	 */
-	rc = eeh_reset_pe(pe);
+	rc = eeh_pe_reset_full(pe);
 	if (rc)
 		return rc;
 
-- 
2.10.2
