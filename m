Return-Path: <abounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6BE332C0085
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Aug 2012 06:36:11 +1000 (EST)
From: Alexandre Bounine <alexandre.bounine@idt.com>
To: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] rapidio/tsi721: fix unused variable compiler warning
Date: Wed, 15 Aug 2012 16:35:13 -0400
Message-Id: <1345062913-29590-1-git-send-email-alexandre.bounine@idt.com>
Cc: Alexandre Bounine <alexandre.bounine@idt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix unused variable compiler warning when built with CONFIG_RAPIDIO_DEBUG
option off.

This patch is applicable to kernel versions starting from v3.2

Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
Cc: Matt Porter <mporter@kernel.crashing.org>
---
 drivers/rapidio/devices/tsi721.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/rapidio/devices/tsi721.c b/drivers/rapidio/devices/tsi721.c
index c0d6a04..5d44252 100644
--- a/drivers/rapidio/devices/tsi721.c
+++ b/drivers/rapidio/devices/tsi721.c
@@ -2219,7 +2219,7 @@ static int __devinit tsi721_probe(struct pci_dev *pdev,
 				  const struct pci_device_id *id)
 {
 	struct tsi721_device *priv;
-	int i, cap;
+	int cap;
 	int err;
 	u32 regval;
 
@@ -2239,12 +2239,15 @@ static int __devinit tsi721_probe(struct pci_dev *pdev,
 	priv->pdev = pdev;
 
 #ifdef DEBUG
+	{
+	int i;
 	for (i = 0; i <= PCI_STD_RESOURCE_END; i++) {
 		dev_dbg(&pdev->dev, "res[%d] @ 0x%llx (0x%lx, 0x%lx)\n",
 			i, (unsigned long long)pci_resource_start(pdev, i),
 			(unsigned long)pci_resource_len(pdev, i),
 			pci_resource_flags(pdev, i));
 	}
+	}
 #endif
 	/*
 	 * Verify BAR configuration
-- 
1.7.8.4
