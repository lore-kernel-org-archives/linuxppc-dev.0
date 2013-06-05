Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2FA0F2C02A4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2013 17:34:48 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 5 Jun 2013 03:34:46 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id A9C7538C8045
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2013 03:34:44 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r557Yj9g337176
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jun 2013 03:34:45 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r557YioZ000320
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jun 2013 03:34:45 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 14/27] powerpc/eeh: I/O chip EEH enable option
Date: Wed,  5 Jun 2013 15:34:15 +0800
Message-Id: <1370417668-16832-15-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1370417668-16832-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1370417668-16832-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch adds the backend to enable or disable EEH functionality
for the specified PE. The backend is also used to enable MMIO or
DMA path for the problematic PE. It's notable that all PEs on
PowerNV platform support EEH functionality by default, and we
disallow to disable EEH for the specific PE.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c |   65 ++++++++++++++++++++++++++++-
 1 files changed, 64 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 6640d4f..e24622e 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -62,9 +62,72 @@ static int ioda_eeh_post_init(struct pci_controller *hose)
 	return 0;
 }
 
+/**
+ * ioda_eeh_set_option - Set EEH operation or I/O setting
+ * @pe: EEH PE
+ * @option: options
+ *
+ * Enable or disable EEH option for the indicated PE. The
+ * function also can be used to enable I/O or DMA for the
+ * PE.
+ */
+static int ioda_eeh_set_option(struct eeh_pe *pe, int option)
+{
+	s64 ret;
+	u32 pe_no;
+	struct pci_controller *hose = pe->phb;
+	struct pnv_phb *phb = hose->private_data;
+
+	/* Check on PE number */
+	if (pe->addr < 0 || pe->addr >= phb->ioda.total_pe) {
+		pr_err("%s: PE address %x out of range [0, %x] "
+		       "on PHB#%x\n",
+			__func__, pe->addr, phb->ioda.total_pe,
+			hose->global_number);
+		return -EINVAL;
+	}
+
+	pe_no = pe->addr;
+	switch (option) {
+	case EEH_OPT_DISABLE:
+		ret = -EEXIST;
+		break;
+	case EEH_OPT_ENABLE:
+		ret = 0;
+		break;
+	case EEH_OPT_THAW_MMIO:
+		ret = opal_pci_eeh_freeze_clear(phb->opal_id, pe_no,
+				OPAL_EEH_ACTION_CLEAR_FREEZE_MMIO);
+		if (ret) {
+			pr_warning("%s: Failed to enable MMIO for "
+				   "PHB#%x-PE#%x, err=%lld\n",
+				__func__, hose->global_number, pe_no, ret);
+			return -EIO;
+		}
+
+		break;
+	case EEH_OPT_THAW_DMA:
+		ret = opal_pci_eeh_freeze_clear(phb->opal_id, pe_no,
+				OPAL_EEH_ACTION_CLEAR_FREEZE_DMA);
+		if (ret) {
+			pr_warning("%s: Failed to enable DMA for "
+				   "PHB#%x-PE#%x, err=%lld\n",
+				__func__, hose->global_number, pe_no, ret);
+			return -EIO;
+		}
+
+		break;
+	default:
+		pr_warning("%s: Invalid option %d\n", __func__, option);
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
 struct pnv_eeh_ops ioda_eeh_ops = {
 	.post_init		= ioda_eeh_post_init,
-	.set_option		= NULL,
+	.set_option		= ioda_eeh_set_option,
 	.get_state		= NULL,
 	.reset			= NULL,
 	.get_log		= NULL,
-- 
1.7.5.4
