Return-Path: <linuxppc-dev+bounces-22898-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0640ECDB46F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2026 01:32:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gknZq6PLpz302K;
	Tue, 23 Jun 2026 11:30:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782178259;
	cv=none; b=Ys83jFh+oqK6Trs7O9CNCOpVPkOheF3wZomzDbU0B5PqihTiXtHrMOCzdelfECgIbFZbQbtbxWoL52sqh8rgnLbHGLjYxM0GQ5ZSAKtxQr1YoMjLzvBLX1DdUiRAnAVYUgrGp3aRcf4CW/7gnFC8oKwAu2lOV3I86EyTU+fcubUL0xT7jtmFhxy4QJfFinSMSR1fqH7O8ZAJkrPaDH/cxf2NYsnd3AOSDu4ZSnRam1JcjzJFXYKyGK/5kErtktSudDS7X9rpXUuSG3m4ykq/wiyzsjjQDxUPNKSJgLQihbSbGLLD3pr8s1npVdmnjuREM0XjEp+V24NME7I3Py50Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782178259; c=relaxed/relaxed;
	bh=lUcHaQeyG0kbFMmXJGyu7uR1kpkah6YkBgOsj+50H+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bVS4NPjKK8RtJx/ybKn6lo+4qxuTQNy6Bp1Exzj3WJ38xTGL5cr0hDFn+OKJSPav63r1Zg+urfMuzVFClOHSd1vPaBMto6M2bbikpqeOUUqIemylQnlnv0Nj+WIxXdCOt9VuMmVLq6cHqvIiMsChboufDYl4GOfz5ogPN3CHb6JLn8IMrl+ARSuY1J0bvc0A2GZ/e7SpTzkhQ00sA+mIFoJD3k9S86PkqLvfavhP+PvfuNnYif/8WaxVqBz+FywkGE4y+QlC3pZvnjk97z+21cW9TsK5XSg9EJinBrmh773VKyHHHlTfvRUiNzNZzPXswyzaattisszSTNnjSNjFGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oN/7B0ks; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oN/7B0ks;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gknZj6R53z2yqw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 11:30:53 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N0mRCR550865;
	Tue, 23 Jun 2026 01:30:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lUcHaQeyG0kbFMmXJ
	Gyu7uR1kpkah6YkBgOsj+50H+g=; b=oN/7B0ks2/EZkP37RjNLxI6SLfEa37WTp
	Mz9Is/1NFpISTp3tsNdYoT++iuj4RGkymlJqFZQSa0LSXJfS08/BJ/ZYSu6FtElK
	Nqi07TCNGVrcuLGukg29T8YHGhDwDjNvwejd6O6NHBqAkH6ZQzihKMZ9A0ROT4q0
	l1kD9Hjs3uf9D8ST17tK3zL+dgC3VTVmn8avOIU3SOlhlZBd3ufqqnYPLpDxc+8Y
	J6/ZeWdRp2k4VlkJXcEVNh+bwEHfODi6RMuc8cPGDsMX1qCfla0CVLcTAXsP7zsT
	IlqUjZlCBK0Y7wYAMB2dZ42lWqgZH4M2XEemF3csqgC5UnA41GhKQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhqm1s8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 01:30:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65N1JhxY014684;
	Tue, 23 Jun 2026 01:30:49 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6ph8vm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 01:30:49 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65N1UFAn53936404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 01:30:15 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D52758062;
	Tue, 23 Jun 2026 01:30:47 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 095FA5805A;
	Tue, 23 Jun 2026 01:30:47 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.188.206])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 01:30:46 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH 13/29] ibmvfc: add NVMe/FC Port Login support
Date: Mon, 22 Jun 2026 18:30:19 -0700
Message-ID: <20260623013035.3436640-14-tyreld@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a39e1ca cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=6rG7Qs-5UubFV84h7OMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDAwOCBTYWx0ZWRfX/9HCxXJ03zg7
 0u0UNbkCb60ytlAfGrtrI5hyUSG/Wj/5uDPORUemdXOQhBLWuOBqdHzw7iigdfTDwcoXTLgFgRw
 PtY6oaVDX90jDzB56nDjByzGOwHSSYWa4eXNmerNJMV9eNXE0rxrrco94ixwYcV6OK9eRYpnsSQ
 ii5evvL72zfXwuBWejDC+/tY+nL00AAWPrVnxFhk1FJyJxL9CdAZbt9wrP4utw1tTxUI4hXajIG
 HazKfdSRpcPQWI8JlUrxdLo9AYTFAzHKeJtzmmefqb6ONoSutEHLZ6iE63W8BoK8BoGG2Q4LO8X
 atqoDbmX8rGLmFtQydlR5ageLDI1T3cb8QTfnhYPOeS7ph/F1AEYzfp0agUfsTxoNebsigIBatC
 mG8QyuaX3F4buHRFPgIGYNfKSL8qEl5Po2cRtEEOvQ5x6nJ2+UCIuGCOi645wx2oS1q352SwzRO
 MRMYnw1psJRx/lmkN9g==
X-Proofpoint-GUID: RyhtUiyP8rcXyedkmvpJbUHrgxzrPUqt
X-Proofpoint-ORIG-GUID: RyhtUiyP8rcXyedkmvpJbUHrgxzrPUqt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDAwOCBTYWx0ZWRfX1NqtprH4si3s
 RwH1XyEZJSNry2XSUs5le3eH84lyNpP3qDCCFTh5gtEfYn9XyFqK3XyjhqasqMemz0CZ7dL/BrT
 QdqqjY4K9UrBrxbrR565tWEY9XSlFUY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230008

Expand the target login path to issue the NVMe/FC-specific port login
MAD for NVMe targets.

Select the correct PLOGI MAD opcode based on the target protocol and
include the protocol name in success and failure logging. The rest of
the target login flow remains shared with the existing SCSI
implementation.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 3e3d77e0d517..2c54d0b9add4 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -4210,7 +4210,7 @@ static void ibmvfc_tgt_plogi_done(struct ibmvfc_event *evt)
 	ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_NONE);
 	switch (status) {
 	case IBMVFC_MAD_SUCCESS:
-		tgt_dbg(tgt, "Port Login succeeded\n");
+		tgt_dbg(tgt, "%s Port Login succeeded\n", proto_type[tgt->protocol]);
 		if (tgt->ids.port_name &&
 		    tgt->ids.port_name != wwn_to_u64(rsp->service_parms.port_name)) {
 			vhost->reinit = 1;
@@ -4238,9 +4238,9 @@ static void ibmvfc_tgt_plogi_done(struct ibmvfc_event *evt)
 		else
 			ibmvfc_del_tgt(tgt);
 
-		tgt_log(tgt, level, "Port Login failed: %s (%x:%x) %s (%x) %s (%x) rc=0x%02X\n",
-			ibmvfc_get_cmd_error(be16_to_cpu(rsp->status), be16_to_cpu(rsp->error)),
-					     be16_to_cpu(rsp->status), be16_to_cpu(rsp->error),
+		tgt_log(tgt, level, "%s Port Login failed: %s (%x:%x) %s (%x) %s (%x) rc=0x%02X\n",
+			proto_type[tgt->protocol], ibmvfc_get_cmd_error(be16_to_cpu(rsp->status),
+			be16_to_cpu(rsp->error)), be16_to_cpu(rsp->status), be16_to_cpu(rsp->error),
 			ibmvfc_get_fc_type(be16_to_cpu(rsp->fc_type)), be16_to_cpu(rsp->fc_type),
 			ibmvfc_get_ls_explain(be16_to_cpu(rsp->fc_explain)), be16_to_cpu(rsp->fc_explain), status);
 		break;
@@ -4286,7 +4286,10 @@ static void ibmvfc_tgt_send_plogi(struct ibmvfc_target *tgt)
 	} else {
 		plogi->common.version = cpu_to_be32(1);
 	}
-	plogi->common.opcode = cpu_to_be32(IBMVFC_PORT_LOGIN);
+	if (tgt->protocol == IBMVFC_PROTO_SCSI)
+		plogi->common.opcode = cpu_to_be32(IBMVFC_PORT_LOGIN);
+	else
+		plogi->common.opcode = cpu_to_be32(IBMVFC_NVMF_PORT_LOGIN);
 	plogi->common.length = cpu_to_be16(sizeof(*plogi));
 	plogi->scsi_id = cpu_to_be64(tgt->scsi_id);
 
@@ -4295,7 +4298,7 @@ static void ibmvfc_tgt_send_plogi(struct ibmvfc_target *tgt)
 		ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_NONE);
 		kref_put(&tgt->kref, ibmvfc_release_tgt);
 	} else
-		tgt_dbg(tgt, "Sent port login\n");
+		tgt_dbg(tgt, "Sent %s port login\n", proto_type[tgt->protocol]);
 }
 
 /**
-- 
2.54.0


