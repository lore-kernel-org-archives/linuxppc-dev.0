Return-Path: <linuxppc-dev+bounces-25454-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D30DC55174
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2026 22:44:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFlpR1yPMz2xlv;
	Thu, 06 Aug 2026 08:44:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785969871;
	cv=none; b=OkjWtrsSstpJ1h9cUtW2jTwOzBj20wZedsOtCPtOJ/7bfcKr9wNLbK2txYhAEWX0/MXtcvTNJfbx1Xdk499FbW/nuPzdzSxgyyNhJPIQmkCrSqehtE01k6xnwULV7dUFgymCoCNLldcs7Gd1GPSotg7p9hdkTVYqsJiUsyYEiyuVFRoxGmUkG3xbEOHRRUudzMuFBTsjGe0lWXbQDF0mwtVmu9tFQlIPgxpHriqEMVT2k6lCdvljVfOPamj/BX3CuIZH48NAFYtb+L25WX//kO8aP7BNiSYLi7M8ZefgMjhgHEnXH/FOg4GHhScZy0WBGbMtmEuWhUC/t8ngfbrPkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785969871; c=relaxed/relaxed;
	bh=KVbsdHtk1APMTbUQTh6+PCCt8U7Buysx03L8SDHtdoM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A1yqIro0eks201O2AqKcTysYZUTTdlVsA73PzLK+dKTA+J8KyoORfDVwfPn6maVOcYHu4eLcplQyG03wtnueVfbYGfI2a5q/8COpc/+G6/bcCeJVrIHtzjl2RWqaHTzccnore+pYm1AUG8AR8AdLguLqdSwT2Q/Kocl5gMReuFAF9R2vkXFGsZ/xhlamRgFWqseMIBqmy64dD5d0UPzKuZ+SDAv03Exm39MHl4v/IN2PUN488N/+kyrjmVYk9sWkr2TBPpB1cy2zNzpvWyCBPR8YukLTxqLwDbxU2VhuQSpGXHMo8fAB5/VRVgyRhg4M/WFsH9+oM2ggLRR9LsnwSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bvPbxCMk; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bvPbxCMk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFlpQ4FKFz2xl5
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 08:44:30 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675HlaHe315619;
	Wed, 5 Aug 2026 22:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KVbsdHtk1APMTbUQT
	h6+PCCt8U7Buysx03L8SDHtdoM=; b=bvPbxCMkU+k5RfzQGMMagji8bFnsygIN6
	M2eyUbFItcNnL79A4UjuKuUn4EIGwW9VsVblWEzl3rv2VxgHEG1yAg6nwnOvYZWd
	JJWOEsX0yyj90SqPUOxzsFRx52zqNl8Sxl6WgQ1nXxgi9j/JpFAijEB6pDNLXOOo
	zuVkebT/PiFm5MCaknz0qrJzMJtjUatg3B6c+eLqw0u+rkvjBXNxCwPb78dLzcpi
	nw/kJGovaFE3c2cPJyMhkEpvsG4I+A0YCQq60Q6IzZRfcsQuiTcBrMqwd0cJXDRw
	obMfkMKqfK8Vp29utoj+DWOU9+y8pDBXlbfdqwCGyVukX229JgEtg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a45d20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 22:44:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675MfIAk016634;
	Wed, 5 Aug 2026 22:44:25 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qrs16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 22:44:25 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675MiNcq51183996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 22:44:23 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7855D58054;
	Wed,  5 Aug 2026 22:44:23 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F35D5805A;
	Wed,  5 Aug 2026 22:44:21 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.135.24])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 22:44:21 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, haren@linux.ibm.com,
        ricklind@linux.ibm.com, nnac123@linux.ibm.com, davemarq@linux.ibm.com,
        vaishnavi@linux.ibm.com, bjking1@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, mmc@linux.ibm.com
Subject: [PATCH net-next v1 3/6] ibmvnic: do not unmap long term buffers across a crq reconnect
Date: Wed,  5 Aug 2026 15:43:58 -0700
Message-Id: <20260805224401.58791-4-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260805224401.58791-1-mmc@linux.ibm.com>
References: <20260805224401.58791-1-mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a73bccb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=wLUknyThVMtLD3m8yAcA:9
X-Proofpoint-ORIG-GUID: gOeOclbr04bj4vyDQcXyXMtDJ7CfhdmR
X-Proofpoint-GUID: MTj5vPoWoAJqwx5hTKKojdm0LwYLQ2MY
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDE4MyBTYWx0ZWRfX1nHfCOYjdiSR
 6hamktMzJ0eSUwI7UIgH2MttC8MwnaxFSFe0N7sNzq0VmSz2bF1nVJLVYaIir9cJAiJGKV8SO2H
 pF+EocUHIP3AArCFrHOkU+hsnaRLEwY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDE4MyBTYWx0ZWRfX5AEA4NJNHa1h
 T2j8nXMIzxzNHcEDuvr/MdqLOHOvpQBdtkCLgwBCroI5QDwqjdMF+6WFjCcN5538bHP0f5lhYLl
 9kDo+Fmqiu3bty2BewBC6ia5CJHG8A9eImmlnGNKuprz9L3ayEeq0J6Fmei3bUoloagjhYOqkV/
 kbAdY/ZdcmgWwruIfkSQeJM0aCcJHLkDgRcvKaBXiOZQxpINLYeIOhKldY1ctLjFwbRJEKGYfkd
 iV2tJCUrVTdI/fMrodAoD5CTrptqX7x5MCowR0+qvj0D+qqkKZqer/zDKZLtCkcY2ytI+OO6y3j
 /T3JTY3vOY3IPUJ3htNZtFfeFiGMZ720Qo8WA2qRR2vmqMWQe9DdBvwL2fLRcMNYHmoBznH5oUk
 ZDf0QY6tXZxqx/MSdtQdFXyrrn4kUfqERJ5ztQkTt2Jn+s/K6RwQ2+HI3G4BIaBlrd8U9aUETdQ
 CeNelVKs5sBPMQrMrpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050183

Once in-range mtus are honoured, changing the mtu - especially up to
jumbo - becomes a normal admin action rather than a rare failover path.
Those changes can make the VIOS reconfigure the backing device and
re-establish the crq connection. Every long term buffer mapping belongs
to the connection it was registered on, so the VIOS drops all of them,
and the driver then asks it to unmap buffers it no longer knows about:

  ibmvnic 30000003 env3: MTU change 1400->9000: slow path (reset required)
  ibmvnic 30000003: Partner initialization complete
  ibmvnic 30000003: Partner protocol version is 1
  ibmvnic 30000003: Error 4 in REQUEST_UNMAP_RSP
  ibmvnic 30000003: Error 4 in REQUEST_UNMAP_RSP
  ...

Error 4 is H_PARAMETER, one per buffer still on the books. Traffic keeps
flowing; the damage is to the log. A single jumbo mtu change prints a
flood of these lines, which drowns out real failures and makes every
reset look broken.

free_long_term_buff() decides from reset_reason alone, listing the
resets after which the VIOS is known to have unmapped everything. That
cannot describe this case. The connection is re-established by the
partner partway through the reset, so whether an unmap is still valid
depends on when it is sent rather than on why the reset was started,
which is why the errors come and go between otherwise identical runs.

Give the connection a generation, bump it whenever the crq goes away,
and record it in each long term buffer as that buffer is mapped. One
whose generation no longer matches was mapped on a connection that has
since gone, so release it locally and leave the VIOS alone. The field
fits in the padding that already followed map_id, so the struct stays
32 bytes and the few hundred mappings an adapter can hold cost nothing
extra.

The reset_reason tests are now redundant, since all three tear the
connection down, but leave them for the moment.

Fixes: 7d3a7b9ea59d ("ibmvnic: skip send_request_unmap for timeout reset")
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Vaishnavi Bhat <vaishnavi@linux.ibm.com>
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 30 +++++++++++++++++++++++-------
 drivers/net/ethernet/ibm/ibmvnic.h |  2 ++
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index f5f9c0d5b4e6..e875f43a1ea1 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -495,6 +495,9 @@ static int alloc_long_term_buff(struct ibmvnic_adapter *adapter,
 	adapter->fw_done_rc = 0;
 	reinit_completion(&adapter->fw_done);
 
+	/* Snapshot gen before the map wait so a reconnect mid-wait is stale. */
+	ltb->crq_gen = adapter->crq.gen;
+
 	rc = send_request_map(adapter, ltb->addr, ltb->size, ltb->map_id);
 	if (rc) {
 		dev_err(dev, "send_request_map failed, rc = %d\n", rc);
@@ -529,11 +532,12 @@ static void free_long_term_buff(struct ibmvnic_adapter *adapter,
 	if (!ltb->buff)
 		return;
 
-	/* VIOS automatically unmaps the long term buffer at remote
-	 * end for the following resets:
-	 * FAILOVER, MOBILITY, TIMEOUT.
+	/* Skip unmap if mapped on a prior crq generation, or after resets
+	 * where the VIOS has already dropped mappings (FAILOVER/MOBILITY/
+	 * TIMEOUT).
 	 */
-	if (adapter->reset_reason != VNIC_RESET_FAILOVER &&
+	if (ltb->crq_gen == adapter->crq.gen &&
+	    adapter->reset_reason != VNIC_RESET_FAILOVER &&
 	    adapter->reset_reason != VNIC_RESET_MOBILITY &&
 	    adapter->reset_reason != VNIC_RESET_TIMEOUT)
 		send_request_unmap(adapter, ltb->map_id);
@@ -5974,6 +5978,18 @@ static int handle_query_phys_parms_rsp(union ibmvnic_crq *crq,
 	return rc;
 }
 
+/**
+ * ibmvnic_crq_deactivate() - Mark the crq connection inactive
+ * @crq: crq queue
+ *
+ * Bump gen so LTB mappings from the old connection can be freed locally.
+ */
+static void ibmvnic_crq_deactivate(struct ibmvnic_crq_queue *crq)
+{
+	crq->active = false;
+	crq->gen++;
+}
+
 static void ibmvnic_handle_crq(union ibmvnic_crq *crq,
 			       struct ibmvnic_adapter *adapter)
 {
@@ -6036,7 +6052,7 @@ static void ibmvnic_handle_crq(union ibmvnic_crq *crq,
 		return;
 	case IBMVNIC_CRQ_XPORT_EVENT:
 		netif_carrier_off(netdev);
-		adapter->crq.active = false;
+		ibmvnic_crq_deactivate(&adapter->crq);
 		/* terminate any thread waiting for a response
 		 * from the device
 		 */
@@ -6241,7 +6257,7 @@ static int ibmvnic_reset_crq(struct ibmvnic_adapter *adapter)
 
 	memset(crq->msgs, 0, PAGE_SIZE);
 	crq->cur = 0;
-	crq->active = false;
+	ibmvnic_crq_deactivate(crq);
 
 	/* And re-open it again */
 	rc = plpar_hcall_norets(H_REG_CRQ, vdev->unit_address,
@@ -6276,7 +6292,7 @@ static void release_crq_queue(struct ibmvnic_adapter *adapter)
 			 DMA_BIDIRECTIONAL);
 	free_page((unsigned long)crq->msgs);
 	crq->msgs = NULL;
-	crq->active = false;
+	ibmvnic_crq_deactivate(crq);
 }
 
 static int init_crq_queue(struct ibmvnic_adapter *adapter)
diff --git a/drivers/net/ethernet/ibm/ibmvnic.h b/drivers/net/ethernet/ibm/ibmvnic.h
index 480dc587078f..4cfedae5d89d 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.h
+++ b/drivers/net/ethernet/ibm/ibmvnic.h
@@ -794,6 +794,7 @@ struct ibmvnic_crq_queue {
 	/* Used for serialization of msgs, cur */
 	spinlock_t lock;
 	bool active;
+	u32 gen; /* bumped when the crq connection drops */
 	char name[32];
 };
 
@@ -839,6 +840,7 @@ struct ibmvnic_long_term_buff {
 	dma_addr_t addr;
 	u64 size;
 	u8 map_id;
+	u32 crq_gen; /* crq.gen when this buffer was mapped */
 };
 
 struct ibmvnic_ltb_set {
-- 
2.50.1 (Apple Git-155)


