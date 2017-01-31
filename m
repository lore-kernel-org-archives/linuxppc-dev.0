Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCd0y204czDqGW
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 07:20:18 +1100 (AEDT)
Subject: [PATCH 1 3/4] PCI: layerscape: Use of_device_get_match_data() to
 simplify probe
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
Date: Tue, 31 Jan 2017 14:20:13 -0600
Message-ID: <20170131202013.27605.44566.stgit@bhelgaas-glaptop.roam.corp.google.com>
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

The only way to call ls_pcie_probe() is to match an entry in
ls_pcie_of_match[], so match cannot be NULL.

Use of_device_get_match_data() to retrieve the drvdata pointer.  No
functional change intended.

Based-on-suggestion-from: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-layerscape.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index ea789138531b..c1f06f8f05fd 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -239,23 +239,18 @@ static int __init ls_add_pcie_port(struct ls_pcie *pcie)
 static int __init ls_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	const struct of_device_id *match;
 	struct ls_pcie *pcie;
 	struct pcie_port *pp;
 	struct resource *dbi_base;
 	int ret;
 
-	match = of_match_device(ls_pcie_of_match, dev);
-	if (!match)
-		return -ENODEV;
-
 	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
 		return -ENOMEM;
 
 	pp = &pcie->pp;
 	pp->dev = dev;
-	pcie->drvdata = match->data;
+	pcie->drvdata = of_device_get_match_data(dev);
 	pp->ops = pcie->drvdata->ops;
 
 	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
