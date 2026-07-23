Return-Path: <linuxppc-dev+bounces-24692-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66918C44536
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 00:34:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5Bw35zLdz2y32;
	Thu, 23 Jul 2026 10:34:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784766883;
	cv=none; b=kRDQWR/XJAp9OPpy7aR9dhFKFOdh7t8lx/DMKubPLN2cKpp1uUpa6ydPz0OYtyRSLOhP7jlKS3kKlsF1mS9Nd1qtf3t9OQaN/wec1Q9d3RP/UadmFu0KfMwZErjy9HMdUjHy42viYcREIiondRjnF+H+OnzuqFCjmeI4OUO4fMxw5BeE+V9ruk8ob+Zq7lyPV8Y0USD+9ufYcqxbUjf8VNEkRz5nrCakeCitdn77zs9iIf+Ez7TSpB1GLTeHB0fMhIbDi9ww8sWiz7ddFE9KXmsCEDgHJdKAdrQFsH0zA7uQRhznO1zo3r7Qf2udcZ1CdfTq7u7WNvUvGK3z8OMQdg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784766883; c=relaxed/relaxed;
	bh=sDNPa6wXw+Ks8qTqC6NbIMJaUjkuU+9RGij6V1ICQ9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzeO1GNZFU+AeGahWQyu9rsWy2Wc6zjobAu3XSLpiGZVeRCCvu5lyH7u72go2O/8gGeZgYjIqr3JIkJxinyBKEHNPuY0aXivqk+aTB+A9cQrgv3DmNvxkmP4UV+Xk9Af9LJ3h80guHXJZOn9xsX790X/XvpWjlYiHnAnKbqKk5eHieS6dZcvQ9FiffwFjJWO7F4srA+IgcqEn4plzRo4BzyLuxybD0N6VCJ140hiBnoF7UIOCNyUvGcpZEYYLMU6A/mmvE/f3XeM6vewIdqpxZKpcITSctcQ5dPYPcZmn1cppgRCKvbex0nwU88EH06+29bUrhwJIZjewqrzUPYUJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aYvIOg2e; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aYvIOg2e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5Bw26f3dz2xqJ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 10:34:42 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MIBlmo712690;
	Thu, 23 Jul 2026 00:02:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=sDNPa6wXw+Ks8qTqC
	6NbIMJaUjkuU+9RGij6V1ICQ9M=; b=aYvIOg2e42kI6Bzq97Xt1cflBLtFkjxYF
	DBbfKa+9LNocU5PT6bf7DwAbPS4PvjajsmxF1GYQSsSC6b/Q06To4UAhIG5/1J7N
	/LJh9gE/hdSaLhbf5un40+t9zrsqiSKATeaT6Nb5dxBEBhC5nMBe/MZAnB1gDg3r
	rdUYgAT3Tre9bDcOAwp1gn3km5mQG55v4aTjvl/9h2rOujHFa4X7PktcIc0vfCSF
	+E1BKpluBSSjtWNxKWhPeFSP8YuXNduJBtzaVACmgxfhGHxpGvTE1YXTzq1raFwn
	LpnHJ+jIhH8CudhVahdw9aI/n4eoO4Y4NWXN96MxUUi1F+3uRQ/Hg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7914xq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 00:02:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MNnddP021718;
	Thu, 23 Jul 2026 00:02:12 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6w9uk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 00:02:12 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66N02Bur19333660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 00:02:11 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87B5058060;
	Thu, 23 Jul 2026 00:02:11 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFD375803F;
	Thu, 23 Jul 2026 00:02:10 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.118.58])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 00:02:10 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH v2 24/33] ibmvfc: register local nvme fc port after fabric login
Date: Wed, 22 Jul 2026 17:01:40 -0700
Message-ID: <20260723000149.969416-25-tyreld@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: DmJg3rPIcT7hWj7UViLX8z8A7CUYCi1I
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a615a05 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=_Vi487lK4oBJGBne3sIA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDIzNCBTYWx0ZWRfX6RTykWbMQkre
 P1ZARnJJ7XgRdZr01P1hlhhC0r4dMTrUQPC7ZenJHFI6RKDhllTPiXd0sGfhBqg7ps2HeAj/aDv
 PrtXppNwrWQsGvs91MzMZsTi6XUCRho=
X-Proofpoint-GUID: DmJg3rPIcT7hWj7UViLX8z8A7CUYCi1I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDIzNCBTYWx0ZWRfX1+HrFx3JJAGo
 K1tvb+oFhOy1pBOs80S9TOrJsNfxBvP5rW5IyInYkX9lTfAjbIFqE8P5BA2YjOpEWbWgWrdaMRx
 WoIfsXx8lriZLaxtdy/B2xkuxLWs/Eb7eNQVoDbfc7w/AuxkgwwC55cX5bWW48Drk1t17BGaP6u
 Sri9VEGFrdAq5ehaJ+0qfQJMizi1LvuUoQ95AYgtgsjftI9slFEbwizjSiwAT2mk04NVlLlaNHa
 BqSrVFqdhEWF+FQ1rdr06aC/SHsTjPvlBJJKwXJSzegMYqQcj66LjVChr2lJ22vjjLsj42xnTVg
 CxtR7HsX1g+qJnatpuN6Fwtz5+mJNIn/gbcRta7ijWdetusCUn9gHKsW9/YJS7GAVNh7FVOPnwZ
 IiFUyyFbQp4PmKszyQvfgfffaOfxfUGfdIV72uDuivjA1wV8QxtEnLrlz0spZcmgmgXcnia3BKq
 gbZNqYwXqhXt2stdBDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220234

Register the local NVMe/FC port only after fabric login has completed.

The VIOS returns the client port ID in the fabric login response, and
that port ID is required to populate the local-port information passed
to the NVMe-FC midlayer. Delay local-port registration until that data
is available and update the registration helper accordingly.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c |  5 +++++
 drivers/scsi/ibmvscsi/ibmvfc-nvme.c | 17 ++++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index ff84ca0f9f45..81d9229bf388 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -5210,6 +5210,8 @@ static void ibmvfc_fabric_login_nvme_done(struct ibmvfc_event *evt)
 
 	switch (mad_status) {
 	case IBMVFC_MAD_SUCCESS:
+		fc_host_port_id(vhost->host) = be64_to_cpu(rsp->nport_id);
+		ibmvfc_nvme_register(vhost);
 		ibmvfc_dbg(vhost, "NVMe fabric login succeeded\n");
 		break;
 	case IBMVFC_MAD_FAILED:
@@ -5271,6 +5273,7 @@ static void ibmvfc_fabric_login_scsi_done(struct ibmvfc_event *evt)
 
 	switch (mad_status) {
 	case IBMVFC_MAD_SUCCESS:
+		fc_host_port_id(vhost->host) = be64_to_cpu(rsp->nport_id);
 		ibmvfc_dbg(vhost, "SCSI fabric login succeeded\n");
 		break;
 	case IBMVFC_MAD_FAILED:
@@ -5653,6 +5656,7 @@ static void ibmvfc_npiv_logout_done(struct ibmvfc_event *evt)
 	case IBMVFC_MAD_SUCCESS:
 		if (list_empty(&vhost->crq.sent) &&
 		    vhost->action == IBMVFC_HOST_ACTION_LOGO_WAIT) {
+			ibmvfc_nvme_unregister(vhost);
 			ibmvfc_init_host(vhost);
 			return;
 		}
@@ -5931,6 +5935,7 @@ static void ibmvfc_do_work(struct ibmvfc_host *vhost)
 		list_splice_init(&vhost->purge, &purge);
 		spin_unlock_irqrestore(vhost->host->host_lock, flags);
 		ibmvfc_complete_purge(&purge);
+		ibmvfc_nvme_unregister(vhost);
 		rc = ibmvfc_reset_crq(vhost);
 
 		spin_lock_irqsave(vhost->host->host_lock, flags);
diff --git a/drivers/scsi/ibmvscsi/ibmvfc-nvme.c b/drivers/scsi/ibmvscsi/ibmvfc-nvme.c
index d679d1ca366a..637d7d7015cf 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-nvme.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-nvme.c
@@ -145,14 +145,17 @@ int ibmvfc_nvme_register(struct ibmvfc_host *vhost)
 	pinfo.dev_loss_tmo = 0;
 
 	rc = nvme_fc_register_localport(&pinfo, &ibmvfc_nvme_fc_transport,
-					vhost->dev, &vhost->nvme_local_port);
+					get_device(vhost->dev),
+					&vhost->nvme_local_port);
 
 	if (!rc) {
 		ibmvfc_log(vhost, 2, "register_localport: host-traddr=nn-0x%llx:pn-0x%llx on portID:%x\n",
 			   pinfo.node_name, pinfo.port_name, pinfo.port_id);
 		vhost->nvme_local_port->private = vhost;
-	} else
+	} else {
 		dev_err(vhost->dev, "Failed to register NVMe fc localport (%d)\n", rc);
+		put_device(vhost->dev);
+	}
 
 	return rc;
 }
@@ -165,9 +168,17 @@ void ibmvfc_nvme_unregister(struct ibmvfc_host *vhost)
 		return;
 
 	if (vhost->nvme_local_port) {
+		ibmvfc_log(vhost, 2, "unregister_localport: host-traddr=nn-0x%llx:pn-0x%llx on portID:%x\n",
+			   vhost->nvme_local_port->node_name,
+			   vhost->nvme_local_port->port_name,
+			   vhost->nvme_local_port->port_id);
 		init_completion(&vhost->nvme_delete_done);
 		rc = nvme_fc_unregister_localport(vhost->nvme_local_port);
-		if (!rc)
+		if (!rc) {
 			wait_for_completion(&vhost->nvme_delete_done);
+		} else
+			dev_err(vhost->dev, "Failed to unregister NVMe fc localport (%d)\n", rc);
+
+		put_device(vhost->dev);
 	}
 }
-- 
2.55.0


