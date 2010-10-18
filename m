Return-Path: <nacc@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 185AFB70F3
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Oct 2010 04:27:36 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o9IHIMqS020319
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Oct 2010 11:18:22 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o9IHRIFD152684
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Oct 2010 11:27:18 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o9IHRGfM007889
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Oct 2010 11:27:17 -0600
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: nacc@us.ibm.com
Subject: [PATCH 5/7] ppc/dart: iommu table cleanup
Date: Mon, 18 Oct 2010 10:27:02 -0700
Message-Id: <1287422825-14999-6-git-send-email-nacc@us.ibm.com>
In-Reply-To: <1287422825-14999-1-git-send-email-nacc@us.ibm.com>
References: <1287422825-14999-1-git-send-email-nacc@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, miltonm@bga.com,
	=?UTF-8?q?Andr=C3=A9=20Goddard=20Rosa?= <andre.goddard@gmail.com>,
	Paul Mackerras <paulus@samba.org>, Tejun Heo <tj@kernel.org>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

No need to set the device tree device_node pci node iommu pointer, its
only used for dlpar remove.

Signed-off-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
---
 arch/powerpc/sysdev/dart_iommu.c |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
index 17cf15e..8e9e06a 100644
--- a/arch/powerpc/sysdev/dart_iommu.c
+++ b/arch/powerpc/sysdev/dart_iommu.c
@@ -312,17 +312,10 @@ static void pci_dma_dev_setup_dart(struct pci_dev *dev)
 
 static void pci_dma_bus_setup_dart(struct pci_bus *bus)
 {
-	struct device_node *dn;
-
 	if (!iommu_table_dart_inited) {
 		iommu_table_dart_inited = 1;
 		iommu_table_dart_setup();
 	}
-
-	dn = pci_bus_to_OF_node(bus);
-
-	if (dn)
-		PCI_DN(dn)->iommu_table = &iommu_table_dart;
 }
 
 static bool dart_device_on_pcie(struct device *dev)
@@ -373,7 +366,7 @@ void __init iommu_init_early_dart(void)
 	if (dn == NULL) {
 		dn = of_find_compatible_node(NULL, "dart", "u4-dart");
 		if (dn == NULL)
-			goto bail;
+			return;	/* use default direct_dma_ops */
 		dart_is_u4 = 1;
 	}
 
-- 
1.7.1
