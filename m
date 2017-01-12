Return-Path: <kishon@ti.com>
Received: from lelnx194.ext.ti.com (lelnx194.ext.ti.com [198.47.27.80])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzm3m2W03zDqk1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 23:56:36 +1100 (AEDT)
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@axis.com>, <linux-arm-msm@vger.kernel.org>,
 <nsekhar@ti.com>, <kishon@ti.com>
Subject: [PATCH 26/37] PCI: dwc: dra7xx: Facilitate wrapper and msi interrupts
 to be enabled independently
Date: Thu, 12 Jan 2017 15:56:15 +0530
Message-ID: <1484216786-17292-27-git-send-email-kishon@ti.com>
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

No functional change. Split dra7xx_pcie_enable_interrupts into
dra7xx_pcie_enable_wrapper_interrupts and dra7xx_pcie_enable_msi_interrupts
so that wrapper interrupts and msi interrupts can be enabled independently.
This is in preparation for adding EP mode support to dra7xx driver since
EP mode doesn't have to enable msi_interrupts.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/dwc/pci-dra7xx.c |   24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index 8a1fccd..eb3a9c6 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -140,18 +140,30 @@ static int dra7xx_pcie_establish_link(struct dra7xx_pcie *dra7xx)
 	return dw_pcie_wait_for_link(pci);
 }
 
-static void dra7xx_pcie_enable_interrupts(struct dra7xx_pcie *dra7xx)
+static void dra7xx_pcie_enable_msi_interrupts(struct dra7xx_pcie *dra7xx)
 {
-	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN,
-			   ~INTERRUPTS);
-	dra7xx_pcie_writel(dra7xx,
-			   PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MAIN, INTERRUPTS);
 	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI,
 			   ~LEG_EP_INTERRUPTS & ~MSI);
-	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MSI,
+
+	dra7xx_pcie_writel(dra7xx,
+			   PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MSI,
 			   MSI | LEG_EP_INTERRUPTS);
 }
 
+static void dra7xx_pcie_enable_wrapper_interrupts(struct dra7xx_pcie *dra7xx)
+{
+	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN,
+			   ~INTERRUPTS);
+	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MAIN,
+			   INTERRUPTS);
+}
+
+static void dra7xx_pcie_enable_interrupts(struct dra7xx_pcie *dra7xx)
+{
+	dra7xx_pcie_enable_wrapper_interrupts(dra7xx);
+	dra7xx_pcie_enable_msi_interrupts(dra7xx);
+}
+
 static void dra7xx_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-- 
1.7.9.5
