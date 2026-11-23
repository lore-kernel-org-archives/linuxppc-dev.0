Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D219606A684
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 07:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gPn1J3Qj
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXypC45M1z2yRP;
	Mon, 23 Nov 2026 18:52:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795420339;
	cv=none; b=PmV66DETVw6hXjRpEgefop8ax7tna+IpO8wdB0SXaI7ZeWNb9n94aUReROCBVXQ+IuimOyoubXoZOAk0AmjMxMv6micgNZoWW1JNMV55d7aSyNs2Nz1pqKUcBJn29bzEE0AV+cO6entXnrPwC1fEJt8qt/FimWh7WDpbOH5cDimSjjpox/naLXPIfUxdvI59CXn51OQyJo0a+il0dOvY8yd+K9dYAr/6WOp0M4ShE9MENMxc9tFzG3ePGvaMdpTUu7bKF/iF6QqIoMxXLd4QPlw5pM56FZE1QqQb/oLJOF6ZTE84lRtmK5Um6Cfwf4OFmYv5DGSlYALbc1y05OfXkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795420339; c=relaxed/relaxed;
	bh=PovMu5Us43lMQLZ6zrqQW5EKuYK2Qg0YpGlcYPRAbK0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CUUZbpcVrjWWKjxG97Hcbc24jWr+nulrhw3xI2g/9xOIRcGx/Jrw12/hIZ/ufxOkl1mbfmJNvdPlbvE896Kvk0DFB7fKofwvuA1b2FOwwXNoc0Eq6/XElD8dXkU15d3EFXomWUI7G+DKfXpovFPVo4rqjOHgH92H73OYwxk2+NL7R6biyGCn6QeIYGfMkRcOL+pLovw8Ad2djE+ZyOF94O4kHVrKo+QYfGOZAKUUPCYuTUrrtK8x6RJM5yzpXEIcbPCGyYhGy5WGYDoIPEIN4YSvU3zFy/kUZ/2IN1LONnPaKCZPiiQFUFwHpB86zGmDzodpNCGqM8eypBLboeGhfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gPn1J3Qj; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gPn1J3Qj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXypB4FlTz3bdQ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 18:52:18 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN54liP2633198;
	Mon, 23 Nov 2026 07:51:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PovMu5Us43lMQLZ6z
	rqQW5EKuYK2Qg0YpGlcYPRAbK0=; b=gPn1J3QjWX6ptUG4tUMs6Jea49kgFhaW7
	64Kb/OpVMO6K2Mo3r2c3/EiJUF7U57wMqJ/ncmT+sGulztYu1hCt/Ahf1GFDmllM
	pwSf3gZE+CBus8Yx37Zc51jqQcaO9dsJ4wWBvEaLWxxUX+8GRbxYxK18v/CVn6Hs
	BezpYZlLWcUh0uJg0miQRcd6S6qQM/9TR/fsEkvHskNV/YE1sF4JI1f5yTBle+rR
	zS5GOmGvA7p2nIA5vde8Ih2VjtGWW8U9syVHb845dxrCp7T7dArHuWcZSB/S6W9F
	uW3/Uyy1715M3qf6JsrUQeE5DKRCCrrXlJcuWVzHSAhxI7bliSFJw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g11skq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 07:51:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN54FCJ684292;
	Mon, 23 Nov 2026 07:51:56 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3p0vdxg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 07:51:56 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AN7ptJ730868160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 07:51:55 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2878D58060;
	Mon, 23 Nov 2026 07:51:55 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1CE358056;
	Mon, 23 Nov 2026 07:51:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.2.38])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 07:51:52 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        sshegde@linux.ibm.com, nnac123@linux.ibm.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org, horms@kernel.org,
        davemarq@linux.ibm.com, haren@linux.ibm.com, ricklind@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Subject: [PATCH net-next v2 4/8] ibmveth: Refactor RX interrupt control for MQ RX queues
Date: Sun, 22 Nov 2026 23:51:32 -0800
Message-Id: <20261123075136.3278-5-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261123075136.3278-1-mmc@linux.ibm.com>
References: <20261123075136.3278-1-mmc@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: Ev1PUKmv2BcZn-CD0jv2X0XaWrbAnv41
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAzMCBTYWx0ZWRfX+zKzNjYdKoOw
 vgt6evasM+k81k9H/5jbjO0HUjl35b2GaOcuNDhepcbG4h6zzQBgNKzQQ+LCrggg8f8YOdcMJ4+
 mmzzKk+kc/Bcq15O2mLqr2GgIYiXHMM=
X-Proofpoint-GUID: 3UZjh3-e1J2InjZSSQmdPh8NApD6gyEp
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6b03f09d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=C6frtIBZwwJNOuPk214A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAzMCBTYWx0ZWRfX/MCh4UG1M57S
 1+FBA5QnjpxEymtMWRrt3kBNKeY5Dp6LY7co9tzSeIoHdoVum85FXZB6meU9rRtwIDe6nI/fk51
 Ny2VGulrfh0MVeCT3FdpgYtesWZ8FkV3cqGRjW2NFWHgS5RAtLCVUZScIkU1d1J/hMTSFD++ESi
 PJ6R4/zD/ghVhjbbN7wSApyX69A5vnetTeZ7VVwyr2zPea+LDDbRuuVPvt7OS/N/VCNgZVTWTzG
 RO8nikmZiudQJHpNob6xueQh2qEooq0lIRkYzuFMh+CoFKBkG91IzB2flyKAWs1scM37zZgJJKj
 /7zYCAo+MWrnp3nWweKk6p3wYOt6RC6d3MedneDpEgSrPVn6bEJjTXgNJGYSB9HaDOBy1WKCw3a
 TrHbyBBDYLWeZHvMLG7eUBewA9p/e2yoxxONYi7RQh/SQvCX1mQPODH7bDOXEd+YJJGh8uKS2dJ
 LvmEJqNJyuLjPazi80w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230030
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
Changes in v2:
- comments only (Sashiko): h_vio_signal() is queue 0; setup does not
  mask; name ibmveth_schedule_rx_queue()

 drivers/net/ethernet/ibm/ibmveth.c | 224 ++++++++++++++++++++++-------
 drivers/net/ethernet/ibm/ibmveth.h |   1 +
 2 files changed, 175 insertions(+), 50 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index fca741eb0291..ea0e5158040c 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -332,6 +332,154 @@ ibmveth_cleanup_rx_resources(struct ibmveth_adapter *adapter)
 	}
 }
 
+/**
+ * ibmveth_toggle_irq - Mask or unmask one RX queue's interrupt in PHYP
+ * @adapter: ibmveth adapter structure
+ * @queue_index: RX queue index
+ * @enable: true to unmask, false to mask
+ *
+ * Only queue 0 exists for now. Its interrupt is the adapter's own, which
+ * h_vio_signal() controls, so @queue_index is used only for logging.
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
+ * The queues must already be masked in PHYP, as they are before the LAN
+ * is registered; this does not unmask them. The caller kicks NAPI, and
+ * the first poll unmasks.
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
@@ -966,7 +1114,8 @@ static int ibmveth_open(struct net_device *netdev)
 					adapter->rx_queue[0].queue_len;
 	rxq_desc.fields.address = adapter->rx_queue[0].queue_dma;
 
-	h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_DISABLE);
+	adapter->queue_irq[0] = netdev->irq;
+	ibmveth_disable_irq(adapter, 0);
 
 	lpar_rc = ibmveth_register_logical_lan(adapter, rxq_desc, mac_address);
 
@@ -987,26 +1136,16 @@ static int ibmveth_open(struct net_device *netdev)
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
 
@@ -1046,30 +1185,19 @@ static int ibmveth_close(struct net_device *netdev)
 
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
@@ -1756,7 +1884,6 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 			container_of(napi, struct ibmveth_adapter, napi[0]);
 	struct net_device *netdev = adapter->netdev;
 	int frames_processed = 0;
-	unsigned long lpar_rc;
 	u64 correlator;
 	u16 mss = 0;
 	int rc;
@@ -1904,18 +2031,18 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
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
-	 * NAPI can start polling, and unmask, as soon as it is queued.
+	/* Mask before queueing, as ibmveth_schedule_rx_queue() does: a
+	 * threaded NAPI can start polling, and unmask, as soon as it is
+	 * queued.
 	 */
 	if (ibmveth_rxq_pending_buffer(adapter) && napi_schedule_prep(napi)) {
-		lpar_rc = h_vio_signal(adapter->vdev->unit_address,
-				       VIO_IRQ_DISABLE);
+		ibmveth_disable_irq(adapter, 0);
 		__napi_schedule(napi);
 	}
 
@@ -1925,16 +2052,11 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 
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
 
@@ -2476,8 +2598,8 @@ static ssize_t veth_pool_store(struct kobject *kobj, struct attribute *attr,
 	}
 	rtnl_unlock();
 
-	/* kick the interrupt handler to allocate/deallocate pools */
-	ibmveth_interrupt(netdev->irq, netdev);
+	/* kick RX processing to allocate/deallocate pools */
+	ibmveth_schedule_rx_queue(adapter, 0);
 	return count;
 
 unlock_err:
@@ -2517,7 +2639,9 @@ static struct kobj_type ktype_veth_pool = {
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


