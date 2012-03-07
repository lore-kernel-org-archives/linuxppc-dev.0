Return-Path: <bhelgaas@google.com>
Received: from mail-gx0-f201.google.com (mail-gx0-f201.google.com
 [209.85.161.201])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 118ACB6FCA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2012 12:00:21 +1100 (EST)
Received: by ggki24 with SMTP id i24so698196ggk.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Mar 2012 17:00:18 -0800 (PST)
Subject: [PATCH v1 2/9] powerpc/PCI: compute I/O space bus-to-resource offset
 consistently
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 06 Mar 2012 18:00:17 -0700
Message-ID: <20120307010017.27465.29519.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120307005905.27465.71131.stgit@bhelgaas.mtv.corp.google.com>
References: <20120307005905.27465.71131.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make sure we compute CPU addresses (resource start/end) the same way both
when we set up the I/O aperture (hose->io_resource) and when we use
pcibios_bus_to_resource() to convert BAR values into resources.

CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/powerpc/include/asm/pci.h   |    1 +
 arch/powerpc/kernel/pci-common.c |    8 ++++++--
 arch/powerpc/kernel/pci_32.c     |    6 +++---
 arch/powerpc/kernel/pci_64.c     |    2 +-
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index 201e352..6653f27 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -182,6 +182,7 @@ extern void pci_resource_to_user(const struct pci_dev *dev, int bar,
 				 const struct resource *rsrc,
 				 resource_size_t *start, resource_size_t *end);
 
+extern resource_size_t pcibios_io_space_offset(struct pci_controller *hose);
 extern void pcibios_setup_bus_devices(struct pci_bus *bus);
 extern void pcibios_setup_bus_self(struct pci_bus *bus);
 extern void pcibios_setup_phb_io_space(struct pci_controller *hose);
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 910b9de..2efd52d 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1492,6 +1492,11 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 	return pci_enable_resources(dev, mask);
 }
 
+resource_size_t pcibios_io_space_offset(struct pci_controller *hose)
+{
+	return (unsigned long) hose->io_base_virt - _IO_BASE;
+}
+
 static void __devinit pcibios_setup_phb_resources(struct pci_controller *hose, struct list_head *resources)
 {
 	struct resource *res;
@@ -1516,8 +1521,7 @@ static void __devinit pcibios_setup_phb_resources(struct pci_controller *hose, s
 		 (unsigned long long)res->start,
 		 (unsigned long long)res->end,
 		 (unsigned long)res->flags);
-	pci_add_resource_offset(resources, res,
-			(resource_size_t) hose->io_base_virt - _IO_BASE);
+	pci_add_resource_offset(resources, res, pcibios_io_space_offset(hose));
 
 	/* Hookup PHB Memory resources */
 	for (i = 0; i < 3; ++i) {
diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index fdd1a3d..4b06ec5 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -219,9 +219,9 @@ void __devinit pcibios_setup_phb_io_space(struct pci_controller *hose)
 	struct resource *res = &hose->io_resource;
 
 	/* Fixup IO space offset */
-	io_offset = (unsigned long)hose->io_base_virt - isa_io_base;
-	res->start = (res->start + io_offset) & 0xffffffffu;
-	res->end = (res->end + io_offset) & 0xffffffffu;
+	io_offset = pcibios_io_space_offset(hose);
+	res->start += io_offset;
+	res->end += io_offset;
 }
 
 static int __init pcibios_init(void)
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 75417fd..94a54f6 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -168,7 +168,7 @@ static int __devinit pcibios_map_phb_io_space(struct pci_controller *hose)
 		return -ENOMEM;
 
 	/* Fixup hose IO resource */
-	io_virt_offset = (unsigned long)hose->io_base_virt - _IO_BASE;
+	io_virt_offset = pcibios_io_space_offset(hose);
 	hose->io_resource.start += io_virt_offset;
 	hose->io_resource.end += io_virt_offset;
 
