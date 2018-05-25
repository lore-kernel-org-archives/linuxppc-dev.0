Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40sWWC1zWDzF1Rv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 13:11:50 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4P34JHx077078
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 23:11:48 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j65fjsn5h-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 23:11:48 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Fri, 25 May 2018 04:11:47 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w4P3BheS12255630
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 03:11:43 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B9E7A4059
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 04:03:02 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE054A4040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 04:03:01 +0100 (BST)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 04:03:01 +0100 (BST)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 6FD5AA03AB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 13:11:40 +1000 (AEST)
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 09/13] powerpc/eeh: Introduce eeh_edev_actionable()
Date: Fri, 25 May 2018 13:11:36 +1000
In-Reply-To: <cover.1527217866.git.sbobroff@linux.ibm.com>
References: <cover.1527217866.git.sbobroff@linux.ibm.com>
In-Reply-To: <cover.1527217866.git.sbobroff@linux.ibm.com>
References: <cover.1527217866.git.sbobroff@linux.ibm.com>
Message-Id: <959c90e75fa65290235718a21ae1128b1586e859.1527217866.git.sbobroff@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The same test is done in every EEH report function, so factor it out.

Since eeh_dev_removed() needs to be moved higher up in the file,
simplify it a little while we're at it.

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
---
 arch/powerpc/kernel/eeh_driver.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 2d3cac584899..30898866418b 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -62,6 +62,17 @@ static enum pci_ers_result pci_ers_merge_result(enum pci_ers_result old,
 	return old;
 }
 
+static bool eeh_dev_removed(struct eeh_dev *edev)
+{
+	return !edev || (edev->mode & EEH_DEV_REMOVED);
+}
+
+static bool eeh_edev_actionable(struct eeh_dev *edev)
+{
+	return (edev->pdev && !eeh_dev_removed(edev) &&
+		!eeh_pe_passed(edev->pe));
+}
+
 /**
  * eeh_pcid_get - Get the PCI device driver
  * @pdev: PCI device
@@ -163,15 +174,6 @@ static void eeh_enable_irq(struct pci_dev *dev)
 	}
 }
 
-static bool eeh_dev_removed(struct eeh_dev *edev)
-{
-	/* EEH device removed ? */
-	if (!edev || (edev->mode & EEH_DEV_REMOVED))
-		return true;
-
-	return false;
-}
-
 static void *eeh_dev_save_state(struct eeh_dev *edev, void *userdata)
 {
 	struct pci_dev *pdev;
@@ -212,7 +214,7 @@ static void *eeh_report_error(struct eeh_dev *edev, void *userdata)
 	enum pci_ers_result rc, *res = userdata;
 	struct pci_driver *driver;
 
-	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
+	if (!eeh_edev_actionable(edev))
 		return NULL;
 
 	device_lock(&dev->dev);
@@ -256,7 +258,7 @@ static void *eeh_report_mmio_enabled(struct eeh_dev *edev, void *userdata)
 	enum pci_ers_result rc, *res = userdata;
 	struct pci_driver *driver;
 
-	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
+	if (!eeh_edev_actionable(edev))
 		return NULL;
 
 	device_lock(&dev->dev);
@@ -295,7 +297,7 @@ static void *eeh_report_reset(struct eeh_dev *edev, void *userdata)
 	enum pci_ers_result rc, *res = userdata;
 	struct pci_driver *driver;
 
-	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
+	if (!eeh_edev_actionable(edev))
 		return NULL;
 
 	device_lock(&dev->dev);
@@ -365,7 +367,7 @@ static void *eeh_report_resume(struct eeh_dev *edev, void *userdata)
 	bool was_in_error;
 	struct pci_driver *driver;
 
-	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
+	if (!eeh_edev_actionable(edev))
 		return NULL;
 
 	device_lock(&dev->dev);
@@ -412,7 +414,7 @@ static void *eeh_report_failure(struct eeh_dev *edev, void *userdata)
 	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
 	struct pci_driver *driver;
 
-	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
+	if (!eeh_edev_actionable(edev))
 		return NULL;
 
 	device_lock(&dev->dev);
-- 
2.16.1.74.g9b0b1f47b
