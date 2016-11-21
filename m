Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tN1T750CVzDvnR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 08:10:03 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uALL8Pcx090229
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 16:10:01 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26v5j4rr7q-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 16:10:01 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Mon, 21 Nov 2016 14:10:00 -0700
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Ian Munsie <imunsie@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Subject: [PATCH 1/2] PCI: Add pci_set_vpd_timeout() to set VPD access timeout
Date: Mon, 21 Nov 2016 15:09:49 -0600
In-Reply-To: <1479762225-51440-1-git-send-email-mrochs@linux.vnet.ibm.com>
References: <1479762225-51440-1-git-send-email-mrochs@linux.vnet.ibm.com>
Message-Id: <1479762589-51557-1-git-send-email-mrochs@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PCI core uses a fixed 50ms timeout when waiting for VPD accesses to
complete. When an access does not complete within this period, a warning
is logged and an error returned to the caller.

While this default timeout is valid for most hardware, some devices can
experience longer access delays under certain circumstances. For example,
one of the IBM CXL Flash devices can take up to ~120ms in a worst-case
scenario. These types of devices can benefit from an extended timeout that
is specific to their hardware constraints.

To support per-device VPD access timeouts, pci_set_vpd_timeout() is added
as an exported service. PCI devices will continue to default with the 50ms
timeout and use a per-device timeout when a driver calls this new service.

Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
---
 drivers/pci/access.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/pci/pci.h    |  2 ++
 include/linux/pci.h  |  1 +
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index d11cdbb..2734a3a 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -288,6 +288,21 @@ int pci_set_vpd_size(struct pci_dev *dev, size_t len)
 }
 EXPORT_SYMBOL(pci_set_vpd_size);
 
+/**
+ * pci_set_vpd_timeout - Set wait timeout for Vital Product Data accesses
+ * @dev:	pci device struct
+ * @timeout:	jiffies to wait for completion
+ */
+int pci_set_vpd_timeout(struct pci_dev *dev, unsigned long timeout)
+{
+	if (!dev->vpd || !dev->vpd->ops)
+		return -ENODEV;
+	return dev->vpd->ops->set_timeout(dev, timeout);
+}
+EXPORT_SYMBOL(pci_set_vpd_timeout);
+
+#define PCI_VPD_DEF_TIMEOUT msecs_to_jiffies(50)
+#define PCI_VPD_MAX_TIMEOUT msecs_to_jiffies(250)
 #define PCI_VPD_MAX_SIZE (PCI_VPD_ADDR_MASK + 1)
 
 /**
@@ -355,7 +370,7 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
 static int pci_vpd_wait(struct pci_dev *dev)
 {
 	struct pci_vpd *vpd = dev->vpd;
-	unsigned long timeout = jiffies + msecs_to_jiffies(50);
+	unsigned long timeout = jiffies + vpd->timeout;
 	unsigned long max_sleep = 16;
 	u16 status;
 	int ret;
@@ -524,10 +539,22 @@ static int pci_vpd_set_size(struct pci_dev *dev, size_t len)
 	return 0;
 }
 
+static int pci_vpd_set_timeout(struct pci_dev *dev, unsigned long timeout)
+{
+	struct pci_vpd *vpd = dev->vpd;
+
+	if (timeout < PCI_VPD_DEF_TIMEOUT || timeout > PCI_VPD_MAX_TIMEOUT)
+		return -EINVAL;
+
+	vpd->timeout = timeout;
+	return 0;
+}
+
 static const struct pci_vpd_ops pci_vpd_ops = {
 	.read = pci_vpd_read,
 	.write = pci_vpd_write,
 	.set_size = pci_vpd_set_size,
+	.set_timeout = pci_vpd_set_timeout,
 };
 
 static ssize_t pci_vpd_f0_read(struct pci_dev *dev, loff_t pos, size_t count,
@@ -574,10 +601,25 @@ static int pci_vpd_f0_set_size(struct pci_dev *dev, size_t len)
 	return ret;
 }
 
+static int pci_vpd_f0_set_timeout(struct pci_dev *dev, unsigned long timeout)
+{
+	struct pci_dev *tdev = pci_get_slot(dev->bus,
+					    PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
+	int ret;
+
+	if (!tdev)
+		return -ENODEV;
+
+	ret = pci_set_vpd_timeout(tdev, timeout);
+	pci_dev_put(tdev);
+	return ret;
+}
+
 static const struct pci_vpd_ops pci_vpd_f0_ops = {
 	.read = pci_vpd_f0_read,
 	.write = pci_vpd_f0_write,
 	.set_size = pci_vpd_f0_set_size,
+	.set_timeout = pci_vpd_f0_set_timeout,
 };
 
 int pci_vpd_init(struct pci_dev *dev)
@@ -594,6 +636,7 @@ int pci_vpd_init(struct pci_dev *dev)
 		return -ENOMEM;
 
 	vpd->len = PCI_VPD_MAX_SIZE;
+	vpd->timeout = PCI_VPD_DEF_TIMEOUT;
 	if (dev->dev_flags & PCI_DEV_FLAGS_VPD_REF_F0)
 		vpd->ops = &pci_vpd_f0_ops;
 	else
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4518562..99f089a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -112,12 +112,14 @@ struct pci_vpd_ops {
 	ssize_t (*read)(struct pci_dev *dev, loff_t pos, size_t count, void *buf);
 	ssize_t (*write)(struct pci_dev *dev, loff_t pos, size_t count, const void *buf);
 	int (*set_size)(struct pci_dev *dev, size_t len);
+	int (*set_timeout)(struct pci_dev *dev, unsigned long timeout);
 };
 
 struct pci_vpd {
 	const struct pci_vpd_ops *ops;
 	struct bin_attribute *attr; /* descriptor for sysfs VPD entry */
 	struct mutex	lock;
+	unsigned long	timeout; /* wait timeout in jiffies */
 	unsigned int	len;
 	u16		flag;
 	u8		cap;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0e49f70..3038246 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1123,6 +1123,7 @@ void pci_unlock_rescan_remove(void);
 ssize_t pci_read_vpd(struct pci_dev *dev, loff_t pos, size_t count, void *buf);
 ssize_t pci_write_vpd(struct pci_dev *dev, loff_t pos, size_t count, const void *buf);
 int pci_set_vpd_size(struct pci_dev *dev, size_t len);
+int pci_set_vpd_timeout(struct pci_dev *dev, unsigned long timeout);
 
 /* Helper functions for low-level code (drivers/pci/setup-[bus,res].c) */
 resource_size_t pcibios_retrieve_fw_addr(struct pci_dev *dev, int idx);
-- 
2.1.0
