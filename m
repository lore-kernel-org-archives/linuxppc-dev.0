Return-Path: <linuxppc-dev+bounces-19123-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D269D1076377
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 06:32:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flwCV1r90z2yjx;
	Wed, 01 Apr 2026 17:32:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775025174;
	cv=none; b=EzvgqcPob7v5ffsbDdM5N6naOiP21Nc0/tkSFtWXDwWOEuDavaeA4BB/yslCwHF7JkJ3wISBuOUZ4gv4pdXDRvJjIQbOkuaI+eNu0OFEHP/dF9KEdJbX+TPAFO0OjS8osZzqKvkU5/eB8pkgtJRIpoTM+w++WR5i8BHGOL3k2iQCrIlLCrzBNr1PR3mPeaE68rcXnxV22Hgi4MXonqBSnigL3frIxcbUXqm6Vu+YzeifuUaRKDKD2hUT6LE7JwLEpYpY9y4L+JN0z72ZitmgCf/vrwr7DebnkVjMVYhFNTbc/Xm4RsVq9GJBC1vIjV7MHycrddNqbdf1y46EVU0+4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775025174; c=relaxed/relaxed;
	bh=SkjwiZunDWK5fwEX6amj6vO5RCISy1VVsllzfElLcGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=htjltyhBlAgAnLHc+QqGLUOaK7Hi6ZWtOwJZsFTcdrra/zIWg7TqJiZG4mtdYg1mVXyfNRWw5S7kyc4WN3XiDtgSTFKH2v0mcQipq6rJOUW3kI2BTEfuJHeRtXypaIlmRMQXpmx6yzL3Fq6MOCBBNghT9tEZcs01Icc1jhbJr5O1A7NMg2Y0hWllwn2QyyCYF4lPV8Lq189jPCDDigfu8Rpyy9px3sgryTvsYqiJBeqEGWFTVzuFkG4v9FXJY4g7zuNZ2rdHjbzPFTdoTnAOT+2NSP6lYZMGZL5fPRil0bV2T4Itga1YA1ssykV1paSBVc1O4ICiMWq5uO+K7U66GA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Fm00lhsn; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Fm00lhsn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flwCT3WZ0z2xb3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 17:32:53 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VHoBrb3518860;
	Wed, 1 Apr 2026 06:32:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=SkjwiZunDWK5fwEX6
	amj6vO5RCISy1VVsllzfElLcGQ=; b=Fm00lhsnaKrFpnWP3aAZEIzZmydJUGqQo
	bOILdhiSjUKa9yBrQLnDNntj4n61OBAiZSnApE6TNVsi3ybaHaKG3OAU9sr+Xtmo
	eTaTBIkfPsGig775KQuyNJYwgA0mClwcS6e4LN0MrmU8h4cbWM7CeIwIzCTzTQlR
	gjEgEsUc+8YZCMYH5cJytd+3ko+OUJjcctHxkZX48eM3cHcqHFweR4JvBX3U3Zed
	lxEEc0aNW2JxtepXxSZWC2yArGU25/SCNZDR8XAfGvgzPSySfF0i70c6M6u2mj6e
	m+6Rc26fP/flVUeLxplwwvRwqySWAq7S6dpP3iSCAxaN+U+Ctvq1g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66q36taw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 06:32:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6311krEN013898;
	Wed, 1 Apr 2026 06:32:36 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttkmaa6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 06:32:36 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6316WWCb48038272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 06:32:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47B7320040;
	Wed,  1 Apr 2026 06:32:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E13220043;
	Wed,  1 Apr 2026 06:32:30 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 06:32:30 +0000 (GMT)
From: adubey@linux.ibm.com
To: linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, bpf@vger.kernel.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        Abhishek Dubey <adubey@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH v7 2/2] selftests/bpf: Enable private stack tests for powerpc64
Date: Wed,  1 Apr 2026 06:32:15 -0400
Message-ID: <20260401103215.104438-2-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260401103215.104438-1-adubey@linux.ibm.com>
References: <20260401103215.104438-1-adubey@linux.ibm.com>
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
X-Proofpoint-GUID: b2lB-LmZi9c9hpyq2hg9RwL800Yi28Mp
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=69ccbc05 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Qsp4X0VqqGRFJZHKWwsA:9
X-Proofpoint-ORIG-GUID: b2lB-LmZi9c9hpyq2hg9RwL800Yi28Mp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA1MyBTYWx0ZWRfX/uroTxCJThA5
 5SPrz3z2sFmiF0CMTLFj3pjRTZltC+9nBCUicqF/5Kos/MHv/YY81fvu+kM2QFsIZSu1HRXZ4Oa
 syyuTJW7xEiUX5mYlM90jkicmdDNh6aw84O8yfvIU1RIShDG6XFi9M3MtKd2ILL3Esanx4HMXYK
 52u8om3K1xsmNUIyRZYwGGqxHRVQm4SugBObN4KkaHgtoczN3ZKps9DZfMRFv654SoXND8KyM0f
 pcirUFq1PYo5aF20GISWuX50DSPfnOj/QNbULvNhf94Ox+IPz9Vsi7U1sfqaKVLlg0E2+TfSGdL
 e1OBOyVnfSTSGpXY3y14sDjKq6nEYhi/TZPhr5nv6tDIPtmLjrmC1GN5/WrdX9m2LWi1O8JGmME
 SshEiirV8HpI/hRNtJeTwvg8Fbrl9Pn4dSMY2cr5KTyJ0WH48SMKJ5F7tGVWJkpG43g1o2qbyXy
 BHAj7zJ4WX449qggvEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010053

From: Abhishek Dubey <adubey@linux.ibm.com>

With support of private stack, relevant tests must pass
on powerpc64.

#./test_progs -t struct_ops_private_stack
#434/1   struct_ops_private_stack/private_stack:OK
#434/2   struct_ops_private_stack/private_stack_fail:OK
#434/3   struct_ops_private_stack/private_stack_recur:OK
#434     struct_ops_private_stack:OK
Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
---

v6->v7:
  Pickup tags
v5->v6:
  Remove unused label
v4->v5:
  Rebase over latest branch
v3->v4:
  No change
v2->v3:
  Enable testcase using __powerpc64__ instead of __TARGET_ARCH_powerpc,
  to prevent it getting invoked on powerpc32
v1->v2:
  No change

[v6]: https://lore.kernel.org/bpf/20260331080309.173612-1-adubey@linux.ibm.com
[v5]: https://lore.kernel.org/bpf/20260330232034.44776-1-adubey@linux.ibm.com
[v4]: https://lore.kernel.org/bpf/20260226031324.17352-1-adubey@linux.ibm.com
[v3]: https://lore.kernel.org/bpf/20260226005440.9570-1-adubey@linux.ibm.com
[v2]: https://lore.kernel.org/bpf/20260225153950.15331-1-adubey@linux.ibm.com
[v1]: https://lore.kernel.org/bpf/20260216152234.36632-1-adubey@linux.ibm.com

 .../bpf/prog_tests/struct_ops_private_stack.c | 30 ++++++++-----------
 .../bpf/progs/struct_ops_private_stack.c      |  6 ----
 .../bpf/progs/struct_ops_private_stack_fail.c |  6 ----
 .../progs/struct_ops_private_stack_recur.c    |  6 ----
 4 files changed, 13 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c b/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
index d42123a0fb16..98db9bafa44b 100644
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
@@ -48,15 +44,9 @@ static void test_private_stack_fail(void)
 	if (!ASSERT_OK_PTR(skel, "struct_ops_private_stack_fail__open"))
 		return;
 
-	if (skel->data->skip) {
-		test__skip();
-		goto cleanup;
-	}
-
 	err = struct_ops_private_stack_fail__load(skel);
 	ASSERT_ERR(err, "struct_ops_private_stack_fail__load");
 
-cleanup:
 	struct_ops_private_stack_fail__destroy(skel);
 }
 
@@ -70,11 +60,6 @@ static void test_private_stack_recur(void)
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
@@ -93,7 +78,7 @@ static void test_private_stack_recur(void)
 	struct_ops_private_stack_recur__destroy(skel);
 }
 
-void test_struct_ops_private_stack(void)
+static void __test_struct_ops_private_stack(void)
 {
 	if (test__start_subtest("private_stack"))
 		test_private_stack();
@@ -102,3 +87,14 @@ void test_struct_ops_private_stack(void)
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


