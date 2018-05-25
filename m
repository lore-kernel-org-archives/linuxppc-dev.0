Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40sWWB4DhqzF1S9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 13:11:50 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4P34NS6089720
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 23:11:47 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j64tuucn8-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 23:11:47 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Fri, 25 May 2018 04:11:46 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w4P3BiRG51445936
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 03:11:44 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 423EB52047
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 03:01:40 +0100 (BST)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 94F005203F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 03:01:39 +0100 (BST)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 6BD0AA039D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 13:11:40 +1000 (AEST)
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 07/13] powerpc/eeh: Clean up pci_ers_result handling
Date: Fri, 25 May 2018 13:11:34 +1000
In-Reply-To: <cover.1527217866.git.sbobroff@linux.ibm.com>
References: <cover.1527217866.git.sbobroff@linux.ibm.com>
In-Reply-To: <cover.1527217866.git.sbobroff@linux.ibm.com>
References: <cover.1527217866.git.sbobroff@linux.ibm.com>
Message-Id: <e638159f9e6dfc4931f5164220741dd99bb4c0c7.1527217866.git.sbobroff@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As EEH event handling progresses, a cumulative result of type
pci_ers_result is built up by (some of) the eeh_report_*() functions
using either:
	if (rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
	if (*res == PCI_ERS_RESULT_NONE) *res = rc;
or:
	if ((*res == PCI_ERS_RESULT_NONE) ||
	    (*res == PCI_ERS_RESULT_RECOVERED)) *res = rc;
	if (*res == PCI_ERS_RESULT_DISCONNECT &&
	    rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
(Where *res is the accumulator.)

However, the intent is not immediately clear and the result in some
situations is order dependent.

Address this by assigning a priority to each result value, and always
merging to the highest priority. This renders the intent clear, and
provides a stable value for all orderings.

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
---
====== v1 -> v2: ======
* Added the value, and missing newline, to some WARN()s.
* Improved name of merge_result() to pci_ers_merge_result().
* Adjusted the result priorities so that unknown doesn't overlap with _NONE.

 arch/powerpc/kernel/eeh_driver.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 188d15c4fe3a..2d3cac584899 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -39,6 +39,29 @@ struct eeh_rmv_data {
 	int removed;
 };
 
+static int eeh_result_priority(enum pci_ers_result result)
+{
+	switch (result) {
+	case PCI_ERS_RESULT_NONE: return 1;
+	case PCI_ERS_RESULT_NO_AER_DRIVER: return 2;
+	case PCI_ERS_RESULT_RECOVERED: return 3;
+	case PCI_ERS_RESULT_CAN_RECOVER: return 4;
+	case PCI_ERS_RESULT_DISCONNECT: return 5;
+	case PCI_ERS_RESULT_NEED_RESET: return 6;
+	default:
+		WARN_ONCE(1, "Unknown pci_ers_result value: %d\n", (int)result);
+		return 0;
+	}
+};
+
+static enum pci_ers_result pci_ers_merge_result(enum pci_ers_result old,
+						enum pci_ers_result new)
+{
+	if (eeh_result_priority(new) > eeh_result_priority(old))
+		return new;
+	return old;
+}
+
 /**
  * eeh_pcid_get - Get the PCI device driver
  * @pdev: PCI device
@@ -206,9 +229,7 @@ static void *eeh_report_error(struct eeh_dev *edev, void *userdata)
 
 	rc = driver->err_handler->error_detected(dev, pci_channel_io_frozen);
 
-	/* A driver that needs a reset trumps all others */
-	if (rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
-	if (*res == PCI_ERS_RESULT_NONE) *res = rc;
+	*res = pci_ers_merge_result(*res, rc);
 
 	edev->in_error = true;
 	pci_uevent_ers(dev, PCI_ERS_RESULT_NONE);
@@ -249,9 +270,7 @@ static void *eeh_report_mmio_enabled(struct eeh_dev *edev, void *userdata)
 
 	rc = driver->err_handler->mmio_enabled(dev);
 
-	/* A driver that needs a reset trumps all others */
-	if (rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
-	if (*res == PCI_ERS_RESULT_NONE) *res = rc;
+	*res = pci_ers_merge_result(*res, rc);
 
 out:
 	eeh_pcid_put(dev);
@@ -294,10 +313,7 @@ static void *eeh_report_reset(struct eeh_dev *edev, void *userdata)
 		goto out;
 
 	rc = driver->err_handler->slot_reset(dev);
-	if ((*res == PCI_ERS_RESULT_NONE) ||
-	    (*res == PCI_ERS_RESULT_RECOVERED)) *res = rc;
-	if (*res == PCI_ERS_RESULT_DISCONNECT &&
-	     rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
+	*res = pci_ers_merge_result(*res, rc);
 
 out:
 	eeh_pcid_put(dev);
-- 
2.16.1.74.g9b0b1f47b
