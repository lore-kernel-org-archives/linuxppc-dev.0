Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D097A606A335
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 00:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=s5sk9TXQ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVJh55w6Dz2yr0;
	Thu, 19 Nov 2026 11:07:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795046869;
	cv=none; b=CE+i/9riF29nlO5PixAbLvBKB7iTIdgT5v3ibDNfvwiZQIM0wjvWCaCF/3k0PhqPc720rJftz0YkXQzo4i6d23fc1S0ugJtwGqbpOh67YOXV4Kgs8BKRtsH8x87jD6Uq7uWZZwR6focRM3ETbexOzgyTwIdD10SU+Zi2bi+DwEHZjkB7kfj6eq26Mb2tjexIys7IjWdkuKZGT/1Bo6mC/Ca+0P8DzoInXwIQiMw7kjxVmNCVlvJbIrFlyl9xOoj2j24cl1qrlitHxXvXo4JHx59ESsl929Ujw+dtkLVXPQAD+Oet0rP+eoviOGVmQzO3Cy7qZFSwZpadKZzqmDHY/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795046869; c=relaxed/relaxed;
	bh=QmXTZrLOAZbZ/cOB09lyN5WkLJFB/KHg1KF/2Fo8HsE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VAa9N0TlHb9Ow9//TmTOPJJx1mkZxvU4r7I1/s+1ghaNwcGoJwzaS6KiWzpwYedkxkZilm/5O4cAcA2+lZZS6K68/k6ti9iNsSpZSl+9OsKFtXj4yQnQ30MQ9bAXR9tQIuehD0XM90lS6TFuoz/F9MwjI6hMz9aouq/uuVsNs0UOh5FhIvwhdPTseCfqtLMU9uw3TJBK0LK4hrU8r1jChvUZ5Z1V943ra4yg3XYIeXlaq1/M7+/CvKYL67Pm9S+2/Aix4ZTH3rZMnYBu6rykR7bBIf4SX/GON50fd73QeLMgfrJkoK7pe1lEJY+guIljrCjkQjE4rmPXyNiXvR3rXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=s5sk9TXQ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=s5sk9TXQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVJh50HvMz2xnQ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 11:07:48 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AILRBaE2242166;
	Thu, 19 Nov 2026 00:07:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=QmXTZrLOAZbZ/cOB0
	9lyN5WkLJFB/KHg1KF/2Fo8HsE=; b=s5sk9TXQN0mvv+ZqUObOkSYoUD8U58hbq
	OZjGSyj8zVp+1SA8v2TSLauLLqkCN/jmab19rDsiH76ew5/6sT+mWx/CbnkiTSgk
	knWoWRUw8/d/1Qmr6pezZnjQWH0EG91hj2jSHmFsl5nf3IwJW8KPO4/8aJ9ZBCVF
	Y0ytrN5knByddYMs1c1hA8eafJWOawxiKAOULZLEgdFISqGpfT+9WAoTwCEHkWRq
	5wXUEKbXOwhadmZxgK1RGc+0l1s9uWv1O5w3IYqipzmMBMvtbyT8mZ71B4Ih/FeU
	xT82QrfeTo3HN0Y0pxvmV9rUQekJ+tgGQeA4kqqv37CsEgqBOws1Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105vn5p2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 00:07:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AILK7df2587017;
	Thu, 19 Nov 2026 00:07:37 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j17c4u36m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 00:07:37 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AJ07Z3s18612868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Nov 2026 00:07:35 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E15558051;
	Thu, 19 Nov 2026 00:07:35 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 021745805A;
	Thu, 19 Nov 2026 00:07:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.93.165])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Nov 2026 00:07:32 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        sshegde@linux.ibm.com, nnac123@linux.ibm.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org, horms@kernel.org,
        davemarq@linux.ibm.com, haren@linux.ibm.com, ricklind@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Subject: [PATCH net-next 5/8] ibmveth: Refactor TX resource allocation in open/close paths
Date: Wed, 18 Nov 2026 16:07:08 -0800
Message-Id: <20261119000711.18093-6-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261119000711.18093-1-mmc@linux.ibm.com>
References: <20261119000711.18093-1-mmc@linux.ibm.com>
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
X-Proofpoint-GUID: QNdMwJa4wxsBPxievL7L0U0s8vF9RAjO
X-Authority-Analysis: v=2.4 cv=HL9WhYtv c=1 sm=1 tr=0 ts=6afe3dca cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=pSCbO-B-MqCK0wuF0D8A:9
X-Proofpoint-ORIG-GUID: jf69Ky0xuMzRo_mdjUEWdO24Y-Iv7ku6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA4OCBTYWx0ZWRfX43fwiKAoWUH0
 7bc2dzpm5Df37fTiSTmx1gJoA9J2meJ1GvY1JWzg5B1LPBt3XfdpNRMHoDA/xm6eaPihFMwW2MK
 keB1gTt37vfV97jcb4QjWzYc/+R8WL8z6Jpb5EsaBHcz7zeHHfI2SwTAmNoMWflpjIo3Zs4uXSA
 TTc+q7XrQc91ox5SCzbh0zH2P+4VCsxewKlvV85fHOTZh0wFNUeDaBjC34LxGcPXQVTQHjOmIsy
 nPAi3mP8mNOBnUH2T7TCG9Zm2TOhF0NABiB0Kd2U2G+6tmF+Ghvh3bkENd+1BcBw/wyjZCoMszT
 3ONF8wGlGE6Cvoma3NlI4RDZdXvbAve+UgKGJYRWhaPhx6OJ4cZMZgmlkdC5ARO415XTT8BeDCv
 jwqnBxs9D3ze12hQMYn6MilDL8cRwcBZPfhy10KZnxFTV7YiX1OlIcRgqe4R7nRiIU17IHiddXU
 z8b48zNWXrNITVS12HQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA4OCBTYWx0ZWRfX7OZajr0U6kgh
 NRnNBoubwfdvUy+r5DnOiFuuyXd4r/zEuHerC5IYg1IOkfowgR/QCJwA9Of0nuttwb5dWmLHV2b
 azXQZmb6jKLtdfw06+rC743We/VISlw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_07,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180088
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move TX LTB allocation and free out of open() and close() into
ibmveth_alloc_tx_resources() and ibmveth_free_tx_resources(), like
the RX helpers.

open() now allocates the TX LTBs last, after RX is running. It stops
TX with netif_tx_disable() first: on a first open the queues are not
DRV_XOFF, so generic XDP_TX could transmit before the LTBs exist. It
starts TX under netif_tx_lock_bh() once they do. A TX allocation
failure unwinds RX the way close() does.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 82 +++++++++++++++++++++++-------
 1 file changed, 65 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index ab5df1794004..8f32f75f2d7f 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1046,6 +1046,48 @@ static int ibmveth_allocate_tx_ltb(struct ibmveth_adapter *adapter, int idx)
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
@@ -1085,6 +1127,11 @@ static int ibmveth_open(struct net_device *netdev)
 
 	netdev_dbg(netdev, "open starting\n");
 
+	/* Stop TX first. First-open queues are not DRV_XOFF, so generic
+	 * XDP_TX could run once NAPI is up and before the LTBs exist.
+	 */
+	netif_tx_disable(netdev);
+
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
 		rxq_entries += adapter->rx_buff_pool[0][i].size;
 
@@ -1096,12 +1143,6 @@ static int ibmveth_open(struct net_device *netdev)
 	if (rc)
 		goto out_free_filter_list;
 
-	rc = -ENOMEM;
-	for (i = 0; i < netdev->real_num_tx_queues; i++) {
-		if (ibmveth_allocate_tx_ltb(adapter, i))
-			goto out_free_tx_ltb;
-	}
-
 	mac_address = ether_addr_to_u64(netdev->dev_addr);
 
 	rxq_desc.fields.flags_len = IBMVETH_BUF_VALID |
@@ -1123,12 +1164,12 @@ static int ibmveth_open(struct net_device *netdev)
 				     rxq_desc.desc,
 				     mac_address);
 		rc = -ENONET;
-		goto out_free_tx_ltb;
+		goto out_free_queue_mem;
 	}
 
 	rc = ibmveth_alloc_buffer_pools(adapter);
 	if (rc)
-		goto out_free_buffer_pools;
+		goto out_unregister_lan;
 
 	/* Enables NAPI, so everything ibmveth_poll() touches must exist:
 	 * netpoll during the direct close()/open() pairs, or a direct
@@ -1136,26 +1177,35 @@ static int ibmveth_open(struct net_device *netdev)
 	 */
 	rc = ibmveth_setup_rx_interrupts(adapter);
 	if (rc)
-		goto out_free_buffer_pools;
+		goto out_unregister_lan;
 
 	netdev_dbg(netdev, "initial replenish cycle\n");
 	ibmveth_schedule_rx_queue(adapter, 0);
 
+	rc = ibmveth_alloc_tx_resources(adapter);
+	if (rc)
+		goto out_cleanup_rx_interrupts;
+
+	/* Start under the xmit lock so a sender that tests DRV_XOFF
+	 * there sees the LTBs this open just published.
+	 */
+	netif_tx_lock_bh(netdev);
 	netif_tx_start_all_queues(netdev);
+	netif_tx_unlock_bh(netdev);
 
 	adapter->opened = true;
 	netdev_dbg(netdev, "open complete\n");
 
 	return 0;
 
-out_free_buffer_pools:
+out_cleanup_rx_interrupts:
+	ibmveth_cleanup_rx_interrupts(adapter);
+out_unregister_lan:
 	do {
 		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
 	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
 	ibmveth_free_buffer_pools(adapter);
-out_free_tx_ltb:
-	for (i = netdev->real_num_tx_queues - 1; i >= 0; i--)
-		ibmveth_free_tx_ltb(adapter, i);
+out_free_queue_mem:
 	ibmveth_cleanup_rx_resources(adapter);
 out_free_filter_list:
 	ibmveth_free_filter_list(adapter);
@@ -1167,7 +1217,6 @@ static int ibmveth_close(struct net_device *netdev)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
 	long lpar_rc;
-	int i;
 
 	/* change_mtu, pool sysfs, set_csum and set_tso call close() and
 	 * open() directly. If that open() fails, IFF_UP stays set and
@@ -1192,13 +1241,12 @@ static int ibmveth_close(struct net_device *netdev)
 			   lpar_rc);
 	}
 	ibmveth_update_rx_no_buffer(adapter);
+	/* netif_tx_disable() above keeps xmit off the TX LTBs. */
+	ibmveth_free_tx_resources(adapter);
 	ibmveth_free_buffer_pools(adapter);
 	ibmveth_cleanup_rx_resources(adapter);
 	ibmveth_free_filter_list(adapter);
 
-	for (i = 0; i < netdev->real_num_tx_queues; i++)
-		ibmveth_free_tx_ltb(adapter, i);
-
 	netdev_dbg(netdev, "close complete\n");
 
 	return 0;
-- 
2.50.1 (Apple Git-155)


