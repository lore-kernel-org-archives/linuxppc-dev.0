Return-Path: <weiyj.lk@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3syLqX1nGXzDvJx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2016 01:55:52 +1100 (AEDT)
Received: by mail-pa0-x241.google.com with SMTP id fn2so8414775pad.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Oct 2016 07:55:52 -0700 (PDT)
From: Wei Yongjun <weiyj.lk@gmail.com>
To: Minghuan Lian <minghuan.Lian@freescale.com>,
 Mingkai Hu <mingkai.hu@freescale.com>,
 Roy Zang <tie-fei.zang@freescale.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH -next] PCI: layerscape: Remove redundant dev_err call in
 ls_pcie_probe()
Date: Mon, 17 Oct 2016 14:55:40 +0000
Message-Id: <1476716140-30608-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wei Yongjun <weiyongjun1@huawei.com>

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/pci/host/pci-layerscape.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index 2cb7315..bbd3d23 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -251,10 +251,8 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 
 	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
 	pcie->pp.dbi_base = devm_ioremap_resource(dev, dbi_base);
-	if (IS_ERR(pcie->pp.dbi_base)) {
-		dev_err(dev, "missing *regs* space\n");
+	if (IS_ERR(pcie->pp.dbi_base))
 		return PTR_ERR(pcie->pp.dbi_base);
-	}
 
 	pcie->drvdata = match->data;
 	pcie->lut = pcie->pp.dbi_base + pcie->drvdata->lut_offset;
