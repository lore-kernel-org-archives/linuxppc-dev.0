Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8MSN1K23zDr3C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 16:58:44 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s8MSM3z4pz9sf9
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2016 16:58:43 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7A6s7Fm006516
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2016 02:58:41 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24qm9u6xge-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2016 02:58:41 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 10 Aug 2016 16:58:38 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id BA9F72BB0059
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2016 16:58:36 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7A6waP032112822
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2016 16:58:36 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7A6wZFD005768
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2016 16:58:36 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: shlimeng@cn.ibm.com, mpe@ellerman.id.au,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH] PCI/hotplug: Take two seconds as settlement time after
 power-on
Date: Wed, 10 Aug 2016 16:58:33 +1000
Message-Id: <1470812313-19943-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PCI adapter's firmware isn't fully functional when the PCIe bus
link is up. 1.8 seconds are needed for the firmware to be completely
functional according to the PCI bus settlement time (after reset)
we have in EEH code (EEH_PE_RST_SETTLE_TIME). Without the delay, the
driver fails to initialize the hot added adapter as observed on the
Sumsung NVME card (144d:a821).

This takes two seconds, a bit more than 1.8 seconds, as the PCI bus
settlement time before PCI scanning in hot add sequence. With this
applied, no error reported from driver on the Sumsung NVME adapter.

Reported-by: Meng Li <shlimeng@cn.ibm.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/pci/hotplug/pnv_php.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index e6245b0..21f1f9d 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -11,6 +11,7 @@
 
 #include <linux/libfdt.h>
 #include <linux/module.h>
+#include <linux/delay.h>
 #include <linux/pci.h>
 #include <linux/pci_hotplug.h>
 
@@ -434,6 +435,12 @@ static int pnv_php_enable(struct pnv_php_slot *php_slot, bool rescan)
 	if (unlikely(ret))
 		return ret;
 
+	/* Take two seconds as settlement time. Otherwise, the firmware
+	 * of PCI adapter behind the PCI slot isn't functional completely
+	 * in time. It causes initializing failure reported from device
+	 * driver as observed on Sumsung NVME adapter (144d:a821).
+	 */
+	msleep(2000);
 scan:
 	if (presence == OPAL_PCI_SLOT_PRESENT) {
 		if (rescan) {
-- 
2.1.0
