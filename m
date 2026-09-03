Return-Path: <linuxppc-dev+bounces-26461-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC22C624A4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2026 07:43:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbBRq6LLLz2yr9;
	Thu, 03 Sep 2026 17:43:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788421431;
	cv=none; b=bGePwe6nxqFXVlNHWQPnxC5znnH2MqlNno52QI9XOt5RVOAy/QA/0CgZmx+2TyKHvRXPVQc4ScXcRgLMir68ug4RuE/a8eCEbR1u/xHxsPI6u6sOM5Q1fsi2Wf93kfaDQr6XKD7I6oVxjfqSfZuecHWI3vz9NemtD2UNBJzDmDUahDL0a60K5GIwaAJcVb3fqTm7QCZAO3yV1lacZz8DiGwPZuaS5mb5j1OtMKxza7LAjIOHOwUhJU5TvToQmTZFV8X8+/8xqCpN5nLG17nl5VokzVwb93TSESfivUQc7t3BQgBvLTnHR+GvZbV+RRa6LHn4NFZ1zHwdOD2sy7QANA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788421431; c=relaxed/relaxed;
	bh=su7B1NKdNPKI73ysRPFKP5OgHbGHjRHjklIOqrXfTEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cq6gTF8dI8Te3BEp2VZ2c9M3KOq6zcJwnV5CqDts2MZFeuZQeGy4WwPfBHvzCCQr8BUL1+HbdNeiifNTNOBim30s3V79fOqNmUF3fQYFXN0a1K4LtJk3PP7jgYZlwQ/UsIhsIRlz5FdrYdjXr3Oe1vpaD5DunY+4y9nweqRVhWf2+bGt+kEPw9SVdHHbGM1DvI1VUyOCHMuYUCl7JEsYrqJNnZFTXUSN9usHEjKYHZLluV92tx3N1eYTI4KnLWo6RYLar2kte0VO2/JW7SL8X5I8HLai18HGYsAPyqk22qqV3S2oD+gYAWm2SCOc93NGddDCaZLKW4d4REMZABnF7w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sQtUKhxn; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sQtUKhxn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbBRp717Zz2yqq
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 17:43:50 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68361Ysk2067428;
	Thu, 3 Sep 2026 07:43:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=su7B1NKdNPKI73ysRPFKP5OgHbGHjRHjklIOqrXfT
	Es=; b=sQtUKhxnNosTpSlI30o102iEX2sE3n/dbGkWh/T+5/+5Y+HTEqSliZq7e
	KSL09knePOnfzCOAWe60yPSz7z5G64cnSVYT2NqrlYaMsK6T9rHPyiN7pM7y+aK9
	LnEZWJuOXuISZOJU46WEE/y+AwIE2qXkbLshxS5kfKsnE7IlJcMb9GfaMzh4AjF+
	uCAdIBmLuh9vCDSM2hIjjr3JlHB1mfDrcNbMoz2hXWoMjxLQ2ZyYyJI7e89meq9q
	UKl2XbWvX0ovrPAs22RWxy2HwxXRnd9WuhDl0fMbL5JaU5cIlqAAkqjzGHA8R5FD
	ocr5msD7QXoAW3nxiI8T3EMLKFMSQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuj3f0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 07:43:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6837fNIL023992;
	Thu, 3 Sep 2026 07:43:44 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rqps25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 07:43:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6837hf7a45416912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Sep 2026 07:43:41 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26D212004D;
	Thu,  3 Sep 2026 07:43:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66C6C2004B;
	Thu,  3 Sep 2026 07:43:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.240.230])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Sep 2026 07:43:36 +0000 (GMT)
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
To: James.Bottomley@HansenPartnership.com, mkp@kernel.org,
        tyreld@linux.ibm.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavrampu@linux.ibm.com, brking@linux.ibm.com, davemarq@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH] scsi: ibmvfc: Add Kconfig dependency to fix link failure when NVME_FC=m
Date: Thu,  3 Sep 2026 13:13:29 +0530
Message-ID: <20260903074329.6705-1-venkat88@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
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
X-Proofpoint-GUID: uVhrgAQuVa3a-Hk50Ctdr453EuCE9wM-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA2NiBTYWx0ZWRfX3vAwl/hIkg26
 ls93ck/iVdfTCbY38V3b3RSZ8Yf/oYGaXZxhfvy44Hi1LKd7N1ss2o/asdUUkVBF3Cr0m/MeJVq
 btaCLiLrkbTS1m122OX2ucT5rPkiRlv6e13a6eAHDwTR0hTfopv63uQD4RJBKj/FRX40VDiyG+L
 TtTd0aP1UCXmg32Kk4h8emkDWpnQjtmuX1F3pedrwJbgO4NXA5QxknC9nG14CrI22Z74kdxhSmV
 YdQ5ovvyy9Ugiwm2Mhqdd+e79uxFmuYdPBTbRY6nTiwUjHbEIKZdPoKRJcuR95WqY7PR2mnW0aM
 kMJkrJwCPVWyaXuZnpQzoybLilxrourjmD5mxj8621cnM5bJLGy+DUz5ZTnjT97jcFPjaPe3oXa
 VvJf84/GhgEFl5Aj6o/4YXQ/zfDjWAg8y8stTLUXXxFpVIkVZvnK4CMbq4ok1im9M9kKz1Ww0Yp
 l97tvHm/mSO1RR3iTlQ==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a992531 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=gACBmWVe_6yc3LGc2GAA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA2NiBTYWx0ZWRfX6xKXIfiAsCst
 V7hpFJqnIPD9r4hZPbf1NewpqxiN9E2sD6bPhdp8g4qnszptKuz9E5ZICCS+mKrForjdr02znAk
 +4qLHtAas9suM2rwChbNBVtZaB79AP4=
X-Proofpoint-ORIG-GUID: uVhrgAQuVa3a-Hk50Ctdr453EuCE9wM-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030066

Building with CONFIG_SCSI_IBMVFC=y and CONFIG_NVME_FC=m results in a
link failure:

  ibmvfc-nvme.o: undefined reference to `nvme_fc_register_localport'
  ibmvfc-nvme.o: undefined reference to `nvme_fc_register_remoteport'
  ibmvfc-nvme.o: undefined reference to `nvme_fc_unregister_localport'
  ibmvfc-nvme.o: undefined reference to `nvme_fc_unregister_remoteport'
  ibmvfc-core.o: undefined reference to `nvme_fc_rescan_remoteport'

IS_ENABLED() evaluates to 1 for both =y and =m, so the nvme_fc_*
call sites are kept in the object file. When SCSI_IBMVFC=y (built-in)
but NVME_FC=m (loadable module), the linker cannot resolve these
symbols at vmlinux link time.

Add the same "depends on NVME_FC || NVME_FC=n" constraint already
used by SCSI_LPFC to prevent this configuration.

Reported-by: Pavithra <pavrampu@linux.ibm.com>
Closes: https://lore.kernel.org/all/327877a29337aa526cc50ac88fbddb86@linux.ibm.com/
Signed-off-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
---
 drivers/scsi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 4a2af0f702e1..1eec66195cf4 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -753,6 +753,7 @@ config SCSI_IBMVFC
 	tristate "IBM Virtual FC support"
 	depends on PPC_PSERIES && SCSI
 	depends on SCSI_FC_ATTRS
+	depends on NVME_FC || NVME_FC=n
 	help
 	  This is the IBM POWER Virtual FC Client
 
-- 
2.45.2


