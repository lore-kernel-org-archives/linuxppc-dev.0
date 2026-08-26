Return-Path: <linuxppc-dev+bounces-26115-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E271C61DBE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Aug 2026 12:56:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVPml4sdnz2xLG;
	Wed, 26 Aug 2026 22:56:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787749015;
	cv=none; b=d579SvEWc98SCn+nNhNfhENDFw9gJpYyHlASjT1uJn4M/izqigxBpCm3XittWcFVmk7q3hurlmE2YBo0V5GEZWNo6TdKQnXljmhKS32/C0sVXYq15UdhbsDv866E7wh3+ObqjZDa/HRnyuOS4lNTCbp9fktFQ1Sp3ENHWOXgg4PmOYedgul9G/vmBuZgwNr1wL89JyKSF596CDLOui7z06LfUs8kfnwukC6/HxzDeSKrnQwqMqhu2H//fq6WhrJQ2XBedG3Kkb9oX/iX1aYb5KHswYK32yTF7uno2i3vrATv+vcqBmLRXvlbF/L6aLxNAhdh+uFR5dl0oh24obmZiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787749015; c=relaxed/relaxed;
	bh=Iz89pwSV01xjarVMqMNJ+t/TWvCJtm1QXWL7i9kgBqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GhkSOY6WtONiwJ5eiJcl7V9TEj741yP55LeVGVNYxFmR3D3knBdbToZDlZ814we6rEXMoZiAkoFusJCUW3zy9PvFg2pbTsH+Yw6KcdDGvwkuI5ONbBxuFwb6ClgywLhLdKJNKb6xp4GrBaF3dRTWMDBMuOdkutsieRap6ZyfbhVHDkds7SEU9QxpoljhQ76t9mjiuBZm9E0pRPhoC7ahyIh9Uv57NL2olF9EGFprkOeoWR10w4JUiJEV0ayiJZNOprvuKvTztWhVoAKaPPlLVf+li9YOjKIy+ha6Y2rOCoCbbB6S2UZF1z8Ddx9KG46QeXbd2h3WmrJhiWo2yL0SNA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nCCM/lD7; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nCCM/lD7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hVPmk1mqGz2xGw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2026 22:56:53 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QCW6lb2127948;
	Wed, 26 Aug 2026 12:56:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Iz89pwSV01xjarVMqMNJ+t/TWvCJtm1QXWL7i9kgB
	qQ=; b=nCCM/lD7X50RT0ht/3Q89c0Swi/RIABmbsep9wT20o50SfyiDM5JnhieR
	AMzacwnUklTA8sKB5FyBeoqg8V8PNkTvKwsad/fwLPeNLi20bKKVBs7kf/69qyaX
	SOEearAINSHyOMz+FPRJTi1bTOzRpqsvU7GhanVBfUk/OnvYwMvNZcOep332CTsU
	liSRykZ3enky3unvqN9G4QCi1v5zsujLVcQ5nGoOzS5k82g8WjLgqebVi7mtKqQG
	FOsIR7mzNXfpgV6uhFCKlzkMj0p3KeVfX+L7n5b0/ulmA3zUyNEcezFhVTA8RqET
	GAiY2YXXP3260xKwV+cjTD8wyiLHA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqxmxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 12:56:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QCuItS018822;
	Wed, 26 Aug 2026 12:56:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkh9wcc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 12:56:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QCuVUH39846300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 12:56:31 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 616AC2004D;
	Wed, 26 Aug 2026 12:56:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8DA920043;
	Wed, 26 Aug 2026 12:56:28 +0000 (GMT)
Received: from shivang.bl1-in.ibm.com (unknown [9.123.12.247])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Aug 2026 12:56:28 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: sourabhjain@linux.ibm.com, adityag@linux.ibm.com, adri.vero.dev@gmail.com,
        anushree.mathur@linux.vnet.ibm.com, chleroy@kernel.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        shivangu@linux.ibm.com
Subject: [PATCH v2] ppc/fadump: collect dump if the collected size is lesser than reserved
Date: Wed, 26 Aug 2026 18:26:26 +0530
Message-ID: <20260826125626.2108771-1-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: bKV3ttUB_ujWYOfitf5hcb0B1a8vk348
X-Proofpoint-ORIG-GUID: BBhvg5KCKp4UQaQrX9a1pp8zgIMTFlYJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEwNCBTYWx0ZWRfX54rqtNVKW9LI
 aeOa1nI0rX2IAw3vfNTNNUkR4xJ+6SKToP5kBz1t91UkvzDOZyeRu2+ZucbgMaawTNAN47lfGce
 Bbbx+723RcGzslrUVMXjBevXknQIWFJxmp5uhAwvgK2mCctGIvWZmn22iwyojChWLa8SDtRvYTQ
 jdlSY0fFqI33Oon9vdg0j6a6D3Z2B4O05vB0ebEtcpIW6f+LKA1/ErPQhGy3Rf2b7wuwBP7+jRg
 XjSCCBFpOds0rEwEOGVAIsk94hfARYvnH4gVr57YS4FLAsMqkinY9UTsLgeYcGXdc2p6tgPzOIR
 0FS4gBLK7cpX9olrw8RCW+7CFiAmkgy+oyKBK/juUAQPC6oc0XcUY7pMZQZW7SHxWABlS2gb1XI
 kqQOEVwVm977Nqs5psBOlSgK5M7gzclEW8qyrfmjBT2Tz2crGHKKhgzn1BIAigrl+LS5b3bMjl9
 9n1L5oKqk6gFT+YZPPg==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8ee285 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=5S_kJhIZ7htqtmZwQG4A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEwNCBTYWx0ZWRfXxFrycj/w9doj
 dwCQ+M8UIk5oFyIf5Qj+eHApX1sXrTTh6D/rOPWNwGJwPAzy4UJQL3fr+zR2nXKMBpcCqLhztj7
 loAm8d6ukPmfBZ0Kt8odHafz+mADazc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260104

During Fadump in Qemu VM, when maxcpus value is set to more than current
cpus, following failure is observed.

    [0.000000] rtas: Dump taken by platform is incomplete (-1)

This is because the CPU_STATE_DATA is allocated for maxcpus, while the
data is only filled for current cpus. As per current implementation
of Fadump, dumped_bytes and source_len for a region have to match,
Which is failing for qemu's case, Even tough the dumped bytes are
reported correctly for only the current cpus. After this /proc/vmcore
generatition also fails.

Allowing dumped_bytes to be lesser than or equal to allocated length, for
CPU_STATE_DATA Fadump region.

Reported-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
ChangeLog:

v2: Only allowing lesser size for CPU_STATE_DATE Fadump region.

v1: https://lore.kernel.org/qemu-devel/20260429065127.366813-1-shivangu@linux.ibm.com/
---
 arch/powerpc/platforms/pseries/rtas-fadump.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/rtas-fadump.c b/arch/powerpc/platforms/pseries/rtas-fadump.c
index 3bb4ac2ab6cc..ea1a0a8ac9eb 100644
--- a/arch/powerpc/platforms/pseries/rtas-fadump.c
+++ b/arch/powerpc/platforms/pseries/rtas-fadump.c
@@ -459,7 +459,10 @@ static int __init rtas_fadump_process(struct fw_dump *fadump_conf)
 	/* Check if the dump data is valid. */
 	for (int i = 0; i < be16_to_cpu(fdm_active->header.dump_num_sections); i++) {
 		int type = be16_to_cpu(fdm_active->rgn[i].source_data_type);
+		uint64_t bytes_dumped = be64_to_cpu(fdm_active->rgn[i].bytes_dumped);
+		uint64_t source_len = be64_to_cpu(fdm_active->rgn[i].source_len);
 		int rc = 0;
+		int region_collected;
 
 		switch (type) {
 		case RTAS_FADUMP_CPU_STATE_DATA:
@@ -469,8 +472,18 @@ static int __init rtas_fadump_process(struct fw_dump *fadump_conf)
 				pr_err("Dump taken by platform is not valid (%d)\n", i);
 				rc = -EINVAL;
 			}
-			if (fdm_active->rgn[i].bytes_dumped != fdm_active->rgn[i].source_len) {
+			/*
+			 * Make sure that dump is collected for entire region.
+			 * CPU_STATE_DATA region is allowed to dump less than allocated space.
+			 */
+			region_collected = (bytes_dumped == source_len ||
+	                         (type == RTAS_FADUMP_CPU_STATE_DATA && bytes_dumped <= source_len));
+
+
+			if (! region_collected) {
 				pr_err("Dump taken by platform is incomplete (%d)\n", i);
+				pr_debug("type -> %d, bytes_dumped -> %llx, source_len -> %llx\n",
+				         type, bytes_dumped, source_len);
 				rc = -EINVAL;
 			}
 			if (rc) {
@@ -482,7 +495,7 @@ static int __init rtas_fadump_process(struct fw_dump *fadump_conf)
 			}
 			break;
 		case RTAS_FADUMP_PARAM_AREA:
-			if (fdm_active->rgn[i].bytes_dumped != fdm_active->rgn[i].source_len ||
+			if (bytes_dumped != source_len ||
 			    fdm_active->rgn[i].error_flags != 0) {
 				pr_warn("Failed to process additional parameters! Proceeding anyway..\n");
 				fadump_conf->param_area = 0;
-- 
2.54.0


