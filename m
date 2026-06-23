Return-Path: <linuxppc-dev+bounces-22906-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDACCDB46F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2026 01:32:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gknb00bJGz3cZ8;
	Tue, 23 Jun 2026 11:31:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782178265;
	cv=none; b=hG4WLIOwPFAWT35GvSbzIpb5cFT44b/QUQDO4+v47+dkRZvNUodtG+VpNOrHZzjaqEnC6ZSaKdzO5m3aYzkKkPzDewnrv23ri8+A4l/UppeHJLsAJwCT7esoAJOOIjB96BHh8Axs6d+mykv1uHFW+VL/4PB+Md4RGSTRwJyCrw1XpIgOVD2jb6rNKaAciwnHNf81cmpBuysolN1qKcTNQig4zs2HE8Lf+VS41aGyno4RWBWt9cvlPqpJeIy9zpElje5FWQUH97onNV7RQwSwei2b2SKgtwvfiIlekXftDT8z6iq9f6XO/Vfkcck/IP7MP+5l6M/tHftpY/s6nDFRFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782178265; c=relaxed/relaxed;
	bh=JLAqepSSiPXgQpMsI3t/l+IugCnX5C+30j9CT0dz4cA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=neDcAoQ2J9OGge3urL0OGj6Fv28136VByZ5E7/VVfN0uuMDjTasxOogc/peY0s50G6CBoj/TKhEAX6EASV3rbda82/jyhUwUiaBVWwEGsNQbgcuUnNas9XQ+xqU405VLsNV5TwE6NnR7+5adKj8trg0jIOkR6a2tUZX3x113jP60X+Zc72bC1YFiPnM5R9Jv6IFLcYmU4Z2Ui9E3Zz/xZ8soF3fNLwieTZ9VOLA7AuuxU4sEPrkfb2fLnfjn9CLqqk25hwWMvwa4MIrPf6Se1GuzIlR7lcy6MHmkLDR87NKll8OtBpmxSsAE5cvyPlHjlimyeH3w9rXBH1uhDzT9BQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JYV4qggo; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JYV4qggo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gknZp4CNzz2yxN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 11:30:58 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N0nN3R310531;
	Tue, 23 Jun 2026 01:30:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JLAqepSSiPXgQpMsI
	3t/l+IugCnX5C+30j9CT0dz4cA=; b=JYV4qggo5ILTmJQpZqAkI0LeD9w6NJMqt
	JgfwgyRn3xpCiKweQv78lCyvt93ITpi0+Q9xcVDyqjdJCdwDSkYMaq+cyRI2a22C
	plhiOKysP98LuJWi5ZgUeFm8v15RnmyOHcmHVOBJKzxt9zyxzrt02Jh80aEexcsw
	Ua4MP/DOVJ39r9Qk3pIRXeOZeTwZwtlN5tvWX0tAhYBeuVajgG+s8Fe1tSpaNHj5
	4F1/thiWv0F6t9Twuon8MN9sYBKGgCuMqkbb1vQuzOOxY5pUa3c5Ia4OM4dGqi3C
	oy+IDOZoBg44Kjo64LI4n+R0UgOnHvbJ9o2NKHnMyeqKqt5gLkx+Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9hmbuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 01:30:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65N1Jnod026340;
	Tue, 23 Jun 2026 01:30:55 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7dg0qwk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 01:30:55 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65N1Urur19530268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 01:30:53 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5130B58064;
	Tue, 23 Jun 2026 01:30:53 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B02BB5805A;
	Tue, 23 Jun 2026 01:30:52 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.188.206])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 01:30:52 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH 21/29] ibmvfc: process NVMe/FC rports in work thread
Date: Mon, 22 Jun 2026 18:30:27 -0700
Message-ID: <20260623013035.3436640-22-tyreld@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: hesHAMeU1FfWS8H0JSDphLEKiyjziy4P
X-Proofpoint-GUID: hesHAMeU1FfWS8H0JSDphLEKiyjziy4P
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a39e1d0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=lFKfsdLaCX9T0gyYbi8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDAwOCBTYWx0ZWRfX5Gl0brgSG/Ld
 FJ9ey5hfbax+I6LacMuLg+YlP887TSqS4Hr4xN3/TxFNFzdUBdHcZUya9zdG+hqlFpvkIYQTXUK
 sdZB7Zef4oeCbA+CUzb06aDh8ntBXX3hwqvXzzTixAu8EePuTgYKa5nz8Tk6WLMvtknWCTnpy8e
 jHINdEOebn8GUnnoiijGrgcLsDH5Ep8OCU6fjNRICUgmcc81wkKc/1rJmY4ky6DhIwCUHmkQulc
 EoBLD8aM/JLjL5NtjxikATSnyPJjtAuntknZyIo3KQ49dOPDUAlgUANAHIdA6m4qaaQp9fwdHY3
 JcieHbbaO4qPKwinE8Y+LLG7y5rMG4Blu2HZjmC65VilhA3fQcVUbF9Gi7vdxyaoS2gtSN58F8L
 +9umHbaDMRxWZjYWW/yBBroYVnEusu1jYNSprMsL002tWC4eGDrnA6gCw8IT2RENGzQM/Ziy7Bi
 db8eHonlRilVVgPCjPA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDAwOCBTYWx0ZWRfX6o1JG7hr23fA
 pqY518bOavG0snjxQCw6T2zhnoJa3NasMfYC4d972UB+B5i6fl7Yw7klebOxglJOwsv3xShJyYK
 FvTX7Gzy1P/YmJXJg62oRjHKZDbHUl0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230008

Add an NVMe-specific remote-port add helper and update the rport worker
thread to walk the NVMe target list, register new NVMe remote ports, and
rescan existing ones through the NVMe-FC midlayer. Also handle delete
and delete-with-logout transitions for NVMe remote ports in the same
worker context used for SCSI rports.

This keeps remote-port registration serialized in the existing worker
model while allowing NVMe targets to participate in the common target
state machine.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 68 ++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 2c7ecf7bdde9..5f6ee99d0dba 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -5829,6 +5829,51 @@ static void ibmvfc_log_ae(struct ibmvfc_host *vhost, int events)
 		fc_host_post_event(vhost->host, fc_get_event_number(), FCH_EVT_LINKUP, 0);
 }
 
+/**
+ * ibmvfc_tgt_add_nvme_rport - Tell the FC transport about a new remote port
+ * @tgt:		ibmvfc target struct
+ *
+ **/
+static void ibmvfc_tgt_add_nvme_rport(struct ibmvfc_target *tgt)
+{
+	struct ibmvfc_host *vhost = tgt->vhost;
+	struct nvme_fc_remote_port *rport;
+	unsigned long flags;
+
+	tgt_dbg(tgt, "Adding NVMe rport\n");
+	ibmvfc_nvme_register_remoteport(tgt);
+	spin_lock_irqsave(vhost->host->host_lock, flags);
+	rport = tgt->nvme_remote_port;
+
+	if (rport && tgt->action == IBMVFC_TGT_ACTION_DEL_RPORT) {
+		tgt_dbg(tgt, "Deleting NVMe rport\n");
+		list_del(&tgt->queue);
+		ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_DELETED_RPORT);
+		spin_unlock_irqrestore(vhost->host->host_lock, flags);
+		ibmvfc_nvme_unregister_remoteport(tgt);
+		timer_delete_sync(&tgt->timer);
+		kref_put(&tgt->kref, ibmvfc_release_tgt);
+		return;
+	} else if (rport && tgt->action == IBMVFC_TGT_ACTION_DEL_AND_LOGOUT_RPORT) {
+		tgt_dbg(tgt, "Deleting NVMe rport with outstanding I/O\n");
+		ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_LOGOUT_DELETED_RPORT);
+		tgt->init_retries = 0;
+		spin_unlock_irqrestore(vhost->host->host_lock, flags);
+		ibmvfc_nvme_unregister_remoteport(tgt);
+		return;
+	} else if (rport && tgt->action == IBMVFC_TGT_ACTION_DELETED_RPORT) {
+		spin_unlock_irqrestore(vhost->host->host_lock, flags);
+		return;
+	}
+
+	if (rport) {
+		tgt_dbg(tgt, "NVMe rport add succeeded\n");
+		tgt->target_id = tgt->nvme_remote_port->port_id;
+	} else
+		tgt_dbg(tgt, "NVMe rport add failed\n");
+	spin_unlock_irqrestore(vhost->host->host_lock, flags);
+}
+
 /**
  * ibmvfc_tgt_add_rport - Tell the FC transport about a new remote port
  * @tgt:		ibmvfc target struct
@@ -6630,6 +6675,7 @@ static void ibmvfc_rport_add_thread(struct work_struct *work)
 						 rport_add_work_q);
 	struct ibmvfc_target *tgt;
 	struct fc_rport *rport;
+	struct nvme_fc_remote_port *nvme_rport;
 	unsigned long flags;
 	int did_work;
 
@@ -6663,7 +6709,27 @@ static void ibmvfc_rport_add_thread(struct work_struct *work)
 				break;
 			}
 		}
-	} while(did_work);
+
+		list_for_each_entry(tgt, &vhost->nvme_scrqs.targets, queue) {
+			if (tgt->add_rport) {
+				did_work = 1;
+				tgt->add_rport = 0;
+				kref_get(&tgt->kref);
+				nvme_rport = tgt->nvme_remote_port;
+				if (!nvme_rport) {
+					spin_unlock_irqrestore(vhost->host->host_lock, flags);
+					ibmvfc_tgt_add_nvme_rport(tgt);
+				} else {
+					spin_unlock_irqrestore(vhost->host->host_lock, flags);
+					nvme_fc_rescan_remoteport(nvme_rport);
+				}
+
+				kref_put(&tgt->kref, ibmvfc_release_tgt);
+				spin_lock_irqsave(vhost->host->host_lock, flags);
+				break;
+			}
+		}
+	} while (did_work);
 
 	if (vhost->state == IBMVFC_ACTIVE)
 		vhost->scan_complete = 1;
-- 
2.54.0


