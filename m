Return-Path: <linuxppc-dev+bounces-24423-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF6FC44521
	for <linuxppc-dev@archiver.kernel.org>; Sun, 19 Jul 2026 13:03:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h33jX1B5yz3046;
	Sun, 19 Jul 2026 23:03:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784466192;
	cv=none; b=QP+4yirNfo5nYIODzE9R1B1i2M+sPGFG7U5BS3IQcF1aOsGj/sL8THlWeReQmycoyvBliZlF69/c32HYyzekNmhNse4FxDn5d3DbmQ6AOoQk6SCmrV2Ru8FeYSENLovNhvWpVjpL04LTxkKy6lm22M7lgf1gnK70K0cLlxY6Y38MJbW/RYUJcnrsX/+3R0R7aZDcZ7ZQENPTJd0mKhJEBucytgIl4CeFPiMvZ6dAiQYowAOULXX0kZ5VDLERwBu4Mq9rPg+NV5QFQ8zgxVryTKi9KLo9UBcazgV7njouIk78f88H8iFnV52m28S1e/YjP/m9u5en3XdZRA/eC2PLHA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784466192; c=relaxed/relaxed;
	bh=PS7PtJoq8vwgXI2SyXKRjmL6kBfqe48fRU/jmUUJzdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ha/tw1kl4B4DJ8yUpjx6gjHLtKYOUjOBJV8DjtRopFKhDG27kaXgmW7rwGg5iBObM5Jl3CTvWDBywoiFbCs/CA86TqYG9q8Pcs60G9us9wO6zXyC29GPm6ZVJCfh32MZoeZk/VJ94+tQH8NMA9DjdzXeWmDwk0rqFLZ/yKGsictTW6ycQurXn/abUXDdCm7Yj0JgrodIb3uMF2VcBtLE0mrudBjr1Gdoq5vc3AmM3cgCU0DGXdWvB9V10h+aVoofazVJSFJ/WFjqQH+701kKmyYMrYuVYad/qDzbW8K7FlfxNkudbLtnAeKCLxWlzNVefwzJD3eGD6pDnXJtWtRrtA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Dv8KL+H5; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=rathc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Dv8KL+H5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=rathc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h33jW2XLYz3bww
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jul 2026 23:03:11 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JBC86j3272841;
	Sun, 19 Jul 2026 13:03:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PS7PtJoq8vwgXI2Sy
	XKRjmL6kBfqe48fRU/jmUUJzdQ=; b=Dv8KL+H5HPesi8b1o2VANa0vp/cZ+86Wq
	Q62L7TvmJfZcQHT6yACnnc9kQ6iocajiDmWBO/FK2oXIXJWR5aj84B2gM3JHXuVx
	sYj3O0TC/GZaIBvburpSAny6ZBZLBHbbjzlMmUjEzNHW5zRqLPdFD5K/WnaKj6C0
	goIQCnIsbox3sFjqyaHGCU/JG/bHnczwxH+YEsXPMpRaTPFIOCYwc1bh//mvmkWk
	F5Bfacfih7iAbSDoSmQ/GTM9vQNklj8lbiDUEDJnFLfdvFY6pF3YFmcFoPM5JF7E
	6zMGzhTVqAixTnr/cz6CdIvSQc7ekNlozwhgD0UFDAZaJvx6yXiCQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77jud0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Jul 2026 13:03:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66JCoEpI014088;
	Sun, 19 Jul 2026 13:03:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnagskhm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Jul 2026 13:03:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66JD32RM33685830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Jul 2026 13:03:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99AD520043;
	Sun, 19 Jul 2026 13:03:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B3A420040;
	Sun, 19 Jul 2026 13:02:58 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown [9.124.218.35])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 19 Jul 2026 13:02:58 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: thuth@redhat.com
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, lvivier@redhat.com,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        andrew.jones@linux.dev, sbhat@linux.ibm.com,
        Chinmay Rath <rathc@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v2 6/6] powerpc: Add a panic test
Date: Sun, 19 Jul 2026 18:30:27 +0530
Message-ID: <20260719130027.2347519-7-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260719130027.2347519-1-rathc@linux.ibm.com>
References: <20260719130027.2347519-1-rathc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a5ccb0b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=dqXfYlxAYPwuIwgSaMQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDEzOSBTYWx0ZWRfX0fsQN3/LVOpq
 pvSMpOTfvmTxVeWSgKs/t7zu9bpXmNVxYl3mytV3FU/cpFDpgTHX8TRN7act9jcy+xVzstcxshI
 HwSIvDsKypp2hYQ8jeua2GsYQ7wR7FBZWJ6fsXH0+fYFEyGIjCnq484OIsmEOGG241eCZM+ZeDz
 uz6fccZ1E8JnNWHnB03JEjaMaeoFhWbwtimLoS4AVCJVYLiW4OHj+uq5ztngKlTE4c8Ad66YdO7
 EPI4uhYdDnn2BJk8vEZEFVGm9n/dLfGZoX8BqGavl2TtCTyqYvTA6ju23eErBVtRutM+orTzIM+
 /KukNtWF8IbkB2jqU7dgQOReJeIUMU0Uhr8YrHbgZaIWhnlpfGZQLfEwDUgwlnCNOmKkjlRXiyu
 MhkTC/oV5xBx9lizdMroCctg43zD7BqzhYMhh51NdT6VQU6fKu1hHauNxqcTTOFHFkYkP+ut1Ml
 kr0g7EallxAZs4SLnSw==
X-Proofpoint-ORIG-GUID: 41SXwHNkjh6DJ4917grMxDrsxWGcU4Ck
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDEzOSBTYWx0ZWRfX53t2CAbN1FZz
 KPa5zllqql+ps/adHcOOOHeeSXr5j6kb7ghrD8VVEgF78+2wJryt9hm/YXC8gGjtVEx/ZciTgDD
 OqDlNtCKllbjBRIIBbX5ocHhQLdIY/Q=
X-Proofpoint-GUID: -DKkfGVFu4yTCoeG-0bmsDilufLcsW2l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607190139

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
index 89329cd3..9d809b13 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -204,6 +204,7 @@ build-ppc64be:
       rtas-set-time-of-day
       selftest-migration
       selftest-migration-skip
+      selftest-panic
       selftest-setup
       sieve
       smp
@@ -235,6 +236,7 @@ build-ppc64le:
       rtas-set-time-of-day
       selftest-migration
       selftest-migration-skip
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
index 60c73086..edd5b3e1 100644
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


