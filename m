Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AAB7714014B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:33 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 24 Apr 2014 18:00:33 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id A093E3578058
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:31 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3O80Gld55246956
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:17 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3O80U15023502
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:31 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH 21/25] powerpc/powernv: Fundamental reset on PLX ports
Date: Thu, 24 Apr 2014 18:00:27 +1000
Message-Id: <1398326431-24305-22-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch intends to support fundamental reset on PLX downstream
ports. If the PCI device matches any one of the internal table,
which includes PLX vendor ID, bridge device ID, register offset
for fundamental reset and bit, fundamental reset will be done
accordingly. Otherwise, it will fail back to hot reset.

Additional flag (EEH_DEV_FRESET) is introduced to record the last
reset type on the PCI bridge.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h            |   1 +
 arch/powerpc/platforms/powernv/eeh-ioda.c | 110 +++++++++++++++++++++++++-----
 2 files changed, 95 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index b76f58c..d12529f 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -109,6 +109,7 @@ struct eeh_pe {
 #define EEH_DEV_NO_HANDLER	(1 << 8)	/* No error handler	*/
 #define EEH_DEV_SYSFS		(1 << 9)	/* Sysfs created	*/
 #define EEH_DEV_REMOVED		(1 << 10)	/* Removed permanently	*/
+#define EEH_DEV_FRESET		(1 << 11)	/* Fundamental reset	*/
 
 struct eeh_dev {
 	int mode;			/* EEH mode			*/
diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 753f08e..79d0cdf 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -477,49 +477,127 @@ out:
 	return 0;
 }
 
+static bool ioda_eeh_is_plx_dnport(struct pci_dev *dev, int *reg,
+				   int *mask, int *len)
+{
+	unsigned short *pid;
+	unsigned short ids[] = {
+		0x10b5, 0x8748, 0x0080, 0x0400, /* PLX#8748     */
+		0x0000, 0x0000, 0x0000, 0x0000, /* End flag     */
+	};
+
+	if (!pci_is_pcie(dev))
+		return false;
+	if (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM)
+		return false;
+
+	pid = &ids[0];
+	while (!reg) {
+		if (pid[0] == 0x0)
+			break;
+
+		if (dev->vendor == pid[0] &&
+		    dev->device == pid[1]) {
+                        *reg  = pid[2];
+                        *mask = pid[3];
+                        *len  = 2;
+                        return true;
+                }
+        }
+
+	*reg  = PCI_BRIDGE_CONTROL;
+	*mask = PCI_BRIDGE_CTL_BUS_RESET;
+	*len  = 2;
+	return false;
+}
+
 static int ioda_eeh_bridge_reset(struct pci_dev *dev, int option)
 
 {
 	struct device_node *dn = pci_device_to_OF_node(dev);
 	struct eeh_dev *edev = of_node_to_eeh_dev(dn);
 	int aer = edev ? edev->aer_cap : 0;
-	u32 ctrl;
+	int reg, mask, val, len;
+	bool is_plx_dnport;
 
 	pr_debug("%s: Reset PCI bus %04x:%02x with option %d\n",
 		 __func__, pci_domain_nr(dev->bus),
 		 dev->bus->number, option);
 
+
+	is_plx_dnport = ioda_eeh_is_plx_dnport(dev, &reg, &mask, &len);
+	if (option == EEH_RESET_FUNDAMENTAL)
+		if (!is_plx_dnport || !edev)
+			option = EEH_RESET_HOT;
+
+	if (option == EEH_RESET_HOT) {
+		reg  = PCI_BRIDGE_CONTROL;
+		mask = PCI_BRIDGE_CTL_BUS_RESET;
+		len  = 2;
+	}
+
+	if (option == EEH_RESET_DEACTIVATE) {
+		if (!is_plx_dnport || !edev ||
+		    !(edev->mode & EEH_DEV_FRESET)) {
+			reg  = PCI_BRIDGE_CONTROL;
+			mask = PCI_BRIDGE_CTL_BUS_RESET;
+			len  = 2;
+		}
+	}
+
 	switch (option) {
 	case EEH_RESET_FUNDAMENTAL:
+		edev->mode |= EEH_DEV_FRESET;
+		/* Fall through */
 	case EEH_RESET_HOT:
-		/* Don't report linkDown event */
 		if (aer) {
+			/* Mask receiver error */
+			eeh_ops->read_config(dn, aer + PCI_ERR_COR_MASK,
+					     4, &val);
+			val |= PCI_ERR_COR_RCVR;
+			eeh_ops->write_config(dn, aer + PCI_ERR_COR_MASK,
+					      4, val);
+
+			/* Mask linkDown */
 			eeh_ops->read_config(dn, aer + PCI_ERR_UNCOR_MASK,
-					     4, &ctrl);
-			ctrl |= PCI_ERR_UNC_SURPDN;
+					     4, &val);
+			val |= PCI_ERR_UNC_SURPDN;
                         eeh_ops->write_config(dn, aer + PCI_ERR_UNCOR_MASK,
-					      4, ctrl);
-                }
+					      4, val);
+		}
 
-		eeh_ops->read_config(dn, PCI_BRIDGE_CONTROL, 2, &ctrl);
-		ctrl |= PCI_BRIDGE_CTL_BUS_RESET;
-		eeh_ops->write_config(dn, PCI_BRIDGE_CONTROL, 2, ctrl);
+		eeh_ops->read_config(dn, reg, len, &val);
+		val |= mask;
+		eeh_ops->write_config(dn, reg, len, val);
 		msleep(EEH_PE_RST_HOLD_TIME);
 
 		break;
 	case EEH_RESET_DEACTIVATE:
-		eeh_ops->read_config(dn, PCI_BRIDGE_CONTROL, 2, &ctrl);
-		ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
-		eeh_ops->write_config(dn, PCI_BRIDGE_CONTROL, 2, ctrl);
+		eeh_ops->read_config(dn, reg, len, &val);
+		val &= ~mask;
+		eeh_ops->write_config(dn, reg, len, val);
 		msleep(EEH_PE_RST_SETTLE_TIME);
 
-		/* Continue reporting linkDown event */
+		if (edev)
+			edev->mode &= ~EEH_DEV_FRESET;
 		if (aer) {
+			/* Clear receive error and enable it */
+			eeh_ops->write_config(dn, aer + PCI_ERR_COR_STATUS,
+					      4, PCI_ERR_COR_RCVR);
+			eeh_ops->read_config(dn, aer + PCI_ERR_COR_MASK,
+					     4, &val);
+                        val &= ~PCI_ERR_COR_RCVR;
+			eeh_ops->write_config(dn, aer + PCI_ERR_COR_MASK,
+					      4, val);
+
+			/* Clear linkDown and enable it */
+			eeh_ops->write_config(dn, aer + PCI_ERR_UNCOR_STATUS,
+					      4, PCI_ERR_UNC_SURPDN);
 			eeh_ops->read_config(dn, aer + PCI_ERR_UNCOR_MASK,
-					     4, &ctrl);
-			ctrl &= ~PCI_ERR_UNC_SURPDN;
+					     4, &val);
+			val &= ~PCI_ERR_UNC_SURPDN;
 			eeh_ops->write_config(dn, aer + PCI_ERR_UNCOR_MASK,
-					      4, ctrl);
+					      4, val);
 		}
 
 		break;
-- 
1.8.3.2
