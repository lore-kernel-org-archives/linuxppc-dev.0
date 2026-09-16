Return-Path: <linuxppc-dev+bounces-27523-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8608C982C9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 23:10:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlZN82tDyz3blT;
	Thu, 17 Sep 2026 09:09:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789600184;
	cv=none; b=cW1jdYOeLTKc6mQrWGONFK+7ERDQbFSsgxFTsFbzbAH8spkLr6cGRVn2Uhy6m8jHq9Nb/DWZpUqmhCLgMOhaVBbYRmNnlUskg3AaTmG5NHwKCFDydzopkYp+qTk1g7jn1U0jlSI8t3f2MYg2Rv4ALyc9ypmlFJHVIBaN4DpBm+4fFaKFiWQzXuMSqijanHWnlxnZwzPS8nRE6qHJXEyOXE4qsBC7PTSM81inQofhApTWF/nP5zqcFLKk0EioO45RjkKOSLYmA/ds/VBOoJfcq52QPG1CwuFzK4YJZjS72Rr+iC4O15Qw+NI1i1SU2Li6e/o0VB3yeqpJfkDrh7wTTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789600184; c=relaxed/relaxed;
	bh=lBwV8ShGbU6TsAn5tw14ype6uEf1Oy80AzGpHyLl8lM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lea9p6DlHgzDtBLrTHniulDG9SwQNxt/V+R4Wxza75BO1Ka59tH7OSE6m7RYaPAb01nm6fj008FN2+M2p+EFLhH9fDnx+8H+v+53Z7W2P1p33J9x+kBFqvyxtggwk2ncnP4jE0AiRHuwGHGvAbvdJ2dd+MHMVpmlmQFIzh/1xZ8yyWDDXsU+BouIJ/76FZ7oKjrtR6okcMddOR45fb48nVPq09QSSNbNi/FPag7H+Whfail83q9Hu4kdDipNvQEECjJX2zZBSziIOWjxLbeYxXhE2p3kuNkRJYKEt0sH2XGgdgl6LHBqgY9iu1h22fFxr4waAPhq7RnbaJahjwEYHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=P89B/3vM; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=P89B/3vM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlZN75mV2z3blC
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 09:09:43 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GG1bqb018008;
	Wed, 16 Sep 2026 23:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lBwV8ShGbU6TsAn5t
	w14ype6uEf1Oy80AzGpHyLl8lM=; b=P89B/3vMtqDvVKCLCAsHocvxoPvffCc+v
	1tV628XpzaBKqzc9n4YdetMtjLInXk0RC6QfsSnrFcLcvLttBIi5TKRerRHI4rRh
	dlGklL2XMYoqJxfaepS97BjpCoTlgGYbXeEZgBsJgI+X9NF+dqTHrHOiPZP1kDPR
	yZB7yhKHz5rKvTalN2KT0ptboZTKy2EKId9Oa5AcsKSKLNbSZeEg3mES/8QGNKdw
	D8UG2IGqrJxI27yH2cj/QlEIe46uW/jsChAnKGdg96yhgyI0sbGHaNv29Z0kIvCc
	IalHeDWxkM3z8SlWbi6DYANcUiHe1KXszt5ksINX8/lRLFY3HCK7Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf57dx9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 23:09:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68GN2TJw1625747;
	Wed, 16 Sep 2026 23:09:39 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gpyxsgw6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 23:09:39 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68GN9cJW26477190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 23:09:38 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A91158054;
	Wed, 16 Sep 2026 23:09:38 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B65D5804E;
	Wed, 16 Sep 2026 23:09:37 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.141.190])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Sep 2026 23:09:37 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH 10/20] scsi: ibmvfc: fix u16 overflow of max_cmds in ibmvfc_set_login_info()
Date: Wed, 16 Sep 2026 16:09:11 -0700
Message-ID: <20260916230921.2204729-11-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916230921.2204729-1-tyreld@linux.ibm.com>
References: <20260916230921.2204729-1-tyreld@linux.ibm.com>
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
X-Proofpoint-GUID: 7CLJjdneXaOhQLDOvAicfUG-jAVeQh32
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDMyMiBTYWx0ZWRfX1yKCmj4B5PVn
 m8zRz9xOHFh4O869R+Q4wupnSWDcMG4AQ4261PaaG05vY0C41AyHEUycj2INE4Dvzx4tr+m+lCM
 MIwDEaEIBcOhQCpj0GP+TanRrR7NyW0=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aab21b4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=oS3JfTuPRayek_SdIqsA:9
X-Proofpoint-ORIG-GUID: 7CLJjdneXaOhQLDOvAicfUG-jAVeQh32
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDMyMiBTYWx0ZWRfX8yCpn8BkXgct
 6DyXelqP0IogPPrymZtFGiB3+4+6LA3gr/2YgCki4Ha16Og4j8/NHDYhhea39+Xei7XUZTyyj8a
 0/8M3mLf9gBLBoT3UL8PHRPmQIcduSEv3QYI0xDH/WLLBJoQ6ZtShdKGPtE1WbvePYjISteCn7f
 XyNzCozyyV/69BVNHxcej/aQ39MnKz4Tv3YJkqoYxrJ2LZXkMD/CbdHTJQoyLvCQ08UfkEQ4Og/
 LFGX5Ah51CntZUNAtQCvNtXplGDxnTZXjH1+g4Kl8GIfDlf4szcmvOVL+PSdupJpcf28bc0RV7p
 XrQV205BdIt6CFCSySobA8GvVsO6r7wI/h8Eb+6lqW+6w1A9RArrepZtH5101x2KIzcNqiEaDv5
 tQ49UwX6/fh9qOznMzvLXLLxuJc/zo/69q8+C+ZE1zkyDs9voplWj8jnJPMkNFupFWuwc7217cJ
 5CeZoGhJXIUoUfnKQvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160322

max_cmds is declared as u16 but the calculation:

  scsi_qdepth + IBMVFC_NUM_INTERNAL_REQ +
  (scsi_qdepth + IBMVFC_NUM_INTERNAL_SUBQ_REQ) *
  (scsi_scrqs.desired_queues + nvme_scrqs.desired_queues)

can exceed 65535 at non-extreme configurations. With scsi_qdepth=2048
and 32 total desired queues (16 SCSI + 16 NVMe maximum), the subqueue
term alone evaluates to 2052 * 32 = 65664, which silently wraps to 128
in a u16, causing the NPIV login MAD to advertise a badly corrupted
command slot count to the VIOS.

The wire field login_info->max_cmds is already __be32, so widen the
local variable to u32 to match, making the arithmetic safe across all
supported module parameter combinations.

Fixes: bffd16f59061 ("ibmvfc: add logic for protocol specific fabric logins")
Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index e5eb0997d507..e2f2fa42bcfd 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -1562,7 +1562,7 @@ static void ibmvfc_set_login_info(struct ibmvfc_host *vhost)
 	struct ibmvfc_queue *async_crq = &vhost->async_crq;
 	struct device_node *of_node = vhost->dev->of_node;
 	const char *location;
-	u16 max_cmds;
+	u32 max_cmds;
 
 	max_cmds = scsi_qdepth + IBMVFC_NUM_INTERNAL_REQ;
 	if (mq_enabled)
-- 
2.55.0


