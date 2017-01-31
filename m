Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCd16036SzDqG4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 07:20:26 +1100 (AEDT)
Subject: [PATCH 1 4/4] PCI: rcar: Use of_device_get_match_data() to simplify
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
Date: Tue, 31 Jan 2017 14:20:20 -0600
Message-ID: <20170131202020.27605.39560.stgit@bhelgaas-glaptop.roam.corp.google.com>
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

This is a DT-only driver, so the only way to call rcar_pcie_probe() is to
match an entry in rcar_pcie_of_match[], so of_id cannot be NULL.

Furthermore, of_id->data can only be NULL if an rcar_pcie_of_match[] entry
has a NULL .data member.  That's a driver defect, and we don't want to
return -EINVAL, which is easy to ignore.  We'd rather take the NULL pointer
dereference so we notice the problem and fix it.

Use of_device_get_match_data() to retrieve the hw_init_fn pointer.  No
functional change intended.

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-rcar.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index aca85be101f8..b3b6d5273347 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -1125,7 +1125,6 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct rcar_pcie *pcie;
 	unsigned int data;
-	const struct of_device_id *of_id;
 	int err;
 	int (*hw_init_fn)(struct rcar_pcie *);
 
@@ -1149,11 +1148,6 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	of_id = of_match_device(rcar_pcie_of_match, dev);
-	if (!of_id || !of_id->data)
-		return -EINVAL;
-	hw_init_fn = of_id->data;
-
 	pm_runtime_enable(dev);
 	err = pm_runtime_get_sync(dev);
 	if (err < 0) {
@@ -1162,6 +1156,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	}
 
 	/* Failure to get a link might just be that no cards are inserted */
+	hw_init_fn = of_device_get_match_data(dev);
 	err = hw_init_fn(pcie);
 	if (err) {
 		dev_info(dev, "PCIe link down\n");
