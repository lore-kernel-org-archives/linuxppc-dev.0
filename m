Return-Path: <linuxppc-dev+bounces-26028-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84791C5DF8E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Aug 2026 10:56:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hRHLX6Q2fz2ygJ;
	Fri, 21 Aug 2026 20:56:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787309812;
	cv=none; b=TfOSka4qm0jhCypAgrdwM9w/IKZGY3E1dZ4tZXi4LJsqxTwYFCB8Sc6KhqcA5xnG96VwdhYuJKiOweHdf5V0F34jvKKMWzsAfPCJA167ToNOeErYU9oUK5r4XfqZVgobc/C4rgB/4T7VawWzY+g+BWFoL0NwTLjhtpA14Zxkg3PD6G3dK7KDnd/UMgLGHumdZIYJZlQDUHHTtZf8NxAL4KnwAF/6wgeHKOXx1a2Xuz1oSfK/60TKN2WCSWM1n6GLB3fMWQWUaTeEqoltWkuVUVIHg9Xe3xtgQ/905mQZF+p7/R1v7yOlMCTts0gCqa7QsQhfOueZ5zU5ssf9HIFWDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787309812; c=relaxed/relaxed;
	bh=+KX/VoY5l/G0eQl4bRPeD017/GY55Wa/Aa/vg9SmAFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYS121EAKgHsqc6grQLjdeIQgGwcA9jfpHDH0l+rfMRda8X0hh0ltsxVjYyumB+ZcsB7ZyALW/C4CFJ53AEH6Omq5daxfSJIlmF67uilJhDpF+MMAhbzKb/RiAIm13bzY6CT2yoUfz5XS9ZDxQF/nuDh5/QBK85dtofu6tSj2pE3QjUfAnL2FgjBUhC205dWwJB5GYsnoUx2i8U0OIXyhG2xZWUQBEskTSuCdWcjVpDrQmq7EsrWkNkn8GfYOkRz07kY/JCIMOlGZ3CpHLvnEbnbTNJJYXbfNh4dQcbLe0MiPuPdOsypuY3Sl3JYY0x5CCrnyTsOJ90rAKstlC17+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Up4V5POw; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Up4V5POw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hRHLW51bSz2yFY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2026 20:56:50 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L9VThY1056972;
	Fri, 21 Aug 2026 10:56:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+KX/VoY5l/G0eQl4b
	RPeD017/GY55Wa/Aa/vg9SmAFg=; b=Up4V5POwjeaYlwNYbO8I4xVjPdQZPmgv9
	SVWe2nVnQw5A63wLwaV3JrRfUVevkklhzbMzeW6O5Ol2Lh5HVwit4bGUCwMn+pVi
	uMUmnQxYArhm2y0XU5EpaEXUQdpwaT7giyhSP1xiCqvj8yClTrmoUFTDB1YXXmYg
	6XAOpDTeMdidSrKrPCZ9fWrk+r/XqGAajAxgVJiNCTSI7txbMVfwVeWOAbqiCbNv
	HLGdkhY608Pb35Bw/R8dIIiUGQSMg7nHKLB/HF7BzsEoxfworcbgV/fRiqeXBpd2
	0OlTJ6DLTRNU1j61kT8HRdtcEcIxOfy8Bb2st5ULCoJP5RnNtRXbQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu1rtcn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 10:56:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LAuOiC031837;
	Fri, 21 Aug 2026 10:56:31 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354yuvsg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 10:56:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LAuS2n51315092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 10:56:28 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B3CA20040;
	Fri, 21 Aug 2026 10:56:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B18E20043;
	Fri, 21 Aug 2026 10:56:23 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.bl1-in.ibm.com (unknown [9.123.14.142])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 10:56:23 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>, Alexander Graf <graf@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Mike Rapoport <rppt@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/3] kernel/liveupdate: make KEXEC_HANDOVER depend on KEXEC_FILE instead of selecting it
Date: Fri, 21 Aug 2026 16:26:07 +0530
Message-ID: <20260821105609.983622-2-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821105609.983622-1-sourabhjain@linux.ibm.com>
References: <20260821105609.983622-1-sourabhjain@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=LsCiDHdc c=1 sm=1 tr=0 ts=6a882ee1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=vggBfdFIAAAA:8 a=Z4Rwk6OoAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=7ipKWUHlAAAA:8 a=JfrnYn6hAAAA:8
 a=5OYvgd8MYfw_dG5BkvsA:9 a=HkZW87K1Qel5hWWM3VKY:22 a=gpc5p9EgBqZVLdJeV_V1:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: o_KV_bRHIEGLMkQUap5i1_BlkNENhfwD
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA3OCBTYWx0ZWRfX8C6Quuj8XWiU
 4pbtE6tO/Hgb+FxqSQkmEmtdttSaRBTEpB+FnhHKtk8VEzSkr3+jE8pubWMgBBHrzn9u3Payfqp
 8bg9tORBK8L7mLKbQnot6jO7JJvNUBE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA3OCBTYWx0ZWRfX1W9BB/IIRIvx
 b+5BFb9eH4JzySwUadzpeKr7Qe+qchyiRYCr4a3maQb3xp9YxFS46p36epYIyZX7Jmz0pPV/fdY
 wPHjJ8d2VFTKSaBsi+EjLF1kwYW7BjOFtgL7FhSTVOt7hP1d6gVYeE+f2yrttIlls3l5MKVBT+z
 eEzgVvlRpRrheI6Eqb910sghw+8V8f0yvAzz/d7SUYKPYQ1DVfd5o5wTJo7cnyrU5RXQH6+Fft9
 oDbPL9yql2fh0iFds1GK+HdxpZ0aPCw1OKXcPycN4m8ZFdibF01UfJhIFngKyHbDkw07QNJTbhP
 i3ifpE5y8nyFhA6c1pDvXJPdPlPqeH464HwRB93fW51ilmQ8GYmWn8onwkNKW1V+1J5oEj5FvTy
 vcLAQUh9fIHUv1eZ7CuLNKDv7F9DtbpsaCergSmzu/on5WHLh+PnUr0tHqdPy6qJXTwpYkUjNOa
 9BHqWqnPmJh+utOvURw==
X-Proofpoint-ORIG-GUID: oEWcB5d1hCVRSp223fOiL4UW7kSjJyqC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210078

An upcoming patch makes ARCH_SUPPORTS_KEXEC_HANDOVER depend on
CRASH_DUMP on powerpc:

    config ARCH_SUPPORTS_KEXEC_HANDOVER
    	def_bool y
    	depends on PPC64
    	depends on !CRASH_DUMP

That triggers a recursive dependency error:

    error: recursive dependency detected!
    	symbol KEXEC_HANDOVER depends on ARCH_SUPPORTS_KEXEC_HANDOVER
    	symbol ARCH_SUPPORTS_KEXEC_HANDOVER depends on CRASH_DUMP
    	symbol CRASH_DUMP depends on KEXEC_CORE
    	symbol KEXEC_CORE is selected by KEXEC_FILE
    	symbol KEXEC_FILE is selected by KEXEC_HANDOVER

KEXEC_HANDOVER and KEXEC_CORE end up depending on each other when
ARCH_SUPPORTS_KEXEC_HANDOVER depends on CRASH_DUMP. This creates a
recursive Kconfig dependency.

Change KEXEC_FILE from select to depends on to break this cycle.
This means KEXEC_FILE must be enabled explicitly instead of being
enabled automatically by KEXEC_HANDOVER.

Keep this change until the powerpc-specific KHO and CRASH_DUMP
dependency is resolved.

Cc: Aditya Gupta <adityag@linux.ibm.com>
Cc: Alexander Graf <graf@amazon.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>
Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 kernel/liveupdate/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
index c13af38ba23a..22e317dc1e1a 100644
--- a/kernel/liveupdate/Kconfig
+++ b/kernel/liveupdate/Kconfig
@@ -6,7 +6,7 @@ config KEXEC_HANDOVER
 	bool "kexec handover"
 	depends on ARCH_SUPPORTS_KEXEC_HANDOVER && ARCH_SUPPORTS_KEXEC_FILE
 	select MEMBLOCK_KHO_SCRATCH
-	select KEXEC_FILE
+	depends on KEXEC_FILE
 	select LIBFDT
 	select CMA
 	help
-- 
2.55.0


