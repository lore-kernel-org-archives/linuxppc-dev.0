Return-Path: <linuxppc-dev+bounces-21012-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D903BCD4F47
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 May 2026 17:41:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJSsF2pfcz3bsd;
	Mon, 18 May 2026 03:41:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779039665;
	cv=none; b=MhxvxrEx1O3UvJmLVYLjmLjpMkGcEkbiQTe/AGzfla6s9oxOjyoZ37JuGBIhql9rQcLTqf9wB5wT80RDsj2nH1R2w69MWeMtpMv0APeBvTetAlrwOiiq81pH0CuZEKavaYdZ3dm4j3EWk0ON+B7PUYr54TmLHowUP49n0FqYHXak2ABPCHjpac9zIfMARvNu5GK0/qelE+w32J5qdbeO9176U9QTOhKeFPiTTKJlzlLi+EYWIy4Z58KA6TZrCUE+hUB+doig8Pb1WzNYCiPcmhlGGdLAWECoP1qql9sYOy7sCexAWoj7cztNTjLVkgz5CpYgv20q0bPJyZ/JU9rSOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779039665; c=relaxed/relaxed;
	bh=TIct3NHUYaBH36Fj/LbbJuo0SwZOr7xZ34JrF6Ab3dM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQFI6gxIPeB/ozx+UkVFV3Em0Yw3Ef5JCKSgJx7Q3Lq63C4hL8EJ2yPZKa/mTAJk5+qGTvS8EsJxFI/UQPVdyzpUnCJ+j1EbbNUlz70otU1dMa22MD0I7UYj8WoAqiQP3cz6E30N+52u36BkBk74pP3AhNhtUHdLCEaMqUe3q0TBaMIFBQrtBfPcaq1mzqYInKmWPNxJJ/dy8kMFEkcu+FwlwRq6fVbPwAOCOJtx580FlNijN6j/Rt0F5ZEJYw5IthbrJUfaakZ4oTcNI1uFcLfwfRDW1MmPf+8JO2NyuSSt7z62Ke8WganxXNj4hNNPSayU8uLoDn5uHQqXXQrFHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aRCdsCOO; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aRCdsCOO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJSsD5N0jz3bsR
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 03:41:04 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64H7j2hX4002074;
	Sun, 17 May 2026 17:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TIct3NHUYaBH36Fj/
	LbbJuo0SwZOr7xZ34JrF6Ab3dM=; b=aRCdsCOOilKsDPOBHZSUQo0insMk/apIZ
	j3vOQf/W9wuvxtrGzB04xfHBXY/qEEZSNrkEwl64MtYH2kSFBMLukoliJ7gib4Dx
	TpTw+27++EOWaDhDPyRwX2hHkjBDlWRNT7E7Mni8VY7EIalA+NHfeC0VqO0wCut+
	tmQnljHunRfjm/NXUcPKhAKKaa4aW6GCNkg0VZQgngj38r3M3/UdEu6pdvpX+ajC
	8Xu2Ubg4yTjnyOEmukWNEFVtHSESMfuaT6dyQYPMnUVjbfI52Z4woBq9dtAtgAeT
	7O1X3T3sIUCHs06O846riXvCr9Q+NVPTmlxce6jyvRURvV4iIr71Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9xmntc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 17 May 2026 17:40:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64HHdF4V025754;
	Sun, 17 May 2026 17:40:50 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dhacaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 17 May 2026 17:40:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64HHekKV56099284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 17 May 2026 17:40:46 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F2582004B;
	Sun, 17 May 2026 17:40:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25FB220040;
	Sun, 17 May 2026 17:40:44 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 17 May 2026 17:40:43 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH v4 4/5] selftest/bpf: Enable verifier selftest for powerpc64
Date: Sun, 17 May 2026 17:40:42 -0400
Message-ID: <20260517214043.12975-5-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260517214043.12975-1-adubey@linux.ibm.com>
References: <20260517214043.12975-1-adubey@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDE5MCBTYWx0ZWRfX5ot19A7v36ih
 x6FOCCAJC0OIQLh+2nGUhThdtUHoT/mmpSsmJfaB0T1FBWM/TfS4snG7Gxl1xQ+ceMXUUHgmEi4
 WDaocyiuA8GYZyCu3GuAQWGLjjZ9TI51A2sdi93AUtR3qRtGptlSDl3CChTLV2XrnSTRK62qou4
 z2XRS3aTB0k6vENiQm5DWEaeGA/atjd58J2OE/kaJSTLwZA8/Oq+iAqDoRpVeugQd5whaWpS2PS
 /UxYCvGH3Nu99o1i/CByzGlNNChTS8GiuahmXwepzJEyZMhgt/B9MqldFz2QVZc1VtoZFrwyJfs
 FZIGfBEAp+i5FZM0k+sv/O/VzwSrITHsVgQaW/pNFfVoHxwFCUq2uSvY9o1T8D0Imkb5x0CcJaS
 F50EF2z6YtaKj0QmYOB7P9ZOw4ZL/g8NCv6uvkJfrhiIGNpUpgpXQ+W2vpovhUV2yqP8uHoADgR
 FdNSE6nXh3qMVqmFpnA==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a09fda3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=DRl-xmwt84w-93Xc4WMA:9
X-Proofpoint-ORIG-GUID: 4YkzZs_EdZpxxxTJNQMtJKy-priEwhNx
X-Proofpoint-GUID: 4YkzZs_EdZpxxxTJNQMtJKy-priEwhNx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605170190

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


