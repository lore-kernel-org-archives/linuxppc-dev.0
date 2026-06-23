Return-Path: <linuxppc-dev+bounces-22900-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4BCCDB46F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2026 01:32:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gknZt5W5sz30G9;
	Tue, 23 Jun 2026 11:31:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782178261;
	cv=none; b=adJtJCXwt6zqYvpp17yTND5SoGFTmbNeiHmgpT2UcNF+Xc5D/SEqAZOAUUVGDy3hsMCg4i7degU5SvBdcQnYVy/qK1rS104c4U1LtZdf2BbNDVmeA4X8uGPXM8x6vSK2W8hDQi/JEBOQ74swdDNZ+h3toQTHNGmw8W103VmDVPnJmYXnn1lQPrCMjqOwExBsqzqMkY/NGmmJPELyknFt6+CQHk6ZikunXuJqiBEH7CTZXZXdtlSGH4/WNzDyiHqFbycqF6likA/GcWeB9qBsleanCGxdJeni25CybHLvDTnON9j8Vam6sNMurjdp47bsOZ+TlB8xjt1RCu6Pn2g4Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782178261; c=relaxed/relaxed;
	bh=k5VScfDahLgVssQxx4kWeRs6DRZCnWyWqlq8ZWEPG0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V0F0Jfe1dNZMfH+WkN+QKCH4gMvTruvFr1VJ+6fYN7eRSPH5dfmZTGUZfW0mdU29B2Fk4C7vFI3yONfeX5GE+iOIDejKcra6u8MErBT4FFnb0S0lobLVh0UWHeyeGu6PhFKKeBUHbH+VpYWUmqInk6ZxvO7ZPn5SZfQfwmVcCp9lLT8qjNHhrxVQgi242Ju6qJasmy60OzlKqIfI07gYhPt9vylVMXSmHIomhO/O9cmfhcj+jc9rPFDEWViff1ZvoBX3T2FSBNZDj7KjzhcezlkfzhU/gooH1xFVt5ByWYplzU08sCvjX4xt9YQAtBge2a5aGmXEQ3ROHOQ+JHiM/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SOMXIM+W; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SOMXIM+W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gknZl41KVz2ytJ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 11:30:55 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N0mJjw408203;
	Tue, 23 Jun 2026 01:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=k5VScfDahLgVssQxx
	4kWeRs6DRZCnWyWqlq8ZWEPG0E=; b=SOMXIM+WP0d8ET3GxK1nrDTNXJzTBg0Nb
	TeoWOV5FJ0Y/iAA31wOvN2yCAMm2u/gHGCQcDixfZbL3f7vakgcZyrsyGkKGCw9n
	sM668oqvd9o5MICkRLmcsPbVVo87e3hmczBm1H/nNrSfJZGO4U1thCpllCjcki0o
	5VMdywpb+ZuseBmUFN9gls2W5A+BI6UE/fg/wKzLdDExcH2Vj2ivO69kt8gy8yBC
	2jJDrGz7Cl/Tzo9wQKVIguu7nrJGA/Z5XaPcVDxrUCvclvS3fiwXo9TxJvVn0JlX
	mMZxihoT3lwRuv4pbHX90EMJMIdKGBWt+xwBt6tCPX2XJrPLatINg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjc3c4r1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 01:30:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65N1Jl6T005253;
	Tue, 23 Jun 2026 01:30:51 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex5jw92jk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 01:30:51 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65N1Uobe13632230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 01:30:50 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 795D758052;
	Tue, 23 Jun 2026 01:30:50 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBFA058056;
	Tue, 23 Jun 2026 01:30:49 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.188.206])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 01:30:49 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH 17/29] ibmvfc: delete NVMe/FC targets as well as SCSI
Date: Mon, 22 Jun 2026 18:30:23 -0700
Message-ID: <20260623013035.3436640-18-tyreld@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=X4Ni7mTe c=1 sm=1 tr=0 ts=6a39e1cc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=FlIHKPD9N9UiteZsW-UA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDAwOCBTYWx0ZWRfX/Yheg/g3k+PK
 hxXZVIl9zh2Vj1IYgKLV450kFePt7lflLvSi6mvXDpCJ03CdFFaxwZ0WU4TPrXZwHSCMVeJLtIt
 K/tT4tX3FJqpix0agw7B0x0ueTyO7pU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDAwOCBTYWx0ZWRfX4VPlBsp6Vfwa
 ZuH7XY92TVA1Ksf7uLQ53aL2YfNzbI07+HZl2bSHAAXisfkbZi0pUcNWVl9EDVYbV3f+LAy4xOv
 pGoT1NvnscsKrZyRIQUPOET7XiPA4DP/9BmwY3XXroSSMsJoi+fQ7wFj9KdUNgp5T/5LqeOeOBb
 ed2UkUhQrDUaRXuIOhsTbelLbnOD7IySp9neYF8cJbDUN5iZaGLdolISADZ1DxfZEa1CWQ+2AIr
 EGJ8CiT7fac7umq6KFYdS0DHNaF9kiQ9BYje8GZhDY10S5d7UQLe8khDsVMu04w1Doy+qMbaAcZ
 NIgUotXu1wKvPFYZRvPnG02wJe9d3+0rQdnP+5REYWUZWYvieoR4bPS0szkfmSkFZujmx65kOea
 P3Bf5PaZnqMBtBIdzQk7tFWrYzsVhX6IRF2GfZe7X0j2kt3IBZqsuMIXnDLhrkNiIG71u1VA7cw
 F2ZZz/8uw/LRKpWGJwg==
X-Proofpoint-ORIG-GUID: ps9VWZinrFgTeGJrujdo8Y5y1-c6AQA3
X-Proofpoint-GUID: ps9VWZinrFgTeGJrujdo8Y5y1-c6AQA3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230008

Extend target deletion paths to process NVMe targets as well as SCSI
targets.

Update link-down, and host reinitialization flows to walk both the SCSI
and NVMe target lists when marking targets for deletion. This ensures
that protocol-specific target state stays consistent across adapter
resets and fabric events.

Rename ibmvfc_relogin to ibmvfc_scsi_relogin as it acts on a scsi
command.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 4b95e4344947..13e513bfd0a8 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -714,6 +714,8 @@ static void ibmvfc_link_down(struct ibmvfc_host *vhost,
 	scsi_block_requests(vhost->host);
 	list_for_each_entry(tgt, &vhost->scsi_scrqs.targets, queue)
 		ibmvfc_del_tgt(tgt);
+	list_for_each_entry(tgt, &vhost->nvme_scrqs.targets, queue)
+		ibmvfc_del_tgt(tgt);
 	ibmvfc_set_host_state(vhost, state);
 	ibmvfc_set_host_action(vhost, IBMVFC_HOST_ACTION_TGT_DEL);
 	vhost->events_to_log |= IBMVFC_AE_LINKDOWN;
@@ -751,6 +753,12 @@ static void ibmvfc_init_host(struct ibmvfc_host *vhost)
 			else
 				ibmvfc_del_tgt(tgt);
 		}
+		list_for_each_entry(tgt, &vhost->nvme_scrqs.targets, queue) {
+			if (vhost->client_migrated)
+				tgt->need_login = 1;
+			else
+				ibmvfc_del_tgt(tgt);
+		}
 
 		scsi_block_requests(vhost->host);
 		ibmvfc_set_host_action(vhost, IBMVFC_HOST_ACTION_INIT);
@@ -1868,7 +1876,7 @@ static void ibmvfc_log_error(struct ibmvfc_event *evt)
  * @sdev:	scsi device struct
  *
  **/
-static void ibmvfc_relogin(struct scsi_device *sdev)
+static void ibmvfc_scsi_relogin(struct scsi_device *sdev)
 {
 	struct ibmvfc_host *vhost = shost_priv(sdev->host);
 	struct fc_rport *rport = starget_to_rport(scsi_target(sdev));
@@ -1920,7 +1928,7 @@ static void ibmvfc_scsi_done(struct ibmvfc_event *evt)
 				memcpy(cmnd->sense_buffer, rsp->data.sense + rsp_len, sense_len);
 			if ((be16_to_cpu(vfc_cmd->status) & IBMVFC_VIOS_FAILURE) &&
 			    (be16_to_cpu(vfc_cmd->error) == IBMVFC_PLOGI_REQUIRED))
-				ibmvfc_relogin(cmnd->device);
+				ibmvfc_scsi_relogin(cmnd->device);
 
 			if (!cmnd->result && (!scsi_get_resid(cmnd) || (rsp->flags & FCP_RESID_OVER)))
 				cmnd->result = (DID_ERROR << 16);
-- 
2.54.0


