Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4515D606A330
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 00:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Dg1n8/xW
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVJh11YyNz2xns;
	Thu, 19 Nov 2026 11:07:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795046865;
	cv=none; b=KNUUy1LE41l4m3Lu2AriJafDNa2BjOELKjaHsiwDnN4eT3n7ysAPMGlAI6q1JJxMkRsNkzspaTwhXVm13j2DEs+sPRiraIkJYVKAuGi++QSFGtISrpDOAatwlKKIdsewr+gW+1DYOTLJwGe99Blo4me4sVt41gNQnaIw8Iteyt70GJsx3U3JE093FJgPj7fh63ZzPQxn1HC3SohDG0/4d0Rs0MqX/Z+pkllTouCIl/suOilZaZFkIvETptni2Pba494iuUI2SwVFkCN2gQiZvGC5l7sXztF02W9hbNCquv89R4rIGiKtjssLCmkkKkYJ9ZkuETh0PXCGKmDAwUn9ug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795046865; c=relaxed/relaxed;
	bh=g81rSIjP9Jsut0gRlpSagxSe0O3PBBT51Kg4Cei2J3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lNY0EiphLWPMLbSUBitGu2pB0qJ+l8tzqsiwwXkP44c6R4KOGRvkvm1+kVQGBv398j1W2oUGTkWCnTa727CP5RoLNk0ktVfo7rToFjNs27eUo8ToKaFgD6FIU3ZIYLjZDvVXY0zAKgiA+WJuIZdhb41sqLJnZpOQa42oVnx2B+n2ijXrmF4J3/gmhV89MvQpsu3wzzBnopmyt9rnk3JziR19P5ervxhNOdH77Te1US8aLj3Ip9ODiD/oTSkPw0Jgt8Kq3FANjM+8a2z6ORe/lOAZCoAM0FbAs6p+Sz7sXx23ShzPQnFYtOzbp6JJSF9ecYoROVtkgXTJU0kMgxQCbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Dg1n8/xW; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Dg1n8/xW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVJh01GX8z2yr0
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 11:07:43 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AILQPk72376740;
	Thu, 19 Nov 2026 00:07:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=g81rSIjP9Jsut0gRl
	pSagxSe0O3PBBT51Kg4Cei2J3I=; b=Dg1n8/xW3UgV+EibA++yzBH4tx+2EKNCG
	pOigg4IDUjXUGTOwDMGUmGHbYOweSeKAhfDkERgF1KsyEfWSBRBUELp4x9h740yP
	VjAb1LRfS4IM8x/4Ofpqo9IKmHicfpwv22ZeGAHUyCHatDy+w8h10KH/lKG040gb
	a1ql9Ikdg/OSyXmzSvmSFUd7zR/WcGL7U98sc4NJNqXXZ2y6UKjkUcn8Z0WXCRkR
	z11nM8jEGU5gaqMgCKc8zS0+Cy/VJWtWMx/EOdCQZc5LIlrV9qDU4NMTLv251gcA
	ws3iZk465Zck9udy/PUbUU+sBWdp47f0e73p/dENloP33jMt/Oxnw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105nd9s2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 00:07:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AILK4RL2586968;
	Thu, 19 Nov 2026 00:07:33 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j17c4u36a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 00:07:33 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AJ07Vhp24314578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Nov 2026 00:07:32 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9F8458051;
	Thu, 19 Nov 2026 00:07:31 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28E205805C;
	Thu, 19 Nov 2026 00:07:29 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.93.165])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Nov 2026 00:07:29 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        sshegde@linux.ibm.com, nnac123@linux.ibm.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org, horms@kernel.org,
        davemarq@linux.ibm.com, haren@linux.ibm.com, ricklind@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Subject: [PATCH net-next 4/8] ibmveth: Refactor RX interrupt control for MQ RX queues
Date: Wed, 18 Nov 2026 16:07:07 -0800
Message-Id: <20261119000711.18093-5-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261119000711.18093-1-mmc@linux.ibm.com>
References: <20261119000711.18093-1-mmc@linux.ibm.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA4OCBTYWx0ZWRfX5N2lAjBNKyfR
 GD3BO0J7Afb0+e7cCu6QeXKbIsuLw23h8BmUhOBmR6fiEt5Yc8ODK/bwUgZzLl49MqOSFtP3T9U
 G6HCqdjxiD8sMLvz9/JinNc6VpdD4XFbq+UWJvLMrGEXO4/B5EKsfC/PDHl56HyZg+5nMIxMHU6
 ga0vMeBXtVZNakULWYVk0l5IqONwPeniRA9ffzTAJC2KAzFP6sWFFpehwIfFcsCDJgm7tlbmeGO
 0cEF8hA1cCvxLqPKXHvJ5z4B9623zchsTAsp00uuGX5tOhRuyryuxPwu7faRc8IwF/bkScJm/4d
 ERsl21TJvGr8N51kRf7+k7Oq/xgXRfX5j4ElY07BxrqJd8mXyeO5RMXhyYhT/HSRzwaQzlctING
 SASjkFwbuKFvsShv6oJW8GymUaAmj69bD9JEy0M6Ud3wFT+Xc1rDMcJDEjS/x0cxnqUm1dJ1JCK
 ftK4W6KdM1MDv2PyYmA==
X-Authority-Analysis: v=2.4 cv=HN9WhYtv c=1 sm=1 tr=0 ts=6afe3dc6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=C6frtIBZwwJNOuPk214A:9
X-Proofpoint-GUID: 6N_0vicTOMT7Gs_zoINV8Y9QQ6BsCbVj
X-Proofpoint-ORIG-GUID: bS6RiavDhbHFkR4UDJo_IbuPVWTsfaEU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA4OCBTYWx0ZWRfX7SOI1HhZYtbS
 e8d14rVenFBoqPZFQynMCkOeNECnYIzI/mDL7F2FFscf+polH8wWtXPyVbrLzPp7cM+bj7PjoMK
 X39S0ivC3crPcQ/3XS+1uniVv5rPydI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_07,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180088
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move IRQ and NAPI setup, teardown and PHYP masking into helpers that
take a queue index. The IRQ cookie is that queue's NAPI. The handler
and the process-context kicks (open, resume, pool sysfs) share
ibmveth_schedule_rx_queue(), which masks only when napi_schedule_prep()
succeeds, as the handler already did. The new queue_irq[] holds each
queue's Linux IRQ; queue 0 uses netdev->irq.

napi_enable() moves to after request_irq(), with PHYP still masked:
NAPI can run as soon as it is enabled, and poll is what unmasks.

Teardown waits for the poll tail and remasks before free_irq(),
because poll unmasks after napi_complete_done(). close() stops TX
before that teardown, and now frees the IRQ before H_FREE_LOGICAL_LAN
rather than after it; PHYP is masked by then. A failed h_vio_signal()
is logged, ratelimited, instead of WARN_ON().

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 217 ++++++++++++++++++++++-------
 drivers/net/ethernet/ibm/ibmveth.h |   1 +
 2 files changed, 169 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 20273240d8fe..ab5df1794004 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -330,6 +330,150 @@ ibmveth_cleanup_rx_resources(struct ibmveth_adapter *adapter)
 	}
 }
 
+/**
+ * ibmveth_toggle_irq - Mask or unmask one RX queue's interrupt in PHYP
+ * @adapter: ibmveth adapter structure
+ * @queue_index: RX queue index
+ * @enable: true to unmask, false to mask
+ *
+ * Return: 0 on success, -EIO on failure
+ */
+static int
+ibmveth_toggle_irq(struct ibmveth_adapter *adapter, int queue_index,
+		   bool enable)
+{
+	const char *action = enable ? "enable" : "disable";
+	unsigned long h_rc;
+
+	h_rc = h_vio_signal(adapter->vdev->unit_address,
+			    enable ? VIO_IRQ_ENABLE : VIO_IRQ_DISABLE);
+	if (h_rc) {
+		dev_err_ratelimited(&adapter->netdev->dev,
+				    "Failed to %s IRQ for queue %d, rc=0x%lx\n",
+				    action, queue_index, h_rc);
+		return -EIO;
+	}
+	return 0;
+}
+
+/**
+ * ibmveth_disable_irq - Disable interrupt for a specific queue
+ * @adapter: ibmveth adapter structure
+ * @queue_index: RX queue index
+ *
+ * Return: 0 on success, -EIO on failure
+ */
+static int
+ibmveth_disable_irq(struct ibmveth_adapter *adapter, int queue_index)
+{
+	return ibmveth_toggle_irq(adapter, queue_index, false);
+}
+
+/**
+ * ibmveth_enable_irq - Enable interrupt for a specific queue
+ * @adapter: ibmveth adapter structure
+ * @queue_index: RX queue index
+ *
+ * Return: 0 on success, -EIO on failure
+ */
+static int
+ibmveth_enable_irq(struct ibmveth_adapter *adapter, int queue_index)
+{
+	return ibmveth_toggle_irq(adapter, queue_index, true);
+}
+
+/**
+ * ibmveth_setup_rx_interrupts - Register IRQs and enable NAPI
+ * @adapter: ibmveth adapter structure
+ *
+ * Leaves the queues masked in PHYP; the caller kicks NAPI, and the first
+ * poll unmasks.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int
+ibmveth_setup_rx_interrupts(struct ibmveth_adapter *adapter)
+{
+	struct net_device *netdev = adapter->netdev;
+	int i, rc, num = adapter->num_rx_queues;
+
+	for (i = 0; i < num; i++) {
+		rc = request_irq(adapter->queue_irq[i], ibmveth_interrupt,
+				 0, netdev->name, &adapter->napi[i]);
+		if (rc) {
+			netdev_err(netdev,
+				   "request_irq() failed for irq 0x%x queue %d: %d\n",
+				   adapter->queue_irq[i], i, rc);
+			goto err_free_irqs;
+		}
+	}
+
+	for (i = 0; i < num; i++)
+		napi_enable(&adapter->napi[i]);
+
+	return 0;
+
+err_free_irqs:
+	while (--i >= 0)
+		free_irq(adapter->queue_irq[i], &adapter->napi[i]);
+	return rc;
+}
+
+/**
+ * ibmveth_cleanup_rx_interrupts - Mask PHYP IRQs, stop NAPI, and free IRQs
+ * @adapter: ibmveth adapter structure
+ *
+ * Mask, napi_disable, wait for the poll tail, remask, then free_irq.
+ * napi_disable() does not wait past napi_complete_done(), which can
+ * unmask.
+ */
+static void
+ibmveth_cleanup_rx_interrupts(struct ibmveth_adapter *adapter)
+{
+	int i;
+
+	for (i = 0; i < adapter->num_rx_queues; i++) {
+		ibmveth_disable_irq(adapter, i);
+		synchronize_irq(adapter->queue_irq[i]);
+	}
+
+	for (i = 0; i < adapter->num_rx_queues; i++)
+		napi_disable(&adapter->napi[i]);
+
+	synchronize_net();
+
+	for (i = 0; i < adapter->num_rx_queues; i++) {
+		ibmveth_disable_irq(adapter, i);
+		synchronize_irq(adapter->queue_irq[i]);
+	}
+
+	for (i = 0; i < adapter->num_rx_queues; i++)
+		free_irq(adapter->queue_irq[i], &adapter->napi[i]);
+}
+
+/**
+ * ibmveth_schedule_rx_queue - Mask PHYP IRQ and schedule NAPI for one RX queue
+ * @adapter: ibmveth adapter structure
+ * @qindex: RX queue index
+ *
+ * Shared by the IRQ handler and process-context kick sites (open, resume,
+ * pool sysfs).
+ *
+ * Does nothing if napi_schedule_prep() fails (NAPI already scheduled,
+ * or disabled because the device is closed). A failed
+ * ibmveth_disable_irq() is logged and the queue may stay unmasked.
+ */
+static void ibmveth_schedule_rx_queue(struct ibmveth_adapter *adapter,
+				      int qindex)
+{
+	struct napi_struct *napi = &adapter->napi[qindex];
+
+	if (napi_schedule_prep(napi)) {
+		ibmveth_disable_irq(adapter, qindex);
+		__napi_schedule(napi);
+	}
+}
+
 /* setup the initial settings for a buffer pool */
 static void ibmveth_init_buffer_pool(struct ibmveth_buff_pool *pool,
 				     u32 pool_index, u32 pool_size,
@@ -964,7 +1108,8 @@ static int ibmveth_open(struct net_device *netdev)
 					adapter->rx_queue[0].queue_len;
 	rxq_desc.fields.address = adapter->rx_queue[0].queue_dma;
 
-	h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_DISABLE);
+	adapter->queue_irq[0] = netdev->irq;
+	ibmveth_disable_irq(adapter, 0);
 
 	lpar_rc = ibmveth_register_logical_lan(adapter, rxq_desc, mac_address);
 
@@ -985,26 +1130,16 @@ static int ibmveth_open(struct net_device *netdev)
 	if (rc)
 		goto out_free_buffer_pools;
 
-	/* NAPI can run as soon as it is enabled, from netpoll during the
-	 * direct close()/open() pairs or from a direct ibmveth_interrupt()
-	 * call, so enable it only once everything ibmveth_poll() touches
-	 * exists.
+	/* Enables NAPI, so everything ibmveth_poll() touches must exist:
+	 * netpoll during the direct close()/open() pairs, or a direct
+	 * kick, can run it as soon as it is enabled.
 	 */
-	napi_enable(&adapter->napi[0]);
-
-	netdev_dbg(netdev, "registering irq 0x%x\n", netdev->irq);
-	rc = request_irq(netdev->irq, ibmveth_interrupt, 0, netdev->name,
-			 netdev);
-	if (rc != 0) {
-		napi_disable(&adapter->napi[0]);
-		synchronize_net();
-		netdev_err(netdev, "unable to request irq 0x%x, rc %d\n",
-			   netdev->irq, rc);
+	rc = ibmveth_setup_rx_interrupts(adapter);
+	if (rc)
 		goto out_free_buffer_pools;
-	}
 
 	netdev_dbg(netdev, "initial replenish cycle\n");
-	ibmveth_interrupt(netdev->irq, netdev);
+	ibmveth_schedule_rx_queue(adapter, 0);
 
 	netif_tx_start_all_queues(netdev);
 
@@ -1044,30 +1179,19 @@ static int ibmveth_close(struct net_device *netdev)
 
 	netdev_dbg(netdev, "close starting\n");
 
-	napi_disable(&adapter->napi[0]);
-	/* napi_disable() returns once ibmveth_poll() has called
-	 * napi_complete_done(), but the poll still re-enables the
-	 * interrupt and reads the RX queue after that.
-	 */
-	synchronize_net();
-
 	netif_tx_disable(netdev);
 
-	h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_DISABLE);
+	ibmveth_cleanup_rx_interrupts(adapter);
 
 	do {
 		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
 	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
-
 	if (lpar_rc != H_SUCCESS) {
-		netdev_err(netdev, "h_free_logical_lan failed with %lx, "
-			   "continuing with close\n", lpar_rc);
+		netdev_err(adapter->netdev,
+			   "h_free_logical_lan failed with %lx, continuing\n",
+			   lpar_rc);
 	}
-
-	free_irq(netdev->irq, netdev);
-
 	ibmveth_update_rx_no_buffer(adapter);
-
 	ibmveth_free_buffer_pools(adapter);
 	ibmveth_cleanup_rx_resources(adapter);
 	ibmveth_free_filter_list(adapter);
@@ -1754,7 +1878,6 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 			container_of(napi, struct ibmveth_adapter, napi[0]);
 	struct net_device *netdev = adapter->netdev;
 	int frames_processed = 0;
-	unsigned long lpar_rc;
 	u64 correlator;
 	u16 mss = 0;
 	int rc;
@@ -1902,18 +2025,17 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 	/* We think we are done - reenable interrupts,
 	 * then check once more to make sure we are done.
 	 */
-	lpar_rc = h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_ENABLE);
-	if (WARN_ON(lpar_rc != H_SUCCESS)) {
+	rc = ibmveth_enable_irq(adapter, 0);
+	if (rc) {
 		schedule_work(&adapter->work);
 		goto out;
 	}
 
-	/* Mask before queueing, as ibmveth_interrupt() does: a threaded
+	/* Mask before queueing, as schedule_rx_queue() does: a threaded
 	 * NAPI can start polling, and unmask, as soon as it is queued.
 	 */
 	if (ibmveth_rxq_pending_buffer(adapter) && napi_schedule_prep(napi)) {
-		lpar_rc = h_vio_signal(adapter->vdev->unit_address,
-				       VIO_IRQ_DISABLE);
+		ibmveth_disable_irq(adapter, 0);
 		__napi_schedule(napi);
 	}
 
@@ -1923,16 +2045,11 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 
 static irqreturn_t ibmveth_interrupt(int irq, void *dev_instance)
 {
-	struct net_device *netdev = dev_instance;
+	struct napi_struct *napi = dev_instance;
+	struct net_device *netdev = napi->dev;
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
-	unsigned long lpar_rc;
 
-	if (napi_schedule_prep(&adapter->napi[0])) {
-		lpar_rc = h_vio_signal(adapter->vdev->unit_address,
-				       VIO_IRQ_DISABLE);
-		WARN_ON(lpar_rc != H_SUCCESS);
-		__napi_schedule(&adapter->napi[0]);
-	}
+	ibmveth_schedule_rx_queue(adapter, napi - adapter->napi);
 	return IRQ_HANDLED;
 }
 
@@ -2474,8 +2591,8 @@ static ssize_t veth_pool_store(struct kobject *kobj, struct attribute *attr,
 	}
 	rtnl_unlock();
 
-	/* kick the interrupt handler to allocate/deallocate pools */
-	ibmveth_interrupt(netdev->irq, netdev);
+	/* kick RX processing to allocate/deallocate pools */
+	ibmveth_schedule_rx_queue(adapter, 0);
 	return count;
 
 unlock_err:
@@ -2515,7 +2632,9 @@ static struct kobj_type ktype_veth_pool = {
 static int ibmveth_resume(struct device *dev)
 {
 	struct net_device *netdev = dev_get_drvdata(dev);
-	ibmveth_interrupt(netdev->irq, netdev);
+	struct ibmveth_adapter *adapter = netdev_priv(netdev);
+
+	ibmveth_schedule_rx_queue(adapter, 0);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index 4c74bd39d4e0..60a94f1d23bc 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -175,6 +175,7 @@ struct ibmveth_adapter {
 	struct ibmveth_buff_pool
 		rx_buff_pool[IBMVETH_MAX_RX_QUEUES][IBMVETH_NUM_BUFF_POOLS];
 	struct ibmveth_rx_q rx_queue[IBMVETH_MAX_RX_QUEUES];
+	unsigned int queue_irq[IBMVETH_MAX_RX_QUEUES];
 	unsigned int num_rx_queues;
 	int rx_csum;
 	int large_send;
-- 
2.50.1 (Apple Git-155)


