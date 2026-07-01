Return-Path: <linuxppc-dev+bounces-23330-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35DACC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 22:26:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grF321zY4z2yvC;
	Thu, 02 Jul 2026 08:25:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782944750;
	cv=none; b=LrzxldMDiuhJdr2Vd1u0NyF7Rxl4YI6Cx9Vy8wzsH4MB/CQ2JELiFURC7o5lbS0qb1cZjBQ21ItkPUDP5XNQG7TTWF4tN5ZVeFpsLdOvpW5kSBG2K3Hne/EOf9qS1O33rWBqISetA1yMIsWKOpZNjZz9uyh6AW2Ukz6svfIO2HTdO0XSX9j2RRDaTVAZKo7K0OBqhbo3MSGgVH9azAfZcqWIPGNrQ8kcsKZg9PFCcuqcPLDXXzfVDOqu6uRp2pS+IcRx4FtTPC+IsyTQuAdKSacz9BFrJnz3wX5713ISCt0DbOBE6CBsucI/cLhtoeFrKHgjIOhFfXlnO5P0sxON/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782944750; c=relaxed/relaxed;
	bh=RZjo9KniSD0qcbgoF1ISjVcr/SurARDGU5dqH0fFeio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dQsY7XRE1s+SSDQPYS4Jk9yL6XkXhLlqh5Ezqfy8YFiNodi4KJvSNstUzw13uExOa/i57GU/ugDN95UlaRZz4Ud0CFHosGLHVfn7AGD/mtFvzlciRacqget9pPfUMXZ6GeItat38S0SdgpRUzaWBEeNreJuBZyR7Y/g0NpJuwfNnyQR9xKHCa+itvZxGVxNFBijEvb+RBCpEufluaPIFkUZIKCzvrmjnWlpWCPi25RaoXTYNKq4wVO4oFcruWWTbc+l3vTTTUMKTG+XFELmUYPJmYiunRL+Cr+ErWDbnYkYqFDHaZWljEMBAGZYZQgV2gkPvHSd0lFpreMmnmhQjbw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=o63Pwody; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=o63Pwody;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grF306LYlz2yv9
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 08:25:48 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661LmgXC1971401;
	Wed, 1 Jul 2026 22:25:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RZjo9KniSD0qcbgoF
	1ISjVcr/SurARDGU5dqH0fFeio=; b=o63PwodyXOGcPM4oRCbks2HGEtSapcXsp
	5/RGafv63M0BQFErmrqbnyEHeZwszTfobkFC/zrIJt5oTOsiKLWkmJJvZFp1FeIf
	BCDQwfCnP5TCQjvFYXUsKBdEX/6Aq9t1BsF4xt3UHFKKXGab71GuX8Fmcf765jeG
	SEN0KRYh/1Wm15cA19iOL+2YFoyKrQTf4hbpc5hFXdlMklAGPXEZv8+HONUXjU47
	nv2pupi2Yigy0Rq9Wx6nrbPHhHjCHm+Axo7t2C045UKPCytV/4TbG/cl98Eu1EfN
	En3g8Vku/iXU2gMMWVqKRykcW9NC07LLAkSj03KbWA+XK7SYbPXzQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rf6g58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 22:25:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 661MJbpO028852;
	Wed, 1 Jul 2026 22:25:35 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7w9fk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 22:25:35 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 661MPYG130999048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 22:25:34 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84C3458059;
	Wed,  1 Jul 2026 22:25:34 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DCE35804B;
	Wed,  1 Jul 2026 22:25:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.150.53])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 22:25:32 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH net-next v2 07/15] ibmveth: Add queue-aware RX buffer submit helper for MQ
Date: Wed,  1 Jul 2026 15:23:19 -0700
Message-Id: <20260701222327.61325-8-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260701222327.61325-1-mmc@linux.ibm.com>
References: <20260701222327.61325-1-mmc@linux.ibm.com>
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
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a4593e0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=DGqNc8_RdM7thkqK1-0A:9
X-Proofpoint-ORIG-GUID: kyLrGZiVrD9M5YHklmo6CZj71pqN2Ek_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDIzOSBTYWx0ZWRfX0lyKCCmWuQDZ
 Kf2jNOynvjlqf+R+ifoMWU7/qb97ko60uQLLD4pMg7/kUjMRqHHFdCGi2r81+Ax+Ckqnl90+ZHl
 7JbBKK0CHJutaPO7BBueJT09D9xjO14cmM4qBR8nchnZ/PegHDIlnSqLBOxC/EYV2BAZR8KkUDd
 cZ2AcmnpIfyY5zoWBr8DX6XLVR1BeOzZUA42w01n6gcKe+QaU4Gzk5vbllaI1xj1yz4AgfPSZ0B
 HcWLdsJn+NN0/To/qFtRsWMy/9qYCZa/s0XYxC1LaptqMGRs1Ds8MsKVBArQms+/6Ih1ztMTcWP
 blYUzvHNiiynI9RbcQZPgEuLJ0A7D/f5pk1GO1+rlx/syaEqn+wT6fIHtpVoqrmxxp1EzM8velS
 bZt+SyU9kP0So0vNMzPH8nEjuibnxROis91Ax25nvkLCgI/czoeb5TYJER88tlS95tJO6hA9im8
 +uc5onJlAuJhp9HVjpg==
X-Proofpoint-GUID: w-087DelP3X5oo4LOMqEOg95nVlQVs5E
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDIzOSBTYWx0ZWRfX6SEEV2elO0JZ
 uUXFdKAJwZR/NdRPf2y7/j0NDl7BrxqDZpMfXYUYVxpFpv9+cRROmA/e8ZnQJziQcmpt/LMI5st
 d5pYmrgQhjSWNZDlvSjJkEi4RpBP8Gs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010239

Replenish is the last open-path hypervisor call that still needs
per-queue awareness before MQ receive is enabled. Today
ibmveth_replenish_buffer_pool() calls h_add_logical_lan_buffer() or
h_add_logical_lan_buffers() directly; MQ posts via
H_ADD_LOGICAL_LAN_BUFFERS_QUEUE against adapter->queue_handle[].

Add ibmveth_add_logical_lan_buffers() to pick the hcall:
multi_queue uses h_add_logical_lan_buffers_queue() (up to 12 buffers,
IOBAs packed with odd counts in the upper 32 bits); legacy uses the
existing single- and multi-buffer hcalls. Count add_buf/add_bufs/
add_bufs_queue in hcall_stats.

Thread queue_index through replenish_task() and replenish_buffer_pool()
so they index rx_buff_pool[queue_index][pool]. All callers still pass
queue 0; legacy hcalls remain the live path until MQ probe enables
multi_queue.

Also split H_FUNCTION handling: legacy batch falls back to single-buffer
mode; multi_queue logs an error on unsupported firmware.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 134 ++++++++++++++++++++---------
 1 file changed, 94 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index fa2d4777ffc7..b3b3886c3eed 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -597,11 +597,73 @@ static inline void ibmveth_flush_buffer(void *addr, unsigned long length)
 		asm("dcbf %0,%1,1" :: "b" (addr), "r" (offset));
 }
 
+/**
+ * ibmveth_add_logical_lan_buffers - Add receive buffers to hypervisor
+ * @adapter: ibmveth adapter structure
+ * @descs: array of buffer descriptors to add
+ * @filled: number of valid descriptors in the array
+ * @buff_size: size of each buffer (multi-queue mode only)
+ * @queue_index: RX queue index
+ *
+ * Return: hypervisor return code
+ */
+static long ibmveth_add_logical_lan_buffers(struct ibmveth_adapter *adapter,
+					    union ibmveth_buf_desc *descs,
+					    int filled,
+					    unsigned long buff_size,
+					    int queue_index)
+{
+	struct vio_dev *vdev = adapter->vdev;
+	unsigned long rc;
+
+	if (adapter->multi_queue) {
+		unsigned long buffersznum = (buff_size << 32) | filled;
+		unsigned long ioba[IBMVETH_MAX_RX_PER_HCALL / 2] = {0};
+		int i;
+
+		/* Pack descriptor addresses into ioba pairs.
+		 * Each ioba holds two 32-bit addresses packed into 64 bits:
+		 * - Even descriptors (0,2,4...) go in high 32 bits
+		 * - Odd descriptors (1,3,5...) go in low 32 bits
+		 */
+		for (i = 0; i < filled && i < IBMVETH_MAX_RX_PER_HCALL; i++) {
+			int pair_idx = i / 2;           /* Which pair: 0-5 */
+			int is_high = (i % 2 == 0);     /* High or low 32 bits */
+
+			if (is_high)
+				ioba[pair_idx] = (unsigned long)descs[i].fields.address << 32;
+			else
+				ioba[pair_idx] |= descs[i].fields.address;
+		}
+
+		rc = h_add_logical_lan_buffers_queue(vdev->unit_address,
+						     adapter->queue_handle[queue_index],
+						     buffersznum,
+						     ioba[0], ioba[1], ioba[2],
+						     ioba[3], ioba[4], ioba[5]);
+		adapter->hcall_stats.add_bufs_queue++;
+	} else if (filled == 1) {
+		rc = h_add_logical_lan_buffer(vdev->unit_address,
+					      descs[0].desc);
+		adapter->hcall_stats.add_buf++;
+	} else {
+		rc = h_add_logical_lan_buffers(vdev->unit_address,
+					       descs[0].desc, descs[1].desc,
+					       descs[2].desc, descs[3].desc,
+					       descs[4].desc, descs[5].desc,
+					       descs[6].desc, descs[7].desc);
+		adapter->hcall_stats.add_bufs++;
+	}
+
+	return rc;
+}
+
 /* replenish the buffers for a pool.  note that we don't need to
  * skb_reserve these since they are used for incoming...
  */
 static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
-					  struct ibmveth_buff_pool *pool)
+					  struct ibmveth_buff_pool *pool,
+					  int queue_index)
 {
 	union ibmveth_buf_desc descs[IBMVETH_MAX_RX_PER_HCALL] = {0};
 	u32 remaining = pool->size - atomic_read(&pool->available);
@@ -687,24 +749,15 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
 		if (!filled)
 			break;
 
-		/* single buffer case*/
-		if (filled == 1)
-			lpar_rc = h_add_logical_lan_buffer(vdev->unit_address,
-							   descs[0].desc);
-		else
-			/* Multi-buffer hcall */
-			lpar_rc = h_add_logical_lan_buffers(vdev->unit_address,
-							    descs[0].desc,
-							    descs[1].desc,
-							    descs[2].desc,
-							    descs[3].desc,
-							    descs[4].desc,
-							    descs[5].desc,
-							    descs[6].desc,
-							    descs[7].desc);
+		lpar_rc = ibmveth_add_logical_lan_buffers(adapter, descs,
+							  filled,
+							  pool->buff_size,
+							  queue_index);
+
 		if (lpar_rc != H_SUCCESS) {
 			dev_warn_ratelimited(dev,
-					     "RX h_add_logical_lan failed: filled=%u, rc=%lu, batch=%u\n",
+					     "RX h_add_logical_lan %s failed: filled=%u, rc=%lu, batch=%u\n",
+					     adapter->multi_queue ? "_queue" : "",
 					     filled, lpar_rc, batch);
 			goto hcall_failure;
 		}
@@ -745,24 +798,19 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
 		}
 		adapter->replenish_add_buff_failure += filled;
 
-		/*
-		 * If multi rx buffers hcall is no longer supported by FW
-		 * e.g. in the case of Live Partition Migration
-		 */
-		if (batch > 1 && lpar_rc == H_FUNCTION) {
-			/*
-			 * Instead of retry submit single buffer individually
-			 * here just set the max rx buffer per hcall to 1
-			 * buffers will be respleshed next time
-			 * when ibmveth_replenish_buffer_pool() is called again
-			 * with single-buffer case
-			 */
-			netdev_info(adapter->netdev,
-				    "RX Multi buffers not supported by FW, rc=%lu\n",
-				    lpar_rc);
-			adapter->rx_buffers_per_hcall = 1;
-			netdev_info(adapter->netdev,
-				    "Next rx replesh will fall back to single-buffer hcall\n");
+		if (lpar_rc == H_FUNCTION) {
+			if (adapter->multi_queue) {
+				netdev_err(adapter->netdev,
+					   "Unexpected H_FUNCTION from multi-queue buffer add (queue=%d, batch=%d)\n",
+					   queue_index, batch);
+				break;
+			} else if (batch > 1) {
+				netdev_warn(adapter->netdev,
+					    "H_FUNCTION from legacy batch buffer add (batch=%d), falling back to single buffer mode\n",
+					    batch);
+				adapter->rx_buffers_per_hcall = 1;
+				continue;
+			}
 		}
 		break;
 	}
@@ -784,18 +832,24 @@ static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter)
 }
 
 /* replenish routine */
-static void ibmveth_replenish_task(struct ibmveth_adapter *adapter)
+static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
+				   int queue_index)
 {
 	int i;
 
+	if (queue_index >= adapter->num_rx_queues)
+		return;
+
 	adapter->replenish_task_cycles++;
 
 	for (i = (IBMVETH_NUM_BUFF_POOLS - 1); i >= 0; i--) {
-		struct ibmveth_buff_pool *pool = &adapter->rx_buff_pool[0][i];
+		struct ibmveth_buff_pool *pool =
+			&adapter->rx_buff_pool[queue_index][i];
 
 		if (pool->active &&
 		    (atomic_read(&pool->available) < pool->threshold))
-			ibmveth_replenish_buffer_pool(adapter, pool);
+			ibmveth_replenish_buffer_pool(adapter, pool,
+						      queue_index);
 	}
 
 	ibmveth_update_rx_no_buffer(adapter);
@@ -2307,7 +2361,7 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 		}
 	}
 
-	ibmveth_replenish_task(adapter);
+	ibmveth_replenish_task(adapter, 0);
 
 	if (frames_processed == budget)
 		goto out;
@@ -2458,7 +2512,7 @@ static void ibmveth_poll_controller(struct net_device *dev)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(dev);
 
-	ibmveth_replenish_task(adapter);
+	ibmveth_replenish_task(adapter, 0);
 	ibmveth_interrupt(dev->irq, &adapter->napi[0]);
 }
 #endif
-- 
2.39.3 (Apple Git-146)


