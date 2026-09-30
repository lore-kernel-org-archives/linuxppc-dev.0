Return-Path: <linuxppc-dev+bounces-28588-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D67CA5FCB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 15:52:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hw0124rT7z30NF;
	Thu, 01 Oct 2026 01:52:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790758492;
	cv=none; b=PPilzov1pcHFz+0Sbf9t7Yr5+rY9LpYPnnuBlwN/j1oGselxUdZm5uQGmgFmYcITGQFayS/Y5UdNur0Tk8k7H1S7UlLPJQgN63v/lEP02ZC5cXpe7FG4Z4+do+2P/qhhsnTocP4rn1cRmxA0a5S3l8esmNslaVFO957WxVQ3iELgucC4cxb4qjj8rBp9+OSvFRKWFm74aK5eZGWafGh2WWp0jRgcCIi/whfEUwj5qMPdhK2sZqI50JG7+4f/yxtj7Cue9S9ORH1dl1Aat+g9LGWTOq/D0KiMr682LMgxBN+NY9YXiuqm+b12YWAa7COCGowyAPv0BMnEJXfdapOVLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790758492; c=relaxed/relaxed;
	bh=Jptl9/+U11paEdlC9elLjJR0bUP8PiTWBv4u6ik5r7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lypRS6JOxtNsuWJjuXO4Y4UWKCi/OS33Y9nYPROjdLZS0r5LAnSNCJH1GINvv7ZrhfAY0W5W+zTZ7zWfRtIRQ1WKaPhrf8n1Il4t0UkSGylst9qYnbvpc3qY3BSBa8llRWYRxVpTnbsxmJ3kCWuX0jhWOPqq3Z0UnAXTECT0GefKP9bWo4rK6TsdNg1ETMJambae9jJ5/NHKy3sCfs9WqjqPw5+0fwho4+T25eVSPmc6nD5Ms7ovzssnHPEHPJI4zSLB/LYS4xAX17WnNt/xL0F/SM3egoGj3zmI/bEdqcNl1AGmxADvt/nmaDxvtHezS+Xi8ngh5MXxB90AMDYIpg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=EiB4m4XL; dkim-atps=neutral; spf=pass (client-ip=45.254.49.197; helo=mail-m49197.qiye.163.com; envelope-from=runyu.xiao@seu.edu.cn; receiver=lists.ozlabs.org) smtp.mailfrom=seu.edu.cn
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=EiB4m4XL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=seu.edu.cn (client-ip=45.254.49.197; helo=mail-m49197.qiye.163.com; envelope-from=runyu.xiao@seu.edu.cn; receiver=lists.ozlabs.org)
X-Greylist: delayed 312 seconds by postgrey-1.37 at boromir; Wed, 30 Sep 2026 18:54:47 AEST
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvplD02G4z2yqT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 18:54:46 +1000 (AEST)
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f9fcecbd;
	Wed, 30 Sep 2026 16:49:23 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <mkp@kernel.org>,
	Brian King <brking@linux.vnet.ibm.com>,
	linux-scsi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH v2] scsi: ibmvfc: synchronize event timer completion
Date: Wed, 30 Sep 2026 16:49:17 +0800
Message-Id: <20260930084917.2965242-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930075801.2949514-1-runyu.xiao@seu.edu.cn>
References: <20260930075801.2949514-1-runyu.xiao@seu.edu.cn>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0f181125f03a1kunm9341f46b27484f
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCQh9JVklPHxlLSU5LHkIfGVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=EiB4m4XLz0mrbtTyJo0X6DAbAvDpwr3ZaSrwem+0X8d70MjbWUjPAWWWsyfO+3qojHIN9mowCHHFZQsXuyiSm/lRIlrD2l+Ag2jP+ixDSY4AZL01zNNlOczNfajRqccVFek2J0NhwqavCg6FVg3Kexhm8N+7JsGHdCYwOdUkpnk=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=Jptl9/+U11paEdlC9elLjJR0bUP8PiTWBv4u6ik5r7s=;
	h=date:mime-version:subject:message-id:from;

An event completion may be deferred when the timer callback is active. MAD
events normally use ibmvfc_locked_done(), but send failures replace the
wrapper with the raw callback because the caller may already hold
host_lock. Preserve that locking requirement when the completion runs from
workqueue context.

Flush every event completion work item before taking the event pool list
lock, then remove the free-list entries while holding queue->l_lock. Route
purge completions through the same timer synchronization helper so all
completion paths obey the same ordering.

Fixes: 072b91f9c651 ("[SCSI] ibmvfc: IBM Power Virtual Fibre Channel Adapter Client Driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 61 ++++++++++++++++++++++++-----
 drivers/scsi/ibmvscsi/ibmvfc.h      |  3 ++
 2 files changed, 55 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 93b9f699c..a3d016f6e 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -811,6 +811,35 @@ static int ibmvfc_send_crq_init_complete(struct ibmvfc_host *vhost)
 	return ibmvfc_send_crq(vhost, 0xC002000000000000LL, 0);
 }
 
+static void ibmvfc_complete_event_work(struct work_struct *work)
+{
+	struct ibmvfc_event *evt = container_of(work, struct ibmvfc_event,
+						timer_work);
+	unsigned long flags;
+
+	timer_delete_sync(&evt->timer);
+	if (evt->done_needs_host_lock) {
+		spin_lock_irqsave(evt->vhost->host->host_lock, flags);
+		evt->done(evt);
+		spin_unlock_irqrestore(evt->vhost->host->host_lock, flags);
+	} else {
+		evt->done(evt);
+	}
+}
+
+static void ibmvfc_complete_event(struct ibmvfc_event *evt)
+{
+	/* The response path can run in hardirq context, so defer only when the
+	 * timer callback is already executing on another context.
+	 */
+	if (timer_delete_sync_try(&evt->timer) < 0) {
+		schedule_work(&evt->timer_work);
+		return;
+	}
+
+	evt->done(evt);
+}
+
 /**
  * ibmvfc_init_event_pool - Allocates and initializes the event pool for a host
  * @vhost:	ibmvfc host who owns the event pool
@@ -859,6 +888,7 @@ static int ibmvfc_init_event_pool(struct ibmvfc_host *vhost,
 		 */
 		atomic_set(&evt->active, -1);
 		atomic_set(&evt->free, 1);
+		INIT_WORK(&evt->timer_work, ibmvfc_complete_event_work);
 		evt->crq.valid = 0x80;
 		evt->crq.ioba = cpu_to_be64(pool->iu_token + (sizeof(*evt->xfer_iu) * i));
 		evt->xfer_iu = pool->iu_storage + i;
@@ -882,18 +912,31 @@ static void ibmvfc_free_event_pool(struct ibmvfc_host *vhost,
 				   struct ibmvfc_queue *queue)
 {
 	int i;
+	unsigned long flags;
 	struct ibmvfc_event_pool *pool = &queue->evt_pool;
 
 	ENTER;
+	if (!pool->size)
+		goto out;
+
+	for (i = 0; i < pool->size; ++i)
+		flush_work(&pool->events[i].timer_work);
+
+	spin_lock_irqsave(&queue->l_lock, flags);
 	for (i = 0; i < pool->size; ++i) {
 		list_del(&pool->events[i].queue_list);
 		BUG_ON(atomic_read(&pool->events[i].free) != 1);
+	}
+	spin_unlock_irqrestore(&queue->l_lock, flags);
+
+	for (i = 0; i < pool->size; ++i) {
 		if (pool->events[i].ext_list)
 			dma_pool_free(vhost->sg_pool,
 				      pool->events[i].ext_list,
 				      pool->events[i].ext_list_token);
 	}
 
+out:
 	kfree(pool->events);
 	dma_free_coherent(vhost->dev,
 			  pool->size * sizeof(*pool->iu_storage),
@@ -1134,7 +1177,7 @@ static void ibmvfc_complete_purge(struct list_head *purge_list)
 	list_for_each_entry_safe(evt, pos, purge_list, queue_list) {
 		list_del(&evt->queue_list);
 		ibmvfc_trc_end(evt);
-		evt->done(evt);
+		ibmvfc_complete_event(evt);
 	}
 }
 
@@ -1162,7 +1205,7 @@ static void ibmvfc_fail_request(struct ibmvfc_event *evt, int error_code)
 	else
 		evt->xfer_iu->mad_common.status = cpu_to_be16(IBMVFC_MAD_DRIVER_FAILED);
 
-	timer_delete(&evt->timer);
+	timer_delete_sync_try(&evt->timer);
 }
 
 /**
@@ -1669,6 +1712,7 @@ void ibmvfc_init_event(struct ibmvfc_event *evt,
 		evt->_done = done;
 		evt->done = ibmvfc_locked_done;
 	}
+	evt->done_needs_host_lock = false;
 	evt->hwq = 0;
 }
 
@@ -1824,7 +1868,6 @@ int ibmvfc_send_event(struct ibmvfc_event *evt,
 		atomic_set(&evt->active, 0);
 		list_del(&evt->queue_list);
 		spin_unlock_irqrestore(&evt->queue->l_lock, flags);
-		timer_delete(&evt->timer);
 
 		/* If send_crq returns H_CLOSED, return SCSI_MLQUEUE_HOST_BUSY.
 		 * Firmware will send a CRQ with a transport event (0xFF) to
@@ -1836,7 +1879,8 @@ int ibmvfc_send_event(struct ibmvfc_event *evt,
 				dev_warn(vhost->dev, "Send warning. Receive queue closed, will retry.\n");
 			if (evt->cmnd)
 				scsi_dma_unmap(evt->cmnd);
-			ibmvfc_free_event(evt);
+			evt->done = ibmvfc_free_event;
+			ibmvfc_complete_event(evt);
 			return SCSI_MLQUEUE_HOST_BUSY;
 		}
 
@@ -1849,9 +1893,10 @@ int ibmvfc_send_event(struct ibmvfc_event *evt,
 		} else {
 			evt->xfer_iu->mad_common.status = cpu_to_be16(IBMVFC_MAD_CRQ_ERROR);
 			evt->done = evt->_done;
+			evt->done_needs_host_lock = true;
 		}
 
-		evt->done(evt);
+		ibmvfc_complete_event(evt);
 	} else {
 		spin_unlock_irqrestore(&evt->queue->l_lock, flags);
 		ibmvfc_trc_start(evt);
@@ -3925,10 +3970,9 @@ static void ibmvfc_tasklet(void *data)
 	spin_unlock_irqrestore(vhost->host->host_lock, flags);
 
 	list_for_each_entry_safe(evt, temp, &evt_doneq, queue_list) {
-		timer_delete(&evt->timer);
 		list_del(&evt->queue_list);
 		ibmvfc_trc_end(evt);
-		evt->done(evt);
+		ibmvfc_complete_event(evt);
 	}
 }
 
@@ -4031,10 +4075,9 @@ static void ibmvfc_drain_sub_crq(struct ibmvfc_queue *scrq)
 	spin_unlock_irqrestore(scrq->q_lock, flags);
 
 	list_for_each_entry_safe(evt, temp, &evt_doneq, queue_list) {
-		timer_delete(&evt->timer);
 		list_del(&evt->queue_list);
 		ibmvfc_trc_end(evt);
-		evt->done(evt);
+		ibmvfc_complete_event(evt);
 	}
 }
 
diff --git a/drivers/scsi/ibmvscsi/ibmvfc.h b/drivers/scsi/ibmvscsi/ibmvfc.h
index ca80ceffe..912d250da 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.h
+++ b/drivers/scsi/ibmvscsi/ibmvfc.h
@@ -14,6 +14,7 @@
 #include <linux/interrupt.h>
 #include <linux/list.h>
 #include <linux/types.h>
+#include <linux/workqueue.h>
 #include <scsi/scsi_device.h>
 #include <scsi/viosrp.h>
 #include <linux/nvme.h>
@@ -867,6 +868,8 @@ struct ibmvfc_event {
 	struct completion comp;
 	struct completion *eh_comp;
 	struct timer_list timer;
+	struct work_struct timer_work;
+	bool done_needs_host_lock;
 	u16 hwq;
 	u8 reserved;
 };
-- 
2.34.1


