Return-Path: <linuxppc-dev+bounces-27527-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EFCAC982C1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 23:11:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlZNF1pndz3c8x;
	Thu, 17 Sep 2026 09:09:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789600189;
	cv=none; b=VyFVqAdutN9PZotHF2Sjfs1jVAFmy2vhLPUHxdEjCx3hu5H3TVExEVPqVkJtbPhMoRZ6yHSLqZAn2VESFR1+MQ8BfgRazCi6y4AiKT+zbDY7dSufESlLppn/uP0bYdMIco0eJzxtIuJ7jX8ELnCyKxrHGAk75Pfzb66PusvoIzLpwtSTIAqe3sU/X9wWlWW+q38rTt+JHb4TARmloG+OL2EFbcAQ5VmSlJCeYM22rIc5+nyS4jS1W82oHYUYaXRKt83jGOnx9t/S0+elFLU/hnHNRJPOGl1/Wu0E8i3zhsspxpq3kw0RFWBFCjk9Yb+zUx2niEkmGe0sjBCntkurMw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789600189; c=relaxed/relaxed;
	bh=EEuEuE0WYF2hGja20dAtbb6NKs9VnDwccw2Va5YMUlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSTV/GM/NK3ZnECWiIewCVlbMopkyL0dISzLw4zDK+ZkeHkQUyPBCytzhkdiJkD9leV5gn4W5iTrqdyy6XSGfAUppIv38ncGnZ0o9Cn8yx96M9g8I9KlTsCNwfq9nzXx+4dGknKitnQ4gPzcjJNpi0FY+v+l/RMRaMwx+mDqWChQxELZLaBFO9zL7UXA3x2Cvr6pEwtrIz1RzrI2kAzgX9+VWl6l7TurQj23tuE8ndEWUQ+XIFYnl27rEmQIvUuu4HrHiUqBkdvsOy85uN8L1MugJmGxpQw8PmyJ4+sjZ/SOfZKxTLlVCR8fMvETKkzBYaDsU7GUX3soTAdKLPTynw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hZtm0kAo; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hZtm0kAo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlZND29WLz3c5j
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 09:09:48 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GG1Vl3006701;
	Wed, 16 Sep 2026 23:09:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=EEuEuE0WYF2hGja20
	dAtbb6NKs9VnDwccw2Va5YMUlo=; b=hZtm0kAokL+N/JSUNOCvmMOpPLdVKsLxT
	46U/PHi0vOc/msxZpyQ0pQxwdBJHqcL3KI4I13YbSe8vI/TBQVs9+eb+B1Uw2vfV
	KsxDsQEswML/nDG1WBKX9qqnOcmhqoro6RoTKRqPQAArIohPyVfBxybjwFTEE3ZJ
	fvwe7iC2hRo63QITNBtDQyaA20w1EbvU+Krv61bcr/60JNGK0VcCg/7aqhXHvlEV
	P7p5/206i9oMoySm4NjyRxFlfT+/clJFToPVqr8Jtpt7gEJ/HdTTkovugEtoDBCt
	AgaYudb7tU6qjeX+WKsEdY+NklCfhUJIfT6ZiW0RoS9vS3GYx+H7g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx83ydyt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 23:09:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68GN2IAU1699595;
	Wed, 16 Sep 2026 23:09:44 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gq03vgufr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 23:09:44 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68GN9heq4719444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 23:09:43 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E39CC5804E;
	Wed, 16 Sep 2026 23:09:42 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0358458066;
	Wed, 16 Sep 2026 23:09:42 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.141.190])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Sep 2026 23:09:41 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH 14/20] scsi: ibmvfc: fix UAF and stall in NVMe LS abort callback
Date: Wed, 16 Sep 2026 16:09:15 -0700
Message-ID: <20260916230921.2204729-15-tyreld@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDMyMiBTYWx0ZWRfXxvRt7LLxO4fk
 oCNxB0/HcNk6V6sUoRiJFVm5xuKjcGXheCr4GxsNb02RVlTE+i2YRFjjBfajrXWiStDdbTOthiP
 Tewr4squ1SJyajKAXKCq0+2Ca3VyPYwup0BRArGYG61Hj6b3wvbP4TK36QFSC8wpFtDG4yy4vZV
 ravlV47TQpEwynOLhVkcvJcxC2WuUXJUb2Is2F7iYhU6uiinlFvT9/OxsoebPHwyML8nxjBwBO4
 SpBU2PdjDp74DDKpj6D3a5MvdQER6P6T62Ov/XMGXLT9Jeqpp5r+/yDHPgFJyY2V1ELKwgd+pN4
 3j154SzZgLg3jJr1Z9GSB4gli+Hdt/7Wt2FYo5x8Yg+TxbT4I5ZiOSbV2dD45oVABmW/ho21Ibu
 0tBHNyOB1rI3SzP1HfQgoMI2Du+3vNqZAIj5+9HR1Uo/CDl9fl0Q6rGoAFK7aJcCMvnAqe5CLia
 hx756L4wcsAG1EIrjKw==
X-Proofpoint-ORIG-GUID: YSDbtv1x8s2r3nj-LMWiwgUn8DGl6t2m
X-Proofpoint-GUID: YSDbtv1x8s2r3nj-LMWiwgUn8DGl6t2m
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDMyMiBTYWx0ZWRfX014pdk1roAkM
 lpV/Cq67rx1VRnlXwCggeXNazBgMgw1/mqgcB5GCCncyM3ShxTxAbdX2xjTgzmCVwyOZCldIx7k
 nud+MSxaaQHLgjsKPIjTl0O7kLNDlTg=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aab21b9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=bf3VTdwimHnaYT9JOUcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160322

Two problems in ibmvfc_nvme_ls_abort():

1. Use-after-free / stale pointer dereference.
   ibmvfc_init_ls_abort() reads abt_evt = ls_abort->private and
   immediately dereferences abt_evt->tgt.  ibmvfc_ls_req_done() calls
   ibmvfc_free_event() under host_lock, which returns the event slot to
   the pool.  If the LS completes naturally just before ls_abort is
   called, abt_evt points to a freed (and potentially reused) event,
   making the dereference a UAF.

   Fix by taking host_lock before reading ls_abort->private and checking
   evt->free (set to 1 by ibmvfc_free_event() under host_lock) to detect
   whether the original LS has already completed.  If so, there is
   nothing to cancel and we return early.  ibmvfc_get_event() is also
   moved inside the lock so the validity check and event allocation are
   atomic with respect to the completion path.

2. Blocking wait on timeout workqueue (same class as the FCP abort fix).
   The original code called wait_for_completion() from ls_abort, which
   is invoked by the NVMe-FC transport from a context that must not
   block.

   Fix by replacing ibmvfc_sync_nvme_completion with a dedicated async
   callback ibmvfc_nvme_ls_abort_done() that logs any non-zero MAD
   status, drops the target kref, and frees the event.
   ibmvfc_send_event() guarantees the callback fires on both success and
   failure paths, so ibmvfc_nvme_ls_abort() returns immediately after
   ibmvfc_send_event().

ibmvfc_sync_nvme_completion is now unused and is removed.
ibmvfc_init_ls_abort() is updated to take the validated abt_evt pointer
directly instead of deriving it from ls_abort->private.

Fixes: 20bec08f0208 ("scsi: ibmvfc: implement nvme-fc LS abort handling callback")
Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-nvme.c | 68 +++++++++++++++--------------
 1 file changed, 35 insertions(+), 33 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-nvme.c b/drivers/scsi/ibmvscsi/ibmvfc-nvme.c
index 52e2621a4342..7e18b79ae4cc 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-nvme.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-nvme.c
@@ -164,21 +164,12 @@ static int ibmvfc_nvme_ls_req(struct nvme_fc_local_port *lport,
 	return 0;
 }
 
-static void ibmvfc_sync_nvme_completion(struct ibmvfc_event *evt)
+static void ibmvfc_init_ls_abort(struct ibmvfc_event *evt,
+				 struct ibmvfc_event *abt_evt)
 {
-	/* copy the response back */
-	if (evt->sync_iu)
-		*evt->sync_iu = *evt->xfer_iu;
-
-	complete(&evt->comp);
-}
-
-static void ibmvfc_init_ls_abort(struct ibmvfc_event *evt, struct nvmefc_ls_req *ls_abort)
-{
-	struct ibmvfc_tmf *tmf;
-	struct ibmvfc_event *abt_evt = ls_abort->private;
 	struct ibmvfc_target *tgt = abt_evt->tgt;
 	struct ibmvfc_host *vhost = evt->vhost;
+	struct ibmvfc_tmf *tmf;
 
 	tmf = &evt->iu.tmf;
 	memset(tmf, 0, sizeof(*tmf));
@@ -192,8 +183,18 @@ static void ibmvfc_init_ls_abort(struct ibmvfc_event *evt, struct nvmefc_ls_req
 	tmf->cancel_key = cpu_to_be32((u64)abt_evt);
 	tmf->my_cancel_key = cpu_to_be32((u64)evt);
 	tmf->assoc_id = cpu_to_be64(tgt->assoc_id);
+}
+
+static void ibmvfc_nvme_ls_abort_done(struct ibmvfc_event *evt)
+{
+	u16 status = be16_to_cpu(evt->xfer_iu->mad_common.status);
+
+	if (status)
+		ibmvfc_dbg(evt->vhost, "ls_abort: cancel MAD failed with rc=%x\n",
+			   status);
 
-	init_completion(&evt->comp);
+	kref_put(&evt->tgt->kref, ibmvfc_release_tgt);
+	ibmvfc_free_event(evt);
 }
 
 static void ibmvfc_nvme_ls_abort(struct nvme_fc_local_port *lport,
@@ -202,34 +203,35 @@ static void ibmvfc_nvme_ls_abort(struct nvme_fc_local_port *lport,
 {
 	struct ibmvfc_host *vhost = lport->private;
 	struct ibmvfc_target *tgt = rport->private;
-	struct ibmvfc_event *evt;
-	union ibmvfc_iu rsp;
+	struct ibmvfc_event *evt, *abt_evt;
 	unsigned long flags;
-	u16 status = IBMVFC_MAD_CRQ_ERROR;
+
+	spin_lock_irqsave(&vhost->host->host_lock, flags);
+
+	/*
+	 * If the original LS has already completed naturally, abt_evt will
+	 * have been freed back to the pool (evt->free set to 1 under
+	 * host_lock by ibmvfc_free_event()).  Nothing left to cancel.
+	 */
+	abt_evt = ls_abort->private;
+	if (!abt_evt || atomic_read(&abt_evt->free)) {
+		spin_unlock_irqrestore(&vhost->host->host_lock, flags);
+		return;
+	}
 
 	evt = ibmvfc_get_event(&vhost->crq);
-	if (!vhost->logged_in || !evt)
+	if (!vhost->logged_in || !evt) {
+		spin_unlock_irqrestore(&vhost->host->host_lock, flags);
 		return;
+	}
 
-	spin_lock_irqsave(&vhost->host->host_lock, flags);
 	kref_get(&tgt->kref);
-	ibmvfc_init_event(evt, ibmvfc_sync_nvme_completion, IBMVFC_MAD_FORMAT);
-	ibmvfc_init_ls_abort(evt, ls_abort);
-	evt->sync_iu = &rsp;
-
-	if (ibmvfc_send_event(evt, vhost, default_timeout))
-		goto out;
-
-	spin_unlock_irqrestore(&vhost->host->host_lock, flags);
+	ibmvfc_init_event(evt, ibmvfc_nvme_ls_abort_done, IBMVFC_MAD_FORMAT);
+	ibmvfc_init_ls_abort(evt, abt_evt);
+	evt->tgt = tgt;
 
-	wait_for_completion(&evt->comp);
-	status = be16_to_cpu(rsp.mad_common.status);
-	spin_lock_irqsave(&vhost->host->host_lock, flags);
-	ibmvfc_free_event(evt);
-out:
+	ibmvfc_send_event(evt, vhost, default_timeout);
 	spin_unlock_irqrestore(&vhost->host->host_lock, flags);
-	ibmvfc_dbg(vhost, "ls_abort: cancel failed with rc=%x\n", status);
-	kref_put(&tgt->kref, ibmvfc_release_tgt);
 }
 
 static void ibmvfc_nvme_done(struct ibmvfc_event *evt)
-- 
2.55.0


