Return-Path: <linas@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4D90367B67
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Sep 2006 09:55:39 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8FNtZas005172
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Sep 2006 19:55:35 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8FNtZM0161192
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Sep 2006 17:55:35 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8FNtY46020401
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Sep 2006 17:55:35 -0600
Date: Fri, 15 Sep 2006 18:55:34 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/4]: PowerPC: EEH: balance pcidev_get/put calls
Message-ID: <20060915235534.GR29167@austin.ibm.com>
References: <20060915235025.GQ29167@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060915235025.GQ29167@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



This patch corrects a pci_dev get/put imbalance that can occur 
only in highly unlikely situations (kmalloc failures, pci devices
with overlapping resource addresses).  No actual failures seen,
this was spotted during code review.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh_cache.c |   17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

Index: linux-2.6.18-rc7-git1/arch/powerpc/platforms/pseries/eeh_cache.c
===================================================================
--- linux-2.6.18-rc7-git1.orig/arch/powerpc/platforms/pseries/eeh_cache.c	2006-09-14 13:13:57.000000000 -0500
+++ linux-2.6.18-rc7-git1/arch/powerpc/platforms/pseries/eeh_cache.c	2006-09-14 13:52:34.000000000 -0500
@@ -157,6 +157,7 @@ pci_addr_cache_insert(struct pci_dev *de
 	if (!piar)
 		return NULL;
 
+	pci_dev_get(dev);
 	piar->addr_lo = alo;
 	piar->addr_hi = ahi;
 	piar->pcidev = dev;
@@ -178,7 +179,6 @@ static void __pci_addr_cache_insert_devi
 	struct device_node *dn;
 	struct pci_dn *pdn;
 	int i;
-	int inserted = 0;
 
 	dn = pci_device_to_OF_node(dev);
 	if (!dn) {
@@ -197,9 +197,6 @@ static void __pci_addr_cache_insert_devi
 		return;
 	}
 
-	/* The cache holds a reference to the device... */
-	pci_dev_get(dev);
-
 	/* Walk resources on this device, poke them into the tree */
 	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
 		unsigned long start = pci_resource_start(dev,i);
@@ -212,12 +209,7 @@ static void __pci_addr_cache_insert_devi
 		if (start == 0 || ~start == 0 || end == 0 || ~end == 0)
 			 continue;
 		pci_addr_cache_insert(dev, start, end, flags);
-		inserted = 1;
 	}
-
-	/* If there was nothing to add, the cache has no reference... */
-	if (!inserted)
-		pci_dev_put(dev);
 }
 
 /**
@@ -240,7 +232,6 @@ void pci_addr_cache_insert_device(struct
 static inline void __pci_addr_cache_remove_device(struct pci_dev *dev)
 {
 	struct rb_node *n;
-	int removed = 0;
 
 restart:
 	n = rb_first(&pci_io_addr_cache_root.rb_root);
@@ -250,16 +241,12 @@ restart:
 
 		if (piar->pcidev == dev) {
 			rb_erase(n, &pci_io_addr_cache_root.rb_root);
-			removed = 1;
+			pci_dev_put(piar->pcidev);
 			kfree(piar);
 			goto restart;
 		}
 		n = rb_next(n);
 	}
-
-	/* The cache no longer holds its reference to this device... */
-	if (removed)
-		pci_dev_put(dev);
 }
 
 /**
