Return-Path: <linuxppc-dev+bounces-25951-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB35C5DF67
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2026 04:45:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPHFD05LPz2yCK;
	Tue, 18 Aug 2026 14:45:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787028319;
	cv=none; b=F/G6nd9UxREy1IjInZA+ZLnhhnSWR5zGsiXtE4lGC47sT1iLePv1kN5n2Tg7xEbPvyVq5XGQXUh75EWK4RfeVuU6OsgYyxSlovg/MVw0aSmA2kbV1+UGbGk6+KK13HFit7F68YyQsKiXu1R6lAeW1nNyAxOnWPVCjvgJvFh61zE8uWTW1UdSmGWhby/TRBNIK4ksHUpv8+hH5ueMWXsptLFQCkJoHBl8coZPA8L236P2G3kGfCpAJxl0CuERyJx6Vi0xhgNl0N4eDhFdNmZsqKYfqtX7L0aDzfkkC6ue7t9EqCsCkFX0ntQcI2EfpJgO+a6dp1ioTpJjTZFhYWfRvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787028319; c=relaxed/relaxed;
	bh=HkRzNQNijP4OVa+Tr9SeyrKv6nPdtXl3dFx/07Vr6eA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BdPNbzhMc4V5pORu3Wb0KOCLy/286yOVb7LyUNtWMDMWGbHouOMYOkXh3CjKu16yHdgzw7TE/gXKrg4CuQNRNyeufRg6W0WcjI0IT9V7TEXcrDS0qSb2dzGUi9SSkDYmBlf3aB6kaI9zgivTTypmo+4jPRW0vEfK1+9rtVhq0INuKXTdUq1hSOSZ0ZMmtQs88Sc7Wps0q0E1lJSsIeSRoBRTn2abmu1CsZ7fdKbAB8fdiOIetqxHhv1I0HsyLwDzXQxHmhi2JhxCa+RSt58Y1WwlIMSQdqVy4GbLHLUKwjTuwErIyR0sYr9UenWNVo2KLxok+Z8vS42yszvmXYn8Dw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JUqhMG3w; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JUqhMG3w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hPHFC2YCfz2ySD
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 14:45:19 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HM22Cm2527318;
	Tue, 18 Aug 2026 04:45:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=HkRzNQNijP4OVa+Tr
	9SeyrKv6nPdtXl3dFx/07Vr6eA=; b=JUqhMG3wrw6EvPQoxvx7YovQVjO9VSnmb
	CA5STNUzvOde90qeViphov/Eg4Tt4iw1db7UBUC8Fx/opuUTa5MdY0ZnxI0hceux
	pca6Xxs54ue1JvSbZzCbE3i64o0cZIoR4cMCGj2UAPvUwmnnWP8hI4Z0KhiJZF+D
	WLElwXa3d9PIYNPGwtfPJYZO5Q1eow5e6V08uQ1g1vUj/dZGskRWHJ2Xoc8ivoty
	2JZUU4Y/MHvTJ2AUsGvESUV+ID/lDr49FLn/pCLqjcazM7bW+vpzhLNS8CsYvfbZ
	FTp2UVQNF7B+jRzpuO2B7+3zeUoUc11hG9Cc2Ljke8siznw+iDCzA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2dhkwx8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 04:45:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67I4fJfU020837;
	Tue, 18 Aug 2026 04:45:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ng95g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 04:45:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67I4iuA537159212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 04:44:56 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B61C92004B;
	Tue, 18 Aug 2026 04:44:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E408620049;
	Tue, 18 Aug 2026 04:44:50 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.ibm.com.com (unknown [9.39.17.69])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 04:44:50 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com, skb99@linux.ibm.com
Subject: [PATCH v12 7/8] selftests/bpf: Enable verifier selftest for powerpc64
Date: Tue, 18 Aug 2026 10:13:40 +0530
Message-ID: <9dfac70df529c0a73194a5efc477cd047c47df36.1787027080.git.skb99@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1787027080.git.skb99@linux.ibm.com>
References: <cover.1787027080.git.skb99@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAzMSBTYWx0ZWRfX8xiOwAoSfnYc
 NoZVbG8mEVizfbWcCjFVCfPUKYgBjkCmgnZwPM+j/KW1d1mZQzolt5six+Vsnlbxkx2OFVX1uoB
 21zmIrf8P/iOISK+WcoswbrOyDmRBtr1ceAoD+00shdCGvGuaMAfJwOVQRQz/7Ok1oYZjmBHB02
 OSyoWjopqDA36QfXC1mWK3fmPO4Gxuxb9vPj5Y9fLqhOmRml91gnOAqABd3GgSSwJLbzrQHMVff
 SRR1y2g8nDD+F4t99qrEcQVGVIqnEsVPDCr9QRNVq3lDDogAi8J/V4i3waXsV4T3PcP0rnHcv8D
 siv1KLppkcRJ6/NzFrXOe7Nkpbr2YzqWhBJIZqXlKrYcOs3D4gBTo3uQdN8b+AxXEgTLU1UWfom
 2sBn+rd/g77BNPQkvhlmyxhDJidx33kP6d6yQtMKcSkbWz1PTsfUrkslGiRt6xwJ1u0Am/Y9G0b
 A/HbUBbM8fMEjlGrtPQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAzMSBTYWx0ZWRfX/U+5A8RW++JC
 PZHBvSmOJ9RpBetRsPOR5lZga1ee1ZBYReKI7tz8OqipmDuR7UNpTw0HvsevzhWQmHdV9Iwxn6H
 PUAtsPDIhuZq8qy3hYE43EERZGXafbQ=
X-Authority-Analysis: v=2.4 cv=JKkLdcKb c=1 sm=1 tr=0 ts=6a83e34d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=NDAN3li2bPRXDg1MUZ8A:9
X-Proofpoint-ORIG-GUID: JiFmIyTzL4mfPxJv2m5b_BUpnOO66SKo
X-Proofpoint-GUID: JiFmIyTzL4mfPxJv2m5b_BUpnOO66SKo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180031

From: Abhishek Dubey <adubey@linux.ibm.com>

Enable "__arch_powerpc64" specifier in verifier selftest
for ppc64. Power 32-bit would require separate handling.
Changes tested for 64-bit only.

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
Tested-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h | 1 +
 tools/testing/selftests/bpf/test_loader.c    | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index b0c441384f20..365008d1ed40 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -159,6 +159,7 @@
 #define __arch_riscv64		__arch("RISCV64")
 #define __arch_s390x		__arch("s390x")
 #define __arch_loongarch	__arch("LOONGARCH")
+#define __arch_powerpc64	__arch("POWERPC64")
 #define __caps_unpriv(caps)	__test_tag("test_caps_unpriv=" EXPAND_QUOTE(caps))
 #define __load_if_JITed()	__test_tag("load_mode=jited")
 #define __load_if_no_JITed()	__test_tag("load_mode=no_jited")
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 3ce32d134e2c..01b1420097d2 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -378,6 +378,7 @@ enum arch {
 	ARCH_RISCV64	= 0x8,
 	ARCH_S390X	= 0x10,
 	ARCH_LOONGARCH	= 0x20,
+	ARCH_POWERPC64	= 0x40,
 };
 
 static int get_current_arch(void)
@@ -392,6 +393,8 @@ static int get_current_arch(void)
 	return ARCH_S390X;
 #elif defined(__loongarch__)
 	return ARCH_LOONGARCH;
+#elif defined(__powerpc64__)
+	return ARCH_POWERPC64;
 #endif
 	return ARCH_UNKNOWN;
 }
@@ -585,6 +588,8 @@ static int parse_test_spec(struct test_loader *tester,
 				arch = ARCH_S390X;
 			} else if (strcmp(val, "LOONGARCH") == 0) {
 				arch = ARCH_LOONGARCH;
+			} else if (strcmp(val, "POWERPC64") == 0) {
+				arch = ARCH_POWERPC64;
 			} else {
 				PRINT_FAIL("bad arch spec: '%s'\n", val);
 				err = -EINVAL;
-- 
2.55.0


