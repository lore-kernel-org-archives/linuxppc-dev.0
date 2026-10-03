Return-Path: <linuxppc-dev+bounces-28793-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BA8CA5FE2
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Oct 2026 01:58:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxTM3354xz30TL;
	Sat, 03 Oct 2026 11:58:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790992687;
	cv=none; b=h7TxUAFpoNVLQ+IOfdeiC4ZxD2E0+pAgOghG/qVP6dq1WQqCr6m1swCkE76rsC/i4P4mpyZwqNZuuCntE4RwTQwzJzNC2vnxB2dzIDVgED9VYT/Z+B0ON94KcsrW6On2LpJxxX0SS4vcqXetyrLPt6pRlNiZoY+XiqlNKI0aaZ5W2G2ez28JfsRH9bzMVZ7K7byHTsKeek19/2nTK/lLoC+9GGkDSbvEjMkNvyZq0hz5IMhSZA9ny+M4tdzdP0ZwFHkAbdC339sZNNZaGtQW0mburp0H+xM1SLfSYUSnmW25Xl4gik56syCmpfnjmZQ0CJ6IYh2+WhR6/U9wGw/vcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790992687; c=relaxed/relaxed;
	bh=NI9X7DQsFH/qwQ3lNloQEK/JRrsyUB9o9pUjyW+bS70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K1rYfdb1kwIMwgm0uG7+eXO+DJvV5vS+sdzb7vydjKA5X88MqYkPzS7zW6Sro/khWwqSaboNMwEyAVJHk7nzpW7IQQ36lynj64c3x4emBhvPY7mnPJnGnNYLlowJ7Ss4SjciG2EIOgnPUh4aXGxZ3po2k1o0uAYPqFuZRSjTxKk+pyu9jxchjqn5hjt6WiFJ0GNQzKGsUT0RkrIfUsjwqOn9lWqnJ4hPeob5YblXkPQ8kso0fSl+WPFZ9mb6TXqB2K12QZU6pgnk40rpV/mMyM6PEKDXCZRxtdDNmXgDMoW3dfjDXq0yjOYWw7XTjF6ti7WsqNX2r7Zumvg2w083og==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GLC766N0; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GLC766N0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxTM22ll7z30DH
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 11:58:06 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6930P8Nj1780776;
	Sat, 3 Oct 2026 01:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NI9X7DQsFH/qwQ3lN
	loQEK/JRrsyUB9o9pUjyW+bS70=; b=GLC766N0l5El7GKHXJeYnDFYRRFZIs9zj
	Hr/etbT6EyStY2eNfcqY5sXazmlFz1O7Lyv1usuxTqLJT7fl6PTEstCrjLDQv5D2
	U6LHHOJEy5Xosg87U5Zrw++aXO8UgfBKpNE7U7yrtuswN24TLa48u2gxerZaPjXQ
	PPgjOlcjd4lCF4dQSogqRG2tjfIugiWHTGeqkZTsFaOz1LFb0nYjEcY0P/EwQTyR
	gND82Gsem2w0Vrpw1zzaowUOh8lpeCSm9mt8yhfj9FvoxMtLYo9VCogWaHvjIOGN
	O+5wnTVLENMusHDFBfHbc4zCMEdR+C6C8Bc9K0HTdxkYypZHZfW9g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4j87n7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 03 Oct 2026 01:57:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 692NlVVF3271160;
	Sat, 3 Oct 2026 01:57:55 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h1xk15agp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Oct 2026 01:57:54 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6931vrv232113302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 3 Oct 2026 01:57:53 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42FC658059;
	Sat,  3 Oct 2026 01:57:53 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F23C45804B;
	Sat,  3 Oct 2026 01:57:50 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.102.94])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  3 Oct 2026 01:57:50 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
        edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
        nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next 7/7] ibmveth: wait for in-flight transmits in ibmveth_close()
Date: Fri,  2 Oct 2026 18:57:19 -0700
Message-Id: <fcee28d86e161c955425afbfa01ba55160fbbcc6.1790991039.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1790991039.git.mmc@linux.ibm.com>
References: <cover.1790991039.git.mmc@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: RLHkcwMRPwWZZ4tUyFEZpqQKyZxYohv-
X-Proofpoint-GUID: Qja7TpskROvl5YPt4XWlqHgbttk_KLH3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAwNSBTYWx0ZWRfX96Gg+kReJ2uz
 jtUlLmYmxEX0rMiw57GDbvTVF5h8o/LkXg677gpzefEoM7/K3Zmh1xbK9Om4LlSI6jL+zwCoonG
 VflZoNBBheTAq33fKkj0xVeab12nzh0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAwNSBTYWx0ZWRfX+RTvQb5mRhlV
 s8+vIJeed9byWMV/lfXF427/zQTF00uk3Di7CFYtQaDy39Falrb0py3ckiKyW5EUYWzyVpllom5
 BkiRdNkLzBEd+kflYe8cn+vS1Jv3HotBkhucKCIAxzMbSFuC7O0XdejHpTFhVFzGPlzK3r1Z2YL
 UBHvTkud545MiPLRhsLoauALWgFb4VvCblhVohTgc721gy/E4w/+MrYNLNA2nHvJRdoPCxSNf+A
 WF1ZRO+vPnOtwv2q61L3FE4dESItelompm4+fI0lWPLFx0UCR0wUrlM6vYqDk7MR74PH5jCI0+b
 /B0bsCGi57kvlAyGCBNmj7D7H4wrUJgzkaJ6SXkCohiVJNtXEl3Crx9tNSgYt7uMAcjYxb5uAWG
 4WnzFCm6UW0SJG+uH+G0pOFnY8GzQYmz9/9xZNf3RXZo6IEeQeG9A+BQwoCTdrN6Hk1roWbeo2a
 yqkZM7BMw1IsHlLD7JA==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac06124 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=4X-BtLuwBG46RJIdyTYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610030005

ibmveth_close() frees the TX buffers after netif_tx_stop_all_queues(),
which does not wait for an ibmveth_start_xmit() already running on
another CPU. That transmit can copy into a freed buffer and hand PHYP
a stale DMA address.

ifdown and the reset work go through dev_close(), which drains TX
first, but MTU, csum/TSO and buffer pool changes call ibmveth_close()
directly while traffic flows.

Use netif_tx_disable(), which waits for running transmits.

The race was not reproduced. Tested on a POWER10 LPAR with MTU changes
during a ping flood, with no warnings.

Fixes: d6832ca48d8a ("ibmveth: Copy tx skbs into a premapped buffer")
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 132c740b5844..5acd5e49b0ad 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -827,7 +827,7 @@ static int ibmveth_close(struct net_device *netdev)
 
 	napi_disable(&adapter->napi);
 
-	netif_tx_stop_all_queues(netdev);
+	netif_tx_disable(netdev);
 
 	h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_DISABLE);
 
-- 
2.39.3 (Apple Git-146)


