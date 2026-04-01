Return-Path: <linuxppc-dev+bounces-19144-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C83D35162
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 11:21:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fm2cm56DCz2ypk;
	Wed, 01 Apr 2026 22:21:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775042504;
	cv=none; b=D9rXTTOJqZpAbZ4gG5BQEKwEpGR8iZQbOBvWZcIMxXN1bBeQOib20reeNhvn9bft5CRMmIpmVvlR+1C+Kh3ekBWwM2hEfTJX7/sK7ZNBy0iOGZ2SSdojMjfY+PvjpmoyHt6V5VFiNNLB1WkaPTNkWc90xmP6WAmMwTFHK9S7d9zf1pAEdcEBzTWr3OxOiMwdBAeQKBnwsZe/Ct3ktBK+T4tJEkUVwiWMimCNEEQt1pGQJzUbo1Sp71XhuDXy4KqF+Tm3ciVdI1FDf2VbOBhyfytS+Wnt61AGbvb0zJ7ZGd3dpq9hxM8OIBn9Vm9qDZdOgid0bkmGjCQH/C3gGeXCOg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775042504; c=relaxed/relaxed;
	bh=B8sLrD5INAbLnxutZcOEx6h9KhE/KtCmj7IYXlwDiZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5N3S7AsXzN5OdcGuqe9YH1eUDMEXnRG7kx15XJQCZC6PGdXUALtB0w+zSVvj5CwuYfaKJ+6lgOJkISmFbLB4vUMAg5W0X1bYiNqbcKAecTkrB0Hs8XT32BI9sVtu2CrBDspB0zAIiWYY88mCql1xpKBo3CQTELboWQJT5WryUlj3UMheF8NyxY5oP5cgqODRJmhhL1KiFu1nQu503+r+Lsg5ooz/EP/GTi84ZOC+fILVMoWTWCgXcUt+VYUBBsJ4TK2Xoe9lxE5necrjWutKdJrOx0v8nu0Sk0lJF/XGbTk6pUGNEPHEReLZH8mPWODaH15iCkcBkHRJncH2dUwwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=s7RW4b1N; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=s7RW4b1N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fm2cl6K7zz2ygf
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 22:21:43 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631AC5Fd119453;
	Wed, 1 Apr 2026 11:21:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=B8sLrD5INAbLnxutZ
	cOEx6h9KhE/KtCmj7IYXlwDiZQ=; b=s7RW4b1Ney98AKb4GPDbitkbUCQL4SI1f
	QKCYrTqcQRyRI9G5uNSHPAu5R10vf/M9y8wMagUW5n5stCPs5fBrE0P9SqLofbR9
	rlFGLdPwWpEJsFjWqnNmCPnTIMc8JEVPiMspXrL06mQkIwAMM3fiOT3jBBFppsrh
	o2V8idC/j5+97rDukMG0OkkAKMQ/SIMiEHT2i06TjMIH/8GOQbI8flC/7g/GQymH
	MQ3r4/xv+Sbi5Vst8G7q35nw8cexz4qTA1jF9N42AeQe5zxD+At4sSC1aex0swKB
	bmnQ34gRfIfiKYbEO8FMZ0tYAcwRZeECwy1drbIQ4ROsiZqD1LHrw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66ms7213-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 11:21:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631AVJYA021722;
	Wed, 1 Apr 2026 11:21:28 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6sasnf5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 11:21:28 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631BLPdC15204646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 11:21:25 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 060E720043;
	Wed,  1 Apr 2026 11:21:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00E3120040;
	Wed,  1 Apr 2026 11:21:23 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 11:21:22 +0000 (GMT)
From: adubey@linux.ibm.com
To: linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, bpf@vger.kernel.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        Abhishek Dubey <adubey@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH v3 2/4] selftest/bpf: Enable instruction array test for powerpc
Date: Wed,  1 Apr 2026 11:21:31 -0400
Message-ID: <20260401152133.42544-3-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260401152133.42544-1-adubey@linux.ibm.com>
References: <20260401152133.42544-1-adubey@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69ccffb9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=qzfPCzmIJ3PduWSRb40A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDEwMyBTYWx0ZWRfXyPfEgqGD7SOi
 VfrU9UPtMXvWvKhJMbwSVfiZoR75x3q6zAul72c414GXPl5Brd6TrrnVu6ixEPFEEAC58ROb6JR
 JpVZARgY2C+usN5XzMCS6FDzHc7Ou82mve2a+2BGRLVgFvc7mFLsPtlhJEZXxT1uGJBhzOcGyr5
 mUrhnkEeu7jkFNwYmzpJcSkDqfoYHGYSrRvAjrwiKN1giok9AAyIm2LpL3sAqCZk7Uo+Q947DB0
 21XARdBFrjYJ+HfQsD6OhpNHwmKUpUN3RXv/XO29uatZ4iZm3Wv3i9bbNBh/X0Gq/U/8d4OpxbT
 RU16ixEldCEmrdoL7wRdGOr94xaIJTwohhNbI6i8PqI39h6IIo231WW4wtfycy+3Bm7L73dG/cj
 A7PuRm6ZneF2YI97vy/K3fz+2uMUJyNsGV1qrRcDndB6c2G/auJqOglS5S78u8bIHiIMZEpvOTF
 R95ydDedwSzsNI93jpg==
X-Proofpoint-GUID: b4MXLmGxMsq1C9CEfufWWM9xtnL8C542
X-Proofpoint-ORIG-GUID: b4MXLmGxMsq1C9CEfufWWM9xtnL8C542
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010103

From: Abhishek Dubey <adubey@linux.ibm.com>

With instruction array now supported, enable corresponding bpf
selftest for powerpc.

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
---
 tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
index 269870bec941..482d38b9c29e 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
@@ -3,7 +3,7 @@
 #include <bpf/bpf.h>
 #include <test_progs.h>
 
-#ifdef __x86_64__
+#if defined(__x86_64__) || defined(__powerpc__)
 static int map_create(__u32 map_type, __u32 max_entries)
 {
 	const char *map_name = "insn_array";
-- 
2.52.0


