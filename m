Return-Path: <linuxppc-dev+bounces-23326-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20832C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 22:25:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grF2p3qffz2xwH;
	Thu, 02 Jul 2026 08:25:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782944738;
	cv=none; b=eqg5Uei3W2pCpLPOeWlvOHgdsXO2FQPv8qlJc/A6sDwgIBVsnGV9/SNu2xmmuhMDdG3vYx1kPuQ0Bbr1egQ53aZl1BVh5KapXhgc4Z9YxDYVnAC59cnsZGoSaTYkN+vZrq5GvWmEJBTVk8Jgvq5fz13/vRPD5jksOq7WiE7yYfz77OJq0+MA8CKflZZW6Uygd5j1+1kRDXXldsmgl+ECmUaL80dyJEQGoDqfemcsW+Z0hpoTALADYbyLKCIUo2UizFUk2A7Q8kM2XuhgQ23ggysJgTDe03gx2WAQdV5ZDDUtgqNX+QG93HIr7Q45oK4CGpb/4YdWb60qaiVK8P2obw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782944738; c=relaxed/relaxed;
	bh=vFSLvmk1zUspJRDUJrGMLAht1yNaZ1/rGIU2XnN27k4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GkgdKQUnLTh4a8ogUjC/i2BXZAGMiowqIKzggpCVjTl2yPhB6th65pbA04bF//BmQ4fx6UGy2j4+4USiD+93gF9xMkxO7DT6N6U91qEDbTGl0Ssr8WzyT/jmBWNZ7tzNQMaCP22cQQ5gfCJAubuhlq6O/J+mCZdSooorLB4HNfa13mkUnNZDNP4dHxUSErORF9VFNVg35avzTDcLdZ5TdeOTX1Bg3IFTeqxeNGJ1h7lP3YV9PY0HnfrJDjt3vQWvL67414smZ5D4UQEX3pNjof25I4ouSKtfXTn/HSeJd1F8I1KbfjPfUuoR5X+db6acPYuxK23q4SiR83ZZ7wxM6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=o85F1yN4; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=o85F1yN4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grF2n5xbtz2xWP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 08:25:37 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661LmYHh2030244;
	Wed, 1 Jul 2026 22:25:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vFSLvm
	k1zUspJRDUJrGMLAht1yNaZ1/rGIU2XnN27k4=; b=o85F1yN4eOsHtovenMiAS7
	c76aTfjh2yLhwyND8ladO+hbKiZXO0QO6l6Jb2rU9dcAT8MJ7ogi/YuJCid/rlsy
	252itnwSHDShjZpt+4JQC8J6UqnUOAOJ3vOAaLHKOmpgtrWQ6jXhSk1vT6yZ+J/K
	ZRr0wLcaaJXDjRhKMGbnG01P3eXKRw8o8Hm6uFe1hM7fCK0SELrpV//8QYzk9Gan
	EuMR8z4Nbpc3jRXpx0ajHC0d9YfzaAJ1L3LK5/E3jifA55bC+nEmO9Axe3fQcsGU
	/MICiBA544ebJ47HZyf6pcdYElQ9c0KzGfVtY/zrC+xdKPggH44wr5jo3xH3n5EQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n5xyke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 22:25:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 661MJaT7022416;
	Wed, 1 Jul 2026 22:25:28 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2suk9cm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 22:25:28 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 661MPR7a34013632
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 22:25:27 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 03C895804B;
	Wed,  1 Jul 2026 22:25:27 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90F6058055;
	Wed,  1 Jul 2026 22:25:25 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.150.53])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 22:25:25 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH net-next v2 04/15] ibmveth: Refactor TX resource allocation in open/close paths
Date: Wed,  1 Jul 2026 15:23:16 -0700
Message-Id: <20260701222327.61325-5-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260701222327.61325-1-mmc@linux.ibm.com>
References: <20260701222327.61325-1-mmc@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDIzOSBTYWx0ZWRfX+dVT/V5GaGSe
 mljhtg1oE+Mm8cPL0AerptZzbtCWoAAkTWnfzeCJlsmueX1Q/vX+JumahGbFvK4zvjiRO8yMQzY
 lnWSLc4frZMqsPRy6DEJ7bEu0L/PpyeaabWzRb5Z9sjOr1PTrBXXwAHnOA9tBvC+ee8ArOQDDmR
 smOL4bYu41YCPWo4Pa+++GwnsG6rwqp2HeIQ0h3syj52l50UrKKtDrZqktPPJ6S3Vz6KlgNBKiu
 ri3ucRI6ku4wKJqeSMI4tkLevyw3aLcJfjY4VtMcud4C7svo8yeDB2G8WFKYacP9n8uZ21+GykV
 sIsWTe5PftW7HaOCeyozZgfAWWOfeBajuS7+1sBkskwfkAx+XAgRSfDavpurOrqGeD1nJhfD8Ns
 B1FIKVV/rYocPyoEOqfJ7G/X2pJnGE0LO+MbxAR7dzPADHRS9UxYd9n/Oxi/ylhzlztK8hR9Kua
 wC4zbJeFtfa7xxsncCQ==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a4593da cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=mtsAU2ZvJdVy61tLPkIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: nx3cO3K9cQ5FzPUkGA-CLBa9-opN2TOM
X-Proofpoint-GUID: wRTpnFuXuOLDp81MPUH3o7kkMOWVOCMb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDIzOSBTYWx0ZWRfX3Kd5qZO5sadi
 ZAzkGYqJ80d2N1RXCv8aFLTBtJCRTLxYXTndkenUSH1vnHzeXZvnORrAoF6gTZIrlo+zFoixJth
 GsEOofpz2F8NVBB6IAXmV25NvcSr6iQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010239

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


