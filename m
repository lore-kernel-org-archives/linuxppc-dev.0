Return-Path: <linuxppc-dev+bounces-27522-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1044C982C1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 23:10:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlZN66wkzz3bbf;
	Thu, 17 Sep 2026 09:09:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789600182;
	cv=none; b=TwuF+AnQwbRiElH9OyalvAwtlsd6EwChVGU8jISNAaG5Xeulcq6csNK595ZePmzHRgcibD5x9LKkPsvMd081OugX2ZkEZseuUUTBy7eyQ8wF+lnQSOLvkajWQxgrr9i3d8vnek38qTTpoyluJO30F2ZnlqJaNx9GAvRNVN9ATERUBm+ZRbecFGvbdv8zOxXrtVMYS0jvvq44Ukk/4P9E+79+rAK74vkJdl3QHbMYySulA0365B1180jjPXWfL++kcMpFLnTWUgIfRy6zrQIgf3XH92peFyebvb8aKEAfXn18RwoOKme7yFS8A2gB+51aO2VjDnqrWuRIcAQEh3HL0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789600182; c=relaxed/relaxed;
	bh=FrLC2oNPttFPs4Vfk4Y4zUrmTP6nitaE45z1d6F8D/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eXgKh+EC5leU/Bm2pqNE7DM0PE6sZvH67VBxgG+1wRdQQnyWtecGhhZ0sEQI69UvgC5TrKOOFWx2IOfCXazj2pB6I26faFjH3N5d98iIl477+xE/YmOjuAIp5iNKbXDl70RzWEHK3LrazHMDjYm0MFmYDNW/94nOuJyx628AcY7RP2NR9G1DusnL+DGrMYkafuBgOjQOtTGUy97HSl91JlbG1g9zGRT6Fc+/nPKlINmjI7ozr+1LElbOJ0jttAour9Uu42AvBsQUtDZcDIrPFR+QQQco7D3ss0lxzYVcvxSpOk/+S9tFEimDbPUV7h2BNufeqNcIbutmNZQu+d7qrQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GMDVNlka; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GMDVNlka;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlZN61RP3z3bgd
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 09:09:41 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GG1bbM4057211;
	Wed, 16 Sep 2026 23:09:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FrLC2oNPttFPs4Vfk
	4Y4zUrmTP6nitaE45z1d6F8D/k=; b=GMDVNlkawJCL6S70MYeRJFUaDQ14zItU/
	jD9X1ik3RvyOiMslpDcxD/7cO/3Coj21Vg01HyNogNzBJH3TxB9SWwmmseMlZXVo
	qfQz8xfnddBSx5mYXH4biOoIK9HSvpuyJIcYWNQRFq6U4tWVwQ7yT4SalcfBdhhj
	mI3bKlu1oiC1Q9l6jzvHLkaiUeRF7MTs1KVHWq1g0W74M13M4ECplrKDyCqo0Wmp
	7dXKXp80RemIK094RDzbQoZrCr1bF86xyiz4uDQL+GV4ZNfQT3yTmy3c+1OfLZTO
	ye5PVvft/PIXWNP8xvLgdS8EBAeCqxmJaHsywJMDtcFDVNQyj2GEw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5hy9v6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 23:09:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68GN0dv82599738;
	Wed, 16 Sep 2026 23:09:38 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gpw6d9e93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 23:09:38 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68GN9baI53477874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 23:09:37 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F5B758060;
	Wed, 16 Sep 2026 23:09:37 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EB0D58054;
	Wed, 16 Sep 2026 23:09:36 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.141.190])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Sep 2026 23:09:36 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH 09/20] scsi: ibmvfc: fix infinite reset loop on NULL evt in implicit logout path
Date: Wed, 16 Sep 2026 16:09:10 -0700
Message-ID: <20260916230921.2204729-10-tyreld@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDMyMiBTYWx0ZWRfX+6lJ0kJDM/Ee
 ztVYrJerrGxA8bdFmPUvO4dBhxpkHjIreBxa5gIjPV+Dem3o4Z78m5sVLGvnko7IN27JU09urOF
 4JtQjU/ZDhztFlbKd9I8F/dxX2notzxQlRO/hi3t9wChnWs2kDl64ayo/K/7Qln3D6fbBdSKTav
 qiadETwtqJDb7c2OjKaId9PkgJnEUioEfUOAh2YGoqNP08I9sf0a3KpM5BUtYUqsv22oZijNyis
 anfp70Kd2cHrWdD+adVzp4r1MNneEXV1NKVZTWosONbuFE8YldD/+cq03AziLEsUsbceACI3sJZ
 TMiUzlJo9bu/iCC9vHsAXrekQ2OhyHgMVrV+WP/YwIZlTx9ycP1lwS1Dr1t2btvDD8mOR1q1UdP
 6MgXhx0/zqYzFYItAaVnZmptI99VviYH/Rk1HO6v0JImG8Nqm6xhhYsA4vW9OjH8CF24CooOcd0
 MmhY44/MA9kpaJS7lhg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDMyMiBTYWx0ZWRfX6+qAfU7ur3Iq
 OCgycOUOtxnpKf1/vuzmK7+BYAq/yK2f2Ylz82hYo7Qk2UlvxPVPNo/cU+Bfxf+L7i0pqnxopol
 0gcN9BpZ/6sGXIHyG/egBxBqzh7uT7Y=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aab21b3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=b_dQgyAL5RWhf91NP5kA:9
X-Proofpoint-ORIG-GUID: Zu2guZDqoAWmUqu9iTalyHmIe9n6-iUQ
X-Proofpoint-GUID: Zu2guZDqoAWmUqu9iTalyHmIe9n6-iUQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160322

ibmvfc_tgt_implicit_logout_and_del() calls ibmvfc_set_tgt_action() with
IBMVFC_TGT_ACTION_NONE in the NULL evt error path. However the state
machine in ibmvfc_set_tgt_action() explicitly handles LOGOUT_RPORT and
only permits transitions to LOGOUT_RPORT_WAIT or DEL_RPORT from that
state; NONE is silently rejected and returns -EINVAL, leaving the target
stuck in LOGOUT_RPORT.

With the target permanently in LOGOUT_RPORT, ibmvfc_dev_logo_to_do()
keeps returning 1, causing the host to spin in an infinite reset loop.

Use IBMVFC_TGT_ACTION_DEL_RPORT instead, which is the same transition
taken by the !vhost->logged_in early-exit path in the same function and
is the correct valid transition to unblock target cleanup.

Fixes: c8380c3ff651 ("ibmvfc: check for NULL evt in implicit LOGO and target delete path")
Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 18e7a462e32d..e5eb0997d507 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -4542,7 +4542,7 @@ static void ibmvfc_tgt_implicit_logout_and_del(struct ibmvfc_target *tgt)
 
 	if (!evt) {
 		vhost->discovery_threads--;
-		ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_NONE);
+		ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_DEL_RPORT);
 		kref_put(&tgt->kref, ibmvfc_release_tgt);
 		__ibmvfc_reset_host(vhost);
 		return;
-- 
2.55.0


