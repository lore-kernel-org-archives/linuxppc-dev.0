Return-Path: <weiyj_lk@163.com>
Received: from m12-16.163.com (m12-16.163.com [220.181.12.16])
 by lists.ozlabs.org (Postfix) with ESMTP id 3rWhtf6rzTzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jun 2016 13:09:46 +1000 (AEST)
From: weiyj_lk@163.com
To: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] ibmvnic: fix to use list_for_each_safe() when delete items
Date: Sat, 18 Jun 2016 02:53:28 +0000
Message-Id: <1466218408-20940-1-git-send-email-weiyj_lk@163.com>
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

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Since we will remove items off the list using list_del() we need
to use a safe version of the list_for_each() macro aptly named
list_for_each_safe().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 864cb21..0b6a922 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -3141,14 +3141,14 @@ static void handle_request_ras_comp_num_rsp(union ibmvnic_crq *crq,
 
 static void ibmvnic_free_inflight(struct ibmvnic_adapter *adapter)
 {
-	struct ibmvnic_inflight_cmd *inflight_cmd;
+	struct ibmvnic_inflight_cmd *inflight_cmd, *tmp1;
 	struct device *dev = &adapter->vdev->dev;
-	struct ibmvnic_error_buff *error_buff;
+	struct ibmvnic_error_buff *error_buff, *tmp2;
 	unsigned long flags;
 	unsigned long flags2;
 
 	spin_lock_irqsave(&adapter->inflight_lock, flags);
-	list_for_each_entry(inflight_cmd, &adapter->inflight, list) {
+	list_for_each_entry_safe(inflight_cmd, tmp1, &adapter->inflight, list) {
 		switch (inflight_cmd->crq.generic.cmd) {
 		case LOGIN:
 			dma_unmap_single(dev, adapter->login_buf_token,
@@ -3165,8 +3165,8 @@ static void ibmvnic_free_inflight(struct ibmvnic_adapter *adapter)
 			break;
 		case REQUEST_ERROR_INFO:
 			spin_lock_irqsave(&adapter->error_list_lock, flags2);
-			list_for_each_entry(error_buff, &adapter->errors,
-					    list) {
+			list_for_each_entry_safe(error_buff, tmp2,
+						 &adapter->errors, list) {
 				dma_unmap_single(dev, error_buff->dma,
 						 error_buff->len,
 						 DMA_FROM_DEVICE);
