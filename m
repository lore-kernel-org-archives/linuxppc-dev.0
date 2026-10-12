Return-Path: <linuxppc-dev+bounces-29220-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86A4CA9ED5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 05:06:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j355l2lLPz30VF;
	Mon, 12 Oct 2026 16:06:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791781563;
	cv=none; b=FOi9pzBSB1p+3uYjjt7koL9xe5p2/muBPpjT3Gz9p5kT9/C1zMwcFdYVvUuYv4m0/bsNXKF/rLKHs6N/aSJ/lD8y+zZgnWYumNuU+6ejxdBPou6Xbvww9IaDGvMbbGLBZimiVstNRB2LRMRipmIFWn9PjJM0BBvFFfR3DSDlJjtLuRqGJbSzRhZ3e11q7L0zBaKqz561KUm6JSKZ5pe3d1qHErYN5QD/gPC9xNablHuTo0VTwNcScXzqeD6A9n4afsczFZW+ZnITmyiWuuwzir1NT2I8qWjJ6mCE0leUGqGnS1wl0vKls3RA50QiqPiV9ZApbnleqvtRMpQ+KwodRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791781563; c=relaxed/relaxed;
	bh=JE9KXs/sVcWR4UeGTcI5pXVqaGCyLYakgLvldDnY/CI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=et7OLvb/e2C7dNc4e1cIxb+q9ROCjLPb0QA7MQuGuvocAQGVj9E0Hp1sRCTaHIIPxuDgBgLxSl+IyZ+nsG0QOstL49awyxQ94iMU6rPYxxslCwe6c5k7ucbUWC+f0x20o8FVMQHFkDBaxdpfuNMIE+1PxaoDHRYaqFLWpgQDpLrvhM9J1jeNriSNpvFYPzvQlB0rOQhJA5HRmWkIUPiVMGeT/pUUuheFjf6bCsulJFhiBI7WfQQ8xCndu9BbrdcorqWHdASs4aTD5/CUPfj/gypH/27gqWdMp0u57IsnkFReuangvGzTFOIkd67QYOu9Z6q3k4pzKgGLovLnt40Acw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HMHpMN7q; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HMHpMN7q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j355k5T4hz3bvL
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 16:06:02 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C2FXqi3020014;
	Mon, 12 Oct 2026 05:05:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JE9KXs/sVcWR4UeGT
	cI5pXVqaGCyLYakgLvldDnY/CI=; b=HMHpMN7qDrbiiaDn9ez8vhxt5XOJdr5ti
	GgmUgJMLv/LnTsaDOMWNtIFTCRC5FXWQyEOeqGobqL7R0eFGEpQfgiCU4+571lGu
	+d2vTiA1eKg3j+TODgURy42kATlTafiu5gdKfD5FDjvc8WMiQdHuY7tPSqUpvrvk
	AlP17EJcSTtDjFKMwteggfChZ2D97slcL9dXDB1jUuoyzZ9iEu9XIrBMrUoP3mgr
	Fu/owRjX3KSBMtHzzSb97tZd874YZMtCTlSMVmitMeDr9FygN1WDrp4KhgjIGQTv
	4wbs6ljsgursAzOnmopcw2dzw8ZOUda4SwUYpIlfXc7wz5IFbh+8Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv378jp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 05:05:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C24o8b563434;
	Mon, 12 Oct 2026 05:05:52 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h802vkw9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 05:05:52 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69C55oWK32244288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 05:05:51 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95E9B5811D;
	Mon, 12 Oct 2026 05:05:50 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98F875810F;
	Mon, 12 Oct 2026 05:05:47 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.163.79])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 05:05:47 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, horms@kernel.org, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com
Subject: [PATCH net-next v4 6/9] ibmveth: return the error when set_channels cannot add TX queues
Date: Sun, 11 Oct 2026 22:05:15 -0700
Message-Id: <20261012050518.88858-7-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261012050518.88858-1-mmc@linux.ibm.com>
References: <20261012050518.88858-1-mmc@linux.ibm.com>
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
X-Proofpoint-GUID: TR3YNXGJQEaamDPoaKarrkkvEhbmckrY
X-Proofpoint-ORIG-GUID: 5jldtkjgE9EAu5zBN5GmIWRfbI9OxjAz
X-Authority-Analysis: v=2.4 cv=aqInmiZV c=1 sm=1 tr=0 ts=6acc6ab2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=RZ4y7BAnkfP1csG6fq0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAxOCBTYWx0ZWRfXwjwd9t8sB8JB
 FshPxAAMHhyD8cRtz44TfIREiuXMueB1PoolONEEi62rL7IOtxeHQF9dnQJ6jASFkqWCFk7Re51
 MpNnCH2ZWGuVd7CbrL+OGsc0e23UJvQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAxOCBTYWx0ZWRfXyIaGJrpYfvtS
 1aM0Ssj4dPfJVDY51op+8lU8XpRLI/w4uuBKHKH6UWeTt22kyaVHkw20KJQ4fdlXfRZ8BYZknQL
 i8ls1xEG/lt0S/OxAbBwFxd3T+XgBE+jFaCRcJ3CZBN5h0j8eY8SwQBAJmMdfi73pE1JByyGUAG
 rHD1NQrR2goABJztjQ3zX60n4IhlngciWs/wX8mNNZjhGwoKRkcBz7RmJqobdb3kORkL+v7jWBp
 wh6zuuxMLgNAP9k9LXIRg8+vutyYRgTvOCSR76VpVHCJv2oQxiVSxo/VTIRfm95t17HtXYjIS9c
 4IqDmzZGuoXT/ZZlmlxYmEBN16ezzUoixw4byCdJkRRdiAEn3WuJ1po0fWqzDybu85D3os5Ao6S
 FZuXZYXElk9+mACxXDCcSqB5Vp3DKps0tI9x3xCmxX4F5/LfZi+6wkEiMPtMdCKsu2LilFRoPqt
 fx7HIY9to/OP6QzPO4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120018

When ibmveth_set_channels() cannot allocate a TX buffer for a new
queue, it falls back to the old queue count, and the successful
netif_set_real_num_tx_queues() call then overwrites rc. ethtool -L
reports success while the queue count is unchanged.

Return the allocation error when the fallback succeeds.

Found by AI-assisted review of the ibmveth multi-queue RX series and
confirmed by code inspection. Tested on a POWER10 LPAR with the TX
buffer allocation forced to fail by a test-only module parameter (not
part of this patch): ethtool -L tx 8 now fails with -ENOMEM and the
device keeps its four queues and passes traffic. No kernel selftests
cover ibmveth.

Fixes: 10c2aba89cc0 ("ibmveth: Ethtool set queue support")
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 42aa9f7bd49d..48bc4406396b 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1177,7 +1177,7 @@ static int ibmveth_set_channels(struct net_device *netdev,
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
 	unsigned int old = netdev->real_num_tx_queues,
 		     goal = channels->tx_count;
-	int rc, i;
+	int rc, i, alloc_rc = 0;
 
 	/* If the device is not open (including a failed close/open with
 	 * IFF_UP still set) then don't allocate, just set desired
@@ -1203,6 +1203,7 @@ static int ibmveth_set_channels(struct net_device *netdev,
 		/* if something goes wrong, free everything we just allocated */
 		netdev_err(netdev, "Failed to allocate more tx queues, returning to %d queues\n",
 			   old);
+		alloc_rc = rc;
 		goal = old;
 		old = i;
 		break;
@@ -1213,6 +1214,8 @@ static int ibmveth_set_channels(struct net_device *netdev,
 			   old);
 		goal = old;
 		old = i;
+	} else if (alloc_rc) {
+		rc = alloc_rc;
 	}
 	/* Free any that are no longer needed */
 	for (i = old; i > goal; i--) {
-- 
2.50.1 (Apple Git-155)


