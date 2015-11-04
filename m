Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AA9841A0CDB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 01:28:11 +1100 (AEDT)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 4 Nov 2015 19:58:07 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id CB00DE004C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2015 19:58:21 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA4EKPaU52101240
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 19:58:04 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA4DDJPj032046
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 18:43:21 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v7 36/50] powerpc/pci: Update bridge windows on PCI plug
Date: Thu,  5 Nov 2015 00:12:36 +1100
Message-Id: <1446642770-4681-37-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On the PCI plugging event, PCI slot's subordinate devices are
scanned and their (IO and MMIO) resources are assigned. Platform
dependent resources (PE#, IO/MMIO/DMA windows) are allocated or
created on updating windows of the slot's upstream bridge.

This updates the windows of the hot plugged slot's upstream bridge
in pcibios_finish_adding_to_bus() so that the platform resources
(PE#, IO/MMIO/DMA segments) are allocated or created accordingly.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/pci-common.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 40df3a5..be9e515 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1444,8 +1444,12 @@ void pcibios_finish_adding_to_bus(struct pci_bus *bus)
 	/* Allocate bus and devices resources */
 	pcibios_allocate_bus_resources(bus);
 	pcibios_claim_one_bus(bus);
-	if (!pci_has_flag(PCI_PROBE_ONLY))
-		pci_assign_unassigned_bus_resources(bus);
+	if (!pci_has_flag(PCI_PROBE_ONLY)) {
+		if (bus->self)
+			pci_assign_unassigned_bridge_resources(bus->self);
+		else
+			pci_assign_unassigned_bus_resources(bus);
+	}
 
 	/* Fixup EEH */
 	eeh_add_device_tree_late(bus);
-- 
2.1.0
