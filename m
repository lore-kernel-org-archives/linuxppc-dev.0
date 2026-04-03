Return-Path: <linuxppc-dev+bounces-19287-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D947EE8538E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2026 19:01:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnSkr16Mnz2ynn;
	Sat, 04 Apr 2026 06:01:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775242916;
	cv=none; b=OiYRRgNtFF5abVGyYp8JZDMARbU10+OpjpTAb5IMh12wT43rWQZozLF2m7jTQu34Fg8NF3QgcNuIHmJFJw4x/9mrn6+1XJLWkg9SMegHcaKQj/3kg0CKAT5qrxBwIKOLbL2I9MCR7UF8DWqaH4XQnXs8rN84M2wG+8QQT8g/HjmgCQ/liWOuf2m5cAnFd24LmLGMVD5BwfEXx7Ri01Kv+1HP6zx34UpgTeOHzUVrjGUcToRRUkNKXKUT3XeLCzo3IdqrAWa6lctgDFRHdEX+ej3YopaEskW0P27R+vEzD5dK3QSCZtGQTSL5z33BnJWaZO7eK8MrkCxLCbS2DsuwDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775242916; c=relaxed/relaxed;
	bh=Fk9oWvBHnCy5qQ9Vssar888LWNTkUho9CDRjRcwyrdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwvKqcOxPyl5g+nJhkLz73z7fYr6buOOi/XJauw89u2WzG4sRonWNrUenZRPCeyaHjCzTIIfKF1xeEQ7cXakPRLX9JWVx7OYSqANru9SNwZB9PahlzTN+T5KVlkEl4sWS9SW2bX5zlgYR/G0oKZ0nBTa8gOnJF5JflRlch/ChY9Xb71tk9X7rw2QEr4p5+H8BImPecfd9vBybwfBnPPPWwxLjFkKXoEWEY1FBbvULPOqGemgESzo7PBnd6Kk0UHkSZwFGdY9Gut3IosNcS7bXDBzWiwMvKtNkCPk0E2YHzPTQHbaqhL/9KoOb2BcJNYGZDgX5Vo2ZMUG6eMuGaqKRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JHzN5lF8; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JHzN5lF8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnSkq28JYz2xSF
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 06:01:54 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 633CYvod172363;
	Fri, 3 Apr 2026 19:01:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Fk9oWvBHnCy5qQ9Vs
	sar888LWNTkUho9CDRjRcwyrdE=; b=JHzN5lF8pwKXHvX1WDLCb/urnzZsw1Jff
	6OJ1+dBBNBAZ6PsSG2iM1nS396l2LyYip4CR5Ate2q8YAwCAxSdTyLIsUJPcCV/I
	M2e8gS+mrHCEhU061ZuFtaO7z/oobhIW0iVTywJ2NNke4BgxcVsRiPqtZpjOh43d
	It/tHPtjy5t9xhUtYRo/S9oSVZJxijArBhu8W32+CBFRbQhgWE9Vxua/FCj1vPR4
	HOQvPbm4zxgn0V8if2lo5IqP1RccYSmYIQoYjfoyET/X2vfAC+qB1GpSxwAIYciv
	/VVUYF21z6bsV3P+fzQhtOrgVnqMpr/xZcZ37TDQaUvy6QZ3XppJg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66msgtvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Apr 2026 19:01:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 633Iu8XN005757;
	Fri, 3 Apr 2026 19:01:43 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spyf93x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Apr 2026 19:01:42 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 633J1cp415204674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Apr 2026 19:01:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D154B20040;
	Fri,  3 Apr 2026 19:01:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D06C120049;
	Fri,  3 Apr 2026 19:01:34 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.domain.name (unknown [9.39.18.186])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 Apr 2026 19:01:34 +0000 (GMT)
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
Subject: [PATCH v2 2/2] powerpc/vmx: avoid KASAN instrumentation in enter_vmx_ops() for kexec
Date: Sat,  4 Apr 2026 00:31:16 +0530
Message-ID: <20260403190123.1383198-2-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260403190123.1383198-1-sourabhjain@linux.ibm.com>
References: <20260403190123.1383198-1-sourabhjain@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69d00e97 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=JuTF4qcAAAAA:8
 a=pGLkceISAAAA:8 a=gEFjLL80loUrrBp6AGkA:9 a=WlT8qwTXB_Kj6um4hl3b:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDE2OCBTYWx0ZWRfX6nUmjs3Y/LGH
 Y0JJNrg5Gl2qi+uOLbHy0dVwzk7uLmawynEkOfhkVhLWkjRUIR92JXfhVE8aop4KGHdPelqxlyl
 f946tFx/u/am4xhi66cpPB7taQOx7U9a8lI9NK1HMPrlKG/cxFbmbyrpYPFGZe7PrQjlhQHF5Py
 6DmXLkBxrYTAt5GT1bgGN8bLnVoFrKWef6lhJar4sDB3dOxEyt/bYb9RfO6Qf0fOed54I9yHJ5q
 VBGLEgw9WorizkLzBOjG8eGTNz5dKd98U2xwoxTs0ZUNlcUr7m6PBuYxoMocSUzsMRD1KfgrPkA
 1AmZUaJKrMDEMIXb7dI0H4XGYe88fs7kvPZC51PyHwtxVtTwjhXQGJ4AF093SBspRD67g/CdhJF
 YZ4IViDxUffuFLS72xhTq4DoJKxrkL8BNHSvLTAPV4+DZ55mTDumGg3pidql2cbWhq11QNNJdXR
 ko8Bt48iF1zqm3p5hTQ==
X-Proofpoint-GUID: gc-R0yRt5PxRsneAIxK3nyaFUvfZXCv9
X-Proofpoint-ORIG-GUID: ihsgHPd86lqwb0J-KpKTUuI6W_7fqkeg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_05,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030168

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
Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Reported-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
Changelog:

v2:
- Remove __no_sanitize_address from exit_vmx_ops
- Add a comment explaining that marking only enter_vmx_ops
  with __no_sanitize_address is sufficient for kexec to
  function properly with KASAN enabled

v1:
https://lore.kernel.org/all/20260321053121.614022-1-sourabhjain@linux.ibm.com/
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


