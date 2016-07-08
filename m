Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rmDK10DWqzDqvs
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 22:27:32 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u68COGTN117062
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jul 2016 08:27:31 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2415xqa78u-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Jul 2016 08:27:30 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Fri, 8 Jul 2016 09:27:28 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 4A0433520068
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 08:27:08 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u68CRPid29884680
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jul 2016 09:27:25 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u68CROkM015077
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jul 2016 09:27:25 -0300
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
To: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Cc: Jonathan Corbet <corbet@lwn.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 Russell King <rmk+kernel@arm.linux.org.uk>,
 Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v3 2/3] nvme: implement DMA_ATTR_NO_WARN
Date: Fri,  8 Jul 2016 09:27:07 -0300
In-Reply-To: <1467980828-5282-1-git-send-email-mauricfo@linux.vnet.ibm.com>
References: <1467980828-5282-1-git-send-email-mauricfo@linux.vnet.ibm.com>
Message-Id: <1467980828-5282-3-git-send-email-mauricfo@linux.vnet.ibm.com>
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
Reviewed-by: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
---
Changelog:
 v3:
  - nvme: use DMA_ATTR_NO_WARN when ret = BLK_MQ_RQ_QUEUE_BUSY (io will be
    requeued) but not when ret = BLK_MQ_RQ_QUEUE_ERROR (io will be failed).
    thanks: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
 v2:
  - all: address warnings from checkpatch.pl (line wrapping and typos)

 drivers/nvme/host/pci.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d1a8259..187aa6b 100644
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
 
@@ -498,7 +501,8 @@ static int nvme_map_data(struct nvme_dev *dev, struct request *req,
 		goto out;
 
 	ret = BLK_MQ_RQ_QUEUE_BUSY;
-	if (!dma_map_sg(dev->dev, iod->sg, iod->nents, dma_dir))
+	if (!dma_map_sg_attrs(dev->dev, iod->sg, iod->nents, dma_dir,
+				&nvme_dma_attrs))
 		goto out;
 
 	if (!nvme_setup_prps(dev, req, size))
@@ -2118,6 +2122,9 @@ static int __init nvme_init(void)
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
