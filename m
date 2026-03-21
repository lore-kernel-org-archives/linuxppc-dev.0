Return-Path: <linuxppc-dev+bounces-18534-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD0B1093170
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Mar 2026 05:31:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fd7NB5xB0z2ygl;
	Sat, 21 Mar 2026 16:31:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774071114;
	cv=none; b=Dbvk8W+UUBxbf+jrPZrUZjhNvbUqexowkyPJ/sUSeV5KTwqm/hEVqHVi6f9ioJqBp+JLE/dZeGM9Kw4m26L3d+OWzCBhfuUKCwB0vA+e4g5Y/+sNRF5HEyEYyO1P9ZtoSiEq+U/GyRV/l/folLmELv284w4AuPyzg3AlbRZgO5NBvYzRuxnb3egaTmoXYvOr1a/tMZI+40yHx+h+FyWvR/FjjiRLd6f7q6YGzyUMRANH1Hn6X9OI+BancNmAeVo4HAgHicL2kB9yEg2BZjAX+D0K0+rTmtE5W4jRVhyS/yMUAOUTxURXGv5FlnOzFKnyp5g4gwVRmalldZZgzZ7cfw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774071114; c=relaxed/relaxed;
	bh=cIYxnN9MOeKKWDKDK/F6SLeoGpu1U4pJOkgZ/mNra3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BM3l/Jf7GjllBiZFeMriCiMO9IRk1ZsY7ueu1Ofdxbef+rNdhShpARQTw7t6YaJue2DLoeYJ0fmo4smJMoM/FV9b523e8TYQWCvhxAktyN2JUhzdtRCjTRqZzgayoNfhyXc6kN0pN6LAZvobAF3+3iTnEFoilTsJL1NlIofrpY9XPOvsgYy4v8oaDcEOulr4nY0KzpzPi3s4n4C9m4fWu/Hs2t7PxYcF5BbPT42DhVJsQBhvkTQWaYZoXH80mwUtS8TjhKYzjxVu9l8bvxw+qt4871jLsKbp6R8ycRQksXeSN7s1nDW/bKmQUD+G5vVONk8EmU5mS8l7lpetH6ffJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bZvzwRZd; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bZvzwRZd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fd7N93f66z2xP9
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2026 16:31:52 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62L3sFSh4146040;
	Sat, 21 Mar 2026 05:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=cIYxnN9MOeKKWDKDK/F6SLeoGpu1
	U4pJOkgZ/mNra3E=; b=bZvzwRZd1XLSAw6DPxyqBO/uLGzQenqsCPxhHUUj+PYH
	uxPUYdqnZS5z5Ytel/tUydpDyCbP1DkZBMCR8kf9W9jo4RwIp/Gmpa7lrwCoM3we
	pVuvKSa37ZUu/ipiv54dwWTG9ein8KOq9eiXO8eq2jCfrdt97CBx/ZBcYxP+vHXK
	SzfsMVVAC6s2mVNxeDTifKFxtmMpszfMoYpCI9NCMTQu5twXfkHXGT90uNJ5aJ/d
	SZxQuCzD+p9NJohQi+Oz/X0SNY59NyEP92ZRb1g5y17GdujRBDix5Caa2jP58M21
	SttyIkSOUvS03YfEjElJKF0CSOs6KwpXcQJKmxtSdQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktxg6dn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 05:31:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62L449Qg006315;
	Sat, 21 Mar 2026 05:31:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwkgktkf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 05:31:37 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62L5VXJ340632678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Mar 2026 05:31:33 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0ECB20043;
	Sat, 21 Mar 2026 05:31:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C12E220040;
	Sat, 21 Mar 2026 05:31:29 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.domain.name (unknown [9.124.222.162])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 21 Mar 2026 05:31:29 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>, Daniel Axtens <dja@axtens.net>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH 1/2] powerpc/kdump: fix KASAN sanitization flag for core_$(BITS).o
Date: Sat, 21 Mar 2026 11:01:17 +0530
Message-ID: <20260321053121.614022-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
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
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69be2d3b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=qf4gfuq51q0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=JuTF4qcAAAAA:8 a=pGLkceISAAAA:8 a=t0Qa3vZ5fVEj1awjsuUA:9
 a=3ZKOabzyN94A:10 a=k40Crp0UdiQA:10 a=WlT8qwTXB_Kj6um4hl3b:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDA0MCBTYWx0ZWRfX37Xoklecv4m+
 CsGZTzUmuGdHnvs5I+tooYDjTUseOuvkpSQKGdzD+KQOBHgSQBO+cLSfFXxGwYyxkjZ5u105U0f
 DD/n1oyPO/5sbPCVZ0WlWAnW5Wlqsg+FSyivIguO9/z10kVPvIZRMvwF/4OapCKtwmyXeqh7QPl
 1x3ny12brfb8GoVOimuQCIm4xXY/UDIM44xQYTd3r4mUoaZGBXqcMwuHfiV5kXOxqSBFEiFZCMG
 /h3Ly655p/SithQzW4fLH2SNmnkRXDwh2VtJMFjKzoOF+jntuWbsluSlrZXEP6s6C+w/QlwRuW6
 X5e4k49nfW6UBYhCqama3gVMoxnELJBkq5vB0v7r154qhBSrS0TlDyF2nmaOJCrdsYl2bv4lTsR
 Q9gMdEoCaccOgEmPhMVoFFSzraJ34Us60BLObt3kALwyT0v7FM2dWXFTjG5U3KgoISQ0ON2UUsY
 21pbFM+XMM9aWOjBb5g==
X-Proofpoint-GUID: OwKcb6BrtJHqXgwbOxatl3kzDiBfkKyB
X-Proofpoint-ORIG-GUID: NIvEsZX8PoV7upU3Tz8e5Ox8gkC4x8DJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_02,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603210040

KASAN instrumentation is intended to be disabled for the kexec core
code, but the existing Makefile entry misses the object suffix. As a
result, the flag is not applied correctly to core_$(BITS).o.

So when KASAN is enabled, kexec_copy_flush and copy_segments in
kexec/core_64.c are instrumented, which can result in accesses to
shadow memory via normal address translation paths. Since these run
with the MMU disabled, such accesses may trigger page faults
(bad_page_fault) that cannot be handled in the kdump path, ultimately
causing a hang and preventing the kdump kernel from booting. The same
is true for kexec as well, since the same functions are used there.

Update the entry to include the “.o” suffix so that KASAN
instrumentation is properly disabled for this object file.

Fixes: 2ab2d5794f14 ("powerpc/kasan: Disable address sanitization in kexec paths")
Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Closes: https://lore.kernel.org/all/1dee8891-8bcc-46b4-93f3-fc3a774abd5b@linux.ibm.com/
Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: Aditya Gupta <adityag@linux.ibm.com>
Cc: Daniel Axtens <dja@axtens.net>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/kexec/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kexec/Makefile b/arch/powerpc/kexec/Makefile
index 470eb0453e17..ec7a0eed75dc 100644
--- a/arch/powerpc/kexec/Makefile
+++ b/arch/powerpc/kexec/Makefile
@@ -16,4 +16,4 @@ GCOV_PROFILE_core_$(BITS).o := n
 KCOV_INSTRUMENT_core_$(BITS).o := n
 UBSAN_SANITIZE_core_$(BITS).o := n
 KASAN_SANITIZE_core.o := n
-KASAN_SANITIZE_core_$(BITS) := n
+KASAN_SANITIZE_core_$(BITS).o := n
-- 
2.52.0


