Return-Path: <chrisp@alliedtelesis.co.nz>
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [202.36.163.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wT4QX5yJ0zDqLs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 May 2017 18:40:52 +1000 (AEST)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: bp@alien8.de,
	mchehab@kernel.org,
	linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au, Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 2/3] EDAC: mv64x60: Fix pdata->name
Date: Thu, 18 May 2017 20:31:34 +1200
Message-Id: <20170518083135.28048-3-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20170518083135.28048-1-chris.packham@alliedtelesis.co.nz>
References: <20170518083135.28048-1-chris.packham@alliedtelesis.co.nz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Change this from mpc85xx_pci_err to mv64x60_pci_err.  The former is
likely a hangover from when this driver was created.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/edac/mv64x60_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/mv64x60_edac.c b/drivers/edac/mv64x60_edac.c
index 454e1e26ee7c..ddc5082f7577 100644
--- a/drivers/edac/mv64x60_edac.c
+++ b/drivers/edac/mv64x60_edac.c
@@ -116,7 +116,7 @@ static int mv64x60_pci_err_probe(struct platform_device *pdev)
 	pdata = pci->pvt_info;
 
 	pdata->pci_hose = pdev->id;
-	pdata->name = "mpc85xx_pci_err";
+	pdata->name = "mv64x60_pci_err";
 	platform_set_drvdata(pdev, pci);
 	pci->dev = &pdev->dev;
 	pci->dev_name = dev_name(&pdev->dev);
-- 
2.11.0.24.ge6920cf
