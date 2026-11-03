Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8E9606A329
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 08:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=O+eNprhO
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJj6Z0TKSz2xKQ;
	Tue, 03 Nov 2026 19:53:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793696037;
	cv=none; b=EG8X3C6epz1+/s9JBE1qEXpt6D3tubXPCt/xNFPev3N6CHfeCUYSsRCbuhw56Yv+jkjbNLmEW8Uqg4H2en/4JzNmFRopqDmCFUZgr6be+JbBqE8PHtA7tXY12Tp2We7zczd+/0xgAxf4W/QjLTR2PZFN78UBZtO4xMcinSbjh/tYmF/gMZZcQO9nQWIsInrEqyHBgJSbPKVlFhdf3XoZhLyjqU6yRulijvDrzsR4awJ9f6ISrQMBD0SVuD/FtswzJEW+7MYUuDY8D5LgUpZpJE3V0AeFsilhMYEHBR6184KZwg12YJinyxlWBpon4ovNaNDo3VMU66M38viBbuL2Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793696037; c=relaxed/relaxed;
	bh=itZKsf6vDdL64wd7jcD7s+h3ERv0zNg9SrhhaMX8rgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RVXGRPKA9gVouzx+RDRgrKOxEl9Y8nN4urO9WfuD4MCCf42h4Etw8DR5yc3aIjSE9PkluZQFQfyBLAnX0CLv9jqF3G4O5xCk0lqGWfesAoy8bI79pNeEZ6X7Tj7k8whKED2kRXyvNyaiDrObG1ukEUGcFuLJsw1aeO2ORC0uwEGQLOQawxKCkYuR7K+dWlr4mpL7u4Q2fMiFIyWG/akKLE3kwG1hgxUzPMLzCe9SkI67Kp2+3Dxa43VK1y+bYhUiltG+eMp+oNx4pDVf1RkfeqQv/fJS58kBWTf1nh0mQzP4Lf+Mgu+CZbyvbehVxiL0sRboTQ2EJxhQSaZ5sZv3XQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=O+eNprhO; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=O+eNprhO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJj6X3tNjz2xHP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 19:53:56 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A31isKC306162;
	Tue, 3 Nov 2026 08:53:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=itZKsf6vDdL64wd7jcD7s+h3ERv0zNg9SrhhaMX8r
	gQ=; b=O+eNprhOXuYW0WOQvEw4YhHUixTkJi1AcvhvMuHTcCZcsAYm8kwgdf/Qv
	GRvGYiFphAfIhxX8J+Mw9EDpJgIuhGMh3RMzQJDFML5X4hULOxSlIa7mL3HutFL5
	yBBruJTN1OXBwNA86v8g8JeOX1BzmIQlfdi61Hx4tFTzPkwYDqax0uqDYGEJBNFH
	eAskRVfLC/KS23GH3vvYbrVEXsLUEkHTcRc011FkCObJ8LMTjEuq8eKh4FaCWgD2
	rwSysa2Elhi81OQeI5jPvl7A2KiLAKPEB03UD5jkqrMxA6AAsxrJAVV1Sv0FWlIh
	FP3t8mdaXDZZlaDZ8PpwtGiyGVstQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn7yrvet8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 08:53:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A37aSYZ623512;
	Tue, 3 Nov 2026 08:53:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hnvvfscjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 08:53:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A38rPYY16449920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Nov 2026 08:53:25 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39CB820043;
	Tue,  3 Nov 2026 08:53:25 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 287E020040;
	Tue,  3 Nov 2026 08:53:22 +0000 (GMT)
Received: from shivang.bl1-in.ibm.com (unknown [9.123.12.247])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Nov 2026 08:53:21 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        sourabhjain@linux.ibm.com, rppt@kernel.org, ruanjinjie@huawei.com,
        baoquan.he@linux.dev, Shivang Upadhyay <shivangu@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>
Subject: [PATCH] powerpc/crash: update fdt on cpu hotplug remove
Date: Tue,  3 Nov 2026 14:23:19 +0530
Message-ID: <20261103085319.51480-1-shivangu@linux.ibm.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Mcr5KJ/f c=1 sm=1 tr=0 ts=6ae9a10a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=S-6rMyIPvGFi4FMeT0EA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAzNCBTYWx0ZWRfX0rxcaEh/2Kz5
 ZLGga6GYB7VlZs2Z6kNOdda082/rfEMKGGDXHyFM6y3NA6fP11xMn3ea7/rYV7zl3Op0cduAJ0Y
 CsdAgVRKgRkoDgFFPC2ZeMjCWit41TY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAzNCBTYWx0ZWRfX76o3wtPlmDLu
 w68FFedjwKrL4IWwd8dLZdb8DVKYG4DnC8dF400W2siSx9cO6D+Fekcv5D8QC/xmKn1914DNTRl
 HcysI2SA15OyWp+O7tnFCTDighhrQw5SQggMFJFYRE+J0TEbzqwx91dRuwS7pm7ClDnlSxWGdRt
 u8LwjGJQELpp7awcjS5AMoa0ONbYya+ZULk9aOOYXvy4ZfzqFPyAz3LV2Ynxh7xidietxnIyruw
 OAA5H9nixmWauk+DIMfFi81WbJEh/37iv8ZNnnyclptY//5h5+1JQEjWO1o8f0a63GPSgLeaZ9S
 Tv7Di4te11W+etZA0P9R4oshrHQzVgMq9SeI/zGSpojoyRW/5bFHCTDfNyzYHgQPBCEyiiFNZAt
 aDZEmtRXCz+Cr3Xeyz90k8tQradovcx1cYPszT1IbXM5ugSM8xRKfomU1ZzNOomxHSJQ9awDWNF
 ng5bBCc426qW7/Ks7Kg==
X-Proofpoint-GUID: kyGgd7sLQHA9gL5cdsTSwh2-a3auW3vL
X-Proofpoint-ORIG-GUID: cdzfwjm90R_Fs9ILAKWt3brLtMRv2zZM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 clxscore=1011 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030034
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently fdt for crash kernel is not updated on cpu hotplug remove,
which can lead to the following XIVE warnings on the crash kernel
bringup.

[    0.630795][    T1] xive: H_INT_GET_QUEUE_INFO cpu=16 prio=6 failed -55
[    0.630912][    T1] xive: Error -55 getting queue info CPU 16 prio 6
[    0.680899][    T1] xive: H_INT_GET_QUEUE_INFO cpu=17 prio=6 failed -55
[    0.681000][    T1] xive: Error -55 getting queue info CPU 17 prio 6

Fixing this by updating crash fdt on cpu hotplug remove path also.

Reported-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
 arch/powerpc/kexec/crash.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
index 775895f31037..0ef10e39ae49 100644
--- a/arch/powerpc/kexec/crash.c
+++ b/arch/powerpc/kexec/crash.c
@@ -639,8 +639,6 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
 
 	switch (image->hp_action) {
 	case KEXEC_CRASH_HP_REMOVE_CPU:
-		return;
-
 	case KEXEC_CRASH_HP_ADD_CPU:
 		update_crash_fdt(image);
 		break;
-- 
2.54.0


