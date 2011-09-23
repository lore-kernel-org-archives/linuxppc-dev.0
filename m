Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5CA39B6F86
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Sep 2011 03:42:08 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: <kumar.gala@freescale.com>, <benh@kernel.crashing.org>,
	<linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/fsl_msi: add support for "msi-address-64" property
Date: Fri, 23 Sep 2011 12:41:35 -0500
Message-ID: <1316799695-31376-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add support for the msi-address-64 property of a PCI node.  This property
specifies the PCI address of MSIIR (message signaled interrupt index
register).

In commit 3da34aae ("powerpc/fsl: Support unique MSI addresses per PCIe Root
Complex"), the msi_addr_hi/msi_addr_lo fields of struct fsl_msi were redefined
from an actual address to just an offset, but the fields were not renamed
accordingly.  These fields are replace with a single field, msiir_offset,
to reflect the new meaning.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

This patch is necessary, but not sufficient, for MSI support under the
Freescale hypervisor.  Future patches will add full support.

 .../devicetree/bindings/powerpc/fsl/msi-pic.txt    |   42 ++++++++++++++++++++
 arch/powerpc/sysdev/fsl_msi.c                      |   20 +++++++---
 arch/powerpc/sysdev/fsl_msi.h                      |    3 +-
 3 files changed, 57 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/msi-pic.txt b/Documentation/devicetree/bindings/powerpc/fsl/msi-pic.txt
index 70558c3..5d586e1 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/msi-pic.txt
+++ b/Documentation/devicetree/bindings/powerpc/fsl/msi-pic.txt
@@ -25,6 +25,16 @@ Required properties:
   are routed to IPIC, and for 85xx/86xx cpu the interrupts are routed
   to MPIC.
 
+Optional properties:
+- msi-address-64: 64-bit PCI address of the MSIIR register. The MSIIR register
+  is used for MSI messaging.  The address of MSIIR in PCI address space is
+  the MSI message address.
+
+  This property may be used in virtualized environments where the hypervisor
+  has created an alternate mapping for the MSIR block.  See below for an
+  explanation.
+
+
 Example:
 	msi@41600 {
 		compatible = "fsl,mpc8610-msi", "fsl,mpic-msi";
@@ -41,3 +51,35 @@ Example:
 			0xe7 0>;
 		interrupt-parent = <&mpic>;
 	};
+
+The Freescale hypervisor and msi-address-64
+-------------------------------------------
+Normally, PCI devices have access to all of CCSR via an ATMU mapping.  The
+Freescale MSI driver calculates the address of MSIIR (in the MSI register
+block) and sets that address as the MSI message address.
+
+In a virtualized environment, the hypervisor may need to create an IOMMU
+mapping for MSIIR.  The Freescale ePAPR hypervisor has this requirement
+because of hardware limitations of the Peripheral Access Management Unit
+(PAMU), which is currently the only IOMMU that the hypervisor supports.
+The ATMU is programmed with the guest physical address, and the PAMU
+intercepts transactions and reroutes them to the true physical address.
+
+In the PAMU, each PCI controller is given only one primary window.  The
+PAMU restricts DMA operations so that they can only occur within a window.
+Because PCI devices must be able to DMA to memory, the primary window must
+be used to cover all of the guest's memory space.
+
+PAMU primary windows can be divided into 256 subwindows, and each
+subwindow can have its own address mapping ("guest physical" to "true
+physical").  However, each subwindow has to have the same alignment, which
+means they cannot be located at just any address.  Because of these
+restrictions, it is usually impossible to create a 4KB subwindow that
+covers MSIIR where it's normally located.
+
+Therefore, the hypervisor has to create a subwindow inside the same
+primary window used for memory, but mapped to the MSIR block (where MSIIR
+lives).  The first subwindow after the end of guest memory is used for
+this.  The address specified in the msi-address-64 property is the PCI
+address of MSIIR.  The hypervisor configures the PAMU to map that address to
+the true physical address of MSIIR.
diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 1cca251..e5c344d 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -30,7 +30,7 @@ LIST_HEAD(msi_head);
 
 struct fsl_msi_feature {
 	u32 fsl_pic_ip;
-	u32 msiir_offset;
+	u32 msiir_offset; /* Offset of MSIIR, relative to start of MSIR bank */
 };
 
 struct fsl_msi_cascade_data {
@@ -126,10 +126,19 @@ static void fsl_compose_msi_msg(struct pci_dev *pdev, int hwirq,
 {
 	struct fsl_msi *msi_data = fsl_msi_data;
 	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
-	u64 base = fsl_pci_immrbar_base(hose);
+	u64 address; /* Physical address of the MSIIR */
+	int len;
+	const u64 *reg;
+
+	/* If the msi-address-64 property exists, then use it */
+	reg = of_get_property(hose->dn, "msi-address-64", &len);
+	if (reg && (len == sizeof(u64)))
+		address = be64_to_cpup(reg);
+	else
+		address = fsl_pci_immrbar_base(hose) + msi_data->msiir_offset;
 
-	msg->address_lo = msi_data->msi_addr_lo + lower_32_bits(base);
-	msg->address_hi = msi_data->msi_addr_hi + upper_32_bits(base);
+	msg->address_lo = lower_32_bits(address);
+	msg->address_hi = upper_32_bits(address);
 
 	msg->data = hwirq;
 
@@ -359,8 +368,7 @@ static int __devinit fsl_of_msi_probe(struct platform_device *dev)
 
 	msi->irqhost->host_data = msi;
 
-	msi->msi_addr_hi = 0x0;
-	msi->msi_addr_lo = features->msiir_offset + (res.start & 0xfffff);
+	msi->msiir_offset = features->msiir_offset + (res.start & 0xfffff);
 
 	rc = fsl_msi_init_allocator(msi);
 	if (rc) {
diff --git a/arch/powerpc/sysdev/fsl_msi.h b/arch/powerpc/sysdev/fsl_msi.h
index 624580c..1313abb 100644
--- a/arch/powerpc/sysdev/fsl_msi.h
+++ b/arch/powerpc/sysdev/fsl_msi.h
@@ -28,8 +28,7 @@ struct fsl_msi {
 
 	unsigned long cascade_irq;
 
-	u32 msi_addr_lo;
-	u32 msi_addr_hi;
+	u32 msiir_offset; /* Offset of MSIIR, relative to start of CCSR */
 	void __iomem *msi_regs;
 	u32 feature;
 	int msi_virqs[NR_MSI_REG];
-- 
1.7.3.4
