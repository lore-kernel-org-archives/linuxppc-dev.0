Return-Path: <linuxppc-dev+bounces-24681-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B309DC44536
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 00:03:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5BBh24YQz30GG;
	Thu, 23 Jul 2026 10:02:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784764940;
	cv=none; b=ijNtxgf6CcGCbyN+7tK7T3lzk1KmU0WvQdqgJfapGMKmY6OngAV7ZTrvWN3IpdnOC8i3gaUNljhklQx8K1rWecbaAfWZbamqg/5zdEsLQz2bvO3x9RnnTvpmTxb6uFj+O/WfQCnr8/wpM4DIVIuDJhysJN3HYpO/+87jZiY4JDaYLG4s5OOFZdtMY/BvBCpLOGztf0IySWL27Cgg13vvAHD3Ypz3Fh8Hii1rV5dnLY5f5MibFvnYMexEcNiFrIZUnX5Bibk3Jdy5YLALfmt39vAw0T2s4IVBIUqFXTQpSnfh5+kZx7AQ8Qx6idLDC3bHBRGAy1ww25pVPJJz2z/YRA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784764940; c=relaxed/relaxed;
	bh=BJ5jHeQTDxl67GLnfENEsPi2OjxPVgqvUKko7n43C8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RhOwZtMywhP0HfWlNUxIH89Uqcpd8C3ZHJIlFbYPbRpqXrfsW0aT0UaQ9trRIIvK5jmfDER20Q/urOmq1KM2ODAxJY37egbsOJ7qOKJO0rL99ko+MKmzP4EUbgC6Y7xoMVX8qng7K1Af2fI+DSgE8eoso384hAGcUUMO81fhdYj6I2phs7eCrp43HYwn6d3MZM3dqn2IvB1Seu4yppLaFNyW3gXm/4jb9qzG5gzI9F/q0t1MvZYW+/SK2P56z+NYvXVxgwvcy+7N4o3zV9aUkVYE2QtInINe9pKqHMkWlNODkJXHJ0ag6YJTJ68i9MtIsOm+YpRCe1kE15HEQEGlSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JS///tho; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JS///tho;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5BBY2klLz2yv8
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 10:02:12 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MIBuF1633559;
	Thu, 23 Jul 2026 00:02:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BJ5jHeQTDxl67GLnf
	ENEsPi2OjxPVgqvUKko7n43C8U=; b=JS///tho+PGpi+vLPCATKLcZNgxLuRGTn
	3xrb6hgIkbP2Ctb+vfch2ByngQ6ZYWLJoIUDWciiUv4AoTO8oqo0J5LaqB8JSY5r
	Y4OK6KbVyNgm2GiZ8BRgrO8uKLKVKeESiZ53TAEwCYR8czYVfx5wXEmFrrqdWzwH
	fW2v5FDQ6Vh4eWX/Q6E+nzoiKpR1Opx0kCEcbhgMuicsuoJ57zn3bHjTgJgwA6PI
	h93DuMnp8HGJZEJzBwxrMzYLfjX7FpFckEQwrL5P57oKRcH86vpP4QuV/ivOhzRy
	tqEC7dQvG2TmTNQLC+W5BVyi/Eh+dI6VQThOh/r8lJ/4xNhest5Nw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77kce6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 00:02:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MNnaIJ028159;
	Thu, 23 Jul 2026 00:02:09 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnah9q36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 00:02:09 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66N027qq14156420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 00:02:08 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B87A158068;
	Thu, 23 Jul 2026 00:02:07 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17A935803F;
	Thu, 23 Jul 2026 00:02:07 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.118.58])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 00:02:06 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH v2 19/33] ibmvfc: add NVMe/FC Query Target support
Date: Wed, 22 Jul 2026 17:01:35 -0700
Message-ID: <20260723000149.969416-20-tyreld@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a615a01 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=LC8GvMgr8iK42x-OS58A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDIzNCBTYWx0ZWRfX+3H/9POlusqS
 KXSeVXXf5ZDEinGR16MbQZAtOUSCqLQDKK7xF8nX/TIVoJoCyFVCt5QboGUg6PvmnftBRrmGOXv
 OcfEvKK2Qgz6vykRXO77VcugrLJFSOlPOjzq/zZGq+wAQuo0WspfISas/uqCQBrVG7YuczZhr7J
 H9Bsfsr/bsxIPxOwMdJv4vSAEqvdIkoZB8Nl5K/VfO9XCj7E9bw53xqqWYEVnPYL7Z5bgGmQ3Ir
 y2ecnTVl+oc7q6QkLe9pwwCY25ccrC0EDaqZunxGqUNgRr66b9NEvJuFLePK/sfe2dMCYLbojpV
 z4IFX9sXXtpf1AUAM0zPx6U7D8XePDhEimXE7hb81LvZyp1Q1iaeZfQDmPgsUY2j9NRiMgnEks6
 O4+QtCoOzYHeychQvWhbvCTk+PBgrcXhELGXu2EViOgkEYeMs/thSkOmgCUXCYo9WfLlowxpWV+
 9XPUHVksTO6/LVUnu3g==
X-Proofpoint-ORIG-GUID: JC3hbpfeB_YtXl0IXdqFDRJrborjFnpL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDIzNCBTYWx0ZWRfX1jvrgDXIBcjG
 nkbask1xBF0bE41DmymkZ5lq1bm9K+hiprTEdmPqmWQNxjlwYNwB/SfCyvgyOOt5kEdzEvyxnGS
 4HIQLIC0LbiGgIT2UdWIrJpAqEcVnaU=
X-Proofpoint-GUID: JC3hbpfeB_YtXl0IXdqFDRJrborjFnpL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220234

Add protocol-specific query-target support for NVMe/FC targets.

Use the NVMe query-target specific MAD when querying an NVMe target and
update the associated debug and error logging to include the target
protocol.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 5950f143e9a1..b479537e9e78 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -4859,7 +4859,7 @@ static void ibmvfc_tgt_query_target_done(struct ibmvfc_event *evt)
 	ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_NONE);
 	switch (status) {
 	case IBMVFC_MAD_SUCCESS:
-		tgt_dbg(tgt, "Query Target succeeded\n");
+		tgt_dbg(tgt, "%s Query Target succeeded\n", proto_type[tgt->protocol]);
 		if (be64_to_cpu(rsp->scsi_id) != tgt->scsi_id)
 			ibmvfc_del_tgt(tgt);
 		else
@@ -4881,9 +4881,9 @@ static void ibmvfc_tgt_query_target_done(struct ibmvfc_event *evt)
 		else
 			ibmvfc_del_tgt(tgt);
 
-		tgt_log(tgt, level, "Query Target failed: %s (%x:%x) %s (%x) %s (%x) rc=0x%02X\n",
-			ibmvfc_get_cmd_error(be16_to_cpu(rsp->status), be16_to_cpu(rsp->error)),
-			be16_to_cpu(rsp->status), be16_to_cpu(rsp->error),
+		tgt_log(tgt, level, "%s Query Target failed: %s (%x:%x) %s (%x) %s (%x) rc=0x%02X\n",
+			proto_type[tgt->protocol], ibmvfc_get_cmd_error(be16_to_cpu(rsp->status),
+			be16_to_cpu(rsp->error)), be16_to_cpu(rsp->status), be16_to_cpu(rsp->error),
 			ibmvfc_get_fc_type(be16_to_cpu(rsp->fc_type)), be16_to_cpu(rsp->fc_type),
 			ibmvfc_get_gs_explain(be16_to_cpu(rsp->fc_explain)), be16_to_cpu(rsp->fc_explain),
 			status);
@@ -4923,7 +4923,10 @@ static void ibmvfc_tgt_query_target(struct ibmvfc_target *tgt)
 	query_tgt = &evt->iu.query_tgt;
 	memset(query_tgt, 0, sizeof(*query_tgt));
 	query_tgt->common.version = cpu_to_be32(1);
-	query_tgt->common.opcode = cpu_to_be32(IBMVFC_QUERY_TARGET);
+	if (tgt->protocol == IBMVFC_PROTO_SCSI)
+		query_tgt->common.opcode = cpu_to_be32(IBMVFC_QUERY_TARGET);
+	else
+		query_tgt->common.opcode = cpu_to_be32(IBMVFC_NVMF_QUERY_TARGET);
 	query_tgt->common.length = cpu_to_be16(sizeof(*query_tgt));
 	query_tgt->wwpn = cpu_to_be64(tgt->ids.port_name);
 
@@ -4933,7 +4936,7 @@ static void ibmvfc_tgt_query_target(struct ibmvfc_target *tgt)
 		ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_NONE);
 		kref_put(&tgt->kref, ibmvfc_release_tgt);
 	} else
-		tgt_dbg(tgt, "Sent Query Target\n");
+		tgt_dbg(tgt, "Sent %s Query Target\n", proto_type[tgt->protocol]);
 }
 
 /**
-- 
2.55.0


