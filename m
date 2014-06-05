Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1CC291A005B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jun 2014 16:36:15 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 5 Jun 2014 16:36:14 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8AA0B3578054
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jun 2014 16:36:11 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s556ZtVi3604900
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jun 2014 16:35:55 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s556aAPJ030128
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jun 2014 16:36:11 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v8 1/3] powerpc/eeh: Avoid event on passed PE
Date: Thu,  5 Jun 2014 16:36:07 +1000
Message-Id: <1401950169-30206-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1401950169-30206-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1401950169-30206-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, agraf@suse.de, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 alex.williamson@redhat.com, qiudayu@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We must not handle EEH error on devices which are passed to somebody
else. Instead, we expect that the frozen device owner detects an EEH
error and recovers from it.

This avoids EEH error handling on passed through devices so the device
owner gets a chance to handle them.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h            | 7 +++++++
 arch/powerpc/kernel/eeh.c                 | 8 ++++++++
 arch/powerpc/platforms/powernv/eeh-ioda.c | 3 ++-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 7782056..653d981 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -25,6 +25,7 @@
 #include <linux/list.h>
 #include <linux/string.h>
 #include <linux/time.h>
+#include <linux/atomic.h>
 
 struct pci_dev;
 struct pci_bus;
@@ -84,6 +85,7 @@ struct eeh_pe {
 	int freeze_count;		/* Times of froze up		*/
 	struct timeval tstamp;		/* Time on first-time freeze	*/
 	int false_positives;		/* Times of reported #ff's	*/
+	atomic_t pass_dev_cnt;		/* Count of passed through devs	*/
 	struct eeh_pe *parent;		/* Parent PE			*/
 	struct list_head child_list;	/* Link PE to the child list	*/
 	struct list_head edevs;		/* Link list of EEH devices	*/
@@ -93,6 +95,11 @@ struct eeh_pe {
 #define eeh_pe_for_each_dev(pe, edev, tmp) \
 		list_for_each_entry_safe(edev, tmp, &pe->edevs, list)
 
+static inline bool eeh_pe_passed(struct eeh_pe *pe)
+{
+	return pe ? !!atomic_read(&pe->pass_dev_cnt) : false;
+}
+
 /*
  * The struct is used to trace EEH state for the associated
  * PCI device node or PCI device. In future, it might
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
