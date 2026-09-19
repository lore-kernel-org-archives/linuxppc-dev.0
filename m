Return-Path: <linuxppc-dev+bounces-27769-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CFAC982D8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Sep 2026 01:34:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmsT16lJ5z3cgh;
	Sat, 19 Sep 2026 11:33:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789781605;
	cv=none; b=mKsLbxGEBddc/hlbJ5PciuLdCwt0DM/oEszRHHmYbigqU13Qb2km8q+wpQU4MIya1DKyoDofgEENrEUeSX/DjKMQgyGH1tq6hz6FdLM5jT+PF8pV2Xot6BQqkKp+nhDi7CHyCBTWsv4nl3Wo7IzvoieOEMa2xrdojV+wPSwB4gjL63MO4K5AofHWbMdpC+C/Q7iWXIFIOgar508cu9PwZ9M6sY2kK38VrqH8TPznmNnUY6qyCcgzrve6qv8aydO01HaQgE6/nRCKabkCEclq21CSJYJHIZtZU1h16wgk80UZjJjrr9R6RrbTrp8yFp1jKg/vsq+bZgpjsvhBUpAAsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789781605; c=relaxed/relaxed;
	bh=cZdqTE0tCATjfIVYRrm9i0hUu5Zyah3yiFzKFjTCx6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EkCCxSe4VyPq0fOfqNdonYsgbe45vn8t33yoJFmx7oXqdOCZdzQ+/PeJpV8ySQP4vkWI+Y84BV5vOFf2gr6MgKlSbJkOaX5EXGTTCxx8+Tw/Ei2Wv9EoFRvtpal3WxqvV3nVyZgATqcPZ42D0F9Yqi82PCh94BLHTeu9ew2areXavv6WG1I3YTa6bGbZvEMyGbfupLw4IbUOGUWJagENLiRccqJR3OPobKcs6aQXCZTMBI+wb9hkQ0lUnb43sfgGY2bV++P8ejQ88A0FmLZDRiSMuKzc6iIcApQZvN1oZt2BbQuBvPvn4mtN3V89I/ot9E9s+3BjOJyglJlDt7q/sg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rJdhthEA; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rJdhthEA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmsT01BVNz3cQL
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2026 11:33:23 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68J0NwIr2566069;
	Sat, 19 Sep 2026 01:33:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cZdqTE0tCATjfIVYR
	rm9i0hUu5Zyah3yiFzKFjTCx6E=; b=rJdhthEA5AVxmiujsNBzoYZd85/HSYAXM
	NC9qk7/3AKCU4XSer4tECGluTeVsXTgtFL/UwvYSTDXp7V9CxoZVuzVe9U7N9x/t
	epRvKnQEMxp0zW2eYwywIlz8AL7mM9z8MjTzlNh8Yt8aLAxEMusr1s2AItXXKYHL
	0pdFZquYxqWR2VNIRUoN+xcZTngvEKCmUfNXz5SRZxCxO8IVK74HV1Z/YxS4bZol
	u/0exK/NaNQq1F4hJQ3Hj1DFxkClhqMP7E0xsMsZ3hAVW1NhLPkP5Jl+AVCrQF90
	QWSUEZIEc6H2o/gtZY3Kq+C1n7YUFQtQVVqU9iPF8fl66NIU7ExGw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gsftk04hh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 19 Sep 2026 01:33:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68J1Qnha1584893;
	Sat, 19 Sep 2026 01:33:19 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gsgr2r0eu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Sep 2026 01:33:19 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68J1XIlY40960730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Sep 2026 01:33:18 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7943C58051;
	Sat, 19 Sep 2026 01:33:18 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFC465805A;
	Sat, 19 Sep 2026 01:33:17 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.101.145])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 19 Sep 2026 01:33:17 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH v2 10/20] scsi: ibmvfc: fix u16 overflow of max_cmds in ibmvfc_set_login_info()
Date: Fri, 18 Sep 2026 18:32:56 -0700
Message-ID: <20260919013306.2948028-11-tyreld@linux.ibm.com>
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
X-Proofpoint-GUID: vg-10DWfbcuTeC2dp-uSmuo5oKsiOAge
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE5MDAxOCBTYWx0ZWRfXz09b4YbXokaz
 MC7fIL9byxLyMHa5fVdbMltqNG+ivIJFQOmnBxwwbvIVh7/GKLWoCE2xIxRn43YPjwTRsvnR3By
 /91Kt4srNjJPX6GVBMcdZ3b7MwAryJ0=
X-Authority-Analysis: v=2.4 cv=EMaTQFZC c=1 sm=1 tr=0 ts=6aade660 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=oS3JfTuPRayek_SdIqsA:9
X-Proofpoint-ORIG-GUID: vg-10DWfbcuTeC2dp-uSmuo5oKsiOAge
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE5MDAxOCBTYWx0ZWRfX0zdGCPKESEke
 AJ+lKJuDEyRTA7jcSXYyIXU77D+YW4m3w/Xf7YmVE23PKmHguO4PcPJ610/tk1eXHFbcQTZhdBh
 bOwPozo5EvwRAN68F2sIt1/3ByHKflXEa6wx1ajfjVXOrUJBuHyH72Rgz6TgWIQBGSnzPKbAsmM
 imRGCwAYRUc64fgKxt9+oOnwPX2ArhaEeytfOzo9b9nNEmHwfdMVWrviWxNFSrFmfq9ULxW3ZkZ
 1IryRiBTyCB1UZt9rcCOiIFw16ct9nKF0oYYM7dZvvYyyzFk//Tzc0CJk3RCuIi0ty1fbrcYmqO
 BaCoN9Gsowf2D8mCUe7gOAdYZ3uKTQVzQBLDlFuXWPVly63k331jraOiEgkliZQnDHC7O7HrRza
 qMBVTVom2Ge/qZo4TJi5jocXcx143cET0fV/wp9PYEBf8Xr9e7dgwZgA4VyPXaewxwsXUz+eq2F
 M1Yfwj4AsTAX0643/EQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_07,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609190018

max_cmds is declared as u16 but the calculation:

  scsi_qdepth + IBMVFC_NUM_INTERNAL_REQ +
  (scsi_qdepth + IBMVFC_NUM_INTERNAL_SUBQ_REQ) *
  (scsi_scrqs.desired_queues + nvme_scrqs.desired_queues)

can exceed 65535 at non-extreme configurations. With scsi_qdepth=2048
and 32 total desired queues (16 SCSI + 16 NVMe maximum), the subqueue
term alone evaluates to 2052 * 32 = 65664, which silently wraps to 128
in a u16, causing the NPIV login MAD to advertise a badly corrupted
command slot count to the VIOS.

The wire field login_info->max_cmds is already __be32, so widen the
local variable to u32 to match, making the arithmetic safe across all
supported module parameter combinations.

Fixes: ecc03d958e37 ("ibmvfc: add logic for protocol specific fabric logins")
Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 70771f6420d9..623fff503040 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -1566,7 +1566,7 @@ static void ibmvfc_set_login_info(struct ibmvfc_host *vhost)
 	struct ibmvfc_queue *async_crq = &vhost->async_crq;
 	struct device_node *of_node = vhost->dev->of_node;
 	const char *location;
-	u16 max_cmds;
+	u32 max_cmds;
 
 	max_cmds = scsi_qdepth + IBMVFC_NUM_INTERNAL_REQ;
 	if (mq_enabled)
-- 
2.55.0


