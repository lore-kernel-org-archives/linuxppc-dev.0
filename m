Return-Path: <linuxppc-dev+bounces-27515-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12892C982C9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 23:09:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlZN002JQz2yr0;
	Thu, 17 Sep 2026 09:09:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789600175;
	cv=none; b=c2BN0gK/iQT6UdfFroBoD3OZUFJbvXJ8yng4aCFVnKmClpMqH8Mxm9IivlZvKKcRLc7l/mgx89kb01xTHXhoeKshU+QQ2PeN/ROdLBqmq/ap2x1eiDHK9T+14U4mwu2nTsj78CR3akLKdDYM1G+zd4UD092t6SYN8YAoZJOUZG1yTNsvgKleF90tS5pAHahrnJK5u2pbda086iKT/BqAChpNp8DuDHTZR4jQkGP7NvRojGTF4B4wWGP42zmKAS9c5a8/HD4yKiIzjoChanxjHiZmm99Qcsx4k8GLRljC49jntysgR8OdELPv9B2nSD/DoGgvXg8tcd4OI7kvR1Gqdw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789600175; c=relaxed/relaxed;
	bh=z0kqp0MahhEkDHyt5qR/Mq5RMXsM3Fgey5/W5u12EiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UD/H6zm3QGPXYg+W750F7rkNPVsV0uY1raPrgDVyjfAhVWdekdAMc5wdHG7rG/mX/42rO7CzuBHv4sywNW6IeN2Xh4EBx6sb8OJfdnAQwqLvJmPFDNHoLuvdXBMcN9txMMBaJFgFF1AQOfb11DTNIPxUnkM08LWjBWuzSfq0tyUWqAjJLfZ6+fznDoPugFabRZqL7CGowGCMcGY0cRYd12CqUUXgJ9RqvGGpz2A7kROQx//PEBa8Om+IhEiLKJU+Isrek7Hp6NP86JDdRkTB8DWndiGV7BhLicYg8SnsRknrBwtB/9EHcPMcnWK+kSFPGCq9ckodUCOHpN3AVp2lxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ATxxqcSu; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ATxxqcSu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlZMy55MYz2ygW
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 09:09:34 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GG1QSL017615;
	Wed, 16 Sep 2026 23:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=z0kqp0MahhEkDHyt5
	qR/Mq5RMXsM3Fgey5/W5u12EiI=; b=ATxxqcSuC4kcdQgziReRPTtANJga+cfSb
	j0tXUTcaltMCJGrdpt201oabiWtI5+FjhUEnlpiYTq/NoqVJtKGWsGeFtAHUPP+g
	0nHa6K0JO8DmwJfe1McDVymt/cDR/7DBuImmR8XfM2JbqCTqrosARjorRdPKByz6
	71SCg0L5/oQHfB6gp/8csas5D0coTOR4rbJURu+HUojv4SlpqHq79DEj26HLsj6h
	NJBynvl6LmN7UIC1qU2+VkvgGz/YP7ivHDx8qQDg1mtuwZjMvilUluYpqtUyPAW9
	98+6jqMBR5FSnxxbQ4eamXfOWywdZjG5Qixj8B02PRWW8W41r2JZg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf57dwx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 23:09:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68GN2GYu1625352;
	Wed, 16 Sep 2026 23:09:30 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gpyxsgw6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 23:09:30 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68GN9TbA51511670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 23:09:29 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A2295804E;
	Wed, 16 Sep 2026 23:09:29 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B23058064;
	Wed, 16 Sep 2026 23:09:28 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.141.190])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Sep 2026 23:09:28 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH 02/20] scsi: ibmvfc: fix trace logging for NVMe FCP commands
Date: Wed, 16 Sep 2026 16:09:03 -0700
Message-ID: <20260916230921.2204729-3-tyreld@linux.ibm.com>
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
X-Proofpoint-GUID: _QEA5SHzISShg65lVIvzQOiHDFn-qN-y
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDMyMiBTYWx0ZWRfX+PvITezOk+CN
 PhU/HXQ/xOwG/iLPk9lS+aaC+lfSkNC5V/BWOcNVmXbDE7CYrTNF7pu/nWz+xOD9pHq1JMLbW+2
 5Yli9ocn2E0huHG8m0MLJK2d0LZpqkk=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aab21ab cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=fF8LTD-R--w6NU_6X2kA:9
X-Proofpoint-ORIG-GUID: _QEA5SHzISShg65lVIvzQOiHDFn-qN-y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDMyMiBTYWx0ZWRfX7FWvv7aX62hw
 RmUxI52OCzcl95qwxfq2QNoEai1Nhkt0vnglf6lXvIx5Xw+asV/s6VNm35ht4I+RGL1uWMf1+TY
 fgA9KlnLdM0vGQOg8rHNrda9VYJlnDpfzqrHVrSw3l7CP15ycSoP39GnqZxJaqw3/v1B88EEXqF
 oF5f96IkBECA6EaHTcZmTWX2fflDixtYMO/W1gv8tllv13xcpRNTMvotE6Eyo27KU7LCWbk32N0
 flzZuhXX3yhj10qHZj25KvGQp+bAHtnC3RUmy0U48791Llm+lZJN0FyJRD+p/NkT7KcRKPiNlB8
 aYh2VPI5qLAMcxtwZgmR3CFkJ4d0cpnGmVBLrHRWM6uhchEtriDlLCbzjJ0voZYWNJDrNqbb0zq
 11XfUFiHWW5AM3XKnoXUUFxU5wW+KqpvBTUKPg7HFbkkzn5IclaOhVq7JFWsDKC1Lw5w/AP+/Yk
 H86Ai29yYAXTpEQnzGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160322

ibmvfc_trc_start() and ibmvfc_trc_end() handle IBMVFC_CMD_FORMAT events
by reading SCSI-specific fields via ibmvfc_get_fcp_iu() and
ibmvfc_get_fcp_rsp(). These helpers return a pointer into the v3scsi
union member of struct ibmvfc_cmd, but NVMe FCP commands store their
command IU in the v3nvme union member. Reading SCSI FCP fields out of an
NVMe IU produces garbage trace entries (wrong opcode, lun, tmf_flags,
xfer_len, rsp_code, and scsi_status).

Fix this by gating the SCSI-specific field reads on evt->cmnd within the
IBMVFC_CMD_FORMAT branch. For NVMe FCP events (evt->fcp_req set) record
the NVMe SQE opcode from v3nvme.iu.sqe.common.opcode and the payload
length from vfc_cmd->payload_len. The common fields that are valid for
both protocols (tgt_scsi_id, vfc_cmd->status, vfc_cmd->error) are
logged unconditionally.

Fixes: 73c13e30c56f ("scsi: ibmvfc: implement nvme-fc IO command submission callback")
Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index aa7ae81df41b..6c243b2a84d7 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -257,11 +257,16 @@ static void ibmvfc_trc_start(struct ibmvfc_event *evt)
 
 	switch (entry->fmt) {
 	case IBMVFC_CMD_FORMAT:
-		entry->op_code = iu->cdb[0];
 		entry->scsi_id = be64_to_cpu(vfc_cmd->tgt_scsi_id);
-		entry->lun = scsilun_to_int(&iu->lun);
-		entry->tmf_flags = iu->tmf_flags;
-		entry->u.start.xfer_len = be32_to_cpu(iu->xfer_len);
+		if (evt->cmnd) {
+			entry->op_code = iu->cdb[0];
+			entry->lun = scsilun_to_int(&iu->lun);
+			entry->tmf_flags = iu->tmf_flags;
+			entry->u.start.xfer_len = be32_to_cpu(iu->xfer_len);
+		} else if (evt->fcp_req) {
+			entry->op_code = vfc_cmd->v3nvme.iu.sqe.common.opcode;
+			entry->u.start.xfer_len = be32_to_cpu(vfc_cmd->payload_len);
+		}
 		break;
 	case IBMVFC_MAD_FORMAT:
 		entry->op_code = be32_to_cpu(mad->opcode);
@@ -294,15 +299,19 @@ static void ibmvfc_trc_end(struct ibmvfc_event *evt)
 
 	switch (entry->fmt) {
 	case IBMVFC_CMD_FORMAT:
-		entry->op_code = iu->cdb[0];
 		entry->scsi_id = be64_to_cpu(vfc_cmd->tgt_scsi_id);
-		entry->lun = scsilun_to_int(&iu->lun);
-		entry->tmf_flags = iu->tmf_flags;
 		entry->u.end.status = be16_to_cpu(vfc_cmd->status);
 		entry->u.end.error = be16_to_cpu(vfc_cmd->error);
-		entry->u.end.fcp_rsp_flags = rsp->flags;
-		entry->u.end.rsp_code = rsp->data.info.rsp_code;
-		entry->u.end.scsi_status = rsp->scsi_status;
+		if (evt->cmnd) {
+			entry->op_code = iu->cdb[0];
+			entry->lun = scsilun_to_int(&iu->lun);
+			entry->tmf_flags = iu->tmf_flags;
+			entry->u.end.fcp_rsp_flags = rsp->flags;
+			entry->u.end.rsp_code = rsp->data.info.rsp_code;
+			entry->u.end.scsi_status = rsp->scsi_status;
+		} else if (evt->fcp_req) {
+			entry->op_code = vfc_cmd->v3nvme.iu.sqe.common.opcode;
+		}
 		break;
 	case IBMVFC_MAD_FORMAT:
 		entry->op_code = be32_to_cpu(mad->opcode);
-- 
2.55.0


