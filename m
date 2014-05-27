Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9A4301A0641
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 May 2014 18:41:12 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 27 May 2014 18:41:10 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 496A02BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 May 2014 18:41:09 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4R8JThl11599954
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 May 2014 18:19:33 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4R8erD0014781
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 May 2014 18:40:54 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v7 1/3] powerpc/eeh: Avoid event on passed PE
Date: Tue, 27 May 2014 18:40:50 +1000
Message-Id: <1401180052-6060-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1401180052-6060-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1401180052-6060-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, agraf@suse.de, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 alex.williamson@redhat.com, qiudayu@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If we detects frozen state on PE that has been passed through to somebody
else. we needn't handle it. Instead, we rely on the device's owner to
detect and recover it. The patch avoid EEH event on the frozen passed PE
so that the device's owner can have chance to handle that.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h            | 32 +++++++++++++++++++++++++++++++
 arch/powerpc/kernel/eeh.c                 |  8 ++++++++
 arch/powerpc/platforms/powernv/eeh-ioda.c |  3 ++-
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 7782056..34a2d83 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -72,6 +72,7 @@ struct device_node;
 #define EEH_PE_RESET		(1 << 2)	/* PE reset in progress	*/
 
 #define EEH_PE_KEEP		(1 << 8)	/* Keep PE on hotplug	*/
+#define EEH_PE_PASSTHROUGH	(1 << 9)	/* PE owned by guest	*/
 
 struct eeh_pe {
 	int type;			/* PE type: PHB/Bus/Device	*/
@@ -93,6 +94,21 @@ struct eeh_pe {
 #define eeh_pe_for_each_dev(pe, edev, tmp) \
 		list_for_each_entry_safe(edev, tmp, &pe->edevs, list)
 
+static inline bool eeh_pe_passed(struct eeh_pe *pe)
+{
+	return pe ? !!(pe->state & EEH_PE_PASSTHROUGH) : false;
+}
+
+static inline void eeh_pe_set_passed(struct eeh_pe *pe, bool passed)
+{
+	if (pe) {
+		if (passed)
+			pe->state |= EEH_PE_PASSTHROUGH;
+		else
+			pe->state &= ~EEH_PE_PASSTHROUGH;
+	}
+}
+
 /*
  * The struct is used to trace EEH state for the associated
  * PCI device node or PCI device. In future, it might
@@ -110,6 +126,7 @@ struct eeh_pe {
 #define EEH_DEV_SYSFS		(1 << 9)	/* Sysfs created	*/
 #define EEH_DEV_REMOVED		(1 << 10)	/* Removed permanently	*/
 #define EEH_DEV_FRESET		(1 << 11)	/* Fundamental reset	*/
+#define EEH_DEV_PASSTHROUGH	(1 << 12)	/* Owned by guest	*/
 
 struct eeh_dev {
 	int mode;			/* EEH mode			*/
@@ -138,6 +155,21 @@ static inline struct pci_dev *eeh_dev_to_pci_dev(struct eeh_dev *edev)
 	return edev ? edev->pdev : NULL;
 }
 
+static inline bool eeh_dev_passed(struct eeh_dev *dev)
+{
+	return dev ? !!(dev->mode & EEH_DEV_PASSTHROUGH) : false;
+}
+
+static inline void eeh_dev_set_passed(struct eeh_dev *dev, bool passed)
+{
+	if (dev) {
+		if (passed)
+			dev->mode |= EEH_DEV_PASSTHROUGH;
+		else
+			dev->mode &= ~EEH_DEV_PASSTHROUGH;
+	}
+}
+
 /* Return values from eeh_ops::next_error */
 enum {
 	EEH_NEXT_ERR_NONE = 0,
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 9c6b899..3bc8b12 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -400,6 +400,14 @@ int eeh_dev_check_failure(struct eeh_dev *edev)
 	if (ret > 0)
 		return ret;
 
+	/*
+	 * If the PE isn't owned by us, we shouldn't check the
+	 * state. Instead, let the owner handle it if the PE has
+	 * been frozen.
+	 */
+	if (eeh_pe_passed(pe))
+		return 0;
+
 	/* If we already have a pending isolation event for this
 	 * slot, we know it's bad already, we don't need to check.
 	 * Do this checking under a lock; as multiple PCI devices
diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index cab3e62..79193eb 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -892,7 +892,8 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 				opal_pci_eeh_freeze_clear(phb->opal_id, frozen_pe_no,
 					OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
 				ret = EEH_NEXT_ERR_NONE;
-			} else if ((*pe)->state & EEH_PE_ISOLATED) {
+			} else if ((*pe)->state & EEH_PE_ISOLATED ||
+				   eeh_pe_passed(*pe)) {
 				ret = EEH_NEXT_ERR_NONE;
 			} else {
 				pr_err("EEH: Frozen PHB#%x-PE#%x (%s) detected\n",
-- 
1.8.3.2
