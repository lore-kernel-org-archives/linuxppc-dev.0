Return-Path: <cascardo@linux.vnet.ibm.com>
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp03.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B9F612C00E7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Dec 2012 06:13:39 +1100 (EST)
Received: from /spool/local
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cascardo@linux.vnet.ibm.com>;
 Fri, 28 Dec 2012 17:13:27 -0200
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 9FC0E3520052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Dec 2012 14:13:24 -0500 (EST)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay02.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qBSJD1oc35913774
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Dec 2012 17:13:01 -0200
Received: from d24av01.br.ibm.com (loopback [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qBSJDND2004983
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Dec 2012 17:13:24 -0200
From: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] EEH/OF: checking for CONFIG_EEH is not needed
Date: Fri, 28 Dec 2012 17:13:18 -0200
Message-Id: <1356721999-25159-1-git-send-email-cascardo@linux.vnet.ibm.com>
In-Reply-To: <20121228120616.GB21831@oc0268524204.ibm.com>
References: <20121228120616.GB21831@oc0268524204.ibm.com>
Cc: bhelgaas@google.com, paulus@samba.org, linux-kernel@vger.kernel.org,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 shangw@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The functions used are already defined as empty inline functions for the
case where EEH is disabled.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/of_platform.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/of_platform.c b/arch/powerpc/kernel/of_platform.c
index 2049f2d..c5fc6b2 100644
--- a/arch/powerpc/kernel/of_platform.c
+++ b/arch/powerpc/kernel/of_platform.c
@@ -71,10 +71,8 @@ static int __devinit of_pci_phb_probe(struct platform_device *dev)
 	eeh_dev_phb_init_dynamic(phb);
 
 	/* Register devices with EEH */
-#ifdef CONFIG_EEH
 	if (dev->dev.of_node->child)
 		eeh_add_device_tree_early(dev->dev.of_node);
-#endif /* CONFIG_EEH */
 
 	/* Scan the bus */
 	pcibios_scan_phb(phb);
@@ -88,9 +86,7 @@ static int __devinit of_pci_phb_probe(struct platform_device *dev)
 	pcibios_claim_one_bus(phb->bus);
 
 	/* Finish EEH setup */
-#ifdef CONFIG_EEH
 	eeh_add_device_tree_late(phb->bus);
-#endif
 
 	/* Add probed PCI devices to the device model */
 	pci_bus_add_devices(phb->bus);
-- 
1.7.1
