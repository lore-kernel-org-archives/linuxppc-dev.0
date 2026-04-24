Return-Path: <linuxppc-dev+bounces-20076-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358C2FE5211
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 11:49:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g2B7n5FH2z2yYs;
	Fri, 24 Apr 2026 21:49:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777022782;
	cv=none; b=i2B9/q1jjjhtmqn30Qe1r8t5CI9DvxXq3uUHaBNJ0elyij6se06KdeJ5BFaOWFqoS+SM2ZCUCfGfdPq2rkjTW5Gd2Yi08cSIBLmuTNBEoZQHZddTn+2gj0ONvY7OTTo0yMMo8qjBgjmqYWICmyyhLNRS88GbHhLWHts9T1zgoD773oLd0PGoYouZEFcBZcndHWy0ObkcMo1EhyDAfBjq7poaGPa1sffDbfkR2uno12QewVibIe6LZ+o9lO82Ig44IxpF7K6jHdHUKFs1YE6MpkTU8oUVT+jRB7tvH8Wlvo/mrmAsb6SJPdRXXj/OJOX5iDI9DVqs0wM37aFtUpEeHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777022782; c=relaxed/relaxed;
	bh=5Z+IcA+wgQgfLjrABjUdZIUTQa/L6I9t9shLlrmRclA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NQazTJJX40mrcYQYyjh45QrY0yQosGjfu8oNq3Fk0j7klzOD9I6jcv8Finv58uMxTqNGt+6VNqZjkBtFtZAyNlTZnXXF+lovUvUU57csHyBjQPhHTmIn3qBOGoTuk81rmxDlyArwvRWjTgO+J8EwzZ//qlIfj40y+qVIfhTtASdhGRk4E+GqYdJfJQIwXSrHwX9mQ/fK72PjtkNLU/aiTOpjOc2d7xPpJGz+lWxqC1GIMzeQpYu90N5tEYaYNItHdc/no1cNuDMmusSyGbWEg+S0ID7N5xtrR+Y3CPMQ4R3Nlnjn+rKEYYcPsmSm22+yLbsiFDh3/UpdGgMGnhgMRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=idxy5bdW; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam.menghani@ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=idxy5bdW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam.menghani@ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g26z10jwgz2xZK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 19:26:20 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63NJ4qcc3514965;
	Fri, 24 Apr 2026 09:26:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=5Z+IcA+wgQgfLjrABjUdZIUTQa/L6I9t9shLlrmRc
	lA=; b=idxy5bdWMC+9p2E+Sdv2+9tP3/aTxR3UwikISKb8MvTsO2wsg5/b/kFKE
	ZyyrwR3hEfkyXORuJTTVCiLdTfmzmjoaPbK9JR/FJuVdeMtbGiv4cNGoV/4ef6RA
	0isaksGSHYpBHgOUGiHbg+B2h+tFGItaZ/O7ScsF3P5ZvnpphQgx3iY91rn5AsIt
	w/gF27aVOyTsccElWEYXlYjGa2WITVp3sqKFXEc8nHxuE+pK8MzxXN9Htg0A5GMj
	dum3OaqvUk1N2ntP0NC/dFYOcWvlYTRdUboylRiMlxW2P+Q6aCFtqPlVxdkHWX+R
	NOdvXKOYk6ceHW/gmTECmUBlCQ0iQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu2d3t1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 09:26:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63O9KMm7005825;
	Fri, 24 Apr 2026 09:26:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjky26kv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 09:26:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63O9Q4JJ52429208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Apr 2026 09:26:04 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 998BA2004D;
	Fri, 24 Apr 2026 09:26:04 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5967720040;
	Fri, 24 Apr 2026 09:26:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.77.7])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Apr 2026 09:26:02 +0000 (GMT)
From: Gautam Menghani <Gautam.Menghani@ibm.com>
To: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org
Cc: Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: PPC: Book3S HV: Add H_FAC_UNAVAIL mapping for tracing exits
Date: Fri, 24 Apr 2026 14:55:55 +0530
Message-ID: <20260424092558.31798-1-Gautam.Menghani@ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDA4NiBTYWx0ZWRfX/8u8Wq8WJHyV
 2M2XPrpWTJRReyRDzVgmBt0TTsUyb39hfiSMqeSWzNNZZ4dlUcuEUDHq2u69k0gXKBsGg4AqKvs
 8laECAH0iux1Dbwmj/pNuG0Mkm2vSq7qkdnh/EwgxPhgRfHXgIpCj1r7l9IO4tmN6V7HV5bjylu
 iLk3XESM3+HfOVJtIjG1qpGRT0bTfURNtjsQlynGsQyIoqe5rH8zq+/yowrnKtLt5YYaHUZ6LjW
 IvyqZvnwgRZ5D3KE1M1Eljqqj/NVhQjnt92qPAiYZDFl1CuzsmpZf6YZZ2CAAkvoPaT0WUp+kaM
 ECjmNECvFOhBMpq1PXLlfIruX51pBTys8mmXFBDeYogOv18iO4C3rlnmruZ4I3NrnTRxihxXYpD
 MB0lnZZQQFm+6GOsAohd+JRqhcNOPiPJ+lmOBVf7ysZeQzp6ysWQGNYRNbaKX6zToGwTHqQIjli
 8RjX5LPsDIGWFOSJnFg==
X-Proofpoint-ORIG-GUID: o7uEaCyfViQqFKy7o4knqUKzxo38Z72Q
X-Proofpoint-GUID: cBRmFAgo3auae0Kg-O3dNlC0_UqYGQdj
X-Authority-Analysis: v=2.4 cv=XMUAjwhE c=1 sm=1 tr=0 ts=69eb3731 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=HaZPnmESgsJLTL5AR_AA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 priorityscore=1501 impostorscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240086

From: Gautam Menghani <gautam@linux.ibm.com>

The macro kvm_trace_symbol_exit is used for providing the mappings
for the trap vectors and their names. Add mapping for H_FAC_UNAVAIL so that
trap reason is displayed as string instead of a vector number when using
the kvm_guest_exit tracepoint.

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
 arch/powerpc/kvm/trace_book3s.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/trace_book3s.h b/arch/powerpc/kvm/trace_book3s.h
index 9260ddbd557f..eafbaeb5a9db 100644
--- a/arch/powerpc/kvm/trace_book3s.h
+++ b/arch/powerpc/kvm/trace_book3s.h
@@ -28,6 +28,7 @@
 	{0xea0, "H_VIRT"}, \
 	{0xf00, "PERFMON"}, \
 	{0xf20, "ALTIVEC"}, \
-	{0xf40, "VSX"}
+	{0xf40, "VSX"}, \
+	{0xf80, "H_FAC_UNAVAIL"},
 
 #endif
-- 
2.52.0


