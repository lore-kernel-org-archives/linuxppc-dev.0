Return-Path: <kishon@ti.com>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com [198.47.27.77])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzj4X4bSKzDqJg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 21:42:04 +1100 (AEDT)
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@axis.com>, <linux-arm-msm@vger.kernel.org>,
 <nsekhar@ti.com>, <kishon@ti.com>
Subject: [PATCH 03/37] PCI: dwc: dra7xx: Populate cpu_addr_fixup ops
Date: Thu, 12 Jan 2017 15:55:52 +0530
Message-ID: <1484216786-17292-4-git-send-email-kishon@ti.com>
In-Reply-To: <1484216786-17292-1-git-send-email-kishon@ti.com>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Populate cpu_addr_fixup ops to extract the least 28 bits of the
corresponding cpu address.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/dwc/pci-dra7xx.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index fb37e09..2073d46 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -88,6 +88,11 @@ static inline void dra7xx_pcie_writel(struct dra7xx_pcie *pcie, u32 offset,
 	writel(value, pcie->base + offset);
 }
 
+static u64 dra7xx_pcie_cpu_addr_fixup(u64 pci_addr)
+{
+	return pci_addr & DRA7XX_CPU_TO_BUS_ADDR;
+}
+
 static int dra7xx_pcie_link_up(struct pcie_port *pp)
 {
 	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pp);
@@ -151,11 +156,6 @@ static void dra7xx_pcie_host_init(struct pcie_port *pp)
 {
 	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pp);
 
-	pp->io_base &= DRA7XX_CPU_TO_BUS_ADDR;
-	pp->mem_base &= DRA7XX_CPU_TO_BUS_ADDR;
-	pp->cfg0_base &= DRA7XX_CPU_TO_BUS_ADDR;
-	pp->cfg1_base &= DRA7XX_CPU_TO_BUS_ADDR;
-
 	dw_pcie_setup_rc(pp);
 
 	dra7xx_pcie_establish_link(dra7xx);
@@ -164,6 +164,7 @@ static void dra7xx_pcie_host_init(struct pcie_port *pp)
 }
 
 static struct pcie_host_ops dra7xx_pcie_host_ops = {
+	.cpu_addr_fixup = dra7xx_pcie_cpu_addr_fixup,
 	.link_up = dra7xx_pcie_link_up,
 	.host_init = dra7xx_pcie_host_init,
 };
-- 
1.7.9.5
