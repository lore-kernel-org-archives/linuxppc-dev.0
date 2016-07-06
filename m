Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlCst5qRNzDr3S
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 07:04:02 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u66KrnI3078721
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 17:04:00 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2415xkg9hm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Jul 2016 17:04:00 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Wed, 6 Jul 2016 18:03:57 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id D9F65352006E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 17:03:36 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u66L3sAg4689942
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 18:03:54 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u66L3rX2017684
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 18:03:54 -0300
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
To: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Cc: Jonathan Corbet <corbet@lwn.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 Russell King <rmk+kernel@arm.linux.org.uk>,
 Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 2/3] nvme: implement DMA_ATTR_NO_WARN
Date: Wed,  6 Jul 2016 18:03:32 -0300
In-Reply-To: <1467839013-22481-1-git-send-email-mauricfo@linux.vnet.ibm.com>
References: <1467839013-22481-1-git-send-email-mauricfo@linux.vnet.ibm.com>
Message-Id: <1467839013-22481-3-git-send-email-mauricfo@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use the DMA_ATTR_NO_WARN attribute on dma_map_sg() calls of nvme driver.

Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
---
 drivers/nvme/host/pci.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d1a8259..c3c3348 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -18,6 +18,7 @@
 #include <linux/blk-mq.h>
 #include <linux/cpu.h>
 #include <linux/delay.h>
+#include <linux/dma-attrs.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/genhd.h>
@@ -65,6 +66,8 @@ MODULE_PARM_DESC(use_cmb_sqes, "use controller's memory buffer for I/O SQes");
 
 static struct workqueue_struct *nvme_workq;
 
+static DEFINE_DMA_ATTRS(nvme_dma_attrs);
+
 struct nvme_dev;
 struct nvme_queue;
 
@@ -498,7 +501,7 @@ static int nvme_map_data(struct nvme_dev *dev, struct request *req,
 		goto out;
 
 	ret = BLK_MQ_RQ_QUEUE_BUSY;
-	if (!dma_map_sg(dev->dev, iod->sg, iod->nents, dma_dir))
+	if (!dma_map_sg_attrs(dev->dev, iod->sg, iod->nents, dma_dir, &nvme_dma_attrs))
 		goto out;
 
 	if (!nvme_setup_prps(dev, req, size))
@@ -516,7 +519,7 @@ static int nvme_map_data(struct nvme_dev *dev, struct request *req,
 		if (rq_data_dir(req))
 			nvme_dif_remap(req, nvme_dif_prep);
 
-		if (!dma_map_sg(dev->dev, &iod->meta_sg, 1, dma_dir))
+		if (!dma_map_sg_attrs(dev->dev, &iod->meta_sg, 1, dma_dir, &nvme_dma_attrs))
 			goto out_unmap;
 	}
 
@@ -2118,6 +2121,9 @@ static int __init nvme_init(void)
 	result = pci_register_driver(&nvme_driver);
 	if (result)
 		destroy_workqueue(nvme_workq);
+
+	dma_set_attr(DMA_ATTR_NO_WARN, &nvme_dma_attrs);
+
 	return result;
 }
 
-- 
1.8.3.1
