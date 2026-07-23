Return-Path: <linuxppc-dev+bounces-24668-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FFAC4453D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 00:02:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5BBN260cz2yjm;
	Thu, 23 Jul 2026 10:02:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784764924;
	cv=none; b=lRa95sTPT+l5ULRCfQEq6FzKDULIS7NkMrYMxCNkal/JlGPrWGzMf6fr6buBZT5RKRsq6LmyILiDb3mII/fF3o6b9M6y5SyjnyIYR+CoRoIk/2swffvCxvJgaRVkD83XVy7P1A07NtS6diBl4QLrwFKDCLpavcS5ubcFDUmvP2+o6Ky/PmoVXN97bp9tSFLpzZLcMHPp6ENxVDTtsVSIBIedTpRwuiyjofjpR5cGHOpqKLaQfuxKBPpUQmfu5cBB6Vn0IORkD8f2YLXbgI3u79giPDMljCxD+vvvtHGLB5OMGRbZIQ9PoJXx8UipFa+uWOO798OUaJ0CK4WcBTuuHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784764924; c=relaxed/relaxed;
	bh=/0ALfZUO8FIrmuzVJzhsUTrsPYLDqHKPAEdKzBn6xE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7bCyX6vxE2whKTwbscoHQoamzcFA9kjBzgfbLbkzI7Fe2Vz/tbIuUJmM4hegjYwuWOce9XlHl57/x0JQ1rTogHuzR0t0BkGbEHgibNO+FLp79UgsJ721ilwz/aZ22MDTz/4VXkI9gqiZtIhROf5F3c6Z1LUARisoGVDtYtgVF9M5rbvYvCpQn6QrqgxLgZpKz3vphM40A0X1yu9fSKmQAfTctE6JWU/4YE3ZsHeR8BJsGHnK9b3U9VKRDKfiNSklpfzm4YLcdSs5PlaTRR1lOkcVk0hn6b18CPFgXZy9PizFpByX6Uvnmxv6FUNN9Rzxg+mMLpA8YMxEg45RzHNbw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PQNrBeCX; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PQNrBeCX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5BBK63MSz2ygL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 10:02:01 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MIBopq704742;
	Thu, 23 Jul 2026 00:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/0ALfZUO8FIrmuzVJ
	zhsUTrsPYLDqHKPAEdKzBn6xE8=; b=PQNrBeCXj/J6cvvVU3/KVpJP01uJyMHhC
	okM+1NDSz3whCeqnznHJQRVz47/mix5U/7dlifuGWEhK65HD/D4PyZWytRtb/XVo
	g0LnJwp30MoUWCe1N18/FFp9VEIHXCtU2hO2E3ZjwGdx+rsRccUhRl6NyUaJvL8K
	ImM2JR1XJuDfajZlxQRhpmkndetluqQ5zOf5GDdVZiunVyXJYUqBr9pA+jZsCcvy
	M7JhSmbbLipLKJRBmVprf3tzEHPdZsmBsBdaCXACfq/8VryWFlm1vUEF0x5X5HUA
	xYBq1ov+RFljRT4FjK+dXqt5w1w9HeyXeVel/A3W8O8/tSVDvEe6Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7abmymt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 00:01:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MNnfg7032317;
	Thu, 23 Jul 2026 00:01:57 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk1rrk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 00:01:57 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66N01tEk44368196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 00:01:56 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6AC858061;
	Thu, 23 Jul 2026 00:01:55 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1216D5806A;
	Thu, 23 Jul 2026 00:01:55 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.118.58])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 00:01:54 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH v2 03/33] ibmvfc: check for NULL evt in implicit LOGO and target delete path
Date: Wed, 22 Jul 2026 17:01:19 -0700
Message-ID: <20260723000149.969416-4-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723000149.969416-1-tyreld@linux.ibm.com>
References: <20260723000149.969416-1-tyreld@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDIzNCBTYWx0ZWRfXxdFPVYwve6Ur
 Xj1yYyI1vfaMb9/WalGd+X7Lw2ZoLkOn6T/m4EJOazOqArSYXuo3KEJf4EzZJwT5JHoa1QxIVu3
 wX/rOg+7Isc+jStjIqH/cxyZJTrQ2ZlEWCJ5ZIEq7MApAnv9b0M/W0wK1en0jclAWG0Wg3jfcKr
 rL3oI+DadXJeyS1H7cxPHkIP78xeEFr8TNzv99Vf5i2KHyTopZccO911sYZIiXPqQ7T+pGcnQei
 91RtOUXywf32AZVx0t4bb8bHcDEqNEoK9MUzj+KZJjbrAgefLQTmtY0KAc0VdlR9oUkFxsDQGRw
 bt0ThYUiNmvlRIOwV+JpyqGsZZJL0l7oZR/62EMGeE+a2efkyBDpMGNpBSCeAcG9XdJ6B7bSCaP
 NTlTWUhp9XSlIZRjrad8GOxURTSWuJqK0OwzlcZxujGdMVZ9CfcgBDFdEN0vHTVWMA9tVLf5SI3
 Xmb8Pc/eU1g/cE/1BQA==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a6159f6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=0xhV0qCuJtyj5y_2DJ0A:9
X-Proofpoint-ORIG-GUID: rtMMAuddeTgQsNBS-ACVZIMGPSU53l5d
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDIzNCBTYWx0ZWRfX3aXHbBQ5b6m6
 DeBUNPTwc6Z/ygmFT8l3vc3QlbNYEnf9YswqI4qnnqtxCVIJKuA/CCu+EGSnaiC8yKDJ8K5i8tI
 CqQCa8/NX+mCd15Az8vPrNuRcUvC+qc=
X-Proofpoint-GUID: rtMMAuddeTgQsNBS-ACVZIMGPSU53l5d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220234

Unlike ibmvfc_tgt_implicit_logout the ibmvfc_tgt_implicit_logout_and_del
path fails to check for a NULL evt returned from
ibmvfc_get_reserved_event and passes that directly to ibmvfc_send_event
which will unconditionally derefence the evt.

Check for a NULL evt and perform same escalation as
ibmvfc_implicit_logout.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index 72317d7840a5..59102dd1c787 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -4406,6 +4406,14 @@ static void ibmvfc_tgt_implicit_logout_and_del(struct ibmvfc_target *tgt)
 	evt = __ibmvfc_tgt_get_implicit_logout_evt(tgt,
 						   ibmvfc_tgt_implicit_logout_and_del_done);
 
+	if (!evt) {
+		vhost->discovery_threads--;
+		ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_NONE);
+		kref_put(&tgt->kref, ibmvfc_release_tgt);
+		__ibmvfc_reset_host(vhost);
+		return;
+	}
+
 	ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_LOGOUT_RPORT_WAIT);
 	if (ibmvfc_send_event(evt, vhost, default_timeout)) {
 		vhost->discovery_threads--;
-- 
2.55.0


