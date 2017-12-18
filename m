Return-Path: <bryantly@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z0wtR4CD4zDrWt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 09:38:39 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBIMcYi3121973
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 17:38:37 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2exnms26xy-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 17:38:37 -0500
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bryantly@linux.vnet.ibm.com>;
 Mon, 18 Dec 2017 17:38:35 -0500
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: seroyer@linux.vnet.ibm.com, jjalvare@linux.vnet.ibm.com,
 alex.williamson@redhat.com, helgaas@kernel.org, aik@ozlabs.ru,
 ruscur@russell.cc, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bodong@mellanox.com, eli@mellanox.com,
 saeedm@mellanox.com, "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Subject: [PATCH v2 4/7] powerpc/kernel Add EEH operations to notify resume
Date: Mon, 18 Dec 2017 16:38:05 -0600
In-Reply-To: <20171218223808.83928-1-bryantly@linux.vnet.ibm.com>
References: <20171218223808.83928-1-bryantly@linux.vnet.ibm.com>
Message-Id: <20171218223808.83928-5-bryantly@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When pseries SR-IOV is enabled and after a PF driver
has resumed from EEH, platform has to be notified
of the event so the child VFs can be allowed to
resume their normal recovery path.

This patch makes the EEH operation allow unfreeze
platform dependent code and adds the call to
pseries EEH code.

Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
Signed-off-by: Juan J. Alvarez <jjalvare@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |  1 +
 arch/powerpc/kernel/eeh_driver.c             |  3 +
 arch/powerpc/platforms/powernv/eeh-powernv.c |  3 +-
 arch/powerpc/platforms/pseries/eeh_pseries.c | 90 +++++++++++++++++++++++++++-
 4 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 82829c65f31a..fd37cc101f4f 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -214,6 +214,7 @@ struct eeh_ops {
 	int (*write_config)(struct pci_dn *pdn, int where, int size, u32 val);
 	int (*next_error)(struct eeh_pe **pe);
 	int (*restore_config)(struct pci_dn *pdn);
+	int (*notify_resume)(struct pci_dn *pdn);
 };
 
 extern int eeh_subsystem_flags;
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 9d4e8177c2e0..ed710076b042 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -385,6 +385,9 @@ static void *eeh_report_resume(void *data, void *userdata)
 
 	eeh_pcid_put(dev);
 	kobject_uevent_env(&dev->dev.kobj, KOBJ_CHANGE, envp);
+#ifdef CONFIG_PCI_IOV
+	eeh_ops->notify_resume(eeh_dev_to_pdn(edev));
+#endif
 	return NULL;
 }
 
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 0665b6d03cb3..33c86c1a1720 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -1704,7 +1704,8 @@ static struct eeh_ops pnv_eeh_ops = {
 	.read_config            = pnv_eeh_read_config,
 	.write_config           = pnv_eeh_write_config,
 	.next_error		= pnv_eeh_next_error,
-	.restore_config		= pnv_eeh_restore_config
+	.restore_config		= pnv_eeh_restore_config,
+	.notify_resume		= NULL
 };
 
 #ifdef CONFIG_PCI_IOV
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index c4bc5dd0c6ec..1bae44f30b73 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -743,6 +743,93 @@ static int pseries_eeh_restore_config(struct pci_dn *pdn)
 	return ret;
 }
 
+#ifdef CONFIG_PCI_IOV
+int pseries_send_allow_unfreeze(struct pci_dn *pdn,
+				u16 *vf_pe_array, int cur_vfs)
+{
+	int rc;
+	int ibm_allow_unfreeze = rtas_token("ibm,open-sriov-allow-unfreeze");
+	unsigned long buid, addr;
+
+	addr = rtas_config_addr(pdn->busno, pdn->devfn, 0);
+	buid = pdn->phb->buid;
+	spin_lock(&rtas_data_buf_lock);
+	memcpy(rtas_data_buf, vf_pe_array, RTAS_DATA_BUF_SIZE);
+	rc = rtas_call(ibm_allow_unfreeze, 5, 1, NULL,
+		       addr,
+		       BUID_HI(buid),
+		       BUID_LO(buid),
+		       rtas_data_buf, cur_vfs * sizeof(u16));
+	spin_unlock(&rtas_data_buf_lock);
+	if (rc)
+		pr_warn("%s: Failed to allow unfreeze for PHB#%x-PE#%lx, rc=%x\n",
+			__func__,
+			pdn->phb->global_number, addr, rc);
+	return rc;
+}
+
+static int pseries_call_allow_unfreeze(struct eeh_dev *edev)
+{
+	struct pci_dn *pdn, *tmp, *parent, *physfn_pdn;
+	int cur_vfs = 0, rc = 0, vf_index, bus, devfn;
+	u16 *vf_pe_array;
+
+	vf_pe_array = kzalloc(RTAS_DATA_BUF_SIZE, GFP_KERNEL);
+	if (!vf_pe_array)
+		return -ENOMEM;
+
+	if (edev->pdev->is_physfn) {
+		cur_vfs = pci_num_vf(edev->pdev);
+		pdn = eeh_dev_to_pdn(edev);
+		parent = pdn->parent;
+
+		for (vf_index = 0; vf_index < cur_vfs; vf_index++)
+			vf_pe_array[vf_index] =
+				cpu_to_be16(pdn->pe_num_map[vf_index]);
+		rc = pseries_send_allow_unfreeze(pdn, vf_pe_array, cur_vfs);
+		pdn->last_allow_rc = rc;
+		for (vf_index = 0; vf_index < cur_vfs; vf_index++) {
+			list_for_each_entry_safe(pdn, tmp, &parent->child_list,
+						 list) {
+				bus = pci_iov_virtfn_bus(edev->pdev, vf_index);
+				devfn = pci_iov_virtfn_devfn(edev->pdev,
+							     vf_index);
+				if (pdn->busno != bus ||
+				    pdn->devfn != devfn)
+					continue;
+				pdn->last_allow_rc = rc;
+			}
+		}
+	} else {
+		pdn = pci_get_pdn(edev->pdev);
+		vf_pe_array[0] = cpu_to_be16(pdn->pe_number);
+		physfn_pdn = pci_get_pdn(edev->physfn);
+		rc = pseries_send_allow_unfreeze(physfn_pdn, vf_pe_array, 1);
+		pdn->last_allow_rc = rc;
+	}
+
+	kfree(vf_pe_array);
+	return rc;
+}
+
+static int pseries_notify_resume(struct pci_dn *pdn)
+{
+	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
+
+	if (!edev)
+		return -EEXIST;
+
+	if (rtas_token("ibm,open-sriov-allow-unfreeze")
+	    == RTAS_UNKNOWN_SERVICE)
+		return -EINVAL;
+
+	if (edev->pdev->is_physfn || edev->pdev->is_virtfn)
+		return pseries_call_allow_unfreeze(edev);
+
+	return 0;
+}
+#endif
+
 static struct eeh_ops pseries_eeh_ops = {
 	.name			= "pseries",
 	.init			= pseries_eeh_init,
@@ -758,7 +845,8 @@ static struct eeh_ops pseries_eeh_ops = {
 	.read_config		= pseries_eeh_read_config,
 	.write_config		= pseries_eeh_write_config,
 	.next_error		= NULL,
-	.restore_config		= pseries_eeh_restore_config
+	.restore_config		= pseries_eeh_restore_config,
+	.notify_resume		= pseries_notify_resume
 };
 
 /**
-- 
2.14.3 (Apple Git-98)
