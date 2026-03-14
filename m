Return-Path: <linuxppc-dev+bounces-18189-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D775105F79E
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Mar 2026 08:37:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXvqj1kK6z2xjb;
	Sat, 14 Mar 2026 19:37:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773477457;
	cv=none; b=glWrUdkJxuMFAFpjafpxSbGZHcnRA3t3IYo+0cy83+SecR+KXyFd5mX5oLLqAW8j5A3EvAOWicMesPindVTkfdlRA0lte66xnkCYaRObhhesaiNiwgniopISUO6xf7hqvOu7eZyEYappumCA3dZ1qe3nBfdZf20QFVuQk1qvlx7d1j1YLWzjFVx/bapOKp77lELQKCxHpsT0GfLfOw0ZuHmKWX2y/ZfZ5nM6Nrwy6+YTvhI2ott7yXCWLpYNtGlfkyHA9bW2D9zhdTiVp3Ei8xjy059gT2yq0je6gygziXMO4UG1KC04oS8Br97eISW683Dl2OJ29n0esUAbqW7a0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773477457; c=relaxed/relaxed;
	bh=3lsB4V5bMYL2HUXBTT5e1ld2bt+Kg6LHO4x7RfSw3Qo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I8qlokkwCznhBVynbQICmcEa1Oc3UvKPi0p3Lxx/8FyH+GZ6Dp+vjMqvi3wNPH2mCLR8UZT0O4i5vPrpV0JbGCZHp895rC0EwF/BLVqRLPbQ3zFxw1Aq5PSwVBtPJbgnANxvvMhdxRz8aWSnWlaDpAb2PCkV0P4epoQCC0WJC3UbR5Q23ILCB5I2GAF/gI3NNMfxymTCi6w+kVsbl45MInHD/TEMmODZnvMMar7rkKJlJxq3rW5i4V7RFPB8h2LttIYWyTCJoSg4f06nu47hKrWWS8qEB+PuHJ6V8FeBDRVnZyKywaj9QbI0f3gOwoOCX5JzyjUdsBwTm7xFFLJdjA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eoTKG0K/; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eoTKG0K/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXvqh3qJYz2xgv
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Mar 2026 19:37:36 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62E7CWQX1023893;
	Sat, 14 Mar 2026 08:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=3lsB4V5bMYL2HUXBTT5e1ld2bt+Kg6LHO4x7RfSw3
	Qo=; b=eoTKG0K/6v9KR4FWuVAtOHKoxlRqKXbmLnPkc4UWXmhBrrusU5xEwqvM6
	ukVK4SdLh58SHJgazYXIZPkCbLugX3pOvGvHXMApGWYnPHbuLxheq2r5Ua4Ew4RX
	zfs5B9vj5yE83B2z3lh4tRmpn0OsH4/llnvJi4drOwEI1riKzek2+y0XwQWyp2cM
	YaMZP51c2AdHxqerct42DLU+4LpMY7dak+hFgGDfkATQYwrVHLGxIZpbayfGK5Ec
	a5RxZWaOL/RlpVKBan+VJjZNOHSomON2hV4FB2ypAI6FU9WU8Bw2r1A6GJZ8/P24
	dsaV/Iop0rZE2QoOWPc/8PavyUwoA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvy648qdq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 14 Mar 2026 08:37:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62E8FCKL006130;
	Sat, 14 Mar 2026 08:37:31 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha9su4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 14 Mar 2026 08:37:31 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62E8bRUh27787602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Mar 2026 08:37:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DF622005A;
	Sat, 14 Mar 2026 08:37:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9CB62004F;
	Sat, 14 Mar 2026 08:37:24 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.216.245])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 14 Mar 2026 08:37:24 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        jbrnak@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Subject: [PATCH] tools/perf/tests: Update debuginfo check in skip_if_no_debuginfo
Date: Sat, 14 Mar 2026 14:07:22 +0530
Message-Id: <20260314083722.76728-1-atrajeev@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: wYmgZT9NiekdXyut2t45XI0wPobSIn22
X-Proofpoint-GUID: 8w3q86xpr2MOm_S3iqSIXh3uaIl6VMwR
X-Authority-Analysis: v=2.4 cv=KYnfcAYD c=1 sm=1 tr=0 ts=69b51e4c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=djXmuU_IFq0narE4Ot4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDA2MiBTYWx0ZWRfX9yPyFeQIA28q
 NUPrtcksxYgQtiA0z7BW2fbgY5KGyC/Dt6IGIt3A/z9GKuxL7+gsmMG1NRJNbjfcvVDJknv/f8n
 oZr+iLIte0xlNtxXQCcykqKcffh+S4CFTPASmMyfU6zH49ecCwnJdlSvrqQ1OLYavlZBZpjPkmi
 qEnptHkbcrG7M7CeL/kQEvPRZZYohStL/eabXxS9WZnKW8aD1Y5bwG5KWJ2GznBvA7GrNGoyVpp
 4jn9jN6XNu44gAk6hTz0S7xANvNmt9qK8aacALnS5VP9Uqg93iNtasDTa+evA7H18WRn8PK0ItB
 h5mI4acYn7Q8XcAv+Msse30arYI8gbQlxeFJ93COzn831IXYVaKBlab66N58XVQdCrtibgIKSBh
 BO6Ac2wqqQgvtfr7Cjwf+JhjR0azFZyPX/A1Gmu46nTmGdHT00c3nCcWz5lAlhBylLJTybzD/Ca
 TYTMMmmKjD2HMXV0Dvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-14_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603140062

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
Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
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
index 88cd0e26d5f6..8584ec76f041 100644
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
+		perf probe -v -L getname_flags 2>&1 | grep -E -q "$debug_str" && return 2
+	else
+		add_probe_vfs_getname -v 2>&1 | grep -E -q "$debug_str" && return 2
+	fi
+
 	return 1
 }
 
-- 
2.47.3


