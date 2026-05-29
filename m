Return-Path: <linuxppc-dev+bounces-21672-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59136CD4F54
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2026 21:59:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRL4F2Rzdz2ykc;
	Fri, 29 May 2026 07:59:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780005565;
	cv=none; b=WKWope364ErHL0ZaoOpreGDen4yj50vaeNJSLds6CYd5hcGNrgoIH6Wu9Gc8nBAVj+9b6lEjAgYS6dn9NctzQ/wRe/xaYpmOX1F20SNw0WLIqncpQ6udhZcF1zQmHhhg37slAZDhjNUtpS0yEG9OK32q6t5Nf9EKp1DMNIFidVmFoLrgWeMN+tyqCKR54j8kT+cT2zKn/y05EB+mvUQ44CoHdN1hjyCHI8JR7Ah7jT30nU0/qBtOpasLqY6ugYKhP0QJNZoDIEYd0CTatHQZ8hnC9iyDznu8TC1ZNcQfAgG/oK9VPpugHlXD79vUV4vXQ7KaZYrwEqj6zG4Q8c1jvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780005565; c=relaxed/relaxed;
	bh=TIct3NHUYaBH36Fj/LbbJuo0SwZOr7xZ34JrF6Ab3dM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=novawh/Dy4OOhELQeBo1L+bS4VgfxcEbQI1nrzV/MijxrCZsRT/8OUsWrl1OfZKSJ64OXBFFlBebCC0cKWAcNgOJevSbCSc3R0+j8Ujb71/4vujmB0CWOKhygQTo1nUJ8GJh6Gz69+oF02sICeylJhwL5e24VvVQSwYiVahMB1f6TIJpLi9kbdzj4Jyg90/HNWSfopUM3XI7ncme2h2Sn2rvJiMv+WuAvzBIJP+DWMzeaHrpA52V+HhRL61HoDB4WV/XiRqc38TduIyQQfUSJ8VsSOeCVHwroFohnhzIXYdYs8xRS9KqKez1u+5XrzguS9KdZ+cm5QQfBogbcJ90Gg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ftX5Kq8N; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ftX5Kq8N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRL4D4pfLz2yVd
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 07:59:24 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SLlhDN2418040;
	Thu, 28 May 2026 21:59:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TIct3NHUYaBH36Fj/
	LbbJuo0SwZOr7xZ34JrF6Ab3dM=; b=ftX5Kq8Nx5d78F8f4MrRuidt9LoTpg+Sq
	Y5l2hhK+o/NV9BQlqt1+kMppvFACSvWqOuRnER82qIHFlGHEUzOgvd1cNs/6PipV
	zIoQsHSrTD+rlAK9XvaTu/9c0KaTvub5seLvTEm2Fj+6sRbXhu1R/aOxI2EMvLTx
	nC7C+pOBxIjCqQ0WWwtn2inhwMBBK5E2Zfjenm3mLpiDGZ6CvFPNV2d1DLobh/Xh
	8mrp74GdZqNTqVwpnQmajWDatC9IshUJPSVnIgZT/TvmuZNRhSjFANuPKeUG6BR+
	pRJX4J41UC74Co/Yow9RxMBgHsO9dbbWcuXCzZdT8GjVR7gpqfWpQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884nepb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 21:59:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64SLdDg6002725;
	Thu, 28 May 2026 21:59:10 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrba8js-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 21:59:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64SLx7R729950358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 May 2026 21:59:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D91F20043;
	Thu, 28 May 2026 21:59:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3369520040;
	Thu, 28 May 2026 21:59:05 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 May 2026 21:59:05 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH v6 4/6] selftest/bpf: Enable verifier selftest for powerpc64
Date: Thu, 28 May 2026 21:58:53 -0400
Message-ID: <20260529015855.364704-5-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260529015855.364704-1-adubey@linux.ibm.com>
References: <20260529015855.364704-1-adubey@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=L4MtheT8 c=1 sm=1 tr=0 ts=6a18baaf cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=DRl-xmwt84w-93Xc4WMA:9
X-Proofpoint-ORIG-GUID: Xrklcd6sZOJKxBD_6Xpnn3TBbJZMvsHo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDIxOCBTYWx0ZWRfXxHzoGvJV2wvz
 oxK/0O3K2NncimQOKciefBHy8H9n3Rhvqej3dsRM1x+p5g1jFIf5LUIGv/jDgxcqlWiGmHN7vjv
 wF4ZM0RIjoWRu0kxF7RgwABl2TGhQSSVxSuduqSJnInopj787Ixl0nN2iTzSEX5pfrmUuEBTibx
 aD1kQ2Yt3a3euTmkxooiHf9tKTjVp9rum2IgtxDWErv/zG34Jst8HKrH2yosAoqmP6mIO+w4VyR
 d8b0q+CHP/TBWaLfV89PDHz0HKkxrIKYvLtjNs7ZkXzPaNnuN27sasgPIFk4vhd49XOPICgAsNE
 7cfvTlfzZdnRxWHeiDjOV7v73L9hju0rpG8NL5hobsIyv09BYK3y/g71ArY2MJ66+Vr5VAokDMx
 ztfNocAC3C6OKKXsg5yYHics35Jm7D8lVIzA9MmKQsXtrdkrCYCENxybZVAOLPLyzgWLhUshhdB
 qY226U7Bt6BHYblszYg==
X-Proofpoint-GUID: Xrklcd6sZOJKxBD_6Xpnn3TBbJZMvsHo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280218

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
index 9eeb5b0b63d6..cdc2a3de3054 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -158,6 +158,7 @@
 #define __arch_arm64		__arch("ARM64")
 #define __arch_riscv64		__arch("RISCV64")
 #define __arch_s390x		__arch("s390x")
+#define __arch_powerpc64	__arch("POWERPC64")
 #define __caps_unpriv(caps)	__test_tag("test_caps_unpriv=" EXPAND_QUOTE(caps))
 #define __load_if_JITed()	__test_tag("load_mode=jited")
 #define __load_if_no_JITed()	__test_tag("load_mode=no_jited")
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index abdb9e6e3713..d5589355ed9e 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -377,6 +377,7 @@ enum arch {
 	ARCH_ARM64	= 0x4,
 	ARCH_RISCV64	= 0x8,
 	ARCH_S390X	= 0x10,
+	ARCH_POWERPC64	= 0x20,
 };
 
 static int get_current_arch(void)
@@ -389,6 +390,8 @@ static int get_current_arch(void)
 	return ARCH_RISCV64;
 #elif defined(__s390x__)
 	return ARCH_S390X;
+#elif defined(__powerpc64__)
+	return ARCH_POWERPC64;
 #endif
 	return ARCH_UNKNOWN;
 }
@@ -580,6 +583,8 @@ static int parse_test_spec(struct test_loader *tester,
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


