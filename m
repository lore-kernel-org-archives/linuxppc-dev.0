Return-Path: <wfp5p@viridian.itc.virginia.edu>
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Subject: [PATCH 3/9] powerpc/PCI: Remove CONFIG_HOTPLUG ifdefs
Date: Wed, 21 Nov 2012 15:34:54 -0500
Message-Id: <1353530100-728-4-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353530100-728-1-git-send-email-wfp5p@virginia.edu>
References: <1353530100-728-1-git-send-email-wfp5p@virginia.edu>
Cc: linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
 Rob Herring <rob.herring@calxeda.com>, Paul Mackerras <paulus@samba.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove conditional code based on CONFIG_HOTPLUG being false.  It's
always on now in preparation of it going away as an option.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: devicetree-discuss@lists.ozlabs.org
---
 arch/powerpc/kernel/pci-common.c | 4 ----
 arch/powerpc/kernel/pci_64.c     | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 7f94f76..abc0d08 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1428,8 +1428,6 @@ void __init pcibios_resource_survey(void)
 		ppc_md.pcibios_fixup();
 }
 
-#ifdef CONFIG_HOTPLUG
-
 /* This is used by the PCI hotplug driver to allocate resource
  * of newly plugged busses. We can try to consolidate with the
  * rest of the code later, for now, keep it as-is as our main
@@ -1488,8 +1486,6 @@ void pcibios_finish_adding_to_bus(struct pci_bus *bus)
 }
 EXPORT_SYMBOL_GPL(pcibios_finish_adding_to_bus);
 
-#endif /* CONFIG_HOTPLUG */
-
 int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
 	if (ppc_md.pcibios_enable_device_hook)
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 4ff190f..2cbe676 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -74,8 +74,6 @@ static int __init pcibios_init(void)
 
 subsys_initcall(pcibios_init);
 
-#ifdef CONFIG_HOTPLUG
-
 int pcibios_unmap_io_space(struct pci_bus *bus)
 {
 	struct pci_controller *hose;
@@ -124,8 +122,6 @@ int pcibios_unmap_io_space(struct pci_bus *bus)
 }
 EXPORT_SYMBOL_GPL(pcibios_unmap_io_space);
 
-#endif /* CONFIG_HOTPLUG */
-
 static int __devinit pcibios_map_phb_io_space(struct pci_controller *hose)
 {
 	struct vm_struct *area;
-- 
1.8.0
