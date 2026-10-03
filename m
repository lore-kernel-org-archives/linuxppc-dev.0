Return-Path: <linuxppc-dev+bounces-28792-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44FB0CA5FE4
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Oct 2026 01:58:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxTM122Rtz3btn;
	Sat, 03 Oct 2026 11:58:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790992685;
	cv=none; b=U4HMkoIriUXNDbjvVV/5GnGPTlovwIIQr4/nwsL4aulJt60Th58M/J2E9SDzDWe37Sv0+meAoAi6CDjByxPlhV51haLL1VTXBM2PSqcVZ7IYXcaxbtDrtJSDRs8cC6rl6/eQV1BnU/NWMLTdc5zfWvyOiNL6k4x1HayFOOrg0BzDrhtfuG3ugMDKlTWfuHz144IqoEAtnkLJAjBQSXPSnCvZ1QJPikWG0skZQXQkrrMOQmseYAaK0VJ5oBq5gP1ulu7fXg1UWRijz4k881bE9X8KfrF2/qVtlp3Rf7p46eMv5yHfoRnW6rgJ5omTJIY4BlaE3vOurSgm1Tvnm6SkNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790992685; c=relaxed/relaxed;
	bh=pMFPDDEVCTtoTwcydL/1S0msLUQn46YGi/bOH3mwC/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VEm+GR/ko4xUebOLqbbpEcBFFPB/C/btw5FK7BFpa5w7RlrqCYMG+Y7VjWg17snby6g3wDsLucA7RiQyn4Hk9hJZLjG3rO810GVgCGdBzbpyO68opuD6RdcSwcCqr3+2CapMFj1n5ZY1FeduhIQM7DAYGG7kQbYXerNGtzDWJptGxnVD/JZN6ObjDvEp73sxekVashK7KyfvYrnRehJY7EiWs6fHvQd4v8rpP44NquLjmkjtw+PS6WVyOWTDoTDtrzrKN5+T3r0/wVmNh3gnG74xv1D/DRoSQQ72cRJIlWXvSgvlC59X/ke+e6n/XvadghrvCS+3pDajgl2zCm4yyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Mc6DKL9R; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Mc6DKL9R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxTM02tjgz30DH
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 11:58:04 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6931VpCR832016;
	Sat, 3 Oct 2026 01:57:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pMFPDDEVCTtoTwcyd
	L/1S0msLUQn46YGi/bOH3mwC/k=; b=Mc6DKL9R1VF/71zU+0tMaGHFi9na7BE+g
	5TkAtmPszBBntrmspKzT3BcJmVZseQxdOY9CM4s0PIreeFDzvXZAIXcUaSoqwU6u
	S+K4+vCCAgWotS4csUxxZyuWH5IxR9dY1KfSlUnlorrx5EriqCPHKVNXwoedAXVs
	nryfXXYPHLA6nAr/czdQ2+L2OBdLD9d3cMgsax/aEJAmFISmo+NzplzqD1aJphJM
	TLpMAagVCdYh+5iVxnHcrEuns8Kq4/19QzvpTjCJwpro+UtsPgVpVwko1IRQXZqS
	vsg4VWMKfWPBoDCsUqJ8vXkeoUpv3Vc6TA2zvoxTRvTzQgpvR+3Rw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2r4fg1xv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 03 Oct 2026 01:57:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 692Nm6DM3271580;
	Sat, 3 Oct 2026 01:57:52 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h21nu4k4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Oct 2026 01:57:52 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6931voN114484142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 3 Oct 2026 01:57:50 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04FB758055;
	Sat,  3 Oct 2026 01:57:50 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0022D5804B;
	Sat,  3 Oct 2026 01:57:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.102.94])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  3 Oct 2026 01:57:46 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
        edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
        nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next 6/7] ibmveth: return the error when set_channels cannot add TX queues
Date: Fri,  2 Oct 2026 18:57:18 -0700
Message-Id: <779e6d063cc21ed4dbc5cf365f43f39aaff0578e.1790991039.git.mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=TOPQ2Fla c=1 sm=1 tr=0 ts=6ac06121 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=WmY7XiZo9o5BhK5z3CgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAwNCBTYWx0ZWRfX1gBS+LJaUIcF
 1fuwcfyurm8+cVTOQT5sPWbQVWr2i7dsLiYdIkMBcftR+mdme9DVwL0BwkW4EjiTc7oLf0vWjqK
 U1X89t7MHXP0PCHCMnngcIrxxGQAOhdqwZ7qh3JMOVERkZSN9x/ZQc6PWv05AMik6rGnfYRQpob
 zCJe73RE81Lzp41UNqpwhEnVr9AQlu98ayxcn3yQ/MbmW8TFLBMxLhStp+/3miO7fcxZFe6nQqm
 UUpy0OgwyEFfBWuAO5cbtFqjD9sjgmMyqpfuVWOIZ/79yCAQ8Uo/UD+kE/Hr/NA65qA9Qoyw3mF
 wywM4Cq2/P3k10VTgvQm6FafUZ577+rTNjUwggKIwFVbSZF6anfjuxqlGkqJJH5drJeTgxSWQA9
 tzT+uSTPnGH8T6s3B0L2rG7R64G/s/SE7YYcD0W9nOmmw+CflAX5jc1SroYa/qmZwCndPpkRigw
 hNoRCXkdjirD1XtqFOQ==
X-Proofpoint-GUID: WOwS2nDH6AZ_vXHxQDEFa8f6ykXcnVyG
X-Proofpoint-ORIG-GUID: _mA4w9DLnjjtsE58NiU6vMNj0A_pQ4JS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAwNCBTYWx0ZWRfX24g28T4IA3TE
 u2W95AAYEUpRTTxHiaIefoyuq0+gg+17hCCW8snfkmgGNn+mIQw1koFX1S0xErCe+cb6KRgh9d4
 41a1Sev8uc7pHfThPmYGH/BUYrWyAos=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610030004

When ibmveth_set_channels() cannot allocate a TX buffer for a new
queue, it falls back to the old queue count, and the successful
netif_set_real_num_tx_queues() call then overwrites rc. ethtool -L
reports success while the queue count is unchanged.

Return the allocation error when the fallback succeeds.

Tested on a POWER10 LPAR with the TX buffer allocation forced to fail:
ethtool -L tx 8 now fails with -ENOMEM and the device keeps its four
queues and passes traffic.

Fixes: 10c2aba89cc0 ("ibmveth: Ethtool set queue support")
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index d5ba2f2650d0..132c740b5844 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1169,7 +1169,7 @@ static int ibmveth_set_channels(struct net_device *netdev,
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
 	unsigned int old = netdev->real_num_tx_queues,
 		     goal = channels->tx_count;
-	int rc, i;
+	int rc, i, alloc_rc = 0;
 
 	/* If the device is not open (including a failed close/open with
 	 * IFF_UP still set) then don't allocate, just set desired
@@ -1195,6 +1195,7 @@ static int ibmveth_set_channels(struct net_device *netdev,
 		/* if something goes wrong, free everything we just allocated */
 		netdev_err(netdev, "Failed to allocate more tx queues, returning to %d queues\n",
 			   old);
+		alloc_rc = rc;
 		goal = old;
 		old = i;
 		break;
@@ -1205,6 +1206,8 @@ static int ibmveth_set_channels(struct net_device *netdev,
 			   old);
 		goal = old;
 		old = i;
+	} else if (alloc_rc) {
+		rc = alloc_rc;
 	}
 	/* Free any that are no longer needed */
 	for (i = old; i > goal; i--) {
-- 
2.39.3 (Apple Git-146)


