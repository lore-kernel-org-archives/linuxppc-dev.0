Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8694606A330
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 07:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UDkPpK/w
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXynP2x35z2xyj;
	Mon, 23 Nov 2026 18:51:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795420297;
	cv=none; b=byY8u6fSS2jzhZbZBkEb5LPqaBME+sFwxnj9XoMu5WXnywB/l3i8/8P81s5mk/4zk91OuGwtdiwyLbuLE89B8Q1GyA7a6dvZnas1nzfCjAPLA1E0SUgtAomNydSBNqwtVqnLxilZaTVApJjpFpwVmAIUmczRVziRDHfJloYCTf7K/tNeQHHFufvrf3mr50FrQYQYohHc5gJyncl66EEJeWBXq8u+NrEq9b4IuJW8/PDhqe75iGumuGwUJLULkinH+Lx6/fKpyHU0zFNcQ15Qk5VCD6Box9XlXrTBi0TPmTdRJPTfotFgouQ3/q5bJMkjjpJlvGAOHqZ5HvSpol+HQw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795420297; c=relaxed/relaxed;
	bh=nyCbZ+JMnydmEkBpLBAjj8LOv6uhZfufkQekJf1sgYk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NZfmlTpWCxTwbcwv39dKI3RdEAkxwSONdi1thiFEsVgTXvNmgrs/dC92aeE8Y6f36doFJedlqTzv9mA0CpCbSnVKHe2bxXPB6r/62zSTmEBd8LSfRmhVZegsppkGCrTmESS+N6Cn2IyoC7+lksntdKwhSkUvfWA14vePOuvMGGq0q4WtqvOaJRvvWcvuXqOVzefQCVSG6wQd6kI5owS28zzBti23QA11uzdFIr+grPPeU8E5o3WPMWIFVZzJwbF8R0ByK/1Gq5lsqNrhez8bVtRm2bIvfXMJCN8a7dE4MnUnbxaVbNmhYZNYF+SEyZwExQaTHToONtFsbfET7yt6pA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UDkPpK/w; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UDkPpK/w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXynM6zxCz2xGg
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 18:51:35 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN55KLT983209;
	Mon, 23 Nov 2026 07:51:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nyCbZ+JMnydmEkBpL
	BAjj8LOv6uhZfufkQekJf1sgYk=; b=UDkPpK/wrZk1VoVb35B+tam2bis+aEw0s
	qpNH0qZUiRY89L6xLJKs0/w0BAv7sp+DtrUB8DkWonUHFJOo4jGO3/ueLDsP1714
	QXB5L61JEfIPAxHEOXmg3ek4v3ZZ4DpFxAzx7tsxFAj++e0oCLo5wBIlAwfrLlm0
	4G+23laVUAxK8rxlMT9QFHMS0R4EHFOn6rMb1oDsrgqyrRpinTsO3awXXjJXlLyX
	1cAvoWFTfT4rsz3wC+II9knwQl4Am4yMl5h6oZhHJlDagb6hzLDcaC45J8gHPyo5
	UCUf07hbzJjhwAQpjUoik70W/FdWgkNE1KukKSKzjB1KlMgHgHgvA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g3238v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 07:51:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN54GDa264437;
	Mon, 23 Nov 2026 07:51:17 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j3qufnn1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 07:51:17 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AN7pGDj28639750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 07:51:16 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04A645803F;
	Mon, 23 Nov 2026 07:51:16 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF6AD58063;
	Mon, 23 Nov 2026 07:51:12 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.2.38])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 07:51:12 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        horms@kernel.org, davemarq@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Subject: [PATCH net-next v2 1/2] ibmveth: drop TX on a queue whose long term buffer was freed
Date: Sun, 22 Nov 2026 23:51:01 -0800
Message-Id: <20261123075102.2962-2-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261123075102.2962-1-mmc@linux.ibm.com>
References: <20261123075102.2962-1-mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=SoQFe/O0 c=1 sm=1 tr=0 ts=6b03f076 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=kixcWV4Xbe6_Ib8X-xcA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAzMCBTYWx0ZWRfX11ELuTmTMPCS
 0VGmJCAYIbEi7zaYisppUSe+TBIP2VVeJSSGZCB0cjuNdKruHNbu0NckGP9Kx4fzHcA2oW+gTMZ
 Xht1NvU4OLTxff1TKYvXh/H3LQzPX/o=
X-Proofpoint-ORIG-GUID: 6Cga-rngYeT8fS0jnHCCIyIgAWzwZwza
X-Proofpoint-GUID: 0rG-9ophgWfs82MeK763X03ilJgN5XKa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAzMCBTYWx0ZWRfX02a53eiapgIb
 diFTHvvTPyQMEJDMmc/+5ExczYpAskMWzWqfw/j3dWuH69X6ZuoSh+e+hhBuZf/x1lNv7pOOeBO
 kIybRZJGTo6Cb86ma6wvkIKvOthxLKvyQ3YIKG1dVVxBK7c7MwRSa1SE0yDTMJ7wpJPYY6tKhMb
 b6/xRqgWwHj4CsbLAOS2KDMG025Qih60L/l1zAvyPAErxb62Shd7rzjBTjwYWEXLGHmze6tcNSo
 KV5gkwr/rhIq+pm2GBdnk9PReWswwh0Ge+jPiqrQGxpcR0zGCgK7efoDuoJ0bOqIjvu0ZR7lklr
 xmPQBQzfvL/kdvWjbKYh83/lgh3AhIBPQja8mjoutTjLw20nlburc/Y6OxdKo5Lg/Ph/DEHb10e
 lrAg4f/Oi8Tu9E9feaQXhT429Za3tjXWhgJseCoZ4dwyuNjqO3ZysZMhCY+6dvg3Tn2CBaOMjoQ
 d6uV2xCKucUCEZ3bK1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230030
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ibmveth_set_channels() frees the TX long term buffer (LTB) of every
queue it removes and then wakes all TX queues. A sender that picked
its queue before the shrink, such as AF_PACKET with
PACKET_QDISC_BYPASS or pktgen, can call ibmveth_start_xmit() on a
removed queue after that, and memcpy() into a NULL LTB.

Read the LTB pointer once and drop the packet if it is NULL.

Stop TX with netif_tx_disable() instead of netif_tx_stop_all_queues(),
so a sender already in ibmveth_start_xmit() has left before
set_channels() allocates, maps or frees an LTB. On a grow, that
sender could otherwise see a new LTB before it is DMA mapped, or one
that the failure path frees again.

Map a new LTB before publishing its pointer with WRITE_ONCE(), and
leave the pointer NULL if the mapping fails, so a sender can only see
an LTB that is fully set up.

Wake the queues under netif_tx_lock_bh(). The LTB updates run with no
txq lock held, and a sender that sees DRV_XOFF clear under its txq
lock is not otherwise ordered against them. Taking every txq lock
before the wake makes it see the cleared pointer on a shrink and the
new pointer and DMA address on a grow.

This came up during review of the ibmveth multi-queue series. It was
not reproduced; the fix is based on analysis of the code paths.

Fixes: 10c2aba89cc0 ("ibmveth: Ethtool set queue support")
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
Changes in v2:
- wake the TX queues under netif_tx_lock_bh() (Sashiko)
- publish the LTB pointer only after it is mapped (Sashiko)

 drivers/net/ethernet/ibm/ibmveth.c | 37 +++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 05d6b60cd187..09eb5bcb306f 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -599,7 +599,7 @@ static void ibmveth_free_tx_ltb(struct ibmveth_adapter *adapter, int idx)
 	if (!ptr)
 		return;
 
-	adapter->tx_ltb_ptr[idx] = NULL;
+	WRITE_ONCE(adapter->tx_ltb_ptr[idx], NULL);
 	dma_unmap_single(&adapter->vdev->dev, adapter->tx_ltb_dma[idx],
 			 adapter->tx_ltb_size, DMA_TO_DEVICE);
 	kfree(ptr);
@@ -607,25 +607,25 @@ static void ibmveth_free_tx_ltb(struct ibmveth_adapter *adapter, int idx)
 
 static int ibmveth_allocate_tx_ltb(struct ibmveth_adapter *adapter, int idx)
 {
-	adapter->tx_ltb_ptr[idx] = kzalloc(adapter->tx_ltb_size,
-					   GFP_KERNEL);
-	if (!adapter->tx_ltb_ptr[idx]) {
+	void *ptr;
+
+	ptr = kzalloc(adapter->tx_ltb_size, GFP_KERNEL);
+	if (!ptr) {
 		netdev_err(adapter->netdev,
 			   "unable to allocate tx long term buffer\n");
 		return -ENOMEM;
 	}
-	adapter->tx_ltb_dma[idx] = dma_map_single(&adapter->vdev->dev,
-						  adapter->tx_ltb_ptr[idx],
+	adapter->tx_ltb_dma[idx] = dma_map_single(&adapter->vdev->dev, ptr,
 						  adapter->tx_ltb_size,
 						  DMA_TO_DEVICE);
 	if (dma_mapping_error(&adapter->vdev->dev, adapter->tx_ltb_dma[idx])) {
 		netdev_err(adapter->netdev,
 			   "unable to DMA map tx long term buffer\n");
-		kfree(adapter->tx_ltb_ptr[idx]);
-		adapter->tx_ltb_ptr[idx] = NULL;
+		kfree(ptr);
 		return -ENOMEM;
 	}
 
+	WRITE_ONCE(adapter->tx_ltb_ptr[idx], ptr);
 	return 0;
 }
 
@@ -1195,7 +1195,7 @@ static int ibmveth_set_channels(struct net_device *netdev,
 	/* We have IBMVETH_MAX_QUEUES netdev_queue's allocated
 	 * but we may need to alloc/free the ltb's.
 	 */
-	netif_tx_stop_all_queues(netdev);
+	netif_tx_disable(netdev);
 
 	/* Allocate any queue that we need */
 	for (i = old; i < goal; i++) {
@@ -1229,7 +1229,12 @@ static int ibmveth_set_channels(struct net_device *netdev,
 			ibmveth_free_tx_ltb(adapter, i - 1);
 	}
 
+	/* netif_tx_lock() takes each txq lock, so a sender that then sees
+	 * DRV_XOFF clear under its txq lock also sees the LTB updates above.
+	 */
+	netif_tx_lock_bh(netdev);
 	netif_tx_wake_all_queues(netdev);
+	netif_tx_unlock_bh(netdev);
 
 	return rc;
 }
@@ -1304,6 +1309,16 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 	union ibmveth_buf_desc desc;
 	int i, queue_num = skb_get_queue_mapping(skb);
 	unsigned long mss = 0;
+	void *ltb;
+
+	/* A sender that picked its queue before ethtool -L shrank the TX
+	 * queues can get here after that queue's LTB was freed.
+	 */
+	ltb = READ_ONCE(adapter->tx_ltb_ptr[queue_num]);
+	if (unlikely(!ltb)) {
+		netdev->stats.tx_dropped++;
+		goto out;
+	}
 
 	if (ibmveth_is_packet_unsupported(skb, netdev))
 		goto out;
@@ -1359,13 +1374,13 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 		netdev->stats.tx_dropped++;
 		goto out;
 	}
-	memcpy(adapter->tx_ltb_ptr[queue_num], skb->data, skb_headlen(skb));
+	memcpy(ltb, skb->data, skb_headlen(skb));
 	total_bytes = skb_headlen(skb);
 	/* Copy frags into mapped buffers */
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 		const skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 
-		memcpy(adapter->tx_ltb_ptr[queue_num] + total_bytes,
+		memcpy(ltb + total_bytes,
 		       skb_frag_address_safe(frag), skb_frag_size(frag));
 		total_bytes += skb_frag_size(frag);
 	}
-- 
2.50.1 (Apple Git-155)


