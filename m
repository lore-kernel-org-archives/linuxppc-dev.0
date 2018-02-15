Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zj2PS4FsPzF1JH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Feb 2018 03:52:11 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1FGokFL137914
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 11:52:09 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g5cr84d32-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 11:52:09 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Thu, 15 Feb 2018 16:52:07 -0000
From: Christophe Lombard <clombard@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 vaibhav@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com
Subject: [PATCH V2] cxl: Fix timebase synchronization status on P9
Date: Thu, 15 Feb 2018 17:52:04 +0100
Message-Id: <1518713524-1500-1-git-send-email-clombard@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PSL Timebase register is updated by the PSL to maintain the
timebase.
On P9, the Timebase value is only provided by the CAPP as received
the last time a timebase request was performed.
The timebase requests are initiated through the adapter configuration or
application registers.
The specific sysfs entry "/sys/class/cxl/cardxx/psl_timebase_synced" is
now dynamically updated according the content of the PSL Timebase
register.

Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>

---
Changelog[v2]
 - Missing Signed-off-by
 - Spaces required around the ':'
---
 drivers/misc/cxl/pci.c   | 35 +++++++++++++++++++----------------
 drivers/misc/cxl/sysfs.c | 14 ++++++++++++++
 2 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 758842f..270afb5 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -612,8 +612,6 @@ static u64 timebase_read_xsl(struct cxl *adapter)
 
 static void cxl_setup_psl_timebase(struct cxl *adapter, struct pci_dev *dev)
 {
-	u64 psl_tb;
-	int delta;
 	unsigned int retry = 0;
 	struct device_node *np;
 
@@ -641,20 +639,25 @@ static void cxl_setup_psl_timebase(struct cxl *adapter, struct pci_dev *dev)
 	cxl_p1_write(adapter, CXL_PSL_Control, 0x0000000000000000);
 	cxl_p1_write(adapter, CXL_PSL_Control, CXL_PSL_Control_tb);
 
-	/* Wait until CORE TB and PSL TB difference <= 16usecs */
-	do {
-		msleep(1);
-		if (retry++ > 5) {
-			dev_info(&dev->dev, "PSL timebase can't synchronize\n");
-			return;
-		}
-		psl_tb = adapter->native->sl_ops->timebase_read(adapter);
-		delta = mftb() - psl_tb;
-		if (delta < 0)
-			delta = -delta;
-	} while (tb_to_ns(delta) > 16000);
-
-	adapter->psl_timebase_synced = true;
+	if (cxl_is_power8()) {
+		u64 psl_tb;
+		int delta;
+
+		/* Wait until CORE TB and PSL TB difference <= 16usecs */
+		do {
+			msleep(1);
+			if (retry++ > 5) {
+				dev_info(&dev->dev, "PSL timebase can't synchronize\n");
+				return;
+			}
+			psl_tb = adapter->native->sl_ops->timebase_read(adapter);
+			delta = mftb() - psl_tb;
+			if (delta < 0)
+				delta = -delta;
+		} while (tb_to_ns(delta) > 16000);
+
+		adapter->psl_timebase_synced = true;
+	}
 	return;
 }
 
diff --git a/drivers/misc/cxl/sysfs.c b/drivers/misc/cxl/sysfs.c
index a8b6d6a..5384c59 100644
--- a/drivers/misc/cxl/sysfs.c
+++ b/drivers/misc/cxl/sysfs.c
@@ -63,6 +63,20 @@ static ssize_t psl_timebase_synced_show(struct device *device,
 {
 	struct cxl *adapter = to_cxl_adapter(device);
 
+	/*
+	 * On P9, the Timebase value is only updated as a result of
+	 * PSL TimeBase command sent to CAPP.
+	 */
+	if (cxl_is_power9()) {
+		u64 psl_tb;
+		int delta;
+
+		psl_tb = cxl_p1_read(adapter, CXL_PSL9_Timebase);
+		delta = mftb() - psl_tb;
+		if (delta < 0)
+			delta = -delta;
+		adapter->psl_timebase_synced = true ? tb_to_ns(delta) < 16000 : false;
+	}
 	return scnprintf(buf, PAGE_SIZE, "%i\n", adapter->psl_timebase_synced);
 }
 
-- 
2.7.4
