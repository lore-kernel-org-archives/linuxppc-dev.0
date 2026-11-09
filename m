Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3645606A31C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 23:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XGhKovXc
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNmsY2ZtWz2yCr;
	Tue, 10 Nov 2026 10:56:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794268609;
	cv=none; b=SCN6D+xOvbFCLIlY/C4B3ZDIEaFEkmdLFCTyBJ8rUn3cbXHjPabVmr8QpTbKpi18NNPlcBOHSY0kvY0UnIm1wHhChsjFdgfKLRn/Hoa33vAJDOYO/tOCTG/Mliy8HwAtZLU6oMQIBanCUXxgtcmYBp23FSVXLGfDhJt11NycBolcfUguObQghLh/rsEdwCHS97yphwZBXRaJ5pjOgyUcBgr8IkH6falJGPCsbf4FVqarYdu3bKn4UvPTlcBqupPFpsL+BxKnuJcvGBOJ2ulfoYNv6+qXfpraHR772Lze14crRF3sho5CjIzGCfRX0iAm2RY5Y55Pqn6O71uoHShJXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794268609; c=relaxed/relaxed;
	bh=5o0YZgwDzh7hITWd6AMVgv67LOWodhhEG7RBV4tHj18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ngUnQiebvPjQpGxHriAbFf4yzHca2X0Z1psNqNVGQbKOFK5/uuNWBGDeEXOQVGn0yBlEa6b3i1fgAFASKGxlTzkqrkGzUfW3ov0HjXrS0PsE+Hvsj1Ko7CSD8I5HagIqyic0HoekVhIZDFjwFyomdig+6qwaRH6KsOeFmHaJy2WNqZ8Xr/7Vj162ZbZweO17sPAOdDDhq2YaNyW6RSsrw0zzHJpKhPStZ+o2U6rrB8N9HKv8D3f3biNyP3FIS6bmcLzCEy2EKrorTeLWTBF8kw95A0kfbkVzAENsWyc5OTBXQw9sTuiTx/tMS+Zgb3g4ZuN5vUENKzO3Z/vxxh5iug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XGhKovXc; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XGhKovXc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNmsW6cKyz2xns
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 10:56:47 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9LEGLA3484369;
	Mon, 9 Nov 2026 23:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5o0YZgwDzh7hITWd6
	AMVgv67LOWodhhEG7RBV4tHj18=; b=XGhKovXcWkFQJRvfe9M2d0Su/kcFlkjvG
	pZdwlPDHUfVypzuaNDknbEoRWbQL8DubnhcJ6c2ZeaIlJxcb7MT2QhjQfuGFH8Vg
	3no1+7jNC4E0geywUh3jPd2bUXY2pSJOmvvtv+Sdk7S4/5vjecvdiQ7FlkUF5E11
	kvsQLhVWZmfrVzEtDsPXf3eGSXU1UNNbJ4ImjUotclcR1jN+VChdk7eBsfVvHV/P
	qdILiWi3WomYTX3EnMq05BRgixtxmsB+uaqK2cy5q/uhZo4bWYwKx05ic639OND7
	VjWUQagy8FJr6mAYWRSWLEr4jIioTkjzWTr9YkKWB3dhdNWaYFCOg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdg217g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 23:56:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9LJuIO851672;
	Mon, 9 Nov 2026 23:56:35 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htfthm8yy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 23:56:35 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A9NuXYU26542680
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 23:56:33 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 278305805B;
	Mon,  9 Nov 2026 23:56:33 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8FB958059;
	Mon,  9 Nov 2026 23:56:29 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.169.223])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 23:56:29 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, davem@davemloft.net, kuba@kernel.org,
        horms@kernel.org, edumazet@kernel.org, pabeni@redhat.com,
        andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Subject: [PATCH net-next v8 05/15] ibmveth: Refactor RX interrupt control for MQ RX queues
Date: Mon,  9 Nov 2026 15:55:46 -0800
Message-Id: <20261109235556.60604-6-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261109235556.60604-1-mmc@linux.ibm.com>
References: <20261109235556.60604-1-mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af25db4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=tRVrPEA066gBcMialcsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA5NCBTYWx0ZWRfX804f4wm2okJW
 6WNfDfLhIE9Aj+IM/Ut5KSk6GZjztdDZVZAhXmNFh639u6ry6fcajcX+2rJIjHn3DnSVGfLs/T6
 txUliEH4gccXp+ziaKW4mVoui7C+3PHl9Evpk5MmDd4zQs7GSxikw/46iuQkgdIQgYPFYNzJ1vV
 V5UiMJlpf+LtTmXvtEshRdcHhYhqrl+olKHjZwcCcF6T+p9uo6pa2lbdysKCfdACAmt/ENSOkaX
 jJsDkrS0TPuxjRMQmOh+kim5dEgZRP3x3rgFA3rD/5640x1XD3kT//ovgRIDZM/EMWnUcanuPlE
 nnRH6mJ1P+GAgPWADbysMQ/StHSBHR20XYEvIC4drhtnedHbxx4hrQoa6m7dgywR2Zy09aJY1mO
 eLbihX3CazIa6tWWjpmT0MhMHA0uJxlqZYPlTvO9MCkQvbjgzM5Eeou9XabylcurQH+D/VQcY+s
 40r5mfP9/pH5ifV+/eA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA5NCBTYWx0ZWRfX54LDdzLcPH3N
 YvXOdJxMVpCCNok59NmtYdOIYMHq2Uf61nzsVbpiacU6rCXiqkraGKhMsXZWGvmx9C9FK0B1tTc
 4VsjAdVa2gKvkzMD2OIr3vaE6sxGPPI=
X-Proofpoint-GUID: JztHGltxFusH3sKrJk3HwdWaD_wnaOer
X-Proofpoint-ORIG-GUID: sHXd914PHroLDY3ImiR9hCEsmxpWvPaa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090094
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

Add ibmveth_dispose_subordinate_irq_mapping() and a bulk 1..N
variant; queue 0 keeps netdev->irq and its mapping is left
alone. The interrupt handler returns IRQ_NONE for an
out-of-range queue index instead of warning.

Move napi_enable() into setup_rx_interrupts(). It still runs only
after LAN registration and buffer-pool allocation, so everything
ibmveth_poll() touches exists, but now after request_irq() rather than
just before it: PHYP delivery is still masked at that point. In this
single-queue tree, setup does not yet unmask PHYP; schedule_rx_queue()
masks queue 0 and schedules NAPI, and ibmveth_poll() is what unmasks
it on completion. That order matches the later scale-up rule (NAPI
live before PHYP unmask), not an inverted window relative to it.

Factor process-context RX kicks (open, resume, pool sysfs)
into ibmveth_schedule_rx_queue(); keep ibmveth_interrupt() as a thin
IRQ-only wrapper.

cleanup_rx_interrupts() masks PHYP and synchronizes IRQs before
napi_disable, waits for the poll tail, then remasks and
synchronizes again before free_irq. napi_disable waits for SCHED. The
synchronize_net() after it covers enable_irq after complete, so
remask/free_irq cannot race that tail, and close() needs no wait of
its own. Close then proceeds to h_free_logical_lan(): free_irq
before free_lan is intentional once PHYP delivery is masked.
close() now runs netif_tx_disable() first; net-next ran it after
napi_disable() and synchronize_net(). Its h_free_logical_lan
failure message is shortened.

rx_irq_setup gates whether cleanup walks IRQ/NAPI state. close()
remains gated on adapter->opened from commit 95811c873d1b ("ibmveth:
do not close twice after a failed reopen"); this patch does not
introduce adapter->opened or change that gate.

schedule_rx_queue() masks PHYP only when napi_schedule_prep() succeeds.
Masking on prep failure can race a completing poll that already
re-enabled PHYP and leave NAPI idle with the queue masked (TX OK, RX
stalled until reload). Teardown storm control stays on STOP
(ibmveth_disable_irq() + synchronize_irq() before napi_disable).
Poll still enables after complete; cleanup's wait covers that tail
versus free_irq. The RX poll helper patch adds the stopping check.

IRQ helpers return 0 or negative errno only (never raw H_* to
ethtool/resize). On subordinate queues (H_VIOCTL), H_PARAMETER on
disable is folded to success (idempotent mask). Queue 0 uses
h_vio_signal() and any failure is -EIO. On enable, H_PARAMETER does
not mean already enabled (enabling an enabled interrupt succeeds); it
means the interrupt number is out of range for the unit address. Keep
it an error so a missed LISN stays visible to poll/resize recovery.
A failed h_vio_signal() in poll or the interrupt handler is now
reported by a rate-limited dev_err() in ibmveth_toggle_irq() instead
of WARN_ON(); poll still schedules a reset on an enable failure.

Runtime remains single-queue (num_rx_queues is still 1).

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---
Changes in v8:
- teardown: synchronize_net() after napi_disable(), then remask and
  free_irq()
- rebased onto net-next's poll tail (mask then schedule, no
  restart_poll)
- close() keeps net-next's order and samples the no_buffer counter
  after h_free_logical_lan()
- ibmveth_schedule_rx_queue() returns void
- commit message: the H_PARAMETER fold applies to the subordinate
  H_VIOCTL disable only

Dropped from this series (merged fixes own them):
- commit 8d9ecac6b96e: poll_controller() netpoll kick (ndo removed)
- commit 95811c873d1b: adapter->opened close gate (in base; not re-added)
- commit 3f872b34368c: close/request_irq synchronize_net() hunks; helpers
  carry the close wait; request_irq fails before napi_enable
- commit af0524bf4ce1: setup-fail inline h_free; out_free_buffer_pools
  already calls h_free_logical_lan()

Changes in v7:
- reword schedule_rx_queue() kdoc: out-of-range is
  WARN_ON, then false
- commit message: remask only catches a re-arm that lands
  before it; name harvest before h_free and synchronize_net()
  after teardown
- noted: no Fixes: peel of the opened-gate hang; stays in
  this patch, not the unwind standalone

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
- Poll re-arm during teardown lands with the RX poll helper patch
  (not claimed here)
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

 drivers/net/ethernet/ibm/ibmveth.c | 404 +++++++++++++++++++++++++----
 drivers/net/ethernet/ibm/ibmveth.h |   2 +
 2 files changed, 357 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 31fad7713dc7..62e6c9a9f5e9 100644
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
@@ -347,6 +349,325 @@ ibmveth_cleanup_rx_resources(struct ibmveth_adapter *adapter)
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
+		 * Fold H_PARAMETER only on disable (idempotent mask). On
+		 * enable it is not already-enabled: a trivial enable
+		 * returns success. H_PARAMETER means the interrupt
+		 * number was not in the valid range for that unit
+		 * address. Keep that an error so a missed LISN stays
+		 * visible to poll/resize recovery.
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
+	/* STOP: wait for the poll tail, then remask; an in-flight poll
+	 * can re-arm after napi_complete_done().
+	 */
+	for (i = 0; i < num; i++)
+		napi_disable(&adapter->napi[i]);
+	synchronize_net();
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
+ * cannot miss a PHYP mask while NAPI is already dead. napi_disable() only
+ * waits for SCHED to clear at napi_complete_done(), so wait for the poll
+ * tail after it, then remask and synchronize again before free_irq(). The
+ * remask alone does not wait for poll to return. Safe for close and for
+ * open failure after setup_rx_interrupts() already unmasked PHYP. No-op if
+ * setup never succeeded (avoids double napi_disable / free_irq after a
+ * failed close+open while IFF_UP remains set).
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
+	synchronize_net();
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
+ * pool sysfs).
+ *
+ * Does nothing if the index is out of range (WARN_ON) or
+ * napi_schedule_prep() fails (NAPI already scheduled, or disabled
+ * because the device is closed). A failed
+ * disable_irq() is logged by the helper; the queue may stay unmasked.
+ */
+static void ibmveth_schedule_rx_queue(struct ibmveth_adapter *adapter,
+				      int qindex)
+{
+	struct napi_struct *napi = &adapter->napi[qindex];
+
+	if (WARN_ON(qindex < 0 || qindex >= adapter->num_rx_queues))
+		return;
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
+	}
+}
+
 /* setup the initial settings for a buffer pool */
 static void ibmveth_init_buffer_pool(struct ibmveth_buff_pool *pool,
 				     u32 pool_index, u32 pool_size,
@@ -1024,7 +1345,8 @@ static int ibmveth_open(struct net_device *netdev)
 					adapter->rx_queue[0].queue_len;
 	rxq_desc.fields.address = adapter->rx_queue[0].queue_dma;
 
-	h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_DISABLE);
+	adapter->queue_irq[0] = netdev->irq;
+	ibmveth_disable_irq(adapter, 0);
 
 	lpar_rc = ibmveth_register_logical_lan(adapter, rxq_desc, mac_address);
 
@@ -1045,26 +1367,16 @@ static int ibmveth_open(struct net_device *netdev)
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
 
@@ -1104,30 +1416,20 @@ static int ibmveth_close(struct net_device *netdev)
 
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
 	ibmveth_update_rx_no_buffer(adapter);
-
 	ibmveth_free_buffer_pools(adapter);
 	ibmveth_cleanup_rx_resources(adapter);
 	ibmveth_free_filter_list(adapter);
@@ -1814,7 +2116,6 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 			container_of(napi, struct ibmveth_adapter, napi[0]);
 	struct net_device *netdev = adapter->netdev;
 	int frames_processed = 0;
-	unsigned long lpar_rc;
 	u64 correlator;
 	u16 mss = 0;
 	int rc;
@@ -1962,18 +2263,17 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
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
 
@@ -1983,16 +2283,20 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 
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
 
@@ -2536,8 +2840,8 @@ static ssize_t veth_pool_store(struct kobject *kobj, struct attribute *attr,
 	}
 	rtnl_unlock();
 
-	/* kick the interrupt handler to allocate/deallocate pools */
-	ibmveth_interrupt(netdev->irq, netdev);
+	/* kick RX processing to allocate/deallocate pools */
+	ibmveth_schedule_rx_queue(adapter, 0);
 	return count;
 
 unlock_err:
@@ -2577,7 +2881,9 @@ static struct kobj_type ktype_veth_pool = {
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
index df5a3b69a157..50be6c95457e 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -325,6 +325,8 @@ struct ibmveth_adapter {
 	unsigned int queue_irq[IBMVETH_MAX_RX_QUEUES];
 	int multi_queue;
 	unsigned int num_rx_queues;
+	/* Lifetime: true while RX IRQ handlers / NAPI are installed. */
+	bool rx_irq_setup;
 	int rx_csum;
 	int large_send;
 	bool is_active_trunk;
-- 
2.50.1 (Apple Git-155)


