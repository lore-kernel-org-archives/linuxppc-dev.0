Return-Path: <linuxppc-dev+bounces-19652-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD3EF3ED5D
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Apr 2026 18:14:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ftMJS3tjkz2yl2;
	Sun, 12 Apr 2026 04:14:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775931272;
	cv=none; b=NNG6P1UVm/OIT/a0O0KaGgJ33jVBC0bSQpjj2/8yt8Q9yxAQmAN2eULsplDUAboYzWqsdVkXJgQRZRUEAWwA+iBx4s3eh7PaYDU9VJ3T1BdBINFgwWz8J2AGBoXGk/0HrISe9d24wJCvbDIeip9cOT+iLUDNFpA3rU8i/clOXu40/UftpSQdvavTd7qgipwkvlapGz8h24yBEIBXKnlbc3sT9QD23cuaYVULKxXwIZvXrd8zko3pxJ1TOC8dQXoDgxRkLULOBoXh8Bx+V71+0drm+vCaarvb8CvUJpfMXpe9KTi+dJTyOufQtxLoxokJwOvoDWSlDuSRGmCqZBlQmw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775931272; c=relaxed/relaxed;
	bh=/+Fg77UFVERdhIcfnJPmiGBFbyGneKpzzqbjfmQa53w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hjb1WMy4jVpnhdXHuZ8vskSOLUjsuecAiryPKzbKszkE291m1H8EvNpxqPgY9zk7kdNCLBJx8+59ArXVfbBkrq1te6pE1HSBnW//Vw6PIFmtWZT4X+4DZA2s2Il7gyC1GWaqxGjEjacM+ns8xOaDqJuLahaMh1WQds4VGFpDqiZ0+qWReDe1dmqT7TYEmMuORFYJBUqclRtF4KTllcwEj0XzNwbajvOh63TxKDjUghs05wNfe4Jk0KfoJDNtEY6TkX29BnbAVdiw41As6GCvkiRD7RYrrlJStYCJDW3GK3Np1gzBHQ8krFVNgUTW9G2QKFHEUrLenzoWQzAq9DpFJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KirhiVMH; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KirhiVMH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ftMJR5bwRz2ytj
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Apr 2026 04:14:31 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63BBrkkb3508724;
	Sat, 11 Apr 2026 18:14:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/+Fg77UFVERdhIcfn
	JPmiGBFbyGneKpzzqbjfmQa53w=; b=KirhiVMH9M1Q8U950cwgGyhcZCoQN+WHd
	VM0QL6VfIWiTNLmK9uTnrA6VxPv3txzdWVPwjRdcVarEeKfScBs2u2L7U4RzELJL
	q6XJwYj2U2td5oErB1ecVsccwS6iUKvflLhYL8ArzeqH4b8IXSyaIvnoIe7758vn
	TxbTxVOifRonstQkTzJYI6pQjM5SQuwYGPLVXXvnwv9V2R4kJn8vQQlbopjnp5GT
	Ra2cKdVezTJUsKGYfuNzOshiuRti4FL0Hf8ICQ2YkMo7uByZ36MyX39JuQOrnPB4
	nfIQkSiDNJvvEXbzElRTpnjik75WhXp/GyZttZPsl28SGaz1gEgFA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfdxwsrmv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 Apr 2026 18:14:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63BDV7QE013827;
	Sat, 11 Apr 2026 18:14:17 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmf4n6f7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 Apr 2026 18:14:17 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63BIEDcs43450634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 11 Apr 2026 18:14:13 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1479C20043;
	Sat, 11 Apr 2026 18:14:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E62B20040;
	Sat, 11 Apr 2026 18:14:11 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 11 Apr 2026 18:14:10 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH v3 4/5] selftest/bpf: Enable verifier selftest for powerpc64
Date: Sat, 11 Apr 2026 18:14:12 -0400
Message-ID: <20260411221413.44304-5-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260411221413.44304-1-adubey@linux.ibm.com>
References: <20260411221413.44304-1-adubey@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDE1NyBTYWx0ZWRfX1wtaZCvzVWZm
 /ZezTU3ReOhWwrJnF3ZrV5wzNf8O7GgLWq0W+sFQGRzXhNEkYtk0EmoPOfZmMsR7UTQdvjan8p5
 c64QVSXw+PzDC3aDLRa/TFqcg9nLUHXK/lgsBXdbbK3gr8afQ9qGLoAPwKz9yiAa2Y9P79jhKe+
 fbTMqEcD6fNg90khPeiH2XgJGOeFo0yxNNeuSKhkh0iweYo/1avWRdFgHy0nar575Oa9d9RbjAx
 Ee0L88ebrCuWuU97+aUlCkklNdmlO0ZRRT2s3QA8V1roYDEzwcvkncwXAKmnf7i/mIMdHTGgow/
 LYLAUREs9eeTdB1YzBNl+NAfwiBK3VFwZTGd5K7hw8vxLdSiwiXRk/VTxxqAnV9bKBquW3LEuM4
 uu3GzXtzR34o7weB0ypp/uwrznpJxanZO8wdUEGGCqRqrFKUgBJ77RMbrvbAK4YDWa27D082Ro4
 oNvK7ZBK/624Mg4AnlQ==
X-Proofpoint-ORIG-GUID: g5YeKLljJDA7zbo5nzEMtBpGBnCFE71G
X-Authority-Analysis: v=2.4 cv=TId1jVla c=1 sm=1 tr=0 ts=69da8f79 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=DRl-xmwt84w-93Xc4WMA:9
X-Proofpoint-GUID: g5YeKLljJDA7zbo5nzEMtBpGBnCFE71G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604110157

From: Abhishek Dubey <adubey@linux.ibm.com>

This patch enables arch specifier "__powerpc64" in verifier
selftest for ppc64. Power 32-bit would require separate
handling. Changes tested for 64-bit only.

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h | 1 +
 tools/testing/selftests/bpf/test_loader.c    | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index dcd78a3a9052..8e8a732b4481 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -157,6 +157,7 @@
 #define __arch_arm64		__arch("ARM64")
 #define __arch_riscv64		__arch("RISCV64")
 #define __arch_s390x		__arch("s390x")
+#define __arch_powerpc64	__arch("POWERPC64")
 #define __caps_unpriv(caps)	__test_tag("test_caps_unpriv=" EXPAND_QUOTE(caps))
 #define __load_if_JITed()	__test_tag("load_mode=jited")
 #define __load_if_no_JITed()	__test_tag("load_mode=no_jited")
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index c4c34cae6102..9b0736831484 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -376,6 +376,7 @@ enum arch {
 	ARCH_ARM64	= 0x4,
 	ARCH_RISCV64	= 0x8,
 	ARCH_S390X	= 0x10,
+	ARCH_POWERPC64	= 0x20,
 };
 
 static int get_current_arch(void)
@@ -388,6 +389,8 @@ static int get_current_arch(void)
 	return ARCH_RISCV64;
 #elif defined(__s390x__)
 	return ARCH_S390X;
+#elif defined(__powerpc64__)
+	return ARCH_POWERPC64;
 #endif
 	return ARCH_UNKNOWN;
 }
@@ -579,6 +582,8 @@ static int parse_test_spec(struct test_loader *tester,
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


