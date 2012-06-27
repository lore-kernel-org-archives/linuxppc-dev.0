Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B8775B6FA4
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2012 02:48:26 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 27 Jun 2012 10:48:24 -0600
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 3B271C93CD2
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 12:03:27 -0400 (EDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5RG3SSJ151914
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 12:03:28 -0400
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5RG210N027274
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 10:02:01 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 02/21] ppc/eeh: use slab to allocate eeh devices
Date: Thu, 28 Jun 2012 00:01:32 +0800
Message-Id: <1340812911-6793-3-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1340812911-6793-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1340812911-6793-1-git-send-email-shangw@linux.vnet.ibm.com>
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
are ready. So we use slab/slub to allocate the memory chunks for
newly creatd EEH devices. That would save lots of memory.

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
index 4cb375c..87fea2e 100644
--- a/arch/powerpc/platforms/pseries/eeh_event.c
+++ b/arch/powerpc/platforms/pseries/eeh_event.c
@@ -137,7 +137,7 @@ int eeh_send_failure_event(struct eeh_dev *edev)
 		printk(KERN_ERR "EEH: PCI location = %s\n", location);
 		return 1;
 	}
-	event = kmalloc(sizeof(*event), GFP_ATOMIC);
+	event = kzalloc(sizeof(*event), GFP_ATOMIC);
 	if (event == NULL) {
 		printk(KERN_ERR "EEH: out of memory, event not handled\n");
 		return 1;
-- 
1.7.9.5
