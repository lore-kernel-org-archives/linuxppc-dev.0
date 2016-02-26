Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 87BA61A0B54
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 11:05:55 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 26 Feb 2016 10:05:54 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 7B5FD2BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 11:05:50 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1Q05gY166453664
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 11:05:50 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1Q05Igc024733
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 11:05:18 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 1/3] powerpc/eeh: Don't propagate error to guest
Date: Fri, 26 Feb 2016 11:04:50 +1100
Message-Id: <1456445092-18337-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1456445092-18337-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1456445092-18337-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When EEH error happened to the parent PE of those PEs that have
been passed through to guest, the error is propagated to guest
domain and the VFIO driver's error handlers are called. It's not
correct as the error in the host domain shouldn't be propagated
to guests and affect them.

This adds one more limitation when calling EEH error handlers.
If the PE has been passed through to guest, the error handlers
won't be called.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_driver.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index c0fe7a6..6c59de8 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -195,7 +195,7 @@ static void *eeh_report_error(void *data, void *userdata)
 	enum pci_ers_result rc, *res = userdata;
 	struct pci_driver *driver;
 
-	if (!dev || eeh_dev_removed(edev))
+	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
 		return NULL;
 	dev->error_state = pci_channel_io_frozen;
 
@@ -237,7 +237,7 @@ static void *eeh_report_mmio_enabled(void *data, void *userdata)
 	enum pci_ers_result rc, *res = userdata;
 	struct pci_driver *driver;
 
-	if (!dev || eeh_dev_removed(edev))
+	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
 		return NULL;
 
 	driver = eeh_pcid_get(dev);
@@ -277,7 +277,7 @@ static void *eeh_report_reset(void *data, void *userdata)
 	enum pci_ers_result rc, *res = userdata;
 	struct pci_driver *driver;
 
-	if (!dev || eeh_dev_removed(edev))
+	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
 		return NULL;
 	dev->error_state = pci_channel_io_normal;
 
@@ -336,7 +336,7 @@ static void *eeh_report_resume(void *data, void *userdata)
 	bool was_in_error;
 	struct pci_driver *driver;
 
-	if (!dev || eeh_dev_removed(edev))
+	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
 		return NULL;
 	dev->error_state = pci_channel_io_normal;
 
@@ -375,7 +375,7 @@ static void *eeh_report_failure(void *data, void *userdata)
 	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
 	struct pci_driver *driver;
 
-	if (!dev || eeh_dev_removed(edev))
+	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
 		return NULL;
 	dev->error_state = pci_channel_io_perm_failure;
 
-- 
2.1.0
