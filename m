Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e4.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E49F22C0093
 for <linuxppc-dev@ozlabs.org>; Sat,  8 Sep 2012 18:44:36 +1000 (EST)
Received: from /spool/local
 by e4.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Sat, 8 Sep 2012 04:44:33 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 985C26E8041
 for <linuxppc-dev@ozlabs.org>; Sat,  8 Sep 2012 04:44:30 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q888iUGa146276
 for <linuxppc-dev@ozlabs.org>; Sat, 8 Sep 2012 04:44:30 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q888iUWK005950
 for <linuxppc-dev@ozlabs.org>; Sat, 8 Sep 2012 04:44:30 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 02/22] ppc/eeh: use slab to allocate eeh devices
Date: Sat,  8 Sep 2012 16:44:03 +0800
Message-Id: <1347093863-6319-3-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1347093863-6319-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1347093863-6319-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The EEH initialization functions have been postponed until slab/slub
are ready. So we use slab/slub to allocate the memory chunks for newly
creatd EEH devices. That would save lots of memory.

The patch also does cleanup to replace "kmalloc" with "kzalloc" so
that we needn't clear the allocated memory chunk explicitly.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/eeh_cache.c |    2 +-
 arch/powerpc/platforms/pseries/eeh_dev.c   |    2 +-
 arch/powerpc/platforms/pseries/eeh_event.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh_cache.c b/arch/powerpc/platforms/pseries/eeh_cache.c
index e5ae1c6..f50b717 100644
--- a/arch/powerpc/platforms/pseries/eeh_cache.c
+++ b/arch/powerpc/platforms/pseries/eeh_cache.c
@@ -151,7 +151,7 @@ pci_addr_cache_insert(struct pci_dev *dev, unsigned long alo,
 			return piar;
 		}
 	}
-	piar = kmalloc(sizeof(struct pci_io_addr_range), GFP_ATOMIC);
+	piar = kzalloc(sizeof(struct pci_io_addr_range), GFP_ATOMIC);
 	if (!piar)
 		return NULL;
 
diff --git a/arch/powerpc/platforms/pseries/eeh_dev.c b/arch/powerpc/platforms/pseries/eeh_dev.c
index ab68c59..8e3443b 100644
--- a/arch/powerpc/platforms/pseries/eeh_dev.c
+++ b/arch/powerpc/platforms/pseries/eeh_dev.c
@@ -55,7 +55,7 @@ void * __devinit eeh_dev_init(struct device_node *dn, void *data)
 	struct eeh_dev *edev;
 
 	/* Allocate EEH device */
-	edev = zalloc_maybe_bootmem(sizeof(*edev), GFP_KERNEL);
+	edev = kzalloc(sizeof(*edev), GFP_KERNEL);
 	if (!edev) {
 		pr_warning("%s: out of memory\n", __func__);
 		return NULL;
diff --git a/arch/powerpc/platforms/pseries/eeh_event.c b/arch/powerpc/platforms/pseries/eeh_event.c
index fb50631..6132772 100644
--- a/arch/powerpc/platforms/pseries/eeh_event.c
+++ b/arch/powerpc/platforms/pseries/eeh_event.c
@@ -139,7 +139,7 @@ int eeh_send_failure_event(struct eeh_dev *edev)
 		printk(KERN_ERR "EEH: PCI location = %s\n", location);
 		return 1;
 	}
-	event = kmalloc(sizeof(*event), GFP_ATOMIC);
+	event = kzalloc(sizeof(*event), GFP_ATOMIC);
 	if (event == NULL) {
 		printk(KERN_ERR "EEH: out of memory, event not handled\n");
 		return 1;
-- 
1.7.5.4
