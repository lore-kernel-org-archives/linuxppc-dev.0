Return-Path: <kishon@ti.com>
Received: from fllnx210.ext.ti.com (fllnx210.ext.ti.com [198.47.19.17])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPH8J4bMHzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 00:30:08 +1100 (AEDT)
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@axis.com>
CC: Joao Pinto <Joao.Pinto@synopsys.com>, <nsekhar@ti.com>, Kishon Vijay
 Abraham I <kishon@ti.com>
Subject: [PATCH 1/4] PCI: dwc: designware: Add new *ops* for cpu addr fixup
Date: Thu, 16 Feb 2017 18:59:09 +0530
Message-ID: <1487251752-12478-2-git-send-email-kishon@ti.com>
In-Reply-To: <1487251752-12478-1-git-send-email-kishon@ti.com>
References: <1487251752-12478-1-git-send-email-kishon@ti.com>
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

Some platforms (like dra7xx) require only the least 28 bits of the
corresponding 32 bit CPU address to be programmed in the address
translation unit. This modified address is stored in io_base/mem_base/
cfg0_base/cfg1_base in dra7xx_pcie_host_init. While this is okay for
host mode where the address range is fixed, device mode requires
different addresses to be programmed based on the host buffer address.
Add a new ops to get the least 28 bits of the corresponding 32 bit
CPU address and invoke it before programming the address translation
unit.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/dwc/pcie-designware.c |    3 +++
 drivers/pci/dwc/pcie-designware.h |    1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-designware.c
index 7e1fb7d..14ee7a3 100644
--- a/drivers/pci/dwc/pcie-designware.c
+++ b/drivers/pci/dwc/pcie-designware.c
@@ -97,6 +97,9 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
 {
 	u32 retries, val;
 
+	if (pp->ops->cpu_addr_fixup)
+		cpu_addr = pp->ops->cpu_addr_fixup(cpu_addr);
+
 	if (pci->iatu_unroll_enabled) {
 		dw_pcie_writel_unroll(pci, index, PCIE_ATU_UNR_LOWER_BASE,
 				      lower_32_bits(cpu_addr));
diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
index cd3b871..8f3dcb2 100644
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
@@ -143,6 +143,7 @@ struct pcie_port {
 };
 
 struct dw_pcie_ops {
+	u64	(*cpu_addr_fixup)(u64 cpu_addr);
 	u32	(*readl_dbi)(struct dw_pcie *pcie, u32 reg);
 	void	(*writel_dbi)(struct dw_pcie *pcie, u32 reg, u32 val);
 	int	(*link_up)(struct dw_pcie *pcie);
-- 
1.7.9.5
