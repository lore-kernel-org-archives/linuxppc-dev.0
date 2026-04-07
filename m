Return-Path: <linuxppc-dev+bounces-19433-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC005FEEF31
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2026 12:44:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqm9851yxz2ySk;
	Tue, 07 Apr 2026 22:44:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775565852;
	cv=none; b=kY1AMR7Fl3UxnZ3+v2YcVvmzsRRochvj33CZYroT4f8+Rjc4/l1GcJ3Gfyk7fbmAJgwHXWqNZh7DngRCv7UtZpD/NmbmYAVv507jqIHYm1sVUmYdx2XRpDEzvT4G1tShgyinWXFQqvyFJt1EQcu8PZCBOkgvcphM6425B1HWzH7gCu+jga9RhvIURdUR5fOt+/koXja6Qui3VA18gjjriBIqSn5xfyV7GZxfnzaUUJ7y+qM5GCBj0T+sGM94/+RZLND41h7zoAkY2zA34WjegSUHbbrT2/IWRUzgJEv58goblbY19+hUG71DctBQWIS4jsI9xWMM+MGWM36LYF/EKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775565852; c=relaxed/relaxed;
	bh=GIyIVK/ANuekaENEgT99syx3twewoAoza/eXIw8/UDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJbJkIAfjIVj2OlmJsXToyaoBs7vU+zXDcAPXyCQoHsV0NRsAcWsy5lgW/GBTTJ1BnLgQA3NL3N/t61rmMjXI8QmJaSiUrMPI6yVyblhIni2iYN/JzwucwASNikga9H99IR70VB45zN0WOvxRAqzw3XtlN89XDEFMEX71PX2W3ejVCfvG4RhBgW23/k78Rek9LRVkKvSiBsZmKfvf9APxZT8iOekdK9TfWq8OlwyhFSrNfQxrZ3TcYDGm9z/1CrjqdhE1ZHfPAeHcL8wUi793qO7xJkfpA06PDS+iDoNV8hLgC2x/jxybKrSppkRapnEDiRrSTgAWTt6aBsrqIdiQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=S2slrH4A; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=S2slrH4A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqm975ljkz2yl2
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Apr 2026 22:44:11 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LmUbW2211703;
	Tue, 7 Apr 2026 12:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GIyIVK/ANuekaENEg
	T99syx3twewoAoza/eXIw8/UDM=; b=S2slrH4AJjqX7Ct1UgY2EZCKpU2mMMInS
	TRdM+Gtlc1uir2liVNS37D2Lpu/gLEsqHwZcnARLiVm/DsIWPRHNJkbgLMpv8jmg
	Hr5WYRtYR7/XBcnWgv4wmt0L01pBCRF09FEUT8zq7GJwfh/ikBBGvQ15Q/xFQYbY
	c/28r0fxtNvV/bjJu+dZ1AOFsLYz3SPIyWbnVRGVeCFhx/Jsly9sJtcrGQ6MYMYm
	NRZGE/0MM7It+948c6WL0JYhu6CwdqvWD8dWudBD9AgZL7c7J+MzT/Pjz7bJUHLI
	SVw5zUX5v9VCSEW/S3lWhfvqFXBg+RxqSBGLy8IooeAkUSZdiyHiA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2hansc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 12:44:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637BO8De014356;
	Tue, 7 Apr 2026 12:44:02 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg4k447-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 12:44:02 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637Chwg242467676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 12:43:58 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B320F20040;
	Tue,  7 Apr 2026 12:43:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D33262004B;
	Tue,  7 Apr 2026 12:43:55 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.bl1-in.ibm.com (unknown [9.123.14.142])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 12:43:55 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>, Daniel Axtens <dja@axtens.net>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v3 2/2] powerpc/vmx: avoid KASAN instrumentation in enter_vmx_ops() for kexec
Date: Tue,  7 Apr 2026 18:13:45 +0530
Message-ID: <20260407124349.1698552-2-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260407124349.1698552-1-sourabhjain@linux.ibm.com>
References: <20260407124349.1698552-1-sourabhjain@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDExNSBTYWx0ZWRfX3ibF8yWc06pP
 Bj5poZ4zko129cx9U0CZ8ryBDqjB8JYdKWjguYjpbs5+tUZoejqvryvv8uhYqXh5/c9lbjEoUn5
 Zx9myA3r3/eoSLM6+G353jZkXokea8UlmiyYQXGFNfCsyKIuA15rpbZo+vVWyf3bQWFVL3d4q3S
 VYG3NCypLVmI1DheTS3xoLbE6JJiK2MyAXRhkpagv5r3w4QDeqWtPzkLFeX7Ufxyumg3MWLLP01
 HcDFi9VZZ5RGKITevBddKdPJU/dOXc5zbuW3/G0PKeZvTRs+IDkdqwbQwv7F+nf7KPCFu2j2md4
 d7IRUgGvb2G0DO4+iPmgdqSSEwviXMspWH3GAACKj4EKRqJ5q0o6UE10VyYjx4MG2370J4aWt8l
 HtF1Rakkd2fHAPb9miqy3mRsU9tbsoPP2buOGKlpHoj/I6a8qf3kA0Nb3OIERnO+/ARB/ScaQwN
 j76a9W708lACMj7V7nw==
X-Proofpoint-GUID: A0j2qXs_N88yAbdG8TDIUGDJXtAXg-JZ
X-Authority-Analysis: v=2.4 cv=a/wAM0SF c=1 sm=1 tr=0 ts=69d4fc13 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=JuTF4qcAAAAA:8 a=pGLkceISAAAA:8
 a=gEFjLL80loUrrBp6AGkA:9 a=WlT8qwTXB_Kj6um4hl3b:22
X-Proofpoint-ORIG-GUID: jmIsnL-G9LM6NQjD79IiIxz-A02pvv7Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070115

The kexec sequence invokes enter_vmx_ops() via copy_page() with the MMU
disabled. In this context, code must not rely on normal virtual address
translations or trigger page faults.

With KASAN enabled, functions get instrumented and may access shadow
memory using regular address translation. When executed with the MMU
off, this can lead to page faults (bad_page_fault) from which the
kernel cannot recover in the kexec path, resulting in a hang.

The kexec path sets preempt_count to HARDIRQ_OFFSET before entering
the MMU-off copy sequence.

current_thread_info()->preempt_count = HARDIRQ_OFFSET
  kexec_sequence(..., copy_with_mmu_off = 1)
    -> kexec_copy_flush(image)
         copy_segments()
           -> copy_page(dest, addr)
	         bl enter_vmx_ops()
                   if (in_interrupt())
                     return 0
	         beq .Lnonvmx_copy

Since kexec sets preempt_count to HARDIRQ_OFFSET, in_interrupt()
evaluates to true and enter_vmx_ops() returns early.

As in_interrupt() (and preempt_count()) are always inlined, mark
enter_vmx_ops() with __no_sanitize_address to avoid KASAN
instrumentation and shadow memory access with MMU disabled, helping
kexec boot fine with KASAN enabled.

Cc: Aditya Gupta <adityag@linux.ibm.com>
Cc: Daniel Axtens <dja@axtens.net>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Reported-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Reviewed-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/lib/vmx-helper.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/vmx-helper.c b/arch/powerpc/lib/vmx-helper.c
index 554b248002b4..57e897b60db8 100644
--- a/arch/powerpc/lib/vmx-helper.c
+++ b/arch/powerpc/lib/vmx-helper.c
@@ -52,7 +52,14 @@ int exit_vmx_usercopy(void)
 }
 EXPORT_SYMBOL(exit_vmx_usercopy);
 
-int enter_vmx_ops(void)
+/*
+ * Can be called from kexec copy_page() path with MMU off. The kexec
+ * code sets preempt_count to HARDIRQ_OFFSET so we return early here.
+ * Since in_interrupt() is always inline, __no_sanitize_address on this
+ * function is sufficient to avoid KASAN shadow memory accesses in real
+ * mode.
+ */
+int __no_sanitize_address enter_vmx_ops(void)
 {
 	if (in_interrupt())
 		return 0;
-- 
2.52.0


