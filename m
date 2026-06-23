Return-Path: <linuxppc-dev+bounces-22903-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7921FCDB46F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2026 01:33:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gknZx1sJCz3brC;
	Tue, 23 Jun 2026 11:31:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782178264;
	cv=none; b=fEs/rnjtzzpUpmZBuKblsbhy+0AlDdhO/tyKKd3awii95oXxTMUdX7pkGzh6ff4zai0MjbhmXQTJYuTUKNy7kFKIbgWYO+BpJTDUMLE/7fhn5DKaxy+XUHGQ/l2HKl3HcFzJj5k7y+kBiYsK9oagSKpkcw/2w+5Dh5NIoKe56YDQuIO247JEhujDDEZUgRwkLbiVJN3k8MfSqIrN2pWzGkizAZBbZqThZtL6L5GHdcbxsu74L0YiEfkbDPXdwmEoUd8L04V7FjgU+gWURu0BW2Cv9aVAZW2i2xYlikZAtfd1eRK7o4Qkzr0YFyYH1p3NmGAyyJSoOC8yaMtWlx+VkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782178264; c=relaxed/relaxed;
	bh=NzzMzrvh2G4aI3GfQM7XGlh4HeWzJSQ29GFgBDju5do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QSfELPhFR5kCNj6PflTFpXV0w6425bpY60vvskuNDnMgY02eAmtjW0aFriF+DFXv4dEXsv4Fd1slhrn4GPcBYO4HlCVJ/MhMHhWazVcDY11Jguopdyn0lvK5HsGFoJq+h2f+piWr0Y3mB2PCzqP9zA38SLRsz07OtY6NMtzvt1w8TbhImVIpR5pbyUTG887b04bYiQ0HjypLIrcM0HXwTs5sPL8axYqFExBJ0FhmyVCUUEAmIXN/eRkkDLASfEZK/GRFRsicwUu8vbOIGhThtEfhYORNsy9gU2DDBt4vfQAOnwphZEzn9BOaY+x+4EIMvNOABh8oF7OtjtXOsKvFzg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lx6Tw8DB; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lx6Tw8DB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gknZn0Rq2z2yvT
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 11:30:56 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N0oJC1286129;
	Tue, 23 Jun 2026 01:30:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NzzMzrvh2G4aI3GfQ
	M7XGlh4HeWzJSQ29GFgBDju5do=; b=lx6Tw8DB+/pLdfvVc9Po7qJn4/kuCcfd/
	+UigeFdy0iJNk2X0tJmx8Rqc43ey9au8umQGvdCE8qaM/D4qvTyTHx/JnPqQRNDk
	BRKUjatiGi4xOmebwpA9CqqDh8KNTfpzESmlOEJBt7fXzsqQNeD2IeOuQD02nU0g
	5GmWhnuHjWAjqyWmfp3sMrdBtAxhJHh26LhTrKUXW+Ltt+Jfk/fNBixWMZPgvKP7
	W3Kv6hERo19lboQbQ4qscKop7s9q8C/xCJ5v/KZmHNdIgbBDDgyEMHFB/kscuq2u
	GhGOLLPForvkRjiIrwIF18BroxoyMif956aNjx5C7s5dX5g4Ji0Ww==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgskys1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 01:30:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65N1Jgp7014680;
	Tue, 23 Jun 2026 01:30:54 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6ph8vme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 01:30:54 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65N1Uq8318547232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 01:30:53 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9504458056;
	Tue, 23 Jun 2026 01:30:52 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05C3558052;
	Tue, 23 Jun 2026 01:30:52 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.188.206])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 01:30:51 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH 20/29] ibmvfc: register local nvme fc port after fabric login
Date: Mon, 22 Jun 2026 18:30:26 -0700
Message-ID: <20260623013035.3436640-21-tyreld@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDAwOCBTYWx0ZWRfX2WG6acaiiAW9
 tRROFk54iEgKXY5wgMOjNLDdU1l3Su1fnsEzPHm5FnJH4/RMZ6k1S7QUADE4AsIj86jKiVs2itp
 NcYDYW4G3+Uo+sZxv66Gf/grFUDJiey7SY/DVm/oCk0fbsEpBq/hacZ95LmugKJIMiGQ1Q8zKTF
 8efznHw0ZWvVvC469Q2MLHc5VNcaTQ5NGVfiayvMUWqEJRNkh3y47DGOU0U+uuJI/T0+aCc6RYM
 gOWpu/RxrAxDqeao5lmgol3UeIvSYiDD+LAZihN1fahsgIjjTTsRlqYFKemDqGLlYSgm+yPoec3
 PSWEnhN0m7NnfDlMbDAFy8HeInGL2spUwv2sNc+Duva1zSAaPmAwBo35z5LB0VFt590ph9GJta7
 g4/MrA6F8cX+808H/LiJ78DSCrGpl/LnwrP0+cwG/T1598LsWdGyGwQ8BhS/xFcpU59bZ9GDDSX
 Gd6NFV9AEk1/ui8lxOw==
X-Proofpoint-GUID: K6X1ZiZR1D_xqD0g1vntUyPAoWvK05Pl
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDAwOCBTYWx0ZWRfX/jgCjCgUHYSa
 42oj91y6mLrFnumFUPJcoqDG/6im6AaPBthRJJOppLUgilV8/sbM74Evg6sVzWJRty5mznYMU2I
 uMqcsp76/p7h4Iyq7/r2i9fuy1qYcgk=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a39e1ce cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=vSfUSS9DNbx-ZO_tdLQA:9
X-Proofpoint-ORIG-GUID: K6X1ZiZR1D_xqD0g1vntUyPAoWvK05Pl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230008

Register the local NVMe/FC port only after fabric login has completed.

The VIOS returns the client port ID in the fabric login response, and
that port ID is required to populate the local-port information passed
to the NVMe-FC midlayer. Delay local-port registration until that data
is available and update the registration helper accordingly.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c |  3 +++
 drivers/scsi/ibmvscsi/ibmvfc-nvme.c | 18 +++++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 9a6a885aa57e..2c7ecf7bdde9 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -5184,6 +5184,8 @@ static void ibmvfc_fabric_login_nvme_done(struct ibmvfc_event *evt)
 
 	switch (mad_status) {
 	case IBMVFC_MAD_SUCCESS:
+		fc_host_port_id(vhost->host) = be64_to_cpu(rsp->nport_id);
+		ibmvfc_nvme_register(vhost);
 		ibmvfc_dbg(vhost, "NVMe fabric login succeeded\n");
 		break;
 	case IBMVFC_MAD_FAILED:
@@ -5245,6 +5247,7 @@ static void ibmvfc_fabric_login_scsi_done(struct ibmvfc_event *evt)
 
 	switch (mad_status) {
 	case IBMVFC_MAD_SUCCESS:
+		fc_host_port_id(vhost->host) = be64_to_cpu(rsp->nport_id);
 		ibmvfc_dbg(vhost, "SCSI fabric login succeeded\n");
 		break;
 	case IBMVFC_MAD_FAILED:
diff --git a/drivers/scsi/ibmvscsi/ibmvfc-nvme.c b/drivers/scsi/ibmvscsi/ibmvfc-nvme.c
index 202e8d0b0081..fc4337fc9b3f 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-nvme.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-nvme.c
@@ -137,14 +137,17 @@ int ibmvfc_nvme_register(struct ibmvfc_host *vhost)
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
@@ -154,9 +157,18 @@ void ibmvfc_nvme_unregister(struct ibmvfc_host *vhost)
 	int rc;
 
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
+			vhost->nvme_local_port->private = NULL;
+		} else
+			dev_err(vhost->dev, "Failed to unregister NVMe fc localport (%d)\n", rc);
+
+		put_device(vhost->dev);
 	}
 }
-- 
2.54.0


