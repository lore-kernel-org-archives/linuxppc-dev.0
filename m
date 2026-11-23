Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E55606A32A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 07:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=P/zp/kW7
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXynf2DHXz2y89;
	Mon, 23 Nov 2026 18:51:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795420310;
	cv=none; b=Ro6vlJ1TLNDXYeG/QYXyVzCSe804f4AUfW1ctBygJI9ezTF2lgEsY8nKlyHMDBiqR1AM00dieCMPzrAnoHUqPc9SHudtS6O8k1EOZblsqLEqhTGEnjzHoEsoGeAp6eqgkQK9Cvt1lyFeIZb2F6rT9jv5Z9RGIJ7AjlkhFGzrNeJC166oRXoMJ6YNckGh2bRNBLjebQfsAPiQIuGwA2iRmogflLndz7L1lCl6t9m+LDsi5lFa9dmUYay6zHKUb/I+CIT3mHYsYzkFdz6/p62VFrJCpm+hUSSdGouf0pTIAeiDNM7iLEH5wC0dCfsrKFFiYwg0zIY6Q3KzsQycqbr9Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795420310; c=relaxed/relaxed;
	bh=gT/F6k82008UDv3KWr7egfL3jP3M6EEakKQRGivTJ40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lQR5T/9JI1ZUyLDwy6fRpSnWI8VNR2DRj9KbaDIbC+bO9Z3tcYAlxZpvA9fn91n9/yuGJUnVmFingOHYrvwnBgHbJWP2HKasoDwb+7mspd1Y1gMr1nCorvCHKL5GmRjzbbSmxElxDCW3P1AxnIZEJ8chlcsuPJwUqfJFRN9rBl51pfkQVLluB0dPD5yNGoZBClvUK/NbA4B59LTf3k80ww+LRDckryQHTeMmKZd+TbucMECGuNmKOy760TKUjbADH1KRGlGZCn1SdM/opTwQFFy8MVeBAJunHZqXTZWQBKqWK9/kRL4+hY6MWe2+XWo0YKYiRQrWjEzwLTFemmavyg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=P/zp/kW7; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=P/zp/kW7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXynd3l1Pz2y7r
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 18:51:49 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN5551O2575176;
	Mon, 23 Nov 2026 07:51:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gT/F6k82008UDv3KW
	r7egfL3jP3M6EEakKQRGivTJ40=; b=P/zp/kW7JP8/9BbJTC2Ir2R7ttvsO9lVb
	ieVnMsgvoPC5pueSTkSPQruZZRK9GVETukAvsudPfTI1Xx0hMj3aTwyg+lVQVvhG
	yrCEt0Gaf1yFxo8OHIr7brTFqFIBwCk7VThcki3H/3M6eLdSlUJ8y4JY/Y55GsyE
	QEj9GfKkwdLN64s+V2xFH2ccetZSu0o8yolp2y+PVUMHxB0MmYeQzjtK/wZVCW1z
	0fCNngHmypP4QQ658FgaXqERV7xAN31MWbdoiUknVmWQoKUVK/u13OPghlnVglVY
	sqiIE1LnfvJfPer4U9HTfbahG37EDqELWInpD/+rD4JqkmZWvILRQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34gv1t79-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 07:51:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN54UaD2817365;
	Mon, 23 Nov 2026 07:51:23 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3pmjwtyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 07:51:23 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AN7pKs824838832
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 07:51:21 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C130658056;
	Mon, 23 Nov 2026 07:51:20 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A0FC5803F;
	Mon, 23 Nov 2026 07:51:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.2.38])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 07:51:18 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        horms@kernel.org, davemarq@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Subject: [PATCH net-next v2 2/2] ibmveth: do not reopen a device that was set down before reset ran
Date: Sun, 22 Nov 2026 23:51:02 -0800
Message-Id: <20261123075102.2962-3-mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=CYCdd7rl c=1 sm=1 tr=0 ts=6b03f07b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=u5j9OXQO57bvaG0S:21 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=1uTVibehr-0tYGdTOcIA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAzMCBTYWx0ZWRfXxi2aq8S6je0S
 5T4oe/nKpp3AtnGSGIg3LlPVy3jgr93u8cdif5OCBgEv6fhUvxRzZKW0sHlPtoZTJIyNsmpZ9E5
 9CEwXuZX7Uywu24JvUVz9uZRwLhZq4Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAzMCBTYWx0ZWRfX77wFqHtS3t1T
 kQt47ys+6i3c+/TzU8F1v1sbLmcLXcq5PWABEnQ7xGvBFOvRPJI0XiM1ceIXxRMHvIpPBjgQ3Fd
 g5SjOf3ldQ3H1Z+Y7mhXdPqIhCvd6208DXRfHBYJYm21ss67p6K33y89HQkXymXlSbuPr14V9kf
 Pp2CbNNRNxTf/Ebsb4bytglmtB2RjAYTfbzKz7WlAOCAXKBUszj9/LbyixQmHm7CXTArVPRwg5j
 iaV2gLMfINJCFJgp3/nI7sFuMEwkmQzyra6ouLSdBqH7L9FtU7HPrTjf2UES0Vdn7bi5eYSJmVm
 HrWNuDP4Bhkpx29dMjL1OeFsCb5CFZNQCHh+WNfSnNRLx2WxUJxH4hoNqyzNQTN81/fxIYk57tb
 lxIoF8RQmhH6nMTpMxVPtmi+JkSEf6blOYXIR7XAoYjOMe5artJcEc/iUMVYJ5zjpEXfKrRBpxR
 Ft1Tr+O2zzYawwg3pew==
X-Proofpoint-ORIG-GUID: 5VF67OmAxqi4zPT5mx0cZ-JZ9osJzQaM
X-Proofpoint-GUID: lKNMy6-MfD7V2E7wb2IxBi1mm8QlcLDg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230030
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ibmveth_reset() runs from a work item queued by the RX, poll and
replenish paths. It calls dev_close() and dev_open() without checking
whether the device is still up. If the admin sets the device down
between queueing the work and the work taking rtnl_lock(), dev_close()
does nothing and dev_open() brings the device back up.

Only close and reopen the device if it is running.

This came up during review of the ibmveth multi-queue series. It was
not reproduced; the fix is based on analysis of the code paths.

Fixes: 2c91e2319ed9 ("net: ibmveth: Reset the adapter when unexpected states are detected")
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
Changes in v2:
- say the bug was found in review and not reproduced

 drivers/net/ethernet/ibm/ibmveth.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 09eb5bcb306f..edaa4cf12ad7 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -904,8 +904,10 @@ static void ibmveth_reset(struct work_struct *w)
 
 	rtnl_lock();
 
-	dev_close(adapter->netdev);
-	dev_open(adapter->netdev, NULL);
+	if (netif_running(netdev)) {
+		dev_close(netdev);
+		dev_open(netdev, NULL);
+	}
 
 	rtnl_unlock();
 
-- 
2.50.1 (Apple Git-155)


