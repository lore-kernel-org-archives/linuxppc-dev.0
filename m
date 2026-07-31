Return-Path: <linuxppc-dev+bounces-25156-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2ECEC55167
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2026 00:49:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hB6r22z3xz2yYd;
	Fri, 31 Jul 2026 10:48:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785458898;
	cv=none; b=Tzzag5OjBVq573iyruJqzV1dDyf74Sw05L3STk6cmke34SRf9C1DIWTADvPv/v3D60fOU+nvz5NdnONFAK3xGvwsl0c7w0D2BkDU8Urk7f4Csz1egkqLbfKzFqpFoJ4SeTk0+DNqYqH6sG/u/cFtiQ1ayJjFlBQAhZxwG4sZSe+80HpFswFdVhRJcW+vlnhppaOzB9X8Al/+qKhV+/3BQ2qnz1etwTHN/zpdUSaPF09F3028JXMMvMK3roYt2MPEV90vtZYXu4diQZ3x9kJwxQMOBcDMW8GzWVYsuz1sLMglRioKjynka4326G1m/crqIQESFQ3c+cUVCrp6rhWccA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785458898; c=relaxed/relaxed;
	bh=hEPp08bciZs3X2ilmll54qClojCkTtpnhozM/Bgcxew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MNyjJ6BdPKLmGV4WNLizzs42wDTu0n201Sbv6ffXdXOa5MYhmhHbAUBNjjNwKCrFqESzFnTIv/9ZANnmjqj7jWuI5+ZjpHvcndOJ4P+pedtYAioekzzKZYRC0fFoO85w3Qa590gzSKIgZFY/dZZQq01RgKURecMXb5fwgvaWPjUkKlDo62JrhZEP1+WTsehqc2kqaTpQxcezDCCtBJ6ql4IuISF2u5b+uNvzNkNiAyE6qeHVl81cwTUiyRCBQoZiucIFVeHVIO2Vh/1MwNSGJHKegg7YDaig6Vp3ZOt0fH3THBbmfv+lEzM/wcER+yE1fjAFc+jK2IveGfn+NeRQsw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eYCsWchy; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eYCsWchy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hB6r05n9qz304N
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 10:48:16 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UNI7Wg244087;
	Fri, 31 Jul 2026 00:48:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hEPp08bciZs3X2ilm
	ll54qClojCkTtpnhozM/Bgcxew=; b=eYCsWchyucU6SLXW75W4H56z2yLTPQiWp
	kYAbZKA1SUuIWBCpNTseU43Dun8YNe4i53DQH8HKRDHKHsGL8JWxMldCJkXBOVrV
	5X2lhCYEi4p6X3GhEft26s8H2lgCDMrZ/CylhIq1Wqhro1pPrfwZvSN6skRTq0NA
	QfCz0IDiC+gctPPgkluiBdg4twLlI95HG9bsmL3O3m3Rhk3DUN2COxdseR50OkeL
	LegM9onb7vaejs5qrp2wsKzvMIEbrS1wAgjrC4KLJdF/CZ4tTpE7zT0aVzgR1WbV
	sTJl/imhL4/XRuKtyYPOKdHoe751RFtGm1mN+uxW0UfDnPxi52phg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwd9n92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 00:48:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66V0fcSJ016841;
	Fri, 31 Jul 2026 00:48:02 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhns0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 00:48:02 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66V0m0Yk5178196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 00:48:00 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AE3958059;
	Fri, 31 Jul 2026 00:48:00 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E28F58058;
	Fri, 31 Jul 2026 00:47:59 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.44.71])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 00:47:59 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, davem@davemloft.net,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        simon.horman@corigine.com, shaik.abdulla1@ibm.com,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH net-next v4 09/14] ibmveth: Enable multi-queue RX receive path
Date: Thu, 30 Jul 2026 17:47:12 -0700
Message-Id: <f49057799577b7c3c1444910b56a6662a610a20a.1785457143.git.mmc@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: HCKwzbh4B2EzgsxweP9fSTwGhRGObyzf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDAwMyBTYWx0ZWRfX+exqN+NMqudS
 Vi0qz2CSVSFrhkvRBqAVIeCNWMzipPFjzxRbE+99SyLixc2UFgvCJTeVWexZfVtK2jzR2XkG9Yu
 j83YnAmgGEyodYCEgbwCa7jmbmXGuNc=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a6bf0c3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=GqEERb6S_SJihmgic74A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDAwMyBTYWx0ZWRfX6epR+5xXdhuP
 UBiE7Lhje42kgcr6uj7Mp8AaRntPGXwhHpXyBVHh4xSh2DzQtzIweUtFZ8StnN9hAYumsHUXcme
 uBVUG18mwKt0e+jbANRGNvpYLggrRSeEraymwtDQFRcUPMr3htrH6OromG+ch/zu4Xe1Y1iDsnd
 2BdS9KOT+77b/cRQOv61iphikLgRpvPI72FDs4fDkQjdHltc9GGJ9Xc6+3vl0Wf4/+WcWXi+2Kw
 pX2oYX0iDr321YKCCPCKRRGKTwlf8n8twlBw9Uzm0UhMPY7Oj3BoAMXlxW54wOBSSHjkbLLRj3h
 CmJxrqd+f/DgJuycGYb0BsDcaMlCkVTIS8+OMVNg1kQIaoFxurJsQI6C5tb9hWKapDuV7ZU8/l7
 Kbx+CsrIWW4/h6WWXTOAcu9upMslHF0KkRd67ibVZbRutV2MCXP9lhvybXN42r9V2YVqSkYe+I1
 leTyvC30vXJlJKUKiRA==
X-Proofpoint-GUID: EBXU6BBMZ4hTlczLea-XkapkJHNRQrlv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310003

This is where MQ actually receives packets. If firmware sets
IBMVETH_ILLAN_RX_MULTI_QUEUE_SUPPORT in H_ILLAN_ATTRIBUTES, probe sets
multi_queue and num_rx_queues to min(num_online_cpus(),
IBMVETH_DEFAULT_QUEUES), matching the existing TX default (cap 8).
Up to IBMVETH_MAX_RX_QUEUES (16) remains available via ethtool -L.
Otherwise we stay at one queue like today.

Enable the live multi-queue RX path using helpers introduced earlier:

  - Probe: MQ capability bit, multi_queue/num_rx_queues,
    IBMVETH_MAX_RX_QUEUES=16, alloc_etherdev_mqs RX count, NAPI for
    all queues, MQ vs regular rx_buffers_per_hcall
  - ibmveth_register_logical_lan_queue() /
    ibmveth_register_single_rx_queue() for subordinate queues via
    H_REG_LOGICAL_LAN_QUEUE (irq_create_mapping for subordinate virqs)
  - Wire subordinates into ibmveth_register_rx_queues()
  - ibmveth_dispose_subordinate_irq_mappings() on partial failure
  - setup_rx_interrupts(): after request_irq + napi_enable, PHYP
    enable_irq for all queues when multi_queue && num_rx_queues > 1
  - MQ open replenishes every RX queue before setup_rx_interrupts()
    unmasks PHYP; SQ keeps the classic setup-then-schedule kick
  - ibmveth_dispose_subordinate_irq_mappings() on setup failure
    (queue 0 uses netdev->irq and is never disposed)

Subordinate register error handling:
  - H_FUNCTION is a hard open failure: honest netdev_err, then the
    generic failure/params logs, without clearing multi_queue or
    claiming single-queue fallback
  - Register each subordinate once; no blind try_again retry
  - No caller-side "Invalid hypervisor return" log; the callee
    already reports the hcall rc

setup_rx_interrupts() failure paths dispose subordinate virq mappings
from both err_free_irqs and err_disable_napi so request_irq failure
after successful subordinate registration cannot leak Linux mappings.

Hot-path netdev->stats TX/RX accounting moves to the next patch
(per-queue qstats).

Legacy firmware without the MQ bit is unchanged.

On probe failure after pool kobjects were created, put them before
free_netdev() so earlier pools cannot leak.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---

Changes in v4:
- Fold subordinate register helpers and their review fixes into the MQ
  enablement patch that first uses them.
- Prefer request_irq -> napi_enable -> PHYP enable on MQ open.
- Preserve open unwind so set_real_num_rx / IRQ failures free LAN
  before buffer pools.
- MQ open replenishes every queue before setup_rx_interrupts() unmasks
  PHYP (drop avoidance during open; PHYP only interrupts after a
  successful enqueue). SQ keeps classic setup-then-schedule kick.
- Dispose subordinate virq mappings on setup_rx_interrupts()
  request_irq failure (err_free_irqs), matching err_disable_napi.
- Open unwind: setup/cleanup own subordinate dispose; skip duplicate
  dispose on those paths.
- H_FUNCTION on subordinate register is a hard open failure (no blind
  retry / no fake single-queue fallback).
- Note: hot-path netdev->stats accounting moves to the next patch (qstats).
- Put already-created pool kobjects on probe kobject_init_and_add /
  set_real_num_tx_queues / register_netdev failure (bisect-safe).

 drivers/net/ethernet/ibm/ibmveth.c | 456 ++++++++++++++++++++++++-----
 drivers/net/ethernet/ibm/ibmveth.h |   3 +-
 2 files changed, 380 insertions(+), 79 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index cb93659fc057..4ad7ced3c608 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -30,6 +30,7 @@
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <asm/hvcall.h>
 #include <linux/atomic.h>
 #include <asm/vio.h>
@@ -45,7 +46,6 @@ static unsigned long ibmveth_get_desired_dma(struct vio_dev *vdev);
 
 static struct kobj_type ktype_veth_pool;
 
-
 static const char ibmveth_driver_name[] = "ibmveth";
 static const char ibmveth_driver_string[] = "IBM Power Virtual Ethernet Driver";
 #define ibmveth_driver_version "1.06"
@@ -97,7 +97,17 @@ static struct ibmveth_stat ibmveth_stats[] = {
 	{ "fw_enabled_ipv6_csum", IBMVETH_STAT_OFF(fw_ipv6_csum_support) },
 	{ "tx_large_packets", IBMVETH_STAT_OFF(tx_large_packets) },
 	{ "rx_large_packets", IBMVETH_STAT_OFF(rx_large_packets) },
-	{ "fw_enabled_large_send", IBMVETH_STAT_OFF(fw_large_send_support) }
+	{ "fw_enabled_large_send", IBMVETH_STAT_OFF(fw_large_send_support) },
+	{ "hcall_reg_lan_queue", IBMVETH_STAT_OFF(hcall_stats.reg_lan_queue) },
+	{ "hcall_reg_lan", IBMVETH_STAT_OFF(hcall_stats.reg_lan) },
+	{ "hcall_add_bufs_queue",
+	  IBMVETH_STAT_OFF(hcall_stats.add_bufs_queue) },
+	{ "hcall_add_bufs", IBMVETH_STAT_OFF(hcall_stats.add_bufs) },
+	{ "hcall_add_buf", IBMVETH_STAT_OFF(hcall_stats.add_buf) },
+	{ "hcall_free_lan_queue",
+	  IBMVETH_STAT_OFF(hcall_stats.free_lan_queue) },
+	{ "hcall_free_lan", IBMVETH_STAT_OFF(hcall_stats.free_lan) },
+	{ "hcall_send_lan", IBMVETH_STAT_OFF(hcall_stats.send_lan) },
 };
 
 /* simple methods of getting data from the current rxq entry */
@@ -429,12 +439,64 @@ ibmveth_enable_irq(struct ibmveth_adapter *adapter, int queue_index)
 	return ibmveth_toggle_irq(adapter, queue_index, true);
 }
 
+/**
+ * ibmveth_dispose_subordinate_irq_mapping - Drop one subordinate virq mapping
+ * @adapter: ibmveth adapter structure
+ * @queue_idx: RX queue index (1..N)
+ *
+ * Subordinate queues get mappings from irq_create_mapping() during PHYP
+ * registration. Queue 0 uses netdev->irq from device tree and is left alone.
+ *
+ * Bound against IBMVETH_MAX_RX_QUEUES, not num_rx_queues: scale-down and
+ * scale-up fail paths dispose queues that are no longer in the published
+ * live set but still own a virq in queue_irq[]. The bulk helper still
+ * iterates only 1..num_rx_queues-1 for close/open-fail cleanup.
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
+ * Bulk helper for paths that registered subordinate queues but never installed
+ * Linux IRQ handlers.
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
 /**
  * ibmveth_setup_rx_interrupts - Register IRQs and enable NAPI
  * @adapter: ibmveth adapter structure
  *
- * Registers interrupt handlers for all RX queues and enables NAPI polling.
- * On error, cleans up any successfully registered IRQs before returning.
+ * Registers interrupt handlers for all RX queues, enables NAPI, then
+ * enables hypervisor interrupt delivery for multi-queue mode after
+ * every queue has a Linux handler installed. For multi-queue open the
+ * caller should replenish RX buffers before this helper so traffic
+ * during open is not dropped (PHYP only interrupts after a successful
+ * enqueue, which needs buffers). Single-queue open leaves PHYP masked
+ * here and kicks NAPI afterward (classic path: first poll posts then
+ * enables).
  *
  * Return: 0 on success, negative error code on failure
  */
@@ -442,12 +504,9 @@ static int
 ibmveth_setup_rx_interrupts(struct ibmveth_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
-	int i, rc;
+	int i, rc, num = adapter->num_rx_queues;
 
-	for (i = 0; i < adapter->num_rx_queues; i++)
-		napi_enable(&adapter->napi[i]);
-
-	for (i = 0; i < adapter->num_rx_queues; i++) {
+	for (i = 0; i < num; i++) {
 		if (!adapter->queue_irq[i]) {
 			netdev_err(netdev, "queue %d has invalid IRQ (0)\n", i);
 			rc = -EINVAL;
@@ -464,13 +523,42 @@ ibmveth_setup_rx_interrupts(struct ibmveth_adapter *adapter)
 		}
 	}
 
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
+				while (--i >= 0)
+					ibmveth_disable_irq(adapter, i);
+				rc = -EIO;
+				goto err_disable_napi;
+			}
+		}
+	}
+
 	return 0;
 
+err_disable_napi:
+	/* PHYP unmask was rolled back above; disable NAPI before free_irq */
+	for (i = 0; i < num; i++)
+		napi_disable(&adapter->napi[i]);
+	for (i = 0; i < num; i++) {
+		if (adapter->queue_irq[i])
+			free_irq(adapter->queue_irq[i], &adapter->napi[i]);
+	}
+	goto err_dispose_mappings;
+
 err_free_irqs:
 	while (--i >= 0)
 		free_irq(adapter->queue_irq[i], &adapter->napi[i]);
-	for (i = 0; i < adapter->num_rx_queues; i++)
-		napi_disable(&adapter->napi[i]);
+err_dispose_mappings:
+	/* Both setup failure paths own subordinate virq disposal. */
+	ibmveth_dispose_subordinate_irq_mappings(adapter);
 	return rc;
 }
 
@@ -503,15 +591,7 @@ ibmveth_cleanup_rx_interrupts(struct ibmveth_adapter *adapter)
 			free_irq(adapter->queue_irq[i], &adapter->napi[i]);
 	}
 
-	/* Dispose IRQ mappings for subordinate queues (1-15).
-	 * Queue 0 uses netdev->irq from device tree, not irq_create_mapping().
-	 */
-	for (i = 1; i < adapter->num_rx_queues; i++) {
-		if (adapter->queue_irq[i]) {
-			irq_dispose_mapping(adapter->queue_irq[i]);
-			adapter->queue_irq[i] = 0;
-		}
-	}
+	ibmveth_dispose_subordinate_irq_mappings(adapter);
 
 	/* Queue 0 uses netdev->irq; leave queue_irq[0] for next open. */
 }
@@ -521,8 +601,8 @@ ibmveth_cleanup_rx_interrupts(struct ibmveth_adapter *adapter)
  * @adapter: ibmveth adapter structure
  * @qindex: RX queue index
  *
- * Shared by the IRQ handler and process-context kick paths (open, resume,
- * pool sysfs, netpoll). Keep ibmveth_interrupt() as the IRQ-only wrapper.
+ * Shared by the IRQ handler and process-context kick sites (open, resume,
+ * pool sysfs, poll_controller).
  */
 static void ibmveth_schedule_rx_queue(struct ibmveth_adapter *adapter,
 				      int qindex)
@@ -834,9 +914,15 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
  */
 static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter)
 {
-	__be64 *p = adapter->buffer_list_addr[0] + 4096 - 8;
+	int i;
 
-	adapter->rx_no_buffer = be64_to_cpup(p);
+	adapter->rx_no_buffer = 0;
+	for (i = 0; i < adapter->num_rx_queues; i++) {
+		__be64 *p = adapter->buffer_list_addr[i] + 4096 - 8;
+		u64 drops = be64_to_cpup(p);
+
+		adapter->rx_no_buffer += drops;
+	}
 }
 
 /* replenish routine */
@@ -847,8 +933,12 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
 	unsigned long flags;
 	int i;
 
-	if (queue_index >= adapter->num_rx_queues)
+	if (queue_index >= adapter->num_rx_queues) {
+		netdev_dbg(adapter->netdev,
+			   "Skipping replenish for freed queue %d (num_queues=%d)\n",
+			   queue_index, adapter->num_rx_queues);
 		return;
+	}
 
 	adapter->replenish_task_cycles++;
 
@@ -858,7 +948,7 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
 		struct ibmveth_buff_pool *pool =
 			&adapter->rx_buff_pool[queue_index][i];
 
-		if (pool->active &&
+		if (pool->active && pool->free_map &&
 		    (atomic_read(&pool->available) < pool->threshold))
 			ibmveth_replenish_buffer_pool(adapter, pool,
 						      queue_index);
@@ -1284,6 +1374,137 @@ static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
 	return rc;
 }
 
+/**
+ * ibmveth_register_logical_lan_queue - Register subordinate queue with
+ * hypervisor
+ * @adapter: ibmveth adapter structure
+ * @rxq_desc: Receive queue descriptor
+ * @queue_index: RX queue index (1..N for subordinate queues)
+ *
+ * Registers a subordinate receive queue using H_REG_LOGICAL_LAN_QUEUE.
+ * On success, stores the queue handle and virtual IRQ in the adapter.
+ * If IRQ mapping fails after a successful hypervisor registration, the
+ * queue is freed before returning.
+ *
+ * Return: H_SUCCESS on success, negative errno on IRQ mapping failure,
+ *         hypervisor error code otherwise
+ */
+static int
+ibmveth_register_logical_lan_queue(struct ibmveth_adapter *adapter,
+				   union ibmveth_buf_desc rxq_desc,
+				   int queue_index)
+{
+	unsigned long handle, hwirq;
+	unsigned int virq;
+	long lpar_rc;
+
+	netdev_dbg(adapter->netdev,
+		   "Attempting to register queue %d: unit_addr=0x%x buffer_list_dma=0x%llx rxq_desc=0x%llx\n",
+		   queue_index, adapter->vdev->unit_address,
+		   (unsigned long long)adapter->buffer_list_dma[queue_index],
+		   (unsigned long long)rxq_desc.desc);
+
+	lpar_rc = h_reg_logical_lan_queue(adapter->vdev->unit_address,
+					  adapter->buffer_list_dma[queue_index],
+					  rxq_desc.desc, &handle, &hwirq);
+	adapter->hcall_stats.reg_lan_queue++;
+
+	if (lpar_rc == H_SUCCESS) {
+		virq = irq_create_mapping(NULL, hwirq);
+		if (!virq) {
+			unsigned long free_rc;
+			unsigned long ua = adapter->vdev->unit_address;
+
+			netdev_err(adapter->netdev,
+				   "Failed to map IRQ for queue %d (hwirq=%lu)\n",
+				   queue_index, hwirq);
+			do {
+				free_rc = h_free_logical_lan_queue(ua, handle);
+			} while (H_IS_LONG_BUSY(free_rc) ||
+				  (free_rc == H_BUSY));
+			adapter->hcall_stats.free_lan_queue++;
+			if (free_rc != H_SUCCESS)
+				netdev_err(adapter->netdev,
+					   "h_free_logical_lan_queue failed for queue %d after IRQ map failure: rc=0x%lx\n",
+					   queue_index, free_rc);
+			return -EINVAL;
+		}
+
+		adapter->queue_handle[queue_index] = handle;
+		adapter->queue_irq[queue_index] = virq;
+
+		netdev_dbg(adapter->netdev,
+			   "queue %d registered: handle=0x%llx irq=%u\n",
+			   queue_index, adapter->queue_handle[queue_index],
+			   adapter->queue_irq[queue_index]);
+		return H_SUCCESS;
+	}
+
+	/*
+	 * H_FUNCTION means firmware rejected this subordinate register
+	 * (MQ unsupported). That is a hard open failure: do not clear
+	 * multi_queue or claim single-queue fallback. Keep a specific
+	 * log, then the generic failure lines below (no early return).
+	 */
+	if (lpar_rc == H_FUNCTION)
+		netdev_err(adapter->netdev,
+			   "h_reg_logical_lan_queue H_FUNCTION for queue %d (firmware MQ unsupported)\n",
+			   queue_index);
+
+	netdev_err(adapter->netdev,
+		   "h_reg_logical_lan_queue failed for queue %d with %ld\n",
+		   queue_index, lpar_rc);
+	netdev_err(adapter->netdev,
+		   "queue %d params: unit_addr=0x%x buffer_list_dma=0x%llx rxq_desc=0x%llx\n",
+		   queue_index, adapter->vdev->unit_address,
+		   (unsigned long long)adapter->buffer_list_dma[queue_index],
+		   (unsigned long long)rxq_desc.desc);
+
+	return lpar_rc;
+}
+
+/**
+ * ibmveth_register_single_rx_queue - Register one subordinate RX queue
+ * @adapter: ibmveth adapter structure
+ * @queue_idx: Queue index to register (1..N)
+ * @mac_address: MAC address (unused; reserved for API symmetry)
+ *
+ * Builds the queue descriptor and registers with the hypervisor via
+ * ibmveth_register_logical_lan_queue().
+ *
+ * Return: 0 on success, -EINVAL if @queue_idx is invalid, -EIO on failure
+ */
+static int
+ibmveth_register_single_rx_queue(struct ibmveth_adapter *adapter,
+				 int queue_idx, u64 mac_address)
+{
+	struct net_device *netdev = adapter->netdev;
+	union ibmveth_buf_desc rxq_desc;
+	long lpar_rc;
+
+	(void)mac_address;
+
+	if (WARN_ON(queue_idx < 1 || queue_idx >= IBMVETH_MAX_RX_QUEUES))
+		return -EINVAL;
+
+	rxq_desc.fields.flags_len = IBMVETH_BUF_VALID |
+				    adapter->rx_queue[queue_idx].queue_len;
+	rxq_desc.fields.address = adapter->rx_queue[queue_idx].queue_dma;
+
+	lpar_rc = ibmveth_register_logical_lan_queue(adapter, rxq_desc,
+						     queue_idx);
+	if (lpar_rc != H_SUCCESS) {
+		netdev_err(netdev, "Failed to register queue %d: rc=0x%lx\n",
+			   queue_idx, lpar_rc);
+		return -EIO;
+	}
+
+	netdev_dbg(netdev, "Registered queue %d with handle 0x%llx\n",
+		   queue_idx, adapter->queue_handle[queue_idx]);
+
+	return 0;
+}
+
 /**
  * ibmveth_free_all_queues - Free all RX queues at once
  * @adapter: ibmveth adapter structure
@@ -1292,7 +1513,8 @@ static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
  * Used during interface close and registration error cleanup.
  *
  * Clears queue handles only; queue_irq[] is released by
- * ibmveth_cleanup_rx_interrupts().
+ * ibmveth_cleanup_rx_interrupts() on close, or by
+ * ibmveth_dispose_subordinate_irq_mappings() on partial register failure.
  */
 static void ibmveth_free_all_queues(struct ibmveth_adapter *adapter)
 {
@@ -1320,10 +1542,11 @@ static void ibmveth_free_all_queues(struct ibmveth_adapter *adapter)
  * @adapter: ibmveth adapter structure
  * @mac_address: MAC address for device registration
  *
- * Registers queue 0 via ibmveth_register_logical_lan(). Subordinate queue
- * registration is added when multi-queue RX is enabled.
+ * Registers queue 0 via ibmveth_register_logical_lan(), then subordinate
+ * queues 1..N when multi-queue mode is enabled.
  *
- * Return: 0 on success, -ENONET if queue 0 registration fails
+ * Return: 0 on success, -ENONET if queue 0 registration fails, -EIO on
+ *         subordinate queue registration failure
  */
 static int
 ibmveth_register_rx_queues(struct ibmveth_adapter *adapter, u64 mac_address)
@@ -1331,7 +1554,7 @@ ibmveth_register_rx_queues(struct ibmveth_adapter *adapter, u64 mac_address)
 	struct net_device *netdev = adapter->netdev;
 	union ibmveth_buf_desc rxq_desc;
 	unsigned long lpar_rc;
-	int rc;
+	int i, rc;
 
 	rxq_desc.fields.flags_len = IBMVETH_BUF_VALID |
 				    adapter->rx_queue[0].queue_len;
@@ -1356,9 +1579,31 @@ ibmveth_register_rx_queues(struct ibmveth_adapter *adapter, u64 mac_address)
 		return -ENONET;
 	}
 
+	if (adapter->num_rx_queues == 1 || !adapter->multi_queue) {
+		netdev_dbg(netdev,
+			   "registered 1 RX queue with hypervisor (single-queue mode)\n");
+		return 0;
+	}
+
+	netdev_dbg(netdev, "Registering %d subordinate queues (1-%d)\n",
+		   adapter->num_rx_queues - 1, adapter->num_rx_queues - 1);
+
+	for (i = 1; i < adapter->num_rx_queues; i++) {
+		rc = ibmveth_register_single_rx_queue(adapter, i, mac_address);
+		if (rc)
+			goto err_unregister;
+	}
+
 	netdev_dbg(netdev,
-		   "registered 1 RX queue with hypervisor (single-queue mode)\n");
+		   "registered %d RX queues with hypervisor (multi-queue mode)\n",
+		   adapter->num_rx_queues);
+
 	return 0;
+
+err_unregister:
+	ibmveth_dispose_subordinate_irq_mappings(adapter);
+	ibmveth_free_all_queues(adapter);
+	return rc;
 }
 
 static int ibmveth_open(struct net_device *netdev)
@@ -1396,12 +1641,29 @@ static int ibmveth_open(struct net_device *netdev)
 		goto out_unregister_queues;
 	}
 
+	/*
+	 * MQ: post buffers before setup_rx_interrupts() unmasks PHYP
+	 * (avoids drops if traffic arrives during open; PHYP allows
+	 * either order). Single-queue keeps the classic kick: setup
+	 * (no unmask) then schedule_rx_queue() so the first poll
+	 * replenishes and enables.
+	 */
+	if (adapter->multi_queue && adapter->num_rx_queues > 1) {
+		for (i = 0; i < adapter->num_rx_queues; i++) {
+			netdev_dbg(netdev,
+				   "initial replenish cycle for queue %d\n", i);
+			ibmveth_replenish_task(adapter, i);
+		}
+	}
+
 	rc = ibmveth_setup_rx_interrupts(adapter);
 	if (rc)
-		goto out_unregister_queues;
+		goto out_free_all_queues; /* setup already disposed IRQs */
 
-	netdev_dbg(netdev, "initial replenish cycle\n");
-	ibmveth_schedule_rx_queue(adapter, 0);
+	if (!(adapter->multi_queue && adapter->num_rx_queues > 1)) {
+		netdev_dbg(netdev, "initial replenish cycle\n");
+		ibmveth_schedule_rx_queue(adapter, 0);
+	}
 
 	rc = ibmveth_alloc_tx_resources(adapter);
 	if (rc)
@@ -1415,7 +1677,10 @@ static int ibmveth_open(struct net_device *netdev)
 
 out_cleanup_rx_interrupts:
 	ibmveth_cleanup_rx_interrupts(adapter);
+	goto out_free_all_queues; /* cleanup already disposed IRQs */
 out_unregister_queues:
+	ibmveth_dispose_subordinate_irq_mappings(adapter);
+out_free_all_queues:
 	ibmveth_free_all_queues(adapter);
 out_free_buffer_pools:
 	ibmveth_free_buffer_pools(adapter);
@@ -1702,6 +1967,11 @@ static int ibmveth_set_features(struct net_device *dev,
 	return rc1 ? rc1 : rc2;
 }
 
+/*
+ * Sum per-queue counters for rare ethtool reads. Do not write adapter
+ * globals on the hot path (ibmvnic-style); with qstats allocated for the
+ * adapter lifetime, these sums remain meaningful across ifdown/up.
+ */
 static void ibmveth_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 {
 	int i;
@@ -1838,12 +2108,15 @@ static int ibmveth_send(struct ibmveth_adapter *adapter,
 		return 1;
 	}
 
+	adapter->hcall_stats.send_lan++;
 	return 0;
 }
 
 static int ibmveth_is_packet_unsupported(struct sk_buff *skb,
-					 struct net_device *netdev)
+					 struct ibmveth_adapter *adapter,
+					 int queue_num)
 {
+	struct net_device *netdev = adapter->netdev;
 	struct ethhdr *ether_header;
 	int ret = 0;
 
@@ -1851,7 +2124,6 @@ static int ibmveth_is_packet_unsupported(struct sk_buff *skb,
 
 	if (ether_addr_equal(ether_header->h_dest, netdev->dev_addr)) {
 		netdev_dbg(netdev, "veth doesn't support loopback packets, dropping packet.\n");
-		netdev->stats.tx_dropped++;
 		ret = -EOPNOTSUPP;
 	}
 
@@ -1867,7 +2139,7 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 	int i, queue_num = skb_get_queue_mapping(skb);
 	unsigned long mss = 0;
 
-	if (ibmveth_is_packet_unsupported(skb, netdev))
+	if (ibmveth_is_packet_unsupported(skb, adapter, queue_num))
 		goto out;
 	/* veth can't checksum offload UDP */
 	if (skb->ip_summed == CHECKSUM_PARTIAL &&
@@ -1878,7 +2150,6 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 	    skb_checksum_help(skb)) {
 
 		netdev_err(netdev, "tx: failed to checksum packet\n");
-		netdev->stats.tx_dropped++;
 		goto out;
 	}
 
@@ -1901,7 +2172,6 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 	if (skb->ip_summed == CHECKSUM_PARTIAL && skb_is_gso(skb)) {
 		if (adapter->fw_large_send_support) {
 			mss = (unsigned long)skb_shinfo(skb)->gso_size;
-			adapter->tx_large_packets++;
 		} else if (!skb_is_gso_v6(skb)) {
 			/* Put -1 in the IP checksum to tell phyp it
 			 * is a largesend packet. Put the mss in
@@ -1910,7 +2180,6 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 			ip_hdr(skb)->check = 0xffff;
 			tcp_hdr(skb)->check =
 				cpu_to_be16(skb_shinfo(skb)->gso_size);
-			adapter->tx_large_packets++;
 		}
 	}
 
@@ -1918,7 +2187,6 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 	if (unlikely(skb->len > adapter->tx_ltb_size)) {
 		netdev_err(adapter->netdev, "tx: packet size (%u) exceeds ltb (%u)\n",
 			   skb->len, adapter->tx_ltb_size);
-		netdev->stats.tx_dropped++;
 		goto out;
 	}
 	memcpy(adapter->tx_ltb_ptr[queue_num], skb->data, skb_headlen(skb));
@@ -1935,7 +2203,6 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 	if (unlikely(total_bytes != skb->len)) {
 		netdev_err(adapter->netdev, "tx: incorrect packet len copied into ltb (%u != %u)\n",
 			   skb->len, total_bytes);
-		netdev->stats.tx_dropped++;
 		goto out;
 	}
 	desc.fields.flags_len = desc_flags | skb->len;
@@ -1944,18 +2211,13 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 	dma_wmb();
 
 	if (ibmveth_send(adapter, desc.desc, mss)) {
-		adapter->tx_send_failed++;
-		netdev->stats.tx_dropped++;
 	} else {
-		netdev->stats.tx_packets++;
-		netdev->stats.tx_bytes += skb->len;
 	}
 
 out:
 	dev_consume_skb_any(skb);
 	return NETDEV_TX_OK;
 
-
 }
 
 static void ibmveth_rx_mss_helper(struct sk_buff *skb, u16 mss, int lrg_pkt)
@@ -2180,8 +2442,6 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 
 			napi_gro_receive(napi, skb);	/* send it up */
 
-			netdev->stats.rx_packets++;
-			netdev->stats.rx_bytes += length;
 			frames_processed++;
 		}
 	}
@@ -2357,8 +2617,7 @@ static unsigned long ibmveth_get_desired_dma(struct vio_dev *vdev)
 	struct ibmveth_adapter *adapter;
 	struct iommu_table *tbl;
 	unsigned long ret;
-	int i;
-	int rxqentries = 1;
+	int i, q;
 
 	tbl = get_iommu_table_base(&vdev->dev);
 
@@ -2373,18 +2632,25 @@ static unsigned long ibmveth_get_desired_dma(struct vio_dev *vdev)
 	/* add size of mapped tx buffers */
 	ret += IOMMU_PAGE_ALIGN(IBMVETH_MAX_TX_BUF_SIZE, tbl);
 
-	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
-		/* add the size of the active receive buffers */
-		if (adapter->rx_buff_pool[0][i].active)
-			ret +=
-			    adapter->rx_buff_pool[0][i].size *
-			    IOMMU_PAGE_ALIGN(adapter->rx_buff_pool[0][i].
-					     buff_size, tbl);
-		rxqentries += adapter->rx_buff_pool[0][i].size;
-	}
-	/* add the size of the receive queue entries */
-	ret += IOMMU_PAGE_ALIGN(
-		rxqentries * sizeof(struct ibmveth_rx_q_entry), tbl);
+	for (q = 0; q < adapter->num_rx_queues; q++) {
+		int rxqentries = 1;
+
+		for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
+			/* add the size of the active receive buffers */
+			struct ibmveth_buff_pool *bpool =
+				&adapter->rx_buff_pool[q][i];
+
+			/* add the size of the active receive buffers */
+			if (bpool->active)
+				ret += bpool->size *
+					IOMMU_PAGE_ALIGN(bpool->buff_size, tbl);
+			rxqentries += bpool->size;
+		}
+
+		/* add the size of the receive queue entries */
+		ret += IOMMU_PAGE_ALIGN(rxqentries *
+					sizeof(struct ibmveth_rx_q_entry), tbl);
+	}
 
 	return ret;
 }
@@ -2449,9 +2715,18 @@ static const struct net_device_ops ibmveth_netdev_ops = {
 #endif
 };
 
+static void ibmveth_put_pool_kobjs(struct ibmveth_adapter *adapter,
+				   int pools_ready)
+{
+	int i;
+
+	for (i = 0; i < pools_ready; i++)
+		kobject_put(&adapter->rx_buff_pool[0][i].kobj);
+}
+
 static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 {
-	int rc, i, mac_len;
+	int rc, i, mac_len, pools_ready = 0;
 	struct net_device *netdev;
 	struct ibmveth_adapter *adapter;
 	unsigned char *mac_addr_p;
@@ -2486,7 +2761,8 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 		return -EINVAL;
 	}
 
-	netdev = alloc_etherdev_mqs(sizeof(struct ibmveth_adapter), IBMVETH_MAX_QUEUES, 1);
+	netdev = alloc_etherdev_mqs(sizeof(struct ibmveth_adapter),
+				    IBMVETH_MAX_QUEUES, IBMVETH_MAX_RX_QUEUES);
 	if (!netdev)
 		return -ENOMEM;
 
@@ -2499,7 +2775,10 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 	adapter->mcastFilterSize = be32_to_cpu(*mcastFilterSize_p);
 	ibmveth_init_link_settings(netdev);
 
-	netif_napi_add_weight(netdev, &adapter->napi[0], ibmveth_poll, 16);
+	for (i = 0; i < IBMVETH_MAX_RX_QUEUES; i++)
+		netif_napi_add_weight(netdev, &adapter->napi[i],
+				      ibmveth_poll, 16);
+
 
 	netdev->irq = dev->irq;
 	netdev->netdev_ops = &ibmveth_netdev_ops;
@@ -2531,16 +2810,27 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 		netdev->features |= NETIF_F_FRAGLIST;
 	}
 
-	/* Initialize queue count - always 1 for now */
-	adapter->multi_queue = 0;
-	adapter->num_rx_queues = IBMVETH_DEFAULT_RX_QUEUES;
+	if (ret == H_SUCCESS &&
+	    (ret_attr & IBMVETH_ILLAN_RX_MULTI_QUEUE_SUPPORT)) {
+		adapter->multi_queue = 1;
+		adapter->num_rx_queues = min(num_online_cpus(),
+					     IBMVETH_DEFAULT_QUEUES);
+		netdev_dbg(netdev, "RX multi queue mode enabled: %d queues\n",
+			   adapter->num_rx_queues);
+	} else {
+		adapter->multi_queue = 0;
+		adapter->num_rx_queues = IBMVETH_DEFAULT_RX_QUEUES;
+	}
 
 	if (ret == H_SUCCESS &&
 	    (ret_attr & IBMVETH_ILLAN_RX_MULTI_BUFF_SUPPORT)) {
-		adapter->rx_buffers_per_hcall = IBMVETH_MAX_RX_REGULAR;
+		if (adapter->multi_queue)
+			adapter->rx_buffers_per_hcall = IBMVETH_MAX_RX_QUEUE;
+		else
+			adapter->rx_buffers_per_hcall = IBMVETH_MAX_RX_REGULAR;
 		netdev_dbg(netdev,
 			   "RX Multi-buffer hcall supported by FW, batch set to %u\n",
-			    adapter->rx_buffers_per_hcall);
+			   adapter->rx_buffers_per_hcall);
 	} else {
 		adapter->rx_buffers_per_hcall = 1;
 		netdev_dbg(netdev,
@@ -2558,15 +2848,24 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
 		struct kobject *kobj = &adapter->rx_buff_pool[0][i].kobj;
-		int error;
 
 		ibmveth_init_buffer_pool(&adapter->rx_buff_pool[0][i], i,
 					 pool_count[i], pool_size[i],
 					 pool_active[i]);
-		error = kobject_init_and_add(kobj, &ktype_veth_pool,
-					     &dev->dev.kobj, "pool%d", i);
-		if (!error)
-			kobject_uevent(kobj, KOBJ_ADD);
+		rc = kobject_init_and_add(kobj, &ktype_veth_pool,
+					  &dev->dev.kobj, "pool%d", i);
+		if (rc) {
+			dev_err(&dev->dev,
+				"failed to create pool%d kobject: %d\n", i, rc);
+			/* init_and_add takes a ref even on failure */
+			kobject_put(kobj);
+			ibmveth_put_pool_kobjs(adapter, pools_ready);
+			free_netdev(netdev);
+			return rc;
+		}
+
+		pools_ready++;
+		kobject_uevent(kobj, KOBJ_ADD);
 	}
 
 	rc = netif_set_real_num_tx_queues(netdev, min(num_online_cpus(),
@@ -2574,6 +2873,7 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 	if (rc) {
 		netdev_dbg(netdev, "failed to set number of tx queues rc=%d\n",
 			   rc);
+		ibmveth_put_pool_kobjs(adapter, pools_ready);
 		free_netdev(netdev);
 		return rc;
 	}
@@ -2590,6 +2890,7 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 
 	if (rc) {
 		netdev_dbg(netdev, "failed to register netdev rc=%d\n", rc);
+		ibmveth_put_pool_kobjs(adapter, pools_ready);
 		free_netdev(netdev);
 		return rc;
 	}
@@ -2761,7 +3062,6 @@ static ssize_t veth_pool_store(struct kobject *kobj, struct attribute *attr,
 	return rc;
 }
 
-
 #define ATTR(_name, _mode)				\
 	struct attribute veth_##_name##_attr = {	\
 	.name = __stringify(_name), .mode = _mode,	\
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index f0b2d470d012..6e1a964df42a 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -30,6 +30,7 @@
 #define IbmVethMcastRemoveFilter     0x2UL
 #define IbmVethMcastClearFilterTable 0x3UL
 
+#define IBMVETH_ILLAN_RX_MULTI_QUEUE_SUPPORT	0x0000000000080000UL
 #define IBMVETH_ILLAN_RX_MULTI_BUFF_SUPPORT	0x0000000000040000UL
 #define IBMVETH_ILLAN_LRG_SR_ENABLED	0x0000000000010000UL
 #define IBMVETH_ILLAN_LRG_SND_SUPPORT	0x0000000000008000UL
@@ -260,7 +261,7 @@ static inline long h_illan_attributes(unsigned long unit_address,
 #define IBMVETH_MAX_TX_BUF_SIZE (1024 * 64)
 #define IBMVETH_MAX_QUEUES 16U
 #define IBMVETH_DEFAULT_QUEUES 8U
-#define IBMVETH_MAX_RX_QUEUES 1U
+#define IBMVETH_MAX_RX_QUEUES 16U
 #define IBMVETH_DEFAULT_RX_QUEUES 1U
 #define IBMVETH_MAX_RX_REGULAR 8U
 #define IBMVETH_MAX_RX_QUEUE 12U
-- 
2.50.1 (Apple Git-155)


