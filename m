Return-Path: <baolex.ni@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by lists.ozlabs.org (Postfix) with ESMTP id 3s3Zvj5dw6zDqfj
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 22:17:21 +1000 (AEST)
From: Baole Ni <baolex.ni@intel.com>
To: tlfalcon@linux.vnet.ibm.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, computersforpeace@gmail.com, m.chehab@samsung.com,
 pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com,
 k.kozlowski@samsung.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, chuansheng.liu@intel.com,
 baolex.ni@intel.com, fw@strlen.de, davem@davemloft.net, Baohua.Song@csr.com
Subject: [PATCH 0718/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:39:36 +0800
Message-Id: <20160802113936.29929-1-baolex.ni@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index ebe6071..7b0fd24 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -66,17 +66,17 @@ MODULE_LICENSE("GPL");
 MODULE_VERSION(ibmveth_driver_version);
 
 static unsigned int tx_copybreak __read_mostly = 128;
-module_param(tx_copybreak, uint, 0644);
+module_param(tx_copybreak, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(tx_copybreak,
 	"Maximum size of packet that is copied to a new buffer on transmit");
 
 static unsigned int rx_copybreak __read_mostly = 128;
-module_param(rx_copybreak, uint, 0644);
+module_param(rx_copybreak, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(rx_copybreak,
 	"Maximum size of packet that is copied to a new buffer on receive");
 
 static unsigned int rx_flush __read_mostly = 0;
-module_param(rx_flush, uint, 0644);
+module_param(rx_flush, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(rx_flush, "Flush receive buffers before use");
 
 static bool old_large_send __read_mostly;
@@ -1730,9 +1730,9 @@ static ssize_t veth_pool_store(struct kobject *kobj, struct attribute *attr,
 	.name = __stringify(_name), .mode = _mode,	\
 	};
 
-static ATTR(active, 0644);
-static ATTR(num, 0644);
-static ATTR(size, 0644);
+static ATTR(active, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+static ATTR(num, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+static ATTR(size, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
 static struct attribute *veth_pool_attrs[] = {
 	&veth_active_attr,
-- 
2.9.2
