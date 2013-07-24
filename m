Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D6C672C00CE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 12:25:16 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 23 Jul 2013 20:25:14 -0600
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 5DE9F6E8054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 22:25:06 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6O2PBR4138654
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 22:25:11 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6O2PAZn004206
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 22:25:10 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 01/11] powerpc/eeh: Remove reference to PCI device
Date: Wed, 24 Jul 2013 10:24:51 +0800
Message-Id: <1374632701-20972-2-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1374632701-20972-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1374632701-20972-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We will rely on pcibios_release_device() to remove the EEH cache
and unbind EEH device for the specific PCI device. So we shouldn't
hold the reference to the PCI device from EEH cache and EEH device.
Otherwise, pcibios_release_device() won't be called as we expected.
The patch removes the reference to the PCI device in EEH core.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c       |    4 ----
 arch/powerpc/kernel/eeh_cache.c |   18 +++++-------------
 2 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 39954fe..b5c425e 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -499,8 +499,6 @@ unsigned long eeh_check_failure(const volatile void __iomem *token, unsigned lon
 	}
 
 	eeh_dev_check_failure(edev);
-
-	pci_dev_put(eeh_dev_to_pci_dev(edev));
 	return val;
 }
 
@@ -904,7 +902,6 @@ static void eeh_add_device_late(struct pci_dev *dev)
 	}
 	WARN_ON(edev->pdev);
 
-	pci_dev_get(dev);
 	edev->pdev = dev;
 	dev->dev.archdata.edev = edev;
 
@@ -992,7 +989,6 @@ static void eeh_remove_device(struct pci_dev *dev, int purge_pe)
 	}
 	edev->pdev = NULL;
 	dev->dev.archdata.edev = NULL;
-	pci_dev_put(dev);
 
 	eeh_rmv_from_parent_pe(edev, purge_pe);
 	eeh_addr_cache_rmv_dev(dev);
diff --git a/arch/powerpc/kernel/eeh_cache.c b/arch/powerpc/kernel/eeh_cache.c
index f9ac123..e8c9fd5 100644
--- a/arch/powerpc/kernel/eeh_cache.c
+++ b/arch/powerpc/kernel/eeh_cache.c
@@ -68,16 +68,12 @@ static inline struct eeh_dev *__eeh_addr_cache_get_device(unsigned long addr)
 		struct pci_io_addr_range *piar;
 		piar = rb_entry(n, struct pci_io_addr_range, rb_node);
 
-		if (addr < piar->addr_lo) {
+		if (addr < piar->addr_lo)
 			n = n->rb_left;
-		} else {
-			if (addr > piar->addr_hi) {
-				n = n->rb_right;
-			} else {
-				pci_dev_get(piar->pcidev);
-				return piar->edev;
-			}
-		}
+		else if (addr > piar->addr_hi)
+			n = n->rb_right;
+		else
+			return piar->edev;
 	}
 
 	return NULL;
@@ -156,7 +152,6 @@ eeh_addr_cache_insert(struct pci_dev *dev, unsigned long alo,
 	if (!piar)
 		return NULL;
 
-	pci_dev_get(dev);
 	piar->addr_lo = alo;
 	piar->addr_hi = ahi;
 	piar->edev = pci_dev_to_eeh_dev(dev);
@@ -250,7 +245,6 @@ restart:
 
 		if (piar->pcidev == dev) {
 			rb_erase(n, &pci_io_addr_cache_root.rb_root);
-			pci_dev_put(piar->pcidev);
 			kfree(piar);
 			goto restart;
 		}
@@ -302,12 +296,10 @@ void eeh_addr_cache_build(void)
 		if (!edev)
 			continue;
 
-		pci_dev_get(dev);  /* matching put is in eeh_remove_device() */
 		dev->dev.archdata.edev = edev;
 		edev->pdev = dev;
 
 		eeh_addr_cache_insert_dev(dev);
-
 		eeh_sysfs_add_device(dev);
 	}
 
-- 
1.7.5.4
