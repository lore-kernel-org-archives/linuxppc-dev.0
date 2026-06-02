Return-Path: <linuxppc-dev+bounces-21874-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9360DCD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 10:06:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV61c5jQMz3bpm;
	Tue, 02 Jun 2026 20:06:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780382961;
	cv=none; b=ofGGQx0O5nwfgkKXP+wqtC0ik4kLnpfncahUbrQQ4oJmQNhit/ZM/fZ/RtabCxuPzFfqE7WNGQQpHpRQ1m5tZwhwHnTZEh9DIQIuO88Oo7/L+kidQMDNUNLUEhaSZMH6qyf6B96U54yrY2JygrIbDF+if/NiG4uRbS858fIfTdDsR7wpWcCZOYx1CnJJfmrv/mdXstJFsMX31fse73IHrTyPsRmquMJDw9RY21PNLbPrvN9AC33xBUFx226qvcYBlRJ0Stmsy9U48bG6ncwAYjj/8VZELpihEB6PjIzORBaaiBzAN1JvEKDOGKYknLkfqhM+RdD6lIXTc9JvH/S2CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780382961; c=relaxed/relaxed;
	bh=dm2g3erC5LRLaOjDzxw99Gc2WDh2rkAjBrkirLhX0jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VrPi7RiuGGy/vQUFdE9O/dQnMiYJp6GsCajAoKOoyF+2f8WaXU2+Xf0mYHShW+PoK2VbU8DRk9ukroPBkSQw+/wAqC0gvjlhnvQ3OIElxTDgq3HDcdv3sIgt9yfup24E7DjEINOsAMgTFsewtxka/C6F81QCDlmNs2AOhG4/IX5eVS6bErG0hjNvFJMZbfVh2DXNLNSEQlfWNN25MF3JezqM9nJjiumy5kPRBp27XVQmoaXqNDvBbQ3XK3YGlt+d+usagTFtW7GiB71R69oYKPmNmO0dYX5wek6Q2Z/zUv5yYLHnwoVjATM7KnldLPkwV5a1XPdv160Y7aUh62Vjdw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QOMckw/y; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=rathc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QOMckw/y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=rathc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV1dr4HCtz2xmX
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 16:49:20 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651LGMNs3717409;
	Tue, 2 Jun 2026 06:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dm2g3erC5LRLaOjDz
	xw99Gc2WDh2rkAjBrkirLhX0jg=; b=QOMckw/y/4nTRvqbsqgVVFQ/M6CGIo+cz
	+usyDB7oLFW5+vUWIFOoGILGWlja/agFzdyRBWSiPPk5h5lz9AObCrY5X5NWAAEJ
	xU3R9HY1di9ulzwnbU7jcFKV1AamH6FDeMyki8ls9ltSAAXGr+UtW5IDPAP5dsyQ
	zK0IgcE9xDip3V8XnDGbC4RA5IDr9jh4o5UltO5zIGtNg80glVucPvOCUSDdJGxF
	cywlTk4TBWOZCPvHrOcajVoMvW0z52DWRnqIP23CZNJZmVRL47JRRykKjp9qPTbw
	Y8tvceaTwz8MvImBe6ZxIz7UfDr7T6oC9chhYdm6WggaM9rSod9lA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnahmdmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 06:49:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6526dA5o028808;
	Tue, 2 Jun 2026 06:49:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ega7qa5ty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 06:49:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6526n6vY50331912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 06:49:06 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8311820043;
	Tue,  2 Jun 2026 06:49:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4D9520040;
	Tue,  2 Jun 2026 06:49:03 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.bl1-in.ibm.com (unknown [9.123.8.229])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2026 06:49:03 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: thuth@redhat.com
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, lvivier@redhat.com,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        andrew.jones@linux.dev, sbhat@linux.ibm.com,
        Chinmay Rath <rathc@linux.ibm.com>
Subject: [kvm-unit-tests RFC PATCH 6/6] powerpc: Add a panic test
Date: Tue,  2 Jun 2026 12:18:06 +0530
Message-ID: <20260602064806.3101025-7-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602064806.3101025-1-rathc@linux.ibm.com>
References: <20260602064806.3101025-1-rathc@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA1OSBTYWx0ZWRfXxcVHmJT7C1Cy
 ZjNR8hRtuWl7MfFo5R+9n3ov14AOjLOv7M3zNt7DnYpnfq/JOnSFI6wukbaa4g6oYRZ/lMAIhEn
 VFmdb1wcwWnmDqBgomu8L+DGLKKx4Rqti1Bb6tKTyOZSRVg+3MSQpkJqGEkqoJC94aX4mTqXmb1
 c+u0vXPpaNSNZ1Ni5GGGewzejs3VkCc8v7tqNfyZie4PwRO5/vDomEV95b4e+ZmY08fOGpFPtO5
 sQEWIz2gonrqk3HaqPKlhn/A+Mlw1Uwi/hRBSLz0cm/DQ935AGPBXktM/xREzsa+Vgu3Ck7Zfuf
 o67vFLkSY2YEEXQa+okglCgncgHY6ILg8I61tUF/9Rz1pMgjPrqxzJqEV47Wbs8rzaO9U6OZ66U
 8ykSlNngJAhCQeuz2DRgxMzy9cs+6zV79DdKr80Wb1umPbMp8kownknafdlkrzWrReeQPTJn+Cx
 pCBaFoUjlRbQO10GGaA==
X-Proofpoint-ORIG-GUID: qjLoDP_gsXm6Alr-SGRxPn_65a74ShpF
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a1e7ce7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=8EgYE67y1SrcKmc73U4A:9
X-Proofpoint-GUID: cbsenqb9khnex6cEo2_jhblo8datPq5U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020059

From: Nicholas Piggin <npiggin@gmail.com>

This adds a simple panic test for pseries that works with
TCG (unlike the s390x panic tests), making it easier to test
this part of the harness code.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 lib/powerpc/asm/rtas.h |  1 +
 lib/powerpc/rtas.c     | 16 ++++++++++++++++
 powerpc/run            |  2 +-
 powerpc/selftest.c     | 17 ++++++++++++++++-
 powerpc/unittests.cfg  |  5 +++++
 5 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/lib/powerpc/asm/rtas.h b/lib/powerpc/asm/rtas.h
index 989b21bd..fdb3c544 100644
--- a/lib/powerpc/asm/rtas.h
+++ b/lib/powerpc/asm/rtas.h
@@ -26,6 +26,7 @@ extern int rtas_call(int token, int nargs, int nret, int *outputs, ...);
 extern int rtas_call_unlocked(struct rtas_args *args, int token, int nargs, int nret, int *outputs, ...);
 
 extern void rtas_power_off(void);
+extern void rtas_os_panic(void);
 extern void rtas_stop_self(void);
 #endif /* __ASSEMBLER__ */
 
diff --git a/lib/powerpc/rtas.c b/lib/powerpc/rtas.c
index 9c1e0aff..98eee24f 100644
--- a/lib/powerpc/rtas.c
+++ b/lib/powerpc/rtas.c
@@ -182,3 +182,19 @@ void rtas_power_off(void)
 	ret = rtas_call_unlocked(&args, token, 2, 1, NULL, -1, -1);
 	printf("RTAS power-off returned %d\n", ret);
 }
+
+void rtas_os_panic(void)
+{
+	struct rtas_args args;
+	uint32_t token;
+	int ret;
+
+	ret = rtas_token("ibm,os-term", &token);
+	if (ret) {
+		puts("RTAS ibm,os-term not available\n");
+		return;
+	}
+
+	ret = rtas_call_unlocked(&args, token, 1, 1, NULL, "rtas_os_panic");
+	printf("RTAS ibm,os-term returned %d\n", ret);
+}
diff --git a/powerpc/run b/powerpc/run
index 06657764..718f08cb 100755
--- a/powerpc/run
+++ b/powerpc/run
@@ -57,7 +57,7 @@ fi
 
 command="$qemu -nodefaults $A $M $B $D"
 command+=" -display none -serial stdio -kernel"
-command="$(migration_cmd) $(timeout_cmd) $command"
+command="$(panic_cmd) $(migration_cmd) $(timeout_cmd) $command"
 
 # powerpc tests currently exit with rtas-poweroff, which exits with 0.
 # run_test treats that as a failure exit and returns 1, so we need
diff --git a/powerpc/selftest.c b/powerpc/selftest.c
index 8d1a2c76..f6f24d6a 100644
--- a/powerpc/selftest.c
+++ b/powerpc/selftest.c
@@ -7,6 +7,7 @@
  */
 #include <libcflat.h>
 #include <util.h>
+#include <asm/rtas.h>
 #include <asm/setup.h>
 #include <asm/smp.h>
 
@@ -47,6 +48,17 @@ static void check_setup(int argc, char **argv)
 		report_abort("missing input");
 }
 
+static void do_panic(void)
+{
+	if (machine_is_pseries()) {
+		rtas_os_panic();
+	} else {
+		/* Cause a checkstop with MSR[ME] disabled */
+		*((char *)0x10000000000) = 0;
+	}
+	report_fail("survived panic");
+}
+
 int main(int argc, char **argv)
 {
 	report_prefix_push("selftest");
@@ -60,7 +72,10 @@ int main(int argc, char **argv)
 
 		check_setup(argc-2, &argv[2]);
 
+	} else if (strcmp(argv[1], "panic") == 0) {
+		do_panic();
+	} else {
+		report_abort("unknown test %s", argv[1]);
 	}
-
 	return report_summary();
 }
diff --git a/powerpc/unittests.cfg b/powerpc/unittests.cfg
index 168af206..d1395464 100644
--- a/powerpc/unittests.cfg
+++ b/powerpc/unittests.cfg
@@ -19,6 +19,11 @@ test_args = 'setup smp=2 mem=1024'
 qemu_params = -m 1g
 groups = selftest gitlab-ci
 
+[selftest-panic]
+file = selftest.elf
+extra_params = -append 'panic'
+groups = selftest panic gitlab-ci
+
 [selftest-migration]
 file = selftest-migration.elf
 machine = pseries
-- 
2.53.0


