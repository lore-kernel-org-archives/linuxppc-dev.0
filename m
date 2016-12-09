Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tZhrv0CvJzDw7f
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Dec 2016 17:19:10 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB96DrNg079668
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Dec 2016 01:19:07 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 277gu4ff3u-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Dec 2016 01:19:07 -0500
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 9 Dec 2016 16:19:04 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id DF1C12BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Dec 2016 17:19:00 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uB96J0iV18743418
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Dec 2016 17:19:00 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uB96J0ag030075
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Dec 2016 17:19:00 +1100
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: ukrishn@linux.vnet.ibm.com, vaibhav@linux.vnet.ibm.com,
 imunsie@au1.ibm.com, fbarrat@linux.vnet.ibm.com
Subject: [PATCH v2] cxl: prevent read/write to AFU config space while AFU not
 configured
Date: Fri,  9 Dec 2016 17:18:50 +1100
Message-Id: <20161209061850.23281-1-andrew.donnellan@au1.ibm.com>
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
Cc: stable@vger.kernel.org # v4.9+
Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>

---

v1 -> v2:

* Refactored to avoid locking over function boundaries - we now both lock
and unlock in cxl_pcie_{read,write}_config(), rather than locking in
cxl_pcie_config_info() and unlocking from the caller. Thanks Vaibhav.

* Changed the stable tag to 4.9 rather than 4.4 - by the time this is
merged, 4.9 will have landed, and I'll need to manually backport this for
4.4.
---
 drivers/misc/cxl/cxl.h  |  2 ++
 drivers/misc/cxl/main.c |  3 ++-
 drivers/misc/cxl/pci.c  |  2 ++
 drivers/misc/cxl/vphb.c | 51 ++++++++++++++++++++++++++++---------------------
 4 files changed, 35 insertions(+), 23 deletions(-)

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
index 3519ace..639a343 100644
--- a/drivers/misc/cxl/vphb.c
+++ b/drivers/misc/cxl/vphb.c
@@ -76,23 +76,22 @@ static int cxl_pcie_cfg_record(u8 bus, u8 devfn)
 	return (bus << 8) + devfn;
 }
 
-static int cxl_pcie_config_info(struct pci_bus *bus, unsigned int devfn,
-				struct cxl_afu **_afu, int *_record)
+static inline struct cxl_afu *pci_bus_to_afu(struct pci_bus *bus)
 {
-	struct pci_controller *phb;
-	struct cxl_afu *afu;
-	int record;
+	struct pci_controller *phb = bus ? pci_bus_to_host(bus) : NULL;
 
-	phb = pci_bus_to_host(bus);
-	if (phb == NULL)
-		return PCIBIOS_DEVICE_NOT_FOUND;
+	return phb ? phb->private_data : NULL;
+}
+
+static inline int cxl_pcie_config_info(struct pci_bus *bus, unsigned int devfn,
+				       struct cxl_afu *afu, int *_record)
+{
+	int record;
 
-	afu = (struct cxl_afu *)phb->private_data;
 	record = cxl_pcie_cfg_record(bus->number, devfn);
 	if (record > afu->crs_num)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	*_afu = afu;
 	*_record = record;
 	return 0;
 }
@@ -106,9 +105,14 @@ static int cxl_pcie_read_config(struct pci_bus *bus, unsigned int devfn,
 	u16 val16;
 	u32 val32;
 
-	rc = cxl_pcie_config_info(bus, devfn, &afu, &record);
+	afu = pci_bus_to_afu(bus);
+	/* Grab a reader lock on afu. */
+	if (afu == NULL || !down_read_trylock(&afu->configured_rwsem))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	rc = cxl_pcie_config_info(bus, devfn, afu, &record);
 	if (rc)
-		return rc;
+		goto out;
 
 	switch (len) {
 	case 1:
@@ -127,10 +131,9 @@ static int cxl_pcie_read_config(struct pci_bus *bus, unsigned int devfn,
 		WARN_ON(1);
 	}
 
-	if (rc)
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	return PCIBIOS_SUCCESSFUL;
+out:
+	up_read(&afu->configured_rwsem);
+	return rc ? PCIBIOS_DEVICE_NOT_FOUND : PCIBIOS_SUCCESSFUL;
 }
 
 static int cxl_pcie_write_config(struct pci_bus *bus, unsigned int devfn,
@@ -139,9 +142,14 @@ static int cxl_pcie_write_config(struct pci_bus *bus, unsigned int devfn,
 	int rc, record;
 	struct cxl_afu *afu;
 
-	rc = cxl_pcie_config_info(bus, devfn, &afu, &record);
+	afu = pci_bus_to_afu(bus);
+	/* Grab a reader lock on afu. */
+	if (afu == NULL || !down_read_trylock(&afu->configured_rwsem))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	rc = cxl_pcie_config_info(bus, devfn, afu, &record);
 	if (rc)
-		return rc;
+		goto out;
 
 	switch (len) {
 	case 1:
@@ -157,10 +165,9 @@ static int cxl_pcie_write_config(struct pci_bus *bus, unsigned int devfn,
 		WARN_ON(1);
 	}
 
-	if (rc)
-		return PCIBIOS_SET_FAILED;
-
-	return PCIBIOS_SUCCESSFUL;
+out:
+	up_read(&afu->configured_rwsem);
+	return rc ? PCIBIOS_SET_FAILED : PCIBIOS_SUCCESSFUL;
 }
 
 static struct pci_ops cxl_pcie_pci_ops =
-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
