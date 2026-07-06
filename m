Return-Path: <linuxppc-dev+bounces-23657-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6582C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 19:37:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvF3y4mP6z3c3y;
	Tue, 07 Jul 2026 05:37:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783366622;
	cv=none; b=hxYeA5KMhOwwKGwadHNqE8hcILw4u21U8RIhbQ7tZbA5rPgYYMsKsU9OL/ZCQILWVecWh8H6p6PuhWeIrFyNrGM4sw05OlSDzuiz03rrA2KZzTe1dOP0vO5vO+tRCO8mIlANcl5AvxjWvaEBwff/OVpLNJiV3vUF0sZ7xSwOMkvaIrf91KfiLQbyev2NrrTEhHID1b0l8BpDhaHSt0GFuKGxFryg95PxLjGLciJA8EeZSHfYfsf1cBKoJi0kLcU9J91hkrXPYrNl6UyMZIl5SvGNTGKIhYajp8aW8TM7mKJ4WvBa8qYkAPTpRHXng1NFjwIfnYkNS/vEVr9LVFOnxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783366622; c=relaxed/relaxed;
	bh=RZjo9KniSD0qcbgoF1ISjVcr/SurARDGU5dqH0fFeio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HEnqfcIaSzUWNGGaLuzIiGIkK7YGledIkxycyRdELtzWfJ4YcgAHXcJVYqC+OvWHvTuQLN9LxuOaLibd8UH90K9LsOXHd2LHH35qjHydcZBy0H3EGbFNbNkhbcSNnXs9Tp6gqqhHAp1lnJR8gAXhVx+7FolFli63YpJHv6WrhjjC+iSk9oxCi2K1nvwU+w2gnIjjY2A09Cs7Oj+5fp1J6+YIkwJYzMp41Qmzq+ZXCtp5zsEZ40HYmlZmT4eSkvzM96nBMnp4IY/3ds3RykCzGQp4uOSqmBSlzf0c3+vKAC/DfjYHCjxuAQ0AWuoV4BsY3Ge6FKTfRcM1ebXPn+89rA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SrzPztWZ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SrzPztWZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvF3x6458z3br5
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 05:37:01 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FIPHF4050075;
	Mon, 6 Jul 2026 19:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RZjo9KniSD0qcbgoF
	1ISjVcr/SurARDGU5dqH0fFeio=; b=SrzPztWZDB1oo3Wp8GWV4zPB+fWtZ49BN
	kFPMuGiGYVAjt3mgeFd+lQHgxeHTFiumkZat2Uhoai0ZiefStMbnhM9fxrW4m58y
	CtRmpvZAwLLfsY34nXfK/H44O9ZUfTjEaZk8kD73MAmHD5O79Ky9QvudrSnHmgP9
	UkC6AwpQ9L1AUyzHgqnldM5OCrGodAGpMA8+BWAgKmtW1CGmg0f99YKj/McjHNWZ
	bw4nwd3IAZpHt8jMpKWjAbxzR00Gd5DBY/ZdFPiEA2HT0FzdUdDOeYHnUk5VDAOZ
	S9BTQuHG0B7IaPd3BTMge7I5x/NyAH7PLXAQlW2YDBu7dVvYJgfKQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stskjyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 19:36:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666JYkGQ013179;
	Mon, 6 Jul 2026 19:36:51 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6xxmww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 19:36:51 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666Jao5232375358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 19:36:50 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D1255805C;
	Mon,  6 Jul 2026 19:36:50 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 552F758051;
	Mon,  6 Jul 2026 19:36:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.26.177])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 19:36:49 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH net-next v3 09/15] ibmveth: Add queue-aware RX buffer submit helper for MQ
Date: Mon,  6 Jul 2026 12:35:57 -0700
Message-Id: <20260706193603.8039-10-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260706193603.8039-1-mmc@linux.ibm.com>
References: <20260706193603.8039-1-mmc@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: GpnCdwnLNJ1eLhP2SEpZ8Y3LRis3Ku9f
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE5NSBTYWx0ZWRfX67kDlAVLJjtW
 LHTnsW0MNDugH5PHZszOMky4mApZqQO5EUIiBrmBdvvrMEu38RvSpgWJcv3VJbUoL3DTYa42zzj
 DxKaoOVTgt3qNkpJuRNtw9qwZTHtO7M=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4c03d4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=DGqNc8_RdM7thkqK1-0A:9
X-Proofpoint-GUID: UfPxPljR_t10C32lCHdiXyi0Vji0WUww
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE5NSBTYWx0ZWRfX4p+wMQXFCBpH
 isZzXdEeIjrsYLEmIBJWkLvbbpZrwURpt7kuzGMwdhf4sla+ZREFbMRyhKaE5uqnruEPMiTnD9R
 fQlQ53CnGXu2LWSm6DZ8odW5nwsX6G6vSvDz1KaE9inaXZVXMiqsTm7nlI2uC90myG2/TdZgF6k
 YoEcljQ133rFW2isRjoDacg1VsvPK1131OHo3tONtShAeXDWYvU2sN4ss/Y1VJ00jbunMICxapA
 9AJhaJ31bdoWuJq0xNl9EJ8IGp17hILvqdIorLj7ocI3wJ16oSCqrIq9ICBQNed3ddOdBZNEkkx
 /nScdn0nz5qTaoJERJBsaTjZnjd5ADxYYvMzsZXLxgt5vaAYSm0hH1jZU7HXOd8/x+5Nb+os/Ud
 56uvMSmMD1w8K+m/dypMOvlKGqTeWtxKhH+oYm5IZ3ctM3KVWSsYaWgfw2wqA43Jk/Y0ty+Rcd2
 yVdrLcxxqN1zIJefudA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060195

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


