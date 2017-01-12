Return-Path: <kishon@ti.com>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com [198.47.27.77])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzj4W0DQpzDqJg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 21:42:02 +1100 (AEDT)
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@axis.com>, <linux-arm-msm@vger.kernel.org>,
 <nsekhar@ti.com>, <kishon@ti.com>
Subject: [PATCH 23/37] PCI: dwc: Add *ops* to start and stop pcie link
Date: Thu, 12 Jan 2017 15:56:12 +0530
Message-ID: <1484216786-17292-24-git-send-email-kishon@ti.com>
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

Add start_link and stop_link ops in dw_pcie_ops to start or stop
the link. This will be used by endpoint functions to start the
link once the setup has been done.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/dwc/pcie-designware.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
index 0ef6ae7..25b3b8b 100644
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
@@ -149,6 +149,8 @@ struct dw_pcie_ops {
 	void	(*write_dbi)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
 			     int size, u32 val);
 	int	(*link_up)(struct dw_pcie *pcie);
+	int	(*start_link)(struct dw_pcie *pcie);
+	void	(*stop_link)(struct dw_pcie *pcie);
 };
 
 struct dw_pcie {
-- 
1.7.9.5
