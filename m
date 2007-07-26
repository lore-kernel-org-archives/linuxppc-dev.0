Return-Path: <linas@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3F524DDE17
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 08:34:02 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6QMXxLd017414
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 18:33:59 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6QMXxJi525766
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 18:33:59 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6QMXxLP027802
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 18:33:59 -0400
Date: Thu, 26 Jul 2007 17:33:58 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/3] powerpc/eeh: Fix pci bridge handling bug
Message-ID: <20070726223358.GB21552@austin.ibm.com>
References: <20070726222935.GJ9876@austin.ibm.com>
	<20070726223026.GA21552@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070726223026.GA21552@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



The EEH code needs to ignore PCI bridges; sort-of. It was ignoring 
them in the wrong place, and thus failing to set up the
PCI_DN(dn)->pcidev pointer. Imprudent dereferencing of this pointer
would lead to a crash on cards with bridges.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh_cache.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

Index: linux-2.6.22-git2/arch/powerpc/platforms/pseries/eeh_cache.c
===================================================================
--- linux-2.6.22-git2.orig/arch/powerpc/platforms/pseries/eeh_cache.c	2007-07-25 13:10:03.000000000 -0500
+++ linux-2.6.22-git2/arch/powerpc/platforms/pseries/eeh_cache.c	2007-07-25 13:13:41.000000000 -0500
@@ -225,6 +225,10 @@ void pci_addr_cache_insert_device(struct
 {
 	unsigned long flags;
 
+	/* Ignore PCI bridges */
+	if ((dev->class >> 16) == PCI_BASE_CLASS_BRIDGE)
+		return;
+
 	spin_lock_irqsave(&pci_io_addr_cache_root.piar_lock, flags);
 	__pci_addr_cache_insert_device(dev);
 	spin_unlock_irqrestore(&pci_io_addr_cache_root.piar_lock, flags);
@@ -285,16 +289,13 @@ void __init pci_addr_cache_build(void)
 	spin_lock_init(&pci_io_addr_cache_root.piar_lock);
 
 	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
-		/* Ignore PCI bridges */
-		if ((dev->class >> 16) == PCI_BASE_CLASS_BRIDGE)
-			continue;
 
 		pci_addr_cache_insert_device(dev);
 
 		dn = pci_device_to_OF_node(dev);
 		if (!dn)
 			continue;
-		pci_dev_get (dev);  /* matching put is in eeh_remove_device() */
+		pci_dev_get(dev);  /* matching put is in eeh_remove_device() */
 		PCI_DN(dn)->pcidev = dev;
 
 		eeh_sysfs_add_device(dev);
