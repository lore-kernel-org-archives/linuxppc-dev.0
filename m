Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3FKj6qtGzDqTy
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 09:05:13 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u71N4869146451
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 19:05:11 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24gr7vjrp0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Aug 2016 19:05:11 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Mon, 1 Aug 2016 20:05:09 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id B31771DC0051
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 19:04:58 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u71N57d828639722
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 20:05:07 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u71N576A023872
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 20:05:07 -0300
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] nvme: use the DMA_ATTR_NO_WARN attribute
Date: Mon,  1 Aug 2016 20:05:06 -0300
In-Reply-To: <1470092706-28075-1-git-send-email-mauricfo@linux.vnet.ibm.com>
References: <1470092706-28075-1-git-send-email-mauricfo@linux.vnet.ibm.com>
Message-Id: <1470092706-28075-4-git-send-email-mauricfo@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use the DMA_ATTR_NO_WARN attribute for the dma_map_sg() call of the nvme
driver that returns BLK_MQ_RQ_QUEUE_BUSY (not for BLK_MQ_RQ_QUEUE_ERROR).

Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Reviewed-by: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d7c33f9..eeaeae0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -503,7 +503,8 @@ static int nvme_map_data(struct nvme_dev *dev, struct request *req,
 		goto out;
 
 	ret = BLK_MQ_RQ_QUEUE_BUSY;
-	if (!dma_map_sg(dev->dev, iod->sg, iod->nents, dma_dir))
+	if (!dma_map_sg_attrs(dev->dev, iod->sg, iod->nents, dma_dir,
+				DMA_ATTR_NO_WARN))
 		goto out;
 
 	if (!nvme_setup_prps(dev, req, size))
-- 
1.8.3.1
