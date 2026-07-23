Return-Path: <linuxppc-dev+bounces-24694-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF47C44536
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 00:44:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5C7C21nPz2xqJ;
	Thu, 23 Jul 2026 10:44:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784767463;
	cv=none; b=KYgLk4Egpa4/SSbKa8DTER4RNmaBxRI2BW7JLbkSHGUklDKhGiuzBUFHsQ5SuWYVXwI94Vo93sHAKmeG0ZGolTIjCQaMlX9MCQRXArSauIAFASTo7VLv3th0nUaV6da4+piDmuIkYSSQbDcD7uZcs+fNj2ynpxq+CU191XDXPsIENUUFfneh7dXgLf/W5+mU8kRk1aHZBZtsKzPrqtjIbrmGsGnlCGQkNJzjcKEQw51jv0qPVQ0afTemV39osWkVYZcRj3sc55Q9c4fimpk9xZ68PwAYW7GUv5Ri4EScL/zw8qmUty6SiA3BkuAeY0FntpKi0m2/tQ00K2COQ+Np/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784767463; c=relaxed/relaxed;
	bh=US34XbCYd7ORMPavVLu5i7Qe98UktG9XrvNR6jCdDhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQ7zevJJAwUhrqrC6daR24ryCpFR/HuaoyXAleSF0evQxZ7KS6AIfc9FN7HZ6iq2UT2RPrOEvnq4FWSDr5ngfPzU0UlO04wzMm7Vdc+5thewbget0O+1Zu8jU7ShjBUPWj8wn2Pz5+P+9rxkvFMc1G7m5Ck4dXLKIdC5qP2vEFICjanBJFcBSkLFJC60lSyH23SVmQnjBZI0KNKg2/GteoblI1GOTKCFqIcVcoBuseHaZshtDs5nvcEGLo7KEugAaasDdP38i67Lh6P08qeZF2IcOMJyPwSRyS+FQQEG/q5/jagDbVMKqwAXJ5hLmCoKrQvhOCLKfpxFXanzpY5IyQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nLgW2L2k; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nLgW2L2k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5C7B2WNbz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 10:44:22 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MIBeQm704617;
	Thu, 23 Jul 2026 00:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=US34XbCYd7ORMPavV
	Lu5i7Qe98UktG9XrvNR6jCdDhE=; b=nLgW2L2kEDgdUMaP5ohZi/JX0ovMK1hWR
	7BdLcbL3JXjOLh4F7Szd0OJh7Jx069n1HIqIszGZGUvR+Jo8rMBPH1o6SBrDUc4u
	g8h4m+T73GpOWGf2btczrTo6V2R6dZT5emHyxnPQXZ+srtDog8jrvpIRlH9RrahR
	amxQMYP9lBikEDsLzpAbWOheGoYJNYL4bmAuyywww9AcOi8PKGw9Mq2yOEs0hZ8S
	h7j/7u6qxiVyJ2geEBEzVPAgteFFGzMg5ZNj3VOIttlGTRL++HZNekMsjLbE7Te3
	U/7NATwpzxi7SGJYnxnJ7NrjvAAdhJVVqN23Q7AUze3Io7L9Uso/A==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7abmynr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 00:02:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MNndSY032298;
	Thu, 23 Jul 2026 00:02:10 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk1rsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 00:02:10 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66N0299T19399180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 00:02:09 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4063A58061;
	Thu, 23 Jul 2026 00:02:09 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B7975803F;
	Thu, 23 Jul 2026 00:02:08 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.118.58])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 00:02:08 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH v2 21/33] ibmvfc: delete NVMe/FC targets as well as SCSI
Date: Wed, 22 Jul 2026 17:01:37 -0700
Message-ID: <20260723000149.969416-22-tyreld@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDIzNCBTYWx0ZWRfXyIPaHWqsleSB
 tKp5yQGoGXVXvcPncbGxL0hI861gjhyYQ2rCx3QqmandpnesNPEgtMzyuNArtiJg/Bwrgdiccw+
 Ns7W9pW/hbElYvLTB++EuaR+FGQQbxbwVEUhhMNYVOWiKeuRsoIxJdrm6fa/GEkgY3BhJHCjHe6
 GDi3obt3jTVhgxLdruO8V4P6x605dWA9Mq3LBy4Ena+lqLJjHuIq+L7AT32Jy/EkRtTNL3Yj+cQ
 z8v0jo1y0zSc13jOZej0x3z7q++5jY1voOeatdOUtccPNB/49x5qHR1C5K3qyYwHv1qjGsynP+S
 Eq+IXSaxQy3qngv84XWQH/00Hbx71JrGPOQrrmFp0Rp2IR8k02CeUZO+fUQHpVk2vO1DqPiSwaD
 lU7if1gIbMUZ4SlK7dtFTkYv8jcY6duVDlstHFl7w3ZOP+7xbP5/1kNQr8usseyoJe+6HeamSCl
 BvDmy7cse/ZstxWVrGQ==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a615a03 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=ogk_YF86eJEipFHfCJ4A:9
X-Proofpoint-ORIG-GUID: eGejvfYrabx76NvuXhR0-ltW6kqH-feq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDIzNCBTYWx0ZWRfX8IuyRxl/JozX
 pR+I+ur8KRMZHgMPhGWnhD3QLlFRmgL1xFgimKWYinbX50OY4EofJ2iBG/47iX/FB+wh0LJD1kL
 I3COxQY6Ij+gtZMA0jXnYEHi1qjy/Yc=
X-Proofpoint-GUID: eGejvfYrabx76NvuXhR0-ltW6kqH-feq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220234

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
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 92c286cfc69c..1185d72a8a73 100644
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
@@ -1870,7 +1878,7 @@ static void ibmvfc_log_error(struct ibmvfc_event *evt)
  * @sdev:	scsi device struct
  *
  **/
-static void ibmvfc_relogin(struct scsi_device *sdev)
+static void ibmvfc_scsi_relogin(struct scsi_device *sdev)
 {
 	struct ibmvfc_host *vhost = shost_priv(sdev->host);
 	struct fc_rport *rport = starget_to_rport(scsi_target(sdev));
@@ -1922,7 +1930,7 @@ static void ibmvfc_scsi_done(struct ibmvfc_event *evt)
 				memcpy(cmnd->sense_buffer, rsp->data.sense + rsp_len, sense_len);
 			if ((be16_to_cpu(vfc_cmd->status) & IBMVFC_VIOS_FAILURE) &&
 			    (be16_to_cpu(vfc_cmd->error) == IBMVFC_PLOGI_REQUIRED))
-				ibmvfc_relogin(cmnd->device);
+				ibmvfc_scsi_relogin(cmnd->device);
 
 			if (!cmnd->result && (!scsi_get_resid(cmnd) || (rsp->flags & FCP_RESID_OVER)))
 				cmnd->result = (DID_ERROR << 16);
@@ -3306,6 +3314,22 @@ static void ibmvfc_handle_async(struct ibmvfc_async_crq *crq,
 				ibmvfc_reinit_host(vhost);
 			}
 		}
+		list_for_each_entry(tgt, &vhost->nvme_scrqs.targets, queue) {
+			if (!crq->scsi_id && !crq->wwpn && !crq->node_name)
+				break;
+			if (crq->scsi_id && cpu_to_be64(tgt->scsi_id) != crq->scsi_id)
+				continue;
+			if (crq->wwpn && cpu_to_be64(tgt->ids.port_name) != crq->wwpn)
+				continue;
+			if (crq->node_name && cpu_to_be64(tgt->ids.node_name) != crq->node_name)
+				continue;
+			if (tgt->need_login && be64_to_cpu(crq->event) == IBMVFC_AE_ELS_LOGO)
+				tgt->logo_rcvd = 1;
+			if (!tgt->need_login || be64_to_cpu(crq->event) == IBMVFC_AE_ELS_PLOGI) {
+				ibmvfc_del_tgt(tgt);
+				ibmvfc_reinit_host(vhost);
+			}
+		}
 		break;
 	case IBMVFC_AE_LINK_DOWN:
 	case IBMVFC_AE_ADAPTER_FAILED:
-- 
2.55.0


