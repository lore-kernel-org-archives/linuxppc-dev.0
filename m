Return-Path: <linuxppc-dev+bounces-27766-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5009FC982DE
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Sep 2026 01:34:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmsT0131mz3cQH;
	Sat, 19 Sep 2026 11:33:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789781603;
	cv=none; b=jsn98aS2C8Iblde84v/x9HqXbX501y56f+9KGHegrktuho742qo79ipQrYKr0bTsuWPMtx+mGNWsPOAkA+KvV7TsFa3WkN+Lthz5ReQN6A7dzn7jNFORr+rUqVL8yGhT/TX3WGmWwof+pLxhYPVinpZg1lwCFynRjFexUNsX4EkCuICMBmB/rvevFVYyuOKv1IJPkLYlujMLuP+9W57k60Hoyu4Z64f0WAw+/X/gKoJt3L016/zBQbq4f6sUTyeXtWz9vCAdYYhh5mFOjogXwwWYcXUuY58cPcg2ttn8RHBg3jPyk+qmNLfuWT9oLfbPYhLJm8AYjbjUuuxfqkGK/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789781603; c=relaxed/relaxed;
	bh=UyEuUHJQNTzO2Papi4WdL/3PgTbno1Y/3bvrorvVotA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C6F20ZPRYZE8kt+kEJ1LqhVOqccvGyHPssqaEfWe/DOUwdmsF/QfIQHRi3wtKpcAnWSySAkZYQaIVZnX2Bmmx77NC/5KOq9uBsA4/BI8nTOMteJXSRenX5BSry17PT0fO4I3iR9UO8rLVoLeoUuQ1oOIK58KJ3KNSHOqkts/R3iax1ymtXnIRKtQ3Up0frY9sD7ZqwGoS+Rhw3FoPLH9bfAvrXwFpJt2vLoJrZg09H/2XMNsWRmqMKbiT9FEKUFlapW5kwrCpROOkVOnZbx4NeZfuZon5Rfdm6yMYRbbkMVED7et48BqYS7RkkZB5ZtDGvPuiGaAdDGw4Djico9bSg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PM+UuIWO; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PM+UuIWO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmsSx3Pbkz3cM9
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2026 11:33:21 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68J01U2U2680639;
	Sat, 19 Sep 2026 01:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UyEuUHJQNTzO2Papi
	4WdL/3PgTbno1Y/3bvrorvVotA=; b=PM+UuIWODxlvetX3hjEM7QILiWAamavbj
	LsgKZRE4TXDMwb6Qa/jrztj8sdXhhjBSv2B0bo7beuZVIXJ2c99ROP//tvoYNhAZ
	rhJJd6wo1XPU1tP26Lsfbn4usL55ywd/gxBQiKnqrM4sMzWBY8LYcQSzjuWUVGfj
	DdMwKMNCaOjrSwkMNz+CqVxDTTcfu+zco4xPVvHlOH5XoMeFC5o6UYNmPlcSrkzk
	fMQsF1cxxldHvroGh2egIUlSXYtdtV2p73K9UEmeQx6E3i8/KfDoN0AZtxYUPeQn
	C25PhVJgvUSq7Mowaypj5Hdx2sNiF9P0l/bftd5qoA4/gvw6dyMWQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf5k1tw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 19 Sep 2026 01:33:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68J1QlXH1584848;
	Sat, 19 Sep 2026 01:33:17 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gsgr2r0es-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Sep 2026 01:33:17 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68J1XGQM26870276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Sep 2026 01:33:16 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2847858051;
	Sat, 19 Sep 2026 01:33:16 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 810165805A;
	Sat, 19 Sep 2026 01:33:15 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.101.145])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 19 Sep 2026 01:33:15 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH v2 07/20] scsi: ibmvfc: fix uninitialized status logged on LS abort send failure
Date: Fri, 18 Sep 2026 18:32:53 -0700
Message-ID: <20260919013306.2948028-8-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919013306.2948028-1-tyreld@linux.ibm.com>
References: <20260919013306.2948028-1-tyreld@linux.ibm.com>
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
X-Proofpoint-GUID: 8Q4wT0M_BTUg3W3Y2PrEHToNSCHh8qgs
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE5MDAxOCBTYWx0ZWRfX/MdtJ5bZKHyE
 3xzrZTgTD4JPhTVtdywKF8IQZ6PSt60UQlU0NHsdZqk5C57QiEDevG+SuJPvVb0jLVyN1v6/R2p
 hAJ1Uf3hcePEhPMJg6IrIaDyBiHaKlY=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aade65e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=dm6BVu0w9rUwWJiP_yAA:9
X-Proofpoint-ORIG-GUID: 8Q4wT0M_BTUg3W3Y2PrEHToNSCHh8qgs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE5MDAxOCBTYWx0ZWRfXxkVnIrmg5MIU
 xdlbQbsdCmAH+ciCLd8cyhBsMPZrOCgU009p9hkFgLfZKxiT5jx0RBU98f1bZ7GbhY0EMXMwT9e
 TcElrUElwOCWmLWs3vIkiWM/Tu6ntPv/bonE6aiggWK5VgSsSItq7wfZBb8jJoSM4VRNwT+FVaG
 OUXKIufd/jHHk30tLZ8Mm+hTie1Zksze0j3hRQ4mym23N/92V4jIsU2QmtcGBemBNhc4c0ow8aY
 aFj7FN77XhpedYSb1dGVVq4HvSn/OEsZ3iEeJn8FIf1dvYLJV14Em+ifoYORwSTif6/tSxt3fx7
 wlDD2UQiUKlWMWmGQ6A9+5EaZzbpt9zFUxBz8rUVGif3Y3TF2AUq3EReqDMB8iMzcDTVf7XNgdv
 GrVkNvZ6u03cBJ6kl+sQBSrz3Ccbg1DnpmGhVfWwdSwuREkX2mHkYnKbgUqCK6qUFmzFrkoF/GD
 9b53z2K064Y7ywLg/tA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_07,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609190018

In ibmvfc_nvme_ls_abort(), 'status' is declared without an initialiser.
It is only assigned at line 223 on the ibmvfc_send_event() success path:

    wait_for_completion(&evt->comp);
    status = be16_to_cpu(rsp.mad_common.status);

When ibmvfc_send_event() fails the code jumps via 'goto out', skipping
the assignment entirely. The ibmvfc_dbg() call that immediately follows
the out: label then reads uninitialised stack memory and logs a
meaningless status value.

Fix by initialising status to IBMVFC_MAD_CRQ_ERROR at its declaration.
This sentinel accurately reflects that the underlying CRQ send failed
and produces a meaningful log message on the error path.

Fixes: 20bec08f0208 ("ibmvfc: implement nvme-fc LS abort handling callback")
Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-nvme.c b/drivers/scsi/ibmvscsi/ibmvfc-nvme.c
index 08dd897b8e64..0391fdb4642d 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-nvme.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-nvme.c
@@ -202,7 +202,7 @@ static void ibmvfc_nvme_ls_abort(struct nvme_fc_local_port *lport,
 	struct ibmvfc_event *evt;
 	union ibmvfc_iu rsp;
 	unsigned long flags;
-	u16 status;
+	u16 status = IBMVFC_MAD_CRQ_ERROR;
 
 	evt = ibmvfc_get_event(&vhost->crq);
 	if (!vhost->logged_in || !evt)
-- 
2.55.0


