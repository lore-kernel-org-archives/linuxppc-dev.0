Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z0lBL5nbzzDsF8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 02:21:46 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBIFJxL3139001
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 10:21:45 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2exd8d93vj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 10:21:44 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Mon, 18 Dec 2017 15:21:40 -0000
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, mpe@ellerman.id.au,
 andrew.donnellan@au1.ibm.com, alastair@au1.ibm.com
Subject: [PATCH 02/13] powerpc/powernv: Set correct configuration space size
 for opencapi devices
Date: Mon, 18 Dec 2017 16:21:15 +0100
In-Reply-To: <cover.1513608243.git.fbarrat@linux.vnet.ibm.com>
References: <cover.1513608243.git.fbarrat@linux.vnet.ibm.com>
In-Reply-To: <cover.1513608243.git.fbarrat@linux.vnet.ibm.com>
References: <cover.1513608243.git.fbarrat@linux.vnet.ibm.com>
Message-Id: <386af9b4afde2a0f9cd699d79b0fdf3e4fc0e2d7.1513608243.git.fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>From Andrew Donnellan <andrew.donnellan@au1.ibm.com>

The configuration space for opencapi devices doesn't have a PCI
Express capability, therefore confusing linux in thinking it's of an
old PCI type with a 256-byte configuration space size, instead of the
desired 4k. So add a PCI fixup to declare the correct size.


Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index c37b5d288f9c..b8ec76aa266f 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -4079,6 +4079,16 @@ void __init pnv_pci_init_npu2_opencapi_phb(struct device_node *np)
 	pnv_pci_init_ioda_phb(np, 0, PNV_PHB_NPU_OCAPI);
 }
 
+static void pnv_npu2_opencapi_cfg_size_fixup(struct pci_dev *dev)
+{
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+	struct pnv_phb *phb = hose->private_data;
+
+	if (phb->type == PNV_PHB_NPU_OCAPI)
+		dev->cfg_size = PCI_CFG_SPACE_EXP_SIZE;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_ANY_ID, PCI_ANY_ID, pnv_npu2_opencapi_cfg_size_fixup);
+
 void __init pnv_pci_init_ioda_hub(struct device_node *np)
 {
 	struct device_node *phbn;
-- 
2.14.1
