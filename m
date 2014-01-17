Return-Path: <aik@ozlabs.ru>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 836FF2C041B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2014 16:10:18 +1100 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 17 Jan 2014 15:10:18 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 7224A2CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2014 16:10:14 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0H4nllH60817512
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2014 15:49:52 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0H58pcl027796
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2014 16:08:51 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/3] pci: add "fundamental reset" quirk
Date: Fri, 17 Jan 2014 16:08:46 +1100
Message-Id: <1389935328-22588-2-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1389935328-22588-1-git-send-email-aik@ozlabs.ru>
References: <1389935328-22588-1-git-send-email-aik@ozlabs.ru>
Cc: aik@ozlabs.ru, Paul Mackerras <paulus@samba.org>,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
---
 drivers/pci/quirks.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f6c31fa..f3eedbf 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3271,6 +3271,19 @@ static int reset_chelsio_generic_dev(struct pci_dev *dev, int probe)
 	return 0;
 }
 
+static int reset_fundamental(struct pci_dev *dev, int probe)
+{
+	if (probe)
+		return 0;
+
+	pci_set_pcie_reset_state(dev, pcie_hot_reset);
+	msleep(250);
+	pci_set_pcie_reset_state(dev, pcie_deassert_reset);
+	msleep(1800);
+
+	return 0;
+}
+
 #define PCI_DEVICE_ID_INTEL_82599_SFP_VF   0x10ed
 #define PCI_DEVICE_ID_INTEL_IVB_M_VGA      0x0156
 #define PCI_DEVICE_ID_INTEL_IVB_M2_VGA     0x0166
@@ -3286,6 +3299,14 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 		reset_intel_generic_dev },
 	{ PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
 		reset_chelsio_generic_dev },
+
+	{ PCI_VENDOR_ID_IBM, PCI_ANY_ID,
+		reset_fundamental },
+	{ PCI_VENDOR_ID_MELLANOX, PCI_ANY_ID,
+		reset_fundamental },
+	{ PCI_VENDOR_ID_TI, PCI_ANY_ID,
+		reset_fundamental },
+
 	{ 0 }
 };
 
-- 
1.8.4.rc4
