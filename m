Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECBA606A32C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 00:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ao/XAFfZ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVJZm6cxXz2yNj;
	Thu, 19 Nov 2026 11:03:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795046592;
	cv=none; b=V7/0v6fP5PSgdgYOOstAdNiCWqh5NTjMwkoADibh1hORYK1Bxs5IGFpd3GQMwZal+oxFXX+c2nXzwhoc1wlbQI5ceHBRoaI0Vmlyd2pUNdAI0FuTbP9wmak8kOoylog4LHgRgs20sDZ4Ocxp7KX4u8zHymXyDvRC6mL0Shcqaczzty0bAVgZOzNrfNcVMH7Uz4i1kUWXHW/4yliNXY2o06nPFsVHgH89snMSq3ygOIk0s905DYXC+pmVqqk6lz2q6V2pKXOliCXk9rL6Tw6CkR7CzNNeMuiCFhC8+gAO6anYJEPI+FKd8w60E6HR9fn9MhdyRlcK3A9QZp6fOn6ODA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795046592; c=relaxed/relaxed;
	bh=YqCFKab9xsZRTpxjkKeRrscrZHdCAE8QQn3hnbXjTeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lL5DKMzv+KXylGK33xClyKQTrVSXmgOXMc7WLagHC0QE6m2DymS91jz9PG1cc9LbxT7vQaW+MC+0ASxOTsk0pt9gxSq2BeQW+9RSCmZq+c3pUR696LQcdlmMW9U7ri1BTFHjx6l2N+udS6j/6D7Yj904MZr5g098n0uoCujB9a0kvY0Hx4rzcauHXAumQ4FvGvkdPSgOMF11mYL2I9NeSc8tnRGiCisoUU8ORCq/XwjUR2Z6CRjABE5Xrntx1XcTVnMGCoeLHGx8f/v+G6FLYjxyTIftirNE5IPE1ChV+FymfJLe8CSctwb2RowEGwv5/cEbhOHYgGIX8rijZTuDXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ao/XAFfZ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ao/XAFfZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVJZm0vNyz2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 11:03:11 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AILQYI62240494;
	Thu, 19 Nov 2026 00:03:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=YqCFKab9xsZRTpxjk
	KeRrscrZHdCAE8QQn3hnbXjTeQ=; b=Ao/XAFfZVDyL/TjPj/5pzXTSGJ7uAR/Rw
	5A8UVgMiHP7IcyB4eXYQMnl0uZTjFc+qke0KmR4Gr5l6YyY/UmedDF5bxA7e3u33
	/Kbh/O6f5fA2/fGnTnkpLkefTJxKX0WrvtQPbRsVQ0eHbfYCm/SL+6lolZIYhKQs
	bwIzRml+4aJ/P/yOrOnJXAjwEuTA2kmBkKKKryW+IQa36Njj6oN45IQB4CvqofVw
	DYvepiBofRdS7zqvcnL2vaco58Ve1Z62O7NHjB++7qN5jRI4Eytie6RoTIAP8tJK
	AnYf+R39oQTSBt4D3xcNl3WNETUQOVhVq+C0UZ/e5g7F02fhPr/ig==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105vn57b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 00:03:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AILKAS71490589;
	Thu, 19 Nov 2026 00:03:00 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j067nj0p4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 00:03:00 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AJ02v4T4391506
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Nov 2026 00:02:57 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AA885805E;
	Thu, 19 Nov 2026 00:02:57 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC8895805C;
	Thu, 19 Nov 2026 00:02:54 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.93.165])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Nov 2026 00:02:54 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        horms@kernel.org, davemarq@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Subject: [PATCH net-next 1/2] ibmveth: drop TX on a queue whose long term buffer was freed
Date: Wed, 18 Nov 2026 16:02:34 -0800
Message-Id: <20261119000235.15622-2-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261119000235.15622-1-mmc@linux.ibm.com>
References: <20261119000235.15622-1-mmc@linux.ibm.com>
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
X-Proofpoint-GUID: 9VjEGF8k5xNRf4T54dPUAZasIIQi-23S
X-Authority-Analysis: v=2.4 cv=HL9WhYtv c=1 sm=1 tr=0 ts=6afe3cb5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=e29-qu0i5GqsXjo-pL8A:9
X-Proofpoint-ORIG-GUID: PzvT47R5EOX3oASoN-owbi-d0KJndVOM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA4OCBTYWx0ZWRfX6zMqBhcDWBMt
 fmEyVU03Wilrq1e6QJpAQVCG9ZbqtuXE5wK7Thzbz+HZOpJxaE6tbLGZygVsyfcTOKWnqNZduiz
 8NnvUnrMJuwtfmFlMNvvrci0rSmJRswZUESmPI2Tca/vtsPXGB6M25yHc0ZMMk0/T5P0B1qxdAs
 QNWapG0hrsUNtRd7PdzZJ/ic9VhpxVlPXxE7ax7JosQVqAlmSFDcLJhMvV78w3j0i6efQuWIr+c
 bdIG6zAWHt+PMiVphDHkbigmY2SwMuPo3lP3JOET+Hfex1uTBQAn40f0fQPMvIXf188ksvqaC/Y
 5Ej9l180Dw6ioANTZYAIBkzVSad6keFeRRjpZb9Oyap1uDuLAazuxw72wz+Olpby1dzaZ+D44Zd
 IYjq8sBXe4p1uU/3X4IERoXNrLgn9mLclLFUOm+9pLU3yx2nth+NGYXExg2drvj2lc84N53ybbA
 yNOb6R9CxW+eoNmJvYQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA4OCBTYWx0ZWRfX69lnULEo2oYd
 xPHlDEhY2tRvePfq/CQk2ywboL5B+zyphhnYaBAe/ZrjSdC97rBEmEvQGXROujwHX+pahwexp+l
 4/Qpr0b/W2EyNjxc1dORimeRXEfRnlE=
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

Fixes: 10c2aba89cc0 ("ibmveth: Ethtool set queue support")
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 05d6b60cd187..faacff14841b 100644
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
@@ -1195,7 +1195,7 @@ static int ibmveth_set_channels(struct net_device *netdev,
 	/* We have IBMVETH_MAX_QUEUES netdev_queue's allocated
 	 * but we may need to alloc/free the ltb's.
 	 */
-	netif_tx_stop_all_queues(netdev);
+	netif_tx_disable(netdev);
 
 	/* Allocate any queue that we need */
 	for (i = old; i < goal; i++) {
@@ -1304,6 +1304,16 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
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
@@ -1359,13 +1369,13 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
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


