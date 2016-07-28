Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s0KYY2YK1zDrPj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 15:05:21 +1000 (AEST)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Cc: gwshan@linux.vnet.ibm.com,
	Russell Currey <ruscur@russell.cc>
Subject: [PATCH v3] powernv/pci: Add PHB register dump debugfs handle
Date: Thu, 28 Jul 2016 15:05:03 +1000
Message-Id: <20160728050503.17366-1-ruscur@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On EEH events the kernel will print a dump of relevant registers.
If EEH is unavailable (i.e. CONFIG_EEH is disabled, a new platform
doesn't have EEH support, etc) this information isn't readily available.

Add a new debugfs handler to trigger a PHB register dump, so that this
information can be made available on demand.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
V3 changes:
	- use s64 instead of int for ret
	- check val != 1ULL instead of 1
	- return -ENODEV instead of -EFAULT
	- check hose and phb in the same statement
	- whitespace changes for DEFINE_SIMPLE_ATTRIBUTE
	- rename handler to "dump_diag_regs"
		- more debugfs handlers seemed to use _ instead of -
V2 changes:
	- use a simple attribute instead of full fops thanks to mpe
	- miscellanous fixes thanks to Gavin
	- rename from "regdump" to "dump_regs"
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 39 ++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 891fc4a..2808fda 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3018,6 +3018,38 @@ static void pnv_ioda_setup_pe_seg(struct pnv_ioda_pe *pe)
 	}
 }
 
+#ifdef CONFIG_DEBUG_FS
+static int pnv_pci_diag_data_set(void *data, u64 val)
+{
+	struct pci_controller *hose;
+	struct pnv_phb *phb;
+	s64 ret;
+
+	if (val != 1ULL)
+		return -EINVAL;
+
+	hose = (struct pci_controller *)data;
+	if (!hose || !hose->private_data)
+		return -ENODEV;
+
+	phb = hose->private_data;
+
+	/* Retrieve the diag data from firmware */
+	ret = opal_pci_get_phb_diag_data2(phb->opal_id, phb->diag.blob,
+					  PNV_PCI_DIAG_BUF_SIZE);
+	if (ret != OPAL_SUCCESS)
+		return -EIO;
+
+	/* Print the diag data to the kernel log */
+	pnv_pci_dump_phb_diag_data(phb->hose, phb->diag.blob);
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(pnv_pci_diag_data_fops, NULL,
+			pnv_pci_diag_data_set, "%llu\n");
+
+#endif /* CONFIG_DEBUG_FS */
+
 static void pnv_pci_ioda_create_dbgfs(void)
 {
 #ifdef CONFIG_DEBUG_FS
@@ -3033,9 +3065,14 @@ static void pnv_pci_ioda_create_dbgfs(void)
 
 		sprintf(name, "PCI%04x", hose->global_number);
 		phb->dbgfs = debugfs_create_dir(name, powerpc_debugfs_root);
-		if (!phb->dbgfs)
+		if (!phb->dbgfs) {
 			pr_warning("%s: Error on creating debugfs on PHB#%x\n",
 				__func__, hose->global_number);
+			continue;
+		}
+
+		debugfs_create_file("dump_diag_regs", 0200, phb->dbgfs, hose,
+				    &pnv_pci_diag_data_fops);
 	}
 #endif /* CONFIG_DEBUG_FS */
 }
-- 
2.9.0
