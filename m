Return-Path: <linuxppc-dev+bounces-24688-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57798C44536
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 00:25:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5Bj767sRz2yYf;
	Thu, 23 Jul 2026 10:25:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784766315;
	cv=none; b=e6EI8xueGZkCEJWf4JkifBSHuaR1iiJGsnmVJZAIilNcS7OlSf0I0OE2RPkpp3wEDyHWOCie+PX84NDc1roEB6g/5ZE+IxH6aqDqSgEwDZYAiUrxLZPJqMzqXxikg7WmASuvrDzVEPoxkEiunLmEF3OxZv1OGHfXvNDzh2rhpoh2Rqsl3U7feFLUmuius7KuDyw/FpbWbd+Uysf7It/6jrWlo+HxJNOfpcjQsES7OqSTCcmE+J+Pz7r0noPy6AbcmNmIOdysBFUyK36GloDckzvy5bKB3vE9qg7C13Eka8yGeDFGq4w35PBww3YqNjIb5P+cSPa+uYRJzmfQemvsjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784766315; c=relaxed/relaxed;
	bh=q3PyX5uAvJzWDGOZDK/aFRn8uHaaymV9uPnomy/8vsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g8mg0Lk3aTyBBuVTlfT8t6ssOhEdrQhJORGWvKf2dJtU9oUJyiT9GO/Saxf/9SwJ5ey1lArKvE3HbEvhyYT58/lP6hnBKPzi1WEvokBAUM/zLl/+B3uF9mZZBJFEG6gVhYPYJkCzxNwmQR58LaMgcVGDmmoBMLCUS3cJo62I0q57d04nTRCpLYVs0Ny+OWacZZWIqf3Isd0pZsnU6FqJ9GmrHJwPgRBXBp8tt4WNpCF1xWfpDlTOnz86Yhc9FuzNR6f62gfrg1TbhmIjT3pN6G6annlzDFu59hohMzex+xlullBwXQOE6Bu/Gd6EMnhS73ox/Yq0j/7s5ke+rP1KDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hidsOZGN; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hidsOZGN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5Bj66rcMz2y32
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 10:25:14 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MIC0gr713614;
	Thu, 23 Jul 2026 00:02:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=q3PyX5uAvJzWDGOZD
	K/aFRn8uHaaymV9uPnomy/8vsY=; b=hidsOZGNZ8GxihaHEwxvaK88+1GbnhCzG
	F/du/tBy7aeHGQzgJQq9jPN9d1PHUyd9DVZXUJOfWytIVGC/UbJW3hAuJ5Iy3QUr
	OrTILZwCluvkUdUhS1WlA0o+J+FabZ4TUADIjITdPO+SfVNuzzJX3H5SUxhNgfPf
	3eercrMWDDD47b7L8xLQpJKZdvg0os/OXGKETvqNYF6PDU2bc7cUnMpZ9/6w0UKe
	hLK+HnYjeilTOcplMwXuDvkOWpGab8f9KOg3Rz1neXX05cJlIPzoe1JQvC3+g5m/
	jbMFpUgie83Cyid07di9EK7CTX9ddiSfjnpCdUdHSdIo+sBII7Adw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahcctx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 00:02:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MNndSa009395;
	Thu, 23 Jul 2026 00:02:20 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1ghjbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 00:02:19 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66N01gSw31457860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 00:01:42 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 03F1C5805A;
	Thu, 23 Jul 2026 00:02:18 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 552C058056;
	Thu, 23 Jul 2026 00:02:17 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.118.58])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 00:02:17 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH v2 32/33] ibmvfc: implement nvme-fc FCP abort callback
Date: Wed, 22 Jul 2026 17:01:48 -0700
Message-ID: <20260723000149.969416-33-tyreld@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: DSUnyEVP1h1HGt9hAEZp0povFfXn-FyI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDIzNCBTYWx0ZWRfX+yBbmpD78ZFo
 ePSFegKI4qBTTo8XXPPiHXdSMwYEHbXdpsrcM2YpKZfepr1pJ2I24ys34NjdRu4OlHyyQq4XGWw
 L7bvJoRu0ZS15ImktB4EPVYkwSRtNeS1HNxBt6VMeogiN1NCttw3csEJ5seWna6NLb5zvamrMHX
 ZDO1UAu/BzYrBIfwPzVhFMtUToN5eLumWyiwqe924VN650+06dcf+QsO7Oazcn7gchVsCXHYFQI
 zl5EmQQH5CrtoHbQTdrUNgHr0XpcZVUFxw15baxhHac6Cih3BqRcWKpa8tJUqMe5jwdhLrQvUXc
 UHR6jglpYdGLCm7ayacgiwp3IDl7RchKbIDw1c47+NWS8iVid9lPbbRmbqsEr6c5dpaC3626nqP
 0tAIKb6i56P4CK810Ni0vhfbkdoHmDpBRYwRjbfYhjza8zXzwKz+JXt5pAMnna5SiF+QeKA+XNN
 E0nl182w5rBdb/du43Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDIzNCBTYWx0ZWRfXywbt0N60JQXt
 HmPiQD4+zETWcMPxfUMpt15r2p52uOd034328W6pyFQNKouiYV4f4KAOeIybhyQH3LtSP5Pwx1P
 WibXB4M4LNIoKUsWxufWFjai1BjMJs0=
X-Proofpoint-GUID: DSUnyEVP1h1HGt9hAEZp0povFfXn-FyI
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a615a0c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=W5rK7oR1aN-uH6BT3QgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220234

Implement the NVMe-FC FCP abort callback by issuing an NVMF cancel MAD
on the same submission queue used by the original FCP request.

Use the original request event stored in abort_req->private to recover
the associated ibmvfc queue, then allocate a new event from that queue
so the cancel is sent on the matching nvme_scrq. Factor the TMF setup
into a dedicated helper, mirroring the LS abort path, and populate the
cancel key, task tag, target WWPN, and association ID needed for the
VIOS NVMF abort request.

The abort path sends the cancel synchronously, waits for completion,
frees the temporary event, and logs non-zero MAD status values for
debugging.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-nvme.c | 64 +++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-nvme.c b/drivers/scsi/ibmvscsi/ibmvfc-nvme.c
index 390410e44f0d..54f80b6265d4 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-nvme.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-nvme.c
@@ -374,11 +374,75 @@ static int ibmvfc_nvme_fcp_io(struct nvme_fc_local_port *lport,
 	return rc;
 }
 
+static void ibmvfc_init_fcp_abort(struct ibmvfc_event *evt,
+				  struct nvmefc_fcp_req *abort_req)
+{
+	struct ibmvfc_tmf *tmf;
+	struct ibmvfc_event *abt_evt = abort_req->private;
+	struct ibmvfc_target *tgt = abt_evt->tgt;
+
+	tmf = &evt->iu.tmf;
+	memset(tmf, 0, sizeof(*tmf));
+	tmf->common.version = cpu_to_be32(2);
+	tmf->common.opcode = cpu_to_be32(IBMVFC_NVMF_TMF_MAD);
+	tmf->common.length = cpu_to_be16(sizeof(*tmf));
+	tmf->flags = cpu_to_be32(IBMVFC_TMF_ABORT_TASK | IBMVFC_TMF_NVMF_ASSOC);
+	tmf->cancel_key = cpu_to_be32((u64)abt_evt);
+	tmf->my_cancel_key = cpu_to_be32((u64)evt);
+	tmf->target_wwpn = cpu_to_be64(tgt->wwpn);
+	tmf->assoc_id = cpu_to_be64(tgt->assoc_id);
+	tmf->task_tag = cpu_to_be64((u64)abt_evt);
+
+	init_completion(&evt->comp);
+}
+
 static void ibmvfc_nvme_fcp_abort(struct nvme_fc_local_port *lport,
 				  struct nvme_fc_remote_port *rport,
 				  void *hw_queue_handle,
 				  struct nvmefc_fcp_req *abort_req)
 {
+	struct ibmvfc_host *vhost = lport->private;
+	struct ibmvfc_target *tgt = rport->private;
+	struct ibmvfc_event *evt, *abt_evt = abort_req->private;
+	struct ibmvfc_queue *queue;
+	union ibmvfc_iu rsp;
+	unsigned long flags;
+	u16 status = 0;
+
+	if (!abt_evt)
+		return;
+
+	queue = abt_evt->queue;
+	if (!vhost->logged_in || !queue)
+		return;
+
+	evt = ibmvfc_get_event(queue);
+	if (!evt)
+		return;
+
+	spin_lock_irqsave(queue->q_lock, flags);
+	kref_get(&tgt->kref);
+	ibmvfc_init_event(evt, ibmvfc_sync_nvme_completion, IBMVFC_MAD_FORMAT);
+	ibmvfc_init_fcp_abort(evt, abort_req);
+	evt->sync_iu = &rsp;
+
+	if (ibmvfc_send_event(evt, vhost, default_timeout))
+		goto out;
+
+	spin_unlock_irqrestore(queue->q_lock, flags);
+
+	wait_for_completion(&evt->comp);
+	status = be16_to_cpu(rsp.mad_common.status);
+
+	spin_lock_irqsave(queue->q_lock, flags);
+	ibmvfc_free_event(evt);
+out:
+	spin_unlock_irqrestore(queue->q_lock, flags);
+
+	if (status)
+		ibmvfc_dbg(vhost, "fcp_abort: cancel failed with rc=%x\n", status);
+
+	kref_put(&tgt->kref, ibmvfc_release_tgt);
 }
 
 static struct nvme_fc_port_template ibmvfc_nvme_fc_transport = {
-- 
2.55.0


