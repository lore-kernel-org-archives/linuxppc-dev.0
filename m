Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58608606A31F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 07:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XpE14GvW
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXypJ5hVsz2yS0;
	Mon, 23 Nov 2026 18:52:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795420344;
	cv=none; b=JYHO/iKZAQ9z8Yrwzd2vUiDKO1GvpzY7iwWEwYlz+T1rMoIpZRAxU8hjTuMcQDQyxtXKs00G08DUZynD/PMkfr2eI1iEWSM/V6xL++5a9XwHxSt7BgrRco7gBSePPcOyFYMl3ZIryJ0JrqSJAMq1REiLGa2zWBNkLLnP2qkMWArDveMbnGIHhUQcaxNtJNHwIkeY36v6hgW5kWA73Tlt5DRzT55JzcdXY7besVjI44hfjlwAjUx1smpxDpg8dCsg8GqiaFtD/DvQtKypOHrcKM9hj6QstZTtOIoSI7Ng5hGQTRc3cURa0yv+mXabYDYVqULYIGPBjbke3V7qeu+/FA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795420344; c=relaxed/relaxed;
	bh=cRAMntHtDcfc3kKLbL0HirHZLhniQPHoNUZeXse+Omo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jTr9tAzyIrSEBVmA5MksywRDLMWtgaZilgtsTnhvymWvIrVgb330Vj22p769JUhyx5P/qkk8y2c9/uG2VCTALdWbCx9035vbkA7m2xwxYOMIDF7YDSsGD0rXVFJNPfCw3CHY1SHuWhHq9yuir2No+mZ1UH3bKVlhoW9YwIYmzoo0Bwng4O6Mi7AvWA5MKCjpt6TSWXt7sOo5yoYmM35izlaqc9WO0IG07nDLGUKSVa0Zd4tBf2dsdwnHMKhLIS8ANhMvCTGReIr4H69brmd67WHrotCHKxAdlQtc+fyiIdj2euOXMYX1am9Uw0udT2w1zYi0v2k/hmmYdEuiDeUlSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XpE14GvW; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XpE14GvW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXypH6r2Fz2yRn
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 18:52:23 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN54rcp1364742;
	Mon, 23 Nov 2026 07:52:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cRAMntHtDcfc3kKLb
	L0HirHZLhniQPHoNUZeXse+Omo=; b=XpE14GvWmputqVnG/RafjoY7vkJp7l7Nj
	6IqWlBfpomn2OEfKVDAkkCxBDpaSnx12cq0d6z5rc9gjFkS5Y3VKOWMGOKG/Zprb
	5p3/FIxGaY/VTAoyEdfX1ZTQy4c9Iybgec5Lb6XthAxLGbdMco6ifPjJswXzKaqB
	xEPRsFNzu2fk/PgjnmeXPkyybGvVYfcfOCz4X9NtnzaJZ2O8KXPBylkBopqp0vnf
	xT2/+G+/E3F/cJzdfkvUx1YOaR51RCPKtlf/5yAb25V0UFvDlMyCCr5gprvogGel
	kQLic3jJo9dFQy/MGiFto4rgAFIPZ3uaRe/85ue733dUyoAq39pMw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p49p2t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 07:52:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN54fqR264691;
	Mon, 23 Nov 2026 07:52:01 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j3qufnn41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 07:52:01 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AN7pwN434079454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 07:51:58 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70BCC5805A;
	Mon, 23 Nov 2026 07:51:58 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 080E35803F;
	Mon, 23 Nov 2026 07:51:56 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.2.38])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 07:51:55 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        sshegde@linux.ibm.com, nnac123@linux.ibm.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org, horms@kernel.org,
        davemarq@linux.ibm.com, haren@linux.ibm.com, ricklind@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Subject: [PATCH net-next v2 5/8] ibmveth: Refactor TX resource allocation in open/close paths
Date: Sun, 22 Nov 2026 23:51:33 -0800
Message-Id: <20261123075136.3278-6-mmc@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAzMCBTYWx0ZWRfX/pjuW6QQIxN4
 HfJMYehlHakjr12QQy1J1ycZz98RkADc55FMLVLGLqTa7YojuQzGPpHb93700szJxMd4/v4oiee
 ohKi8za3aLqucprZNIwKKYqo/+ffv1c=
X-Proofpoint-GUID: mIQjlQN350wh821JIKGqXC66-29ZlaO3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAzMCBTYWx0ZWRfXyR2NaOd9pqc9
 rXDSuSBv1T/Vkwz0arUXifbzCALopg4TUocnX83BThZylFjf6pnxdNcGD/kxXqyQd7sEKre2yyI
 /Cfm2Cs10RXdtvX0jI1r2nK11z8SODPbRuRhJWygMSW7lIinrylggT1h5+d4xJa8/V30Qm4bAr0
 P1WX5qNNsH3ZNQiFBD1DyPnnnsod73YC6QQWezxmo1MRvRr4u1Go2qbuRR1c0K2PWeBqW2r0USW
 HoBUbET6H1axMgi+1ocDSG0OiVD3PS0nbJKrSD/sbfTnbV9EhHMk+b+ZPpQHpiLCyN6ayCUPKan
 Km25V08cXXcuV1ny7eWJx8a5t85Uaqmheceemh5pFWpHKt4z5wYykP+Ks5ZLtJSoGvFX4vJnOI4
 Jg75DncjYMDkQNbNFIr1ETuNi8CMg41rsmq+AWGxgXQkzFPdDUr1W3tDAUSMzkGydE4U5gZvqmm
 5NgLzdRtzjj/bvsfJqg==
X-Proofpoint-ORIG-GUID: MnfOyZlebSq--ayKwG9Tzm_-noEB3Ok3
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b03f0a2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=C2ZisYdtOmHXE8G5D3kA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230030
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move TX LTB allocation and free out of open() and close() into
ibmveth_alloc_tx_resources() and ibmveth_free_tx_resources(), like
the RX helpers. alloc_tx_resources() frees its own partial
allocation, so open() no longer unwinds TX with a loop index shared
with the allocation.

open() still maps the TX LTBs before any RX buffer goes to PHYP:
under CMO both draw on the same IO entitlement, and a failed RX
mapping only skips that buffer while a failed TX mapping fails
open(). It now starts TX under netif_tx_lock_bh() so a sender that
sees DRV_XOFF clear after close() also sees the new LTBs.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
Changes in v2:
- map TX LTBs before RX buffers go to PHYP again; v1 moved them after
  RX bring-up (Sashiko)
- drop the netif_tx_disable() at the top of open(); close() frees TX
  last again

 drivers/net/ethernet/ibm/ibmveth.c | 68 +++++++++++++++++++++++++-----
 1 file changed, 57 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index ea0e5158040c..06741a6756b8 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1052,6 +1052,48 @@ static int ibmveth_allocate_tx_ltb(struct ibmveth_adapter *adapter, int idx)
 	return 0;
 }
 
+/**
+ * ibmveth_alloc_tx_resources - Allocate TX LTBs for real_num_tx_queues
+ * @adapter: ibmveth adapter structure
+ *
+ * Allocate a TX long-term buffer for each live TX queue. On a
+ * partial failure this helper already frees what it allocated.
+ *
+ * Return: 0 on success, -ENOMEM on failure
+ */
+static int ibmveth_alloc_tx_resources(struct ibmveth_adapter *adapter)
+{
+	struct net_device *netdev = adapter->netdev;
+	int i;
+
+	for (i = 0; i < netdev->real_num_tx_queues; i++) {
+		if (ibmveth_allocate_tx_ltb(adapter, i))
+			goto err_free_ltbs;
+	}
+
+	return 0;
+
+err_free_ltbs:
+	while (--i >= 0)
+		ibmveth_free_tx_ltb(adapter, i);
+	return -ENOMEM;
+}
+
+/**
+ * ibmveth_free_tx_resources - Free TX LTBs for real_num_tx_queues
+ * @adapter: ibmveth adapter structure
+ *
+ * Free the TX long-term buffers for each live TX queue.
+ */
+static void ibmveth_free_tx_resources(struct ibmveth_adapter *adapter)
+{
+	struct net_device *netdev = adapter->netdev;
+	int i;
+
+	for (i = 0; i < netdev->real_num_tx_queues; i++)
+		ibmveth_free_tx_ltb(adapter, i);
+}
+
 static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
         union ibmveth_buf_desc rxq_desc, u64 mac_address)
 {
@@ -1102,11 +1144,13 @@ static int ibmveth_open(struct net_device *netdev)
 	if (rc)
 		goto out_free_filter_list;
 
-	rc = -ENOMEM;
-	for (i = 0; i < netdev->real_num_tx_queues; i++) {
-		if (ibmveth_allocate_tx_ltb(adapter, i))
-			goto out_free_tx_ltb;
-	}
+	/* Map the TX LTBs before RX buffers go to PHYP: under CMO they
+	 * draw on the same IO entitlement, and only RX copes with a
+	 * failed mapping.
+	 */
+	rc = ibmveth_alloc_tx_resources(adapter);
+	if (rc)
+		goto out_free_queue_mem;
 
 	mac_address = ether_addr_to_u64(netdev->dev_addr);
 
@@ -1147,7 +1191,12 @@ static int ibmveth_open(struct net_device *netdev)
 	netdev_dbg(netdev, "initial replenish cycle\n");
 	ibmveth_schedule_rx_queue(adapter, 0);
 
+	/* netif_tx_lock() takes each txq lock, so a sender that then sees
+	 * DRV_XOFF clear under its txq lock also sees the LTBs set up above.
+	 */
+	netif_tx_lock_bh(netdev);
 	netif_tx_start_all_queues(netdev);
+	netif_tx_unlock_bh(netdev);
 
 	adapter->opened = true;
 	netdev_dbg(netdev, "open complete\n");
@@ -1160,8 +1209,8 @@ static int ibmveth_open(struct net_device *netdev)
 	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
 	ibmveth_free_buffer_pools(adapter);
 out_free_tx_ltb:
-	for (i = netdev->real_num_tx_queues - 1; i >= 0; i--)
-		ibmveth_free_tx_ltb(adapter, i);
+	ibmveth_free_tx_resources(adapter);
+out_free_queue_mem:
 	ibmveth_cleanup_rx_resources(adapter);
 out_free_filter_list:
 	ibmveth_free_filter_list(adapter);
@@ -1173,7 +1222,6 @@ static int ibmveth_close(struct net_device *netdev)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
 	long lpar_rc;
-	int i;
 
 	/* change_mtu, pool sysfs, set_csum and set_tso call close() and
 	 * open() directly. If that open() fails, IFF_UP stays set and
@@ -1201,9 +1249,7 @@ static int ibmveth_close(struct net_device *netdev)
 	ibmveth_free_buffer_pools(adapter);
 	ibmveth_cleanup_rx_resources(adapter);
 	ibmveth_free_filter_list(adapter);
-
-	for (i = 0; i < netdev->real_num_tx_queues; i++)
-		ibmveth_free_tx_ltb(adapter, i);
+	ibmveth_free_tx_resources(adapter);
 
 	netdev_dbg(netdev, "close complete\n");
 
-- 
2.50.1 (Apple Git-155)


