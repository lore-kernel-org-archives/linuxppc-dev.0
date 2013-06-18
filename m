Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4564E2C0315
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 18:35:18 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 18 Jun 2013 04:35:16 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id F25D16E8028
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 04:34:38 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5I8YCQG320180
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 04:34:13 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5I8YCT1021294
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 05:34:12 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 11/31] powerpc/eeh: Trace time on first error for PE
Date: Tue, 18 Jun 2013 16:33:35 +0800
Message-Id: <1371544435-4943-12-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1371544435-4943-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1371544435-4943-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We're not expecting that one specific PE got frozen for over 5
times in last hour. Otherwise, the PE will be removed from the
system upon newly coming EEH errors. The patch introduces time
stamp to trace the first error on specific PE in last hour and
function to update that accordingly. Besides, the time stamp
is recovered during PE hotplug path as we did for frozen count.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h   |    3 +++
 arch/powerpc/kernel/eeh_driver.c |    5 +++++
 arch/powerpc/kernel/eeh_pe.c     |   27 +++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index beec788..e1109fd 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -24,6 +24,7 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/string.h>
+#include <linux/time.h>
 
 struct pci_dev;
 struct pci_bus;
@@ -62,6 +63,7 @@ struct eeh_pe {
 	struct pci_bus *bus;		/* Top PCI bus for bus PE	*/
 	int check_count;		/* Times of ignored error	*/
 	int freeze_count;		/* Times of froze up		*/
+	struct timeval tstamp;		/* Time on first-time freeze	*/
 	int false_positives;		/* Times of reported #ff's	*/
 	struct eeh_pe *parent;		/* Parent PE			*/
 	struct list_head child_list;	/* Link PE to the child list	*/
@@ -190,6 +192,7 @@ struct eeh_pe *eeh_phb_pe_get(struct pci_controller *phb);
 struct eeh_pe *eeh_pe_get(struct eeh_dev *edev);
 int eeh_add_to_parent_pe(struct eeh_dev *edev);
 int eeh_rmv_from_parent_pe(struct eeh_dev *edev, int purge_pe);
+void eeh_pe_update_time_stamp(struct eeh_pe *pe);
 void *eeh_pe_dev_traverse(struct eeh_pe *root,
 		eeh_traverse_func fn, void *flag);
 void eeh_pe_restore_bars(struct eeh_pe *pe);
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 0acc5a2..69102b1 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -349,10 +349,12 @@ static void *eeh_report_failure(void *data, void *userdata)
  */
 static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
 {
+	struct timeval tstamp;
 	int cnt, rc;
 
 	/* pcibios will clear the counter; save the value */
 	cnt = pe->freeze_count;
+	tstamp = pe->tstamp;
 
 	/*
 	 * We don't remove the corresponding PE instances because
@@ -385,6 +387,8 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
 		ssleep(5);
 		pcibios_add_pci_devices(bus);
 	}
+
+	pe->tstamp = tstamp;
 	pe->freeze_count = cnt;
 
 	return 0;
@@ -425,6 +429,7 @@ void eeh_handle_event(struct eeh_pe *pe)
 		return;
 	}
 
+	eeh_pe_update_time_stamp(pe);
 	pe->freeze_count++;
 	if (pe->freeze_count > EEH_MAX_ALLOWED_FREEZES)
 		goto excess_failures;
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 5bd1637..2246ef5 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -487,6 +487,33 @@ int eeh_rmv_from_parent_pe(struct eeh_dev *edev, int purge_pe)
 }
 
 /**
+ * eeh_pe_update_time_stamp - Update PE's frozen time stamp
+ * @pe: EEH PE
+ *
+ * We have time stamp for each PE to trace its time of getting
+ * frozen in last hour. The function should be called to update
+ * the time stamp on first error of the specific PE. On the other
+ * handle, we needn't account for errors happened in last hour.
+ */
+void eeh_pe_update_time_stamp(struct eeh_pe *pe)
+{
+	struct timeval tstamp;
+
+	if (!pe) return;
+
+	if (pe->freeze_count <= 0) {
+		pe->freeze_count = 0;
+		do_gettimeofday(&pe->tstamp);
+	} else {
+		do_gettimeofday(&tstamp);
+		if (tstamp.tv_sec - pe->tstamp.tv_sec > 3600) {
+			pe->tstamp = tstamp;
+			pe->freeze_count = 0;
+		}
+	}
+}
+
+/**
  * __eeh_pe_state_mark - Mark the state for the PE
  * @data: EEH PE
  * @flag: state
-- 
1.7.5.4
