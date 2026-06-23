Return-Path: <linuxppc-dev+bounces-22897-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 879E6CDB46F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2026 01:32:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gknZq1RyQz300B;
	Tue, 23 Jun 2026 11:30:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782178259;
	cv=none; b=eTQPdigZHVnNvHKX7m6l0Pefj153vIpiNootmJVl84sk3PifmXI953dK6jqNDSiayH/LGG2ujdvRbnSo6/axFvreZUuOocyr/gVQvFPNrAYCSkWkEpGCWy3ke/J1lQKKc4YRQXSzPzJuH1JNsqIsqYIABRAT+9h++KQF0TcyWgSXVbn3sT14AKyukbKovOg7mw9CjFmHJAk3MQu8+v8ZnwZ9tpwUHeGLQ8u/1V0WjKJxJQYka9aGSlx4/xxp7urwZr3HUpZqewInuFKQ42SstFzVs2Js4EK5l6lq0b+2ZbvticRub+isk1Trs3FwiMKP/AmjgMDfUC/rjPwa1/37QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782178259; c=relaxed/relaxed;
	bh=gdKp0tuEdkhI9N+iB8+Nb0yfXn6AnGSkMqSZPcEEYa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+z8eNuidxEm7rH0EY1Q5/tXiNgg3pCMDVdtyeSpRX5kJmR35/e1+S4EyV/TRH55+wEUsvDvsFIdieHeEZulWpTKHhrLeg7v0rwjQ6b7LAGcsqlrDgwUssqV+utX6gBCMQvOuWhb7qst0zFaBT3P5d/Q7BdX9frqM5E4/2HSQGoBVd7PskOY0j/BHmCv8usEvUKqFakxmd0Ju/H3gSBLNvGcszix2cJSk24W/FRovTA/FK3jItmOnWICDMVnxfvh2CJMNzfy93lVi6Tcwu1r6XwvZcYKHAeoxpb8zKMuar7uWgu/LnRUTRn17KwevfwrVCW3tx2U4eTok7qBJPKR8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HqeWFU7W; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HqeWFU7W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gknZj2xFpz2yqX
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 11:30:53 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N0nZKT310847;
	Tue, 23 Jun 2026 01:30:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gdKp0tuEdkhI9N+iB
	8+Nb0yfXn6AnGSkMqSZPcEEYa8=; b=HqeWFU7WMufd1+WNDRiUrDjoQ7kWLIDHp
	M7h755I10C2sJ/ptYyUXx5QxzM+yKvG/jdyyiGOlNfLj0lacEZLAN23mghxC2wzc
	2ekZPAYEEaZsq/HxIcXzy61nhYiSpCXdQEH7e9fs0wRhyKKnLUM09i+IQizQTc7y
	xF60dHDTpC/H2GjFdJDhEUtxVqLWQtsY6SBU0s8PjKWRJYKpV507RlICgrWHZQIw
	FI8W5ApxsPLMr/trIvVWjMnk9X/5e58NoqWpKxHdvMtnSL+nBiyLnQLYpm8h0JzT
	S8rx+2zrmKXwCa9/QIavvQCVQcZVW+S56ghqqcXP0zWWb+od1jH5A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9hmbuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 01:30:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65N1K6Kr002685;
	Tue, 23 Jun 2026 01:30:49 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56q95ma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 01:30:49 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65N1Unre25494174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 01:30:49 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 110E758052;
	Tue, 23 Jun 2026 01:30:49 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70E215805A;
	Tue, 23 Jun 2026 01:30:48 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.188.206])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 01:30:48 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH 15/29] ibmvfc: add NVMe/FC Query Target support
Date: Mon, 22 Jun 2026 18:30:21 -0700
Message-ID: <20260623013035.3436640-16-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623013035.3436640-1-tyreld@linux.ibm.com>
References: <20260623013035.3436640-1-tyreld@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: x_JPWFOQqnsqgl7rLluY5dD_Qdfmo6BU
X-Proofpoint-GUID: x_JPWFOQqnsqgl7rLluY5dD_Qdfmo6BU
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a39e1ca cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=LC8GvMgr8iK42x-OS58A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDAwOCBTYWx0ZWRfX0wP2W48F78V2
 wxsfD3iMRXLcadp4R+odwHafbH3b6bq5GlHmg4vcI7QoUZvZYY8CDHIe5hoxCwga5DFhBvZ4t8i
 e1T2G5VEejZRCLqEE/TiVMHf/3Z2A72fPYlgRcKqtSFYbZ+vZIQXGfif6stNafpmFbpZhZwZerj
 gZP9W/tNU9TV18vxQnNrJapctpdhB5GZN2tV3j6Yeet48yCxAnJ05LPTUMDlMKYtTVl3I5V0PdR
 8FRD7oTJ5V5tGrDJUt1pN1iY2KEv3zk6GashYSuyVX0dIg7DlRnu4vMwbg9hBVTcUZw0TnTV2eF
 e3neY8Tj2OehoHcy2du205z28wFrPGJm0oo80bhvkyJxBNnPqoSzvipnSe6E9rw8fS+wzPstO0S
 YJKq4kdchF5xbJ3QDJzmGq8lKdprfBAfKQGMPjXK6yPHUG0LG5NEya8H8n3u0rtCpoK2DjvYBia
 sdOZBSYxQbNCafvQb/A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDAwOCBTYWx0ZWRfX5YnoNqbVKlv5
 dxVg9wRq0rir3fuPSWCuBmitMwmXSawUt0n6FDWAFoDw+f7ZX95G/yz0fzwAXqKgq9W5ddttOAI
 7Jnx1B+oTB+qI86waRG4gBMomKsAD2g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230008

Add protocol-specific query-target support for NVMe/FC targets.

Use the NVMe query-target specific MAD when querying an NVMe target and
update the associated debug and error logging to include the target
protocol.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index b45cd0183fb5..363bf75d6244 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -4849,7 +4849,7 @@ static void ibmvfc_tgt_query_target_done(struct ibmvfc_event *evt)
 	ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_NONE);
 	switch (status) {
 	case IBMVFC_MAD_SUCCESS:
-		tgt_dbg(tgt, "Query Target succeeded\n");
+		tgt_dbg(tgt, "%s Query Target succeeded\n", proto_type[tgt->protocol]);
 		if (be64_to_cpu(rsp->scsi_id) != tgt->scsi_id)
 			ibmvfc_del_tgt(tgt);
 		else
@@ -4871,9 +4871,9 @@ static void ibmvfc_tgt_query_target_done(struct ibmvfc_event *evt)
 		else
 			ibmvfc_del_tgt(tgt);
 
-		tgt_log(tgt, level, "Query Target failed: %s (%x:%x) %s (%x) %s (%x) rc=0x%02X\n",
-			ibmvfc_get_cmd_error(be16_to_cpu(rsp->status), be16_to_cpu(rsp->error)),
-			be16_to_cpu(rsp->status), be16_to_cpu(rsp->error),
+		tgt_log(tgt, level, "%s Query Target failed: %s (%x:%x) %s (%x) %s (%x) rc=0x%02X\n",
+			proto_type[tgt->protocol], ibmvfc_get_cmd_error(be16_to_cpu(rsp->status),
+			be16_to_cpu(rsp->error)), be16_to_cpu(rsp->status), be16_to_cpu(rsp->error),
 			ibmvfc_get_fc_type(be16_to_cpu(rsp->fc_type)), be16_to_cpu(rsp->fc_type),
 			ibmvfc_get_gs_explain(be16_to_cpu(rsp->fc_explain)), be16_to_cpu(rsp->fc_explain),
 			status);
@@ -4913,7 +4913,10 @@ static void ibmvfc_tgt_query_target(struct ibmvfc_target *tgt)
 	query_tgt = &evt->iu.query_tgt;
 	memset(query_tgt, 0, sizeof(*query_tgt));
 	query_tgt->common.version = cpu_to_be32(1);
-	query_tgt->common.opcode = cpu_to_be32(IBMVFC_QUERY_TARGET);
+	if (tgt->protocol == IBMVFC_PROTO_SCSI)
+		query_tgt->common.opcode = cpu_to_be32(IBMVFC_QUERY_TARGET);
+	else
+		query_tgt->common.opcode = cpu_to_be32(IBMVFC_NVMF_QUERY_TARGET);
 	query_tgt->common.length = cpu_to_be16(sizeof(*query_tgt));
 	query_tgt->wwpn = cpu_to_be64(tgt->ids.port_name);
 
@@ -4923,7 +4926,7 @@ static void ibmvfc_tgt_query_target(struct ibmvfc_target *tgt)
 		ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_NONE);
 		kref_put(&tgt->kref, ibmvfc_release_tgt);
 	} else
-		tgt_dbg(tgt, "Sent Query Target\n");
+		tgt_dbg(tgt, "Sent %s Query Target\n", proto_type[tgt->protocol]);
 }
 
 /**
-- 
2.54.0


