Return-Path: <Varun.Sethi@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0237.outbound.protection.outlook.com [207.46.163.237])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 328051A0941
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 04:16:03 +1000 (EST)
From: Varun Sethi <Varun.Sethi@freescale.com>
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <alex.williamson@redhat.com>
Subject: [PATCH 3/3] iommu/fsl: Fix the error condition during iommu group
Date: Tue, 24 Jun 2014 19:27:17 +0530
Message-ID: <1403618237-26248-4-git-send-email-Varun.Sethi@freescale.com>
In-Reply-To: <1403618237-26248-1-git-send-email-Varun.Sethi@freescale.com>
References: <1403618237-26248-1-git-send-email-Varun.Sethi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Varun Sethi <Varun.Sethi@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Earlier PTR_ERR was being returned even if group was set to null.
Now, we explicitly set an ERR_PTR value in case the group  pointer is
NULL.

Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
---
 drivers/iommu/fsl_pamu_domain.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 54060d1..af47648 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -1037,12 +1037,15 @@ root_bus:
 			group = get_shared_pci_device_group(pdev);
 	}
 
+	if (!group)
+		group = ERR_PTR(-ENODEV);
+
 	return group;
 }
 
 static int fsl_pamu_add_device(struct device *dev)
 {
-	struct iommu_group *group = NULL;
+	struct iommu_group *group = ERR_PTR(-ENODEV);
 	struct pci_dev *pdev;
 	const u32 *prop;
 	int ret, len;
@@ -1065,7 +1068,7 @@ static int fsl_pamu_add_device(struct device *dev)
 			group = get_device_iommu_group(dev);
 	}
 
-	if (!group || IS_ERR(group))
+	if (IS_ERR(group))
 		return PTR_ERR(group);
 
 	ret = iommu_group_add_device(group, dev);
-- 
1.7.9.5
