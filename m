Return-Path: <pawel.moll@arm.com>
Received: from collaborate-mta1.arm.com (unknown [217.140.110.23])
 by lists.ozlabs.org (Postfix) with ESMTP id 70F251A03B0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Aug 2014 20:38:32 +1000 (EST)
From: Pawel Moll <pawel.moll@arm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 3/5 v2] mmc: sdhci-pltfm: Do not use parent as the host's
 device
Date: Tue, 12 Aug 2014 11:37:52 +0100
Message-Id: <1407839872-12864-1-git-send-email-pawel.moll@arm.com>
In-Reply-To: <CAPDyKFrb9OSbhHtn=wgbs9Yky1t453rdNBJVgGA62vER-65dYw@mail.gmail.com>
References: <CAPDyKFrb9OSbhHtn=wgbs9Yky1t453rdNBJVgGA62vER-65dYw@mail.gmail.com>
Cc: Pawel Moll <pawel.moll@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Anton Vorontsov <anton@enomsg.org>, linux-mmc@vger.kernel.org,
 Chris Ball <chris@printf.net>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The code selecting a device for the sdhci host has been
continuously tweaked (4b711cb13843f5082e82970dd1e8031383134a65
"mmc: sdhci-pltfm: Add structure for host-specific data" and
a4d2177f00a5252d825236c5124bc1e9918bdb41 "mmc: sdhci-pltfm: dt
device does not pass parent to sdhci_alloc_host" while there
does not seem to be any reason to use platform device's parent
in the first place.

The comment saying "Some PCI-based MFD need the parent here"
seem to refer to Timberdale FPGA driver (the only MFD driver
registering SDHCI cell, drivers/mfd/timberdale.c) but again,
the only situation when parent device matter is runtime PM,
which is not implemented for Timberdale.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/mmc/host/sdhci-pltfm.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 7e834fb..c5b01d6 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -123,7 +123,6 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 				    size_t priv_size)
 {
 	struct sdhci_host *host;
-	struct device_node *np = pdev->dev.of_node;
 	struct resource *iomem;
 	int ret;
 
@@ -136,13 +135,8 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 	if (resource_size(iomem) < 0x100)
 		dev_err(&pdev->dev, "Invalid iomem size!\n");
 
-	/* Some PCI-based MFD need the parent here */
-	if (pdev->dev.parent != &platform_bus && !np)
-		host = sdhci_alloc_host(pdev->dev.parent,
-			sizeof(struct sdhci_pltfm_host) + priv_size);
-	else
-		host = sdhci_alloc_host(&pdev->dev,
-			sizeof(struct sdhci_pltfm_host) + priv_size);
+	host = sdhci_alloc_host(&pdev->dev,
+		sizeof(struct sdhci_pltfm_host) + priv_size);
 
 	if (IS_ERR(host)) {
 		ret = PTR_ERR(host);
-- 
1.9.1
