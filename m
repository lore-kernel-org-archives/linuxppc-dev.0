Return-Path: <desnesn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ydb4q21vxzDrD6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 22:10:34 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAHB9FRF045226
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 06:10:32 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e9vce63gw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 06:10:32 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <desnesn@linux.vnet.ibm.com>;
 Fri, 17 Nov 2017 04:10:31 -0700
From: Desnes Augusto Nunes do Rosario <desnesn@linux.vnet.ibm.com>
To: netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, tlfalcon@linux.vnet.ibm.com,
 nfont@linux.vnet.ibm.com, jallen@linux.vnet.ibm.com
Subject: [PATCH] [net] ibmvnic: fix dma_mapping_error call
Date: Fri, 17 Nov 2017 09:09:04 -0200
Message-Id: <20171117110904.9797-1-desnesn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch fixes the dma_mapping_error call to use the correct dma_addr
which is inside the ibmvnic_vpd struct. Moreover, it fixes an uninitialized
warning regarding a local dma_addr variable which is not used anymore.

Fixes: 4e6759be28e4 ("ibmvnic: Feature implementation of VPD for the ibmvnic driver")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Desnes A. Nunes do Rosario <desnesn@linux.vnet.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 04aaacb..1dc4aef 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -849,7 +849,6 @@ static int ibmvnic_get_vpd(struct ibmvnic_adapter *adapter)
 {
 	struct device *dev = &adapter->vdev->dev;
 	union ibmvnic_crq crq;
-	dma_addr_t dma_addr;
 	int len = 0;
 
 	if (adapter->vpd->buff)
@@ -879,7 +878,7 @@ static int ibmvnic_get_vpd(struct ibmvnic_adapter *adapter)
 	adapter->vpd->dma_addr =
 		dma_map_single(dev, adapter->vpd->buff, adapter->vpd->len,
 			       DMA_FROM_DEVICE);
-	if (dma_mapping_error(dev, dma_addr)) {
+	if (dma_mapping_error(dev, adapter->vpd->dma_addr)) {
 		dev_err(dev, "Could not map VPD buffer\n");
 		kfree(adapter->vpd->buff);
 		return -ENOMEM;
-- 
2.9.5
