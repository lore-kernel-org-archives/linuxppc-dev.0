Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4C7DD2C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jul 2013 12:14:35 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 17 Jul 2013 22:14:32 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id C3E986E803C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jul 2013 22:14:24 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6I2ETMA112804
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jul 2013 22:14:29 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6I2ETxc028792
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jul 2013 22:14:29 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 03/10] powerpc/pci: Override pcibios_release_device()
Date: Thu, 18 Jul 2013 10:14:13 +0800
Message-Id: <1374113660-15347-4-git-send-email-shangw@linux.vnet.ibm.com>
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

The patch overrides pcibios_release_device() to release EEH
resources (EEH cache, unbinding EEH device) for the indicated PCI
device.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/pci-hotplug.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
index 3f60880..3dab2f2 100644
--- a/arch/powerpc/kernel/pci-hotplug.c
+++ b/arch/powerpc/kernel/pci-hotplug.c
@@ -22,6 +22,17 @@
 #include <asm/eeh.h>
 
 /**
+ * pcibios_release_device - release PCI device
+ * @dev: PCI device
+ *
+ * The function is called before releasing the indicated PCI device.
+ */
+void pcibios_release_device(struct pci_dev *dev)
+{
+	eeh_remove_device(dev, 1);
+}
+
+/**
  * __pcibios_remove_pci_devices - remove all devices under this bus
  * @bus: the indicated PCI bus
  * @purge_pe: destroy the PE on removal of PCI devices
-- 
1.7.5.4
