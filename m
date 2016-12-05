Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tXQRj21YGzDvh3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2016 00:22:56 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB5DJqmW106451
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Dec 2016 08:22:54 -0500
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2756v9g7ba-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Dec 2016 08:22:54 -0500
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 5 Dec 2016 23:22:51 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B9CCB3578053
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2016 00:22:48 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uB5DMmva58720406
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Dec 2016 00:22:48 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uB5DMmCd027413
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Dec 2016 00:22:48 +1100
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: ukrishn@linux.vnet.ibm.com, pradghos@in.ibm.com, imunsie@au1.ibm.com,
 fbarrat@linux.vnet.ibm.com
Subject: [PATCH] cxl: prevent read/write to AFU config space while AFU not
 configured
Date: Tue,  6 Dec 2016 00:22:42 +1100
Message-Id: <20161205132242.13517-1-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

During EEH recovery, we deconfigure all AFUs whilst leaving the
corresponding vPHB and virtual PCI device in place.

If something attempts to interact with the AFU's PCI config space (e.g.
running lspci) after the AFU has been deconfigured and before it's
reconfigured, cxl_pcie_{read,write}_config() will read invalid values from
the deconfigured struct cxl_afu and proceed to Oops when they try to
dereference pointers that have been set to NULL during deconfiguration.

Add a rwsem to struct cxl_afu so we can prevent interaction with config
space while the AFU is deconfigured.

Reported-by: Pradipta Ghosh <pradghos@in.ibm.com>
Suggested-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org # 4.4+
Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
---

Pradipta found this while doing testing for cxlflash. I've tested this 
patch and I'm satisfied that it solves the issue, but I've asked Pradipta 
to test it a bit further. 

---

 drivers/misc/cxl/cxl.h  |  2 ++
 drivers/misc/cxl/main.c |  3 ++-
 drivers/misc/cxl/pci.c  |  2 ++
 drivers/misc/cxl/vphb.c | 11 ++++++++++-
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index a144073..379c463 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -418,6 +418,8 @@ struct cxl_afu {
 	struct dentry *debugfs;
 	struct mutex contexts_lock;
 	spinlock_t afu_cntl_lock;
+	/* Used to block access to AFU config space while deconfigured */
+	struct rw_semaphore configured_rwsem;
 
 	/* AFU error buffer fields and bin attribute for sysfs */
 	u64 eb_len, eb_offset;
diff --git a/drivers/misc/cxl/main.c b/drivers/misc/cxl/main.c
index 62e0dfb..2a6bf1d 100644
--- a/drivers/misc/cxl/main.c
+++ b/drivers/misc/cxl/main.c
@@ -268,7 +268,8 @@ struct cxl_afu *cxl_alloc_afu(struct cxl *adapter, int slice)
 	idr_init(&afu->contexts_idr);
 	mutex_init(&afu->contexts_lock);
 	spin_lock_init(&afu->afu_cntl_lock);
-
+	init_rwsem(&afu->configured_rwsem);
+	down_write(&afu->configured_rwsem);
 	afu->prefault_mode = CXL_PREFAULT_NONE;
 	afu->irqs_max = afu->adapter->user_irqs;
 
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index c4d79b5d..c7b2121 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -1129,6 +1129,7 @@ static int pci_configure_afu(struct cxl_afu *afu, struct cxl *adapter, struct pc
 	if ((rc = cxl_native_register_psl_irq(afu)))
 		goto err2;
 
+	up_write(&afu->configured_rwsem);
 	return 0;
 
 err2:
@@ -1141,6 +1142,7 @@ static int pci_configure_afu(struct cxl_afu *afu, struct cxl *adapter, struct pc
 
 static void pci_deconfigure_afu(struct cxl_afu *afu)
 {
+	down_write(&afu->configured_rwsem);
 	cxl_native_release_psl_irq(afu);
 	if (afu->adapter->native->sl_ops->release_serr_irq)
 		afu->adapter->native->sl_ops->release_serr_irq(afu);
diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
index 3519ace..d79aba5 100644
--- a/drivers/misc/cxl/vphb.c
+++ b/drivers/misc/cxl/vphb.c
@@ -88,9 +88,16 @@ static int cxl_pcie_config_info(struct pci_bus *bus, unsigned int devfn,
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	afu = (struct cxl_afu *)phb->private_data;
+
+	/* Grab a reader lock on afu. We rely on the caller to release this! */
+	if (!down_read_trylock(&afu->configured_rwsem))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
 	record = cxl_pcie_cfg_record(bus->number, devfn);
-	if (record > afu->crs_num)
+	if (record > afu->crs_num) {
+		up_read(&afu->configured_rwsem);
 		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
 
 	*_afu = afu;
 	*_record = record;
@@ -127,6 +134,7 @@ static int cxl_pcie_read_config(struct pci_bus *bus, unsigned int devfn,
 		WARN_ON(1);
 	}
 
+	up_read(&afu->configured_rwsem); /* locked in cxl_pcie_config_info() */
 	if (rc)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
@@ -157,6 +165,7 @@ static int cxl_pcie_write_config(struct pci_bus *bus, unsigned int devfn,
 		WARN_ON(1);
 	}
 
+	up_read(&afu->configured_rwsem); /* locked in cxl_pcie_config_info() */
 	if (rc)
 		return PCIBIOS_SET_FAILED;
 
-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
