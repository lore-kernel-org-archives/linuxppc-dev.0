Return-Path: <linuxppc-dev+bounces-25149-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EA7C55167
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2026 00:48:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hB6qq6l4Qz2yqs;
	Fri, 31 Jul 2026 10:48:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785458887;
	cv=none; b=fhVQ+dNoSyv8pmp2tSleos03MFGuexeRIBvYdoXHfUOyzTiCQbvh0A73Na7pImmKhJjvKt38j4MlTLisx7p65MztBY6cySOUZ85ItIaqO4BPjw0W2YDymrOlg5UxnloX79GvKqUZimEFZr3aFcip7ktGRKETJdKOQgIwTvNEumD3oawJmqFs4r0b1UlVoP6HZwwzFVdCadJTo137/MrGxUDuc4XM9u8Yj/Z1WiV0BuvcVKxbHHFakrYrNllrklZDDoBT0eEGMlFK8JJUJvNfgzmtnoJvxWRBw4jT8g6B1AtPcbSIqLb4PYH3NuZPkDwE2zQsttL+3b4QtBoI8vWQQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785458887; c=relaxed/relaxed;
	bh=+4K0DPPLXrfmjcVODYWArncUxMT+fIBnLkE4agSaeBs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RDAoXzzWUyUJFAWbW4ZnbrDANESIItxiC6308ucxGc3meH8fgHGXeytBrTLqW8evVw3zJreZT3cD5h9JloB79ll/z0AwFAtWAGTcGXT8P5ziuCSGagIPtrq5Lu0qJIsNzTN8YR07yqKyItKbOSvbHITUn8itCUCkbJDiHdeDf/z3A7vcVqHHl02KmSx6EktP+lFVGERHQXPPG6E0ANooHfErRxJ0H5f0BqyhINYylUW9cJXdz3n78Z/qC/NVEgB3zUPpYW25WIVinR+y7d7Nm1lxK4wjzz0+PecJJaKylKZeYR89nKVFMY5dgPcaDmQdixCd3Brg0SpLWWdAd18RFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RQSVsjt+; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RQSVsjt+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hB6qp00Dqz2xlQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 10:48:05 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UNHbIe2518072;
	Fri, 31 Jul 2026 00:47:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+4K0DPPLXrfmjcVOD
	YWArncUxMT+fIBnLkE4agSaeBs=; b=RQSVsjt+WO9cuwY5M3iYr4f+8gfENuC4F
	N1HFMrw7c67rUVw8F9Hnuav1F6FK7JhrpI7br/VFIYdclbkre/uwvA3fIZer/Ivf
	MtXFSo8pYhjXKWLxLkeu63B8NW6NK5wFWOpcMawIWqUVmRNmMIxmbksNdDRfJQgu
	6n6JEqwcd8nRysYku2suNCHQPS803LcpCEbbWZmgJigk5xHvQy/D06h9bTve+0+j
	T7rYTXfsa2YlbxPohIOT4dyy7J3Xdu9EiZJRyva78mENkyzc5aWIeweqdrBzq1L+
	LwG77jM8aqkWPDcaGIdHHZF/9pWxS7NdfFqDt3GjXeq0xB7wjHigw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycthhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 00:47:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66V0fJdD031552;
	Fri, 31 Jul 2026 00:47:53 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgnpdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 00:47:53 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66V0lqFV26542592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 00:47:53 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC2FE58059;
	Fri, 31 Jul 2026 00:47:52 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6D2558057;
	Fri, 31 Jul 2026 00:47:51 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.44.71])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 00:47:51 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, davem@davemloft.net,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        simon.horman@corigine.com, shaik.abdulla1@ibm.com,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH net-next v4 05/14] ibmveth: Refactor RX interrupt control for MQ RX queues
Date: Thu, 30 Jul 2026 17:47:08 -0700
Message-Id: <3375291b81496032d02dc769c962a2fa323fb20b.1785457143.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1785457143.git.mmc@linux.ibm.com>
References: <cover.1785457143.git.mmc@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 7ZS5Mx9k1Q7wKdyaVWntZpB2rJA-frDv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDAwMyBTYWx0ZWRfXxmXnKWecKiJD
 er2VlUZttvdXVTwVwMyX3aBpUywewwzMfqJeuQ09qaeSNy1DODb3HHfcK2KND3/Hqg6FwtsahbI
 VG1WSVE90SGcEgnOsnDuo73WLineQfo5we7m5EzDziLj2D47zmUO+VDB0ZvUZdd7Z0MfFBnsysZ
 tR2qzm08bqczX9IfPfeH5xKNiuw5ymnGOS7I4TiLWyLUBVBtxB0robi0Ipyw7NV5I+z9Jpsj/4J
 XU0UhJ6aLOggLBNXGQlCr8PNhtAyr9VUA050KeuE2+9aZYLqgkFT0YjA+CLASU7gfjUe7INvxgB
 6lbIHAavdf2kELAgSdsxLvsAlUO7dAZDyC1zgmJHcFo8i2wec3UH8N4Tuhm7mVdbBT61lMzlNRM
 AEz5grZ2+cbaJ5GY0udvB8mjFH5TW4LhBVHfL45Xhr3BLzTqmKTPvHuQhuE4mNNO+w3SIX+8mYb
 EJZHjSbLZvxb11JmGow==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDAwMyBTYWx0ZWRfX6IvEIP0iqVza
 aPXTB+wx+lYt/jDGNe4sttWL5hOIYdhCqlVAx0IP29Vh5XWkVabXRlNTQHCSnx3FrZIDrojhSQ5
 Ir9TQfhg9Oe6ZtoUv1F/Anbkp9Q58jY=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6bf0bb cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=3MmicaTprrt6KLCmupAA:9
X-Proofpoint-GUID: nTsXOhlErhFrUMwpvVuYo_6cSlXb-gtw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310003

Queue 0 and subordinate RX queues use different interrupt control
interfaces in PHYP:

  - queue 0: h_vio_signal() after h_register_logical_lan()
  - queue N: H_VIOCTL against the queue handle/hwirq mapping

The current code is single-queue oriented and cannot safely scale to
multiple RX queues in poll completion and open/close IRQ setup.

Introduce queue-indexed interrupt helpers and wire them into
open()/close()/poll()/interrupt in the same patch:

  ibmveth_toggle_irq() / enable_irq() / disable_irq()
  ibmveth_setup_rx_interrupts() / ibmveth_cleanup_rx_interrupts()
  ibmveth_schedule_rx_queue()

These helpers centralize queue0-vs-subordinate dispatch.
request_irq() uses &adapter->napi[i] as the per-queue cookie so the
handler can resolve the queue index.

Move napi_enable() into setup_rx_interrupts() (after LAN registration
and buffer-pool allocation): request_irq -> napi_enable. In this
single-queue tree, setup does not yet unmask PHYP; the first poll/kick
still enables queue 0 via schedule_rx_queue().

Factor process-context RX kicks (open, resume, pool sysfs, netpoll)
into ibmveth_schedule_rx_queue(); keep ibmveth_interrupt() as a thin
IRQ-only wrapper.

cleanup_rx_interrupts() masks PHYP and synchronizes IRQs before
napi_disable (intentional storm-safety vs classic close ordering).

Runtime remains single-queue (num_rx_queues is still 1).

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---

Changes in v4:
- Include irq.h / irqdomain.h with first irq_dispose_mapping() use.
- Introduce IRQ helpers in the same patch that wires open/close/poll
  callers, instead of leaving unused statics.
- Factor process-context RX kicks into ibmveth_schedule_rx_queue();
  keep ibmveth_interrupt() as the IRQ-only wrapper.
- On cleanup, mask PHYP and synchronize_irq before napi_disable
  (storm-safety; not fully behavior-preserving vs classic close).
- Leave queue_irq[0] set after cleanup (queue 0 uses netdev->irq;
  next open reuses it). Only subordinate virqs are disposed.

 drivers/net/ethernet/ibm/ibmveth.c | 258 +++++++++++++++++++++++++----
 1 file changed, 225 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 7a2ed49cad4f..664169c4d27a 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -21,6 +21,8 @@
 #include <linux/skbuff.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/mm.h>
 #include <linux/pm.h>
 #include <linux/ethtool.h>
@@ -329,6 +331,203 @@ ibmveth_cleanup_rx_resources(struct ibmveth_adapter *adapter)
 	}
 }
 
+/**
+ * ibmveth_toggle_irq - Common helper to enable/disable queue interrupts
+ * @adapter: ibmveth adapter structure
+ * @queue_index: Index of the queue (0 for primary, 1+ for subordinate)
+ * @enable: true to enable, false to disable
+ *
+ * For queue 0 (primary), uses h_vio_signal() as it's registered via
+ * h_register_logical_lan(). For subordinate queues (1+), uses H_VIOCTL
+ * with H_ENABLE/DISABLE_VIO_INTERRUPT for per-queue interrupt control.
+ *
+ * Return: 0 on success, error code otherwise
+ */
+static int
+ibmveth_toggle_irq(struct ibmveth_adapter *adapter, int queue_index,
+		   bool enable)
+{
+	unsigned long rc;
+	unsigned long irq = adapter->queue_irq[queue_index];
+	const char *action = enable ? "enable" : "disable";
+
+	if (queue_index == 0) {
+		/* Primary queue: use h_vio_signal() */
+		rc = h_vio_signal(adapter->vdev->unit_address,
+				  enable ? VIO_IRQ_ENABLE : VIO_IRQ_DISABLE);
+	} else {
+		/* Subordinate queues: use H_VIOCTL with hardware IRQ */
+		struct irq_data *irq_data = irq_get_irq_data(irq);
+		irq_hw_number_t hwirq;
+		u64 vioctl_cmd = enable ? H_ENABLE_VIO_INTERRUPT :
+			H_DISABLE_VIO_INTERRUPT;
+
+		if (!irq_data) {
+			netdev_err(adapter->netdev,
+				   "Failed to get IRQ data for queue %d (virq=%lu)\n",
+				   queue_index, irq);
+			return -EINVAL;
+		}
+
+		hwirq = irqd_to_hwirq(irq_data);
+		rc = plpar_hcall_norets(H_VIOCTL,
+					adapter->vdev->unit_address,
+					vioctl_cmd,
+					hwirq, 0, 0);
+
+		if (rc == H_PARAMETER) {
+			/* H_PARAMETER is non-fatal when IRQ is already in
+			 * the requested state.
+			 */
+			netdev_warn_once(adapter->netdev,
+					 "H_VIOCTL %s IRQ returned H_PARAMETER for queue %d (hwirq=%lu)\n",
+					 action, queue_index, hwirq);
+			return 0;
+		}
+	}
+
+	if (rc)
+		netdev_err(adapter->netdev,
+			   "Failed to %s IRQ for queue %d, rc=%ld\n",
+			   action, queue_index, rc);
+	return rc;
+}
+
+/**
+ * ibmveth_disable_irq - Disable interrupt for a specific queue
+ * @adapter: ibmveth adapter structure
+ * @queue_index: Index of the queue (0 for primary, 1+ for subordinate)
+ *
+ * Return: 0 on success, error code otherwise
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
+ * @queue_index: Index of the queue (0 for primary, 1+ for subordinate)
+ *
+ * Return: 0 on success, error code otherwise
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
+ * Registers interrupt handlers for all RX queues and enables NAPI polling.
+ * On error, cleans up any successfully registered IRQs before returning.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int
+ibmveth_setup_rx_interrupts(struct ibmveth_adapter *adapter)
+{
+	struct net_device *netdev = adapter->netdev;
+	int i, rc;
+
+	for (i = 0; i < adapter->num_rx_queues; i++) {
+		if (!adapter->queue_irq[i]) {
+			netdev_err(netdev, "queue %d has invalid IRQ (0)\n", i);
+			rc = -EINVAL;
+			goto err_free_irqs;
+		}
+
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
+	for (i = 0; i < adapter->num_rx_queues; i++)
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
+ * ibmveth_cleanup_rx_interrupts - Mask PHYP, disable NAPI, free IRQs
+ * @adapter: ibmveth adapter structure
+ *
+ * Tears down RX interrupt delivery for all queues. Mask PHYP before
+ * napi_disable so ibmveth_interrupt cannot return IRQ_HANDLED without
+ * masking (same storm window as scale-down). Safe for close and for
+ * open failure after setup_rx_interrupts() already unmasked PHYP.
+ */
+static void
+ibmveth_cleanup_rx_interrupts(struct ibmveth_adapter *adapter)
+{
+	int i;
+
+	for (i = 0; i < adapter->num_rx_queues; i++) {
+		if (adapter->queue_irq[i]) {
+			ibmveth_disable_irq(adapter, i);
+			synchronize_irq(adapter->queue_irq[i]);
+		}
+	}
+
+	for (i = 0; i < adapter->num_rx_queues; i++)
+		napi_disable(&adapter->napi[i]);
+
+	for (i = 0; i < adapter->num_rx_queues; i++) {
+		if (adapter->queue_irq[i])
+			free_irq(adapter->queue_irq[i], &adapter->napi[i]);
+	}
+
+	/* Dispose IRQ mappings for subordinate queues (1-15).
+	 * Queue 0 uses netdev->irq from device tree, not irq_create_mapping().
+	 */
+	for (i = 1; i < adapter->num_rx_queues; i++) {
+		if (adapter->queue_irq[i]) {
+			irq_dispose_mapping(adapter->queue_irq[i]);
+			adapter->queue_irq[i] = 0;
+		}
+	}
+
+	/* Queue 0 uses netdev->irq; leave queue_irq[0] for next open. */
+}
+
+/**
+ * ibmveth_schedule_rx_queue - Mask PHYP IRQ and schedule NAPI for one RX queue
+ * @adapter: ibmveth adapter structure
+ * @qindex: RX queue index
+ *
+ * Shared by the IRQ handler and process-context kick paths (open, resume,
+ * pool sysfs, netpoll). Keep ibmveth_interrupt() as the IRQ-only wrapper.
+ */
+static void ibmveth_schedule_rx_queue(struct ibmveth_adapter *adapter,
+				      int qindex)
+{
+	struct napi_struct *napi = &adapter->napi[qindex];
+	unsigned long lpar_rc;
+
+	if (WARN_ON(qindex < 0 || qindex >= adapter->num_rx_queues))
+		return;
+
+	if (napi_schedule_prep(napi)) {
+		lpar_rc = ibmveth_disable_irq(adapter, qindex);
+		WARN_ON(lpar_rc != H_SUCCESS);
+		__napi_schedule(napi);
+	}
+}
+
 /* setup the initial settings for a buffer pool */
 static void ibmveth_init_buffer_pool(struct ibmveth_buff_pool *pool,
 				     u32 pool_index, u32 pool_size,
@@ -947,8 +1146,6 @@ static int ibmveth_open(struct net_device *netdev)
 
 	netdev_dbg(netdev, "open starting\n");
 
-	napi_enable(&adapter->napi[0]);
-
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
 		rxq_entries += adapter->rx_buff_pool[0][i].size;
 
@@ -972,7 +1169,8 @@ static int ibmveth_open(struct net_device *netdev)
 					adapter->rx_queue[0].queue_len;
 	rxq_desc.fields.address = adapter->rx_queue[0].queue_dma;
 
-	h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_DISABLE);
+	adapter->queue_irq[0] = netdev->irq;
+	ibmveth_disable_irq(adapter, 0);
 
 	lpar_rc = ibmveth_register_logical_lan(adapter, rxq_desc, mac_address);
 
@@ -993,21 +1191,16 @@ static int ibmveth_open(struct net_device *netdev)
 	if (rc)
 		goto out_free_tx_ltb;
 
-	netdev_dbg(netdev, "registering irq 0x%x\n", netdev->irq);
-	rc = request_irq(netdev->irq, ibmveth_interrupt, 0, netdev->name,
-			 netdev);
-	if (rc != 0) {
-		netdev_err(netdev, "unable to request irq 0x%x, rc %d\n",
-			   netdev->irq, rc);
+	rc = ibmveth_setup_rx_interrupts(adapter);
+	if (rc) {
 		do {
 			lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
 		} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
-
 		goto out_free_buffer_pools;
 	}
 
 	netdev_dbg(netdev, "initial replenish cycle\n");
-	ibmveth_interrupt(netdev->irq, netdev);
+	ibmveth_schedule_rx_queue(adapter, 0);
 
 	netif_tx_start_all_queues(netdev);
 
@@ -1024,7 +1217,6 @@ static int ibmveth_open(struct net_device *netdev)
 out_free_filter_list:
 	ibmveth_free_filter_list(adapter);
 out:
-	napi_disable(&adapter->napi[0]);
 	return rc;
 }
 
@@ -1036,11 +1228,10 @@ static int ibmveth_close(struct net_device *netdev)
 
 	netdev_dbg(netdev, "close starting\n");
 
-	napi_disable(&adapter->napi[0]);
-
 	netif_tx_stop_all_queues(netdev);
 
-	h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_DISABLE);
+	/* PHYP mask + napi_disable + free_irq live in cleanup_rx_interrupts */
+	ibmveth_cleanup_rx_interrupts(adapter);
 
 	do {
 		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
@@ -1051,8 +1242,6 @@ static int ibmveth_close(struct net_device *netdev)
 			   "continuing with close\n", lpar_rc);
 	}
 
-	free_irq(netdev->irq, netdev);
-
 	ibmveth_update_rx_no_buffer(adapter);
 
 	ibmveth_free_buffer_pools(adapter);
@@ -1798,15 +1987,14 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 	/* We think we are done - reenable interrupts,
 	 * then check once more to make sure we are done.
 	 */
-	lpar_rc = h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_ENABLE);
+	lpar_rc = ibmveth_enable_irq(adapter, 0);
 	if (WARN_ON(lpar_rc != H_SUCCESS)) {
 		schedule_work(&adapter->work);
 		goto out;
 	}
 
 	if (ibmveth_rxq_pending_buffer(adapter) && napi_schedule(napi)) {
-		lpar_rc = h_vio_signal(adapter->vdev->unit_address,
-				       VIO_IRQ_DISABLE);
+		lpar_rc = ibmveth_disable_irq(adapter, 0);
 		goto restart_poll;
 	}
 
@@ -1816,16 +2004,16 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 
 static irqreturn_t ibmveth_interrupt(int irq, void *dev_instance)
 {
-	struct net_device *netdev = dev_instance;
+	struct napi_struct *napi = dev_instance;
+	struct net_device *netdev = napi->dev;
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
-	unsigned long lpar_rc;
+	int qindex;
 
-	if (napi_schedule_prep(&adapter->napi[0])) {
-		lpar_rc = h_vio_signal(adapter->vdev->unit_address,
-				       VIO_IRQ_DISABLE);
-		WARN_ON(lpar_rc != H_SUCCESS);
-		__napi_schedule(&adapter->napi[0]);
-	}
+	qindex = napi - adapter->napi;
+	if (WARN_ON(qindex < 0 || qindex >= adapter->num_rx_queues))
+		return IRQ_NONE;
+
+	ibmveth_schedule_rx_queue(adapter, qindex);
 	return IRQ_HANDLED;
 }
 
@@ -1930,8 +2118,10 @@ static int ibmveth_change_mtu(struct net_device *dev, int new_mtu)
 #ifdef CONFIG_NET_POLL_CONTROLLER
 static void ibmveth_poll_controller(struct net_device *dev)
 {
-	ibmveth_replenish_task(netdev_priv(dev));
-	ibmveth_interrupt(dev->irq, dev);
+	struct ibmveth_adapter *adapter = netdev_priv(dev);
+
+	ibmveth_replenish_task(adapter);
+	ibmveth_schedule_rx_queue(adapter, 0);
 }
 #endif
 
@@ -2343,8 +2533,8 @@ static ssize_t veth_pool_store(struct kobject *kobj, struct attribute *attr,
 	}
 	rtnl_unlock();
 
-	/* kick the interrupt handler to allocate/deallocate pools */
-	ibmveth_interrupt(netdev->irq, netdev);
+	/* kick RX processing to allocate/deallocate pools */
+	ibmveth_schedule_rx_queue(adapter, 0);
 	return count;
 
 unlock_err:
@@ -2384,7 +2574,9 @@ static struct kobj_type ktype_veth_pool = {
 static int ibmveth_resume(struct device *dev)
 {
 	struct net_device *netdev = dev_get_drvdata(dev);
-	ibmveth_interrupt(netdev->irq, netdev);
+	struct ibmveth_adapter *adapter = netdev_priv(netdev);
+
+	ibmveth_schedule_rx_queue(adapter, 0);
 	return 0;
 }
 
-- 
2.50.1 (Apple Git-155)


