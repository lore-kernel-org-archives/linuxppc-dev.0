Return-Path: <linuxppc-dev+bounces-19393-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DFFEF4EC2
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2026 09:21:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fq3hx6rFlz2yty;
	Mon, 06 Apr 2026 19:20:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775467249;
	cv=none; b=Of3l0WjtnvmK2+EsOl4LpYKU1aoYktey4ZjvrjMFuZS/KZImDeK6tFjHCyPTwu/GVNU8DhsiCfG+VxR2ozrOAygiz9v8x7y2ijn5g+aue5LuQrp5wa2ZMzcs5H5yfJUBQ9ath71HpUP4dNQGeheSo9U1magbwICyWsWElhBzEQcrs53BpT9V7jY9xx0ysQat1dRy8K5OiFCh1Niwh3gRVHpX01M7Gi447qyPwMeXQlJy5KzRHoGmQzd5KzDgoNWgdyXn4PoAZuOCq56o1a2urT2gQXME1vsxHPj2DNr9jkQ7NFK8DowldUsCGj3GMm8boDiLpR1l31d1M4fGVzs4uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775467249; c=relaxed/relaxed;
	bh=JNtZN4fc3fipI4yf8pu4qS2Gj54ni0NC4icf3M6AOi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+cP4KO0uLK6QZNtUTBWNxFF7dhKvxOfzyvkU0Ri3RV/kvxzHB5co+H4EwH6yRpsOsIz9qKSeSKA3o5YvGU34sI2MX6y+PI/H/mvDc/yHYv/ndJuO/wrWkWjgeNmivvAEXTQSWtDZ3XM00a0HUnfoy2DHEp8reh7QofYyPuRwhTr7LLXK+VcxoM3EP5mS0OJulFKpBQZrRhqi74qDGwXZYXKiLUHddY3cE0L6xDjOKv05zg3w4k3rac0SBhENQJkHr54W750Gz/4sigXnBG8zX7sM90rXb+s+n9TIRsCo8/Yuk4rGIGgCJ9WHJ0ErtMj/G4Hc6Ks9OBNJplW06Gt2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VrdErJcX; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VrdErJcX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fq3hx1ttvz2yft
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Apr 2026 19:20:49 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6357VDPg2060321;
	Mon, 6 Apr 2026 09:20:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JNtZN4fc3fipI4yf8
	pu4qS2Gj54ni0NC4icf3M6AOi8=; b=VrdErJcXzFnKrj1X2SdixJ8NqvqAI+FHU
	MQkHqTdrNwMcgPLap7BftiIhZjQyasphfdKdphjtEik4Pd1KDhJtYxV2e1vN0HbH
	FeTjzTsxLz2Z5hacl0yxeZ4o9IYeSGdt5okgPDRBSJTMTnofUMuNTR8C+bXy5a1m
	xrmxTk/U7L2r1tenDRzX4OWcBfvjwK/PvghtQKZbDwV2olp9D2+XLcBPTpm8XnKC
	QH239u5lP/NqodtXTFngALMmVnqX7cD3EPGq0f8VW3c3HrEIbEtgSuw+oxHPnkeb
	UIEJkjs45YQPGXV9Cir0R+RWBz4gV4Xrn5fd/tpeuejyLJs4LKeBg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4datc2nwk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 09:20:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6365YIxO020122;
	Mon, 6 Apr 2026 09:20:35 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dbdync2xf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 09:20:34 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6369KVbK35717560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Apr 2026 09:20:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E561820040;
	Mon,  6 Apr 2026 09:20:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2B4820043;
	Mon,  6 Apr 2026 09:20:27 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.bl1-in.ibm.com (unknown [9.123.3.209])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Apr 2026 09:20:27 +0000 (GMT)
From: Sayali Patil <sayalip@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>
Cc: David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Michal Hocko <mhocko@kernel.org>, Oscar Salvador <osalvador@suse.de>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Dev Jain <dev.jain@arm.com>, Liam.Howlett@oracle.com,
        linuxppc-dev@lists.ozlabs.org, Miaohe Lin <linmiaohe@huawei.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Sayali Patil <sayalip@linux.ibm.com>
Subject: [PATCH v4 13/15] selftests/mm: move hwpoison setup into run_test() and silence modprobe output for memory-failure category
Date: Mon,  6 Apr 2026 14:49:32 +0530
Message-ID: <8ef8640092004d143fe80e6fc32ea8d30a9080de.1775466330.git.sayalip@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1775466329.git.sayalip@linux.ibm.com>
References: <cover.1775466329.git.sayalip@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDA5MCBTYWx0ZWRfX3oslSqiFf+LQ
 p6SaJ1Q3vw9BSrU0PRFLFDRhkKrZ/n64kViRHF+jfc8/ldlHAFDpmwKctEzTiCpJeBsLr0ufUxl
 1qJV9d7Y64QtR9Y2zkyzMI7BLwlJkx8cJmaxLvSpmKO63EHMJ85raAn35PX6sB5EdSfd20/FHqK
 TPIOUdE3UBJ2LYKMz7E+KBB+Ecw88HOmNDWAVuH7Rzg5rXEbe9SUFbUxcPtly4cYILEOh2LL4CU
 368D+pch/KIY1GINjcomiIVEYJ9F6NS27gICBIa4NDWJKgivnU3z9ZpuGG9hTEUT/oF/ISK3qjK
 Nm3uNGPX+3onphblaXscmT2EyOqtJcU4bq9b2w3Yh8SkKaVk1TGDKq9D9VEbGJtgmgR4p/u4Np2
 cZlQp+oCmeMA+/EiaICc0YweZXTdYIl6KbglhwlohGCfmVqQnolsiUNH4N2W//UN0aaYjiLBJOB
 pRsTMCrHZPdqiNSGx0g==
X-Proofpoint-GUID: QYU5me-PA449jhZ1jmNCEMx5dtqm78Fn
X-Proofpoint-ORIG-GUID: l6L2mecNU6czOwdTVez3C-q7FeG_yKkj
X-Authority-Analysis: v=2.4 cv=HJvO14tv c=1 sm=1 tr=0 ts=69d37ae4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=w_JUWIshtjp1QPcyv1YA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604060090

run_vmtests.sh contains special handling to ensure the hwpoison_inject
module is available for the memory-failure tests. This logic was
implemented outside of run_test(), making the setup category-specific
but managed globally.

Move the hwpoison_inject handling into run_test() and restrict it
to the memory-failure category so that:
1. the module is checked and loaded only when memory-failure tests run,
2. the test is skipped if the module or the debugfs interface
(/sys/kernel/debug/hwpoison/) is not available.
3. the module is unloaded after the test if it was loaded by the script.

This localizes category-specific setup and makes the test flow
consistent with other per-category preparations.

While updating this logic, fix the module availability check.
The script previously used:

	modprobe -R hwpoison_inject

The -R option prints the resolved module name to stdout, causing every
run to print:

	hwpoison_inject

in the test output, even when no action is required, introducing
unnecessary noise.

Replace this with:

	modprobe -n hwpoison_inject

which verifies that the module is loadable without producing output,
keeping the selftest logs clean and consistent.

Also, ensure that skipped tests do not override a previously recorded
failure. A skipped test currently sets exitcode to ksft_skip even if a
prior test has failed, which can mask failures in the final exit status.
Update the logic to only set exitcode to ksft_skip when no failure has
been recorded.

Fixes: ff4ef2fbd101 ("selftests/mm: add memory failure anonymous page test")
Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
---
 tools/testing/selftests/mm/run_vmtests.sh | 52 ++++++++++++++---------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index afdcfd0d7cef..17c9bd910c47 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -235,6 +235,7 @@ pretty_name() {
 run_test() {
 	if test_selected ${CATEGORY}; then
 		local skip=0
+		local LOADED_MOD=0
 
 		# On memory constrainted systems some tests can fail to allocate hugepages.
 		# perform some cleanup before the test for a higher success rate.
@@ -250,6 +251,28 @@ run_test() {
 			fi
 		fi
 
+		# Ensure hwpoison_inject is available for memory-failure tests
+		if [ "${CATEGORY}" = "memory-failure" ]; then
+			# Try to load hwpoison_inject if not present.
+			HWPOISON_DIR=/sys/kernel/debug/hwpoison/
+			if [ ! -d "$HWPOISON_DIR" ]; then
+				if ! modprobe -n hwpoison_inject > /dev/null 2>&1; then
+					echo "Module hwpoison_inject not found, skipping..." \
+						| tap_prefix
+					skip=1
+				else
+					modprobe hwpoison_inject > /dev/null 2>&1
+					LOADED_MOD=1
+					if [ ! -d "$HWPOISON_DIR" ]; then
+						echo "hwpoison debugfs interface not present" \
+							| tap_prefix
+						skip=1
+					fi
+				fi
+			fi
+
+		fi
+
 		local test=$(pretty_name "$*")
 		local title="running $*"
 		local sep=$(echo -n "$title" | tr "[:graph:][:space:]" -)
@@ -261,6 +284,12 @@ run_test() {
 		else
 			local ret=$ksft_skip
 		fi
+
+		# Unload hwpoison_inject if we loaded it
+		if [ -n "${LOADED_MOD}" ]; then
+			modprobe -r hwpoison_inject > /dev/null 2>&1
+		fi
+
 		count_total=$(( count_total + 1 ))
 		if [ $ret -eq 0 ]; then
 			count_pass=$(( count_pass + 1 ))
@@ -270,7 +299,9 @@ run_test() {
 			count_skip=$(( count_skip + 1 ))
 			echo "[SKIP]" | tap_prefix
 			echo "ok ${count_total} ${test} # SKIP" | tap_output
-			exitcode=$ksft_skip
+			if [ $exitcode -eq 0 ]; then
+				exitcode=$ksft_skip
+			fi
 		else
 			count_fail=$(( count_fail + 1 ))
 			echo "[FAIL]" | tap_prefix
@@ -529,24 +560,7 @@ CATEGORY="page_frag" run_test ./test_page_frag.sh nonaligned
 
 CATEGORY="rmap" run_test ./rmap
 
-# Try to load hwpoison_inject if not present.
-HWPOISON_DIR=/sys/kernel/debug/hwpoison/
-if [ ! -d "$HWPOISON_DIR" ]; then
-	if ! modprobe -q -R hwpoison_inject; then
-		echo "Module hwpoison_inject not found, skipping..."
-	else
-		modprobe hwpoison_inject > /dev/null 2>&1
-		LOADED_MOD=1
-	fi
-fi
-
-if [ -d "$HWPOISON_DIR" ]; then
-	CATEGORY="memory-failure" run_test ./memory-failure
-fi
-
-if [ -n "${LOADED_MOD}" ]; then
-	modprobe -r hwpoison_inject > /dev/null 2>&1
-fi
+CATEGORY="memory-failure" run_test ./memory-failure
 
 if [ "${HAVE_HUGEPAGES}" = 1 ]; then
 	echo "$orig_nr_hugepgs" > /proc/sys/vm/nr_hugepages
-- 
2.52.0


