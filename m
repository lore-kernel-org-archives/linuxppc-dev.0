Return-Path: <linuxppc-dev+bounces-18535-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCFF1093176
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Mar 2026 05:31:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fd7NB66VPz2ygm;
	Sat, 21 Mar 2026 16:31:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774071114;
	cv=none; b=AEBcqbdIth6h9ae1d3sdGRye3kkttZIf9PYfXGH3vWZNN+ivN7VxNZuE/kwjTjh9Q4HdjVd9mjRQQLTki0iVh1UdkRzO5rbE55MfnLld/B2PZm2IaMZ6Al9prXDsb9ABV3GdwxmN55YJ1MNoFZpmJN7HWrIinTba848uu6t+wvS0TAyT14n7Pi3kgq//iedKKQdz1xFNOAfez4O5gQViXi8dBhuvbSn08VDGSVX81MtpbUhAMHsuCdJlPsOUdxsk63J6MN27MEdO9hFfbtAac5eW1hHr7is2oba/4sOguYbTQ4j8j7csfkBasIAMnJh24hD1bREJnrAob1xCJKc6Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774071114; c=relaxed/relaxed;
	bh=wgKKwKDhFzDE8QZg+Ovca0ckS/q8PpXNJcAOANlcIPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hEYV62wDnURDCwqQjT8drSuv0Qmdvm+zoz9iTKrlMXgZJDJQQGjp0MEGWqK26CxCqhD9NeY/GJF2d+HaE4s2vqwaeLDr4tvVgSt9yZM1sGFD5lJiRHFCKsKs0Hm7MDEx0FDTYynCx1kHVcT5LYRWQ4+y/LEE3Du4nld5MMPYxKJbv7g9VZdCVQ+fMTfGhPzP5mTJlzP9/GZnwRNxqqcVohXdK/1sFs/DZnFWtpysS8v10AtPUARiP9s1HmgvCWTOWfEDOsussmp7FeagL8Kmt9gS1pEwsQNI1ozqAnU6zm3QI4RShrkL/OZlkxGaUgI5EDCpu0WRHMNoWFWwnUoOZg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RhzXFNsT; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RhzXFNsT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fd7N93f9Bz2ygh
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2026 16:31:53 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62L3wlmN4141480;
	Sat, 21 Mar 2026 05:31:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wgKKwKDhFzDE8QZg+
	Ovca0ckS/q8PpXNJcAOANlcIPk=; b=RhzXFNsTSfZ9J9pni3S0SMxgnKMEElxXI
	yLRjodQO5xZjgWZ5K/maCPFTyp7aTnJBogsAXvyeBx9V49r9FgtNbMhpAkSvUjR6
	nW/ElmDqs1uRbzWlFU9FM8zqbVVVs1dRbdOTDgqYzlPlRW3CNBft9jc2SlWlNgBL
	0TlNKYQyizaIb/l9tTSVxPUNcVrwBFt9N9r2NR0jZCZdgdZpqqBdHmVKWp5tHgKp
	a79ReA0/LO7XPVOfKTCrUTqFlM+PNIiJD+JudoaGLh6aMrOORK0EHS8bo9AMDdv6
	w8XF5VrBFfqRs7Qxvs2ZlSMYMZ+K4w7Wc6TOGqH05ZambHMQLynlQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kum869c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 05:31:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62L44L12012771;
	Sat, 21 Mar 2026 05:31:42 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwmq1tch7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 05:31:42 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62L5VcN643254060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Mar 2026 05:31:38 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABD982004B;
	Sat, 21 Mar 2026 05:31:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0383C20040;
	Sat, 21 Mar 2026 05:31:35 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.domain.name (unknown [9.124.222.162])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 21 Mar 2026 05:31:34 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>, Daniel Axtens <dja@axtens.net>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>
Subject: [PATCH 2/2] powerpc/kexec: Disable KASAN for VMX helpers used in MMU-off path
Date: Sat, 21 Mar 2026 11:01:18 +0530
Message-ID: <20260321053121.614022-2-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260321053121.614022-1-sourabhjain@linux.ibm.com>
References: <20260321053121.614022-1-sourabhjain@linux.ibm.com>
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
X-Proofpoint-GUID: BB2qH-cHs7Gt6qDqU4Zqcp3kkktzSkq6
X-Proofpoint-ORIG-GUID: wIhAUarcJTGoVFPatELpG8qhj7NS_8KU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDA0MCBTYWx0ZWRfXw+qlIvD3pLoG
 m7QdabL8+mkfoslclvz+Iwl0NsxeLl9qJBV2Li9p/ctJ7SMRt9zzmHx37QDulRECGefoeAzjIk8
 M004o++Gt7qunUD9M5nac6u+hVgXjwAaCLI3Ji9bwo+8oPAxmT1rVraJDdZCCjpjjMitObtRdj/
 u1ch4qihbj+Ah9mxAc3+YdoamQVVXDmMcx4ym5hCRcKbOKzC44ymsU/eeuFZZJVEjrSbJsWh106
 3VQpz93Qt628DhrPdsJ6ooh1jUd8m7YUcc2aAp1LvfslLF1hxdKMFgE/y09ycFWMCIxtdoubEu1
 mzVk1KVSDkfbS2LCaizNoniPykNpGGAYlUAIYBvnvUwFHhr5YT0HWKGGilkJN5M9IqYXdeoh6HA
 AbekSj6+TvTk1u58GFoCyvxEMTYdFWBlpswtijQFpaNKPigcrhvLOXA5slyAUTCpkSfUBBbWkQt
 JeTCKb2SIzA8S8so5MA==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69be2d3f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=JuTF4qcAAAAA:8 a=pGLkceISAAAA:8
 a=Ch0cGf-TT9rgrewJZhwA:9 a=WlT8qwTXB_Kj6um4hl3b:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_02,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1011
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603210040

The kexec sequence invokes enter_vmx_ops() and exit_vmx_ops() with the
MMU disabled. In this context, code must not rely on normal virtual
address translations or trigger page faults.

With KASAN enabled, these functions get instrumented and may access
shadow memory using regular address translation. When executed with
the MMU off, this can lead to page faults (bad_page_fault) from which
the kernel cannot recover in the kexec path, resulting in a hang.

Mark enter_vmx_ops() and exit_vmx_ops() with __no_sanitize_address to
avoid KASAN instrumentation and ensure kexec boots fine with KASAN
enabled.

Cc: Aditya Gupta <adityag@linux.ibm.com>
Cc: Daniel Axtens <dja@axtens.net>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Reported-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/lib/vmx-helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/vmx-helper.c b/arch/powerpc/lib/vmx-helper.c
index 554b248002b4..c01b2d856650 100644
--- a/arch/powerpc/lib/vmx-helper.c
+++ b/arch/powerpc/lib/vmx-helper.c
@@ -52,7 +52,7 @@ int exit_vmx_usercopy(void)
 }
 EXPORT_SYMBOL(exit_vmx_usercopy);
 
-int enter_vmx_ops(void)
+int __no_sanitize_address enter_vmx_ops(void)
 {
 	if (in_interrupt())
 		return 0;
@@ -69,7 +69,7 @@ int enter_vmx_ops(void)
  * passed a pointer to the destination which we return as required by a
  * memcpy implementation.
  */
-void *exit_vmx_ops(void *dest)
+void __no_sanitize_address *exit_vmx_ops(void *dest)
 {
 	disable_kernel_altivec();
 	preempt_enable();
-- 
2.52.0


