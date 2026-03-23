Return-Path: <linuxppc-dev+bounces-18627-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090E5EC01CD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 12:24:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffXRY4VtTz2ySc;
	Mon, 23 Mar 2026 23:24:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774268681;
	cv=none; b=LBAkfLKEAA5cbRLq/wIAyAqbWxphMOn0YS6P/N2dOQELQtv1ELwuZSDObideUavE7WD6Aor/lgeu1VMhPA1yWHNEE7vfWNs4W0nVw7Vp7z5XYJrsQz4xL+59nDF+oIyYhP76fLqnk+U69wsCqkODyNlWsCMV6PeBGwhVvLYYP/Rf+inPXKGE3rfLKVPUihgfeFeyy2QqpKjOpBlfwI3SK4q1ztlfCMeFiGw8Vq+8LONv6b36LhuA41lwepXNy7ZaintMj8iEJPS/cjD3y/mm6lh4x//nUS8zWc7n9QZ6xRvro9cpbYC5U5bhzulGEgZZy2ySc1IyZqhnTg3FIx7fVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774268681; c=relaxed/relaxed;
	bh=z6SgLbYUDqPGxGeE/U9+Advc7KQ1OyZKc+TkwM3oeFM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BOyt6/X448jlMf11anbrSBY0YZFzxkKR+hF6ZIZR1+O+ho0Dy5QfA5BPcIKKHuVbVFwnw8oogMsMPaqb6qJusTRw/J/aP07Ize5wCpBhvaSS0ZpjKDuByU7RsIxWZ5TXEi2kJ0Ery0ZBFXAHwfNQL/cE/B13aRDF3HopmJZu5rPBhNMaU2rsdc/2RjKf5TsDo7PnZyjDMfWVrSkTh//yXBz/+7Sgh8jEfdwqY9FIPuaGY2QhaE4wPLWwI9zjoS7d6L9wdOT2h20epN9wkkBeKm6LusjN6GP219OgM2ZRNr4VUyp7UUaIpdW9jBvcwb2tPw7GKHNIzBJVxR19POcTww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fTcu/ZB8; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fTcu/ZB8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffXRX5Jwbz2ySb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 23:24:40 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62MLGB3v415280;
	Mon, 23 Mar 2026 12:24:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=z6SgLbYUDqPGxGeE/U9+Advc7KQ1OyZKc+TkwM3oe
	FM=; b=fTcu/ZB8F5nkSY/B5yV2MWxqpXBAy4bg4NAuoFC319eAMCsuSA24sbtvT
	cT0xZAFgtIoqxCRmijq7jtaodYz+qjiK/HyfnPjxMmhhblZyRgH1V7rxWCg6FXQt
	WAIeqrU5M8R66YYGY8eqUBasqsDEWQ1VF4BC5ljDw6ag8RSf3oxK5hsGvQAJCT5J
	Kc1CjiRP1xH0pfLFpWXVGolqN73YpjBs3WUuYVFnBaDJU5YoqqKshDPPSvf2WjPN
	73HPCDlzo6mQRr9210ztn6E6uebJ3BeedDkAjRiqLDYczb1PowU+AMB6QVqb6W7q
	lh2IIHOC77vxGWqsCMvbV6yhAZ2Qg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kumeg4y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 12:24:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62NBBLJp031592;
	Mon, 23 Mar 2026 12:24:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d25nsnegg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 12:24:33 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62NCOT1r12583308
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 12:24:29 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 576842004F;
	Mon, 23 Mar 2026 12:24:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96E4B2004B;
	Mon, 23 Mar 2026 12:24:26 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.222.130])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Mar 2026 12:24:26 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Subject: [PATCH V2] tools/perf/tests: Update test_adding_kernel.sh to handle proper debuginfo check
Date: Mon, 23 Mar 2026 17:54:24 +0530
Message-Id: <20260323122424.88068-1-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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
X-Proofpoint-GUID: 0IuV7QVQEzjkYDzoBN0cHa-UXOuMnVNc
X-Proofpoint-ORIG-GUID: 5YWDhPIAUIOY5zunGHzgCnz7SjuMU7Cd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA5NSBTYWx0ZWRfX9MQg/yrfA+eV
 Vbiump5d9YNTxjugaska9+bkF226WMu9ndpg5T48YML1rv+Vyj/n6MwxzaT1dXkotgM3ZCKyBcH
 xRp+ezW5NxgYRCbKkWtG/9fvU/P4NQ/VSjDGYBJ8m7KJbTvaHtwoL8xUBM9LCMuDzkLENmkPUKf
 hM/gkeh0cD6fWcudVI4khZEovm+N+mO6Z/pLGUpLNKxEwlGMXwD3xFNpBC/YlBJDnn8Y3poEslJ
 0Su00CQFbkSmba0NHVn0TrWtbcD8jIsH1o6yPRDdt+F1U5FeB4wGmL+QomzFqrS2NjpEqh5z/aF
 ar0KLSXK66KhvqS+08FbvLKvClqG9ojg3p+jEwxCEdcYjfvl4NOP2u/b6R4ZgYwxN0VBEgIBAbf
 J0bu+fkngB8zJ0dd0gAqB91dcP4sPPzqNAN6igKds1PZaF4fztNTLLaQp23csuUBRr+IzwJ35A+
 prhy0cyhb1BkFA5EC3Q==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c13102 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8
 a=djXmuU_IFq0narE4Ot4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230095

Perf test perftool-testsuite_probe fails as below:

 Regexp not found: "\s*probe:inode_permission(?:_\d+)?\s+\(on inode_permission(?:[:\+][0-9A-Fa-f]+)?@.+\)"
 -- [ FAIL ] -- perf_probe :: test_adding_kernel :: listing added probe :: perf probe -l (output regexp parsing)
 -- [ PASS ] -- perf_probe :: test_adding_kernel :: removing multiple probes
 Regexp not found: "probe:vfs_mknod"
 Regexp not found: "probe:vfs_create"
 Regexp not found: "probe:vfs_rmdir"
 Regexp not found: "probe:vfs_link"
 Regexp not found: "probe:vfs_write"
 -- [ FAIL ] -- perf_probe :: test_adding_kernel :: wildcard adding support (command exitcode + output regexp parsing)
 Regexp not found: "somenonexistingrandomstuffwhichisalsoprettylongorevenlongertoexceed64"
 Regexp not found: "in this function|at this address"
 -- [ FAIL ] -- perf_probe :: test_adding_kernel :: non-existing variable (output regexp parsing)
 ## [ FAIL ] ## perf_probe :: test_adding_kernel SUMMARY :: 3 failures found

Further analysing, the failed testcase is for "test_adding_kernel".
If the kernel debuginfo is missing, perf probe fails as below:

perf probe -nf --max-probes=512 -a 'vfs_* $params'
Failed to find the path for the kernel: No such file or directory
  Error: Failed to add events.

skip_if_no_debuginfo has check to handle whether debuginfo is present
and the testcase checks for debuginfo since this :
commit 90d32e92011e ("tools/perf: Handle perftool-testsuite_probe
testcases fail when kernel debuginfo is not present")

Recently a change got added in "tests/shell/lib/probe_vfs_getname.sh"
via this another fix:
commit 92b664dcefab ("perf test probe_vfs_getname: Skip if no suitable
line detected")
Since this commit, first add_probe_vfs_getname is used to prevent false
failures. And based on return code of add_probe_vfs_getname, skip_if_no_debuginfo
is used to skip testcase if debuginfo is present. And this modified other
testcases to call add_probe_vfs_getname first and invoke
skip_if_no_debuginfo based on return value.

The tests in test_adding_kernel.sh which depends on presence of
debuginfo are:
1. probe add for inode_permission
2. probe max-probes option using 'vfs_* $params'
3. non-existing variable probing

For these tests, probe check for specific line is not required.
So call skip_if_no_debuginfo with argument to say if line check is
needed. This is to convey to skip_if_no_debuginfo() function
that test only needs to check for debuginfo, and not specifically
line number. Update skip_if_no_debuginfo to use simple "perf probe"
check if test only needs to check for debuginfo. And for other
tests which rely on line number, use add_probe_vfs_getname()

With the change, verified that only three which required debuginfo only
is skipped and others ran successfully. Also tested with debuginfo
to make sure tests are not skipped.

Reported-by: Tejas Manhas <Tejas.Manhas1@ibm.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changelog:
- First version used "perf probe -v -L getname_flags" for debuginfo
  check. This will not catch fail string "Debuginfo-analysis is not
supported" which is used in cases when perf is built without dwarf.
 So use "perf probe -vn add inode_permission" to capture cases when
 tools built with NO_LIBDWARF=1. This will capture debuginfo missing as
well as tool built without dwarf case.

 .../tests/shell/base_probe/test_adding_kernel.sh  | 15 ++++++++++++++-
 tools/perf/tests/shell/lib/probe_vfs_getname.sh   | 13 ++++++++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
index 555a825d55f2..f3db125c8669 100755
--- a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
+++ b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
@@ -23,10 +23,23 @@ TEST_RESULT=0
 . "$DIR_PATH/../lib/probe_vfs_getname.sh"
 
 TEST_PROBE=${TEST_PROBE:-"inode_permission"}
+PROBE_NO_LINE_CHECK=1
 
 # set NO_DEBUGINFO to skip testcase if debuginfo is not present
 # skip_if_no_debuginfo returns 2 if debuginfo is not present
-skip_if_no_debuginfo
+#
+# The perf probe checks which depends on presence of debuginfo and
+# used in this testcase are:
+# 1. probe add for inode_permission
+# 2. probe max-probes option using 'vfs_* $params'
+# 3. non-existing variable probing
+#
+# For these tests, probe check for specific line is not
+# required ( add_probe_vfs_getname does that ). So call
+# skip_if_no_debuginfo with argument as 1. This is to convey
+# that test only needs to check for debuginfo, and not specifically
+# line number
+skip_if_no_debuginfo $PROBE_NO_LINE_CHECK
 if [ $? -eq 2 ]; then
 	NO_DEBUGINFO=1
 fi
diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
index 88cd0e26d5f6..8ae2ea2bc8a2 100644
--- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
@@ -39,7 +39,18 @@ add_probe_vfs_getname() {
 }
 
 skip_if_no_debuginfo() {
-	add_probe_vfs_getname -v 2>&1 | grep -E -q "^(Failed to find the path for the kernel|Debuginfo-analysis is not supported)|(file has no debug information)" && return 2
+	no_line_check=$1
+	debug_str="^(Failed to find the path for the kernel|Debuginfo-analysis is not supported)|(file has no debug information)"
+
+	# search for debug_str using simple perf probe if the
+	# test only needs to check for debuginfo, and not specifically
+	# line number.
+	if [ $no_line_check -eq 1 ]; then
+		perf probe -vn add inode_permission 2>&1 | grep -E -q "$debug_str" && return 2
+	else
+		add_probe_vfs_getname -v 2>&1 | grep -E -q "$debug_str" && return 2
+	fi
+
 	return 1
 }
 
-- 
2.47.3


