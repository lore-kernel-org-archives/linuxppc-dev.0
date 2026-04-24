Return-Path: <linuxppc-dev+bounces-20091-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5902BFED3F1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 17:24:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g2KbC5V9bz2yTQ;
	Sat, 25 Apr 2026 03:24:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777051495;
	cv=none; b=Lj5lIxjhO70tViaqjmGq5lH93ChGBffKK8s31yJsuWkcRJ+vD26nHwxTHRZBKSn1NM5wDfP2OmYsX8cZ9tqrdXeLUs78Qf535tnN/tXQTvBBuIeIri2rEeQ9rcx+JM7MnxrL6MKGmaR1rCGjTXDWtP01bkw3hKscRd9TCTBOm3vHykbbJ0Q0gsx5n+b9Sdmg3Zic6frVXBIxLYJskP9pb8Y2zDEHJ02VMuVdUFEo92BKpfcVLUxCtkwPrhEBeN0xcibrAeNmhfqkO6ERGS8d9uaeeP7w9se7qjFyNETcPbkHcxW5fCkdVfYXO/pZuI9HI/0PCdGcNxycYwMCfPRw+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777051495; c=relaxed/relaxed;
	bh=/cB85TzxeRYGL5Odl5N8QteFy9OAAU3sdsj9rYuH1O8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NPEQ8aEzDraFbkRvuI8VM5iltfSSRiwmOoCvu5sHWLU4LiWyZWUiBonVvrJB+w7esiNZrpEQBwwk4ZORroqazLa1S6E7SdEUzgK7EPcMnF7f1N9l521aM+bPHJ6D0ptXbycTpoq/sWzXuUfhhKZ60ZQLoE4Vgl6aIiG+XWlC/6nylg3CVwVzPWNTun6OOkYy/ki+SwNrNwousBammu3xATf8+1VIpwUtFH4oufmVlqVIkyD5sfle9F5tns3wFx0wcih8VnCV8vJ868ekvDIrMhIaqE+cSaXPGKYsqTwlA++rvlTNciCGaoh82a1bkLY7g9esjLqNqaLKAbdVBXqZyw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fvYNBsz1; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fvYNBsz1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g2KbB6C3kz2xnl
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2026 03:24:54 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63O6Z2Fp365114;
	Fri, 24 Apr 2026 17:24:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=/cB85TzxeRYGL5Odl5N8QteFy9OAAU3sdsj9rYuH1
	O8=; b=fvYNBsz144WBDQgkTM88ctT9ssOJrjNs5Gt7KHng5egoiYha8Wnx5zHJE
	FMm85o9VkzuisY/7QWRTwEwzedfDJ0MAYdPkTlhWBSOvrhUjUDRzkDOkkOtZDwzI
	ICCIdjAXP0uShhhk1ixe9tJg36rRYc6P9tWVwOi/mmZgu1GqTdPeK5kqPbfYWb3c
	jbwCnjaIsNDoSNHLUjwnPPfH3MQYoEQBKVtnV4m+D0mnvWlCg/ZIbMIfJOKkJ5Ek
	qdU3ueRTh40HeuEKuAnmLy86xV4FFYLvgoIiZdNt9t9nCoX/kUlPwx5aOL6+CMgF
	6wFPQnf7iQhRDzyKFMTeM2tIEX1Kw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dphfrpexp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 17:24:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63OHKMIo008912;
	Fri, 24 Apr 2026 17:24:46 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjkyus5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 17:24:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63OHOgcA51839234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Apr 2026 17:24:42 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 381212004D;
	Fri, 24 Apr 2026 17:24:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABEA020040;
	Fri, 24 Apr 2026 17:24:38 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.219.242])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Apr 2026 17:24:38 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Subject: [PATCH V3] tools/perf/tests: Update test_adding_kernel.sh to handle proper debuginfo check
Date: Fri, 24 Apr 2026 22:54:35 +0530
Message-Id: <20260424172435.91725-1-atrajeev@linux.ibm.com>
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
X-Proofpoint-GUID: YjCa_2gnaxastfQMauDVt-2uALpe3MT1
X-Proofpoint-ORIG-GUID: SNk5dnMaD0qg3b5xw5IHv1twqOHt33c-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE2OCBTYWx0ZWRfXy2vPscDy0r2z
 wx6fyETH5tQmEqA0QMLcrpSs4llFo07WIZ5GJV5yFfucWbZ3KuAOnGRVXRWu011zhvNkQuUfQGj
 3z+Sc5uApnyhICJEkAkI/+OPNMuxqGlUpYL01zBDFOxSmavaFK4h2DfXBhy2JI9sTKD/tUzPQ0A
 PS0/+hBb/vIfMPGGmbn9YbUwewJo64dm9K19OZ7b+2uY2sxk2QoGfAuYVJAJxOg0LPf2CdxjXzw
 +ZbuGcUfk+f/4rHxj+j3+mS4AdilGv3U+IkmC83gF71/zF1t8BZUCaGXsZvJPTdI/DykEqGfe8Y
 Cdu6bMV3O4N19AJPXg74e661YJ50jrvPBOBymdgdS+3kRpDRwPuSC48frHpWRt0P5AH+1k/6mW+
 J5kaXgmPcggTn+ZIyLlvbFH0ZHCj5ONV2Xa2AWQ0ZOumBdJOOs1FxdNf2t+pOiNzq5hyhFhBlqB
 zl1wTsZ1cLrxuVA8WGg==
X-Authority-Analysis: v=2.4 cv=SJxykuvH c=1 sm=1 tr=0 ts=69eba75f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8
 a=E34RJTyr9ZXJz0s_rhIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240168

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
Update other places which uses skip_if_no_debuginfo to use argument
as zero.

With the change, verified that only three which required debuginfo only
is skipped and others ran successfully. Also tested with debuginfo
to make sure tests are not skipped.

Reported-by: Tejas Manhas <Tejas.Manhas1@ibm.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changelog:
v2 -> v3:
- Update other callsites to use "skip_if_no_debuginfo 0"
- Use "perf probe -vn --add inode_permission $params"

v1 -> v2:
- First version used "perf probe -v -L getname_flags" for debuginfo
  check. This will not catch fail string "Debuginfo-analysis is not
supported" which is used in cases when perf is built without dwarf.
 So use "perf probe -vn add inode_permission" to capture cases when
 tools built with NO_LIBDWARF=1. This will capture debuginfo missing as
well as tool built without dwarf case.

 .../tests/shell/base_probe/test_adding_kernel.sh  | 15 ++++++++++++++-
 tools/perf/tests/shell/lib/probe_vfs_getname.sh   | 13 ++++++++++++-
 tools/perf/tests/shell/probe_vfs_getname.sh       |  7 ++++++-
 .../shell/record+script_probe_vfs_getname.sh      |  7 ++++++-
 tools/perf/tests/shell/trace+probe_vfs_getname.sh |  7 ++++++-
 5 files changed, 44 insertions(+), 5 deletions(-)

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
index 88cd0e26d5f6..2c5252a38ea1 100644
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
+		perf probe -vn --add 'inode_permission $params' 2>&1 | grep -E -q "$debug_str" && return 2
+	else
+		add_probe_vfs_getname -v 2>&1 | grep -E -q "$debug_str" && return 2
+	fi
+
 	return 1
 }
 
diff --git a/tools/perf/tests/shell/probe_vfs_getname.sh b/tools/perf/tests/shell/probe_vfs_getname.sh
index 5fe5682c28ce..b0878f571449 100755
--- a/tools/perf/tests/shell/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/probe_vfs_getname.sh
@@ -16,8 +16,13 @@ skip_if_no_perf_probe || exit 2
 add_probe_vfs_getname
 err=$?
 
+# Invoke skip_if_no_debuginfo with argument as 0,
+# since the test needs suitable line number for getname
+# along with debuginfo check.
+# Argument "1" is used when to convey that test only needs to
+# check for debuginfo, and not specifically line number.
 if [ $err -eq 1 ] ; then
-	skip_if_no_debuginfo
+	skip_if_no_debuginfo 0
 	err=$?
 fi
 
diff --git a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
index 002f7037f182..48063fc2b221 100755
--- a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
@@ -38,8 +38,13 @@ perf_script_filenames() {
 add_probe_vfs_getname
 err=$?
 
+# Invoke skip_if_no_debuginfo with argument as 0,
+# since the test needs suitable line number for getname
+# along with debuginfo check.
+# Argument "1" is used when to convey that test only needs to
+# check for debuginfo, and not specifically line number.
 if [ $err -eq 1 ] ; then
-        skip_if_no_debuginfo
+        skip_if_no_debuginfo 0
         err=$?
 fi
 
diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
index 7a0b1145d0cd..6833fba12086 100755
--- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
@@ -28,8 +28,13 @@ trace_open_vfs_getname() {
 add_probe_vfs_getname
 err=$?
 
+# Invoke skip_if_no_debuginfo with argument as 0,
+# since the test needs suitable line number for getname
+# along with debuginfo check.
+# Argument "1" is used when to convey that test only needs to
+# check for debuginfo, and not specifically line number.
 if [ $err -eq 1 ] ; then
-        skip_if_no_debuginfo
+        skip_if_no_debuginfo 0
         err=$?
 fi
 
-- 
2.47.3


