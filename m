Return-Path: <linuxppc-dev+bounces-24679-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB63C44536
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 00:03:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5BBd4l2rz303F;
	Thu, 23 Jul 2026 10:02:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784764937;
	cv=none; b=Hw0aT5tIIN08p/SVxOm8KXeMhs5WhlKxrrsNh0E3qp7DPLf3vyrTAv1NHZHTHfoeA0gPpGm8VuxnijnvquwwmSYc7jseBC5sFhaIBb30gnqbrC+llMG5V9nzCRXsMhVXxX9+hYr063wZSddPi9m7J8rVvbDg0pjzsc4/1x6V3fHsMkcm7/GLJQBaoLVoEfNDUBIL1wULtQjlnSQLVNvVUnjgM37QaaWC+DllHrBeNjekhdG3H7ROw6rBiaRC8oERFG7jhgq9PzxX+3lsrgLXb8hZ+G4wobHPb6kConKZX7aynKFOVD/OciW8/aq6u9jMnRhEwQvDHba9PTDUEDARWA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784764937; c=relaxed/relaxed;
	bh=9puitqZwLH8kiVP/ZpuEifIvBtjQAMW/MHJpov32270=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gDjKJYWEksCqfWh4Zb12k5JrF5i0c0xd9NYd/bVZhqIkA+b+owdi2nUxzHCSjHWDv7XmkFnE4BiGBibmvYUOmRFhHnngt+dtAK4Fyutzh0kteWVBFo0bJtg8j6SL3nzxvvPw5MJOMuIWuH3NK6iku6zgHRm3DYcSimQb5vVFxkZATLYvfEcdiVgZbNgMF0OVPqBoavWFshm/Mxv9db0N1bUoh3mITujfPTOAck2EFMsdSZroGooz0l2j/bP7SufRCQxDqM3HzhryjFz2nF+696xVllSOv9r+gHVnBbdz9uXaHtK5Q2z9rfq3Ix2Eeish7ua5VTHpfIKBH7dqJV5Img==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iWRgIuk2; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iWRgIuk2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5BBR3pTlz2ynT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 10:02:07 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MIBxKK606649;
	Thu, 23 Jul 2026 00:02:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9puitqZwLH8kiVP/Z
	puEifIvBtjQAMW/MHJpov32270=; b=iWRgIuk2Ci7h7ppm1bFkbYqeIqHhRflSa
	ikgwdWsc2Tc3WSXuqo7/xT0F8CgG8vb7420gwbbCGcOeVSXz1woQkA9OuMw86G+Y
	LwrEnMGraA4IxOAn7hkSqk6udJXZPsdZqwyEJwa7tAfH/NfTCcrcLTDp1rvAxe+u
	YSV6px4YP+RzzmeDGWIgnAMsdbW6bfCNpoxr0ud7Vt9TaMaHGS92sJPikHsLOMYx
	jVe/OAP+HEm140iLJiBSh/4CdHHaYWcxfs3AfNm0zvsfNbs/srCj0mKiRcS3RETl
	o8opc2KpBCQosLMlGrbcOL3OUvyf6I5ARlaDD1c00x2hrO97aX2yw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78gcc05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 00:02:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MNnbP7028169;
	Thu, 23 Jul 2026 00:02:03 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnah9q2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 00:02:03 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66N022fc29885138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 00:02:02 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D8C458056;
	Thu, 23 Jul 2026 00:02:02 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9BF55803F;
	Thu, 23 Jul 2026 00:02:01 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.118.58])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 00:02:01 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH v2 12/33] ibmvfc: add helper for creating protocol specific discovery event
Date: Wed, 22 Jul 2026 17:01:28 -0700
Message-ID: <20260723000149.969416-13-tyreld@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDIzNCBTYWx0ZWRfX7ERrU0rmmtqM
 ltL9SE7wLsOmQjdGbATJ/m6gpGR3aZ+KlV59Di0RNS4nDwul5yUNgCfa5Pz4TqMtbT9lTxtzIjz
 nw5lVOXC3RrOEEXwECaHkFVzKwT/G1mf/4IJioyEII5oQqXssatbXOULY+YP4ZEBzoATuNepewi
 TcxuXlgUwpu9JdWr5kJaoMELKtb+quB84hmw+dOg7kSR1W1tRtwOhb/BfzzYbv8Su+136AqmrlT
 cd224ghBpObUDNcIXRUYtsntA6F47Ytv4hLdalKwrDfk7PkvN5ZX61Ercv2pytS1bO0ywhJ8RUc
 fwQBHOiQrg93j8FwQAtawvr/2gc2/C749DwBLu25d8zHUQfPuqeptLDEtY5Lr1tO6r4raUIz0Tn
 kAObAD7UHSgcAzk4sh2EpAgjFHcZHfSHWPBpin6iMOLtcd5cQMEYc6cGt/3ZNk/H21YKTDB1lne
 KmoQgdY29mkBZhX1lSA==
X-Proofpoint-GUID: Pur9GUyRdV_gyoOmP6Ksp8mYKMi3tAaL
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a6159fc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=cvol4pHx2ldDu_PevKwA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDIzNCBTYWx0ZWRfX+XlwswkFpmBb
 v9NB8eUHX4FZysp2I7gvwzy9jAq7aG/WJ+Fw1qVw01E33STvC4FYV36Ttv/qa02wFtyH1jB0vFD
 yQkRjn9fzRAINQ4t5kGDTtPhMGvjxgY=
X-Proofpoint-ORIG-GUID: Pur9GUyRdV_gyoOmP6Ksp8mYKMi3tAaL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220234

Refactor discover-target event creation so it can be shared by both SCSI
and NVMe/FC discovery.

Introduce a helper that takes a protocol-specific channel group, selects
the correct discover-target opcode, and maps the corresponding discovery
buffer into the MAD.

This is a preparatory cleanup for issuing protocol-specific discovery
MADs in later patches.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 39 ++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index e0edd71e9fd4..84302f982a6a 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -5033,6 +5033,32 @@ static void ibmvfc_discover_targets_done(struct ibmvfc_event *evt)
 	wake_up(&vhost->work_wait_q);
 }
 
+static struct ibmvfc_event *ibmvfc_get_disc_event(struct ibmvfc_channels *channels)
+{
+	struct ibmvfc_discover_targets *mad;
+	struct ibmvfc_host *vhost = ibmvfc_channels_to_vhost(channels);
+	struct ibmvfc_event *evt = ibmvfc_get_reserved_event(&vhost->crq);
+
+	if (!evt)
+		return NULL;
+
+	ibmvfc_init_event(evt, ibmvfc_discover_targets_done, IBMVFC_MAD_FORMAT);
+	mad = &evt->iu.discover_targets;
+	memset(mad, 0, sizeof(*mad));
+	mad->common.version = cpu_to_be32(1);
+	if (channels->protocol == IBMVFC_PROTO_SCSI)
+		mad->common.opcode = cpu_to_be32(IBMVFC_DISC_TARGETS);
+	else
+		mad->common.opcode = cpu_to_be32(IBMVFC_DISC_NVMF_TARGETS);
+	mad->common.length = cpu_to_be16(sizeof(*mad));
+	mad->bufflen = cpu_to_be32(channels->disc_buf_sz);
+	mad->buffer.va = cpu_to_be64(channels->disc_buf_dma);
+	mad->buffer.len = cpu_to_be32(channels->disc_buf_sz);
+	mad->flags = cpu_to_be32(IBMVFC_DISC_TGT_PORT_ID_WWPN_LIST);
+
+	return evt;
+}
+
 /**
  * ibmvfc_discover_targets - Send Discover Targets MAD
  * @vhost:	ibmvfc host struct
@@ -5040,8 +5066,7 @@ static void ibmvfc_discover_targets_done(struct ibmvfc_event *evt)
  **/
 static void ibmvfc_discover_targets(struct ibmvfc_host *vhost)
 {
-	struct ibmvfc_discover_targets *mad;
-	struct ibmvfc_event *evt = ibmvfc_get_reserved_event(&vhost->crq);
+	struct ibmvfc_event *evt = ibmvfc_get_disc_event(&vhost->scsi_scrqs);
 	int level = IBMVFC_DEFAULT_LOG_LEVEL;
 
 	if (!evt) {
@@ -5050,16 +5075,6 @@ static void ibmvfc_discover_targets(struct ibmvfc_host *vhost)
 		return;
 	}
 
-	ibmvfc_init_event(evt, ibmvfc_discover_targets_done, IBMVFC_MAD_FORMAT);
-	mad = &evt->iu.discover_targets;
-	memset(mad, 0, sizeof(*mad));
-	mad->common.version = cpu_to_be32(1);
-	mad->common.opcode = cpu_to_be32(IBMVFC_DISC_TARGETS);
-	mad->common.length = cpu_to_be16(sizeof(*mad));
-	mad->bufflen = cpu_to_be32(vhost->scsi_scrqs.disc_buf_sz);
-	mad->buffer.va = cpu_to_be64(vhost->scsi_scrqs.disc_buf_dma);
-	mad->buffer.len = cpu_to_be32(vhost->scsi_scrqs.disc_buf_sz);
-	mad->flags = cpu_to_be32(IBMVFC_DISC_TGT_PORT_ID_WWPN_LIST);
 	ibmvfc_set_host_action(vhost, IBMVFC_HOST_ACTION_INIT_WAIT);
 
 	if (!ibmvfc_send_event(evt, vhost, default_timeout))
-- 
2.55.0


