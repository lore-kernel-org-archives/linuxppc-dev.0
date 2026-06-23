Return-Path: <linuxppc-dev+bounces-22911-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49606CDB466
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2026 01:33:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gknb33Lmsz3cjQ;
	Tue, 23 Jun 2026 11:31:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782178270;
	cv=none; b=UmX2qYOTiBDWCWNMy4p56uvApOeSqnXVk/KKByyZDsL7r4z8YbR2b7/a5W+g6UOCCeHIPOVjzYRJ2j0o/84bvzcGcYQyHErLzonxnfvj5JF7fFs3BGn2edb6JmG+KYDnPcRAbMcZ4mYipIfgU5Cp/lTn5SLezGElToO6bNrZdNKnIezbnBxmcuvKtjzUG4YX8fxTIgRIoKzn30SmA4r8hkom1S9txqUK28MzeZ57P1YxCMKUp75BbYMQtinndhcCiXTrnLeOy+dSQL2pDB7BvH5cLWpUpStwtmjV5Ud2ATiduvMmGYNAabvOiupZf3m0TtekZTXwnFYGpf95qEIwpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782178270; c=relaxed/relaxed;
	bh=MIGvv0x+i38/isd9z979ZoHfy5N7Sea5AWurFece3BI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oC1DoKKehaycy+8daojTEj/fyPRzd8lQcU27RFFbD3jzWiv7LDKv8eDKuAlznD8TkX7LcndRcXCnGIPBVzvPSI4KWf7pmhdQLouvgVPcsDigtAIB0AYUaqVHrDuZKz4ers8W1rwG4lyx36+1rRqAqRPXcZ5DRLIdqOTU+GM9b2i/eUYPHIhM/HZZsd0SyymBGcCizeaJBqXcWtzLWLLUkp3gUJED1SGSXkjVHUjHM3fmuLOQ889o6j2xKkiUoivjtth1SN8ldfUrgfjza5wTyOVpBUhOHRTKRGJu9ZwJSAQNZpkWFkq/ZrPOSdMI7mP6WRD/RIszyAp5QGtj2kktwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=isW0hxGM; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=isW0hxGM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gknZv3XXhz30Tc
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 11:31:03 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N0nK79283967;
	Tue, 23 Jun 2026 01:31:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=MIGvv0x+i38/isd9z
	979ZoHfy5N7Sea5AWurFece3BI=; b=isW0hxGMRXQ9gXG/ygdSGF0A0vEBP0JuZ
	pAXqJo6NMTh8M6T3fPtQtimpznJXMzmo2WY0ZVWXDveEsgvKL3cq4tIw4FkxObiI
	T7FifU0QU5fsJ9DcsWWwErj5NzzA2U98r0lj4Gw19iqVHUmC9aF9o6fbwAtf3WkL
	UNiixlLaOYYJKY2bAHkxAy5Ns0GJIx7svzY9AwrJ7f4QfQ7e98ygsfaJcLjtNvug
	W9QQ2qOCmrrP7Gk9+lK526T4wAuSHOzMOMBBJcjMmFJ/wy6i/sGJ9h9JXdxjxkA9
	whUp+XidLg1sOZrm6xVetobZZdfp5LUA4bM9Z3sol2EcussKyfXOg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgskysd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 01:31:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65N1K360018524;
	Tue, 23 Jun 2026 01:31:00 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vygn49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 01:31:00 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65N1UwGA4785100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 01:30:58 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AB9E58052;
	Tue, 23 Jun 2026 01:30:58 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEA4558056;
	Tue, 23 Jun 2026 01:30:57 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.188.206])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 01:30:57 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH 28/29] ibmvfc: implement nvme-fc FCP abort callback
Date: Mon, 22 Jun 2026 18:30:34 -0700
Message-ID: <20260623013035.3436640-29-tyreld@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDAwOCBTYWx0ZWRfX6ooZhG2bYB0v
 Eky4IE5KnImJTsFR81j1utGaviAP+G72nZn5REL8D6e/2jOHy2wmVl2O/T05wPPFLn2V4qx2P7N
 YNaSwIQ9KL0cHfsw3CKo/K2n+af14Pj+dMBTiv4EmkUzwXLGhQxDWUAQF6iEkY8H0jm/nN/Gh2e
 Yr4vRz7uPMN9XBaKGORSGkzZKNAm/vFgyKZUHRj2BFHDky/azlSQB9Werg7JG/1pLcxy6Ds/a/H
 0HkrknhSX18sLpP2TsPDp7asXoZZgFWCltypt3GlSBydKYbunuYBJeLr+fX+UAvbdhR90m/8vPl
 YK7R7ROlaU/larZCopBN0u4p4nRhd7xtrhR4HgW7dCl2oFFap6L8DzH5aqQf7yDEn9C1/NC+KP5
 rDyOQCTFTFO2vKTIFwWavEHepCf2FEIup1EhW9b6/qS3jo3pnhcHXof/xydn9WpxNohY+xMJ4f6
 T9LOQfyYEqSm5ycw9CQ==
X-Proofpoint-GUID: m3B6AJr8UOQUkUAVzggnkIq4TyzEW4mV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDAwOCBTYWx0ZWRfXyKobDUy8z2qV
 M4pG4XLdoDfFiO0eZX2E+7h7LMP5iRI5NM4/A+MEZPrclu9mZfLO1DQ4DADv5n5ZD/FUZTx6V99
 Pb9bpVls68b+8bmDpIzbKH7NPtntZfw=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a39e1d5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=W5rK7oR1aN-uH6BT3QgA:9
X-Proofpoint-ORIG-GUID: m3B6AJr8UOQUkUAVzggnkIq4TyzEW4mV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230008

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
index 18e8657abc44..92937f9aa464 100644
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
2.54.0


