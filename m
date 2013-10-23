Return-Path: <B31939@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ACDD82C0374
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Oct 2013 21:41:55 +1100 (EST)
From: Minghuan Lian <Minghuan.Lian@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 03/12][v3] pci: fsl: add PCI indirect access support
Date: Wed, 23 Oct 2013 18:41:25 +0800
Message-ID: <1382524894-15164-3-git-send-email-Minghuan.Lian@freescale.com>
In-Reply-To: <1382524894-15164-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1382524894-15164-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>, linux-pci@vger.kernel.org,
 Zang Roy-R61911 <r61911@freescale.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch adds PCI indirect read/write functions. The main code
is ported from arch/powerpc/sysdev/indirect_pci.c. We use general
IO API iowrite32be/ioread32be instead of out_be32/in_be32, and
use structure fsl_Pci instead of PowerPC's pci_controller.
The patch also provides fsl_pcie_check_link() to check PCI link.
The weak function fsl_arch_pci_exclude_device() is provided to
call ppc_md.pci_exclude_device() for PowerPC architecture.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
change log:
v1-v3:
Derived from http://patchwork.ozlabs.org/patch/278965/

Based on upstream master.
Based on the discussion of RFC version here
http://patchwork.ozlabs.org/patch/274487/

 drivers/pci/host/pci-fsl-common.c | 169 ++++++++++++++++++++++++++++++++------
 include/linux/fsl/pci-common.h    |   6 ++
 2 files changed, 151 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/host/pci-fsl-common.c b/drivers/pci/host/pci-fsl-common.c
index 69d338b..8bc9a64 100644
--- a/drivers/pci/host/pci-fsl-common.c
+++ b/drivers/pci/host/pci-fsl-common.c
@@ -35,52 +35,173 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
-static int fsl_pcie_check_link(struct pci_controller *hose)
+/* Indirect type */
+#define INDIRECT_TYPE_EXT_REG			0x00000002
+#define INDIRECT_TYPE_SURPRESS_PRIMARY_BUS	0x00000004
+#define INDIRECT_TYPE_NO_PCIE_LINK		0x00000008
+#define INDIRECT_TYPE_BIG_ENDIAN		0x00000010
+#define INDIRECT_TYPE_FSL_CFG_REG_LINK		0x00000040
+
+int __weak fsl_arch_pci_exclude_device(struct fsl_pci *pci, u8 bus, u8 devfn)
+{
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int fsl_pci_read_config(struct fsl_pci *pci, int bus, int devfn,
+				int offset, int len, u32 *val)
+{
+	u32 bus_no, reg, data;
+
+	if (pci->indirect_type & INDIRECT_TYPE_NO_PCIE_LINK) {
+		if (bus != pci->first_busno)
+			return PCIBIOS_DEVICE_NOT_FOUND;
+		if (devfn != 0)
+			return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+
+	if (fsl_arch_pci_exclude_device(pci, bus, devfn))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	bus_no = (bus == pci->first_busno) ? pci->self_busno : bus;
+
+	if (pci->indirect_type & INDIRECT_TYPE_EXT_REG)
+		reg = ((offset & 0xf00) << 16) | (offset & 0xfc);
+	else
+		reg = offset & 0xfc;
+
+	if (pci->indirect_type & INDIRECT_TYPE_BIG_ENDIAN)
+		iowrite32be(0x80000000 | (bus_no << 16) | (devfn << 8) | reg,
+			    &pci->regs->config_addr);
+	else
+		iowrite32(0x80000000 | (bus_no << 16) | (devfn << 8) | reg,
+			  &pci->regs->config_addr);
+
+	/*
+	 * Note: the caller has already checked that offset is
+	 * suitably aligned and that len is 1, 2 or 4.
+	 */
+	data = ioread32(&pci->regs->config_data);
+	switch (len) {
+	case 1:
+		*val = (data >> (8 * (offset & 3))) & 0xff;
+		break;
+	case 2:
+		*val = (data >> (8 * (offset & 3))) & 0xffff;
+		break;
+	default:
+		*val = data;
+		break;
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int fsl_pci_write_config(struct fsl_pci *pci, int bus, int devfn,
+				 int offset, int len, u32 val)
+{
+	void __iomem *cfg_data;
+	u32 bus_no, reg;
+
+	if (pci->indirect_type & INDIRECT_TYPE_NO_PCIE_LINK) {
+		if (bus != pci->first_busno)
+			return PCIBIOS_DEVICE_NOT_FOUND;
+		if (devfn != 0)
+			return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+
+	if (fsl_arch_pci_exclude_device(pci, bus, devfn))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	bus_no = (bus == pci->first_busno) ?
+			pci->self_busno : bus;
+
+	if (pci->indirect_type & INDIRECT_TYPE_EXT_REG)
+		reg = ((offset & 0xf00) << 16) | (offset & 0xfc);
+	else
+		reg = offset & 0xfc;
+
+	if (pci->indirect_type & INDIRECT_TYPE_BIG_ENDIAN)
+		iowrite32be(0x80000000 | (bus_no << 16) | (devfn << 8) | reg,
+			    &pci->regs->config_addr);
+	else
+		iowrite32(0x80000000 | (bus_no << 16) | (devfn << 8) | reg,
+			  &pci->regs->config_addr);
+
+	/* suppress setting of PCI_PRIMARY_BUS */
+	if (pci->indirect_type & INDIRECT_TYPE_SURPRESS_PRIMARY_BUS)
+		if ((offset == PCI_PRIMARY_BUS) &&
+		    (bus == pci->first_busno))
+			val &= 0xffffff00;
+
+	/*
+	 * Note: the caller has already checked that offset is
+	 * suitably aligned and that len is 1, 2 or 4.
+	 */
+	cfg_data = ((void *) &(pci->regs->config_data)) + (offset & 3);
+	switch (len) {
+	case 1:
+		iowrite8(val, cfg_data);
+		break;
+	case 2:
+		iowrite16(val, cfg_data);
+		break;
+	default:
+		iowrite32(val, cfg_data);
+		break;
+	}
+	return PCIBIOS_SUCCESSFUL;
+}
+
+bool fsl_pci_check_link(struct fsl_pci *pci)
 {
 	u32 val = 0;
 
-	if (hose->indirect_type & PPC_INDIRECT_TYPE_FSL_CFG_REG_LINK) {
-		if (hose->ops->read == fsl_indirect_read_config) {
-			struct pci_bus bus;
-			bus.number = hose->first_busno;
-			bus.sysdata = hose;
-			bus.ops = hose->ops;
-			indirect_read_config(&bus, 0, PCIE_LTSSM, 4, &val);
-		} else
-			early_read_config_dword(hose, 0, 0, PCIE_LTSSM, &val);
+	if (pci->indirect_type & INDIRECT_TYPE_FSL_CFG_REG_LINK) {
+		fsl_pci_read_config(pci, 0, 0, PCIE_LTSSM, 4, &val);
 		if (val < PCIE_LTSSM_L0)
-			return 1;
+			return false;
 	} else {
-		struct ccsr_pci __iomem *pci = hose->private_data;
 		/* for PCIe IP rev 3.0 or greater use CSR0 for link state */
-		val = (in_be32(&pci->pex_csr0) & PEX_CSR0_LTSSM_MASK)
+		val = (ioread32be(&pci->regs->pex_csr0) & PEX_CSR0_LTSSM_MASK)
 				>> PEX_CSR0_LTSSM_SHIFT;
 		if (val != PEX_CSR0_LTSSM_L0)
-			return 1;
+			return false;
 	}
 
-	return 0;
+	return true;
 }
 
 static int fsl_indirect_read_config(struct pci_bus *bus, unsigned int devfn,
 				    int offset, int len, u32 *val)
 {
-	struct pci_controller *hose = pci_bus_to_host(bus);
+	struct fsl_pci *pci = fsl_arch_sys_to_pci(bus->sysdata);
+
+	if (!pci)
+		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	if (fsl_pcie_check_link(hose))
-		hose->indirect_type |= PPC_INDIRECT_TYPE_NO_PCIE_LINK;
+	if (fsl_pci_check_link(pci))
+		pci->indirect_type &= ~INDIRECT_TYPE_NO_PCIE_LINK;
 	else
-		hose->indirect_type &= ~PPC_INDIRECT_TYPE_NO_PCIE_LINK;
+		pci->indirect_type |= INDIRECT_TYPE_NO_PCIE_LINK;
 
-	return indirect_read_config(bus, devfn, offset, len, val);
+	return fsl_pci_read_config(pci, bus->number, devfn, offset, len, val);
 }
 
-#if defined(CONFIG_FSL_SOC_BOOKE) || defined(CONFIG_PPC_86xx)
-
-static struct pci_ops fsl_indirect_pcie_ops =
+static int fsl_indirect_write_config(struct pci_bus *bus, unsigned int devfn,
+				     int offset, int len, u32 val)
 {
+	struct fsl_pci *pci = fsl_arch_sys_to_pci(bus->sysdata);
+
+	if (!pci)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	return fsl_pci_write_config(pci, bus->number, devfn,
+				     offset, len, val);
+}
+
+static struct pci_ops fsl_indirect_pci_ops = {
 	.read = fsl_indirect_read_config,
-	.write = indirect_write_config,
+	.write = fsl_indirect_write_config,
 };
 
 static int setup_one_atmu(struct ccsr_pci __iomem *pci,
diff --git a/include/linux/fsl/pci-common.h b/include/linux/fsl/pci-common.h
index e56a040..7df4355 100644
--- a/include/linux/fsl/pci-common.h
+++ b/include/linux/fsl/pci-common.h
@@ -143,5 +143,11 @@ struct fsl_pci {
  */
 extern struct fsl_pci *fsl_arch_sys_to_pci(void *sys);
 
+/* Return link status true -> link, false -> no link */
+bool fsl_pci_check_link(struct fsl_pci *pci);
+
+/* To avoid touching specified devices */
+int fsl_arch_pci_exclude_device(struct fsl_pci *pci, u8 bus, u8 devfn);
+
 #endif /* __PCI_COMMON_H */
 #endif /* __KERNEL__ */
-- 
1.8.1.2
