Return-Path: <kishon@ti.com>
Received: from fllnx209.ext.ti.com (fllnx209.ext.ti.com [198.47.19.16])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzkYs0HmkzDqMf
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 22:49:04 +1100 (AEDT)
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@axis.com>, <linux-arm-msm@vger.kernel.org>,
 <nsekhar@ti.com>, <kishon@ti.com>
Subject: [PATCH 02/37] PCI: dwc: designware: Add new *ops* for cpu addr fixup
Date: Thu, 12 Jan 2017 15:55:51 +0530
Message-ID: <1484216786-17292-3-git-send-email-kishon@ti.com>
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
index bed1999..d68bc7b 100644
--- a/drivers/pci/dwc/pcie-designware.c
+++ b/drivers/pci/dwc/pcie-designware.c
@@ -195,6 +195,9 @@ static void dw_pcie_prog_outbound_atu(struct pcie_port *pp, int index,
 {
 	u32 retries, val;
 
+	if (pp->ops->cpu_addr_fixup)
+		cpu_addr = pp->ops->cpu_addr_fixup(cpu_addr);
+
 	if (pp->iatu_unroll_enabled) {
 		dw_pcie_writel_unroll(pp, index, PCIE_ATU_UNR_LOWER_BASE,
 			lower_32_bits(cpu_addr));
diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
index a567ea2..32f4602 100644
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
@@ -54,6 +54,7 @@ struct pcie_port {
 };
 
 struct pcie_host_ops {
+	u64 (*cpu_addr_fixup)(u64 cpu_addr);
 	u32 (*readl_rc)(struct pcie_port *pp, u32 reg);
 	void (*writel_rc)(struct pcie_port *pp, u32 reg, u32 val);
 	int (*rd_own_conf)(struct pcie_port *pp, int where, int size, u32 *val);
-- 
1.7.9.5
