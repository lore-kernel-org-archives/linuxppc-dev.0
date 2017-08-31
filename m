Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xjSfL5V5WzDqF4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 13:34:18 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <helgaas@kernel.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Alistair Popple <alistair@popple.id.au>, shan.gavin@gmail.com,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Russell Currey <ruscur@russell.cc>, Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH kernel] powerpc/powernv: Update comment about shifting IOV BAR
Date: Thu, 31 Aug 2017 13:34:12 +1000
Message-Id: <20170831033412.1971-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

This updates the comment about creating a hole in /proc/iomem which
should not be normally happening but it does in the powernv platform
due the way MMIO M64 BARs are organised in the IODA2-capable hardware.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

It has been mentioned multiple times (last one -
https://www.spinics.net/lists/linux-pci/msg64084.html ) that the comment
is not informative enough for people not particularly familiar with
the POWER8 IO hardware.

This attempt aims to:
1. explain why we shift the resource
2. explain why nothing can use that hole as a resource while it is "free"
(I am not sure that this is the case actually)

Please comment, everyone, let's have this very well documented while
I remember these bits :) Thanks.
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 48de308224d6..c4a36ae78c95 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1002,9 +1002,13 @@ static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
 	}
 
 	/*
-	 * After doing so, there would be a "hole" in the /proc/iomem when
-	 * offset is a positive value. It looks like the device return some
-	 * mmio back to the system, which actually no one could use it.
+	 * Since M64 BAR shares segments among all possible 256 PEs,
+	 * we have to shift the beginning of PF IOV BAR to make it start from
+	 * the segment which belongs to the PE number assigned to the first VF.
+	 * This creates a "hole" in the /proc/iomem which could be used for
+	 * allocating other resources, however this is not expected to happen
+	 * on IODA as the only possibility would be a PCI hotplug and IODA
+	 * hardware only allows it on a slot with dedicated PHB.
 	 */
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
 		res = &dev->resource[i + PCI_IOV_RESOURCES];
-- 
2.11.0
