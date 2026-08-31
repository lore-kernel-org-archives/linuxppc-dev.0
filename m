Return-Path: <linuxppc-dev+bounces-26306-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3261C624A4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 15:08:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYXSQ2BHpz2yFW;
	Tue, 01 Sep 2026 01:08:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788188918;
	cv=none; b=TzKaAda3W4lG1mWdwX25Bc4l3xjlwAqsoBs68E/BkImo6gEDUUdCxhslIfpllo/N9sOdpi5jOofjSaFyszLclnFZL/Hkz1JtL9Q1D/pUnpG/EYswNGrKT9wTNpEcM3M7WyKU7U2Dln0Axc8W3dZdPWdFnfPjliExYjKLTmyPWZ8C8wdvAw4b0RkBvUc0W1DcciYBUWZJ0Zdb6W6/goeGYRbjdZBV+IGjUSZASLCTfq8d4Jg5K7qzxPcFDQx4P8bPBWp1g5Zs7qFxMCcubO1CwfkP9xNRM+jqt9p3cPmFAAg2rXg8b7zXrAffBicC41NVtC7j6QILIxjwN3m6OjGW2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788188918; c=relaxed/relaxed;
	bh=/LYAeZK0zKc5FC29ERj2MS/6YaHH5eEKKxWpKG9SP1A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HjtMiPm/DxjiQ9+1naZ89y4QaDJh335zWadVnyvrWxrBzN35JwyLqfm6FB0DhyqT9jLwGik/1kuAp3Y5jVNmhS4Nc5NVYPWx3eOuKcFPdaH4S5U6DMh/EP8D8+X9o/oX6Lt5wEuQoR1QwDuchskU/4mHuN4DDMDcsl1Mxx0nyqzpopP1xigOHss9ENLTmLcLgkQ/jBQMt77znyJAhojX8aeAymBmzZJQ7xKMP7Mq/8Lq0pssD6VMh9Y+aSgkR383eLtJxH3Z4mzFPeIOdGgtvX8pnHYlmkSMiBH/9LSrNXhX2XLqtaccanBXVptzjUgf8CdOIFIY2jivcXtsUbs74g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gH2TFCi5; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gH2TFCi5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYXSN6fRkz2yFK
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 01:08:36 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZEU12415005;
	Mon, 31 Aug 2026 15:08:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/LYAeZK0zKc5FC29E
	Rj2MS/6YaHH5eEKKxWpKG9SP1A=; b=gH2TFCi53t/WzK70UsmB9PC0zv8G7aH9/
	0bsGvi0g7aU46z8INWEC02qvLkrIjyi+S/KpoJcVu0t4muGeWZzEsK74KpwR1XkI
	sbLeWv4vueq85bbsJrb+NmhWmLNnp6khF7XiBlC/cKiFZ7Ttz6tmm1c7kInkBPhX
	hAUGFdEv2VGvCKejzfGxyS3kpKTKjZGm9vRZHKkWlIzLe/Ab5w5/Yk8J+f73Skb8
	ldYOLg9+VjGYmX5kSroD0+qD1JODP5kXZLaS8F089fRGFaDFykOE+dmW7TAeb/6c
	xYbWUHzitDAHnc8DkvrNXOK9NWf/K3LRtpNjpFFecRpXSsN5igDzw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuhj8wn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 15:08:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEuKje024293;
	Mon, 31 Aug 2026 15:08:24 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarjxjw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 15:08:24 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VF8Jf964422230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 15:08:20 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C46E858051;
	Mon, 31 Aug 2026 15:08:19 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 018455805A;
	Mon, 31 Aug 2026 15:08:16 +0000 (GMT)
Received: from 192.168.1.50 (unknown [9.67.102.143])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 15:08:15 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
        edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
        nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
        ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        shaik.abdulla1@ibm.com, Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next v6 05/15] ibmveth: Refactor RX interrupt control for MQ RX queues
Date: Mon, 31 Aug 2026 08:07:16 -0700
Message-Id: <8f989bb564874f041ac9648d871c6ff3e3014bb9.1788102125.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1788102125.git.mmc@linux.ibm.com>
References: <cover.1788102125.git.mmc@linux.ibm.com>
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
X-Proofpoint-GUID: nkqfGEvQQAj7nKO4wLoaataGid2eTO9y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfXwNq77S/MmiN+
 7PPCEgBIOp4gFwYHqQaGAe/sDiCjCC+K5Z4U2iI8Y84O8sdbSCZ5Xzdlz6JO6iiT8MZ/XK1odJ9
 Tjanhm6ygIrZxvWnyjZURBdNxCiXb8xTILAw9QzvC3p5AK0ws6sspMlV/o/ATGlT+zIdW69lxEy
 rP4BfGzJkCGEKqyaE1EMH98fH3bx5o9ltLsLGwz9f4wkRyEoMeF9wF7MulJX5S0KSro5dVdAE77
 4irvliGya5TLUwVaUlySucBC/WSSAee5z3ixLcX7Bqam3r5SrEdhnyA+9nHBOFA1RIDoXyCt7bh
 HC/LU0SlB/v3HEE8T/sWKDyONEV/kogIhmOdZRPj+jLtSOAVrYBWgnW6THnfP/MxiELtajzYD6T
 Ge85OOdXv333ZH0ITP/8gpN+1XTECUyGFNtj9B71dyUUzoT/Jr6KrBpQg88O6fwJZSdUFkG6Agg
 AOeso1g7u8DYRhDp/Rg==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a9598e9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=9c5XYJHA5lSF3gzyfG0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfX5tn+FfUfZ77D
 46afACpRroV5gtMvX2aysnKcukYDSl3A1ySrCYWpQe3K96G9ANO3f3+UQ3BsavdmUZ0giZly0Hf
 OOLt/l3BrTT+hudQFpd2UaSJkCxbVvU=
X-Proofpoint-ORIG-GUID: mQTNTINw4L2Cx19CD7rAnUFkY0fp5Xce
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310130

Queue 0 and subordinate RX queues use different interrupt control
interfaces in PHYP:

  - queue 0: h_vio_signal() after h_register_logical_lan()
  - queue N: H_VIOCTL against the queue's mapped hwirq

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
single-queue tree, setup does not yet unmask PHYP; schedule_rx_queue()
masks queue 0 and schedules NAPI, and ibmveth_poll() is what unmasks
it on completion. That order matches the later scale-up rule (NAPI
live before PHYP unmask), not an inverted window relative to it.

Factor process-context RX kicks (open, resume, pool sysfs, netpoll)
into ibmveth_schedule_rx_queue(); keep ibmveth_interrupt() as a thin
IRQ-only wrapper.

cleanup_rx_interrupts() masks PHYP and synchronizes IRQs before
napi_disable, remasks and synchronizes again after it because an
in-flight poll can re-arm, then free_irq. Close then proceeds to
h_free_logical_lan(): free_irq before free_lan is intentional once
PHYP delivery is masked.

On setup_rx enable-fail (MQ path), if enable_irq() fails for queue i,
remask+sync queues 0..i, including the one that failed, before
napi_disable/free_irq; the rollback loop used while (--i) and skipped
it. H_PARAMETER stays an error on enable, so PHYP may already be
unmasked; an unmasked queue must not drive schedule_rx, which would
prep-fail without mask during the napi_disable wait (STOP storm).
err_disable_napi mirrors cleanup remask after napi_disable.

opened / rx_irq_setup gate whether cleanup walks IRQ/NAPI state.
Opened / rx_irq_setup also closes a pre-existing hang: after a
failed reopen, a later ndo_stop used to napi_disable and free_irq
a second time (rtnl spin + already-free IRQ). That depends on the
helpers in this patch, so there is no standalone Fixes: tag.

schedule_rx_queue() masks PHYP only when napi_schedule_prep() succeeds.
Masking on prep failure can race a completing poll that already
re-enabled PHYP and leave NAPI idle with the queue masked (TX OK, RX
stalled until reload). Teardown storm control stays on STOP
(disable_irq + synchronize_irq before napi_disable) and the
poll_stopping() re-arm guard added in P09, not on the schedule helper
failure path.

IRQ helpers return 0 or negative errno only (never raw H_* to
ethtool/resize). H_PARAMETER is folded to success only on disable
(idempotent mask). On enable it remains an error so a stuck-masked
queue stays visible to poll/resize recovery.

Runtime remains single-queue (num_rx_queues is still 1).

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---

Changes in v6:
- setup_rx enable-fail remasks queues 0..i, including the one that
  failed (the rollback used while (--i) and left queue i unmasked
  across napi_disable); err_disable_napi remasks after napi_disable
- drop WARN_ON() on enable/disable_irq() returns (schedule_rx and
  poll); the helper already logs the hcall rc, and rate-limit that
  print
- reword schedule_rx_queue() kdoc: true means NAPI was scheduled and
  the mask attempted; a failed disable_irq() does not change the
  return, and an out-of-range qindex returns false
- noted: pool-fail without h_free predates this; the opened gate
  also drops the accidental h_free a later ndo_stop used to give.
  P06/P07 close it
- noted: set_channels() IFF_UP vs opened TX LTB window closes in P14/P15
- noted: poll() takes queue_index in P08; range check / skip helpers
  in P09

Changes in v5:
- Remask+sync after napi_disable in cleanup (in-flight poll can re-arm)
- Interrupt: quiet IRQ_NONE on out-of-range qindex (no WARN storm)
- Opened / rx_irq_setup gate cleanup so close after a failed open
  cannot napi_disable / free_irq without a prior enable/request; set
  opened on successful open; rx_irq_setup only on full setup success
- H_PARAMETER fold disable-only; enable stays error (stuck-masked visible)
- IRQ helpers return 0 / negative errno only (never raw H_* to ethtool)
- Decision: keep open IRQ order request_irq -> napi_enable while PHYP
  stays masked until schedule/enable (coherent with later scale-up)
- schedule_rx_queue returns bool (napi_schedule_prep success)
- Keep mask-only-on-prep-success (no else-mask; avoids idle+masked race)
- Call out free_irq-before-free_lan as intentional once PHYP is masked
- Poll re-arm during teardown lands with SQ poll-harden (not claimed here)
- synchronize_net() after RX IRQ/NAPI teardown in close
- Add subordinate IRQ dispose helpers (per-queue + bulk 1..N; bound to MAX)

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

 drivers/net/ethernet/ibm/ibmveth.c | 404 ++++++++++++++++++++++++++---
 drivers/net/ethernet/ibm/ibmveth.h |   4 +
 2 files changed, 367 insertions(+), 41 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 37a6d13e603e..335712faaa42 100644
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
@@ -338,6 +340,320 @@ ibmveth_cleanup_rx_resources(struct ibmveth_adapter *adapter)
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
+ * Return: 0 on success, negative errno on failure (never raw H_*).
+ */
+static int
+ibmveth_toggle_irq(struct ibmveth_adapter *adapter, int queue_index,
+		   bool enable)
+{
+	unsigned long h_rc;
+	unsigned long irq = adapter->queue_irq[queue_index];
+	const char *action = enable ? "enable" : "disable";
+
+	if (queue_index == 0) {
+		/* Primary queue: use h_vio_signal() */
+		h_rc = h_vio_signal(adapter->vdev->unit_address,
+				    enable ? VIO_IRQ_ENABLE : VIO_IRQ_DISABLE);
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
+		h_rc = plpar_hcall_norets(H_VIOCTL,
+					  adapter->vdev->unit_address,
+					  vioctl_cmd,
+					  hwirq, 0, 0);
+
+		/*
+		 * H_PARAMETER is ambiguous (already in requested state vs bad
+		 * args). Fold only on disable as an idempotent mask. On enable
+		 * keep it an error so a stuck-masked queue stays visible to
+		 * poll/resize recovery.
+		 */
+		if (h_rc == H_PARAMETER && !enable) {
+			dev_warn_ratelimited(&adapter->netdev->dev,
+					     "H_VIOCTL %s IRQ returned H_PARAMETER for queue %d (hwirq=%lu)\n",
+					     action, queue_index, hwirq);
+			return 0;
+		}
+	}
+
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
+ * @queue_index: Index of the queue (0 for primary, 1+ for subordinate)
+ *
+ * Return: 0 on success, negative errno on failure
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
+ * Return: 0 on success, negative errno on failure
+ */
+static int
+ibmveth_enable_irq(struct ibmveth_adapter *adapter, int queue_index)
+{
+	return ibmveth_toggle_irq(adapter, queue_index, true);
+}
+
+/**
+ * ibmveth_dispose_subordinate_irq_mapping - Drop one subordinate virq mapping
+ * @adapter: ibmveth adapter structure
+ * @queue_idx: RX queue index (1..N)
+ *
+ * Subordinate queues get mappings from irq_create_mapping() during PHYP
+ * registration. Queue 0 uses netdev->irq from device tree and is left alone.
+ *
+ * Bound against IBMVETH_MAX_RX_QUEUES, not num_rx_queues: a caller may
+ * dispose a queue that is no longer in the published live set but still
+ * owns a virq in queue_irq[]. Contrast with the bulk helper, which only
+ * walks 1..num_rx_queues-1 (close / open-fail cleanup of the live set).
+ *
+ * Linux virq lifetime is owned by interrupt cleanup helpers. Call this only
+ * after free_irq() when a handler was installed, or from registration failure
+ * cleanup before request_irq().
+ */
+static void
+ibmveth_dispose_subordinate_irq_mapping(struct ibmveth_adapter *adapter,
+					int queue_idx)
+{
+	if (queue_idx <= 0 || queue_idx >= IBMVETH_MAX_RX_QUEUES)
+		return;
+
+	if (adapter->queue_irq[queue_idx]) {
+		irq_dispose_mapping(adapter->queue_irq[queue_idx]);
+		adapter->queue_irq[queue_idx] = 0;
+	}
+}
+
+/**
+ * ibmveth_dispose_subordinate_irq_mappings - Drop virq mappings for queues 1..N
+ * @adapter: ibmveth adapter structure
+ *
+ * Bulk helper for close / open-fail cleanup of the published live set
+ * (queues 1..num_rx_queues-1). Paths that need a retired or not-yet-published
+ * queue must call ibmveth_dispose_subordinate_irq_mapping() directly.
+ */
+static void
+ibmveth_dispose_subordinate_irq_mappings(struct ibmveth_adapter *adapter)
+{
+	int i;
+
+	for (i = 1; i < adapter->num_rx_queues; i++)
+		ibmveth_dispose_subordinate_irq_mapping(adapter, i);
+}
+
+/**
+ * ibmveth_setup_rx_interrupts - Register IRQs and enable NAPI
+ * @adapter: ibmveth adapter structure
+ *
+ * Registers interrupt handlers for all RX queues, enables NAPI, then
+ * enables hypervisor interrupt delivery for multi-queue mode after
+ * every queue has a Linux handler installed. For multi-queue open the
+ * caller should replenish RX buffers before this helper so traffic
+ * during open is not dropped (PHYP only interrupts after a successful
+ * enqueue, which needs buffers). Single-queue open leaves PHYP masked
+ * here and kicks NAPI afterward (classic path: first poll posts then
+ * enables).
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
+	for (i = 0; i < num; i++)
+		napi_enable(&adapter->napi[i]);
+
+	if (adapter->multi_queue && num > 1) {
+		for (i = 0; i < num; i++) {
+			rc = ibmveth_enable_irq(adapter, i);
+			if (rc) {
+				netdev_err(netdev,
+					   "Failed to enable IRQ for queue %d, rc=%d\n",
+					   i, rc);
+				for (; i >= 0; i--) {
+					ibmveth_disable_irq(adapter, i);
+					synchronize_irq(adapter->queue_irq[i]);
+				}
+				rc = -EIO;
+				goto err_disable_napi;
+			}
+		}
+	}
+
+	/* Set only on full success; fail paths leave this false so a later
+	 * close() / cleanup is a no-op.
+	 */
+	adapter->rx_irq_setup = true;
+	return 0;
+
+err_disable_napi:
+	/* STOP: remask after napi_disable; an in-flight poll can re-arm. */
+	for (i = 0; i < num; i++)
+		napi_disable(&adapter->napi[i]);
+	for (i = 0; i < num; i++) {
+		if (!adapter->queue_irq[i])
+			continue;
+		ibmveth_disable_irq(adapter, i);
+		synchronize_irq(adapter->queue_irq[i]);
+	}
+	for (i = 0; i < num; i++) {
+		if (adapter->queue_irq[i])
+			free_irq(adapter->queue_irq[i], &adapter->napi[i]);
+	}
+	goto err_dispose_mappings;
+
+err_free_irqs:
+	while (--i >= 0)
+		free_irq(adapter->queue_irq[i], &adapter->napi[i]);
+err_dispose_mappings:
+	/* Both setup failure paths own subordinate virq disposal. */
+	ibmveth_dispose_subordinate_irq_mappings(adapter);
+	return rc;
+}
+
+/**
+ * ibmveth_cleanup_rx_interrupts - Mask PHYP IRQs, stop NAPI, and free IRQs
+ * @adapter: ibmveth adapter structure
+ *
+ * Mask and synchronize each queue IRQ before napi_disable() so the handler
+ * cannot miss a PHYP mask while NAPI is already dead. Remask after
+ * napi_disable() in case an in-flight poll re-armed PHYP while we waited.
+ * free_irq() runs only after that. Safe for close and for open failure after
+ * setup_rx_interrupts() already unmasked PHYP. No-op if setup never
+ * succeeded (avoids double napi_disable / free_irq after a failed close+open
+ * while IFF_UP remains set).
+ */
+static void
+ibmveth_cleanup_rx_interrupts(struct ibmveth_adapter *adapter)
+{
+	int i;
+
+	if (!adapter->rx_irq_setup)
+		return;
+
+	for (i = 0; i < adapter->num_rx_queues; i++) {
+		if (!adapter->queue_irq[i])
+			continue;
+		ibmveth_disable_irq(adapter, i);
+		synchronize_irq(adapter->queue_irq[i]);
+	}
+
+	for (i = 0; i < adapter->num_rx_queues; i++)
+		napi_disable(&adapter->napi[i]);
+
+	for (i = 0; i < adapter->num_rx_queues; i++) {
+		if (!adapter->queue_irq[i])
+			continue;
+		ibmveth_disable_irq(adapter, i);
+		synchronize_irq(adapter->queue_irq[i]);
+	}
+
+	for (i = 0; i < adapter->num_rx_queues; i++) {
+		if (adapter->queue_irq[i])
+			free_irq(adapter->queue_irq[i], &adapter->napi[i]);
+	}
+
+	ibmveth_dispose_subordinate_irq_mappings(adapter);
+
+	/* Queue 0 uses netdev->irq; leave queue_irq[0] for next open. */
+	adapter->rx_irq_setup = false;
+}
+
+/**
+ * ibmveth_schedule_rx_queue - Mask PHYP IRQ and schedule NAPI for one RX queue
+ * @adapter: ibmveth adapter structure
+ * @qindex: RX queue index
+ *
+ * Shared by the IRQ handler and process-context kick sites (open, resume,
+ * pool sysfs, poll_controller).
+ *
+ * Return: true if napi_schedule_prep() succeeded and NAPI was scheduled.
+ * Mask is attempted in that case; a failed disable_irq() is logged by the
+ * helper and does not change the return (queue may still be unmasked).
+ * false if the index is out of range or prep failed (including NAPI
+ * already scheduled).
+ */
+static bool ibmveth_schedule_rx_queue(struct ibmveth_adapter *adapter,
+				      int qindex)
+{
+	struct napi_struct *napi = &adapter->napi[qindex];
+
+	if (WARN_ON(qindex < 0 || qindex >= adapter->num_rx_queues))
+		return false;
+
+	/*
+	 * Only mask PHYP when NAPI will run. Masking on prep failure can
+	 * race a completing poll that already re-enabled the queue, leaving
+	 * NAPI idle with the IRQ masked (TX works, RX stalls) until reload.
+	 * Storm prevention on teardown remains in cleanup/disable paths.
+	 */
+	if (napi_schedule_prep(napi)) {
+		/* Failure is already logged with the hcall rc by the helper. */
+		ibmveth_disable_irq(adapter, qindex);
+		__napi_schedule(napi);
+		return true;
+	}
+	return false;
+}
+
 /* setup the initial settings for a buffer pool */
 static void ibmveth_init_buffer_pool(struct ibmveth_buff_pool *pool,
 				     u32 pool_index, u32 pool_size,
@@ -954,8 +1270,6 @@ static int ibmveth_open(struct net_device *netdev)
 
 	netdev_dbg(netdev, "open starting\n");
 
-	napi_enable(&adapter->napi[0]);
-
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
 		rxq_entries += adapter->rx_buff_pool[0][i].size;
 
@@ -979,7 +1293,8 @@ static int ibmveth_open(struct net_device *netdev)
 					adapter->rx_queue[0].queue_len;
 	rxq_desc.fields.address = adapter->rx_queue[0].queue_dma;
 
-	h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_DISABLE);
+	adapter->queue_irq[0] = netdev->irq;
+	ibmveth_disable_irq(adapter, 0);
 
 	lpar_rc = ibmveth_register_logical_lan(adapter, rxq_desc, mac_address);
 
@@ -1000,24 +1315,20 @@ static int ibmveth_open(struct net_device *netdev)
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
 
+	adapter->opened = true;
 	netdev_dbg(netdev, "open complete\n");
 
 	return 0;
@@ -1031,7 +1342,6 @@ static int ibmveth_open(struct net_device *netdev)
 out_free_filter_list:
 	ibmveth_free_filter_list(adapter);
 out:
-	napi_disable(&adapter->napi[0]);
 	return rc;
 }
 
@@ -1041,27 +1351,32 @@ static int ibmveth_close(struct net_device *netdev)
 	long lpar_rc;
 	int i;
 
-	netdev_dbg(netdev, "close starting\n");
+	/* Gate on opened, not IFF_UP: pool_store/change_mtu close+open can
+	 * leave IFF_UP set after a failed reopen.
+	 */
+	if (!adapter->opened)
+		return 0;
 
-	napi_disable(&adapter->napi[0]);
+	adapter->opened = false;
+
+	netdev_dbg(netdev, "close starting\n");
 
 	netif_tx_stop_all_queues(netdev);
 
-	h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_DISABLE);
+	ibmveth_cleanup_rx_interrupts(adapter);
+	/* Wait for softirq/poll that already passed shutdown checks. */
+	synchronize_net();
 
+	ibmveth_update_rx_no_buffer(adapter);
+	/* Full LAN teardown (subordinates arrive with register helpers). */
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
-	ibmveth_update_rx_no_buffer(adapter);
-
 	ibmveth_free_buffer_pools(adapter);
 	ibmveth_cleanup_rx_resources(adapter);
 	ibmveth_free_filter_list(adapter);
@@ -1705,7 +2020,7 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 			container_of(napi, struct ibmveth_adapter, napi[0]);
 	struct net_device *netdev = adapter->netdev;
 	int frames_processed = 0;
-	unsigned long lpar_rc;
+	int rc;
 	u16 mss = 0;
 
 restart_poll:
@@ -1805,15 +2120,14 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
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
 
 	if (ibmveth_rxq_pending_buffer(adapter) && napi_schedule(napi)) {
-		lpar_rc = h_vio_signal(adapter->vdev->unit_address,
-				       VIO_IRQ_DISABLE);
+		ibmveth_disable_irq(adapter, 0);
 		goto restart_poll;
 	}
 
@@ -1823,16 +2137,20 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 
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
+	/*
+	 * Quiet on out-of-range: teardown can leave a residual IRQ after the
+	 * live count drops. Do not WARN-storm; return IRQ_NONE until free_irq.
+	 */
+	if (qindex < 0 || qindex >= adapter->num_rx_queues)
+		return IRQ_NONE;
+
+	ibmveth_schedule_rx_queue(adapter, qindex);
 	return IRQ_HANDLED;
 }
 
@@ -1937,8 +2255,10 @@ static int ibmveth_change_mtu(struct net_device *dev, int new_mtu)
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
 
@@ -2351,8 +2671,8 @@ static ssize_t veth_pool_store(struct kobject *kobj, struct attribute *attr,
 	}
 	rtnl_unlock();
 
-	/* kick the interrupt handler to allocate/deallocate pools */
-	ibmveth_interrupt(netdev->irq, netdev);
+	/* kick RX processing to allocate/deallocate pools */
+	ibmveth_schedule_rx_queue(adapter, 0);
 	return count;
 
 unlock_err:
@@ -2392,7 +2712,9 @@ static struct kobj_type ktype_veth_pool = {
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
index 495269631323..c13240f0ea2e 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -315,6 +315,10 @@ struct ibmveth_adapter {
 	unsigned int queue_irq[IBMVETH_MAX_RX_QUEUES];
 	int multi_queue;
 	unsigned int num_rx_queues;
+	/* Lifetime: true after successful ndo_open until close clears it. */
+	bool opened;
+	/* Lifetime: true while RX IRQ handlers / NAPI are installed. */
+	bool rx_irq_setup;
 	int rx_csum;
 	int large_send;
 	bool is_active_trunk;
-- 
2.50.1 (Apple Git-155)


