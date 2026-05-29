Return-Path: <linuxppc-dev+bounces-21723-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F42CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 14:11:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRldN2BGmz2ySg;
	Sat, 30 May 2026 00:11:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780063864;
	cv=none; b=ItEFLsJxVLMRpaVnA7stHWEQFZJ/LWGozXNWAUsxCutCCO/eoE22OMKA0O3ZhoAxnf969sjn6gwy0Kk6w0OalgWlXIFDTLTZ5wGpNdkCwnn5yWMDiomvG2EdexayyUF6PYOjKbUDC3Qj40z3XmhXddqqgzUfarMmBh5oJV8bgBlpIOg4dZWkhDvmMm3QtqnEI49tWyxQGXBtb/40+DxhayQcsIBOfBORAiwfcjEqf6/RYErm9CgSOd+cwPBQgHXpKCPebkMkGYldWejNOGymosRQwRrwhf3LQP6ulaJ3OZSVkVEnENYCC7BcfMUlHjLy/lMNpmVHkX64Zw95XDfKQA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780063864; c=relaxed/relaxed;
	bh=lgbPAz26tAknd8qvQW4f5tYMn929446gN9YHMUjWjBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XtKzsuuY2oz/gVCnkwDHS8Jqjb7PFUVad96PrR1ZQ5b0Fsdn5gTYdqAT0pKZ10ecDkHHvTRaru3S4kAFioC6eY4YR5Oyqgg/TJ7IL59x8hWdcqnDi665bE0om5ojmKDQrN4YdvmOcMjs5igpCxN7JnALoSKoi9K2NeUX6HPadCM/cKBB2uprAHKM4epP1Svv86h7/XKbRDZbXMT94Ws1dlnY+iNt5IhKCwfT7dqY291P+fmNlBZOg2l4B2fnJE/UaUuUZLkYSxdhR3Qv7dlCAhF8QWuj2sHXVIh2aEm7GyCzdBj6lAws9FDTB7tioUEOzbIYuE5wMyDlUwNSTUf1xA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sIsK/TYT; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sIsK/TYT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRldM0sNcz2yQL
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2026 00:11:02 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TBbKvt2418177;
	Fri, 29 May 2026 14:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=lgbPAz26tAknd8qvQW4f5tYMn929446gN9YHMUjWj
	Bo=; b=sIsK/TYTDQMJxAxZBAMk2kex5MjQs7rkSE64xvqdl1mzTXSeJjbNMetQd
	dZbgWcR5BQRk42CqES8yuA0FTPmWCQw3EwCKLHe4zne237mRbVWWiS8OIj4gsaoj
	JcwjgyPEI1P+a/E2gMMz4HO7YUlh6tVFw4Ag7lKMKedsbxGxSrKR3v3n2bBqQjM3
	Me1OWozm/io/iyTm+sGc4/bsH41AAqeE75UH2eRYIUo0+aqf1/6Ssb9FFE6aM+8W
	Poua5Z/0ft+DHDDn6ED7R8DcwHF8nuh/kZ4XXuFKXaKIJYh9fBu2Y4hkokUU/S+3
	sfG/j8L+lAm33p7KWPgczh/4WPy+A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884s56g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 14:10:53 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TE96w3027125;
	Fri, 29 May 2026 14:10:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrbdyfn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 14:10:52 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TEAniJ34013510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 14:10:49 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B4E22004D;
	Fri, 29 May 2026 14:10:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 380FA20040;
	Fri, 29 May 2026 14:10:47 +0000 (GMT)
Received: from mac.bl1-in.ibm.com (unknown [9.123.11.154])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 14:10:47 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org
Cc: Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, atrajeev@linux.ibm.com,
        harshpb@linux.ibm.com, stable@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH v3] powerpc/pseries/Kconfig: Enable CONFIG_VPA_PMU to be used with KVM
Date: Fri, 29 May 2026 19:40:31 +0530
Message-ID: <20260529141032.69559-1-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
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
X-Authority-Analysis: v=2.4 cv=L4MtheT8 c=1 sm=1 tr=0 ts=6a199e6e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8
 a=dkYHUGA-BDwxkZPz_lEA:9
X-Proofpoint-ORIG-GUID: IMJAOJv4ObE1BMRJRflC2YmpI8lFl0Jw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE0MSBTYWx0ZWRfX187YlHsiJbUL
 5JokN0h1VxwZTTP0zHyy90T5xWG7jmq/yvy1AUjB6vp8oPllUvjF6XPX5DtF+m53v+W/1fVTOdt
 Pjqx4paNguhLlnlZW+cdADtv1ZNtsHGRbxBVrdWxtGnOQR2P7rQeqa/u0jmDvCytTbDFWje6YOh
 fJZ6HrSgQH9OTOh/BeZW830EmIJReitfQrS+QTA+jGkBoOmwKhu0/J4DpK1EdSfvlsyeYhG8hCY
 9asjw+8+aoKLX95CIFrj66LHqQpfNovF2oWZYj53RgIYUQxHDffL2rZ9iQLK8dG9sh5ajCOyi72
 vAIGTGH1TivlYLlSIVKjl/6DO4I59YYMAeuP4ZozAjrEgGeZx82Zyx42tg95V4BxhQ7TsuV+/PE
 0+RLtSsZckU21WSzgdUeYWDmO3ykzzM5nhs+q0U9xUZ6jREaxUGlVfa/ypm+xuy0phI0KksFPdc
 1VNYrfot/SoircqqkQg==
X-Proofpoint-GUID: lRQ20GSOgXYU8galxn3fTwmrFCsIs-OK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290141

Currently, CONFIG_VPA_PMU is not enabled any of the configs, and
consequently cannot be used for KVM guests at all.

Mark CONFIG_VPA_PMU as "default m" to ensure it is available when KVM is
being used.

Fixes: 176cda0619b6c ("powerpc/perf: Add perf interface to expose vpa counters")
Cc: stable@vger.kernel.org # v6.13+
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
v2 -> v3:
1. Make CONFIG_VPA_PMU as default m so that it can separately disabled
(Sean)

v1 -> v2:
1. Rebased on latest master

 arch/powerpc/platforms/pseries/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index f7052b131a4c..74910ce3a541 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -154,6 +154,7 @@ config HV_PERF_CTRS
 config VPA_PMU
 	tristate "VPA PMU events"
 	depends on KVM_BOOK3S_64_HV && HV_PERF_CTRS
+	default m
 	help
 	  Enable access to the VPA PMU counters via perf. This enables
 	  code that support measurement for KVM on PowerVM(KoP) feature.
-- 
2.53.0


