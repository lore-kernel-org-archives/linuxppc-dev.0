Return-Path: <linuxppc-dev+bounces-24680-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAED6C44532
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 00:03:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5BBg307mz30D3;
	Thu, 23 Jul 2026 10:02:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784764938;
	cv=none; b=Fl24xzeiq669Adn0ObI5xg2O/6pHRhHWcYPEeCuOYnIRbPL29IyMLZZh3GiG1tX/9D7PABsT8+MnHjXUDbZ2HJ8SjLwDsPbbQ10OjsNF9SIeGaBTXS9NFg4+k0oW7Dml9HL7Vr7h8nMbV5Ui6/KanQA+z1uO9SVeUglXWWtgc0Cqd+0IkCK6CtxmGO3bY29sTslB8rwui0MVNfq6BZFnepdFquSIIHuUMJG5Pw1dBlOf6HNGnXrmqub4NwkBDEqbemMPEqDz9pP7349y8nTbeT5Xg4NLfPCLgLXZ030c78Iaww8S9oGkYMvB9XaYCOOK0h4Z84sUChWgY7wpn3Lliw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784764938; c=relaxed/relaxed;
	bh=/J48jdanjixDF2dUbfBjqE0vgyyWu4PVAZaKChOMabk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lhocw0j7fh/smjYrRMtii7/w7b6RDOoNTrS3523FxStAXTnVjpAYKz7ftwtTaSS8oM1eo9Dq3mo6MY1sIaM/ZiA+T5CMyfHBBoclVS9mEu89FBUU/+qW6fxdonJCQYU29aJ2q7y2rUtLCFlXRQDzRK8Q4+c61Tbt5LvuWVe5ZNc5LYLNnRJyBWNQLQ2UN/RNL0GPReQJ5/mRZpr5CRZdwAe55fkm1fBiTeH4iyDzXojWpw7xfmTFWTb3RUJiv/aqYLa9oTHCMwrDtLa0HdLnJJvnkDQyRiAFlzlUl/H/qATfnIBxUSwi61qa9Ed9duF9qCq7d8KXfazi3XKi+rpbsw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eYU8SD0F; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eYU8SD0F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5BBV11Tsz2yqx
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 10:02:09 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MIBuWI713174;
	Thu, 23 Jul 2026 00:02:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/J48jdanjixDF2dUb
	fBjqE0vgyyWu4PVAZaKChOMabk=; b=eYU8SD0FKpdoRNnt9KoK5D3CIa9/bzXpm
	6v/XBqA8b9TqYJrh774WKTVcypVcKLxyc3I7REmGQn0JHBHtkkFlCCEasVuttyCH
	8DjnrwMoI20ZoZnYiU+GddYdZTzsZP86DS2S+TS2UCWnqYeohQWXCmrj17Z0g+x6
	rHxLbBj/rtY8zEYihawiR8CR0dUzHkILj9ubLUGnpBeTCNLsG3VWdr3ib34KCHgx
	VdMQMtNQzs14UACfJaGvvj8XY3gYPzo1DAN4terfinoKDyy4bpLEaTUkJbPkm4b2
	QqQBPif/b7lcl222gIvETpY8TMsI1IH7Mg3ied6lQWovoXlFtd9lA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7914xpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 00:02:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MNnr2r021831;
	Thu, 23 Jul 2026 00:02:05 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6w9ujk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 00:02:05 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66N024HV30671360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 00:02:04 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C44F58063;
	Thu, 23 Jul 2026 00:02:04 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0940A58060;
	Thu, 23 Jul 2026 00:02:04 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.118.58])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 00:02:03 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH v2 15/33] ibmvfc: send NVMe target discovery MAD
Date: Wed, 22 Jul 2026 17:01:31 -0700
Message-ID: <20260723000149.969416-16-tyreld@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: ZTwC0VCp6K9EbmREQ65I2aQHjOnpRmiZ
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a6159ff cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=tsEFHN6dr6_4AEcdNwsA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDIzNCBTYWx0ZWRfX1juZ5ywvBmXM
 JoMxT+DEbENrLpN88D4dqpCtXUS95E3rxmLxXjGSM0NlFDo/arYQ9P/kP2oFT8kBpslGokuHclc
 dKje+aTCEBUqOvGTgh/ZR83h+lFWj8Q=
X-Proofpoint-GUID: ZTwC0VCp6K9EbmREQ65I2aQHjOnpRmiZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDIzNCBTYWx0ZWRfX/S0rGFDiFBY7
 CaoFJwQlhWdqFpST9m5Qbzmb6pJbkjt0EqH9u2Ep7yW/6j51SKyLwMT4VKQvZvlGxWwJlrmJPlA
 mgIU8X+SbEYQxVhAaN9RqYm+YqJVA9Hov7fz98ajqRMefgwIGtKahZLyOTeM5AvXkjgYxrcQ5Uu
 YIrnDm+BZFJ30jpUwEOcDpJsDA7lgMfpyJJfeaTc1d05Unx3oNxOSLM8EkrnylqLrv6EE6AFOQk
 bpENCRD0neXoYJhIBR5KV5qRvMmRauf+f6P+kq7mfb6b5QqRaUUYH8Lk7cf0Mj7UUlcdInBiSXC
 32hNjywEaNERyd+/WffUJJ/AQhi3zswI3l3qDxHxwMPKgtzkFE5fj+4FUVin5Ei51LbI4iW5Stx
 cjcPvj84nN00w98TTFxVbsoA/v+nVcq9eoKcg7CmrXGO2rkokMpTaMqOAs2ebh2+72mnU2B9VHC
 ABH8uwoFXO6OFc8IVyA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220234

Extend target discovery to send protocol-specific discover-target MADs
for NVMe/FC.

Use the protocol-aware discovery helper to build an NVMe discover-target
request, submit it when NVMe/FC support is active, and process the
returned target count using the NVMe channel group's discovery buffer.

This allows the driver to discover NVMe/FC targets in parallel with the
existing SCSI discovery flow while keeping protocol-specific target data
separate.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 50 +++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index a700e2554e69..1d2a88e9fe94 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -173,6 +173,11 @@ static const struct {
 	{ IBMVFC_FC_SCSI_ERROR, IBMVFC_COMMAND_FAILED, DID_ERROR, 0, 1, "PRLI to device failed." },
 };
 
+static const char *proto_type[] = {
+	"SCSI",
+	"NVMe",
+};
+
 static void ibmvfc_npiv_login(struct ibmvfc_host *);
 static void ibmvfc_tgt_send_prli(struct ibmvfc_target *);
 static void ibmvfc_tgt_send_plogi(struct ibmvfc_target *);
@@ -5011,19 +5016,30 @@ static void ibmvfc_discover_targets_done(struct ibmvfc_event *evt)
 {
 	struct ibmvfc_host *vhost = evt->vhost;
 	struct ibmvfc_discover_targets *rsp = &evt->xfer_iu->discover_targets;
+	struct ibmvfc_channels *channels;
 	u32 mad_status = be16_to_cpu(rsp->common.status);
+	u32 opcode = be32_to_cpu(rsp->common.opcode);
 	int level = IBMVFC_DEFAULT_LOG_LEVEL;
 
+	if (opcode == IBMVFC_DISC_TARGETS)
+		channels = &vhost->scsi_scrqs;
+	else
+		channels = &vhost->nvme_scrqs;
+
 	switch (mad_status) {
 	case IBMVFC_MAD_SUCCESS:
-		ibmvfc_dbg(vhost, "Discover Targets succeeded\n");
-		vhost->scsi_scrqs.num_targets = min_t(u32, be32_to_cpu(rsp->num_written),
-						      max_targets);
+		ibmvfc_dbg(vhost, "Discover %s Targets succeeded\n",
+			   proto_type[channels->protocol]);
+		channels->num_targets = min_t(u32, be32_to_cpu(rsp->num_written),
+					      max_targets);
+		ibmvfc_dbg(vhost, "%d %s targets found\n", channels->num_targets,
+			   proto_type[channels->protocol]);
 		ibmvfc_set_host_action(vhost, IBMVFC_HOST_ACTION_ALLOC_TGTS);
 		break;
 	case IBMVFC_MAD_FAILED:
 		level += ibmvfc_retry_host_init(vhost);
-		ibmvfc_log(vhost, level, "Discover Targets failed: %s (%x:%x)\n",
+		ibmvfc_log(vhost, level, "Discover %s Targets failed: %s (%x:%x)\n",
+			   proto_type[channels->protocol],
 			   ibmvfc_get_cmd_error(be16_to_cpu(rsp->status), be16_to_cpu(rsp->error)),
 			   be16_to_cpu(rsp->status), be16_to_cpu(rsp->error));
 		break;
@@ -5076,7 +5092,7 @@ static void ibmvfc_discover_targets(struct ibmvfc_host *vhost)
 	int level = IBMVFC_DEFAULT_LOG_LEVEL;
 
 	if (!evt) {
-		ibmvfc_log(vhost, level, "Discover Targets failed: no available events\n");
+		ibmvfc_log(vhost, level, "Discover SCSI Targets failed: no available events\n");
 		ibmvfc_hard_reset_host(vhost);
 		return;
 	}
@@ -5084,9 +5100,29 @@ static void ibmvfc_discover_targets(struct ibmvfc_host *vhost)
 	ibmvfc_set_host_action(vhost, IBMVFC_HOST_ACTION_INIT_WAIT);
 
 	if (!ibmvfc_send_event(evt, vhost, default_timeout))
-		ibmvfc_dbg(vhost, "Sent discover targets\n");
+		ibmvfc_dbg(vhost, "Sent discover SCSI targets\n");
 	else
-		ibmvfc_link_down(vhost, IBMVFC_LINK_DEAD);
+		goto link_down;
+
+	if (!ibmvfc_nvme_active(vhost))
+		return;
+
+	evt = ibmvfc_get_disc_event(&vhost->nvme_scrqs);
+	if (!evt) {
+		ibmvfc_log(vhost, level, "Discover NVMe Targets failed: no available events\n");
+		ibmvfc_hard_reset_host(vhost);
+		return;
+	}
+
+	if (!ibmvfc_send_event(evt, vhost, default_timeout))
+		ibmvfc_dbg(vhost, "Sent discover NVMe targets\n");
+	else
+		goto link_down;
+
+	return;
+
+link_down:
+	ibmvfc_link_down(vhost, IBMVFC_LINK_DEAD);
 }
 
 static void ibmvfc_fabric_login_nvme_done(struct ibmvfc_event *evt)
-- 
2.55.0


