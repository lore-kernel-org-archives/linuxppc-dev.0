Return-Path: <linuxppc-dev+bounces-29152-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3546ACA601E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Oct 2026 18:33:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1b8w59VBz3bSw;
	Sat, 10 Oct 2026 05:33:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791570816;
	cv=none; b=YcvXGiMMP+EYn0YfHUYfOGilGUMWPo2Z3NnqdHynPjJooO0v7IMTZKwdE8WlZ1ChgpION7H1MS9lUIWg5j8OtsaxPL4frMV2tb8ic25ObURRZZwa4Cr790lHn08YR9vwoswf2h4vqxPE/mNvGyWqvtaXYgHmAa0bUbnu9/R/8tE2moLiZViI7gKC8V3krhtBZ0INKMz+cgmUy3sV3dVcO5S/yv5nVj1hCyxhM6YaAdmK5N5jI9oAFcW2GDnlBQNrlG7WUh7Mrsu4i5nzyVCfMuAVLtsLSPxshoYqiPGi8JQP+rV0q4ZvBSWNyAK9ZQLGSAdaPwbCOb8IxMqh2qLOLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791570816; c=relaxed/relaxed;
	bh=vU96N6Mg5oDnRAeCp5sckE1d7IjMZBUWCSbSYQ92nJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ODWRkq4m30UP+AK6sKJrpynFTVBATTPfmAdcZWdclD5Mlg6stdOhG6SxEeGS6TrW+MiniNj3O9B1AElzOWdlZ458tyIFgmMsI8SqkmheEpG3gFOXM+9fLpvPckYNlhYn0uut+tPg427JOgHgLDZy1E3Xic28qKyx5YgdH0JCPuPN/V/2ZsR3Tiw+VelrS2pGFKAOiqliK81kScX8LySNq4XeZ9RqaXgMYxHZjp0OoKuTgi4jEuBz4AxQq8m3K5S+D/czZOmagcodHwcLaiGvdrYdlGy2dLUT0kdL9YT4CKg04E8roSwT3Pd9a4UFn6mL8mdFMcfQve1emjKWKLpKtQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TfBAj4OR; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TfBAj4OR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1b8v4gjMz3bSn
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 05:33:35 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699HZxP6592731;
	Fri, 9 Oct 2026 18:33:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vU96N6Mg5oDnRAeCp
	5sckE1d7IjMZBUWCSbSYQ92nJ8=; b=TfBAj4ORDVwz+OWC+XAY1JPvulMlJ7SyO
	0NC5HeWplrZaZ2cizdtj2Z6pJ2dlAYW3QzSRhq2fsr8JHYaPSAKnnBnBXudY9T68
	S2gP7yq9MebScveS5B0qIX4/v8R2iZryfCUZGVU4BCMw6eFrkMNniciiz/n0i44Q
	g8bdUDzMDJ62rWsuDU78/6HMWBOyz0v8k7dRDYf33tDkiU+NDO00anUQH+3dCOlr
	nnTxGHJH3VjtqEv9BbNPEy8WueOUM+AVWz9nfB6iJjF1CmlecGqbKZkAWWO4pGzL
	0e3tR8LgOmbkR2Uk30lzqOZzLMD4DTiJmJcX6+xUfxln938dkuCeg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h74tdg92u-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 18:33:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 699H8E6A1162502;
	Fri, 9 Oct 2026 18:33:22 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h6v76t67u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 18:33:22 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699IXJTE6030296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 18:33:20 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3A0458062;
	Fri,  9 Oct 2026 18:33:19 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7761D58051;
	Fri,  9 Oct 2026 18:33:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.110.242])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 18:33:17 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        nnac123@linux.ibm.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        horms@kernel.org, davemarq@linux.ibm.com, bjking1@linux.ibm.com
Subject: [PATCH net-next v3 3/8] ibmveth: disable the reset work before unregister in remove
Date: Fri,  9 Oct 2026 11:32:53 -0700
Message-Id: <20261009183258.18624-4-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261009183258.18624-1-mmc@linux.ibm.com>
References: <20261009183258.18624-1-mmc@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX//TaOy2uVBu+
 A3N/RiJxsqd71+8HEF7CEqVdYsPSOp1zfi1D+SQTj65rm4rUgeLTpmVWCYN1GBhVlTv6zlPyXKK
 VmjxDIRBQ3sURmieNDNw91oPCcpoXGoj/ZqeaO2kurZhvR2iyTiG6zeJcO1KDPe/185uoOQWNCm
 JopcGp09v6t769yGHor2bgZjqPT2c5oAIBQzW/NiLAiYiK5olkJqbEusHD2O/0qZ9q/PoSRZeeG
 OaqdxMTQADfd57p9a1Mz7nKSiZQcQ7JAAG40AjEwbGj9hYobNUuTFw1btwVNhR7BJN8OMOruPD6
 +CILasUQK5HXdQHHZG/rg9QERwmdn8TV60oGPJPDDIdNULgjJskLaGVB0iYErUD9W4wbOJHlG61
 fMi/8QD3fT8PEQMmEVuXFOyTvVumge0OS91PBJqPOd8slzgMXqM5kVXRSh8OJslSfwyoa6//zSu
 sJUYvuiwUTBJfJxbFUA==
X-Authority-Analysis: v=2.4 cv=FqWQbGrq c=1 sm=1 tr=0 ts=6ac93373 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=IlR5_4QjEJt1gQzRlPQA:9
X-Proofpoint-GUID: GoKwrXzavvft7SUfYWxyVOPBf-xSxeE9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX8Or7oRNQgeK7
 9T1WOfrwTGObFPpmeOhtLSp5BUt3ROYEhiJ9F4JaDoQbsrh2ZRicmGXS4ThPbk4D8erXgGfZBR2
 kgGbUvFac1uxFZQdHYLp6M6qL6TbLes=
X-Proofpoint-ORIG-GUID: 34KJTnFigNck1AJQZKl2-BdFsvPqGq_5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090072

ibmveth_remove() cancels the reset work before unregister_netdev(),
but NAPI keeps running until unregister closes the device and can
queue the reset again, on an interrupt enable failure, a bad
free_map entry or a bad RX slot. The reset can then run on the
adapter after free_netdev(), or reopen the device during unregister.

Use disable_work_sync(), which waits for a running reset and keeps
the work from being queued again. A bad RX slot also makes poll
spin, which can stall unregister; a later patch in this series
fixes that.

Found by AI-assisted review of the ibmveth multi-queue RX series and
confirmed by code inspection; it was not reproduced. Tested on a POWER10
LPAR with unbind and bind cycles under traffic. No kernel selftests
cover ibmveth.

Fixes: 2c91e2319ed9 ("net: ibmveth: Reset the adapter when unexpected states are detected")
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 4665447997ea..cee0e9783b2a 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1956,7 +1956,7 @@ static void ibmveth_remove(struct vio_dev *dev)
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
 	int i;
 
-	cancel_work_sync(&adapter->work);
+	disable_work_sync(&adapter->work);
 
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
 		kobject_put(&adapter->rx_buff_pool[i].kobj);
-- 
2.50.1 (Apple Git-155)


