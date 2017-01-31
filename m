Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCd0q1Cn6zDqCp
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 07:20:11 +1100 (AEDT)
Subject: [PATCH 1 2/4] PCI: iproc: Use of_device_get_match_data() to
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
Date: Tue, 31 Jan 2017 14:20:06 -0600
Message-ID: <20170131202006.27605.98823.stgit@bhelgaas-glaptop.roam.corp.google.com>
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

The only way to call iproc_pcie_pltfm_probe() is to match an entry in
iproc_pcie_of_match_table[], so match cannot be NULL.

Use of_device_get_match_data() to retrieve the pcie->type.  No functional
change intended.

Based-on-suggestion-from: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-iproc-platform.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pci/host/pcie-iproc-platform.c b/drivers/pci/host/pcie-iproc-platform.c
index 22d814a78a78..f4909bb0b2ad 100644
--- a/drivers/pci/host/pcie-iproc-platform.c
+++ b/drivers/pci/host/pcie-iproc-platform.c
@@ -47,7 +47,6 @@ MODULE_DEVICE_TABLE(of, iproc_pcie_of_match_table);
 static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	const struct of_device_id *of_id;
 	struct iproc_pcie *pcie;
 	struct device_node *np = dev->of_node;
 	struct resource reg;
@@ -55,16 +54,12 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
 	LIST_HEAD(res);
 	int ret;
 
-	of_id = of_match_device(iproc_pcie_of_match_table, dev);
-	if (!of_id)
-		return -EINVAL;
-
 	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
 		return -ENOMEM;
 
 	pcie->dev = dev;
-	pcie->type = (enum iproc_pcie_type)of_id->data;
+	pcie->type = (enum iproc_pcie_type) of_device_get_match_data(dev);
 
 	ret = of_address_to_resource(np, 0, &reg);
 	if (ret < 0) {
