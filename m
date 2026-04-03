Return-Path: <linuxppc-dev+bounces-19236-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CFBD6AB13
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2026 20:40:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmtzP6zfSz2yfl;
	Fri, 03 Apr 2026 07:40:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775162449;
	cv=none; b=PG3PG00UtOJS7qjZxzIWPOOEAaVrzIYm02IEnTcohkMKvEHiR+vPQ+iBohIDQO1XUm7GPwexz3nouMFOV6Y4NZFiOGWyvZr24yuQWi7f4wtDw3fzuuxgVAhXKKlsB9OSLfacWRMC/KGuWKm3YASHgYIhiLa3Rv5yi39B2K8JuC3V6cUif2ATjQv3aTtTXihJbIWmBYbuvHlAPx0V8RzwPe4uL5vW+wj+PkNf/ZhAJoVYfFn1pPrhvO8nVTEKe+imrX9iyNmhZFCvG31WZOn4eaAARpxm2a+9G6LSzi0hcQKx79kcJofPOuM/0UyDvKIziA6H3ol6aFJeVqF5kLwX0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775162449; c=relaxed/relaxed;
	bh=B1/Neq2m/CTKiuUiXs1KrqxKRjM7xfwfRTx73tLTlgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kiYKlkdfqF0zFAPGbtnetPhmvE29ZoOh58x6y/9nmKOd/5EH2mS7Msp8uOv6g7oF19QG+pGAtk6NIxbJsIIXhWY0JQxcYRJPxuI0iHDc9Dszr/MZXtdpRsGHFVApAlPcUFm85cT/apX+AuAVKV9H9q6hjC9/qdfCqgfhWcpUaphC2fLwQ5Gum7WHKWpRfjXitC1UDHRBS6NueT9YrwyNrtloubJDVXRl589b5W1BpRiYdI3Pb4Ujy+EChvwNx2g2ZJiZ91tpAdB/pYYBoR9gJxagv7D0PkVCOblGu/S5x3+ppzGKblxvMjIG48y0QgZR1ATmzyDy3cu52xfugdYQRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MwmdnD6F; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MwmdnD6F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmtzP29Rkz2yZc
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 07:40:48 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632KGfca2411380;
	Thu, 2 Apr 2026 20:40:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=B1/Neq2m/CTKiuUiX
	s1KrqxKRjM7xfwfRTx73tLTlgE=; b=MwmdnD6FFZ65f3cWJE/nsLoSfK5RPvksD
	NYfRfoAJVnqM6VkJcs8x6NKp7KacYJXUOJSktv8MM1BFISZQjlS2ccefvDPZKHh2
	8AWsVUPKZkuFjD2I4CZpUTxTJvQ+CrSzGz2d1VW0wv0YmE3/evWpPPMDQAZT7WK/
	SJPm3EZl3urgszKMFqojP9PQKcoSLNK/Fbbpnf82XYWHrEsAh4R+sn+1NGsdHylU
	P5BNvB5d+0PNd28Vct4ZlgKL+HFYgOKONBsoayUk3zsKJ4gcNhtTutWJXn0IBoFB
	KevbydR9woSEDnCegwL11lcltn4VHlTVfiNrb+xF2uqVmP9IvmNrw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d64dgwrrp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 20:40:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 632GtqZ4013922;
	Thu, 2 Apr 2026 20:40:33 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttkuk4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 20:40:33 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 632KeTgo26870042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 20:40:29 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE62620043;
	Thu,  2 Apr 2026 20:40:29 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C91F520040;
	Thu,  2 Apr 2026 20:40:27 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 20:40:27 +0000 (GMT)
From: adubey@linux.ibm.com
To: linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, bpf@vger.kernel.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH v2 4/5] selftest/bpf: Enable verifier selftest for powerpc64
Date: Thu,  2 Apr 2026 20:40:10 -0400
Message-ID: <20260403004011.44417-5-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260403004011.44417-1-adubey@linux.ibm.com>
References: <20260403004011.44417-1-adubey@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDE4MSBTYWx0ZWRfX7vCVFiok5Nkl
 quj7/HbPrGeqw3Y/T+gWpX4T29l5dGGW47fVY01rucGF1GuZuClPcArZ+CviIFzxqyIWPPQl9lC
 ZhBQ+/DLPtyB9ANA6ktbrGwH64/7q5YROf2C61DVdFXMA9eH0Kye1QrVB5ICdDPekTnm9B3oIzx
 /vMePGNy8rDXW49PpyhU+BP9wpnC8vkSK+8ZMTUiMsKrxkVVdLCHpChgL2Agigtz+LYoLBdOnMm
 3fUEXL1jChHqJWE7UBB3ILvz5bNzKAhefzotojftw0MRNyHjHdqG8jjF3OB95Wcca82pJ+Pq7ft
 pXs0uZsUoNNkNlwlQK1dS7r/aw/LciTSOmJSH+8l4Qc9RqCYEgfzg0tKi6ytIbaKR3ViB4GZCmp
 jcpKKGUEAur41SmqjpvZFlNbhm8JQnZELiUsHS4wkG/RKOdoCv55M+3eYDIn8bQOyydGAQf/6/j
 gBQ3uAzfStznPJfsXgw==
X-Authority-Analysis: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=69ced442 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=LqUW6rLYXr1P-t3EVGcA:9
X-Proofpoint-GUID: G4EF9MynNtk7xB9kFL25Ufpzwj27hL7L
X-Proofpoint-ORIG-GUID: G4EF9MynNtk7xB9kFL25Ufpzwj27hL7L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_03,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020181

From: Abhishek Dubey <adubey@linux.ibm.com>

This patch enables arch specifier "__powerpc64" in verifier
selftest for ppc64. Power 32-bit would require separate
handling. Changes tested for ppc64 only.

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h | 1 +
 tools/testing/selftests/bpf/test_loader.c    | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index c9bfbe1bafc1..dee284c3ddba 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -155,6 +155,7 @@
 #define __arch_arm64		__arch("ARM64")
 #define __arch_riscv64		__arch("RISCV64")
 #define __arch_s390x		__arch("s390x")
+#define __arch_powerpc64	__arch("POWERPC64")
 #define __caps_unpriv(caps)	__attribute__((btf_decl_tag("comment:test_caps_unpriv=" EXPAND_QUOTE(caps))))
 #define __load_if_JITed()	__attribute__((btf_decl_tag("comment:load_mode=jited")))
 #define __load_if_no_JITed()	__attribute__((btf_decl_tag("comment:load_mode=no_jited")))
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 338c035c3688..fc8b95316379 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -378,6 +378,7 @@ enum arch {
 	ARCH_ARM64	= 0x4,
 	ARCH_RISCV64	= 0x8,
 	ARCH_S390X	= 0x10,
+	ARCH_POWERPC64	= 0x20,
 };
 
 static int get_current_arch(void)
@@ -390,6 +391,8 @@ static int get_current_arch(void)
 	return ARCH_RISCV64;
 #elif defined(__s390x__)
 	return ARCH_S390X;
+#elif defined(__powerpc64__)
+	return ARCH_POWERPC64;
 #endif
 	return ARCH_UNKNOWN;
 }
@@ -587,6 +590,8 @@ static int parse_test_spec(struct test_loader *tester,
 				arch = ARCH_RISCV64;
 			} else if (strcmp(val, "s390x") == 0) {
 				arch = ARCH_S390X;
+			} else if (strcmp(val, "POWERPC64") == 0) {
+				arch = ARCH_POWERPC64;
 			} else {
 				PRINT_FAIL("bad arch spec: '%s'\n", val);
 				err = -EINVAL;
-- 
2.52.0


