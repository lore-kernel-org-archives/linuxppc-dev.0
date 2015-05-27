Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A1B641A0DD2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 16:07:36 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org
Cc: imunsie@au.ibm.com, linuxppc-dev@ozlabs.org, mikey@neuling.org,
 Daniel Axtens <dja@axtens.net>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, brking@linux.vnet.ibm.com
Subject: [PATCH v3 06/24] powerpc/pci: Add pcibios_disable_device() hook
Date: Wed, 27 May 2015 16:07:00 +1000
Message-Id: <1432706838-20794-7-git-send-email-mikey@neuling.org>
In-Reply-To: <1432706838-20794-1-git-send-email-mikey@neuling.org>
References: <1432706838-20794-1-git-send-email-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds a hook into the powerpc pci code for pci_disable_device() calls.  The
generic code already provides a weak pcibios_disable_device() symbol, so we
just need to provide our own in powerpc and it'll get picked up.

This is passed directly to the phb controller ops, provided one exists.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/pci-bridge.h | 2 ++
 arch/powerpc/kernel/pci-common.c      | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 3947749..b76cd56 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -27,6 +27,8 @@ struct pci_controller_ops {
 	 * allow assignment/enabling of the device. */
 	bool		(*enable_device_hook)(struct pci_dev *);
 
+	void		(*disable_device)(struct pci_dev *);
+
 	void		(*release_device)(struct pci_dev *);
 
 	/* Called during PCI resource reassignment */
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 2040cd2..b9de34d 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1490,6 +1490,14 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 	return pci_enable_resources(dev, mask);
 }
 
+void pcibios_disable_device(struct pci_dev *dev)
+{
+	struct pci_controller *phb = pci_bus_to_host(dev->bus);
+
+	if (phb->controller_ops.disable_device)
+		phb->controller_ops.disable_device(dev);
+}
+
 resource_size_t pcibios_io_space_offset(struct pci_controller *hose)
 {
 	return (unsigned long) hose->io_base_virt - _IO_BASE;
-- 
2.1.0
