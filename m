Return-Path: <linuxppc-dev+bounces-27773-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A42CC982DE
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Sep 2026 01:34:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmsT53hBdz3dKS;
	Sat, 19 Sep 2026 11:33:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789781608;
	cv=none; b=DgitXmhlphR8dIPK2bPArPL5VLZzM6a8igfTEj2EftH3T+70B9ms0LjaaeSqjlOhT1YCt/FhRuCkvQgj5Er873G4LMYM6PMjf21jIWsabBu3ucRBCRpXyZGgYDUtVM9VUxl2ASAHDRvtCggyRMMu3DX5hfQ3Vsl4vCfuXL30420jfKcvM/OGkrepl4QZuYwHKUqMklTKytJ8Q2uKK4r14Le/36FRlPnIUvkQ3RwLtc48tTAHZZUbj7FAB/O+EsiVKs7ygSTzt+CTvXSS4KNle8skvp71C3Hc1fNpp4eYkiCtH0YDHjU6yenLTlNZoAZ0ONBi+cKIL1iItAb/ICg1ug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789781608; c=relaxed/relaxed;
	bh=310Q0AU+M7NgMF0sYKFvE8ZmxNTxAi3GC1xzvNzQwwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZzhnUZrOcyPMLHBe8UG9xbUvxtSMZk3flMgcYCfhCu1bihuq89xJZqWpUXQEf/Bk5vmbXxLHw6jhpJR3PRnmljRqzC7e7EL9oCtLEuyi3f76v/tVMIcjMByn1cNep1u4kYJ3T1lMOPNbG+asHCbd3FCi1m3pvjwMoQ3DSxxVV4Pjl68CHRF3vpIGp0JTrfS34u/yJ/RRyZkiju2rS7XFgMwkQVbbuao0VmlYCMES0PXXj3snacGzTrJrtiGt5GKS2+lscEgd9GlMFdZe7PFGDSeTbMolvqM//BPQliHAaP0SzQN+sABXLGqGc2lJhFCjQ+Yresc4hArNoFRgxHdJAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BjPR+Zfp; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BjPR+Zfp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmsT34LLLz3d8N
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2026 11:33:27 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68J01YgG2662346;
	Sat, 19 Sep 2026 01:33:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=310Q0A
	U+M7NgMF0sYKFvE8ZmxNTxAi3GC1xzvNzQwwc=; b=BjPR+ZfpOb3NRSwZ8tfaep
	1tC8mEBZM5LIxW9K1DYtFQ6TeOnqpUso+589XixUHBz+MLWe4UNSaI4TickkXrTW
	PBagZn6dhUjnQdwXLYCUakhi7VvisCde5qBhV7TNpb48Yw+KZyfJs6Vyaoce+jWK
	KCVf0qrwN85k2lXSKyzvOQWOOBvjx2rU6mQa7rFHFNhjHbKPgxRIrBduQSLWZvQG
	OTwc9bwm1KwZrWhPLPxli/AzUI9EwOsEJwlJI9QdrhlQqJfp4vmPgae6FITctF0F
	CK/M+x6iJ6tDZEMzZfM7GZ+t9jz9pBtykqrE7E1LSAfhhnt1mA6jYMbpG4Mf07rg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx84b0jc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 19 Sep 2026 01:33:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68J1SRM71608298;
	Sat, 19 Sep 2026 01:33:23 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gsgrx00aj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Sep 2026 01:33:23 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68J1XMq932244444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Sep 2026 01:33:22 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A96558051;
	Sat, 19 Sep 2026 01:33:22 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B57945805A;
	Sat, 19 Sep 2026 01:33:21 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.101.145])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 19 Sep 2026 01:33:21 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH v2 15/20] scsi: ibmvfc: unregister NVMe local port on adapter removal
Date: Fri, 18 Sep 2026 18:33:01 -0700
Message-ID: <20260919013306.2948028-16-tyreld@linux.ibm.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE5MDAxOCBTYWx0ZWRfX/FqsA9kZCGV5
 yutD1ntOLAzn0KWA+21JUspHF+LIYrq0PSJvuInj5HiKHFw4e4YSEd0XGZc0CFujXb1k9pHRjV8
 mEAKpa8c4VmYQlw/tA+JW7kq70bkOiXh3ye4bbD9ljh2W6pINdCF4jCUJTCVYBdmEPPwks3ZyqX
 eiHSlb4+PgwFF7r4KDl3LXsCDB+MrCI82+vekYEg3qoQRgt0gW7LMU3nFvqZQb9LuccrD9BzyVN
 W0h77hD5XukvdvKxgQGqKaiArAIuqNw1K0eG2vfmrN/TtLwEV0fyrzO8TEyRD95WSfhPzaUUwmC
 z7hGqzTnXR3qwicX6+AYs3nH9VVyrODO3ms3InyOtEHJldHt6iVliFXWIndD5WJJ8a+gjzVsHfd
 bqW2A6SBE8Up5UXBPC23jjkvIx3RKLzgpdGc2/6V7Lt0PdWd8pb+7AYc5EOjoVHxjmfjPCkaCPu
 DU40xxVjTekK5H0iQBQ==
X-Proofpoint-ORIG-GUID: 4PerKHZR_iOQ9sHzWzK6yRKUHRNtvq6a
X-Proofpoint-GUID: 4PerKHZR_iOQ9sHzWzK6yRKUHRNtvq6a
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE5MDAxOCBTYWx0ZWRfX+RkkVwc2/Epb
 pYTeNEvRQig0lBgsZvpHL2GV4OQkjXOUs6zBsGG3KhdPnS02OlHSH5lOwIhy+FLoiTIXEqbXWcd
 iIRA/bx/rxb5EEH3Avedi1NTHdlGbQQ=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aade664 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=ETEOwY9weeunu4j8P0UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_07,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609190018

ibmvfc_remove() tears down the CRQ and frees all host memory but never
calls ibmvfc_nvme_unregister().  The NVMe-FC transport therefore retains
a live reference to the local port whose private pointer points into the
now-freed ibmvfc_host, leading to a use-after-free whenever the transport
subsequently touches the port (queue creation, port scanning, etc.).

ibmvfc_nvme_unregister() is already called from the NPIV logout and host
reset paths during normal operation; driver removal simply missed it.

Add the call after ibmvfc_release_crq_queue() — at which point the CRQ
is torn down so no further completions can arrive — and before
ibmvfc_free_mem(), so host memory is still valid while
nvme_fc_unregister_localport() runs and waits for the
localport_delete callback to complete.

Fixes: 86e495358096 ("scsi: ibmvfc: implement LLDD callbacks for mapping nvme-fc queues")
Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 080312ff0a93..e68ed5e79e58 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -6976,6 +6976,7 @@ static int ibmvfc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 static void ibmvfc_remove(struct vio_dev *vdev)
 {
 	struct ibmvfc_host *vhost = dev_get_drvdata(&vdev->dev);
+	struct ibmvfc_target *tgt, *tgt_tmp;
 	LIST_HEAD(purge);
 	unsigned long flags;
 
@@ -6992,6 +6993,22 @@ static void ibmvfc_remove(struct vio_dev *vdev)
 	fc_remove_host(vhost->host);
 	scsi_remove_host(vhost->host);
 
+	list_for_each_entry_safe(tgt, tgt_tmp, &vhost->nvme_scrqs.targets, queue) {
+		if (tgt->nvme_remote_port)
+			ibmvfc_nvme_unregister_remoteport(tgt);
+		list_del(&tgt->queue);
+		timer_delete_sync(&tgt->timer);
+		kref_put(&tgt->kref, ibmvfc_release_tgt);
+	}
+
+	list_for_each_entry_safe(tgt, tgt_tmp, &vhost->scsi_scrqs.targets, queue) {
+		if (tgt->rport)
+			fc_remote_port_delete(tgt->rport);
+		list_del(&tgt->queue);
+		timer_delete_sync(&tgt->timer);
+		kref_put(&tgt->kref, ibmvfc_release_tgt);
+	}
+
 	spin_lock_irqsave(&vhost->host->host_lock, flags);
 	ibmvfc_purge_requests(vhost, DID_ERROR);
 	list_splice_init(&vhost->purge, &purge);
@@ -7000,6 +7017,8 @@ static void ibmvfc_remove(struct vio_dev *vdev)
 	ibmvfc_release_sub_crqs(vhost);
 	ibmvfc_release_crq_queue(vhost);
 
+	ibmvfc_nvme_unregister(vhost);
+
 	ibmvfc_free_mem(vhost);
 	spin_lock(&ibmvfc_driver_lock);
 	list_del(&vhost->queue);
-- 
2.55.0


