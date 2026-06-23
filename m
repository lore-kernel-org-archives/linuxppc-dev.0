Return-Path: <linuxppc-dev+bounces-22910-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33375CDB46F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2026 01:33:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gknb32kyZz3cj9;
	Tue, 23 Jun 2026 11:31:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782178269;
	cv=none; b=erKMnNBlIF2YBbqICX+xcNI6K4BsDFW6LpLSMDldvc29y9co6r29LOvxDB5hZgnubmRyYTxo3yD7UCX/mzfnQrZ9tUdpw9uLhrTjLqGxwoxcMsbPvJG6E89h8RDqKVYD4171tRCPirL3uFP8ucWLDxqM5h1JTF8rFax8LyGAFL+6s7vhLSAKVMnaG/Vj/DELaAacb4iFYjNDkSSuHc8pqc39CECd/X+Ta3Xmk46tx8evWowlxYamTfd77xPxNyLureeNrusyslkn3ph/WIwjJXZ6ZpiqThbYk9xO2GMKYxKXQ0shhqx00fuvqiHuTsHKrSUlbxhNZq0+QDll9D/aWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782178269; c=relaxed/relaxed;
	bh=LejKE+J5X2I6kcE7ibbu1nmLcQt3872qxP1YbQoHDGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U01F4PpLnOS/GQ58FyeJ842uTkwF74BbGx2yvCW2VZEYXMxblmWsSXpJF42otDqb4XUSTHww5LDiLVGDIqOFFdK7KUtJX4vriByrWSu4b3ZpUjkt8jnWTTXSemULCVHMZUdZcR9sv5pT5j8e8iB4yk4GlbAnRLn9DXGc2MeiqupF1+DvyMJ7agZYxxaBWYGJxLj/du1pJFrBKdSUf3pIG3stWeIVJCbCDVxuhA1pYYIqoLYgoEwq0Crk+8m7aO3Dv+zd3DIWc5oBl7LmRy06+PaH+HuxNdzsw75BsBqW9bfEOobDO0EXdNgZel7jFadxyJOrqQwnIx3J7okcsmnTfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=H2osm/d3; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=H2osm/d3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gknZr4whSz305P
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 11:31:00 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N0nZAD347451;
	Tue, 23 Jun 2026 01:30:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=LejKE+J5X2I6kcE7i
	bbu1nmLcQt3872qxP1YbQoHDGE=; b=H2osm/d36JLd7A2DLZpHb7A41XB0YbiRo
	1qthiQ/vQ319HLVVmS5We8Y/G4146RNfqIDvAgKA+Hnk/6UQZFoeYnmI8yRsi4dS
	iuAfxguK4VAEAkFv6Yz36+LkbhQQjjuHxSGVzNTbNJHmgXTDp1EbdximLL1fSDhv
	8Bo+6NVyJ5St6I40f8VJt0cl2PBtaQMMEZNGP0KMKVa103j5Wbb0+6BTOBjXozHg
	L77YGm9twFVAQAVlPn0LTlOAbLgltq0qYwWM6i+JU2FvPI/aA6MT9Zwb8NnLb2/t
	ZZBDf1PdEplcMDg94GSpfzYZ5Q3sL2+TJujBIruvKPmGHr7K1y6Ow==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewh9gc43p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 01:30:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65N1K2rM026922;
	Tue, 23 Jun 2026 01:30:57 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7dg0qwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 01:30:57 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65N1UuVj2425502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 01:30:56 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A85758052;
	Tue, 23 Jun 2026 01:30:56 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A80FD58063;
	Tue, 23 Jun 2026 01:30:55 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.188.206])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 01:30:55 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH 25/29] ibmvfc: implement nvme-fc LS submission transport callback
Date: Mon, 22 Jun 2026 18:30:31 -0700
Message-ID: <20260623013035.3436640-26-tyreld@linux.ibm.com>
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
X-Proofpoint-GUID: zIj0-5ZcinmMpoTmZHQyIFyi02EVM7bd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDAwOCBTYWx0ZWRfX9sX0an+zYqT3
 ffwYyonSgm4PTsUUA2YgUvYhqaBgyPkvVhyPF0NiVBvlBUvGg+IhcHT4zPjSeUbtjZkIRNu5QwE
 UySwhFbTzVbFB0F6SuH/msbJR4PA00k=
X-Authority-Analysis: v=2.4 cv=c62bhx9l c=1 sm=1 tr=0 ts=6a39e1d2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=NuzgT4qAQ9w6WZqWKkYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDAwOCBTYWx0ZWRfX979AicChhiix
 DJTOxVk6NCE+BD9amO7M0ht0EZWx3wbIe8EJ440ByG6YGLaQ9ZBE8a0MkPLGM6gOwWJu9NtOGCN
 HTw1IX3Pv8MYgDanNOlL/FLxSGteXnz40GJ5KzmTjlOwugXrvuAzWXXUvnkU8UUv0AW4uRjtwiX
 UGvAVC97NknUDnjZwAB4nBPh5OwbHdX5CRKevTllOhcTsl2y8yb0eupbeaO9+QX28AkSo9sCOzk
 +j5zjOeP9A9+6UGKxyMyiE+cBFwIBKSAgmVjZJrfhVZItNQAVFeYafhi/cyu9OOtColMM4djAQI
 FNcwLega3mslEgGdK6W7UylPZQpTykw5A3y7oy0YdCscArds1BwDEYFjajrDDOX5jsYVN1frMct
 ss54HcUZOUu9fWiO1jTcjcFOZW/NQdFmxg1j9iuvbr0QhjXO9vWumo1MSATYXUcVOpRQnYSMJxH
 RRXOInm6R4i3rg0MDYw==
X-Proofpoint-ORIG-GUID: zIj0-5ZcinmMpoTmZHQyIFyi02EVM7bd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230008

NVMe FC Link Service commands are required to use the ibmvfc_passthru
MAD. Initialize a pssthru mad for the target port including the DMA
addresses for the FC4_LS request and response as well as the max length
of each IU as provided in the nvmefc_ls_req struct. FC4_LS commands are
sent via the primary CRQ. Further, store the assoc_id during a create
association request as this is a required field in our vfc_cmd struct
for nvme_fcp_io commands.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-nvme.c | 89 +++++++++++++++++++++++++++++
 drivers/scsi/ibmvscsi/ibmvfc-nvme.h |  8 +++
 drivers/scsi/ibmvscsi/ibmvfc.h      |  2 +
 3 files changed, 99 insertions(+)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-nvme.c b/drivers/scsi/ibmvscsi/ibmvfc-nvme.c
index 1108d11d6b2d..506135c1a34e 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-nvme.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-nvme.c
@@ -62,10 +62,99 @@ static void ibmvfc_nvme_delete_queue(struct nvme_fc_local_port *lport, unsigned
 	kfree(handle);
 }
 
+static void ibmvfc_ls_req_done(struct ibmvfc_event *evt)
+{
+	struct ibmvfc_target *tgt = evt->tgt;
+	struct ibmvfc_passthru_mad *mad = &evt->xfer_iu->passthru;
+	struct fcnvme_ls_rqst_w0 *ls_rqst;
+	struct fcnvme_ls_cr_assoc_acc *ls_resp;
+	u32 status = be16_to_cpu(mad->common.status);
+	int rc = 0;
+
+	ls_rqst = (struct fcnvme_ls_rqst_w0 *)evt->ls_req->rqstaddr;
+	ls_resp = (struct fcnvme_ls_cr_assoc_acc *)evt->ls_req->rspaddr;
+
+	switch (status) {
+	case IBMVFC_MAD_SUCCESS:
+		tgt_dbg(tgt, "ls_req succeeded\n");
+		if ((ls_rqst->ls_cmd == FCNVME_LS_CREATE_ASSOCIATION) &&
+		    (ls_resp->hdr.w0.ls_cmd == FCNVME_LS_ACC)) {
+			tgt->assoc_id = be64_to_cpu(ls_resp->associd.association_id);
+			tgt_dbg(tgt, "assoc_id 0x%llx\n", tgt->assoc_id);
+		}
+		break;
+	case IBMVFC_MAD_DRIVER_FAILED:
+		break;
+	case IBMVFC_MAD_FAILED:
+	default:
+		tgt_info(tgt, "ls_req failed: %s (%x:%x) rc=0x%02X\n",
+			 ibmvfc_get_cmd_error(be16_to_cpu(mad->iu.status), be16_to_cpu(mad->iu.error)),
+			 be16_to_cpu(mad->iu.status), be16_to_cpu(mad->iu.error), status);
+		break;
+	}
+
+	if (status)
+		rc = -EIO;
+
+	evt->ls_req->done(evt->ls_req, rc);
+
+	kref_put(&tgt->kref, ibmvfc_release_tgt);
+	ibmvfc_free_event(evt);
+}
+
+static void ibmvfc_init_ls_req(struct ibmvfc_event *evt, struct nvmefc_ls_req *ls_req)
+{
+	struct ibmvfc_passthru_mad *mad = &evt->iu.passthru;
+
+	memset(mad, 0, sizeof(*mad));
+	mad->common.version = cpu_to_be32(2);
+	mad->common.opcode = cpu_to_be32(IBMVFC_NVMF_PASSTHRU);
+	mad->common.length = cpu_to_be16(sizeof(*mad) - sizeof(mad->fc_iu) - sizeof(mad->iu));
+	mad->cmd_ioba.va = cpu_to_be64((u64)be64_to_cpu(evt->crq.ioba) +
+				       offsetof(struct ibmvfc_passthru_mad, iu));
+	mad->cmd_ioba.len = cpu_to_be32(sizeof(mad->iu));
+	mad->iu.cmd_len = cpu_to_be32(ls_req->rqstlen);
+	mad->iu.rsp_len = cpu_to_be32(ls_req->rsplen);
+	mad->iu.cmd.va = cpu_to_be64(ls_req->rqstdma);
+	mad->iu.cmd.len = cpu_to_be32(ls_req->rqstlen);
+	mad->iu.rsp.va = cpu_to_be64(ls_req->rspdma);
+	mad->iu.rsp.len = cpu_to_be32(ls_req->rsplen);
+}
+
 static int ibmvfc_nvme_ls_req(struct nvme_fc_local_port *lport,
 			      struct nvme_fc_remote_port *rport,
 			      struct nvmefc_ls_req *ls_req)
 {
+	struct ibmvfc_host *vhost = lport->private;
+	struct ibmvfc_target *tgt = rport->private;
+	struct ibmvfc_passthru_mad *mad;
+	struct ibmvfc_event *evt;
+
+	kref_get(&tgt->kref);
+	evt = ibmvfc_get_event(&vhost->crq);
+	if (!evt) {
+		kref_put(&tgt->kref, ibmvfc_release_tgt);
+		return -EBUSY;
+	}
+
+	ibmvfc_init_event(evt, ibmvfc_ls_req_done, IBMVFC_MAD_FORMAT);
+	evt->tgt = tgt;
+	evt->ls_req = ls_req;
+	ls_req->private = evt;
+
+	ibmvfc_init_ls_req(evt, ls_req);
+	mad = &evt->iu.passthru;
+	mad->iu.flags = cpu_to_be32(IBMVFC_FC4_LS_DSC_CTRL);
+	mad->iu.scsi_id = cpu_to_be64(tgt->scsi_id);
+	mad->iu.cancel_key = cpu_to_be32((u64)evt);
+	mad->iu.target_wwpn = cpu_to_be64(tgt->wwpn);
+
+	ibmvfc_dbg(vhost, "nvme_ls_req\n");
+	if (ibmvfc_send_event(evt, vhost, IBMVFC_FC4_LS_PLUS_CANCEL_TIMEOUT)) {
+		kref_put(&tgt->kref, ibmvfc_release_tgt);
+		return -ENXIO;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/scsi/ibmvscsi/ibmvfc-nvme.h b/drivers/scsi/ibmvscsi/ibmvfc-nvme.h
index 4c6146048a6f..e245b6ed0875 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-nvme.h
+++ b/drivers/scsi/ibmvscsi/ibmvfc-nvme.h
@@ -14,6 +14,8 @@
 #include <scsi/fc/fc_fs.h>
 #include <scsi/fc/fc_els.h>
 #include <linux/nvme-fc-driver.h>
+#include <linux/nvme.h>
+#include <linux/nvme-fc.h>
 
 #include "ibmvfc.h"
 
@@ -22,10 +24,16 @@
 #define IBMVFC_MAX_NVME_QUEUES	16
 #define IBMVFC_NVME_CHANNELS	8
 
+#define IBMVFC_FC4_LS_TIMEOUT	15
+#define IBMVFC_FC4_LS_CANCEL_TIMEOUT	45
+#define IBMVFC_FC4_LS_PLUS_CANCEL_TIMEOUT	\
+	(IBMVFC_FC4_LS_TIMEOUT + IBMVFC_FC4_LS_CANCEL_TIMEOUT)
+
 extern unsigned int ibmvfc_debug;
 
 struct ibmvfc_host;
 struct ibmvfc_target;
+struct ibmvfc_queue;
 
 struct ibmvfc_nvme_qhandle {
 	unsigned int qidx;
diff --git a/drivers/scsi/ibmvscsi/ibmvfc.h b/drivers/scsi/ibmvscsi/ibmvfc.h
index ece1f379c269..9f6705e604fd 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.h
+++ b/drivers/scsi/ibmvscsi/ibmvfc.h
@@ -824,6 +824,7 @@ struct ibmvfc_target {
 	u64 scsi_id;
 	u64 wwpn;
 	u64 new_scsi_id;
+	u64 assoc_id;
 	struct fc_rport *rport;
 	int target_id;
 	enum ibmvfc_target_action action;
@@ -851,6 +852,7 @@ struct ibmvfc_event {
 	struct ibmvfc_queue *queue;
 	struct ibmvfc_target *tgt;
 	struct scsi_cmnd *cmnd;
+	struct nvmefc_ls_req *ls_req;
 	atomic_t free;
 	atomic_t active;
 	union ibmvfc_iu *xfer_iu;
-- 
2.54.0


