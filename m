Return-Path: <linuxppc-dev+bounces-24682-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF27C44536
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 00:03:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5BBj3fvSz30Wb;
	Thu, 23 Jul 2026 10:02:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784764941;
	cv=none; b=jGXQNrnruZLfPibZvQF/YMqCUbGguD1OSN0uOzkWfBafHhInjzm5s7eEIenIMD59uK6rnsHO8QXA4p2co9H6JxUI2fm6ZMqHAHJxHLKK6ZyL7fyxOZTDfdA2aPBpGYHiJmQ8UBflVELmzLFi9f0MnaHodMiSkQ+su6JNq0OgNrwshBrxGy/5KJAtfOXyUprc5LonZGbAyrkBzA9Pz6u++po+V39GuDbdxK/j3ehbxSfRaqM8thm15stmvkt0cY0thjyHcbwvk975M2hNzQvvvGK0+fk/GEUGPFhmwo4qcBD94hgHcf1GIPiTIOdZp2k4XAP6hGdG0wPYIkP9tMLMEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784764941; c=relaxed/relaxed;
	bh=2EWbeYjqIEIHDerH8OnXaiH3xR3pLUb5ZY1bKI1oaTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SgB6V7p9mVJwamNxBGiPDmrV/3mUUnyBmJof+lbv/sPZSrCha3IbN4LzbSwzEkpfgH7vDF1UwkV5U39xmbnGiXnlQr88KqmgaXuHKQbN7eiUHjutN9gpvfDjUMMaXH7c5DW1sxVagLp7G0hW8SDOWhw9ggAY7FNznmgMlY8C2pXA3aRbaqb0WjMs5oIKr6cH7strOnOeXUmn67OVYl8ZT76RzEu88rfQK30hpfCBP1ypy6EMrUEuAmNbXK78x3sP+uepgEU2+3lO6h5ctyBamEdI/uw7Bu9+pbo/aDrb5IUdrj6XIK3t4xJ8z5+La6aYqNEW5Z6kWwdV5cQiBtK2iQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Op9uRFsy; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Op9uRFsy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5BBV70h3z2yrC
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 10:02:10 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MIBkqt712893;
	Thu, 23 Jul 2026 00:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2EWbeYjqIEIHDerH8
	OnXaiH3xR3pLUb5ZY1bKI1oaTU=; b=Op9uRFsyazVQ36ZuUiXHTg4xp3IPn5r7z
	zF1vYpVZVJ/ltlcrm6434n38ghB8qx0QDUpUrEmsGYesVkPgLfQpI7CYve7Q7i28
	Kj+dpxUA4GuFzKiVPmdfUC4MCTeaLV1a7Tf4bJ6svSeuv+j/h7EtPU6RS0ngZX8w
	JhIDLzmGXRiUUcUeyZrX8Y0HLCbmx1UcFxy63y4frUg+PM4eeHsceO2XCZnTVWpj
	dTXzQcz3+pQ+jD9aOBaUCbJ2Q8EQU8fdLw3SPucJfXGMdpZzuweS/t9m4OcS0jjB
	D/N1UbdRYg6VDpTgMX+sKC6PM7HatZdP05DC+t1HlSOaalagkEzjA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahcctb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 00:02:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MNncnY009390;
	Thu, 23 Jul 2026 00:02:07 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1ghja8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 00:02:07 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66N01TF37340716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 00:01:30 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6440E58068;
	Thu, 23 Jul 2026 00:02:05 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8C9658060;
	Thu, 23 Jul 2026 00:02:04 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.118.58])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 00:02:04 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH v2 16/33] ibmvfc: add NVMe/FC Implicit Logout and Move Login support
Date: Wed, 22 Jul 2026 17:01:32 -0700
Message-ID: <20260723000149.969416-17-tyreld@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: M-K_QW-daduJz-yE8PrzUfl4lwNzvZSp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDIzNCBTYWx0ZWRfX9qxDODB7tpAI
 RxkKh/mGZ2jHxnksxo9jSXG16A9XsmCbq6vr98GfmthaKtSLNdUNIBS/grORnNLP2dtRjSj7I5e
 exYpKU8GvFSdva8i2SG2o5HtILbXYXFcFiE2CqibO4mq+C2j79LPV6ziBp6TnGxtNMeQFOqLkOz
 eBQsEfaGKmLzWVAVe8W7xtnlU7/QplDVWb/zU8fgaPgtS+dQGCKSu6S8OkDKNaLo3swi9yUP1ht
 fkHg/GloGMEYeOjq2Psc8z5xveQCdZ2bOdjtVPhs0kZ669mCc6CaZ2fxkZmdyhrxvlv77qz42Pq
 kTm6gUdzMEh3vhQEXQGEKRzI0/56u798kmUyibLOLxhp4YMBF3qkd7lSazlQ/Rid51ZLGPAHsh9
 u2m9jm3x2aAjhYj3gzbeX1UsY0wu2NZ6TZR3xxA1MvVKwa1qBfHbr9oKcN63gvsQGl1Z2UVDvyT
 FiQeEdYkpQVyLVW/prQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDIzNCBTYWx0ZWRfX1eV6lT5xpI9/
 BCImDxNQU7WCccj5ICBHHy2kGhFSQkxklT/kDyA0yvht3Nce/1TTOr0x1oob/5khehiyynpX2p1
 fkvtOz/zB2T1ckF15A3AFOo7Bm51I2I=
X-Proofpoint-GUID: M-K_QW-daduJz-yE8PrzUfl4lwNzvZSp
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a615a00 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=vOiCItosospfXf71XmMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220234

Add protocol-specific handling for implicit logout and move-login
operations on NVMe/FC targets.

Select the NVMe/FC-specific implicit logout opcode when operating on an
NVMe target and update the associated logging so protocol-specific
operations are visible in debug output. This extends the existing target
relogin and migration-related flows to work with NVMe targets as well as
SCSI targets.

These changes are needed so target reauthentication and target movement
continue to work once NVMe/FC targets are added to the driver's state
machine.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 33 +++++++++++++++++++----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 1d2a88e9fe94..66fcff7ac834 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -4318,7 +4318,7 @@ static void ibmvfc_tgt_implicit_logout_done(struct ibmvfc_event *evt)
 
 	switch (status) {
 	case IBMVFC_MAD_SUCCESS:
-		tgt_dbg(tgt, "Implicit Logout succeeded\n");
+		tgt_dbg(tgt, "%s Implicit Logout succeeded\n", proto_type[tgt->protocol]);
 		break;
 	case IBMVFC_MAD_DRIVER_FAILED:
 		kref_put(&tgt->kref, ibmvfc_release_tgt);
@@ -4326,7 +4326,8 @@ static void ibmvfc_tgt_implicit_logout_done(struct ibmvfc_event *evt)
 		return;
 	case IBMVFC_MAD_FAILED:
 	default:
-		tgt_err(tgt, "Implicit Logout failed: rc=0x%02X\n", status);
+		tgt_err(tgt, "%s Implicit Logout failed: rc=0x%02X\n",
+			proto_type[tgt->protocol], status);
 		break;
 	}
 
@@ -4359,7 +4360,10 @@ static struct ibmvfc_event *__ibmvfc_tgt_get_implicit_logout_evt(struct ibmvfc_t
 	mad = &evt->iu.implicit_logout;
 	memset(mad, 0, sizeof(*mad));
 	mad->common.version = cpu_to_be32(1);
-	mad->common.opcode = cpu_to_be32(IBMVFC_IMPLICIT_LOGOUT);
+	if (tgt->protocol == IBMVFC_PROTO_SCSI)
+		mad->common.opcode = cpu_to_be32(IBMVFC_IMPLICIT_LOGOUT);
+	else
+		mad->common.opcode = cpu_to_be32(IBMVFC_NVMF_IMPLICIT_LOGOUT);
 	mad->common.length = cpu_to_be16(sizeof(*mad));
 	mad->old_scsi_id = cpu_to_be64(tgt->scsi_id);
 	return evt;
@@ -4395,7 +4399,7 @@ static void ibmvfc_tgt_implicit_logout(struct ibmvfc_target *tgt)
 		ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_NONE);
 		kref_put(&tgt->kref, ibmvfc_release_tgt);
 	} else
-		tgt_dbg(tgt, "Sent Implicit Logout\n");
+		tgt_dbg(tgt, "%s Sent Implicit Logout\n", proto_type[tgt->protocol]);
 }
 
 /**
@@ -4425,7 +4429,8 @@ static void ibmvfc_tgt_implicit_logout_and_del_done(struct ibmvfc_event *evt)
 	else
 		ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_DEL_AND_LOGOUT_RPORT);
 
-	tgt_dbg(tgt, "Implicit Logout %s\n", (status == IBMVFC_MAD_SUCCESS) ? "succeeded" : "failed");
+	tgt_dbg(tgt, "%s Implicit Logout %s\n", proto_type[tgt->protocol],
+		(status == IBMVFC_MAD_SUCCESS) ? "succeeded" : "failed");
 	kref_put(&tgt->kref, ibmvfc_release_tgt);
 	wake_up(&vhost->work_wait_q);
 }
@@ -4466,7 +4471,7 @@ static void ibmvfc_tgt_implicit_logout_and_del(struct ibmvfc_target *tgt)
 		ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_DEL_RPORT);
 		kref_put(&tgt->kref, ibmvfc_release_tgt);
 	} else
-		tgt_dbg(tgt, "Sent Implicit Logout\n");
+		tgt_dbg(tgt, "%s Sent Implicit Logout\n", proto_type[tgt->protocol]);
 }
 
 /**
@@ -4486,7 +4491,8 @@ static void ibmvfc_tgt_move_login_done(struct ibmvfc_event *evt)
 	ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_NONE);
 	switch (status) {
 	case IBMVFC_MAD_SUCCESS:
-		tgt_dbg(tgt, "Move Login succeeded for new scsi_id: %llX\n", tgt->new_scsi_id);
+		tgt_dbg(tgt, "%s Move Login succeeded for new scsi_id: %llX\n",
+			proto_type[tgt->protocol], tgt->new_scsi_id);
 		tgt->ids.node_name = wwn_to_u64(rsp->service_parms.node_name);
 		tgt->ids.port_name = wwn_to_u64(rsp->service_parms.port_name);
 		tgt->scsi_id = tgt->new_scsi_id;
@@ -4507,8 +4513,9 @@ static void ibmvfc_tgt_move_login_done(struct ibmvfc_event *evt)
 		level += ibmvfc_retry_tgt_init(tgt, ibmvfc_tgt_move_login);
 
 		tgt_log(tgt, level,
-			"Move Login failed: new scsi_id: %llX, flags:%x, vios_flags:%x, rc=0x%02X\n",
-			tgt->new_scsi_id, be32_to_cpu(rsp->flags), be16_to_cpu(rsp->vios_flags),
+			"%s Move Login failed: new scsi_id: %llX, flags:%x, vios_flags:%x, rc=0x%02X\n",
+			proto_type[tgt->protocol], tgt->new_scsi_id,
+			be32_to_cpu(rsp->flags), be16_to_cpu(rsp->vios_flags),
 			status);
 		break;
 	}
@@ -4548,7 +4555,10 @@ static void ibmvfc_tgt_move_login(struct ibmvfc_target *tgt)
 	move = &evt->iu.move_login;
 	memset(move, 0, sizeof(*move));
 	move->common.version = cpu_to_be32(1);
-	move->common.opcode = cpu_to_be32(IBMVFC_MOVE_LOGIN);
+	if (tgt->protocol == IBMVFC_PROTO_SCSI)
+		move->common.opcode = cpu_to_be32(IBMVFC_MOVE_LOGIN);
+	else
+		move->common.opcode = cpu_to_be32(IBMVFC_NVMF_MOVE_LOGIN);
 	move->common.length = cpu_to_be16(sizeof(*move));
 
 	move->old_scsi_id = cpu_to_be64(tgt->scsi_id);
@@ -4561,7 +4571,8 @@ static void ibmvfc_tgt_move_login(struct ibmvfc_target *tgt)
 		ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_DEL_RPORT);
 		kref_put(&tgt->kref, ibmvfc_release_tgt);
 	} else
-		tgt_dbg(tgt, "Sent Move Login for new scsi_id: %llX\n", tgt->new_scsi_id);
+		tgt_dbg(tgt, "Sent %s Move Login for new scsi_id: %llX\n",
+			proto_type[tgt->protocol], tgt->new_scsi_id);
 }
 
 /**
-- 
2.55.0


