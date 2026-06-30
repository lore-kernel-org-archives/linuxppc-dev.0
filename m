Return-Path: <linuxppc-dev+bounces-23204-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEBC8C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 14:54:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqR4F1msDz2yfs;
	Wed, 01 Jul 2026 00:54:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782831245;
	cv=none; b=Vsk2hxCM2PxDGEqP2OAqf/lXhMgb3Zx4FxsEY65dmOFoxnK3NaGbaMoC8rlkZGG8eWUS3B/sexTFOmnFo3qrHM4uzkRy3/231P+eEyRocfUqclPwZ1hrFlnWWRJTI9B1IWHlca5/ESvDSCfVz3AxBsvlU20+8kTSlICuGOic6ZmTRDtUDpi5ByE0eAuWRt3f6QfnCVwY7no051bWN6spFqNUena3P+rlyHF2MWcyKtn2WzcjgZX4pQr1w8/NJzyPvSJk/8N+E1oj93xA1W1bI0kwDteUu85HC1Xcp1soYTh3EUcvw5MpuiOpo2XELs8bbNIjE0LZeR8saSz9Wj8/GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782831245; c=relaxed/relaxed;
	bh=vFSLvmk1zUspJRDUJrGMLAht1yNaZ1/rGIU2XnN27k4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YHCOMTEp4+p55cvPVuLk42YK+pJKSnUlFcFGJolzbz4gbWjDQHUS3hmm2LyNetoOiiIgZ5CuLKUswXOEb5zE11u+MPh67+N/7FTZVehEdk8u+aR8KjRfuHZN7wpbVxB+gtIR/AwmHdPoWPNpmI5MsSryisOZ0pepkSFYqSSYMjMk8WD6Xp4Khy5h9OenIGxGuFQrQ3XmTTXtg4cRmAOW4dwDLuVeBnXEplPQmleMoWXtzW904N1rhQ3ocws5EOL0VeSqOGfHEw5ggl/8T2y2eAlez47ch8PEiQycP9dTfD/77E+WPrDzHHMYoN7h++smEXloyCNb/cdUhXpQRaRxQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=h3kJTewS; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=h3kJTewS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqR4D3d4pz2ytx
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 00:54:04 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UEILni2288618;
	Tue, 30 Jun 2026 14:53:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vFSLvm
	k1zUspJRDUJrGMLAht1yNaZ1/rGIU2XnN27k4=; b=h3kJTewSmpQ8vkjBTCbZAf
	0gYUsdPNHDaDRba79kc+vv4rYf59jfNORnBS4EpLIWPwpMgSTHQTEsuf+pY6H7IN
	NH5DM0E9AAeiNpsG++jeG3GYjDiUPXtaIzgOmyZIWkLfc5a6JS/W0zQwKPmYduEo
	Senx0kFSf2Np7q5qf4VIzF79aLF1oWgHM2IUSEvQNTLpMU8e1tJqrMAjPFWtezmO
	85ADUjB0LThSFTODwphkkB+evl1dNMhZa4OXKC1euBjM6n7lUBHQQaM2YW4pCSeV
	F8GxY+7vDoYR8QmfhYmAms2jC0Z9p8/Me6NjuklqpJ7FELVYK2WrjUSBETTVCc9Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pdye3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 14:53:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UEneCd018167;
	Tue, 30 Jun 2026 14:53:54 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqaxya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 14:53:54 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UErrcI32965324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 14:53:53 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59ED55805C;
	Tue, 30 Jun 2026 14:53:53 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 132AC58054;
	Tue, 30 Jun 2026 14:53:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.117.151])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 14:53:51 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH v1 07/18] ibmveth: Refactor TX resource allocation in open/close paths
Date: Tue, 30 Jun 2026 07:53:14 -0700
Message-Id: <da084481587ad1cbb1552d6a65f562fb7fd7a871.1782758799.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1782758799.git.mmc@linux.ibm.com>
References: <cover.1782758799.git.mmc@linux.ibm.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: qGHvBH3xf_8379Rh63W_Gvjum9b4hrzA
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEzOSBTYWx0ZWRfXzBQBKArnx8xS
 JDO9tbmusqSHoTnQK8QuZonqao2NscKbLWzEfOEBp7RrdQZBJQM3MMrpjGzAmNxo1XNDGRdZUfZ
 MG+vsh/sz792GTBTmB2sOpSYTVPwwtk=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a43d883 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=mtsAU2ZvJdVy61tLPkIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEzOSBTYWx0ZWRfXwtl1Xujr5SNe
 Y7vKhnOY/87+r90qNFILE3CGzPKDtQAQGho+OO7pdjSm6sEHe0xNIOfC+ScHHslmthO6FZLcGBt
 Ipf3sT8I0IQeP4BBoupfpP/owKrsaiSZOGrQ1cHvzGpUpE9qB4sIAOnU/8PxsTGBXrk6PzFR1gL
 vrVr3wosgnnI3JzP5U63C6RJ7P16GlHdOZH8J0f34s2DfsZaeTBdvN5O5/9Ebb4g3pD3D6COY5j
 ffh3HFkxfiQY0r06uNNFRe1AnrBp7N9OItzOjxfmGZoSyYere6MG4vMrGCb5QlOaQ2bFao/oyXh
 IHuo73sVpzqjjEpyTEvdD/yH7iGjGMSqYD5LfH0omxan0OxsZrZpT/EvbG+qEb7Tnh50zqT0DA0
 0FrspjbTIqXnIFRvXLkC06llr5g87iO3aVgI16j0KC95Twnqhi7DylYtaUcAIRUV6hKoVW/BySH
 MwA7blZSTEkp/cM1YjA==
X-Proofpoint-ORIG-GUID: q25YIHgqt06uGFU8fpeC6daWeSMWaVp5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300139

Same story as the RX refactor: pull TX LTB alloc out of open/close.

ibmveth_alloc_tx_resources() / ibmveth_free_tx_resources() walk
real_num_tx_queues so ethtool TX channel changes keep working. Hooked
into open/close in the next patch.

No MQ RX behaviour change — TX was already multi-queue capable via
ethtool -L. This patch only tidies the open/close path ahead of the
RX helper wiring in the next patch.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 43 ++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index b5ae979c1f82..63b0184c622a 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1038,6 +1038,49 @@ static int ibmveth_allocate_tx_ltb(struct ibmveth_adapter *adapter, int idx)
 	return 0;
 }
 
+/**
+ * ibmveth_alloc_tx_resources - Allocate TX resources for all queues
+ * @adapter: ibmveth adapter structure
+ *
+ * Allocates TX Long Term Buffers (LTBs) for all TX queues.
+ *
+ * Return: 0 on success, -ENOMEM on failure
+ */
+static int __maybe_unused
+ibmveth_alloc_tx_resources(struct ibmveth_adapter *adapter)
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
+ * ibmveth_free_tx_resources - Free TX resources for all queues
+ * @adapter: ibmveth adapter structure
+ *
+ * Frees TX Long Term Buffers (LTBs) for all TX queues.
+ */
+static void __maybe_unused
+ibmveth_free_tx_resources(struct ibmveth_adapter *adapter)
+{
+	struct net_device *netdev = adapter->netdev;
+	int i;
+
+	for (i = 0; i < netdev->real_num_tx_queues; i++)
+		ibmveth_free_tx_ltb(adapter, i);
+}
+
 static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
 				   union ibmveth_buf_desc rxq_desc,
 				   u64 mac_address)
-- 
2.39.3 (Apple Git-146)


