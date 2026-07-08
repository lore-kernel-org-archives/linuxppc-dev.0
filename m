Return-Path: <linuxppc-dev+bounces-23813-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 378C7C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 10:52:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwFKX3m88z3c05;
	Wed, 08 Jul 2026 20:52:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783507936;
	cv=none; b=X+kReK+gv/3Yz6Z5Df0AFUKmzbotbpriYuLTXvyjkIlxr1Uy5YY5cKIY3Hop+jlJ92LC5+3+lrm8715Yy+iRn45oGpqA2L3/Eik5LVc9bJRNsf7CAf9Y1Si1c5a3UEWFWLDKGYlmn290RfxWpzLdQcpcPzDKfHLaTrO2rNTGRC6GotkbBqpUOPAUikOWao3+tL7vYAELfkmSlWVb3daCzJIy1VyTKwLI5RYQeNJOtTeCQG5zQ4CHbqrDNh0MkHpkf5S2wLxYcnPBnMl28NMxcrQItSoEuOwMqDIwWduWfz+zGb+kbMdGwSrHm2vDTHIC5ZYoPP48Xy3UXia+7v+QHA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783507936; c=relaxed/relaxed;
	bh=BEl3FDk4W6OE85fGKiliuMQSrlersvU+xXv9zJ8pq1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oETZxbaCshPOHpCW9Z8UlWhHwqCfT00cm7WlnKzvQVCa3Ej01tBMSofFG8oQKHwutaBmt4Z86J7Ry7xFzLuZ0umh+tkZ/kfwndf8HhyntBoohVqyBo+xe2T6U8hmgXYQNQrw8LaitrtrVScwc5v7pi/DhDK1Wj4UKEZRYYFfOgu0q62f/n+N/hmy/qqHXVaDkKMsqrwCo7KeMNnHolS3y/QGFTNSNpyNeqaMrh1YrcT5vCfWsObzwOkPAJZKrvzESF0zITj9B/CbLaOBhcY1aKPvbdThkSERQ1BvNZBgSw0Sp/+e9tSL0VracxuBt5MaUnxpzV/0XzlAjpZYsY/q5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=G/qdIN7e; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rathc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=G/qdIN7e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rathc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwFKW68dnz3c01
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 20:52:15 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6688IEMV2501492;
	Wed, 8 Jul 2026 10:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BEl3FDk4W6OE85fGK
	iliuMQSrlersvU+xXv9zJ8pq1k=; b=G/qdIN7elr2XmYEehWk5T8lw5pO6Rd0jx
	MdoOMocoUOCEgYJbcB/PqmMNSkCm8b5PrP6BtFrLjuGXGL5i+381/1QgiN7JSmt7
	wF7g4PYWdPEzXgqnx1LRmnoMUZ7Z58G3H05AoNAHqHZ2wvENlZXomSk7t2U1Erhw
	W8Zw9Q3pr2mj3W2yE1mV5b5sTX3MirOIwTdi9LsQOkWMQSgyRj4L3L2Vp0f1FVmQ
	y33Si9rUB7vqinXelKu033y5GGL5yNbkR9mYWF0Rk0AG74mOR0eqGOxVR+wAk/G5
	p8qCfk6OBOIeBjpSvp0etM1GJGoemwAhtoSSP30/uViyIJOkZCLxA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4v06r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 10:52:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 668AncDI023487;
	Wed, 8 Jul 2026 10:52:10 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqg7e17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 10:52:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 668Aq6qo53543278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jul 2026 10:52:07 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE8A42004D;
	Wed,  8 Jul 2026 10:52:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D403B20040;
	Wed,  8 Jul 2026 10:52:03 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown [9.39.26.49])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jul 2026 10:52:03 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: thuth@redhat.com
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, lvivier@redhat.com,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        andrew.jones@linux.dev, sbhat@linux.ibm.com,
        Chinmay Rath <rathc@linux.ibm.com>
Subject: [kvm-unit-tests PATCH 6/6] powerpc: Add a panic test
Date: Wed,  8 Jul 2026 16:21:22 +0530
Message-ID: <20260708105122.1177210-7-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708105122.1177210-1-rathc@linux.ibm.com>
References: <20260708105122.1177210-1-rathc@linux.ibm.com>
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
X-Proofpoint-GUID: v-DDk_osieqSnLCExvUN8ugctUkFHcaY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDEwNSBTYWx0ZWRfX0YZ8TpDVJpei
 KQu5lFk7DofRufMPWIN/n5H8hL6iWOxW533cUHWZytiUbDxUNAzmvyt07ueSf4qpRYuGk5uQpkH
 UKwgh2KwAHKCN3W5Lm8Bl/PiE1tOg01V7qVKzQnElR+z080DE0iLPCK6/QvfUBII97neJ2Q5n+1
 TXGX6GnR7hD5MU8ujNxt+yhhxIuuwHhqffC8QqAVlf/GQtU46XpB2MUkoX5E2GcXbiXT2NqeImK
 EUjJBuqd/7vZMhRDPzFFWRdsDsuXK7zieyZtrLGdhWQVLyH3BF7WZcxDb18ZO/wbXkjvhqtxyy8
 2ZJ5TZAQWcsfQrVT0yNNq1DtOOeqPvCGr6lZ9MxPZoi2ytclR9VjSo3EFnnzGvzETr1GQnlYJF8
 8QPwAke4orbtzWy2CWltKVjejoSe11Mcd/2stsQ4DXKjQcqIq09xbqgkqBBbbvU3rFX+HOuDmHN
 vSPlEbTvQ7JA0+Bvajg==
X-Proofpoint-ORIG-GUID: lCaK8spx5VMHCxhiDy81Lmoi6aoGLHIQ
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4e2bdc cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=dqXfYlxAYPwuIwgSaMQA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDEwNSBTYWx0ZWRfX/d35rhMGcvgv
 lMGSTDqshEHIaIRUogyUz3hgeWPeWNc3gYYGlvei3AbgNHvFjZ0nX/hG+BMkPeB/GMx+E4uzPi8
 94+yiWWwRWb0T7/IbdP4e3uoOWTeags=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080105

From: Nicholas Piggin <npiggin@gmail.com>

This adds a simple panic test for pseries that works with
TCG (unlike the s390x panic tests), making it easier to test
this part of the harness code.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 .gitlab-ci.yml         |  2 ++
 lib/powerpc/asm/rtas.h |  1 +
 lib/powerpc/rtas.c     | 16 ++++++++++++++++
 powerpc/run            |  2 +-
 powerpc/selftest.c     | 17 ++++++++++++++++-
 powerpc/unittests.cfg  |  5 +++++
 6 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index b28d1eb5..5b5d6036 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -205,6 +205,7 @@ build-ppc64be:
       selftest-migration
       selftest-migration-skip
       selftest-migration-ci
+      selftest-panic
       selftest-setup
       sieve
       smp
@@ -238,6 +239,7 @@ build-ppc64le:
       selftest-migration
       selftest-migration-skip
       selftest-migration-ci
+      selftest-panic
       selftest-setup
       sieve
       smp
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
index 62630ead..afabb46c 100644
--- a/powerpc/unittests.cfg
+++ b/powerpc/unittests.cfg
@@ -19,6 +19,11 @@ test_args = 'setup smp=2 mem=1024'
 qemu_params = -m 1g
 groups = selftest
 
+[selftest-panic]
+file = selftest.elf
+extra_params = -append 'panic'
+groups = selftest panic
+
 [selftest-migration]
 file = selftest-migration.elf
 machine = pseries
-- 
2.53.0


