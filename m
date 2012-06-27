Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 957BE100839
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2012 02:10:39 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 27 Jun 2012 12:10:36 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id E3D4E6E8085
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 12:08:41 -0400 (EDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5RG77sm198728
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 12:08:41 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5RG22iq003583
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 10:02:02 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 04/21] ppc/eeh: Introduce eeh_pe struct
Date: Thu, 28 Jun 2012 00:01:34 +0800
Message-Id: <1340812911-6793-5-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1340812911-6793-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1340812911-6793-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As defined in PAPR 2.4, Partitionable Endpoint (PE) is an I/O subtree
that can be treated as a unit for the purposes of partitioning and error
recovery. Therefore, eeh core should be aware of PE. With eeh_pe struct,
we can support PE explicitly. Further more, it makes all the staff as
data centralized. Another important reason is for eeh core to support
multiple platforms. Some of them like pSeries figures out PEs through
OF nodes while others like powernv have to do that through PCI bus/device
tree. With explicit PE support, eeh core will be implemented based on
the centrialized data and platform dependent implementations figure it
out by their feasible ways.

When the struct is designed, following factors are taken in account:
  * Reflecting the relationships of PEs. PE might have parent
    as well children.
  * Reflecting the association of PE and (eeh) devices.
  * PEs have PHB boundary.
  * PE should have unique address assigned in the corresponding
    PHB domain.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h |   38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 06dedff..f77b6d7 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -32,6 +32,42 @@ struct device_node;
 #ifdef CONFIG_EEH
 
 /*
+ * The struct is used to trace PE related EEH functionality.
+ * In theory, there will have one instance of the struct to
+ * be created against particular PE. In nature, PEs corelate
+ * to each other. the struct has to reflect that hierarchy in
+ * order to easily pick up those affected PEs when one particular
+ * PE has EEH errors.
+ *
+ * Also, one particular PE might be composed of PCI device, PCI
+ * bus and its subordinate components. The struct also need ship
+ * the information. Further more, one particular PE is only meaingful
+ * in the corresponding PHB. Therefore, the root PEs should be created
+ * against existing PHBs in on-to-one fashion.
+ */
+#define EEH_PE_PHB	1	/* PHB PE    */
+#define EEH_PE_DEVICE 	2	/* Device PE */
+#define EEH_PE_BUS	3	/* Bus PE    */
+
+#define EEH_PE_ISOLATED		(1 << 0)	/* Isolated PE		*/
+#define EEH_PE_RECOVERING	(1 << 1)	/* Recovering PE	*/
+
+struct eeh_pe {
+	int type;			/* PE type: PHB/Bus/Device	*/
+	int state;			/* PE EEH dependent mode	*/
+	int config_addr;		/* Traditional PCI address	*/
+	int addr;			/* PE configuration address	*/
+	struct pci_controller *phb;	/* Associated PHB		*/
+	int check_count;		/* Times of ignored error	*/
+	int freeze_count;		/* Times of froze up		*/
+	int false_positives;		/* Times of reported #ff's	*/
+	struct eeh_pe *parent;		/* Parent PE			*/
+	struct list_head child_list;	/* Link PE to the child list	*/
+	struct list_head edevs;		/* Link list of EEH devices	*/
+	struct list_head child;		/* Child PEs			*/
+};
+
+/*
  * The struct is used to trace EEH state for the associated
  * PCI device node or PCI device. In future, it might
  * represent PE as well so that the EEH device to form
@@ -53,6 +89,8 @@ struct eeh_dev {
 	int freeze_count;		/* Times of froze up		*/
 	int false_positives;		/* Times of reported #ff's	*/
 	u32 config_space[16];		/* Saved PCI config space	*/
+	struct eeh_pe *pe;		/* Associated PE		*/
+	struct list_head list;		/* Form link list in the PE	*/
 	struct pci_controller *phb;	/* Associated PHB		*/
 	struct device_node *dn;		/* Associated device node	*/
 	struct pci_dev *pdev;		/* Associated PCI device	*/
-- 
1.7.9.5
