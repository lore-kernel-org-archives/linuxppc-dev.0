Return-Path: <linuxppc-dev+bounces-23207-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BDE3C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 14:54:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqR4P1sNMz2yyy;
	Wed, 01 Jul 2026 00:54:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782831253;
	cv=none; b=YN4sXNRF+D5rvSaFts438EmS7qZGFgcFiof9FyC9Kl4y1AEjnxOsS5K0g1XFbgWBKjYA7Dk1I+xVsBrrqibAyKp621n+efM/G8JC+/jdTeHNMZtF8C2po9nJ6VV2e+DkghhrA5NThxMJVr+YYzOEaVpFRYzD45+EfbVuSQFYHPQEO7DooK7JaeKYP+1UXeV5OOTDTRZrMF9DO/6j7o1u+rntyj+bKCJQ4S9mgXiyattsnN5i5vAgX/12W2r1EyTljKmGS09rD+yHTSQWQyBB5t7SpzvEqegd6M4VJ6JqeS2aMvogB1ZR/1CiQLK7CV5wm1wVw+wx8/pSkSfJcJzc3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782831253; c=relaxed/relaxed;
	bh=RZjo9KniSD0qcbgoF1ISjVcr/SurARDGU5dqH0fFeio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JF6RMb4WPsM/iFFwrc6iFRFTyeESsduYIny9+moY8nqlPfmsbzI+mFyKSovyXj2CKYyRG1FXtdy9kDRJdsXc5Wn5I0dKW/MBxnfLso/yTfIglAbCAH9TpqCoGTXbCcbsnnFygn9qFsDdkl8edJgEdFo2Kzp0wNzfuejst0FcZbUAUiKOqHky13FR1WDgRSKzYNas/Fgua65kVupv1fuIef0T45D6QXmt4pKagMCZR67/5sW7Qj63Rja79WQNobpwszYR7sIAJc1EaemaR33YErAnOonfnnj8cS4yW5m1JgaAh/HxWJjWkoWadfyWwQ8fF4wo3hwba2kxIcKJlwMkPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pu3QujlA; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pu3QujlA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqR4N354dz2ygh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 00:54:12 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UEIO8M2124266;
	Tue, 30 Jun 2026 14:54:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RZjo9KniSD0qcbgoF
	1ISjVcr/SurARDGU5dqH0fFeio=; b=pu3QujlAlXm7/C2hn2+Hi6yQpvnZtzfee
	8/MZ3DNWFHEcd0yyKF9ZHWdb/QJkEtaDO3KcBOqvi4hDPYg9kwXAJJmBuRC2OanK
	efWw9oO4ZAhlLuZbV5FGWtJdrHRhmeEyA4C2jM+H8Mz0nr3In2pEe0+1tuBjQeGU
	oSkZn3bWeN6Kibky5SiCtQ2faIF/VYPlWkf3MlLUC36e35KCGU/gCegQdVeCcx4v
	kLx4NmCjz9aB+e5MFg0O1zV9QhmLqmKMADzh8Jv+M5mvkD3qLS7Y7gHlCwH3QAWu
	m5TZ/RgaAagllpI94sB4iKhiLEAnPOF3f8UDAq4ZeaJA7qprZhRdQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mjq5dq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 14:54:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UEnflX000654;
	Tue, 30 Jun 2026 14:54:01 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhaphk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 14:54:01 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UEs0wH25559638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 14:54:00 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 475D15805C;
	Tue, 30 Jun 2026 14:54:00 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E79E658054;
	Tue, 30 Jun 2026 14:53:58 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.117.151])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 14:53:58 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH v1 10/18] ibmveth: Add queue-aware RX buffer submit helper for MQ
Date: Tue, 30 Jun 2026 07:53:17 -0700
Message-Id: <69237a637d1dec620c84267360af95dc84c6765d.1782758799.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1782758799.git.mmc@linux.ibm.com>
References: <cover.1782758799.git.mmc@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEzOSBTYWx0ZWRfX4i4hPSqABIlb
 wYXxiqMOpVMHjm6STgzHZwPeVKHYFC8GYwqTIt0PWz2h9G14jmGwKlE/OqXJ7ft9f1YF21n41VD
 2Q8WG/55LutVGpxbQwQ6Mot7Xoo0+BGYBJX4PKtJ4REWZDtUfC0f5QUFIlZ5h237UqzjznM1dkc
 p4/MfoYB63A/9WRAZDcNPhLqryhsVo9yUBMRYGd8CxPQh10Gz7Nu5uY7PGzTCDJ0U5dE96qAMRy
 qfInD3+CGivgOPPVlWFyHchijPO80xwXA5Q3zf/gKK+ADfcX13RSgV7ZRjEaGk/iH7WAryd6Bsn
 PBI7FSwKlRCQItJS/xx4XVc1duHbPSXs80Im/0xR2M1cAs8baBSnWqDesH9BrCLXT60KqlIIIJL
 N5X4lNojqe8TOf8yp9Xv4Z4PGXVbKSBmoyWzwaYtfWwmJSATQIQhXgGBiYGH6+UpnBmLILY6ldB
 gD2oWRa5QCVbnfwiP2Q==
X-Proofpoint-GUID: 8HNGQvppqLH-idpY-kLj1kh68A3npXdy
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a43d88a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=DGqNc8_RdM7thkqK1-0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEzOSBTYWx0ZWRfX3NgL2g9cCv8J
 F0Rx7AfwOCXHPkYE6Y+eruBVLqsJUSKGnU+DtWUYstsAtkpCgwmjgHwU4NyzfcbCzbtnWp4IZyw
 Lo35HejdByGoOIb/hkozAmuCCe9SdkA=
X-Proofpoint-ORIG-GUID: ZpwMX9aG5c6QkHkj59a5dtq1ea4Ih0ZL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300139

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


