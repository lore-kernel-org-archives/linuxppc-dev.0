Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e38.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 961D32C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jul 2013 12:14:32 +1000 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 17 Jul 2013 20:14:29 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 6BD9819D804C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jul 2013 20:14:16 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6I2ERKQ049056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jul 2013 20:14:27 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6I2EQiT010526
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jul 2013 20:14:26 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 01/10] powerpc/eeh: Remove reference to PCI device
Date: Thu, 18 Jul 2013 10:14:11 +0800
Message-Id: <1374113660-15347-2-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1374113660-15347-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1374113660-15347-1-git-send-email-shangw@linux.vnet.ibm.com>
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
