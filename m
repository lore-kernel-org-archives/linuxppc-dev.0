Return-Path: <linuxppc-dev+bounces-19741-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF2CED7B84
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Apr 2026 08:24:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvy3K24SPz3bfV;
	Tue, 14 Apr 2026 18:23:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776155021;
	cv=none; b=lb2fph16VS1TFO8/mpLfR5kwt712OsUf1ItsMHotz1rV1YpVjoC23vqVpEzCdFJ4p1R06fe7598jkkxOJgSHUz8KkOJPGNe3rVHK4/2Sqj8I8hulldv+Tqr6vJWy4u0/8k4u2DCb7oLEg0/gMU54SSPypbqOg29xfHcPczZaqCmnMyJrp1gwxBf+5Em2pf12Wo9kFPpLcpGU24APOF1s0BVR0s8hDEQ+HCRIfWD1Vl28exm1PIz2qFEs+aybgNet0AFGLQi8/5U1ZDg47KtL74OJ7iPof4gYPCdgrTbZAxA2r90wv5J1w/7MYzQ5utzcQn//8iZ00HqGIPfSsovT4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776155021; c=relaxed/relaxed;
	bh=iCumWvX/ac3jXvh4F1ZXlL3cuNPYnkwd3hOEkAJPAF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cFOBfPgDTi/VlVAajHpcvLEJhDRhkoAt59X/uRk25k7GPRTq6hYB2ZWTLaNv2f6nCDyF+Q+ytuWtugbng3Qc2dB0dYslflmUAZLyjViurQBr6erpjXHowphjfH8yvAvCDDferxHRLNtrgqjYMpHlmMTVAdfErctPCYzN28TUGvHLzGztSQxnOjWE9H76bzCqaZlK3b4m4/r+VrOX5zMOhTGUe6jyph4gmpM6xDyVo9kPDQhLm/DlNGvcSFcvihqhUNzsCKIgCNp7ikOMi7YVtg1c91QQPbc1rlDi2k0hH/XNv124RpRkQsNahvgwY0wrrF6AI2XaaB6H8RDs2DDKOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Vkd/bYnE; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Vkd/bYnE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvy3J4mmQz2yvL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2026 18:23:40 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DLJ8NK1834698;
	Tue, 14 Apr 2026 08:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=iCumWvX/ac3jXvh4F
	1ZXlL3cuNPYnkwd3hOEkAJPAF4=; b=Vkd/bYnEdECk+Adr7PcmWYAGy5r5K1pf0
	IsbG2Mi9CoUgzMAmfoeWt6Xz2hhtYf18tyvbvM+hDrEQemhaq9QfiuO9AQXjxVdb
	gaD2tYNUc3SJj7coddjO+ldhZhgOvcuBhfs+ZQBYoZohDh+my2M5O9R0FlwTOzuh
	n6hs/q7dHbp2iirLqThnKtGhgsi22CYeacXSDBGAIaH5ghjb6F5nxS+UukQhVZjx
	chdgK8F2UUqjVyNuvA1EJrf7qeydakva1SGVZZqAMFyRN2YVYVZh+owriVmd85jV
	ccAYLZtMtmZYhF4vvcvuGzu1DGt8so4qq8CM4JoJKNOCmSZpBHgMQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89r9sfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 08:23:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63E4suMx004179;
	Tue, 14 Apr 2026 08:23:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg24k8ht3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 08:23:21 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63E8NHfM15794638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 08:23:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98CD920043;
	Tue, 14 Apr 2026 08:23:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A5E62004D;
	Tue, 14 Apr 2026 08:23:13 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.ibm.com.com (unknown [9.39.26.223])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Apr 2026 08:23:13 +0000 (GMT)
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
Subject: [PATCH v5 13/14] selftests/mm: move hwpoison setup into run_test() and silence modprobe output for memory-failure category
Date: Tue, 14 Apr 2026 13:52:07 +0530
Message-ID: <ec5a0e5e98c4fe55b8571c408ca891bd02208cc3.1776150071.git.sayalip@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1776150071.git.sayalip@linux.ibm.com>
References: <cover.1776150071.git.sayalip@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA3NyBTYWx0ZWRfX5ABL9MhlKMiS
 IZ8T3OISac/cfvyB7e0yO7isf51Eji0Pu0DIsl3b+KrS3nT6D+r2G9StCY/2arzCcQMoKZ1X90N
 GqVORKHJVmoZ+RkDkavyeOmm19NxAGoT08P23f922NDqwlUv3ytMha4Bu6t8lzZKvGLeNDjMm/V
 gWaexN5sz3ccXbSEP7RFh4o2Md/WbhvvOCVtYxB81ywgIUB9jXInJvxkaLMmRK9ezEZxAVcKGuH
 uz2Bhh381vCrpq3Iofc3Zyx4uCkx7EMpiPWhrULiTYJIFroJnPWa9LdQjv43dOSI2xP9pS24HXx
 Z4fPGAIXbXUNtlUxk+U7jdU8sFXTNMWH84YqdzvUSzZxF9TUuJzg8Hsl5wb/0sdpiTeuA7Ink+l
 EN8RmuTHodJJq5qb+h5/bVpSl5d2j/hdc74EI1h9eV+xqkA/FcBrhj/SPFaJ2o4DVRSneFNY0kr
 XRXDzUvv4m4M/pJQCGQ==
X-Proofpoint-ORIG-GUID: uFrQIKN5WM9lAcwSJUA3irW3UnP4U4wF
X-Proofpoint-GUID: 8w_gV9ei4Z6ZlLW6S7AyAzvbHThjrPju
X-Authority-Analysis: v=2.4 cv=fYidDUQF c=1 sm=1 tr=0 ts=69ddf97b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=Ikd4Dj_1AAAA:8 a=VnNF1IyMAAAA:8
 a=w_JUWIshtjp1QPcyv1YA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140077

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
Reviewed-by: Zi Yan <ziy@nvidia.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
---
 tools/testing/selftests/mm/run_vmtests.sh | 52 ++++++++++++++---------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index afdcfd0d7cef..62dcfbb9887b 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -235,6 +235,7 @@ pretty_name() {
 run_test() {
 	if test_selected ${CATEGORY}; then
 		local skip=0
+		local LOADED_HWPOISON_INJECT_MOD=0
 
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
+					LOADED_HWPOISON_INJECT_MOD=1
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
+		if [ -n "${LOADED_HWPOISON_INJECT_MOD}" ]; then
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


