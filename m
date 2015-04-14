Return-Path: <tlfalcon@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 588131A0143
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 06:35:12 +1000 (AEST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.vnet.ibm.com>;
 Tue, 14 Apr 2015 14:35:10 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 995D23E4003B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 14:35:06 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3EKYm3E33882116
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 13:34:48 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3EKZ5pj014389
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 14:35:05 -0600
From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
To: netdev@vger.kernel.org
Subject: [PATCH 1/5] ibmveth: change rx buffer default allocation for CMO
Date: Tue, 14 Apr 2015 15:35:00 -0500
Message-Id: <1429043704-22552-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch enables 64k rx buffer pools by default.  If Cooperative
Memory Overcommitment (CMO) is enabled, the number of 64k buffers
is reduced to save memory.

Cc: Brian King <brking@linux.vnet.ibm.com>
Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 3 +++
 drivers/net/ethernet/ibm/ibmveth.h | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index cd7675a..0210622 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1424,6 +1424,9 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 
 	memcpy(netdev->dev_addr, mac_addr_p, ETH_ALEN);
 
+	if (firmware_has_feature(FW_FEATURE_CMO))
+		memcpy(pool_count, pool_count_cmo, sizeof(pool_count));
+
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
 		struct kobject *kobj = &adapter->rx_buff_pool[i].kobj;
 		int error;
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index 1f37499..0dc664b 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -104,7 +104,8 @@ static inline long h_illan_attributes(unsigned long unit_address,
 
 static int pool_size[] = { 512, 1024 * 2, 1024 * 16, 1024 * 32, 1024 * 64 };
 static int pool_count[] = { 256, 512, 256, 256, 256 };
-static int pool_active[] = { 1, 1, 0, 0, 0};
+static int pool_count_cmo[] = { 256, 512, 256, 256, 64 };
+static int pool_active[] = { 1, 1, 0, 0, 1};
 
 #define IBM_VETH_INVALID_MAP ((u16)0xffff)
 
-- 
1.8.3.1
