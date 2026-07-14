Return-Path: <linuxppc-dev+bounces-24262-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D5CC4450A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 17:30:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h05tV3fPvz2y7W;
	Wed, 15 Jul 2026 03:30:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784050242;
	cv=none; b=oUtLxPETJcXuhlvlOmprtNmx/mynw7GhmE6U9k0usWWDchGREqanpQmqcLq/KO4izYpa1Q+jUvfoHdwihCP0B6TCdYE+KC4lcYoZSuJtZek8UsYyMvq3f+n2/+AMoCFAayZ14Me1cPQesjAc+qFgYYaRjUYfaCFftg59gAfeK1GPygbb/Vs0NL56cxdQ9oxT5EfvU5pYy0r0c5q3HmtvovYBKNs7wlZ49hi81oOtc5Bfi/pKw/Y1b1eEZY4kLEp915JyUW01vFIhV02NQdTWID/iltPtVGv9OfA/LQ8AW6y/BwYx6jzk0XzuiWGUNr3cP+4oIbNbr4+VkRvgrw9iPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784050242; c=relaxed/relaxed;
	bh=5RM7/NQc+0ebV8Gxhd7c5YJ9/W2V4Q270F2mu34yEwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FOkyZkp1QCydqkEEB9zlfUXIizKAoclUguGb6hjYYTwzgzAY0DO+bttetq7dv60GhK9tbkw8+OGjfeNZpENypSHlQGq0ExW2OAQiF/gNWcVX2DyBOiMJ70HKy8iyM7QEyl3eu8m1pwYXgaQzNsMltVq8W/4Ns35pVnCDHHDSfmAtcnj738U+ENilNA5U5kBcP77LD98tK+0ljlJKSNDR9+dWylp6ZTH5hVAo4iAe1ZN3nac5s7+Y9dONVR3hkhBd3/VS0L1BPY569V712rs3rMeHPhTGV7l7VyunT9w3MYeNSrtO+QNzgFljg6wufn1IQ+RAypgmOHr7J9FrR8cdBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LHmoTyRV; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LHmoTyRV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h05tT4l0Cz2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 03:30:41 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EGBr8B1785895;
	Tue, 14 Jul 2026 17:30:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=5RM7/NQc+0ebV8Gxhd7c5YJ9/W2V4Q270F2mu34yE
	wA=; b=LHmoTyRVfPiKdJGIuEu5+KF64LgKAlXfl/YMJz6u3KebNjbMbQU7X7fqJ
	q2ezMDLNBrm6EiFSch2VYYFV05+Q3Sh3MFBhWg4COLdtcKKGm2bKOnkSoMdWhBZ+
	4I3jGZIvMljJ8G3qt0c/IjU5PZzhY3OdszOly2ku3qy7RXFYa/XBZBh6NmEJWyAv
	a9gJV1f+AFmW7kORMOG9Yk7hSfeAz9oq1vTM57gxWfSLRGGdYVhBxl7lJQ1/XRfA
	W6uh1vn9klYWnQoh7BsLVKg61ovIOBMc2IL3fmNUNTq6XfYETPZrQrcyif9D+4BP
	Ag/nTpkR0qnia7QO7ZXJTtn65GQvQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbpyt6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 17:30:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EHJdXr029856;
	Tue, 14 Jul 2026 17:30:30 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uy3mm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 17:30:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66EHURVe48169462
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 17:30:27 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1607920043;
	Tue, 14 Jul 2026 17:30:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C64BA20040;
	Tue, 14 Jul 2026 17:30:23 +0000 (GMT)
Received: from shivang.com (unknown [9.124.218.131])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Jul 2026 17:30:23 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, sourabhjain@linux.ibm.com, adri.vero.dev@gmail.com,
        adityag@linux.ibm.com, anushree.mathur@linux.vnet.ibm.com,
        Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH] ppc/fadump: collect dump if the collected size is lesser than reserved
Date: Tue, 14 Jul 2026 23:00:10 +0530
Message-ID: <20260714173010.615682-1-shivangu@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a567237 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=ERNNbWzvqkqraKjHjBsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE3OCBTYWx0ZWRfX0YIv4tQKNAr1
 vkCb1jLEpN65Y2Qd9Cuhu3PRKLj4JlsJhC1rruD4hG7OVQGJgqwajaHTzcvrOG1lmEyPCoN3nLe
 Zm8ZeW7BCkF8VKCyUOFZit7Y+0uPCaP+MdbZs4u0WGz33c7lGrucGRzm4EXjzWoL9o/PeMQ8/LD
 Qmvt5o/qJMMn7QBVHiFAvbZ+6lF3tX4A81YtN3cMtSj27pC3e1oQJF+CuYeKb7WfSaNViF7J5qE
 uHe6pPqUWXUKcvJ6SGplI990kSTLQTjFU82bkJHJLggiPKqBfQoNeXMAD6Bgbbu6bi1QmkMem77
 /9j363J3Bxc7cqmZR+RdH7YwXi8oqTW5QWPehHCdy9kQDRZxcHqutvt/vIC6/gSDzgVYUKVcw1P
 4eGwT8jE5mTFb7gwgw7M2DcN2AGnrDlvC5sOYDLRD6uXqEYJVbhw5HBvoPEB4XA6dUP4wMonCRk
 /uhBhUea4YUbDwsizZA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE3OCBTYWx0ZWRfX5XPneJfjJXWt
 u2twjVLIWksl+l9pOlsj9yE/phtQba6UHp7HeY2Y+/JAt6iKl2A+qaLTkfZJaB65G7oC695R8Kn
 JGYiT/NP47Tsp3hpT/4iHJDZg615O2s=
X-Proofpoint-GUID: zuapkpq2kWGyd_lCYlPYA1bmofNmUbse
X-Proofpoint-ORIG-GUID: MgoM9eDk5Za2niy2HdggoFKWKS-k3z7y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140178

When a machine is subjected to CPUs add/remove, using dlpar
operations, the number of collected CPU_NOTES can change.
As per PAPR, collected dump size should not be more than
allocated size. Reflecting the same in source.

Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/rtas-fadump.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/rtas-fadump.c b/arch/powerpc/platforms/pseries/rtas-fadump.c
index 3bb4ac2ab6cc..19a5adaf326b 100644
--- a/arch/powerpc/platforms/pseries/rtas-fadump.c
+++ b/arch/powerpc/platforms/pseries/rtas-fadump.c
@@ -469,7 +469,8 @@ static int __init rtas_fadump_process(struct fw_dump *fadump_conf)
 				pr_err("Dump taken by platform is not valid (%d)\n", i);
 				rc = -EINVAL;
 			}
-			if (fdm_active->rgn[i].bytes_dumped != fdm_active->rgn[i].source_len) {
+			if (be64_to_cpu(fdm_active->rgn[i].bytes_dumped)
+			    > be64_to_cpu(fdm_active->rgn[i].source_len)) {
 				pr_err("Dump taken by platform is incomplete (%d)\n", i);
 				rc = -EINVAL;
 			}
-- 
2.54.0


