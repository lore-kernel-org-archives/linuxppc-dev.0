Return-Path: <weiyj.lk@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sK7td35r5zDrJy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Aug 2016 23:48:25 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id y134so1281583pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Aug 2016 06:48:25 -0700 (PDT)
From: Wei Yongjun <weiyj.lk@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org
Subject: [PATCH -next] ibmvnic: fix error return code in ibmvnic_probe()
Date: Wed, 24 Aug 2016 13:47:58 +0000
Message-Id: <1472046478-1427-1-git-send-email-weiyj.lk@gmail.com>
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

Fix to return error code -ENOMEM from the dma_map_single error
handling case instead of 0, as done elsewhere in this function.

Fixes: 032c5e82847a ("Driver for IBM System i/p VNIC protocol")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index b942108..59245d0 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -3751,6 +3751,7 @@ static int ibmvnic_probe(struct vio_dev *dev, const struct vio_device_id *id)
 	if (dma_mapping_error(&dev->dev, adapter->stats_token)) {
 		if (!firmware_has_feature(FW_FEATURE_CMO))
 			dev_err(&dev->dev, "Couldn't map stats buffer\n");
+		rc = -ENOMEM;
 		goto free_crq;
 	}
