Return-Path: <linuxppc-dev+bounces-26031-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB5AC5DF89
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Aug 2026 10:57:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hRHLj6JJCz3bwF;
	Fri, 21 Aug 2026 20:57:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787309821;
	cv=none; b=WHpwRtRCgbbzESOvFemha26Y4wNF4UvkwmRJB5eDAdzW5xO5Fgmzuk776q2DeOTmaOONfKD4KIAV2f/uEg8bQb1XCOz+rgXXEy4G+P+ZiIHVJXBttfyKSIFTE7lxlCj4EBN/X5jBntA0AjU2nHUOfL9vktX9MEi6RG9MhoUxdehWjJPo51GTTUNb2JlhdlHHVVyHjl+UgaOvKdELse4Mcm50FB2JeqpiE9CoXcdEHVhGEEA03UAaRB5AQduCrymZe8W40RDeBgEV9GHlMaESD6rNkcYdDBm3iwoycrbVTj2a3q52r3i44rNf/6EB0ZBsd22uxJFfERxXPLMnhmxE1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787309821; c=relaxed/relaxed;
	bh=6i/yP0REzn9lxzfgjUg8E32OU9DLi22+hqLzFLTzx0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbt/LfXDm6uJvKchRirhSme5uPoWXslWJXKr3X5T27DTAPB6Lf7BdwZbniMrzzsuX45Spp0yAuOC+x5DjNAWbk2nkpHpdKYoUyHvp/N0RMWdpXR+AnV3ELI9JqJ899hJxUUi/NMmsb+YN/g8qfsRo9VZ0RWJrUVcGtjoQnD3O++0cUi6XhzEWDU8AaXnyP6cIhA2ZfJfMQq98OfS8yu4RqaNn6uGQdYVdiLHqakPMp2zuJVlaXby7q9Y5mVxOpOM4ZYJ0yeaP69frjCrOUmGN6lrK9kc3FfhXNqFkWsFECCtFHU6Hyxd5TBjKLsfTwPlUgPpESdkKTt++ZN7xb61gA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MZwxm+mm; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MZwxm+mm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hRHLh6wYhz2yFY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2026 20:57:00 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L9WMWK999043;
	Fri, 21 Aug 2026 10:56:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6i/yP0REzn9lxzfgj
	Ug8E32OU9DLi22+hqLzFLTzx0E=; b=MZwxm+mmKXVrro0yW8sAs8T4RtNTa645z
	kjJjwnqs6NN3y7C6lPafolpkhNxJ19fvtLg7GR03xnyF8QPmAftkMAehZsiCiVlx
	dHm6L+OaEg1b2BPWIvPzFLi7QG/ewhw7NzEG5b5srwt2MPvUZyUD7NlpkqOQpkEA
	ydJRgty8MFuRS25zehiuNtDjuef5MdUbkBECoLekOiyYv44ZNf6+9mOadKrJjZGo
	eyJ929FUvvw+3YChf6fHlwCYycP3WDqDL7IVnb0iUg7DW6BmpJS+lZoBvrLd1p9m
	aFwUVFdqv2nPFOHegMHAEpZVI8T1PExafDFTlZDdutRJlb/DvqxvQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4grcj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 10:56:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LAuI2e016376;
	Fri, 21 Aug 2026 10:56:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32twm80j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 10:56:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LAucC041746876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 10:56:38 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E0EB2004D;
	Fri, 21 Aug 2026 10:56:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F1BC20040;
	Fri, 21 Aug 2026 10:56:34 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.bl1-in.ibm.com (unknown [9.123.14.142])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 10:56:34 +0000 (GMT)
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
Subject: [RFC PATCH 3/3] powerpc/kho: exclude THP and HUGETLB_PAGE
Date: Fri, 21 Aug 2026 16:26:09 +0530
Message-ID: <20260821105609.983622-4-sourabhjain@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA3OCBTYWx0ZWRfXxkbwyTThBDwg
 NELZnbNGcBIRpd43ywTbq7bJoKupsXLuf24EJdwZ7bSWUnLbl0XqUQEpeWNAr+ylQ5gBjbkzhSk
 KQXOVafoaF6lOSve1zqO7wXyO34+CWs=
X-Proofpoint-GUID: 65iMWXvBDsxap-MDVq5bzcbcYcilH6Y0
X-Proofpoint-ORIG-GUID: kgXdKGWl4OgHoqZlAvytwn-D23Jv81Up
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a882eeb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=vggBfdFIAAAA:8 a=Z4Rwk6OoAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=7ipKWUHlAAAA:8 a=JfrnYn6hAAAA:8
 a=T6IRowXMNMGVb2OzyiIA:9 a=HkZW87K1Qel5hWWM3VKY:22 a=gpc5p9EgBqZVLdJeV_V1:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA3OCBTYWx0ZWRfX7Ej3/twDiIg8
 xeqJ5OqfWnZMEeU/3ebf2BDeSNvYv4dyKtNbiUNMcLo1niBn1GYmmpbN30vqecweFOa7jZk2J4d
 fOskWSGhm1hpwUVYkL0Uhz9nWHsMsADvtEk0+YxfHTSax4VUjdR99nt2Sg0UGIAr2+odm5j7Xi3
 r9Eo2hU8KChIFqVKE0WpZD6ljRX5E4Hw7hy/c4/c8LjDwEeZt+fvEaKaMWHN2h45MVh6QiJUvja
 wywQBCbdFTgqCeWW6J8R4fPa7VHMTSxF96iVPqWcUD5TlQQNjcwzkHEBOQtR7zo8fQAXICx+U1T
 O0kY9Ola9kJ++SLZdYbiAcPAJGZEN4zySdUUS9leNc57MN4Jzp+wVYXTVbTAjsLrwKRDcm9y9RX
 xyoSKClhhQ4KfMD7K838Pw43+izBzqnxG8S7MP0qgcn/P4nzcdpb3FyfN52YLg36VLB9Co2yrYA
 c3iHGF/Bt7SYUsutV6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210078

Enabling CONFIG_KEXEC_HANDOVER together with CONFIG_TRANSPARENT_HUGEPAGE
or CONFIG_HUGETLB_PAGE on powerpc fails to build:

    kernel/liveupdate/kexec_handover.c:49:39: error: expression in static assertion is not constant
       49 | static_assert(SCRATCH_ALIGNMENT_BYTES >= CMA_MIN_ALIGNMENT_BYTES);
    ./include/linux/build_bug.h:80:56: note: in definition of macro '__static_assert'
       80 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
          |                                                        ^~~~
    kernel/liveupdate/kexec_handover.c:49:1: note: in expansion of macro 'static_assert'
       49 | static_assert(SCRATCH_ALIGNMENT_BYTES >= CMA_MIN_ALIGNMENT_BYTES);

CMA_MIN_ALIGNMENT_BYTES is derived from pageblock_order, which on
powerpc is not a compile-time constant when THP or HUGETLB_PAGE is
enabled -- powerpc can determine huge page size at runtime in that
configuration, so pageblock_order becomes a variable rather than a
constant expression. KHO's static_assert() on
SCRATCH_ALIGNMENT_BYTES >= CMA_MIN_ALIGNMENT_BYTES then fails to
compile, since it requires both sides to be constant expressions.

Until CMA_MIN_ALIGNMENT_BYTES (or KHO's use of it) is made to handle
the non-constant pageblock_order case on powerpc, exclude
TRANSPARENT_HUGEPAGE and HUGETLB_PAGE from ARCH_SUPPORTS_KEXEC_HANDOVER
so the two can't be enabled together and hit this build failure.

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
 arch/powerpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 61350d3e7a19..f68b9fc883ba 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -720,6 +720,7 @@ config ARCH_SUPPORTS_KEXEC_HANDOVER
 	def_bool y
 	depends on PPC64
 	depends on !CRASH_DUMP
+	depends on !TRANSPARENT_HUGEPAGE && !HUGETLB_PAGE
 
 config ARCH_SUPPORTS_CRASH_HOTPLUG
 	def_bool y
-- 
2.55.0


