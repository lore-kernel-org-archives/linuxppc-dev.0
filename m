Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e36.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E9ED82C00C7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 21:11:09 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 23 Jul 2013 05:11:07 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id A33253E4004F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 05:10:41 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6NBB2pZ148464
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 05:11:03 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6NBB27p023472
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 05:11:02 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 03/11] powerpc/pci: Override pcibios_release_device()
Date: Tue, 23 Jul 2013 19:10:48 +0800
Message-Id: <1374577856-1712-4-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1374577856-1712-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1374577856-1712-1-git-send-email-shangw@linux.vnet.ibm.com>
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
