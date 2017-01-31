Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCd0h137NzDqDq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 07:20:04 +1100 (AEDT)
Subject: [PATCH 1 1/4] PCI: hisi: Use of_device_get_match_data() to simplify
 probe
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org
Cc: Scott Branden <sbranden@broadcom.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 linuxppc-dev@lists.ozlabs.org, linux-renesas-soc@vger.kernel.org,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Simon Horman <horms@verge.net.au>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com,
 Mingkai Hu <mingkai.hu@freescale.com>, Roy Zang <tie-fei.zang@freescale.com>,
 Shailendra Verma <shailendra.v@samsung.com>
Date: Tue, 31 Jan 2017 14:19:59 -0600
Message-ID: <20170131201958.27605.54898.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170131201400.27605.56002.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20170131201400.27605.56002.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Shailendra Verma <shailendra.v@samsung.com>

The only way to call hisi_pcie_probe() is to match an entry in
hisi_pcie_of_match[], so match cannot be NULL.

Use of_device_get_match_data() to retrieve the soc_ops pointer.  No
functional change intended.

[bhelgaas: use of_device_get_match_data(), changelog]
Based-on-suggestion-from: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Shailendra Verma <shailendra.v@samsung.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-hisi.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
index a301a7187b30..33c201afdbf1 100644
--- a/drivers/pci/host/pcie-hisi.c
+++ b/drivers/pci/host/pcie-hisi.c
@@ -139,7 +139,7 @@ struct hisi_pcie {
 	struct pcie_port pp;		/* pp.dbi_base is DT rc_dbi */
 	struct regmap *subctrl;
 	u32 port_id;
-	struct pcie_soc_ops *soc_ops;
+	const struct pcie_soc_ops *soc_ops;
 };
 
 /* HipXX PCIe host only supports 32-bit config access */
@@ -259,7 +259,6 @@ static int hisi_pcie_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct hisi_pcie *hisi_pcie;
 	struct pcie_port *pp;
-	const struct of_device_id *match;
 	struct resource *reg;
 	struct device_driver *driver;
 	int ret;
@@ -272,11 +271,10 @@ static int hisi_pcie_probe(struct platform_device *pdev)
 	pp->dev = dev;
 	driver = dev->driver;
 
-	match = of_match_device(driver->of_match_table, dev);
-	hisi_pcie->soc_ops = (struct pcie_soc_ops *) match->data;
+	hisi_pcie->soc_ops = of_device_get_match_data(dev);
 
 	hisi_pcie->subctrl =
-	syscon_regmap_lookup_by_compatible("hisilicon,pcie-sas-subctrl");
+	    syscon_regmap_lookup_by_compatible("hisilicon,pcie-sas-subctrl");
 	if (IS_ERR(hisi_pcie->subctrl)) {
 		dev_err(dev, "cannot get subctrl base\n");
 		return PTR_ERR(hisi_pcie->subctrl);
