Return-Path: <linuxppc-dev+bounces-19029-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D25C81061B1A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 19:21:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fl1Lq3zVKz2yhX;
	Tue, 31 Mar 2026 06:21:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774898467;
	cv=none; b=lMNSLTZCAEtoXGCIMhAb22qC4buKKqPk/WYHrxYdtSVkJ94b5dGx4P/UMcw2zweKAUFYvKJcL3SBn9SFBv+tSp60heXS8n7vSZhJWbXnyF4u9ib0eGp4+Ai8WwzpDPSfwF/SsSisDEQMCC4OKJX6TMBxOpBuQNokKVQZU58Iiq5VEaShFcB649nJ9b5KTt6L+INMWdXcUW+xileLbnlb97+F7OqJOHIwnThz+Vi7j/cjZnXumsPBYbmaKnU38WmNYTKBVdz+y/FsmPu/0qAA5+gaXFhEodcqMlTRtypF6CfgBuUykx5kYqMa5T04znzM8fyVdyAzmEVUVNYSMeAkHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774898467; c=relaxed/relaxed;
	bh=LaHGbyy3a+PyoQzYh9/3THjoLQiOMnnzugao2tSRl8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cjULeqb7gVey6DwzG7ZgVADvppzYucM4wYdyZm72yTwxJN1jrTklJlqMyAGhFv6UZufvp1RLAcsPhIx5/rcl48ezx2ckpBH3tW42ubAopirEdtPCrJKDsZTC3lEqIK+b024PZSf/EskQBnHmfqnFGZOeedmSKyO1BnEwmnkyXss4eZANeLqCxB0h5lgpvXTa+WYQD46OIxx/BkRPA74+lfYOGXTROzGT/xioa1jpLLTysDfkJdnRx5vx579bXKJcl8Q74LdBQAe5s/t36GFdIzsWXUIMJ2O6yc8b5F+udOpI/h972GaOdDKMcMvCSEAWxTes2GLV8cdsKF5MSUNj4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dWXEiPVt; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dWXEiPVt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fl1Lp4mWSz2yhY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 06:21:06 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UAUtG33068935;
	Mon, 30 Mar 2026 19:20:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=LaHGbyy3a+PyoQzYh
	9/3THjoLQiOMnnzugao2tSRl8E=; b=dWXEiPVtEM0wCU8F+2hu4bTQcEbUn+jCB
	p6w0VBrz/xTKtcJjBQnZThscbtsOnE2nQIAivFoeZbTW3NJuI99PYOyomcc2fyfT
	efqpdvjwewOn4512E/KTj7yzcELcW/GGGl+IeStFV8dzwJZkpaI3NvqEU4yAVagG
	7K9ZMOwKBldWxYISznGJqFRtBSWQ2Fr9WosYCOcCzagHexb7k6QKYfN3E32yw3ys
	4fCRyIoyd3t2iYNP1mZAflqQWyrZQbBYr080T7JDOBT3+Du1cBkG8PRE8Bz+ZKSC
	uFZ05d/cRARJfxxbo49Y57PvGMKngRWr6vJ3QYT4sb1P29ygICRSA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dc80uk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 19:20:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62UJ56sl005980;
	Mon, 30 Mar 2026 19:20:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spxx8ky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 19:20:50 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62UJKkBR52953574
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 19:20:46 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A72F62004D;
	Mon, 30 Mar 2026 19:20:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24E8920043;
	Mon, 30 Mar 2026 19:20:45 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Mar 2026 19:20:44 +0000 (GMT)
From: adubey@linux.ibm.com
To: linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, bpf@vger.kernel.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH v5 2/2] selftests/bpf: Enable private stack tests for powerpc64
Date: Mon, 30 Mar 2026 19:20:34 -0400
Message-ID: <20260330232034.44776-2-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260330232034.44776-1-adubey@linux.ibm.com>
References: <20260330232034.44776-1-adubey@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69cacd13 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=WRW5XrRV495NP23rXD4A:9
X-Proofpoint-GUID: 4nFR3oUsB9ZqUDrwQQ2vqpwj1_ku6JFI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE2MSBTYWx0ZWRfX0XMmEGyK6CXu
 +PJViSH3DlvfdDTa7lXLYT6El2juIBKcrrlz0B8gex8e3VDfDorpf0DLT80qUBf/XsYX2T9KN60
 4gLMv2OxVDgOHhxyg4bMcRI9vI4p49rqiLHdi8zmIdGBQfFnhU1N6QYW4GoLc4CJLkVSGtFk/os
 wWmLib/QgeVlyP5c8ds3Lp+P7PjeNf/igsLV0/tfNo4WgQeI0jyi51ZhYLOAsYaM8dRpLwtqIiY
 TtSraozKxF48l/ojSvCCzWb7ztDzOMLVsK8sB1svQYCp1mnLA9fT4IP68UVT1E1dc1+VQJtGzLm
 UNC/FXRDV02geLhKVZZjWQ5B2OOQdXuCM9Wmn4iFXfDt0Qm6gqh/Ia35Mwg97651dRaLoeh+/99
 pu6TtwUaDFKChC288gkMkOcWiBpHtX5SVGifgtMbzx8MVRtACSeszIecpnu6W5W7mL+5eV5VGrE
 XUeBpsVrIpbqNVf6S+A==
X-Proofpoint-ORIG-GUID: 4nFR3oUsB9ZqUDrwQQ2vqpwj1_ku6JFI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603300161

From: Abhishek Dubey <adubey@linux.ibm.com>

With support of private stack, relevant tests must pass
on powerpc64.

#./test_progs -t struct_ops_private_stack
#434/1   struct_ops_private_stack/private_stack:OK
#434/2   struct_ops_private_stack/private_stack_fail:OK
#434/3   struct_ops_private_stack/private_stack_recur:OK
#434     struct_ops_private_stack:OK
Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED

v4->v5:
  Rebase over latest branch
v3->v4:
  No change
v2->v3:
  Enable testcase using __powerpc64__ instead of __TARGET_ARCH_powerpc,
  to prevent it getting invoked on powerpc32
v1->v2:
  No change

[v4]: https://lore.kernel.org/bpf/20260226031324.17352-1-adubey@linux.ibm.com
[v3]: https://lore.kernel.org/bpf/20260226005440.9570-1-adubey@linux.ibm.com
[v2]: https://lore.kernel.org/bpf/20260225153950.15331-1-adubey@linux.ibm.com
[v1]: https://lore.kernel.org/bpf/20260216152234.36632-1-adubey@linux.ibm.com

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 .../bpf/prog_tests/struct_ops_private_stack.c | 29 +++++++++----------
 .../bpf/progs/struct_ops_private_stack.c      |  6 ----
 .../bpf/progs/struct_ops_private_stack_fail.c |  6 ----
 .../progs/struct_ops_private_stack_recur.c    |  6 ----
 4 files changed, 13 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c b/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
index d42123a0fb16..4c4421045dd0 100644
--- a/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
+++ b/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
@@ -5,6 +5,7 @@
 #include "struct_ops_private_stack_fail.skel.h"
 #include "struct_ops_private_stack_recur.skel.h"
 
+#if defined(__x86_64__) || defined(__aarch64__) || defined(__powerpc64__)
 static void test_private_stack(void)
 {
 	struct struct_ops_private_stack *skel;
@@ -15,11 +16,6 @@ static void test_private_stack(void)
 	if (!ASSERT_OK_PTR(skel, "struct_ops_private_stack__open"))
 		return;
 
-	if (skel->data->skip) {
-		test__skip();
-		goto cleanup;
-	}
-
 	err = struct_ops_private_stack__load(skel);
 	if (!ASSERT_OK(err, "struct_ops_private_stack__load"))
 		goto cleanup;
@@ -48,11 +44,6 @@ static void test_private_stack_fail(void)
 	if (!ASSERT_OK_PTR(skel, "struct_ops_private_stack_fail__open"))
 		return;
 
-	if (skel->data->skip) {
-		test__skip();
-		goto cleanup;
-	}
-
 	err = struct_ops_private_stack_fail__load(skel);
 	ASSERT_ERR(err, "struct_ops_private_stack_fail__load");
 
@@ -70,11 +61,6 @@ static void test_private_stack_recur(void)
 	if (!ASSERT_OK_PTR(skel, "struct_ops_private_stack_recur__open"))
 		return;
 
-	if (skel->data->skip) {
-		test__skip();
-		goto cleanup;
-	}
-
 	err = struct_ops_private_stack_recur__load(skel);
 	if (!ASSERT_OK(err, "struct_ops_private_stack_recur__load"))
 		goto cleanup;
@@ -93,7 +79,7 @@ static void test_private_stack_recur(void)
 	struct_ops_private_stack_recur__destroy(skel);
 }
 
-void test_struct_ops_private_stack(void)
+static void __test_struct_ops_private_stack(void)
 {
 	if (test__start_subtest("private_stack"))
 		test_private_stack();
@@ -102,3 +88,14 @@ void test_struct_ops_private_stack(void)
 	if (test__start_subtest("private_stack_recur"))
 		test_private_stack_recur();
 }
+#else
+static void __test_struct_ops_private_stack(void)
+{
+	test__skip();
+}
+#endif
+
+void test_struct_ops_private_stack(void)
+{
+	__test_struct_ops_private_stack();
+}
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c b/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
index dbe646013811..3cd0c1a55cbd 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
@@ -7,12 +7,6 @@
 
 char _license[] SEC("license") = "GPL";
 
-#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
-bool skip __attribute((__section__(".data"))) = false;
-#else
-bool skip = true;
-#endif
-
 void bpf_testmod_ops3_call_test_2(void) __ksym;
 
 int val_i, val_j;
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c
index 3d89ad7cbe2a..1442728f5604 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c
@@ -7,12 +7,6 @@
 
 char _license[] SEC("license") = "GPL";
 
-#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
-bool skip __attribute((__section__(".data"))) = false;
-#else
-bool skip = true;
-#endif
-
 void bpf_testmod_ops3_call_test_2(void) __ksym;
 
 int val_i, val_j;
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c
index b1f6d7e5a8e5..faaa0f8d65a4 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c
@@ -7,12 +7,6 @@
 
 char _license[] SEC("license") = "GPL";
 
-#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
-bool skip __attribute((__section__(".data"))) = false;
-#else
-bool skip = true;
-#endif
-
 void bpf_testmod_ops3_call_test_1(void) __ksym;
 
 int val_i, val_j;
-- 
2.52.0


