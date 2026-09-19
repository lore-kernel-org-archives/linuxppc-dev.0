Return-Path: <linuxppc-dev+bounces-27778-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CBFC982DE
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Sep 2026 01:35:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmsTB02l9z3dVy;
	Sat, 19 Sep 2026 11:33:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789781613;
	cv=none; b=TpYnK5eGOQU+Y+Ol/6OvwFOluxzWLWAePj91DYHF/8kz6XoQ+87ImmzF/G7+B+6EknwVYwkdSvez+nS55w64aAJi9LD4yTHw8uJoVscd5MWWcRYIM2oNNWHPTkjqqiHcN0o+dNcAzq9j5Swv4R/T+V82Amc7FGgx+PL9BuwuYRhonIw3MjgIJnTmMW8wQj2RZB6oTHZ2Sj0zBMDu5Kv9N7hVtaCMw6nkE6vLgjdTW73I6KrFbJp6otV7F3gJ13tu0R0/dY7DfXD3UkznZhxAYnUKc8i8/0eGEukrpe/i5nNdr1SDConzl+gQ0kN/fXLOiU+opKL4htwT8cC+Nr/ZOg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789781613; c=relaxed/relaxed;
	bh=UDMf5Wk1qyT/dSPEsQ2r9cDTMThOrVKd03KqreuuP8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iyR9FEqPoZhcGKyq6WJkci0UjhQjxBYk+Jp1tA8m2G+LKpqlMtXc5QfyXUuYwBCfwLsxRxx0MY9ktvS7kShmlZ/mEr2YesMSJDchWhC5eyW2bRBpDBOHiEcynIo5IsAlAqUg6/h+DcQLIUDlgPP5Jutw2xjSUg5cIk7J14F4v2cZLirwx3HF8xKMff7ESrpyNBbuTsiLuFS1U0K1o1PF4b5KZLNEQCskINAlLxTFHm20RAjEQkJQ7lbxV+GfORz6NoSLK8hVtB6IOdT6+BPRnYoNCFrkMZrisDLGsMUH/Ube7j6loalcnse+wCwy7E9YzW6FgTkI78yKqMrn9HYLTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=C83+cY/c; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=C83+cY/c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmsT652SLz3dPs
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2026 11:33:30 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68J01U7N2662258;
	Sat, 19 Sep 2026 01:33:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UDMf5Wk1qyT/dSPEs
	Q2r9cDTMThOrVKd03KqreuuP8U=; b=C83+cY/cgU5rD/mbmoUfcB0XyTIJ8TYvC
	c6fnpKc3d8YeufUufDaKk3zR8xUHNmS2TFfsV1wHGsNZxwx181nv4X025is1QxCj
	uEkzM1tbrZVjPXK/20SaAUc293QJn7scil9rFJNrICnEBI1SezkduPC2QMt7nLTs
	o6y98Wy1gtTa5MzOdaI9IRHDMLtBMfm8tVgKAimD4zP+5uPOUOlBBjKqgFre19LC
	eK9CVvY7WKIQtEgEzgLnnsVGBtiXa5r//RAnw7ydjLXb7Nlcodh4JG8OY6POYzWR
	YUunY3EIOyfXoQP6Thk+AFLf8GbLcjdj3FaE2Qv9Ch8HAanaLLAsQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx84b0jk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 19 Sep 2026 01:33:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68J1RaOc1658899;
	Sat, 19 Sep 2026 01:33:27 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gsgrgg0dm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Sep 2026 01:33:27 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68J1XQEL26411582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Sep 2026 01:33:26 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B82258051;
	Sat, 19 Sep 2026 01:33:26 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7219A5805A;
	Sat, 19 Sep 2026 01:33:25 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.101.145])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 19 Sep 2026 01:33:25 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH v2 20/20] scsi: ibmvfc: fix concurrent SCSI and NVMe discover-targets race dropping targets
Date: Fri, 18 Sep 2026 18:33:06 -0700
Message-ID: <20260919013306.2948028-21-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919013306.2948028-1-tyreld@linux.ibm.com>
References: <20260919013306.2948028-1-tyreld@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE5MDAxOCBTYWx0ZWRfX1HjFvpICJyd2
 HoCw7zlVzk3uAA4LeNpQe0vc6snYE7n2MjBnr3eoF6kzv9isAy2ZIKnFB8gGoHkapVnZOqe/yup
 cYTnfnHyX0PWbjFGSJvtZ4NUz48tR3GEdG3ac4z8R9T7Smz7YJU23+iczqvRpFvt3v46VJ6zqAI
 06osr5nIH4v18zB8XW+H7Nr7bEObzD4vLSRHQyv/TQxv+QPURKEYn9nzxsNw/LntTaJkzbMTk5v
 r3DS5cAJvMGtfdlCFThu7F6oNpxD7IkskNfiUEHIwPmkdD4EemKHEPOyEBX45TSUwQXqvItebS8
 Xrw7ArPdMyu6djw7fr92h/RZ/MaI9dd5MsmJbI2ZEqxtcZOYdNoZnYdV3WFRT7AUzDR4B0+4Q8e
 wQ494KGoaWmnPxbjPV+3ucz4kfvUzpN/quPnCaUtXGGQp1nnkwTCqH/MKDzXExGYcvgwzyrtrzk
 hmSJvC6EElv2RJt1qAA==
X-Proofpoint-ORIG-GUID: _3i7vAMg0zk4pxgHNMCPaoXfSiNABME3
X-Proofpoint-GUID: _3i7vAMg0zk4pxgHNMCPaoXfSiNABME3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE5MDAxOCBTYWx0ZWRfX2A5G05OEnlL+
 0MhLFaPTrtiNJrKJxu73psZjBBtpyq7PHA2JbUNXAS0k1D7rShZlSUFI38RUDgNIxK4pxhdxP+w
 cFo59Jzh0Y9yICa2plOPgL/HtX6lLRQ=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aade667 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=TELSalMAAoxOiMB7PF4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_07,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609190018

Commit 5e9dd03726ad ("scsi: ibmvfc: send NVMe target discovery MAD")
introduced concurrent SCSI and NVMe discover-target MADs.
ibmvfc_discover_targets_done() unconditionally set
IBMVFC_HOST_ACTION_ALLOC_TGTS on the first completion to arrive.
ibmvfc_alloc_targets() ran immediately and read both channels'
disc_buf and num_targets fields while the slower protocol's MAD was
still in flight. The slower protocol's num_targets remained zero from
the previous cycle, silently dropping all targets for that protocol.
The second completion attempted to transition to ALLOC_TGTS again but
the state machine had already advanced, so the transition was a no-op
and ibmvfc_alloc_targets() was never re-run.

Fix this by serializing discovery: send the SCSI discover-targets MAD
first and wait for its completion before sending the NVMe MAD.
ibmvfc_discover_scsi_targets_done() advances the job_step to
ibmvfc_discover_nvme_targets() when NVMe is active, or transitions
directly to IBMVFC_HOST_ACTION_ALLOC_TGTS when it is not.
ibmvfc_discover_nvme_targets_done() then transitions to ALLOC_TGTS
after the NVMe buffer is fully written. This guarantees that
ibmvfc_alloc_targets() is only called after both discovery buffers
are complete with no shared counter and no concurrent MADs in flight.

Fixes: 5e9dd03726ad ("scsi: ibmvfc: send NVMe target discovery MAD")
Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 115 +++++++++++++++++++---------
 1 file changed, 79 insertions(+), 36 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index ca9a0437fc0c..46d6b94cb96d 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -184,6 +184,7 @@ static void ibmvfc_tgt_send_prli(struct ibmvfc_target *);
 static void ibmvfc_tgt_send_plogi(struct ibmvfc_target *);
 static void ibmvfc_tgt_query_target(struct ibmvfc_target *);
 static void ibmvfc_npiv_logout(struct ibmvfc_host *);
+static void ibmvfc_discover_nvme_targets(struct ibmvfc_host *);
 static void ibmvfc_tgt_implicit_logout_and_del(struct ibmvfc_target *);
 static void ibmvfc_tgt_move_login(struct ibmvfc_target *);
 
@@ -5137,45 +5138,80 @@ static int ibmvfc_alloc_targets(struct ibmvfc_host *vhost)
 }
 
 /**
- * ibmvfc_discover_targets_done - Completion handler for discover targets MAD
+ * ibmvfc_discover_scsi_targets_done - Completion handler for SCSI discover targets MAD
  * @evt:	ibmvfc event struct
  *
  **/
-static void ibmvfc_discover_targets_done(struct ibmvfc_event *evt)
+static void ibmvfc_discover_scsi_targets_done(struct ibmvfc_event *evt)
 {
 	struct ibmvfc_host *vhost = evt->vhost;
 	struct ibmvfc_discover_targets *rsp = &evt->xfer_iu->discover_targets;
-	struct ibmvfc_channels *channels;
 	u32 mad_status = be16_to_cpu(rsp->common.status);
-	u32 opcode = be32_to_cpu(rsp->common.opcode);
 	int level = IBMVFC_DEFAULT_LOG_LEVEL;
 
-	if (opcode == IBMVFC_DISC_TARGETS)
-		channels = &vhost->scsi_scrqs;
-	else
-		channels = &vhost->nvme_scrqs;
+	switch (mad_status) {
+	case IBMVFC_MAD_SUCCESS:
+		ibmvfc_dbg(vhost, "Discover SCSI Targets succeeded\n");
+		vhost->scsi_scrqs.num_targets = min_t(u32, be32_to_cpu(rsp->num_written),
+						      max_targets);
+		ibmvfc_dbg(vhost, "%d SCSI targets found\n",
+			   vhost->scsi_scrqs.num_targets);
+		if (ibmvfc_nvme_active(vhost)) {
+			ibmvfc_set_host_action(vhost, IBMVFC_HOST_ACTION_INIT);
+			vhost->job_step = ibmvfc_discover_nvme_targets;
+		} else {
+			ibmvfc_set_host_action(vhost, IBMVFC_HOST_ACTION_ALLOC_TGTS);
+		}
+		break;
+	case IBMVFC_MAD_FAILED:
+		level += ibmvfc_retry_host_init(vhost);
+		ibmvfc_log(vhost, level, "Discover SCSI Targets failed: %s (%x:%x)\n",
+			   ibmvfc_get_cmd_error(be16_to_cpu(rsp->status), be16_to_cpu(rsp->error)),
+			   be16_to_cpu(rsp->status), be16_to_cpu(rsp->error));
+		break;
+	case IBMVFC_MAD_DRIVER_FAILED:
+		break;
+	default:
+		dev_err(vhost->dev, "Invalid Discover SCSI Targets response: 0x%x\n", mad_status);
+		ibmvfc_link_down(vhost, IBMVFC_LINK_DEAD);
+		break;
+	}
+
+	ibmvfc_free_event(evt);
+	wake_up(&vhost->work_wait_q);
+}
+
+/**
+ * ibmvfc_discover_nvme_targets_done - Completion handler for NVMe discover targets MAD
+ * @evt:	ibmvfc event struct
+ *
+ **/
+static void ibmvfc_discover_nvme_targets_done(struct ibmvfc_event *evt)
+{
+	struct ibmvfc_host *vhost = evt->vhost;
+	struct ibmvfc_discover_targets *rsp = &evt->xfer_iu->discover_targets;
+	u32 mad_status = be16_to_cpu(rsp->common.status);
+	int level = IBMVFC_DEFAULT_LOG_LEVEL;
 
 	switch (mad_status) {
 	case IBMVFC_MAD_SUCCESS:
-		ibmvfc_dbg(vhost, "Discover %s Targets succeeded\n",
-			   proto_type[channels->protocol]);
-		channels->num_targets = min_t(u32, be32_to_cpu(rsp->num_written),
-					      max_targets);
-		ibmvfc_dbg(vhost, "%d %s targets found\n", channels->num_targets,
-			   proto_type[channels->protocol]);
+		ibmvfc_dbg(vhost, "Discover NVMe Targets succeeded\n");
+		vhost->nvme_scrqs.num_targets = min_t(u32, be32_to_cpu(rsp->num_written),
+						      max_targets);
+		ibmvfc_dbg(vhost, "%d NVMe targets found\n",
+			   vhost->nvme_scrqs.num_targets);
 		ibmvfc_set_host_action(vhost, IBMVFC_HOST_ACTION_ALLOC_TGTS);
 		break;
 	case IBMVFC_MAD_FAILED:
 		level += ibmvfc_retry_host_init(vhost);
-		ibmvfc_log(vhost, level, "Discover %s Targets failed: %s (%x:%x)\n",
-			   proto_type[channels->protocol],
+		ibmvfc_log(vhost, level, "Discover NVMe Targets failed: %s (%x:%x)\n",
 			   ibmvfc_get_cmd_error(be16_to_cpu(rsp->status), be16_to_cpu(rsp->error)),
 			   be16_to_cpu(rsp->status), be16_to_cpu(rsp->error));
 		break;
 	case IBMVFC_MAD_DRIVER_FAILED:
 		break;
 	default:
-		dev_err(vhost->dev, "Invalid Discover Targets response: 0x%x\n", mad_status);
+		dev_err(vhost->dev, "Invalid Discover NVMe Targets response: 0x%x\n", mad_status);
 		ibmvfc_link_down(vhost, IBMVFC_LINK_DEAD);
 		break;
 	}
@@ -5184,7 +5220,8 @@ static void ibmvfc_discover_targets_done(struct ibmvfc_event *evt)
 	wake_up(&vhost->work_wait_q);
 }
 
-static struct ibmvfc_event *ibmvfc_get_disc_event(struct ibmvfc_channels *channels)
+static struct ibmvfc_event *ibmvfc_get_disc_event(struct ibmvfc_channels *channels,
+						  void (*done)(struct ibmvfc_event *))
 {
 	struct ibmvfc_discover_targets *mad;
 	struct ibmvfc_host *vhost = ibmvfc_channels_to_vhost(channels);
@@ -5193,7 +5230,7 @@ static struct ibmvfc_event *ibmvfc_get_disc_event(struct ibmvfc_channels *channe
 	if (!evt)
 		return NULL;
 
-	ibmvfc_init_event(evt, ibmvfc_discover_targets_done, IBMVFC_MAD_FORMAT);
+	ibmvfc_init_event(evt, done, IBMVFC_MAD_FORMAT);
 	mad = &evt->iu.discover_targets;
 	memset(mad, 0, sizeof(*mad));
 	mad->common.version = cpu_to_be32(1);
@@ -5211,17 +5248,18 @@ static struct ibmvfc_event *ibmvfc_get_disc_event(struct ibmvfc_channels *channe
 }
 
 /**
- * ibmvfc_discover_targets - Send Discover Targets MAD
+ * ibmvfc_discover_nvme_targets - Send Discover NVMe Targets MAD
  * @vhost:	ibmvfc host struct
  *
  **/
-static void ibmvfc_discover_targets(struct ibmvfc_host *vhost)
+static void ibmvfc_discover_nvme_targets(struct ibmvfc_host *vhost)
 {
-	struct ibmvfc_event *evt = ibmvfc_get_disc_event(&vhost->scsi_scrqs);
+	struct ibmvfc_event *evt = ibmvfc_get_disc_event(&vhost->nvme_scrqs,
+							 ibmvfc_discover_nvme_targets_done);
 	int level = IBMVFC_DEFAULT_LOG_LEVEL;
 
 	if (!evt) {
-		ibmvfc_log(vhost, level, "Discover SCSI Targets failed: no available events\n");
+		ibmvfc_log(vhost, level, "Discover NVMe Targets failed: no available events\n");
 		ibmvfc_hard_reset_host(vhost);
 		return;
 	}
@@ -5229,29 +5267,34 @@ static void ibmvfc_discover_targets(struct ibmvfc_host *vhost)
 	ibmvfc_set_host_action(vhost, IBMVFC_HOST_ACTION_INIT_WAIT);
 
 	if (!ibmvfc_send_event(evt, vhost, default_timeout))
-		ibmvfc_dbg(vhost, "Sent discover SCSI targets\n");
+		ibmvfc_dbg(vhost, "Sent discover NVMe targets\n");
 	else
-		goto link_down;
+		ibmvfc_link_down(vhost, IBMVFC_LINK_DEAD);
+}
 
-	if (!ibmvfc_nvme_active(vhost))
-		return;
+/**
+ * ibmvfc_discover_targets - Send Discover SCSI Targets MAD
+ * @vhost:	ibmvfc host struct
+ *
+ **/
+static void ibmvfc_discover_targets(struct ibmvfc_host *vhost)
+{
+	struct ibmvfc_event *evt = ibmvfc_get_disc_event(&vhost->scsi_scrqs,
+							 ibmvfc_discover_scsi_targets_done);
+	int level = IBMVFC_DEFAULT_LOG_LEVEL;
 
-	evt = ibmvfc_get_disc_event(&vhost->nvme_scrqs);
 	if (!evt) {
-		ibmvfc_log(vhost, level, "Discover NVMe Targets failed: no available events\n");
+		ibmvfc_log(vhost, level, "Discover SCSI Targets failed: no available events\n");
 		ibmvfc_hard_reset_host(vhost);
 		return;
 	}
 
+	ibmvfc_set_host_action(vhost, IBMVFC_HOST_ACTION_INIT_WAIT);
+
 	if (!ibmvfc_send_event(evt, vhost, default_timeout))
-		ibmvfc_dbg(vhost, "Sent discover NVMe targets\n");
+		ibmvfc_dbg(vhost, "Sent discover SCSI targets\n");
 	else
-		goto link_down;
-
-	return;
-
-link_down:
-	ibmvfc_link_down(vhost, IBMVFC_LINK_DEAD);
+		ibmvfc_link_down(vhost, IBMVFC_LINK_DEAD);
 }
 
 static void ibmvfc_fabric_login_nvme_done(struct ibmvfc_event *evt)
-- 
2.55.0


