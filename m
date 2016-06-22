Return-Path: <weiyj_lk@163.com>
Received: from m12-15.163.com (m12-15.163.com [220.181.12.15])
 by lists.ozlabs.org (Postfix) with ESMTP id 3rZ8fy3cbBzDqFM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 13:08:08 +1000 (AEST)
Subject: [PATCH v2] ibmvnic: fix to use list_for_each_safe() when delete items
To: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
References: <1466218408-20940-1-git-send-email-weiyj_lk@163.com>
 <576810C2.6080208@linux.vnet.ibm.com> <576964CF.3040804@linux.vnet.ibm.com>
Cc: John Allen <jallen@linux.vnet.ibm.com>, netdev@vger.kernel.org,
 Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linuxppc-dev@lists.ozlabs.org
From: Wei Yongjun <weiyj_lk@163.com>
Message-ID: <2db3a1f8-cafd-8fde-6223-2b2e3787d615@163.com>
Date: Wed, 22 Jun 2016 10:51:46 +0800
MIME-Version: 1.0
In-Reply-To: <576964CF.3040804@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since we will remove items off the list using list_del() we need
to use a safe version of the list_for_each() macro aptly named
list_for_each_safe().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
  drivers/net/ethernet/ibm/ibmvnic.c | 14 +++++++-------
  1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 864cb21..ecdb685 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2121,7 +2121,7 @@ static void handle_error_info_rsp(union ibmvnic_crq *crq,
  				  struct ibmvnic_adapter *adapter)
  {
  	struct device *dev = &adapter->vdev->dev;
-	struct ibmvnic_error_buff *error_buff;
+	struct ibmvnic_error_buff *error_buff, *tmp;
  	unsigned long flags;
  	bool found = false;
  	int i;
@@ -2133,7 +2133,7 @@ static void handle_error_info_rsp(union ibmvnic_crq *crq,
  	}
  
  	spin_lock_irqsave(&adapter->error_list_lock, flags);
-	list_for_each_entry(error_buff, &adapter->errors, list)
+	list_for_each_entry_safe(error_buff, tmp, &adapter->errors, list)
  		if (error_buff->error_id == crq->request_error_rsp.error_id) {
  			found = true;
  			list_del(&error_buff->list);
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
