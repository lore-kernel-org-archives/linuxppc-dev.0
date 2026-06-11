Return-Path: <linuxppc-dev+bounces-22489-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D0CDCD98CC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 11:40:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbgg15BZxz3c2F;
	Thu, 11 Jun 2026 21:39:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781177997;
	cv=none; b=T3jeT34xWb+47TFkUhKO2tBYdaihCy96hiTDLAtxM0YfkfY7k/eKPa3jM2FogEvkDJtJ+Xno3yk23OTYpeoY25+Ujof4EnC927lnJzocd2vhULdnpviE5u3Pxw53CjmbcIuJqIcYWH+/iblzQJM+jz4dncHF5cCclg8TG8pdebgSlO27uegQzDgpasZcAqbONXIDhvKWtl7+DHHey47RfIR1EPIvN+6CrLt9O3EwAt9JKdGxTb37LxegndwpHJWqdLxx903yh3JrRs6xY/XzitiOrms7ad0nsIL3URLY2NIxfy8J00dvpSLNI4EvLxpo7KueqKWOSiUYJKkW9ZCsEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781177997; c=relaxed/relaxed;
	bh=aklu07BPS1piXeSsoaOB53jGEe8EVF2hHvFhPPD91FI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BEvICluA1j56X4klqDyGstGnJLVNWss0YMCvumqx7j9PdbTUYHXpHWvoFg51/uhAIFJYWJymE38Y0jwGi9Lo1ytHilrjO1D2zxUqp9o/ExUpcU6TNTbuydpKLwnUnd+3+WoFeMMvAuwUeNWtUfj4AnVFf6tMB3XmyOQ1MrB38alYjlmQLi5jqNnRtpt1sWAR1IkVQaKoruyArAD6Wczi8K6ZMHvFLauLNRESNkc35qoHmq5WTzBv7S3B2JyJyLRu/2EJ2FjaPRrQYhcCY8A4H2P5Ofmpom7/WuJtGiTjRpt4Y1p9wT8wPQNJdeeUViEV0MxVPvQVJAQjwEfY7fM1EQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KNsQdL2f; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KNsQdL2f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbgg10zM9z3c2C
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 21:39:56 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65AJu7Wc4146648;
	Thu, 11 Jun 2026 11:39:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=aklu07BPS1piXeSso
	aOB53jGEe8EVF2hHvFhPPD91FI=; b=KNsQdL2fyCokJN9faPBZoGYlSfqcYRP37
	yH6vgS6KmcmSRUS7AfV4VY2KsA4i6+5uoL8hpmECTQ7oGFU4Hee6737jk1XthLux
	TVqE7siXH+0IClhWPpkPIUr5g7jsSYupU7fFeAZyCs/nWNiY44IybclWaAX+FIhr
	bXGWEAd2wxZzhk0QQ7RmBrl2YkcLZpujl6DWcrlJmMmPx8E0MujxlkU6iAtVCoMa
	mKgMhU2S2bx4zWe2UikNIU6UOP4kEh9CIWamKGm0p/Js8wzz4JrZIif8fWUDeq32
	XNCjOv5RY6FAcKpCqJT/1HV339FIxbWtfRH9rG+67piviRfSceY/Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8c35jp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 11:39:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65BBYefq009100;
	Thu, 11 Jun 2026 11:39:42 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09jyct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 11:39:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65BBddiI35520806
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 11:39:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AEF120049;
	Thu, 11 Jun 2026 11:39:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48BA520040;
	Thu, 11 Jun 2026 11:39:37 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jun 2026 11:39:37 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH v7 6/7] selftest/bpf: Add tailcall verifier selftest for powerpc64
Date: Thu, 11 Jun 2026 11:38:25 -0400
Message-ID: <20260611153826.31187-7-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260611153826.31187-1-adubey@linux.ibm.com>
References: <20260611153826.31187-1-adubey@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDExNiBTYWx0ZWRfX3UBHkJRA8ZzG
 U3ePcvKYXxpNrbMLieMel2DlJEKJ8pL7q0si4kfbe8i6VJ+7CPL3RIQj+Xxh2hSi3I5dYlrYWi7
 jVubuJ01HRf/CdnQlS9n7CgXXzbfkZI=
X-Authority-Analysis: v=2.4 cv=AYCB2XXG c=1 sm=1 tr=0 ts=6a2a9e7f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=v_EuApQnFJK-j3Uko2UA:9
X-Proofpoint-GUID: D-1w_WtVY1pry_9bj5gisocilce7mCtW
X-Proofpoint-ORIG-GUID: D-1w_WtVY1pry_9bj5gisocilce7mCtW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDExNiBTYWx0ZWRfX8rL5wmIRuVSW
 MIlbiFzD/5iAwsjhEROqjrUzGwF4gdV+KIdJdJqpEYNgB3SXdFJtKM/TWt/rl5M2NdEau9e78sY
 7v8YvdtHbEWJaiVNbwqh2pm9ArHRhk22cR17MofLEX0HIHPFUx0FADCkPxAAtP94mE/kLdAU+xm
 726cufkn0EfLEd7LKZU+oFbhJ7rjq7FAV//WI9rVeTaQVV13rGSChV5PqlLj+8AnBmlVKuf5i3P
 o70JYxzvSw9HWiaAqq+m/Zdg07kFteVU17N5dc4r3n6sYfibAhc1T3Rmxayiad4jMcbGSWJvkDi
 hv+uekWKih89iiM3E6gOT7x3JCPh56Us7vtnSqCKVCZh+yr/Yx8safKQ/rYYD0+L9UPo6s7nTux
 E8e1OlDrlFU4jiAsVURRqLNldFMXcyvlBuzxJbc5HgesXMFBQDBCLKWiZpWiGEzwpVhrO4Mm0q/
 gTSByIHUKm61g9H56Og==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110116

From: Abhishek Dubey <adubey@linux.ibm.com>

Verifier testcase result for tailcalls:

# ./test_progs -t verifier_tailcall
#618/1   verifier_tailcall/invalid map type for tail call:OK
#618/2   verifier_tailcall/invalid map type for tail call @unpriv:OK
#618     verifier_tailcall:OK
#619/1   verifier_tailcall_jit/main:OK
#619     verifier_tailcall_jit:OK
Summary: 2/3 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 .../bpf/progs/verifier_tailcall_jit.c         | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c b/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
index 48fa34d2959f..09d7e92c8491 100644
--- a/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
+++ b/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
@@ -91,6 +91,75 @@ __jited("	popq	%rax")
 __jited("	jmp	{{.*}}")		/* jump to tail call tgt   */
 __jited("L0:	leave")
 __jited("	{{(retq|jmp	0x)}}")		/* return or jump to rethunk */
+__arch_powerpc64
+/* program entry for main(), regular function prologue */
+__jited("	nop")
+__jited("...")                          /* ld 2, 16(13) absent with CONFIG_PPC_KERNEL_PCREL */
+__jited("	li 9, 0")
+__jited("	std 9, -8(1)")
+__jited("	mflr 0")
+__jited("	std 0, 16(1)")
+__jited("	stdu 1, {{.*}}(1)")
+/* load address and call sub() via count register */
+__jited("	lis 12, {{.*}}")
+__jited("	sldi 12, 12, 32")
+__jited("	oris 12, 12, {{.*}}")
+__jited("	ori 12, 12, {{.*}}")
+__jited("	mtctr 12")
+__jited("	bctrl")
+__jited("	mr	8, 3")
+__jited("	li 8, 0")
+__jited("	addi 1, 1, {{.*}}")
+__jited("	ld 0, 16(1)")
+__jited("	mtlr 0")
+__jited("	mr	3, 8")
+__jited("	blr")
+__jited("...")
+__jited("func #1")
+/* subprogram entry for sub() */
+__jited("	nop")
+__jited("...")                          /* ld 2, 16(13) absent with CONFIG_PPC_KERNEL_PCREL */
+/* tail call prologue for subprogram */
+__jited("	ld 10, 0(1)")
+__jited("	ld 9, -8(10)")
+__jited("	cmpldi	9, 33")
+__jited("	bt	{{.*}}, {{.*}}")
+__jited("	addi 9, 10, -8")
+__jited("	std 9, -8(1)")
+__jited("	lis {{.*}}, {{.*}}")
+__jited("	sldi {{.*}}, {{.*}}, 32")
+__jited("	oris {{.*}}, {{.*}}, {{.*}}")
+__jited("	ori {{.*}}, {{.*}}, {{.*}}")
+__jited("	li {{.*}}, 0")
+__jited("	lwz 9, {{.*}}({{.*}})")
+__jited("	slwi {{.*}}, {{.*}}, 0")
+__jited("	cmplw	{{.*}}, 9")
+__jited("	bf	0, {{.*}}")
+/* bpf_tail_call implementation */
+__jited("	ld 9, -8(1)")
+__jited("	cmpldi	9, 33")
+__jited("	bf	{{.*}}, {{.*}}")
+__jited("	ld 9, 0(9)")
+__jited("	cmpldi	9, 33")
+__jited("	bt	{{.*}}, {{.*}}")
+__jited("	addi 9, 9, 1")
+__jited("	mulli 10, {{.*}}, 8")
+__jited("	add 10, 10, {{.*}}")
+__jited("	ld 10, {{.*}}(10)")
+__jited("	cmpldi	10, 0")
+__jited("	bt	{{.*}}, {{.*}}")
+__jited("	ld 10, {{.*}}(10)")
+__jited("	addi 10, 10, {{.*}}")    /* offset depends on CONFIG_PPC_KERNEL_PCREL */
+__jited("	mtctr 10")
+__jited("	ld 10, -8(1)")
+__jited("	cmpldi	10, 33")
+__jited("	bt	{{.*}}, {{.*}}")
+__jited("	addi 10, 1, -8")
+__jited("	std 9, 0(10)")
+__jited("	bctr")
+__jited("	mr	3, 8")
+__jited("	blr")
+
 SEC("tc")
 __naked int main(void)
 {
-- 
2.52.0


