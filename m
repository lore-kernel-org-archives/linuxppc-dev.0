Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 716211A021A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 10:57:35 +1000 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Mon, 28 Jul 2014 18:57:33 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 0B4AA3E4003D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jul 2014 18:57:31 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6T0uE8710224110
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 02:56:15 +0200
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6T0vUfR000432
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jul 2014 18:57:30 -0600
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/pci: reorder pci bus/bridge unregistration during PHB
 removal
Date: Mon, 28 Jul 2014 20:48:31 -0400
Message-Id: <1406594911-7097-1-git-send-email-tyreld@linux.vnet.ibm.com>
Cc: nfont@linux.vnet.ibm.com, paulus@samba.org,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit bcdde7e made __sysfs_remove_dir() recursive and introduced a BUG_ON
during PHB removal while attempting to delete the power managment attribute
group of the bus. This is a result of tearing the bridge and bus devices down
out of order in remove_phb_dynamic. Since, the the bus resides below the bridge
in the sysfs device tree it should be torn down first.

This patch simply moves the device_unregister call for the PHB bridge device
after the device_unregister call for the PHB bus.

Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/pci_dlpar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/pci_dlpar.c b/arch/powerpc/platforms/pseries/pci_dlpar.c
index 203cbf0..89e2381 100644
--- a/arch/powerpc/platforms/pseries/pci_dlpar.c
+++ b/arch/powerpc/platforms/pseries/pci_dlpar.c
@@ -118,10 +118,10 @@ int remove_phb_dynamic(struct pci_controller *phb)
 		}
 	}
 
-	/* Unregister the bridge device from sysfs and remove the PCI bus */
-	device_unregister(b->bridge);
+	/* Remove the PCI bus and unregister the bridge device from sysfs */
 	phb->bus = NULL;
 	pci_remove_bus(b);
+	device_unregister(b->bridge);
 
 	/* Now release the IO resource */
 	if (res->flags & IORESOURCE_IO)
-- 
1.7.12.4
