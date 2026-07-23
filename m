Return-Path: <linuxppc-dev+bounces-24685-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 596CEC44532
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 00:04:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5BBk2vr8z3brL;
	Thu, 23 Jul 2026 10:02:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784764942;
	cv=none; b=fD3Ry6XZk66i5hMjabABtzE3zzMs1JsIprQoJ8kWjGIQ0a2z8+astaE+uRdWfiXZhvbTRmq3oJxq6rmX4X85OyWmzP0+alY6FWQk6AzesQF5lYQQKus4AupacK4hmzAWuSGD1tP1Mq2T5HN/JwpHgmLeagGyvO/Y1UNyS3cGUqhJdA+a/k/7+3eJbyq9rwXN2l5mEZYS/UBIwaRG3VE9ixwBTQYhp+W2k0CT6Lq1jhGRN0H8FDP244JQ9CnmTJrh4qkAzN/g3PseQVxFzSnwT+BbB0OTnQt60jJMaEF2HiIbGxWD4WvkVvKU7r6Up6HzGoCfvZsfPBEvGHMIGVRMrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784764942; c=relaxed/relaxed;
	bh=aTujkMcgyHlk3C9g4oRTB5pn7toMmHXYhqj5kr7m5UU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PugIa1cQ7NDMAqrAvGACpgpTpXFjQtBuqowOt7Nydv1JoBloTHSKdcKZ+5E5pWaPCkWaxuKOJwwtUiE/P2nJ6Aeeobx6WJoJhPXqreOHQOONLnNZOOL1YdqGdq+/QftbxC+H/8XDJYPzDmCohMzfyOUc/ylmAZGGaIQVEo7/9uUDDwMqyr1kWboqZEowDgGNc1OaIHiR+DMCwuQO4FMbRMqVsdk0/hauNBdz0ZA8gsxU/SUfFzodeRxz/9Vobv8uUtmpwE7gZoUa1VCCKKfpUJwkrguWFDjTrohZcgok4gb9fZ/0gaj8xJ2HdtqZq/Q/WhVA5fcNybPQm5sXLv1P6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hOAJAkcO; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hOAJAkcO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5BBZ5tQDz2yvV
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 10:02:14 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MICBC9713996;
	Thu, 23 Jul 2026 00:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=aTujkMcgyHlk3C9g4
	oRTB5pn7toMmHXYhqj5kr7m5UU=; b=hOAJAkcOE1N7y7OE6eRKz+IWo06uLtamL
	mo4/EAacc/7nDTYXDi6boyK8IvFNgk8lH2DoOT/UiNmFhe0dvURKC7BmSYOMrAqi
	+llbcmEPC51xUFgRX3pft5S2zjyEQ96i5S3XKNGV0xfbFKFQb6qjQiHN8F03Z4mz
	MvbdozgFlDWC/WjmTAr8aDoM4GW1GjELTbreBj2VlPmkTDQeHQHKHMjUFI9I8fuu
	ZyxFXI3fHgsexF2hmeGqso+r07oejIT7mfArwQ3QG4/pFCQmPyA6IHYEE3guNVjX
	NIMRxMW9YRC3uJmEfUWDOPtlikA39QwhdZ+y2bap7CJTTqPiS51Dg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7914xq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 00:02:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MNncpe009383;
	Thu, 23 Jul 2026 00:02:10 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1ghjaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 00:02:10 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66N02ALJ9896646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 00:02:10 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08D435805A;
	Thu, 23 Jul 2026 00:02:10 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DC4C5803F;
	Thu, 23 Jul 2026 00:02:09 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.118.58])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 00:02:09 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH v2 22/33] ibmvfc: update state machine to process NVMe/FC targets
Date: Wed, 22 Jul 2026 17:01:38 -0700
Message-ID: <20260723000149.969416-23-tyreld@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 6SJd1A_AZabApK0vWY6pDand2DOy9YZq
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a615a03 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=-uFVuYJf3eyC8FhR5LMA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDIzNCBTYWx0ZWRfXwdOr8wzGz50v
 4SrCqWrZSJqQA737BDjP3ZGtd5eyy4/nqeX1Stt72Y+bVUUJEoqW7USJD7jVtp62gtjrL03DkVK
 Fm5WyThtUtRQx4il5/vn0epXSsKRmjM=
X-Proofpoint-GUID: 6SJd1A_AZabApK0vWY6pDand2DOy9YZq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDIzNCBTYWx0ZWRfXyOIA8lJXw4U9
 huoeOEf50G/2uw7lrC1y2Fa1y8tyzkPEo1Hzp++ia58I+bGU1/XxwGqAHegqWQKniBuq+nbWirM
 vi3olpJjZnGj7JG9oMwzzHxUa39nBp7Zu3GYjqCvaFSBiTmikxzPnvleomekL9JjbivVgNdo2P0
 HsKtea9eyAECCXggCuI2cl1GIMobBIchax0g6v4ESOD+lhGzRHbZ74I/DuzIluh8zdYkdkvvv5A
 BN0Adows6kg5Rg6CM908fOb1624mJjdg8npO8b23RJM4mwmo5x19FT1gLZadwG4kDKg/gRlln1O
 K7OOicpME4MVaRREO9dO5DfSswyFpmG/8dfM0utU9moaNNVUQRU8bt0cpo8XjQMVIT6yk/q/ZDV
 ZQJPjdKw/XEDuA40rYmzUZtsDA0udNPgLyt46JVo49vgJE3Hbjuwc6GgKHSFW2OkpCdADOL1Nzl
 5CjzS7TMsOD+IC9Lx2Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220234

Update the host work loop and target state-machine helpers to process
NVMe targets in addition to SCSI targets.

Check both protocol-specific target lists when determining whether there
is initialization or logout work pending, and extend the query, target
init, and target delete phases to dispatch work for NVMe targets using
the same common state-machine callbacks.

This allows the existing discovery and login state machine to drive
NVMe/FC targets through query, login, and deletion without duplicating
the control flow.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 42 +++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 1185d72a8a73..ff84ca0f9f45 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -5718,6 +5718,11 @@ static int ibmvfc_dev_init_to_do(struct ibmvfc_host *vhost)
 		    tgt->action == IBMVFC_TGT_ACTION_INIT_WAIT)
 			return 1;
 	}
+	list_for_each_entry(tgt, &vhost->nvme_scrqs.targets, queue) {
+		if (tgt->action == IBMVFC_TGT_ACTION_INIT ||
+		    tgt->action == IBMVFC_TGT_ACTION_INIT_WAIT)
+			return 1;
+	}
 
 	return 0;
 }
@@ -5738,6 +5743,11 @@ static int ibmvfc_dev_logo_to_do(struct ibmvfc_host *vhost)
 		    tgt->action == IBMVFC_TGT_ACTION_LOGOUT_RPORT_WAIT)
 			return 1;
 	}
+	list_for_each_entry(tgt, &vhost->nvme_scrqs.targets, queue) {
+		if (tgt->action == IBMVFC_TGT_ACTION_LOGOUT_RPORT ||
+		    tgt->action == IBMVFC_TGT_ACTION_LOGOUT_RPORT_WAIT)
+			return 1;
+	}
 	return 0;
 }
 
@@ -5766,9 +5776,15 @@ static int __ibmvfc_work_to_do(struct ibmvfc_host *vhost)
 		list_for_each_entry(tgt, &vhost->scsi_scrqs.targets, queue)
 			if (tgt->action == IBMVFC_TGT_ACTION_INIT)
 				return 1;
+		list_for_each_entry(tgt, &vhost->nvme_scrqs.targets, queue)
+			if (tgt->action == IBMVFC_TGT_ACTION_INIT)
+				return 1;
 		list_for_each_entry(tgt, &vhost->scsi_scrqs.targets, queue)
 			if (tgt->action == IBMVFC_TGT_ACTION_INIT_WAIT)
 				return 0;
+		list_for_each_entry(tgt, &vhost->nvme_scrqs.targets, queue)
+			if (tgt->action == IBMVFC_TGT_ACTION_INIT_WAIT)
+				return 0;
 		return 1;
 	case IBMVFC_HOST_ACTION_TGT_DEL:
 	case IBMVFC_HOST_ACTION_TGT_DEL_FAILED:
@@ -5777,9 +5793,15 @@ static int __ibmvfc_work_to_do(struct ibmvfc_host *vhost)
 		list_for_each_entry(tgt, &vhost->scsi_scrqs.targets, queue)
 			if (tgt->action == IBMVFC_TGT_ACTION_LOGOUT_RPORT)
 				return 1;
+		list_for_each_entry(tgt, &vhost->nvme_scrqs.targets, queue)
+			if (tgt->action == IBMVFC_TGT_ACTION_LOGOUT_RPORT)
+				return 1;
 		list_for_each_entry(tgt, &vhost->scsi_scrqs.targets, queue)
 			if (tgt->action == IBMVFC_TGT_ACTION_LOGOUT_RPORT_WAIT)
 				return 0;
+		list_for_each_entry(tgt, &vhost->nvme_scrqs.targets, queue)
+			if (tgt->action == IBMVFC_TGT_ACTION_LOGOUT_RPORT_WAIT)
+				return 0;
 		return 1;
 	case IBMVFC_HOST_ACTION_LOGO:
 	case IBMVFC_HOST_ACTION_INIT:
@@ -5967,6 +5989,8 @@ static void ibmvfc_do_work(struct ibmvfc_host *vhost)
 	case IBMVFC_HOST_ACTION_QUERY:
 		list_for_each_entry(tgt, &vhost->scsi_scrqs.targets, queue)
 			ibmvfc_init_tgt(tgt, ibmvfc_tgt_query_target);
+		list_for_each_entry(tgt, &vhost->nvme_scrqs.targets, queue)
+			ibmvfc_init_tgt(tgt, ibmvfc_tgt_query_target);
 		ibmvfc_set_host_action(vhost, IBMVFC_HOST_ACTION_QUERY_TGTS);
 		break;
 	case IBMVFC_HOST_ACTION_QUERY_TGTS:
@@ -5976,6 +6000,12 @@ static void ibmvfc_do_work(struct ibmvfc_host *vhost)
 				break;
 			}
 		}
+		list_for_each_entry(tgt, &vhost->nvme_scrqs.targets, queue) {
+			if (tgt->action == IBMVFC_TGT_ACTION_INIT) {
+				tgt->job_step(tgt);
+				break;
+			}
+		}
 
 		if (!ibmvfc_dev_init_to_do(vhost))
 			ibmvfc_set_host_action(vhost, IBMVFC_HOST_ACTION_TGT_DEL);
@@ -5988,6 +6018,12 @@ static void ibmvfc_do_work(struct ibmvfc_host *vhost)
 				break;
 			}
 		}
+		list_for_each_entry(tgt, &vhost->nvme_scrqs.targets, queue) {
+			if (tgt->action == IBMVFC_TGT_ACTION_LOGOUT_RPORT) {
+				tgt->job_step(tgt);
+				break;
+			}
+		}
 
 		if (ibmvfc_dev_logo_to_do(vhost)) {
 			spin_unlock_irqrestore(vhost->host->host_lock, flags);
@@ -6075,6 +6111,12 @@ static void ibmvfc_do_work(struct ibmvfc_host *vhost)
 				break;
 			}
 		}
+		list_for_each_entry(tgt, &vhost->nvme_scrqs.targets, queue) {
+			if (tgt->action == IBMVFC_TGT_ACTION_INIT) {
+				tgt->job_step(tgt);
+				break;
+			}
+		}
 
 		if (!ibmvfc_dev_init_to_do(vhost))
 			ibmvfc_set_host_action(vhost, IBMVFC_HOST_ACTION_TGT_DEL_FAILED);
-- 
2.55.0


