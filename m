Return-Path: <nacc@us.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 31870B6ED0
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 04:06:41 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e8.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8FHm0Gr029438
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 13:48:00 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8FI6agu079734
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 14:06:36 -0400
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o8FI6ZwE006026
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 12:06:36 -0600
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: nacc@us.ibm.com
Subject: [PATCH 12/15] ppc/dart: iommu table cleanup
Date: Wed, 15 Sep 2010 11:05:55 -0700
Message-Id: <1284573958-8397-13-git-send-email-nacc@us.ibm.com>
In-Reply-To: <1284573958-8397-1-git-send-email-nacc@us.ibm.com>
References: <1284573958-8397-1-git-send-email-nacc@us.ibm.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Milton Miller <miltonm@bga.com>,
	=?UTF-8?q?Andr=C3=A9=20Goddard=20Rosa?= <andre.goddard@gmail.com>,
	Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>, linuxppc-dev@lists.ozlabs.org
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

direct_dma_ops are the default, no need to restore them or dma bus ops
if we haven't set them in the error paths.

Signed-off-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
---
 arch/powerpc/sysdev/dart_iommu.c |   18 +-----------------
 1 files changed, 1 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
index 559db2b..64fe9c7 100644
--- a/arch/powerpc/sysdev/dart_iommu.c
+++ b/arch/powerpc/sysdev/dart_iommu.c
@@ -302,17 +302,10 @@ static void pci_dma_dev_setup_dart(struct pci_dev *dev)
 
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
 
 void __init iommu_init_early_dart(void)
@@ -324,7 +317,7 @@ void __init iommu_init_early_dart(void)
 	if (dn == NULL) {
 		dn = of_find_compatible_node(NULL, "dart", "u4-dart");
 		if (dn == NULL)
-			goto bail;
+			return;	/* use default direct_dma_ops */
 		dart_is_u4 = 1;
 	}
 
@@ -340,16 +333,7 @@ void __init iommu_init_early_dart(void)
 
 		/* Setup pci_dma ops */
 		set_pci_dma_ops(&dma_iommu_ops);
-		return;
 	}
-
- bail:
-	/* If init failed, use direct iommu and null setup functions */
-	ppc_md.pci_dma_dev_setup = NULL;
-	ppc_md.pci_dma_bus_setup = NULL;
-
-	/* Setup pci_dma ops */
-	set_pci_dma_ops(&dma_direct_ops);
 }
 
 #ifdef CONFIG_PM
-- 
1.7.0.4
