Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXV0B26GjzDqJk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 18:03:06 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1S6sCQs075919
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 02:03:04 -0500
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28w2hc4gss-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 02:03:04 -0500
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Tue, 28 Feb 2017 12:33:00 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id A7D5DE0045
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 12:34:41 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1S72stF15466728
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 12:32:54 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1S72t1S020800
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 12:32:57 +0530
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Russell Currey <ruscur@russell.cc>,
 frederic.barrat@fr.ibm.com
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Andrew Donnellan <andonnel@au1.ibm.com>, Ian Munsie <ianmunsi@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Gregory Kurz <KURZGREG@fr.ibm.com>, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [RFC 1/3] powerpc/eeh: Refactor eeh_pe_update_time_stamp to update
 freeze_count
Date: Tue, 28 Feb 2017 12:32:20 +0530
In-Reply-To: <20170228070222.21126-1-vaibhav@linux.vnet.ibm.com>
References: <20170228070222.21126-1-vaibhav@linux.vnet.ibm.com>
Message-Id: <20170228070222.21126-2-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch introduces a new function named
eeh_pe_update_freeze_counter replacing existing function
eeh_pe_update_time_stamp. The new function also manages the value of
freeze_count along with tstamp to track the number of times the PE
froze in last one hour and if the freeze_count > eeh_max_freezes then
reports an error(-ENOTRECOVERABLE) to indicate that the PE should be
permanently disabled.

This patch should not introduce any behavioral change.

Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h   |  2 +-
 arch/powerpc/kernel/eeh_driver.c | 20 +++-------------
 arch/powerpc/kernel/eeh_pe.c     | 50 ++++++++++++++++++++++++++--------------
 3 files changed, 37 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 8e37b71..68806be 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -265,7 +265,7 @@ struct eeh_pe *eeh_phb_pe_get(struct pci_controller *phb);
 struct eeh_pe *eeh_pe_get(struct eeh_dev *edev);
 int eeh_add_to_parent_pe(struct eeh_dev *edev);
 int eeh_rmv_from_parent_pe(struct eeh_dev *edev);
-void eeh_pe_update_time_stamp(struct eeh_pe *pe);
+int eeh_pe_update_freeze_counter(struct eeh_pe *pe);
 void *eeh_pe_traverse(struct eeh_pe *root,
 		eeh_traverse_func fn, void *flag);
 void *eeh_pe_dev_traverse(struct eeh_pe *root,
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index b948871..326b4e4 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -739,10 +739,9 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
 		return;
 	}
 
-	eeh_pe_update_time_stamp(pe);
-	pe->freeze_count++;
-	if (pe->freeze_count > eeh_max_freezes)
-		goto excess_failures;
+	/* Update freeze counters and see if we have tripped max-freeze limit */
+	if (eeh_pe_update_freeze_counter(pe) < 0)
+		goto perm_error;
 	pr_warn("EEH: This PCI device has failed %d times in the last hour\n",
 		pe->freeze_count);
 
@@ -872,19 +871,6 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
 
 	return;
 
-excess_failures:
-	/*
-	 * About 90% of all real-life EEH failures in the field
-	 * are due to poorly seated PCI cards. Only 10% or so are
-	 * due to actual, failed cards.
-	 */
-	pr_err("EEH: PHB#%x-PE#%x has failed %d times in the\n"
-	       "last hour and has been permanently disabled.\n"
-	       "Please try reseating or replacing it.\n",
-		pe->phb->global_number, pe->addr,
-		pe->freeze_count);
-	goto perm_error;
-
 hard_fail:
 	pr_err("EEH: Unable to recover from failure from PHB#%x-PE#%x.\n"
 	       "Please try reseating or replacing it\n",
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index cc4b206..cf70a8b 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -504,30 +504,46 @@ int eeh_rmv_from_parent_pe(struct eeh_dev *edev)
 }
 
 /**
- * eeh_pe_update_time_stamp - Update PE's frozen time stamp
+ * eeh_pe_update_freeze_counter - Update PE's frozen time stamp
+ * and freeze counter
  * @pe: EEH PE
  *
- * We have time stamp for each PE to trace its time of getting
- * frozen in last hour. The function should be called to update
- * the time stamp on first error of the specific PE. On the other
- * handle, we needn't account for errors happened in last hour.
+ * We have a freeze-counter and time stamp for each PE to trace
+ * number of times the PE was frozen in last one hour. This function
+ * updates the PE's freeze counter and if its > eeh_max_freezes then
+ * returns an error. The function should be called to once every-time
+ * a specific PE freezes.
  */
-void eeh_pe_update_time_stamp(struct eeh_pe *pe)
+int eeh_pe_update_freeze_counter(struct eeh_pe *pe)
 {
 	struct timeval tstamp;
 
-	if (!pe) return;
+	if (!pe)
+		return -EINVAL;
 
-	if (pe->freeze_count <= 0) {
-		pe->freeze_count = 0;
-		do_gettimeofday(&pe->tstamp);
-	} else {
-		do_gettimeofday(&tstamp);
-		if (tstamp.tv_sec - pe->tstamp.tv_sec > 3600) {
-			pe->tstamp = tstamp;
-			pe->freeze_count = 0;
-		}
-	}
+	do_gettimeofday(&tstamp);
+	if (pe->freeze_count <= 0 || tstamp.tv_sec - pe->tstamp.tv_sec > 3600) {
+		pe->tstamp = tstamp;
+		pe->freeze_count = 1;
+
+	} else if (pe->freeze_count >= eeh_max_freezes) {
+		pe->freeze_count++;
+		/*
+		 * About 90% of all real-life EEH failures in the field
+		 * are due to poorly seated PCI cards. Only 10% or so are
+		 * due to actual, failed cards.
+		 */
+		pr_err("EEH: PHB#%x-PE#%x has failed %d times in the\n"
+		       "last hour and has been permanently disabled.\n"
+		       "Please try reseating or replacing it.\n",
+		       pe->phb->global_number, pe->addr,
+		       pe->freeze_count);
+		return -ENOTRECOVERABLE;
+
+	} else
+		pe->freeze_count++;
+
+	return 0;
 }
 
 /**
-- 
2.9.3
