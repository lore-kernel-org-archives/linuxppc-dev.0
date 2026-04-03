Return-Path: <linuxppc-dev+bounces-19286-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D09E8538E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2026 19:01:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnSkk63gDz2yQj;
	Sat, 04 Apr 2026 06:01:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775242910;
	cv=none; b=ZeHYetK7bQUfOZApLQ7wkHThfQejRNdU3f7RtALyIqjQYMZBIJyiNreCkGwi2Lttgs3fm4QtN/sP3O3OchHGVvSveW1jScPGR5NaTXaFkpVMEJoH+q5yxJOKM+4NHYXqgno5Dbml+3QWetqyoLtWeBh1DnS+AQq9BSxnnl3PyXlds+w8m090GUNyt+DgMg7hsjlCqrdon7qR6QP6Z6BUk6rSXUtqC4YqHk5hztT/cKEIOeCtinfIQWkWTFwHCgb0Enot2itmXw3Lhj+dT1/B13pgBCF6y8rrHaOC17Sw52H6mJmYzurzliG6QhxF/l/GHYqHVHx/O4mmKzcNQBCFUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775242910; c=relaxed/relaxed;
	bh=k0vrgXZq08zHnhqmmfYlO+hu8mNgR9cSbF3OUh9/3GM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NIIheGGODceG4DSWZHF9XwVsA392Fo5OmqQzW+OXkXmb+pnTmrGmxAZHnQUb+EJQbrKwCPuNw92y6GGWTTSyPa29ggy+tOplbGycWjIUVD/3cl4Rl3W4BmsCqKTSfmqljI08xzEOprBGojtETvsp3yZGf/FUrKqrodqUVhj5nHch+wOEoTMoc2FFZBMem53Z1ovNYjXgAXx6nxrXZzSHEpqx+2JEUayLsfERnD0aF3zcmgtGDgZB0s7aIrwhtBDH2xqPwyoPRHNIHfX7AmcyBwRhd0qjlrWIydCf6ZF+nAX3M3umJgAZrl6s0qbOqY90lcLM7gLPGoHJ8wlgiXBi9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bdLYR8IC; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bdLYR8IC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnSkj28rnz2xSF
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 06:01:48 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6333qUv5361401;
	Fri, 3 Apr 2026 19:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=k0vrgXZq08zHnhqmmfYlO+hu8mNg
	R9cSbF3OUh9/3GM=; b=bdLYR8IC44VhXdQyXs+EmMhL3TWOCYuTu4RJoNw5T+8C
	3f1zdNDcik8KWiuUPyGw/RGhbBie8YKF2NReO/deZULs5olZwU/kg/LtmR2ZEa9H
	DamZ4gfwA9nqfQZkGdswvIcL9KG2ROd+1jV2slspN++j1AP8xFLsIG/KdgatMgm5
	6KC36/SxIGSsCyWafqdEWkt0RzmtKjsxizcr7uA5Z9v9Iz8KdL75wmDGeLcZlmtP
	4r/ama8CxbF+i9T2JhbNJ0OLbSdXEMkf/+5BxhLTuGUU3zf+Jkl14cLAr6+z2Kxj
	2IDbcsCNnE+JgTpbagzJV1+/WklpQ8vPpkycuy9GIw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66q3hwn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Apr 2026 19:01:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 633Iu8XJ005757;
	Fri, 3 Apr 2026 19:01:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spyf93h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Apr 2026 19:01:36 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 633J1Xvb45023634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Apr 2026 19:01:33 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE9752004D;
	Fri,  3 Apr 2026 19:01:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6548020040;
	Fri,  3 Apr 2026 19:01:28 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.domain.name (unknown [9.39.18.186])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 Apr 2026 19:01:28 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>, Daniel Axtens <dja@axtens.net>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>
Subject: [PATCH v2 1/2] powerpc/kdump: fix KASAN sanitization flag for core_$(BITS).o
Date: Sat,  4 Apr 2026 00:31:15 +0530
Message-ID: <20260403190123.1383198-1-sourabhjain@linux.ibm.com>
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
X-Proofpoint-GUID: 0B1LHM57XAH5E_ADuzGcKQ6IBHfNj_UG
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=69d00e92 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=qf4gfuq51q0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=JuTF4qcAAAAA:8 a=pGLkceISAAAA:8 a=Rbr8bO_GjACkDpKrMaMA:9
 a=3ZKOabzyN94A:10 a=k40Crp0UdiQA:10 a=WlT8qwTXB_Kj6um4hl3b:22
X-Proofpoint-ORIG-GUID: O308Vted1d_-6EbRme_gnJ7YOVgFe1it
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDE2OCBTYWx0ZWRfX3ViMQ8moW1zV
 UeMvG+X00ksq4OyZBy5zAL8m5wd1Yt1Ul6Rv/A6bhF2qUw2/4IxEhMFv01VCaOEnWp3oTzb0KFm
 OHR4S/rOlXihOSi/Am+Hq3lZ50C8skqlGar5PGC862ExJ+JfwIXru6kgKbRv0c9RUUVon62Lo8B
 sTbVpxFbiJ4v3DTvKpxJLWYqnXJfBmd4YQOJgpP+4l5gm1ypevycbxRT8WcUvvkGyXnc05SmqX2
 LN+GBTewHW6ypSdzskPtRT5StQzbimXBYKxo9/eME5GNGYy/tM9YrAZuW/NPRUZizFdraPtKt76
 e7f80Js8PW5NtHEYbc3AbUCc8mEPwg1H5n332yY4cKDgazcdffI/zqtia18pcQJtBX/piEnmndX
 y9JNsOk4cMs/31fn8LhOGBpzM8g0Ag4G7cH8cJCv4XqD0/n6Fsk3wgozRucF0cYZoSXyHa5+hx2
 Ep2obOwcV0Xq6gco3Og==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_05,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030168

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
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Acked-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
Changelog:

v2:
- Add Reviewed-by, Acked-by and Tested-by tags
- No functional changes
 
 v1:
 https://lore.kernel.org/all/20260321053121.614022-1-sourabhjain@linux.ibm.com/
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


